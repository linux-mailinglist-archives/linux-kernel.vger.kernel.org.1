Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8786E2BA764
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgKTKY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:24:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:17833 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgKTKY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:24:57 -0500
IronPort-SDR: NAFvEEefF0os1YZsgaSoEQI+7eAu/mdnalgSg86QwOoA3dVUrvVbS7/vy7JaNe3YAK3OxJRDvo
 StI902QlvqFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="150717613"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="150717613"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 02:24:56 -0800
IronPort-SDR: 8P/T6JtU1XA7l67MJL1xk+xRYiSCHOVAtGxSrMe0pxtppIVGtGbKF0bDRiCW8mNpZpvdI8U7qI
 8JirINhqNwAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="545393719"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2020 02:24:53 -0800
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
Subject: [PATCH v5 6/7] iommu/vt-d: Convert intel iommu driver to the iommu ops
Date:   Fri, 20 Nov 2020 18:17:18 +0800
Message-Id: <20201120101719.3172693-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
References: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Murphy <murphyt7@tcd.ie>

Convert the intel iommu driver to the dma-iommu api. Remove the iova
handling and reserve region code from the intel iommu driver.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/intel/Kconfig |   1 +
 drivers/iommu/intel/iommu.c | 746 ++----------------------------------
 2 files changed, 43 insertions(+), 704 deletions(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 5337ee1584b0..28a3d1596c76 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -13,6 +13,7 @@ config INTEL_IOMMU
 	select DMAR_TABLE
 	select SWIOTLB
 	select IOASID
+	select IOMMU_DMA
 	help
 	  DMA remapping (DMAR) devices support enables independent address
 	  translations for Direct Memory Access (DMA) from devices.
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 80a7e4e1781b..7b36b48b9887 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -31,6 +31,7 @@
 #include <linux/io.h>
 #include <linux/iova.h>
 #include <linux/iommu.h>
+#include <linux/dma-iommu.h>
 #include <linux/intel-iommu.h>
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
@@ -41,7 +42,6 @@
 #include <linux/dma-direct.h>
 #include <linux/crash_dump.h>
 #include <linux/numa.h>
-#include <linux/swiotlb.h>
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -382,9 +382,6 @@ struct device_domain_info *get_domain_info(struct device *dev)
 DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
-#define device_needs_bounce(d) (!intel_no_bounce && dev_is_pci(d) &&	\
-				to_pci_dev(d)->untrusted)
-
 /*
  * Iterate over elements in device_domain_list and call the specified
  * callback @fn against each element.
@@ -1289,13 +1286,6 @@ static void dma_free_pagelist(struct page *freelist)
 	}
 }
 
-static void iova_entry_free(unsigned long data)
-{
-	struct page *freelist = (struct page *)data;
-
-	dma_free_pagelist(freelist);
-}
-
 /* iommu handling */
 static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 {
@@ -1660,19 +1650,17 @@ static inline void __mapping_notify_one(struct intel_iommu *iommu,
 		iommu_flush_write_buffer(iommu);
 }
 
-static void iommu_flush_iova(struct iova_domain *iovad)
+static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
-	struct dmar_domain *domain;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	int idx;
 
-	domain = container_of(iovad, struct dmar_domain, iovad);
-
-	for_each_domain_iommu(idx, domain) {
+	for_each_domain_iommu(idx, dmar_domain) {
 		struct intel_iommu *iommu = g_iommus[idx];
-		u16 did = domain->iommu_did[iommu->seq_id];
+		u16 did = dmar_domain->iommu_did[iommu->seq_id];
 
-		if (domain_use_first_level(domain))
-			domain_flush_piotlb(iommu, domain, 0, -1, 0);
+		if (domain_use_first_level(dmar_domain))
+			domain_flush_piotlb(iommu, dmar_domain, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
@@ -1954,48 +1942,6 @@ static int domain_detach_iommu(struct dmar_domain *domain,
 	return count;
 }
 
-static struct iova_domain reserved_iova_list;
-static struct lock_class_key reserved_rbtree_key;
-
-static int dmar_init_reserved_ranges(void)
-{
-	struct pci_dev *pdev = NULL;
-	struct iova *iova;
-	int i;
-
-	init_iova_domain(&reserved_iova_list, VTD_PAGE_SIZE, IOVA_START_PFN);
-
-	lockdep_set_class(&reserved_iova_list.iova_rbtree_lock,
-		&reserved_rbtree_key);
-
-	/* IOAPIC ranges shouldn't be accessed by DMA */
-	iova = reserve_iova(&reserved_iova_list, IOVA_PFN(IOAPIC_RANGE_START),
-		IOVA_PFN(IOAPIC_RANGE_END));
-	if (!iova) {
-		pr_err("Reserve IOAPIC range failed\n");
-		return -ENODEV;
-	}
-
-	/* Reserve all PCI MMIO to avoid peer-to-peer access */
-	for_each_pci_dev(pdev) {
-		struct resource *r;
-
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			r = &pdev->resource[i];
-			if (!r->flags || !(r->flags & IORESOURCE_MEM))
-				continue;
-			iova = reserve_iova(&reserved_iova_list,
-					    IOVA_PFN(r->start),
-					    IOVA_PFN(r->end));
-			if (!iova) {
-				pci_err(pdev, "Reserve iova for %pR failed\n", r);
-				return -ENODEV;
-			}
-		}
-	}
-	return 0;
-}
-
 static inline int guestwidth_to_adjustwidth(int gaw)
 {
 	int agaw;
@@ -2018,7 +1964,7 @@ static void domain_exit(struct dmar_domain *domain)
 
 	/* destroy iovas */
 	if (domain->domain.type == IOMMU_DOMAIN_DMA)
-		put_iova_domain(&domain->iovad);
+		iommu_put_dma_cookie(&domain->domain);
 
 	if (domain->pgd) {
 		struct page *freelist;
@@ -2552,16 +2498,6 @@ struct dmar_domain *find_domain(struct device *dev)
 	return NULL;
 }
 
-static void do_deferred_attach(struct device *dev)
-{
-	struct iommu_domain *domain;
-
-	dev_iommu_priv_set(dev, NULL);
-	domain = iommu_get_domain_for_dev(dev);
-	if (domain)
-		intel_iommu_attach_device(domain, dev);
-}
-
 static inline struct device_domain_info *
 dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
 {
@@ -3434,595 +3370,6 @@ static int __init init_dmars(void)
 	return ret;
 }
 
-/* This takes a number of _MM_ pages, not VTD pages */
-static unsigned long intel_alloc_iova(struct device *dev,
-				     struct dmar_domain *domain,
-				     unsigned long nrpages, uint64_t dma_mask)
-{
-	unsigned long iova_pfn;
-
-	/*
-	 * Restrict dma_mask to the width that the iommu can handle.
-	 * First-level translation restricts the input-address to a
-	 * canonical address (i.e., address bits 63:N have the same
-	 * value as address bit [N-1], where N is 48-bits with 4-level
-	 * paging and 57-bits with 5-level paging). Hence, skip bit
-	 * [N-1].
-	 */
-	if (domain_use_first_level(domain))
-		dma_mask = min_t(uint64_t, DOMAIN_MAX_ADDR(domain->gaw - 1),
-				 dma_mask);
-	else
-		dma_mask = min_t(uint64_t, DOMAIN_MAX_ADDR(domain->gaw),
-				 dma_mask);
-
-	/* Ensure we reserve the whole size-aligned region */
-	nrpages = __roundup_pow_of_two(nrpages);
-
-	if (!dmar_forcedac && dma_mask > DMA_BIT_MASK(32)) {
-		/*
-		 * First try to allocate an io virtual address in
-		 * DMA_BIT_MASK(32) and if that fails then try allocating
-		 * from higher range
-		 */
-		iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
-					   IOVA_PFN(DMA_BIT_MASK(32)), false);
-		if (iova_pfn)
-			return iova_pfn;
-	}
-	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
-				   IOVA_PFN(dma_mask), true);
-	if (unlikely(!iova_pfn)) {
-		dev_err_once(dev, "Allocating %ld-page iova failed\n",
-			     nrpages);
-		return 0;
-	}
-
-	return iova_pfn;
-}
-
-static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
-				     size_t size, int dir, u64 dma_mask)
-{
-	struct dmar_domain *domain;
-	phys_addr_t start_paddr;
-	unsigned long iova_pfn;
-	int prot = 0;
-	int ret;
-	struct intel_iommu *iommu;
-	unsigned long paddr_pfn = paddr >> PAGE_SHIFT;
-
-	BUG_ON(dir == DMA_NONE);
-
-	if (unlikely(attach_deferred(dev)))
-		do_deferred_attach(dev);
-
-	domain = find_domain(dev);
-	if (!domain)
-		return DMA_MAPPING_ERROR;
-
-	iommu = domain_get_iommu(domain);
-	size = aligned_nrpages(paddr, size);
-
-	iova_pfn = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size), dma_mask);
-	if (!iova_pfn)
-		goto error;
-
-	/*
-	 * Check if DMAR supports zero-length reads on write only
-	 * mappings..
-	 */
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL || \
-			!cap_zlr(iommu->cap))
-		prot |= DMA_PTE_READ;
-	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-		prot |= DMA_PTE_WRITE;
-	/*
-	 * paddr - (paddr + size) might be partial page, we should map the whole
-	 * page.  Note: if two part of one page are separately mapped, we
-	 * might have two guest_addr mapping to the same host paddr, but this
-	 * is not a big problem
-	 */
-	ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova_pfn),
-				 mm_to_dma_pfn(paddr_pfn), size, prot);
-	if (ret)
-		goto error;
-
-	start_paddr = (phys_addr_t)iova_pfn << PAGE_SHIFT;
-	start_paddr += paddr & ~PAGE_MASK;
-
-	trace_map_single(dev, start_paddr, paddr, size << VTD_PAGE_SHIFT);
-
-	return start_paddr;
-
-error:
-	if (iova_pfn)
-		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
-	dev_err(dev, "Device request: %zx@%llx dir %d --- failed\n",
-		size, (unsigned long long)paddr, dir);
-	return DMA_MAPPING_ERROR;
-}
-
-static dma_addr_t intel_map_page(struct device *dev, struct page *page,
-				 unsigned long offset, size_t size,
-				 enum dma_data_direction dir,
-				 unsigned long attrs)
-{
-	return __intel_map_single(dev, page_to_phys(page) + offset,
-				  size, dir, *dev->dma_mask);
-}
-
-static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
-				     size_t size, enum dma_data_direction dir,
-				     unsigned long attrs)
-{
-	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
-}
-
-static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
-{
-	struct dmar_domain *domain;
-	unsigned long start_pfn, last_pfn;
-	unsigned long nrpages;
-	unsigned long iova_pfn;
-	struct intel_iommu *iommu;
-	struct page *freelist;
-	struct pci_dev *pdev = NULL;
-
-	domain = find_domain(dev);
-	BUG_ON(!domain);
-
-	iommu = domain_get_iommu(domain);
-
-	iova_pfn = IOVA_PFN(dev_addr);
-
-	nrpages = aligned_nrpages(dev_addr, size);
-	start_pfn = mm_to_dma_pfn(iova_pfn);
-	last_pfn = start_pfn + nrpages - 1;
-
-	if (dev_is_pci(dev))
-		pdev = to_pci_dev(dev);
-
-	freelist = domain_unmap(domain, start_pfn, last_pfn, NULL);
-	if (intel_iommu_strict || (pdev && pdev->untrusted) ||
-			!has_iova_flush_queue(&domain->iovad)) {
-		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
-				      nrpages, !freelist, 0);
-		/* free iova */
-		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(nrpages));
-		dma_free_pagelist(freelist);
-	} else {
-		queue_iova(&domain->iovad, iova_pfn, nrpages,
-			   (unsigned long)freelist);
-		/*
-		 * queue up the release of the unmap to save the 1/6th of the
-		 * cpu used up by the iotlb flush operation...
-		 */
-	}
-
-	trace_unmap_single(dev, dev_addr, size);
-}
-
-static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
-			     size_t size, enum dma_data_direction dir,
-			     unsigned long attrs)
-{
-	intel_unmap(dev, dev_addr, size);
-}
-
-static void intel_unmap_resource(struct device *dev, dma_addr_t dev_addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	intel_unmap(dev, dev_addr, size);
-}
-
-static void *intel_alloc_coherent(struct device *dev, size_t size,
-				  dma_addr_t *dma_handle, gfp_t flags,
-				  unsigned long attrs)
-{
-	struct page *page = NULL;
-	int order;
-
-	if (unlikely(attach_deferred(dev)))
-		do_deferred_attach(dev);
-
-	size = PAGE_ALIGN(size);
-	order = get_order(size);
-
-	if (gfpflags_allow_blocking(flags)) {
-		unsigned int count = size >> PAGE_SHIFT;
-
-		page = dma_alloc_from_contiguous(dev, count, order,
-						 flags & __GFP_NOWARN);
-	}
-
-	if (!page)
-		page = alloc_pages(flags, order);
-	if (!page)
-		return NULL;
-	memset(page_address(page), 0, size);
-
-	*dma_handle = __intel_map_single(dev, page_to_phys(page), size,
-					 DMA_BIDIRECTIONAL,
-					 dev->coherent_dma_mask);
-	if (*dma_handle != DMA_MAPPING_ERROR)
-		return page_address(page);
-	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-		__free_pages(page, order);
-
-	return NULL;
-}
-
-static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
-				dma_addr_t dma_handle, unsigned long attrs)
-{
-	int order;
-	struct page *page = virt_to_page(vaddr);
-
-	size = PAGE_ALIGN(size);
-	order = get_order(size);
-
-	intel_unmap(dev, dma_handle, size);
-	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-		__free_pages(page, order);
-}
-
-static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
-			   int nelems, enum dma_data_direction dir,
-			   unsigned long attrs)
-{
-	dma_addr_t startaddr = sg_dma_address(sglist) & PAGE_MASK;
-	unsigned long nrpages = 0;
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sglist, sg, nelems, i) {
-		nrpages += aligned_nrpages(sg_dma_address(sg), sg_dma_len(sg));
-	}
-
-	intel_unmap(dev, startaddr, nrpages << VTD_PAGE_SHIFT);
-
-	trace_unmap_sg(dev, startaddr, nrpages << VTD_PAGE_SHIFT);
-}
-
-static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nelems,
-			enum dma_data_direction dir, unsigned long attrs)
-{
-	int i;
-	struct dmar_domain *domain;
-	size_t size = 0;
-	int prot = 0;
-	unsigned long iova_pfn;
-	int ret;
-	struct scatterlist *sg;
-	unsigned long start_vpfn;
-	struct intel_iommu *iommu;
-
-	BUG_ON(dir == DMA_NONE);
-
-	if (unlikely(attach_deferred(dev)))
-		do_deferred_attach(dev);
-
-	domain = find_domain(dev);
-	if (!domain)
-		return 0;
-
-	iommu = domain_get_iommu(domain);
-
-	for_each_sg(sglist, sg, nelems, i)
-		size += aligned_nrpages(sg->offset, sg->length);
-
-	iova_pfn = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size),
-				*dev->dma_mask);
-	if (!iova_pfn) {
-		sglist->dma_length = 0;
-		return 0;
-	}
-
-	/*
-	 * Check if DMAR supports zero-length reads on write only
-	 * mappings..
-	 */
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL || \
-			!cap_zlr(iommu->cap))
-		prot |= DMA_PTE_READ;
-	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-		prot |= DMA_PTE_WRITE;
-
-	start_vpfn = mm_to_dma_pfn(iova_pfn);
-
-	ret = domain_sg_mapping(domain, start_vpfn, sglist, size, prot);
-	if (unlikely(ret)) {
-		dma_pte_free_pagetable(domain, start_vpfn,
-				       start_vpfn + size - 1,
-				       agaw_to_level(domain->agaw) + 1);
-		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
-		return 0;
-	}
-
-	for_each_sg(sglist, sg, nelems, i)
-		trace_map_sg(dev, i + 1, nelems, sg);
-
-	return nelems;
-}
-
-static u64 intel_get_required_mask(struct device *dev)
-{
-	return DMA_BIT_MASK(32);
-}
-
-static const struct dma_map_ops intel_dma_ops = {
-	.alloc = intel_alloc_coherent,
-	.free = intel_free_coherent,
-	.map_sg = intel_map_sg,
-	.unmap_sg = intel_unmap_sg,
-	.map_page = intel_map_page,
-	.unmap_page = intel_unmap_page,
-	.map_resource = intel_map_resource,
-	.unmap_resource = intel_unmap_resource,
-	.dma_supported = dma_direct_supported,
-	.mmap = dma_common_mmap,
-	.get_sgtable = dma_common_get_sgtable,
-	.alloc_pages = dma_common_alloc_pages,
-	.free_pages = dma_common_free_pages,
-	.get_required_mask = intel_get_required_mask,
-};
-
-static void
-bounce_sync_single(struct device *dev, dma_addr_t addr, size_t size,
-		   enum dma_data_direction dir, enum dma_sync_target target)
-{
-	struct dmar_domain *domain;
-	phys_addr_t tlb_addr;
-
-	domain = find_domain(dev);
-	if (WARN_ON(!domain))
-		return;
-
-	tlb_addr = intel_iommu_iova_to_phys(&domain->domain, addr);
-	if (is_swiotlb_buffer(tlb_addr))
-		swiotlb_tbl_sync_single(dev, tlb_addr, size, dir, target);
-}
-
-static dma_addr_t
-bounce_map_single(struct device *dev, phys_addr_t paddr, size_t size,
-		  enum dma_data_direction dir, unsigned long attrs,
-		  u64 dma_mask)
-{
-	size_t aligned_size = ALIGN(size, VTD_PAGE_SIZE);
-	struct dmar_domain *domain;
-	struct intel_iommu *iommu;
-	unsigned long iova_pfn;
-	unsigned long nrpages;
-	phys_addr_t tlb_addr;
-	int prot = 0;
-	int ret;
-
-	if (unlikely(attach_deferred(dev)))
-		do_deferred_attach(dev);
-
-	domain = find_domain(dev);
-
-	if (WARN_ON(dir == DMA_NONE || !domain))
-		return DMA_MAPPING_ERROR;
-
-	iommu = domain_get_iommu(domain);
-	if (WARN_ON(!iommu))
-		return DMA_MAPPING_ERROR;
-
-	nrpages = aligned_nrpages(0, size);
-	iova_pfn = intel_alloc_iova(dev, domain,
-				    dma_to_mm_pfn(nrpages), dma_mask);
-	if (!iova_pfn)
-		return DMA_MAPPING_ERROR;
-
-	/*
-	 * Check if DMAR supports zero-length reads on write only
-	 * mappings..
-	 */
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL ||
-			!cap_zlr(iommu->cap))
-		prot |= DMA_PTE_READ;
-	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-		prot |= DMA_PTE_WRITE;
-
-	/*
-	 * If both the physical buffer start address and size are
-	 * page aligned, we don't need to use a bounce page.
-	 */
-	if (!IS_ALIGNED(paddr | size, VTD_PAGE_SIZE)) {
-		tlb_addr = swiotlb_tbl_map_single(dev,
-				phys_to_dma_unencrypted(dev, io_tlb_start),
-				paddr, size, aligned_size, dir, attrs);
-		if (tlb_addr == DMA_MAPPING_ERROR) {
-			goto swiotlb_error;
-		} else {
-			/* Cleanup the padding area. */
-			void *padding_start = phys_to_virt(tlb_addr);
-			size_t padding_size = aligned_size;
-
-			if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-			    (dir == DMA_TO_DEVICE ||
-			     dir == DMA_BIDIRECTIONAL)) {
-				padding_start += size;
-				padding_size -= size;
-			}
-
-			memset(padding_start, 0, padding_size);
-		}
-	} else {
-		tlb_addr = paddr;
-	}
-
-	ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova_pfn),
-				 tlb_addr >> VTD_PAGE_SHIFT, nrpages, prot);
-	if (ret)
-		goto mapping_error;
-
-	trace_bounce_map_single(dev, iova_pfn << PAGE_SHIFT, paddr, size);
-
-	return (phys_addr_t)iova_pfn << PAGE_SHIFT;
-
-mapping_error:
-	if (is_swiotlb_buffer(tlb_addr))
-		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
-					 aligned_size, dir, attrs);
-swiotlb_error:
-	free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(nrpages));
-	dev_err(dev, "Device bounce map: %zx@%llx dir %d --- failed\n",
-		size, (unsigned long long)paddr, dir);
-
-	return DMA_MAPPING_ERROR;
-}
-
-static void
-bounce_unmap_single(struct device *dev, dma_addr_t dev_addr, size_t size,
-		    enum dma_data_direction dir, unsigned long attrs)
-{
-	size_t aligned_size = ALIGN(size, VTD_PAGE_SIZE);
-	struct dmar_domain *domain;
-	phys_addr_t tlb_addr;
-
-	domain = find_domain(dev);
-	if (WARN_ON(!domain))
-		return;
-
-	tlb_addr = intel_iommu_iova_to_phys(&domain->domain, dev_addr);
-	if (WARN_ON(!tlb_addr))
-		return;
-
-	intel_unmap(dev, dev_addr, size);
-	if (is_swiotlb_buffer(tlb_addr))
-		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
-					 aligned_size, dir, attrs);
-
-	trace_bounce_unmap_single(dev, dev_addr, size);
-}
-
-static dma_addr_t
-bounce_map_page(struct device *dev, struct page *page, unsigned long offset,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	return bounce_map_single(dev, page_to_phys(page) + offset,
-				 size, dir, attrs, *dev->dma_mask);
-}
-
-static dma_addr_t
-bounce_map_resource(struct device *dev, phys_addr_t phys_addr, size_t size,
-		    enum dma_data_direction dir, unsigned long attrs)
-{
-	return bounce_map_single(dev, phys_addr, size,
-				 dir, attrs, *dev->dma_mask);
-}
-
-static void
-bounce_unmap_page(struct device *dev, dma_addr_t dev_addr, size_t size,
-		  enum dma_data_direction dir, unsigned long attrs)
-{
-	bounce_unmap_single(dev, dev_addr, size, dir, attrs);
-}
-
-static void
-bounce_unmap_resource(struct device *dev, dma_addr_t dev_addr, size_t size,
-		      enum dma_data_direction dir, unsigned long attrs)
-{
-	bounce_unmap_single(dev, dev_addr, size, dir, attrs);
-}
-
-static void
-bounce_unmap_sg(struct device *dev, struct scatterlist *sglist, int nelems,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sglist, sg, nelems, i)
-		bounce_unmap_page(dev, sg->dma_address,
-				  sg_dma_len(sg), dir, attrs);
-}
-
-static int
-bounce_map_sg(struct device *dev, struct scatterlist *sglist, int nelems,
-	      enum dma_data_direction dir, unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nelems, i) {
-		sg->dma_address = bounce_map_page(dev, sg_page(sg),
-						  sg->offset, sg->length,
-						  dir, attrs);
-		if (sg->dma_address == DMA_MAPPING_ERROR)
-			goto out_unmap;
-		sg_dma_len(sg) = sg->length;
-	}
-
-	for_each_sg(sglist, sg, nelems, i)
-		trace_bounce_map_sg(dev, i + 1, nelems, sg);
-
-	return nelems;
-
-out_unmap:
-	bounce_unmap_sg(dev, sglist, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
-	return 0;
-}
-
-static void
-bounce_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
-			   size_t size, enum dma_data_direction dir)
-{
-	bounce_sync_single(dev, addr, size, dir, SYNC_FOR_CPU);
-}
-
-static void
-bounce_sync_single_for_device(struct device *dev, dma_addr_t addr,
-			      size_t size, enum dma_data_direction dir)
-{
-	bounce_sync_single(dev, addr, size, dir, SYNC_FOR_DEVICE);
-}
-
-static void
-bounce_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist,
-		       int nelems, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sglist, sg, nelems, i)
-		bounce_sync_single(dev, sg_dma_address(sg),
-				   sg_dma_len(sg), dir, SYNC_FOR_CPU);
-}
-
-static void
-bounce_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
-			  int nelems, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sglist, sg, nelems, i)
-		bounce_sync_single(dev, sg_dma_address(sg),
-				   sg_dma_len(sg), dir, SYNC_FOR_DEVICE);
-}
-
-static const struct dma_map_ops bounce_dma_ops = {
-	.alloc			= intel_alloc_coherent,
-	.free			= intel_free_coherent,
-	.map_sg			= bounce_map_sg,
-	.unmap_sg		= bounce_unmap_sg,
-	.map_page		= bounce_map_page,
-	.unmap_page		= bounce_unmap_page,
-	.sync_single_for_cpu	= bounce_sync_single_for_cpu,
-	.sync_single_for_device	= bounce_sync_single_for_device,
-	.sync_sg_for_cpu	= bounce_sync_sg_for_cpu,
-	.sync_sg_for_device	= bounce_sync_sg_for_device,
-	.map_resource		= bounce_map_resource,
-	.unmap_resource		= bounce_unmap_resource,
-	.alloc_pages		= dma_common_alloc_pages,
-	.free_pages		= dma_common_free_pages,
-	.dma_supported		= dma_direct_supported,
-};
-
 static inline int iommu_domain_cache_init(void)
 {
 	int ret = 0;
@@ -4690,7 +4037,7 @@ static void free_all_cpu_cached_iovas(unsigned int cpu)
 			if (!domain || domain->domain.type != IOMMU_DOMAIN_DMA)
 				continue;
 
-			free_cpu_cached_iovas(cpu, &domain->iovad);
+			iommu_dma_free_cpu_cached_iovas(cpu, &domain->domain);
 		}
 	}
 }
