Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22B7203E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgFVRdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 13:33:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730114AbgFVRc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:32:57 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C293EF80ACF35D700EFE;
        Tue, 23 Jun 2020 01:32:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 23 Jun 2020 01:32:43 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <trivial@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <maz@kernel.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in arm_smmu_cmdq_issue_cmdlist()
Date:   Tue, 23 Jun 2020 01:28:40 +0800
Message-ID: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been shown that the cmpxchg() for finding space in the cmdq can
be a bottleneck:
- for more CPUs contending the cmdq, the cmpxchg() will fail more often
- since the software-maintained cons pointer is updated on the same 64b
  memory region, the chance of cmpxchg() failure increases again

The cmpxchg() is removed as part of 2 related changes:

- Update prod and cmdq owner in a single atomic add operation. For this, we
  count the prod and owner in separate regions in prod memory.

  As with simple binary counting, once the prod+wrap fields overflow, they
  will zero. They should never overflow into "owner" region, and we zero
  the non-owner, prod region for each owner. This maintains the prod
  pointer.

  As for the "owner", we now count this value, instead of setting a flag.
  Similar to before, once the owner has finished gathering, it will clear
  a mask. As such, a CPU declares itself as the "owner" when it reads zero
  for this region. This zeroing will also clear possible overflow in
  wrap+prod region, above.

  The owner is now responsible for all cmdq locking to avoid possible
  deadlock. The owner will lock the cmdq for all non-owers it has gathered
  when they have space in the queue and have written their entries.

- Check for space in the cmdq after the prod pointer has been assigned.

  We don't bother checking for space in the cmdq before assigning the prod
  pointer, as this would be racy.

  So since the prod pointer is updated unconditionally, it would be common
  for no space to be available in the cmdq when prod is assigned - that
  is, according the software-maintained prod and cons pointer. So now
  it must be ensured that the entries are not yet written and not until
  there is space.

  How the prod pointer is maintained also leads to a strange condition
  where the prod pointer can wrap past the cons pointer. We can detect this
  condition, and report no space here. However, a prod pointer progressed
  twice past the cons pointer cannot be detected. But it can be ensured that
  this that this scenario does not occur, as we limit the amount of
  commands any CPU can issue at any given time, such that we cannot
  progress prod pointer further.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 101 ++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 45a39ccaf455..54d056f10bea 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -772,10 +772,19 @@ static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
 	prod = Q_IDX(q, q->prod);
 	cons = Q_IDX(q, q->cons);
 
-	if (Q_WRP(q, q->prod) == Q_WRP(q, q->cons))
+	if (Q_WRP(q, q->prod) == Q_WRP(q, q->cons)) {
+		/* check if we have wrapped, meaning definitely no space */
+		if (cons > prod)
+			return false;
+
 		space = (1 << q->max_n_shift) - (prod - cons);
-	else
+	} else {
+		/* similar check to above */
+		if (prod > cons)
+			return false;
+
 		space = cons - prod;
+	}
 
 	return space >= n;
 }
@@ -1073,7 +1082,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
  *   fails if the caller appears to be the last lock holder (yes, this is
  *   racy). All successful UNLOCK routines have RELEASE semantics.
  */
-static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq)
+static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq, int count)
 {
 	int val;
 
@@ -1083,12 +1092,12 @@ static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq)
 	 * to INT_MIN so these increments won't hurt as the value will remain
 	 * negative.
 	 */
-	if (atomic_fetch_inc_relaxed(&cmdq->lock) >= 0)
+	if (atomic_fetch_add_relaxed(count, &cmdq->lock) >= 0)
 		return;
 
 	do {
 		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);
-	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1) != val);
+	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + count) != val);
 }
 
 static void arm_smmu_cmdq_shared_unlock(struct arm_smmu_cmdq *cmdq)
@@ -1374,8 +1383,10 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
  *   insert their own list of commands then all of the commands from one
  *   CPU will appear before any of the commands from the other CPU.
  *
- * - A CMD_SYNC is always inserted, ensuring that any CPU does not issue
- *   more than the permitted amount commands at once.
+ * - A CMD_SYNC is always inserted, which ensures we limit the prod pointer
+ *   for when the cmdq is full, such that we don't wrap more than twice.
+ *   It also makes it easy for the owner to know by how many to increment the
+ *   cmdq lock.
  */
 static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				       u64 *cmds, int n)
