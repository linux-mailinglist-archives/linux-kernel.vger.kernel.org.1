Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0699267782
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 05:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgILD2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 23:28:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:27603 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgILD2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 23:28:12 -0400
IronPort-SDR: e7z6eFFADg0i22NfKvMuUknWvBMWHc8XDDXuzfFLoza1q4mdUXplDCwvt3Pn2jHloK2c+T5PNP
 z924vzfCIJqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="223074013"
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; 
   d="scan'208";a="223074013"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 20:28:10 -0700
IronPort-SDR: MLP+qubHQ7map2lRR6fdhSC+d75aYD/pItgFsOZRc9gAAgGvn0ZcmzIMQ82RhXuKKeQJuRlKX1
 S58LYso1fOAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; 
   d="scan'208";a="408321406"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2020 20:28:08 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 3/6] iommu: Allow the dma-iommu api to use bounce buffers
Date:   Sat, 12 Sep 2020 11:21:57 +0800
Message-Id: <20200912032200.11489-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200912032200.11489-1-baolu.lu@linux.intel.com>
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Murphy <murphyt7@tcd.ie>

Allow the dma-iommu api to use bounce buffers for untrusted devices.
This is a copy of the intel bounce buffer code.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 163 +++++++++++++++++++++++++++++++++++---
 1 file changed, 150 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d06411bd5e08..1a1da22e5a5e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -21,9 +21,11 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/swiotlb.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
+#include <linux/dma-direct.h>
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -498,6 +500,31 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
 }
 
+static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	phys_addr_t phys;
+
+	phys = iommu_iova_to_phys(domain, dma_addr);
+	if (WARN_ON(!phys))
+		return;
+
+	__iommu_dma_unmap(dev, dma_addr, size);
+
+	if (unlikely(is_swiotlb_buffer(phys)))
+		swiotlb_tbl_unmap_single(dev, phys, size,
+				iova_align(iovad, size), dir, attrs);
+}
+
+static bool dev_is_untrusted(struct device *dev)
+{
+	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+}
+
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size_t size, int prot, u64 dma_mask)
 {
@@ -523,6 +550,55 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	return iova + iova_off;
 }
 
+static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
+		size_t org_size, dma_addr_t dma_mask, bool coherent,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	int prot = dma_info_to_prot(dir, coherent, attrs);
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	size_t aligned_size = org_size;
+	void *padding_start;
+	size_t padding_size;
+	dma_addr_t iova;
+
+	/*
+	 * If both the physical buffer start address and size are
+	 * page aligned, we don't need to use a bounce page.
+	 */
+	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
+	    iova_offset(iovad, phys | org_size)) {
+		aligned_size = iova_align(iovad, org_size);
+		phys = swiotlb_tbl_map_single(dev,
+				__phys_to_dma(dev, io_tlb_start),
+				phys, org_size, aligned_size, dir, attrs);
+
+		if (phys == DMA_MAPPING_ERROR)
+			return DMA_MAPPING_ERROR;
+
+		/* Cleanup the padding area. */
+		padding_start = phys_to_virt(phys);
+		padding_size = aligned_size;
+
+		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		    (dir == DMA_TO_DEVICE ||
+		     dir == DMA_BIDIRECTIONAL)) {
+			padding_start += org_size;
+			padding_size -= org_size;
+		}
+
+		memset(padding_start, 0, padding_size);
+	}
+
+	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
+	if ((iova == DMA_MAPPING_ERROR) && is_swiotlb_buffer(phys))
+		swiotlb_tbl_unmap_single(dev, phys, org_size,
+				aligned_size, dir, attrs);
+
+	return iova;
+}
+
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -698,11 +774,15 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev))
+	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	arch_sync_dma_for_cpu(phys, size, dir);
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_for_cpu(phys, size, dir);
+
+	if (is_swiotlb_buffer(phys))
+		swiotlb_tbl_sync_single(dev, phys, size, dir, SYNC_FOR_CPU);
 }
 
 static void iommu_dma_sync_single_for_device(struct device *dev,
@@ -710,11 +790,15 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev))
+	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	arch_sync_dma_for_device(phys, size, dir);
+	if (is_swiotlb_buffer(phys))
+		swiotlb_tbl_sync_single(dev, phys, size, dir, SYNC_FOR_DEVICE);
+
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_for_device(phys, size, dir);
 }
 
 static void iommu_dma_sync_sg_for_cpu(struct device *dev,
@@ -724,11 +808,17 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev))
+	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i)
-		arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
+	for_each_sg(sgl, sg, nelems, i) {
+		if (!dev_is_dma_coherent(dev))
+			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
+
+		if (is_swiotlb_buffer(sg_phys(sg)))
+			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length,
+						dir, SYNC_FOR_CPU);
+	}
 }
 
 static void iommu_dma_sync_sg_for_device(struct device *dev,
@@ -738,11 +828,17 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev))
+	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i)
-		arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
+	for_each_sg(sgl, sg, nelems, i) {
+		if (is_swiotlb_buffer(sg_phys(sg)))
+			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length,
+						dir, SYNC_FOR_DEVICE);
+
+		if (!dev_is_dma_coherent(dev))
+			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
+	}
 }
 
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
@@ -751,10 +847,10 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
-	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dma_handle;
 
-	dma_handle = __iommu_dma_map(dev, phys, size, prot, dma_get_mask(dev));
+	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
+			coherent, dir, attrs);
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
 		arch_sync_dma_for_device(phys, size, dir);
@@ -766,7 +862,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
-	__iommu_dma_unmap(dev, dma_handle, size);
+	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
 /*
@@ -844,6 +940,39 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 	}
 }
 
+static void iommu_dma_unmap_sg_swiotlb(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i)
+		__iommu_dma_unmap_swiotlb(dev, sg_dma_address(s),
+				sg_dma_len(s), dir, attrs);
+}
+
+static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i) {
+		sg_dma_address(s) = __iommu_dma_map_swiotlb(dev, sg_phys(s),
+				s->length, dma_get_mask(dev),
+				dev_is_dma_coherent(dev), dir, attrs);
+		if (sg_dma_address(s) == DMA_MAPPING_ERROR)
+			goto out_unmap;
+		sg_dma_len(s) = s->length;
+	}
+
+	return nents;
+
+out_unmap:
+	iommu_dma_unmap_sg_swiotlb(dev, sg, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
+	return 0;
+}
+
 /*
  * The DMA API client is passing in a scatterlist which could describe
  * any old buffer layout, but the IOMMU API requires everything to be
@@ -870,6 +999,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
 
+	if (dev_is_untrusted(dev))
+		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
+
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
 	 * IOVA granules for the IOMMU driver to handle. With some clever
@@ -939,6 +1071,11 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
 
+	if (dev_is_untrusted(dev)) {
+		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
+		return;
+	}
+
 	/*
 	 * The scatterlist segments are mapped into a single
 	 * contiguous IOVA allocation, so this is incredibly easy.
-- 
2.17.1