@@ -4963,12 +4310,6 @@ int __init intel_iommu_init(void)
 	if (list_empty(&dmar_atsr_units))
 		pr_info("No ATSR found\n");
 
-	if (dmar_init_reserved_ranges()) {
-		if (force_on)
-			panic("tboot: Failed to reserve iommu ranges\n");
-		goto out_free_reserved_range;
-	}
-
 	if (dmar_map_gfx)
 		intel_iommu_gfx_mapped = 1;
 
@@ -4979,7 +4320,7 @@ int __init intel_iommu_init(void)
 		if (force_on)
 			panic("tboot: Failed to initialize DMARs\n");
 		pr_err("Initialization failed\n");
-		goto out_free_reserved_range;
+		goto out_free_dmar;
 	}
 	up_write(&dmar_global_lock);
 
@@ -5020,8 +4361,6 @@ int __init intel_iommu_init(void)
 
 	return 0;
 
-out_free_reserved_range:
-	put_iova_domain(&reserved_iova_list);
 out_free_dmar:
 	intel_iommu_free_dmars();
 	up_write(&dmar_global_lock);
@@ -5119,17 +4458,6 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	return 0;
 }
 
-static void intel_init_iova_domain(struct dmar_domain *dmar_domain)
-{
-	init_iova_domain(&dmar_domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
-	copy_reserved_iova(&reserved_iova_list, &dmar_domain->iovad);
-
-	if (!intel_iommu_strict &&
-	    init_iova_flush_queue(&dmar_domain->iovad,
-				  iommu_flush_iova, iova_entry_free))
-		pr_info("iova flush queue initialization failed\n");
-}
-
 static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
@@ -5149,8 +4477,9 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 			return NULL;
 		}
 
