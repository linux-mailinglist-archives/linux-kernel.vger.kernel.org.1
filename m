Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8902BA75D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgKTKYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:24:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:17833 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgKTKYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:24:43 -0500
IronPort-SDR: itkVI56vSRtYWNWnvpyfJ358XVlDMAvi20Oi/Jo9CQDNBsJdTNa5JVLgUuBaqb3zpmJIxiG0l4
 u4qcDl3d2lMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="150717591"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="150717591"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 02:24:42 -0800
IronPort-SDR: 8PC9PE/7Vl/HOQ/X/024TsNymgoUb+l1N1w3cWQQcQBANm/ScQtwhBgBVQaGGo/287q0siyZGo
 jlcBkfUvT3XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="545393643"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2020 02:24:39 -0800
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
Subject: [PATCH v5 1/7] iommu: Handle freelists when using deferred flushing in iommu drivers
Date:   Fri, 20 Nov 2020 18:17:13 +0800
Message-Id: <20201120101719.3172693-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
References: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Murphy <murphyt7@tcd.ie>

Allow the iommu_unmap_fast to return newly freed page table pages and
pass the freelist to queue_iova in the dma-iommu ops path.

This is useful for iommu drivers (in this case the intel iommu driver)
which need to wait for the ioTLB to be flushed before newly
free/unmapped page table pages can be freed. This way we can still batch
ioTLB free operations and handle the freelists.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/dma-iommu.c   | 29 +++++++++++++------
 drivers/iommu/intel/iommu.c | 55 ++++++++++++++++++++++++-------------
 include/linux/iommu.h       |  1 +
 3 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0cbcd3fc3e7e..9c827a4d2207 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -49,6 +49,18 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 };
 
+static void iommu_dma_entry_dtor(unsigned long data)
+{
+	struct page *freelist = (struct page *)data;
+
+	while (freelist) {
+		unsigned long p = (unsigned long)page_address(freelist);
+
+		freelist = freelist->freelist;
+		free_page(p);
+	}
+}
+
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 {
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
@@ -343,7 +355,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
 			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
 		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
-					NULL))
+					  iommu_dma_entry_dtor))
 			pr_warn("iova flush queue initialization failed\n");
 		else
 			cookie->fq_domain = domain;
@@ -440,7 +452,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 }
 
 static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
-		dma_addr_t iova, size_t size)
+		dma_addr_t iova, size_t size, struct page *freelist)
 {
 	struct iova_domain *iovad = &cookie->iovad;
 
@@ -449,7 +461,8 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 		cookie->msi_iova -= size;
 	else if (cookie->fq_domain)	/* non-strict mode */
 		queue_iova(iovad, iova_pfn(iovad, iova),
-				size >> iova_shift(iovad), 0);
+				size >> iova_shift(iovad),
+				(unsigned long)freelist);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
@@ -474,7 +487,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 
 	if (!cookie->fq_domain)
 		iommu_iotlb_sync(domain, &iotlb_gather);
-	iommu_dma_free_iova(cookie, dma_addr, size);
+	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
@@ -496,7 +509,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		return DMA_MAPPING_ERROR;
 
 	if (iommu_map_atomic(domain, iova, phys - iova_off, size, prot)) {
-		iommu_dma_free_iova(cookie, iova, size);
+		iommu_dma_free_iova(cookie, iova, size, NULL);
 		return DMA_MAPPING_ERROR;
 	}
 	return iova + iova_off;
@@ -649,7 +662,7 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 out_free_sg:
 	sg_free_table(&sgt);
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size);
+	iommu_dma_free_iova(cookie, iova, size, NULL);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
 	return NULL;
@@ -900,7 +913,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	return __finalise_sg(dev, sg, nents, iova);
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, iova_len);
+	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
 out_restore_sg:
 	__invalidate_sg(sg, nents);
 	return 0;
