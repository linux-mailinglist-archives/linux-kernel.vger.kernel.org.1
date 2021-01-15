Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829CB2F6FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbhAOAwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:52:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:31432 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbhAOAv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:51:59 -0500
IronPort-SDR: O6RRU2yCkVVS7JvvhVZQ1QRcJC+2OZQE0hkxW4Hp8neUrSGnmnghtBViixpRItxRJqoKz3OVPq
 kjfF/P1xJxpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="166142441"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="166142441"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 16:50:13 -0800
IronPort-SDR: Z+FBDxFkjn5pZSMhpnlnykNa8p/SlQ0NTUGj2B5jCphULH9lm3Vlx6FcYtI3TlPYZqybv7cyZY
 U+CpgWG6IxRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="465420917"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jan 2021 16:50:11 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Preset Access/Dirty bits for IOVA over FL
Date:   Fri, 15 Jan 2021 08:42:02 +0800
Message-Id: <20210115004202.953965-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Access/Dirty bits in the first level page table entry will be set
whenever a page table entry was used for address translation or write
permission was successfully translated. This is always true when using
the first-level page table for kernel IOVA. Instead of wasting hardware
cycles to update the certain bits, it's better to set them up at the
beginning.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 14 ++++++++++++--
 include/linux/intel-iommu.h |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0ea2e1440a9b..54b8d1bf2009 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1018,8 +1018,11 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 
 			domain_flush_cache(domain, tmp_page, VTD_PAGE_SIZE);
 			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
-			if (domain_use_first_level(domain))
+			if (domain_use_first_level(domain)) {
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
+				if (domain->domain.type == IOMMU_DOMAIN_DMA)
+					pteval |= DMA_FL_PTE_ACCESS;
+			}
 			if (cmpxchg64(&pte->val, 0ULL, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
 				free_pgtable_page(tmp_page);
@@ -2293,9 +2296,16 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		return -EINVAL;
 
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
-	if (domain_use_first_level(domain))
+	if (domain_use_first_level(domain)) {
 		attr |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_XD | DMA_FL_PTE_US;
 
+		if (domain->domain.type == IOMMU_DOMAIN_DMA) {
+			attr |= DMA_FL_PTE_ACCESS;
+			if (prot & DMA_PTE_WRITE)
+				attr |= DMA_FL_PTE_DIRTY;
+		}
+	}
+
 	pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | attr;
 
 	while (nr_pages > 0) {
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 65aa963cc115..832730549c52 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -42,6 +42,8 @@
 
 #define DMA_FL_PTE_PRESENT	BIT_ULL(0)
 #define DMA_FL_PTE_US		BIT_ULL(2)
+#define DMA_FL_PTE_ACCESS	BIT_ULL(5)
+#define DMA_FL_PTE_DIRTY	BIT_ULL(6)
 #define DMA_FL_PTE_XD		BIT_ULL(63)
 
 #define ADDR_WIDTH_5LEVEL	(57)
-- 
2.25.1

