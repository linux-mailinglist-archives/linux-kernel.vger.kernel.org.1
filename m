Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EDC1FB362
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 16:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgFPOEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 10:04:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6345 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728980AbgFPOEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:04:05 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AABFE974DBF50C8407E0;
        Tue, 16 Jun 2020 22:03:57 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 22:03:51 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <trivial@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <maz@kernel.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH RFC v2 3/4] iommu/arm-smmu-v3: Always issue a CMD_SYNC per batch
Date:   Tue, 16 Jun 2020 21:59:52 +0800
Message-ID: <1592315993-164290-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1592315993-164290-1-git-send-email-john.garry@huawei.com>
References: <1592315993-164290-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure that a CPU does not send more than a permitted amount of commands
to the cmdq, ensure that each batch includes a CMD_SYNC. When issuing a
CMD_SYNC, we always wait for the consumption of its batch of commands - as
such, we guarantee that any CPU will not issue more than its permitted
amount.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 87 +++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c3562dc35d45..36648163364c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1373,11 +1373,15 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
  * - Command insertion is totally ordered, so if two CPUs each race to
  *   insert their own list of commands then all of the commands from one
  *   CPU will appear before any of the commands from the other CPU.
+ *
+ * - A CMD_SYNC is always inserted, ensuring that any CPU does not issue
+ *   more than the permitted amount commands at once.
  */
 static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
-				       u64 *cmds, int n, bool sync)
+				       u64 *cmds, int n)
 {
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
+	const int sync = 1;
 	u32 prod;
 	unsigned long flags;
 	bool owner;
@@ -1419,19 +1423,18 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	 * Dependency ordering from the cmpxchg() loop above.
 	 */
 	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
-	if (sync) {
-		prod = queue_inc_prod_n(&llq, n);
-		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
-		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
 
-		/*
-		 * In order to determine completion of our CMD_SYNC, we must
-		 * ensure that the queue can't wrap twice without us noticing.
-		 * We achieve that by taking the cmdq lock as shared before
-		 * marking our slot as valid.
-		 */
-		arm_smmu_cmdq_shared_lock(cmdq);
-	}
+	prod = queue_inc_prod_n(&llq, n);
+	arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
+	queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
+
+	/*
+	 * In order to determine completion of our CMD_SYNC, we must
+	 * ensure that the queue can't wrap twice without us noticing.
+	 * We achieve that by taking the cmdq lock as shared before
+	 * marking our slot as valid.
+	 */
+	arm_smmu_cmdq_shared_lock(cmdq);
 
 	/* 3. Mark our slots as valid, ensuring commands are visible first */
 	dma_wmb();
@@ -1468,26 +1471,22 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		atomic_set_release(&cmdq->owner_prod, prod);
 	}
 
-	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
-	if (sync) {
-		llq.prod = queue_inc_prod_n(&llq, n);
-		ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
-		if (ret) {
-			dev_err_ratelimited(smmu->dev,
-					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
-					    llq.prod,
-					    readl_relaxed(cmdq->q.prod_reg),
-					    readl_relaxed(cmdq->q.cons_reg));
-		}
+	/* 5. Since we always insert a CMD_SYNC, we must wait for it to complete */
+	llq.prod = queue_inc_prod_n(&llq, n);
+	ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
+	if (ret) {
+		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
+				    llq.prod, readl_relaxed(cmdq->q.prod_reg),
+				    readl_relaxed(cmdq->q.cons_reg));
+	}
 
-		/*
-		 * Try to unlock the cmdq lock. This will fail if we're the last
-		 * reader, in which case we can safely update cmdq->q.llq.cons
-		 */
-		if (!arm_smmu_cmdq_shared_tryunlock(cmdq)) {
-			WRITE_ONCE(cmdq->q.llq.cons, llq.cons);
-			arm_smmu_cmdq_shared_unlock(cmdq);
-		}
+	/*
+	 * Try to unlock the cmdq lock. This will fail if we're the last reader,
+	 * in which case we can safely update cmdq->q.llq.cons
+	 */
+	if (!arm_smmu_cmdq_shared_tryunlock(cmdq)) {
+		WRITE_ONCE(cmdq->q.llq.cons, llq.cons);
+		arm_smmu_cmdq_shared_unlock(cmdq);
 	}
 
 	local_irq_restore(flags);
@@ -1505,12 +1504,7 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 		return -EINVAL;
 	}
 
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, false);
-}
-
-static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
-{
-	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1);
 }
 
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
@@ -1521,7 +1515,7 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 	struct arm_smmu_ll_queue *llq = &q->q.llq;
 
 	if (cmds->num == llq->max_cmd_per_batch) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num);
 		cmds->num = 0;
 	}
 	arm_smmu_cmdq_build_cmd(&cmds->cmds[cmds->num * CMDQ_ENT_DWORDS], cmd);
@@ -1531,7 +1525,7 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 				      struct arm_smmu_cmdq_batch *cmds)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num);
 }
 
 /* Context descriptor manipulation functions */
@@ -1803,7 +1797,6 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	};
 
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
 }
 
 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
@@ -2197,17 +2190,20 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 
 static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 {
-	int i;
+	int i, ret = 0;
 	struct arm_smmu_cmdq_ent cmd;
 
 	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
 
 	for (i = 0; i < master->num_sids; i++) {
+		int rc;
+
 		cmd.atc.sid = master->sids[i];
-		arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
+		rc = arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
+		ret = ret ? :  rc;
 	}
 
-	return arm_smmu_cmdq_issue_sync(master->smmu);
+	return ret;
 }
 
 static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
@@ -2280,7 +2276,6 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * careful, 007.
 	 */
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
 }
 
@@ -3650,7 +3645,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	/* Invalidate any cached configuration */
 	cmd.opcode = CMDQ_OP_CFGI_ALL;
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
 
 	/* Invalidate any stale TLB entries */
 	if (smmu->features & ARM_SMMU_FEAT_HYP) {
@@ -3660,7 +3654,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 	cmd.opcode = CMDQ_OP_TLBI_NSNH_ALL;
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
 
 	/* Event queue */
 	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-- 
2.26.2

