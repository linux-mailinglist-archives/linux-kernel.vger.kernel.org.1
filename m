Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5962C1FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgKXI2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:28:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:63905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730457AbgKXI2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:28:34 -0500
IronPort-SDR: G0FJRTXmMhmG87Zn5ap9hhO/JhBvj/mAc0iMG3dYT1ZQzGp7HVqdAiNRrZHgHKAb5VpPnJAVb5
 VYWSz34Rl9Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171129627"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="171129627"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 00:28:33 -0800
IronPort-SDR: DyLinjAj34abO5wEsWhxzo+4/eMiQmSM1TW6Ut7XX3Lq+d0d8/IX3SevYxBY5Lsyg0mAP7V0CZ
 GO/Iw0i8fOuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="432539722"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2020 00:28:31 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH v6 3/7] iommu: Allow the dma-iommu api to use bounce buffers
Date:   Tue, 24 Nov 2020 16:20:53 +0800
Message-Id: <20201124082057.2614359-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
References: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Murphy <murphyt7@tcd.ie>

Allow the dma-iommu api to use bounce buffers for untrusted devices.
This is a copy of the intel bounce buffer code.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/dma-iommu.c | 162 +++++++++++++++++++++++++++++++++++---
 1 file changed, 149 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index de521e22bafb..83eb99bfb990 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -20,9 +20,11 @@
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
@@ -499,6 +501,31 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
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
@@ -524,6 +551,54 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
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
+		phys = swiotlb_tbl_map_single(dev, phys, org_size,
+					      aligned_size, dir, attrs);
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
@@ -697,11 +772,15 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
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
@@ -709,11 +788,15 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
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
@@ -723,11 +806,17 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
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
@@ -737,11 +826,17 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
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
@@ -750,10 +845,10 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
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
@@ -765,7 +860,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
-	__iommu_dma_unmap(dev, dma_handle, size);
+	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
 /*
@@ -843,6 +938,39 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
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
@@ -869,6 +997,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
 
+	if (dev_is_untrusted(dev))
+		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
+
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
 	 * IOVA granules for the IOMMU driver to handle. With some clever
@@ -938,6 +1069,11 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
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
2.25.1