@@ -1388,39 +1399,38 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	struct arm_smmu_ll_queue llq = {
 		.max_n_shift = cmdq->q.llq.max_n_shift,
-	}, head = llq;
+	}, head = llq, space = llq;
+	u32 owner_val = 1 << cmdq->q.llq.owner_count_shift;
+	u32 prod_mask = GENMASK(cmdq->q.llq.max_n_shift, 0);
+	u32 owner_mask = GENMASK(30, cmdq->q.llq.owner_count_shift);
 	int ret = 0;
 
 	/* 1. Allocate some space in the queue */
 	local_irq_save(flags);
-	llq.val = READ_ONCE(cmdq->q.llq.val);
-	do {
-		u64 old;
 
-		while (!queue_has_space(&llq, n + sync)) {
-			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
-				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
-			local_irq_save(flags);
-		}
+	prod = atomic_fetch_add(n + sync + owner_val,
+				&cmdq->q.llq.atomic.prod);
 
-		head.cons = llq.cons;
-		head.prod = queue_inc_prod_n(&llq, n + sync) |
-					     CMDQ_PROD_OWNED_FLAG;
+	owner = !(prod & owner_mask);
+	llq.prod = prod_mask & prod;
+	head.prod = queue_inc_prod_n(&llq, n + sync);
 
-		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
-		if (old == llq.val)
-			break;
+	/*
+	 * Ensure it's safe to write the entries. For this, we need to ensure
+	 * that there is space in the queue from our prod pointer.
+	 */
+	space.cons = READ_ONCE(cmdq->q.llq.cons);
+	space.prod = llq.prod;
+	while (!queue_has_space(&space, n + sync)) {
+		if (arm_smmu_cmdq_poll_until_not_full(smmu, &space))
+			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 
-		llq.val = old;
-	} while (1);
-	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
-	head.prod &= ~CMDQ_PROD_OWNED_FLAG;
-	llq.prod &= ~CMDQ_PROD_OWNED_FLAG;
+		space.prod = llq.prod;
+	}
 
 	/*
 	 * 2. Write our commands into the queue
-	 * Dependency ordering from the cmpxchg() loop above.
+	 * Dependency ordering from the space-checking while loop, above.
 	 */
 	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
 
@@ -1428,26 +1438,24 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
 	queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
 
-	/*
-	 * In order to determine completion of our CMD_SYNC, we must ensure
-	 * that the queue can't wrap twice without us noticing. We achieve that
-	 * by taking the cmdq lock as shared before marking our slot as valid.
-	 */
-	arm_smmu_cmdq_shared_lock(cmdq);
-
 	/* 3. Mark our slots as valid, ensuring commands are visible first */
 	dma_wmb();
 	arm_smmu_cmdq_set_valid_map(cmdq, llq.prod, head.prod);
 
 	/* 4. If we are the owner, take control of the SMMU hardware */
 	if (owner) {
+		int owner_count;
+		u32 prod_tmp;
+
 		/* a. Wait for previous owner to finish */
 		atomic_cond_read_relaxed(&cmdq->owner_prod, VAL == llq.prod);
 
-		/* b. Stop gathering work by clearing the owned flag */
-		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
-						   &cmdq->q.llq.atomic.prod);
-		prod &= ~CMDQ_PROD_OWNED_FLAG;
+		/* b. Stop gathering work by clearing the owned mask */
+		prod_tmp = atomic_fetch_andnot_relaxed(~prod_mask,
+						       &cmdq->q.llq.atomic.prod);
+		prod = prod_tmp & prod_mask;
+		owner_count = prod_tmp & owner_mask;
+		owner_count >>= cmdq->q.llq.owner_count_shift;
 
 		/*
 		 * c. Wait for any gathered work to be written to the queue.
@@ -1456,6 +1464,19 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		 */
 		arm_smmu_cmdq_poll_valid_map(cmdq, llq.prod, prod);
 
+		/*
+		 * In order to determine completion of the CMD_SYNCs, we must
+		 * ensure that the queue can't wrap twice without us noticing.
+		 * We achieve that by taking the cmdq lock as shared before
+		 * progressing the prod pointer.
+		 * The owner does this for all the non-owners it has gathered.
+		 * Otherwise, some non-owner(s) may lock the cmdq, blocking
+		 * cons being updating. This could be when the cmdq has just
+		 * become full. In this case, other sibling non-owners could be
+		 * blocked from progressing, leading to deadlock.
+		 */
+		arm_smmu_cmdq_shared_lock(cmdq, owner_count);
+
 		/*
 		 * d. Advance the hardware prod pointer
 		 * Control dependency ordering from the entries becoming valid.
-- 
2.26.2

