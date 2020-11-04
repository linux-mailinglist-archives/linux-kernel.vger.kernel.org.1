Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9992A5D39
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgKDDzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:55:36 -0500
Received: from ozlabs.ru ([107.174.27.60]:42026 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgKDDzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:55:35 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 463BCAE80275;
        Wed, 28 Oct 2020 02:59:54 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH kernel v3 1/2] dma: Allow mixing bypass and mapped DMA operation
Date:   Wed, 28 Oct 2020 18:00:29 +1100
Message-Id: <20201028070030.60643-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028070030.60643-1-aik@ozlabs.ru>
References: <20201028070030.60643-1-aik@ozlabs.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment we allow bypassing DMA ops only when we can do this for
the entire RAM. However there are configs with mixed type memory
where we could still allow bypassing IOMMU in most cases;
POWERPC with persistent memory is one example.

This adds an arch hook to determine where bypass can still work and
we invoke direct DMA API. The following patch checks the bus limit
on POWERPC to allow or disallow direct mapping.

This adds a CONFIG_ARCH_HAS_DMA_SET_MASK config option to make arch_xxxx
hooks no-op by default.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 kernel/dma/mapping.c | 24 ++++++++++++++++++++----
 kernel/dma/Kconfig   |  4 ++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 51bb8fa8eb89..a0bc9eb876ed 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -137,6 +137,18 @@ static inline bool dma_map_direct(struct device *dev,
 	return dma_go_direct(dev, *dev->dma_mask, ops);
 }
 
+#ifdef CONFIG_ARCH_HAS_DMA_MAP_DIRECT
+bool arch_dma_map_page_direct(struct device *dev, phys_addr_t addr);
+bool arch_dma_unmap_page_direct(struct device *dev, dma_addr_t dma_handle);
+bool arch_dma_map_sg_direct(struct device *dev, struct scatterlist *sg, int nents);
+bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg, int nents);
+#else
+#define arch_dma_map_page_direct(d, a) (0)
+#define arch_dma_unmap_page_direct(d, a) (0)
+#define arch_dma_map_sg_direct(d, s, n) (0)
+#define arch_dma_unmap_sg_direct(d, s, n) (0)
+#endif
+
 dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		size_t offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
@@ -149,7 +161,8 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 	if (WARN_ON_ONCE(!dev->dma_mask))
 		return DMA_MAPPING_ERROR;
 
-	if (dma_map_direct(dev, ops))
+	if (dma_map_direct(dev, ops) ||
+	    arch_dma_map_page_direct(dev, page_to_phys(page) + offset + size))
 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
@@ -165,7 +178,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (dma_map_direct(dev, ops))
+	if (dma_map_direct(dev, ops) ||
+	    arch_dma_unmap_page_direct(dev, addr + size))
 		dma_direct_unmap_page(dev, addr, size, dir, attrs);
 	else if (ops->unmap_page)
 		ops->unmap_page(dev, addr, size, dir, attrs);
@@ -188,7 +202,8 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 	if (WARN_ON_ONCE(!dev->dma_mask))
 		return 0;
 
-	if (dma_map_direct(dev, ops))
+	if (dma_map_direct(dev, ops) ||
+	    arch_dma_map_sg_direct(dev, sg, nents))
 		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
 	else
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
@@ -207,7 +222,8 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 	BUG_ON(!valid_dma_direction(dir));
 	debug_dma_unmap_sg(dev, sg, nents, dir);
-	if (dma_map_direct(dev, ops))
+	if (dma_map_direct(dev, ops) ||
+	    arch_dma_unmap_sg_direct(dev, sg, nents))
 		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
 	else if (ops->unmap_sg)
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c99de4a21458..43d106598e82 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -20,6 +20,10 @@ config DMA_OPS
 config DMA_OPS_BYPASS
 	bool
 
+# Lets platform IOMMU driver choose between bypass and IOMMU
+config ARCH_HAS_DMA_MAP_DIRECT
+	bool
+
 config NEED_SG_DMA_LENGTH
 	bool
 
-- 
2.17.1

