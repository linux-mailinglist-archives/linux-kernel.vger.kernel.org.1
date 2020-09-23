Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D20D275AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgIWOuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:50:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2914 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbgIWOuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:50:11 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E82B372EE1393A03E283;
        Wed, 23 Sep 2020 15:50:09 +0100 (IST)
Received: from [127.0.0.1] (10.47.2.162) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 23 Sep
 2020 15:50:09 +0100
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: Improve cmdq lock efficiency
To:     Will Deacon <will@kernel.org>
CC:     <maz@kernel.org>, <joro@8bytes.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>
References: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
 <20200921134324.GK2139@willie-the-truck>
 <b13d0858-e164-4670-a5c6-ab84e81724b7@huawei.com>
Message-ID: <37734fe9-8b67-3cf3-2925-2fee549cb45a@huawei.com>
Date:   Wed, 23 Sep 2020 15:47:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <b13d0858-e164-4670-a5c6-ab84e81724b7@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.162]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2020 14:58, John Garry wrote:
> 
>> Could you try to adapt the hacks I sent before,
>> please? I know they weren't quite right (I have no hardware to test 
>> on

Could the ARM Rev C FVP be used to at least functionally test? Can't 
seem to access myself, even though it's gratis...

), but
>> the basic idea is to fall back to a spinlock if the cmpxchg() fails. The
>> queueing in the spinlock implementation should avoid the contention.
> 

So I modified that suggested change to get it functioning, and it looks 
like this:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7196207be7ea..f907b7c233a2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -560,6 +560,7 @@ struct arm_smmu_cmdq {
  	atomic_long_t			*valid_map;
  	atomic_t			owner_prod;
  	atomic_t			lock;
+	spinlock_t			slock;
  };

  struct arm_smmu_cmdq_batch {
@@ -1378,7 +1379,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct 
arm_smmu_device *smmu,
  	u64 cmd_sync[CMDQ_ENT_DWORDS];
  	u32 prod;
  	unsigned long flags;
-	bool owner;
+	bool owner, locked = false;
  	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
  	struct arm_smmu_ll_queue llq = {
  		.max_n_shift = cmdq->q.llq.max_n_shift,
@@ -1387,26 +1388,42 @@ static int arm_smmu_cmdq_issue_cmdlist(struct 
arm_smmu_device *smmu,

  	/* 1. Allocate some space in the queue */
  	local_irq_save(flags);
-	llq.val = READ_ONCE(cmdq->q.llq.val);
  	do {
  		u64 old;

-		while (!queue_has_space(&llq, n + sync)) {
+		llq.val = READ_ONCE(cmdq->q.llq.val);
+
+		if (queue_has_space(&llq, n + sync))
+			goto try_cas;
+
+		if (locked) {
+			spin_unlock(&cmdq->slock);
+			locked = 0; // added
+		}
+
+		do {
  			local_irq_restore(flags);
  			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
  				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
  			local_irq_save(flags);
-		}
+		} while (!queue_has_space(&llq, n + sync));

+try_cas:
  		head.cons = llq.cons;
  		head.prod = queue_inc_prod_n(&llq, n + sync) |
  					     CMDQ_PROD_OWNED_FLAG;

  		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
-		if (old == llq.val)
+		if (old == llq.val) { // was if (old != llq.val)
+			if (locked)   //           break;
+				spin_unlock(&cmdq->slock);//
  			break;//
+		}//

-		llq.val = old;
+		if (!locked) {
+			spin_lock(&cmdq->slock);
+			locked = true;
+		}
  	} while (1);
  	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
  	head.prod &= ~CMDQ_PROD_OWNED_FLAG;
@@ -3192,6 +3209,7 @@ static int arm_smmu_cmdq_init(struct 
arm_smmu_device *smmu)

  	atomic_set(&cmdq->owner_prod, 0);
  	atomic_set(&cmdq->lock, 0);
+	spin_lock_init(&cmdq->slock);

  	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
  	if (!bitmap) {
-- 
2.26.2

I annotated my mods with comments. Maybe those mods would not be as you 
intend.

So I'm not sure that we solve the problem of a new CPU coming along and 
trying the cmpxchg immediately, while another CPU has the slock and will 
try the cmpxchg also.

Anyway, the results are a bit mixed depending on the CPU count, but 
generally positive compared to mainline:

CPUs		2	4	8	16	32	64	96
v5.9-rc1	453K	409K	295K	157K	33.6K	9.5K	5.2K
Will's change	459K	414K	281K	131K	44K	15.5K	8.6K
$subject change	481K	406K	305K	190K	81K	30K	18.7K

(Unit is DMA map+unmap per CPU per second, using test harness. Higher is 
better.)

Please let me know of any way to progress.

Thanks,
John