-		if (type == IOMMU_DOMAIN_DMA)
-			intel_init_iova_domain(dmar_domain);
+		if (type == IOMMU_DOMAIN_DMA &&
+		    iommu_get_dma_cookie(&dmar_domain->domain))
+			return NULL;
 
 		domain = &dmar_domain->domain;
 		domain->geometry.aperture_start = 0;
@@ -5779,13 +5108,13 @@ static void intel_iommu_release_device(struct device *dev)
 
 static void intel_iommu_probe_finalize(struct device *dev)
 {
-	struct iommu_domain *domain;
+	dma_addr_t base = IOVA_START_PFN << VTD_PAGE_SHIFT;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 
-	domain = iommu_get_domain_for_dev(dev);
-	if (device_needs_bounce(dev))
-		set_dma_ops(dev, &bounce_dma_ops);
-	else if (domain && domain->type == IOMMU_DOMAIN_DMA)
-		set_dma_ops(dev, &intel_dma_ops);
+	if (domain && domain->type == IOMMU_DOMAIN_DMA)
+		iommu_setup_dma_ops(dev, base,
+				    __DOMAIN_MAX_ADDR(dmar_domain->gaw) - base);
 	else
 		set_dma_ops(dev, NULL);
 }
@@ -5898,19 +5227,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	return ret;
 }
 
