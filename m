Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4321A2CDDE1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbgLCSjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:39:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8243 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbgLCSjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:39:54 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cn4NW41DczkkwX;
        Fri,  4 Dec 2020 02:38:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 02:39:01 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <0x7f454c46@gmail.com>,
        <robin.murphy@arm.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH 1/3] iommu: Delete split_and_remove_iova()
Date:   Fri, 4 Dec 2020 02:34:50 +0800
Message-ID: <1607020492-189471-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607020492-189471-1-git-send-email-john.garry@huawei.com>
References: <1607020492-189471-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function split_and_remove_iova() has not been referenced since commit
e70b081c6f37 ("iommu/vt-d: Remove IOVA handling code from the non-dma_ops
path"), so delete it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 41 -----------------------------------------
 include/linux/iova.h | 10 ----------
 2 files changed, 51 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index ea04a88c673d..4803bd83447d 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -738,47 +738,6 @@ copy_reserved_iova(struct iova_domain *from, struct iova_domain *to)
 }
 EXPORT_SYMBOL_GPL(copy_reserved_iova);
 
-struct iova *
-split_and_remove_iova(struct iova_domain *iovad, struct iova *iova,
-		      unsigned long pfn_lo, unsigned long pfn_hi)
-{
-	unsigned long flags;
-	struct iova *prev = NULL, *next = NULL;
-
-	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	if (iova->pfn_lo < pfn_lo) {
-		prev = alloc_and_init_iova(iova->pfn_lo, pfn_lo - 1);
-		if (prev == NULL)
-			goto error;
-	}
-	if (iova->pfn_hi > pfn_hi) {
-		next = alloc_and_init_iova(pfn_hi + 1, iova->pfn_hi);
-		if (next == NULL)
-			goto error;
-	}
-
-	__cached_rbnode_delete_update(iovad, iova);
-	rb_erase(&iova->node, &iovad->rbroot);
-
-	if (prev) {
-		iova_insert_rbtree(&iovad->rbroot, prev, NULL);
-		iova->pfn_lo = pfn_lo;
-	}
-	if (next) {
-		iova_insert_rbtree(&iovad->rbroot, next, NULL);
-		iova->pfn_hi = pfn_hi;
-	}
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-
-	return iova;
-
-error:
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-	if (prev)
-		free_iova_mem(prev);
-	return NULL;
-}
-
 /*
  * Magazine caches for IOVA ranges.  For an introduction to magazines,
  * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
diff --git a/include/linux/iova.h b/include/linux/iova.h
index a0637abffee8..a77add571c50 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -160,8 +160,6 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
-struct iova *split_and_remove_iova(struct iova_domain *iovad,
-	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
 void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 #else
 static inline int iova_cache_get(void)
@@ -258,14 +256,6 @@ static inline void put_iova_domain(struct iova_domain *iovad)
 {
 }
 
-static inline struct iova *split_and_remove_iova(struct iova_domain *iovad,
-						 struct iova *iova,
-						 unsigned long pfn_lo,
-						 unsigned long pfn_hi)
-{
-	return NULL;
-}
-
 static inline void free_cpu_cached_iovas(unsigned int cpu,
 					 struct iova_domain *iovad)
 {
-- 
2.26.2