@@ -1228,7 +1241,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return msi_page;
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size);
+	iommu_dma_free_iova(cookie, iova, size, NULL);
 out_free_page:
 	kfree(msi_page);
 	return NULL;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index af3abd285214..77fba7f8336a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1243,17 +1243,17 @@ static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
    pages can only be freed after the IOTLB flush has been done. */
 static struct page *domain_unmap(struct dmar_domain *domain,
 				 unsigned long start_pfn,
-				 unsigned long last_pfn)
+				 unsigned long last_pfn,
+				 struct page *freelist)
 {
-	struct page *freelist;
-
 	BUG_ON(!domain_pfn_supported(domain, start_pfn));
 	BUG_ON(!domain_pfn_supported(domain, last_pfn));
 	BUG_ON(start_pfn > last_pfn);
 
 	/* we don't need lock here; nobody else touches the iova range */
 	freelist = dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
-				       domain->pgd, 0, start_pfn, last_pfn, NULL);
+				       domain->pgd, 0, start_pfn, last_pfn,
+				       freelist);
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
@@ -2011,7 +2011,8 @@ static void domain_exit(struct dmar_domain *domain)
 	if (domain->pgd) {
 		struct page *freelist;
 
-		freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
+		freelist = domain_unmap(domain, 0,
+					DOMAIN_MAX_PFN(domain->gaw), NULL);
 		dma_free_pagelist(freelist);
 	}
 
@@ -3570,7 +3571,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	if (dev_is_pci(dev))
 		pdev = to_pci_dev(dev);
 
-	freelist = domain_unmap(domain, start_pfn, last_pfn);
+	freelist = domain_unmap(domain, start_pfn, last_pfn, NULL);
 	if (intel_iommu_strict || (pdev && pdev->untrusted) ||
 			!has_iova_flush_queue(&domain->iovad)) {
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
@@ -4637,7 +4638,8 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 			struct page *freelist;
 
 			freelist = domain_unmap(si_domain,
-						start_vpfn, last_vpfn);
+						start_vpfn, last_vpfn,
+						NULL);
 
 			rcu_read_lock();
 			for_each_active_iommu(iommu, drhd)
@@ -5610,10 +5612,8 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 				struct iommu_iotlb_gather *gather)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct page *freelist = NULL;
 	unsigned long start_pfn, last_pfn;
-	unsigned int npages;
-	int iommu_id, level = 0;
+	int level = 0;
 
 	/* Cope with horrid API which requires us to unmap more than the
 	   size argument if it happens to be a large-page mapping. */
@@ -5625,22 +5625,38 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	start_pfn = iova >> VTD_PAGE_SHIFT;
 	last_pfn = (iova + size - 1) >> VTD_PAGE_SHIFT;
 
-	freelist = domain_unmap(dmar_domain, start_pfn, last_pfn);
-
-	npages = last_pfn - start_pfn + 1;
-
-	for_each_domain_iommu(iommu_id, dmar_domain)
-		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
-				      start_pfn, npages, !freelist, 0);
-
-	dma_free_pagelist(freelist);
+	gather->freelist = domain_unmap(dmar_domain, start_pfn,
+					last_pfn, gather->freelist);
 
 	if (dmar_domain->max_addr == iova + size)
 		dmar_domain->max_addr = iova;
 
+	iommu_iotlb_gather_add_page(domain, gather, iova, size);
+
 	return size;
 }
 
+static void intel_iommu_tlb_sync(struct iommu_domain *domain,
+				 struct iommu_iotlb_gather *gather)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	unsigned long iova_pfn = IOVA_PFN(gather->start);
+	size_t size = gather->end - gather->start;
+	unsigned long start_pfn, last_pfn;
+	unsigned long nrpages;
+	int iommu_id;
+
+	nrpages = aligned_nrpages(gather->start, size);
+	start_pfn = mm_to_dma_pfn(iova_pfn);
+	last_pfn = start_pfn + nrpages - 1;
+
+	for_each_domain_iommu(iommu_id, dmar_domain)
+		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
+				      start_pfn, nrpages, !gather->freelist, 0);
+
+	dma_free_pagelist(gather->freelist);
+}
+
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 					    dma_addr_t iova)
 {
@@ -6100,6 +6116,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.aux_get_pasid		= intel_iommu_aux_get_pasid,
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
+	.iotlb_sync		= intel_iommu_tlb_sync,
 	.iova_to_phys		= intel_iommu_iova_to_phys,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b95a6f8db6ff..e56bae327e35 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -180,6 +180,7 @@ struct iommu_iotlb_gather {
 	unsigned long		start;
 	unsigned long		end;
 	size_t			pgsize;
+	struct page		*freelist;
 };
 
 /**
-- 
2.25.1

