Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53312C1FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbgKXI2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:28:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:63905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730604AbgKXI2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:28:45 -0500
IronPort-SDR: ZJzW4JqyY+OJNXwSuf0UYlOfHnnH1FXKhROkmA72ghWyg8wa9llPDDpMrjmoaxbofAB2i5Qb7V
 akAJYoGE/LeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171129644"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="171129644"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 00:28:44 -0800
IronPort-SDR: RXya/bIlnrG57AVJIMTZXFu1hGSwyz7l81Ac//rMk1PL98/d1K2X4Fkw87oZ51w+FAgiwTjxlu
 l75H2oIPLwEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="432539746"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2020 00:28:41 -0800
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
Subject: [PATCH v6 7/7] iommu/vt-d: Cleanup after converting to dma-iommu ops
Date:   Tue, 24 Nov 2020 16:20:57 +0800
Message-Id: <20201124082057.2614359-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
References: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanups after converting the driver to use dma-iommu ops.
- Remove nobounce option;
- Cleanup and simplify the path in domain mapping.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Logan Gunthorpe <logang@deltatee.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 --
 drivers/iommu/intel/iommu.c                   | 90 ++++++-------------
 2 files changed, 28 insertions(+), 67 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..76b2a2063fd0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1883,11 +1883,6 @@
 			Note that using this option lowers the security
 			provided by tboot because it makes the system
 			vulnerable to DMA attacks.
-		nobounce [Default off]
-			Disable bounce buffer for untrusted devices such as
-			the Thunderbolt devices. This will treat the untrusted
-			devices as the trusted ones, hence might expose security
-			risks of DMA attacks.
 
 	intel_idle.max_cstate=	[KNL,HW,ACPI,X86]
 			0	disables intel_idle and fall back on acpi_idle.
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 09003abf3bbb..6d336e59851b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -355,7 +355,6 @@ static int dmar_forcedac;
 static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
 static int iommu_identity_mapping;
-static int intel_no_bounce;
 static int iommu_skip_te_disable;
 
 #define IDENTMAP_GFX		2
@@ -457,9 +456,6 @@ static int __init intel_iommu_setup(char *str)
 		} else if (!strncmp(str, "tboot_noforce", 13)) {
 			pr_info("Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
 			intel_iommu_tboot_noforce = 1;
-		} else if (!strncmp(str, "nobounce", 8)) {
-			pr_info("Intel-IOMMU: No bounce buffer. This could expose security risks of DMA attacks\n");
-			intel_no_bounce = 1;
 		}
 
 		str += strcspn(str, ",");
@@ -2277,15 +2273,14 @@ static inline int hardware_largepage_caps(struct dmar_domain *domain,
 	return level;
 }
 
-static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
-			    struct scatterlist *sg, unsigned long phys_pfn,
-			    unsigned long nr_pages, int prot)
+static int
+__domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
+		 unsigned long phys_pfn, unsigned long nr_pages, int prot)
 {
 	struct dma_pte *first_pte = NULL, *pte = NULL;
-	phys_addr_t pteval;
-	unsigned long sg_res = 0;
 	unsigned int largepage_lvl = 0;
 	unsigned long lvl_pages = 0;
+	phys_addr_t pteval;
 	u64 attr;
 
 	BUG_ON(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1));
@@ -2297,26 +2292,14 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	if (domain_use_first_level(domain))
 		attr |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_XD | DMA_FL_PTE_US;
 
