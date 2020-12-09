Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5AF2D460D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbgLIPzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:55:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9409 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbgLIPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:55:00 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CrhRV3m7fz7BpC;
        Wed,  9 Dec 2020 23:53:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Dec 2020 23:54:06 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/3] iova: Delete copy_reserved_iova()
Date:   Wed, 9 Dec 2020 23:50:18 +0800
Message-ID: <1607529019-229549-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607529019-229549-1-git-send-email-john.garry@huawei.com>
References: <1607529019-229549-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the
iommu ops"), function copy_reserved_iova() is not referenced, so delete
it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 30 ------------------------------
 include/linux/iova.h |  6 ------
 2 files changed, 36 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0a758ec2a1c4..04f0a3ae1c63 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -710,36 +710,6 @@ reserve_iova(struct iova_domain *iovad,
 }
 EXPORT_SYMBOL_GPL(reserve_iova);
 
-/**
- * copy_reserved_iova - copies the reserved between domains
- * @from: - source doamin from where to copy
- * @to: - destination domin where to copy
- * This function copies reserved iova's from one doamin to
- * other.
- */
-void
-copy_reserved_iova(struct iova_domain *from, struct iova_domain *to)
-{
-	unsigned long flags;
-	struct rb_node *node;
-
-	spin_lock_irqsave(&from->iova_rbtree_lock, flags);
-	for (node = rb_first(&from->rbroot); node; node = rb_next(node)) {
-		struct iova *iova = rb_entry(node, struct iova, node);
-		struct iova *new_iova;
-
-		if (iova->pfn_lo == IOVA_ANCHOR)
-			continue;
-
-		new_iova = reserve_iova(to, iova->pfn_lo, iova->pfn_hi);
-		if (!new_iova)
-			pr_err("Reserve iova range %lx@%lx failed\n",
-			       iova->pfn_lo, iova->pfn_lo);
-	}
-	spin_unlock_irqrestore(&from->iova_rbtree_lock, flags);
-}
-EXPORT_SYMBOL_GPL(copy_reserved_iova);
-
 /*
  * Magazine caches for IOVA ranges.  For an introduction to magazines,
  * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 2b76e0be1c5b..c834c01c0a5b 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -150,7 +150,6 @@ unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 			      unsigned long limit_pfn, bool flush_rcache);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
-void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
 int init_iova_flush_queue(struct iova_domain *iovad,
@@ -211,11 +210,6 @@ static inline struct iova *reserve_iova(struct iova_domain *iovad,
 	return NULL;
 }
 
-static inline void copy_reserved_iova(struct iova_domain *from,
-				      struct iova_domain *to)
-{
-}
-
 static inline void init_iova_domain(struct iova_domain *iovad,
 				    unsigned long granule,
 				    unsigned long start_pfn)
-- 
2.26.2

