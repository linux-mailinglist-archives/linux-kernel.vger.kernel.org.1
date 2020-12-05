Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008392CFAA3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 09:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgLEIdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 03:33:31 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8667 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgLEIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 03:31:51 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cp2nd3m6Mz15XHm;
        Sat,  5 Dec 2020 16:30:13 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 5 Dec 2020 16:30:32 +0800
From:   Keqian Zhu <zhukeqian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>
CC:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH] iommu: Up front sanity check in the arm_lpae_map
Date:   Sat, 5 Dec 2020 16:29:57 +0800
Message-ID: <20201205082957.12544-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... then we have more chance to detect wrong code logic.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index a7a9bc08dcd1..8ade72adab31 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -444,10 +444,6 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	arm_lpae_iopte prot;
 	long iaext = (s64)iova >> cfg->ias;
 
-	/* If no access, then nothing to do */
-	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
-		return 0;
-
 	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
 		return -EINVAL;
 
@@ -456,6 +452,10 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(iaext || paddr >> cfg->oas))
 		return -ERANGE;
 
+	/* If no access, then nothing to do */
+	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
+		return 0;
+
 	prot = arm_lpae_prot_to_pte(data, iommu_prot);
 	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep, gfp);
 	/*
-- 
2.23.0

