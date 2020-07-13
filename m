Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40676218B48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 17:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgGHPcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 11:32:51 -0400
Received: from casper.infradead.org ([90.155.50.34]:37204 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbgGHPcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uUUl6/91E4RjY3y2FdTQuf9fNwe4LcxCQPXQPlAagng=; b=go2tyef7UxkXhGCQbSKvJqNsbe
        CRtr5l8AYmmj9HSsm/+Z1YL23NBX+28KMlqyywl+GfX9Zaey5kTW48Sss42mbVvEN7MTuAxZBBMIa
        ODrozsDOkltatkBKy4OmTR4afejuF8cVEnqql3NlvRi2cl8yvm7hJRWT9OJth0VJPFSjp+DEcjOvY
        voSlEB3WO50FHBqG9dAXFB8pdoMxwY8doXNlmtbi3PUEoeqzH0AomqVLaUoYRHzFpSmBv0yvV4t+C
        Ka/8ElDNDVNcJqHxWpnOPGksVN8Y5LQ+SncoR3fe8uyrSlUZD2nPuI+Q+iNbzBefg4+BOlaSqqrfG
        WoJEoq3A==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtC3J-0002LJ-Ol; Wed, 08 Jul 2020 15:32:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dma-mapping: inline the fast path dma-direct calls
Date:   Wed,  8 Jul 2020 17:24:46 +0200
Message-Id: <20200708152449.316476-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708152449.316476-1-hch@lst.de>
References: <20200708152449.316476-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inline the single page map/unmap/sync dma-direct calls into the now
out of line generic wrappers.  This restores the behavior of a single
function call that we had before moving the generic calls out of line.
Besides the dma-mapping callers there are just a few callers in IOMMU
drivers that have a bypass mode, and more of those are going to be
switched to the generic bypass soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h | 92 ++++++++++++++++++++++++++++----------
 kernel/dma/direct.c        | 65 ---------------------------
 2 files changed, 69 insertions(+), 88 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 78dc3524adf880..dbb19dd9869054 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -1,10 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Internals of the DMA direct mapping implementation.  Only for use by the
+ * DMA mapping code and IOMMU drivers.
+ */
 #ifndef _LINUX_DMA_DIRECT_H
 #define _LINUX_DMA_DIRECT_H 1
 
 #include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/memblock.h> /* for min_low_pfn */
 #include <linux/mem_encrypt.h>
+#include <linux/swiotlb.h>
 
 extern unsigned int zone_dma_bits;
 
@@ -86,25 +92,17 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 		unsigned long attrs);
 int dma_direct_supported(struct device *dev, u64 mask);
 bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
-dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
+size_t dma_direct_max_mapping_size(struct device *dev);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_SWIOTLB)
-void dma_direct_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir);
-void dma_direct_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
+void dma_direct_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir);
 #else
-static inline void dma_direct_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
-{
-}
 static inline void dma_direct_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
@@ -114,34 +112,82 @@ static inline void dma_direct_sync_sg_for_device(struct device *dev,
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
     defined(CONFIG_SWIOTLB)
-void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
-void dma_direct_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir);
 void dma_direct_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
 #else
-static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-}
 static inline void dma_direct_unmap_sg(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir,
 		unsigned long attrs)
 {
 }
+static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+}
+#endif
+
+static inline void dma_direct_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	phys_addr_t paddr = dma_to_phys(dev, addr);
+
+	if (unlikely(is_swiotlb_buffer(paddr)))
+		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
+
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_for_device(paddr, size, dir);
+}
+
 static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 		dma_addr_t addr, size_t size, enum dma_data_direction dir)
 {
+	phys_addr_t paddr = dma_to_phys(dev, addr);
+
+	if (!dev_is_dma_coherent(dev)) {
+		arch_sync_dma_for_cpu(paddr, size, dir);
+		arch_sync_dma_for_cpu_all();
+	}
+
+	if (unlikely(is_swiotlb_buffer(paddr)))
+		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
 }
-static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+
+static inline dma_addr_t dma_direct_map_page(struct device *dev,
+		struct page *page, unsigned long offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
 {
+	phys_addr_t phys = page_to_phys(page) + offset;
+	dma_addr_t dma_addr = phys_to_dma(dev, phys);
+
+	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
+		return swiotlb_map(dev, phys, size, dir, attrs);
+
+	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
+		if (swiotlb_force != SWIOTLB_NO_FORCE)
+			return swiotlb_map(dev, phys, size, dir, attrs);
+
+		dev_WARN_ONCE(dev, 1,
+			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
+			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
+		return DMA_MAPPING_ERROR;
+	}
+
+	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(phys, size, dir);
+	return dma_addr;
 }
-#endif
 
-size_t dma_direct_max_mapping_size(struct device *dev);
+static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	phys_addr_t phys = dma_to_phys(dev, addr);
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+
+	if (unlikely(is_swiotlb_buffer(phys)))
+		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
+}
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 6d1975c4a26873..3078e36941e6d4 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -10,11 +10,9 @@
 #include <linux/dma-direct.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-contiguous.h>
-#include <linux/dma-noncoherent.h>
 #include <linux/pfn.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
-#include <linux/swiotlb.h>
 
 /*
  * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use it
@@ -304,18 +302,6 @@ void dma_direct_free(struct device *dev, size_t size,
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_SWIOTLB)
-void dma_direct_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
-{
-	phys_addr_t paddr = dma_to_phys(dev, addr);
-
-	if (unlikely(is_swiotlb_buffer(paddr)))
-		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
-
-	if (!dev_is_dma_coherent(dev))
-		arch_sync_dma_for_device(paddr, size, dir);
-}
-
 void dma_direct_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
@@ -339,20 +325,6 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
     defined(CONFIG_SWIOTLB)
-void dma_direct_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
-{
-	phys_addr_t paddr = dma_to_phys(dev, addr);
-
-	if (!dev_is_dma_coherent(dev)) {
-		arch_sync_dma_for_cpu(paddr, size, dir);
-		arch_sync_dma_for_cpu_all();
-	}
-
-	if (unlikely(is_swiotlb_buffer(paddr)))
-		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
-}
-
 void dma_direct_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
@@ -374,18 +346,6 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu_all();
 }
 
-void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	phys_addr_t phys = dma_to_phys(dev, addr);
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
-
-	if (unlikely(is_swiotlb_buffer(phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
-}
-
 void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
@@ -398,31 +358,6 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 }
 #endif
 
-dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	phys_addr_t phys = page_to_phys(page) + offset;
-	dma_addr_t dma_addr = phys_to_dma(dev, phys);
-
-	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
-		return swiotlb_map(dev, phys, size, dir, attrs);
-
-	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
-		if (swiotlb_force != SWIOTLB_NO_FORCE)
-			return swiotlb_map(dev, phys, size, dir, attrs);
-
-		dev_WARN_ONCE(dev, 1,
-			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
-			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
-		return DMA_MAPPING_ERROR;
-	}
-
-	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arch_sync_dma_for_device(phys, size, dir);
-	return dma_addr;
-}
-
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-- 
2.26.2

