Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED042D0FF5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgLGMDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:03:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9026 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgLGMDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:03:06 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqMNv6JCwzhntJ;
        Mon,  7 Dec 2020 20:01:51 +0800 (CST)
Received: from DESKTOP-6NKE0BC.china.huawei.com (10.174.185.137) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 20:02:15 +0800
From:   Kunkun Jiang <jiangkunkun@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Keqian Zhu <zhukeqian1@huawei.com>,
        "Zenghui Yu" <yuzenghui@huawei.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>
Subject: [PATCH RESEND] iommu/io-pgtalbe-arm: Remove "iopte_type(pte, l)" extra parameter "l"
Date:   Mon, 7 Dec 2020 20:01:50 +0800
Message-ID: <20201207120150.1891-1-jiangkunkun@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.137]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Knowing from the code, the macro "iopte_type(pte, l)" doesn't use the
parameter "l" (level). So we'd better to remove it.

Fixes: e1d3c0fd701df(iommu: add ARM LPAE page table allocator)
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index a7a9bc08dcd1..e58ba5759b80 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -130,7 +130,7 @@
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
-#define iopte_type(pte,l)					\
+#define iopte_type(pte)					\
 	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
 
 #define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
@@ -151,9 +151,9 @@ static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
 			      enum io_pgtable_fmt fmt)
 {
 	if (lvl == (ARM_LPAE_MAX_LEVELS - 1) && fmt != ARM_MALI_LPAE)
-		return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_PAGE;
+		return iopte_type(pte) == ARM_LPAE_PTE_TYPE_PAGE;
 
-	return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_BLOCK;
+	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_BLOCK;
 }
 
 static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
@@ -280,7 +280,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 		/* We require an unmap first */
 		WARN_ON(!selftest_running);
 		return -EEXIST;
-	} else if (iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
+	} else if (iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE) {
 		/*
 		 * We need to unmap and free the old table before
 		 * overwriting it with a block entry.
@@ -548,7 +548,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		 * block, but anything else is invalid. We can't misinterpret
 		 * a page entry here since we're never at the last level.
 		 */
-		if (iopte_type(pte, lvl - 1) != ARM_LPAE_PTE_TYPE_TABLE)
+		if (iopte_type(pte) != ARM_LPAE_PTE_TYPE_TABLE)
 			return 0;
 
 		tablep = iopte_deref(pte, data);
-- 
2.19.1