-static void intel_iommu_apply_resv_region(struct device *dev,
-					  struct iommu_domain *domain,
-					  struct iommu_resv_region *region)
-{
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long start, end;
-
-	start = IOVA_PFN(region->start);
-	end   = IOVA_PFN(region->start + region->length - 1);
-
-	WARN_ON_ONCE(!reserve_iova(&dmar_domain->iovad, start, end));
-}
-
 static struct iommu_group *intel_iommu_device_group(struct device *dev)
 {
 	if (dev_is_pci(dev))
@@ -6099,6 +5415,27 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
 	return ret;
 }
 
+static int
+intel_iommu_domain_get_attr(struct iommu_domain *domain,
+			    enum iommu_attr attr, void *data)
+{
+	switch (domain->type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		return -ENODEV;
+	case IOMMU_DOMAIN_DMA:
+		switch (attr) {
+		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
+			*(int *)data = !intel_iommu_strict;
+			return 0;
+		default:
+			return -ENODEV;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Check that the device does not live on an external facing PCI port that is
  * marked as untrusted. Such devices should not be able to apply quirks and
@@ -6120,6 +5457,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_free		= intel_iommu_domain_free,
+	.domain_get_attr        = intel_iommu_domain_get_attr,
 	.domain_set_attr	= intel_iommu_domain_set_attr,
 	.attach_dev		= intel_iommu_attach_device,
 	.detach_dev		= intel_iommu_detach_device,
@@ -6128,6 +5466,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.aux_get_pasid		= intel_iommu_aux_get_pasid,
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
+	.flush_iotlb_all        = intel_flush_iotlb_all,
 	.iotlb_sync		= intel_iommu_tlb_sync,
 	.iova_to_phys		= intel_iommu_iova_to_phys,
 	.probe_device		= intel_iommu_probe_device,
@@ -6135,7 +5474,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
-	.apply_resv_region	= intel_iommu_apply_resv_region,
 	.device_group		= intel_iommu_device_group,
 	.dev_has_feat		= intel_iommu_dev_has_feat,
 	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
-- 
2.25.1

