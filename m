Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C279B2D0FD8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgLGL7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:59:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8719 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLGL7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:59:00 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CqMHz0MXpzklsJ;
        Mon,  7 Dec 2020 19:57:35 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 19:58:06 +0800
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
Subject: [PATCH v2] iommu: Defer the early return in arm_(v7s/lpae)_map
Date:   Mon, 7 Dec 2020 19:57:58 +0800
Message-ID: <20201207115758.9400-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although handling a mapping request with no permissions is a
trivial no-op, defer the early return until after the size/range
checks so that we are consistent with other mapping requests.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 8 ++++----
 drivers/iommu/io-pgtable-arm.c     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index a688f22cbe3b..359b96b0fa3e 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -522,14 +522,14 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
 	struct io_pgtable *iop = &data->iop;
 	int ret;
 
-	/* If no access, then nothing to do */
-	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
-		return 0;
-
 	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
 		    paddr >= (1ULL << data->iop.cfg.oas)))
 		return -ERANGE;
 
+	/* If no access, then nothing to do */
+	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
+		return 0;
+
 	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd, gfp);
 	/*
 	 * Synchronise all PTE updates for the new mapping before there's
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