-	if (!sg) {
-		sg_res = nr_pages;
-		pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | attr;
-	}
+	pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | attr;
 
 	while (nr_pages > 0) {
 		uint64_t tmp;
 
-		if (!sg_res) {
-			unsigned int pgoff = sg->offset & ~PAGE_MASK;
-
-			sg_res = aligned_nrpages(sg->offset, sg->length);
-			sg->dma_address = ((dma_addr_t)iov_pfn << VTD_PAGE_SHIFT) + pgoff;
-			sg->dma_length = sg->length;
-			pteval = (sg_phys(sg) - pgoff) | attr;
-			phys_pfn = pteval >> VTD_PAGE_SHIFT;
-		}
-
 		if (!pte) {
-			largepage_lvl = hardware_largepage_caps(domain, iov_pfn, phys_pfn, sg_res);
+			largepage_lvl = hardware_largepage_caps(domain, iov_pfn,
+					phys_pfn, nr_pages);
 
 			first_pte = pte = pfn_to_dma_pte(domain, iov_pfn, &largepage_lvl);
 			if (!pte)
@@ -2328,7 +2311,7 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 				pteval |= DMA_PTE_LARGE_PAGE;
 				lvl_pages = lvl_to_nr_pages(largepage_lvl);
 
-				nr_superpages = sg_res / lvl_pages;
+				nr_superpages = nr_pages / lvl_pages;
 				end_pfn = iov_pfn + nr_superpages * lvl_pages - 1;
 
 				/*
@@ -2362,48 +2345,45 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		lvl_pages = lvl_to_nr_pages(largepage_lvl);
 
 		BUG_ON(nr_pages < lvl_pages);
-		BUG_ON(sg_res < lvl_pages);
 
 		nr_pages -= lvl_pages;
 		iov_pfn += lvl_pages;
 		phys_pfn += lvl_pages;
 		pteval += lvl_pages * VTD_PAGE_SIZE;
-		sg_res -= lvl_pages;
 
 		/* If the next PTE would be the first in a new page, then we
-		   need to flush the cache on the entries we've just written.
-		   And then we'll need to recalculate 'pte', so clear it and
-		   let it get set again in the if (!pte) block above.
-
-		   If we're done (!nr_pages) we need to flush the cache too.
-
-		   Also if we've been setting superpages, we may need to
-		   recalculate 'pte' and switch back to smaller pages for the
-		   end of the mapping, if the trailing size is not enough to
-		   use another superpage (i.e. sg_res < lvl_pages). */
+		 * need to flush the cache on the entries we've just written.
+		 * And then we'll need to recalculate 'pte', so clear it and
+		 * let it get set again in the if (!pte) block above.
+		 *
+		 * If we're done (!nr_pages) we need to flush the cache too.
+		 *
+		 * Also if we've been setting superpages, we may need to
+		 * recalculate 'pte' and switch back to smaller pages for the
+		 * end of the mapping, if the trailing size is not enough to
+		 * use another superpage (i.e. nr_pages < lvl_pages).
+		 */
 		pte++;
 		if (!nr_pages || first_pte_in_page(pte) ||
-		    (largepage_lvl > 1 && sg_res < lvl_pages)) {
+		    (largepage_lvl > 1 && nr_pages < lvl_pages)) {
 			domain_flush_cache(domain, first_pte,
 					   (void *)pte - (void *)first_pte);
 			pte = NULL;
 		}
-
-		if (!sg_res && nr_pages)
-			sg = sg_next(sg);
 	}
+
 	return 0;
 }
 
-static int domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
-			  struct scatterlist *sg, unsigned long phys_pfn,
-			  unsigned long nr_pages, int prot)
+static int
+domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
+	       unsigned long phys_pfn, unsigned long nr_pages, int prot)
 {
 	int iommu_id, ret;
 	struct intel_iommu *iommu;
 
 	/* Do the real mapping first */
-	ret = __domain_mapping(domain, iov_pfn, sg, phys_pfn, nr_pages, prot);
+	ret = __domain_mapping(domain, iov_pfn, phys_pfn, nr_pages, prot);
 	if (ret)
 		return ret;
 
@@ -2415,20 +2395,6 @@ static int domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	return 0;
 }
 
-static inline int domain_sg_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
-				    struct scatterlist *sg, unsigned long nr_pages,
-				    int prot)
-{
-	return domain_mapping(domain, iov_pfn, sg, 0, nr_pages, prot);
-}
-
-static inline int domain_pfn_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
-				     unsigned long phys_pfn, unsigned long nr_pages,
-				     int prot)
-{
-	return domain_mapping(domain, iov_pfn, NULL, phys_pfn, nr_pages, prot);
-}
-
 static void domain_context_clear_one(struct intel_iommu *iommu, u8 bus, u8 devfn)
 {
 	unsigned long flags;
@@ -2688,7 +2654,7 @@ static int iommu_domain_identity_map(struct dmar_domain *domain,
 	 */
 	dma_pte_clear_range(domain, first_vpfn, last_vpfn);
 
-	return __domain_mapping(domain, first_vpfn, NULL,
+	return __domain_mapping(domain, first_vpfn,
 				first_vpfn, last_vpfn - first_vpfn + 1,
 				DMA_PTE_READ|DMA_PTE_WRITE);
 }
@@ -4943,8 +4909,8 @@ static int intel_iommu_map(struct iommu_domain *domain,
 	/* Round up size to next multiple of PAGE_SIZE, if it and
 	   the low bits of hpa would take us onto the next page */
 	size = aligned_nrpages(hpa, size);
-	ret = domain_pfn_mapping(dmar_domain, iova >> VTD_PAGE_SHIFT,
-				 hpa >> VTD_PAGE_SHIFT, size, prot);
+	ret = domain_mapping(dmar_domain, iova >> VTD_PAGE_SHIFT,
+			     hpa >> VTD_PAGE_SHIFT, size, prot);
 	return ret;
 }
 
-- 
2.25.1

