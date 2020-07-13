Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB736218B6D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 17:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgGHPhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 11:37:19 -0400
Received: from casper.infradead.org ([90.155.50.34]:37346 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbgGHPhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WONRmdayeVnib8Sp6DFT/rNEBQkDNkncQsl/NpzNp0k=; b=aPaRkTKR36u+fHzuZPyLOmBo8k
        LXZH5MHfJ+0hjjyE4HVtaZhzhC889r4Lshr6amjGAZXi1wCuffWCA+QsQtGJeaSuA7/5WrKDAaFfQ
        Q6cGAhFHum2OSzgf4XmQaOf6UsFGJYEhAFrdYQTWLGBt75fxgaw+DC0r8oDeSuC6heJhLjc3WPsej
        e+ROqavGMPIXyP2BDLjgKB83Z/aPqYuQTPr8zmZvKiV1x5zlHsBOaOeQiptzYy3V8jcNFV4cwY94w
        2aCaWUyOVEwbK/7//UijvoiXkjhgcs41+yG/8VsBOkKgLA0jP/EpY60DsZLlGrnNy8uLCnOlTY3Av
        pjsk09EQ==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtC7n-0002aO-Oy; Wed, 08 Jul 2020 15:36:51 +0000
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
Subject: [PATCH 4/5] dma-mapping: add a dma_ops_bypass flag to struct device
Date:   Wed,  8 Jul 2020 17:24:48 +0200
Message-Id: <20200708152449.316476-5-hch@lst.de>
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

Several IOMMU drivers have a bypass mode where they can use a direct
mapping if the devices DMA mask is large enough.  Add generic support
to the core dma-mapping code to do that to switch those drivers to
a common solution.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/device.h |  8 +++++
 kernel/dma/Kconfig     |  8 +++++
 kernel/dma/mapping.c   | 74 +++++++++++++++++++++++++++++-------------
 3 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 4c4af98321ebd6..1f71acf37f78d7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -523,6 +523,11 @@ struct dev_links_info {
  *		  sync_state() callback.
  * @dma_coherent: this particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
+ * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
+ *		streaming DMA operations (->map_* / ->unmap_* / ->sync_*),
+ *		and optionall (if the coherent mask is large enough) also
+ *		for dma allocations.  This flag is managed by the dma ops
+ *		instance from ->dma_supported.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -623,6 +628,9 @@ struct device {
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	bool			dma_coherent:1;
 #endif
+#ifdef CONFIG_DMA_OPS_BYPASS
+	bool			dma_ops_bypass : 1;
+#endif
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 5cfb2428593ac7..f4770fcfa62bb3 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -8,6 +8,14 @@ config HAS_DMA
 config DMA_OPS
 	bool
 
+#
+# IOMMU drivers that can bypass the IOMMU code and optionally use the direct
+# mapping fast path should select this option and set the dma_ops_bypass
+# flag in struct device where applicable
+#
+config DMA_OPS_BYPASS
+	bool
+
 config NEED_SG_DMA_LENGTH
 	bool
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b53953024512fe..0d129421e75fc8 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -105,9 +105,35 @@ void *dmam_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 }
 EXPORT_SYMBOL(dmam_alloc_attrs);
 
-static inline bool dma_is_direct(const struct dma_map_ops *ops)
+static bool dma_go_direct(struct device *dev, dma_addr_t mask,
+		const struct dma_map_ops *ops)
 {
-	return likely(!ops);
+	if (likely(!ops))
+		return true;
+#ifdef CONFIG_DMA_OPS_BYPASS
+	if (dev->dma_ops_bypass)
+		return min_not_zero(mask, dev->bus_dma_limit) >=
+			    dma_direct_get_required_mask(dev);
+#endif
+	return false;
+}
+
+
+/*
+ * Check if the devices uses a direct mapping for streaming DMA operations.
+ * This allows IOMMU drivers to set a bypass mode if the DMA mask is large
+ * enough.
+ */
+static inline bool dma_alloc_direct(struct device *dev,
+		const struct dma_map_ops *ops)
+{
+	return dma_go_direct(dev, dev->coherent_dma_mask, ops);
+}
+
+static inline bool dma_map_direct(struct device *dev,
+		const struct dma_map_ops *ops)
+{
+	return dma_go_direct(dev, *dev->dma_mask, ops);
 }
 
 dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
@@ -118,7 +144,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
+	if (dma_map_direct(dev, ops))
 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
@@ -134,7 +160,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
+	if (dma_map_direct(dev, ops))
 		dma_direct_unmap_page(dev, addr, size, dir, attrs);
 	else if (ops->unmap_page)
 		ops->unmap_page(dev, addr, size, dir, attrs);
@@ -153,7 +179,7 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 	int ents;
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
+	if (dma_map_direct(dev, ops))
 		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
 	else
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
@@ -172,7 +198,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 	BUG_ON(!valid_dma_direction(dir));
 	debug_dma_unmap_sg(dev, sg, nents, dir);
-	if (dma_is_direct(ops))
+	if (dma_map_direct(dev, ops))
 		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
 	else if (ops->unmap_sg)
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
@@ -191,7 +217,7 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
 		return DMA_MAPPING_ERROR;
 
-	if (dma_is_direct(ops))
+	if (dma_map_direct(dev, ops))
 		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
 	else if (ops->map_resource)
 		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
@@ -207,7 +233,7 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (!dma_is_direct(ops) && ops->unmap_resource)
+	if (!dma_map_direct(dev, ops) && ops->unmap_resource)
 		ops->unmap_resource(dev, addr, size, dir, attrs);
 	debug_dma_unmap_resource(dev, addr, size, dir);
 }
@@ -219,7 +245,7 @@ void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
+	if (dma_map_direct(dev, ops))
 		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
 	else if (ops->sync_single_for_cpu)
 		ops->sync_single_for_cpu(dev, addr, size, dir);
@@ -233,7 +259,7 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
+	if (dma_map_direct(dev, ops))
 		dma_direct_sync_single_for_device(dev, addr, size, dir);
 	else if (ops->sync_single_for_device)
 		ops->sync_single_for_device(dev, addr, size, dir);
@@ -247,7 +273,7 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
+	if (dma_map_direct(dev, ops))
 		dma_direct_sync_sg_for_cpu(dev, sg, nelems, dir);
 	else if (ops->sync_sg_for_cpu)
 		ops->sync_sg_for_cpu(dev, sg, nelems, dir);
@@ -261,7 +287,7 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
+	if (dma_map_direct(dev, ops))
 		dma_direct_sync_sg_for_device(dev, sg, nelems, dir);
 	else if (ops->sync_sg_for_device)
 		ops->sync_sg_for_device(dev, sg, nelems, dir);
@@ -302,7 +328,7 @@ int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (dma_is_direct(ops))
+	if (dma_alloc_direct(dev, ops))
 		return dma_direct_get_sgtable(dev, sgt, cpu_addr, dma_addr,
 				size, attrs);
 	if (!ops->get_sgtable)
@@ -372,7 +398,7 @@ bool dma_can_mmap(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (dma_is_direct(ops))
+	if (dma_alloc_direct(dev, ops))
 		return dma_direct_can_mmap(dev);
 	return ops->mmap != NULL;
 }
@@ -397,7 +423,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (dma_is_direct(ops))
+	if (dma_alloc_direct(dev, ops))
 		return dma_direct_mmap(dev, vma, cpu_addr, dma_addr, size,
 				attrs);
 	if (!ops->mmap)
@@ -410,7 +436,7 @@ u64 dma_get_required_mask(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (dma_is_direct(ops))
+	if (dma_alloc_direct(dev, ops))
 		return dma_direct_get_required_mask(dev);
 	if (ops->get_required_mask)
 		return ops->get_required_mask(dev);
@@ -441,7 +467,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* let the implementation decide on the zone to allocate from: */
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
-	if (dma_is_direct(ops))
+	if (dma_alloc_direct(dev, ops))
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
 	else if (ops->alloc)
 		cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
@@ -473,7 +499,7 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		return;
 
 	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
-	if (dma_is_direct(ops))
+	if (dma_alloc_direct(dev, ops))
 		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
 	else if (ops->free)
 		ops->free(dev, size, cpu_addr, dma_handle, attrs);
@@ -484,7 +510,11 @@ int dma_supported(struct device *dev, u64 mask)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (dma_is_direct(ops))
+	/*
+	 * ->dma_supported sets the bypass flag, so we must always call
+	 * into the method here unless the device is truly direct mapped.
+	 */
+	if (!ops)
 		return dma_direct_supported(dev, mask);
 	if (!ops->dma_supported)
 		return 1;
@@ -540,7 +570,7 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 
 	BUG_ON(!valid_dma_direction(dir));
 
-	if (dma_is_direct(ops))
+	if (dma_alloc_direct(dev, ops))
 		arch_dma_cache_sync(dev, vaddr, size, dir);
 	else if (ops->cache_sync)
 		ops->cache_sync(dev, vaddr, size, dir);
@@ -552,7 +582,7 @@ size_t dma_max_mapping_size(struct device *dev)
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	size_t size = SIZE_MAX;
 
-	if (dma_is_direct(ops))
+	if (dma_map_direct(dev, ops))
 		size = dma_direct_max_mapping_size(dev);
 	else if (ops && ops->max_mapping_size)
 		size = ops->max_mapping_size(dev);
@@ -565,7 +595,7 @@ bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (dma_is_direct(ops))
+	if (dma_map_direct(dev, ops))
 		return dma_direct_need_sync(dev, dma_addr);
 	return ops->sync_single_for_cpu || ops->sync_single_for_device;
 }
-- 
2.26.2

