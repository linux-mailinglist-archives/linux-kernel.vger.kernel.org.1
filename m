Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118FA2F5CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbhANJAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:00:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:38938 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbhANJAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:00:06 -0500
IronPort-SDR: dlt3cmZG2vK+hvpBPRVYzTxFHXZZXn+W6smsi8JBxmFfwNF97ztQZbEEEEOITZ10Q3BrVejtyf
 y54ubo+dp87g==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="166005758"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="166005758"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 00:58:37 -0800
IronPort-SDR: VDfZHKwFzx84YTFDConwZBa/HwsLp8PJtgdveSAV4AesjLfkptxoPYNUZFO3GswIxqBMPAr2br
 qlmpn5FxE5ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="465189266"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jan 2021 00:58:34 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Consolidate duplicate cache invaliation code
Date:   Thu, 14 Jan 2021 16:50:21 +0800
Message-Id: <20210114085021.717041-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pasid based IOTLB and devTLB invalidation code is duplicate in
several places. Consolidate them by using the common helpers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 18 ++----------
 drivers/iommu/intel/svm.c   | 55 ++++++-------------------------------
 2 files changed, 11 insertions(+), 62 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index b92af83b79bd..f26cb6195b2c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -456,20 +456,6 @@ pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
-static void
-iotlb_invalidation_with_pasid(struct intel_iommu *iommu, u16 did, u32 pasid)
-{
-	struct qi_desc desc;
-
-	desc.qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
-			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) | QI_EIOTLB_TYPE;
-	desc.qw1 = 0;
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-
-	qi_submit_sync(iommu, &desc, 1, 0);
-}
-
 static void
 devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 			       struct device *dev, u32 pasid)
@@ -514,7 +500,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 		clflush_cache_range(pte, sizeof(*pte));
 
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-	iotlb_invalidation_with_pasid(iommu, did, pasid);
+	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
 
 	/* Device IOTLB doesn't need to be flushed in caching mode. */
 	if (!cap_caching_mode(iommu->cap))
@@ -530,7 +516,7 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 
 	if (cap_caching_mode(iommu->cap)) {
 		pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-		iotlb_invalidation_with_pasid(iommu, did, pasid);
+		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
 	} else {
 		iommu_flush_write_buffer(iommu);
 	}
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 18a9f05df407..033b25886e57 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -123,53 +123,16 @@ static void __flush_svm_range_dev(struct intel_svm *svm,
 				  unsigned long address,
 				  unsigned long pages, int ih)
 {
-	struct qi_desc desc;
+	struct device_domain_info *info = get_domain_info(sdev->dev);
 
-	if (pages == -1) {
-		desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
-			QI_EIOTLB_DID(sdev->did) |
-			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
-			QI_EIOTLB_TYPE;
-		desc.qw1 = 0;
-	} else {
-		int mask = ilog2(__roundup_pow_of_two(pages));
-
-		desc.qw0 = QI_EIOTLB_PASID(svm->pasid) |
-				QI_EIOTLB_DID(sdev->did) |
-				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
-				QI_EIOTLB_TYPE;
-		desc.qw1 = QI_EIOTLB_ADDR(address) |
-				QI_EIOTLB_IH(ih) |
-				QI_EIOTLB_AM(mask);
-	}
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-	qi_submit_sync(sdev->iommu, &desc, 1, 0);
-
-	if (sdev->dev_iotlb) {
-		desc.qw0 = QI_DEV_EIOTLB_PASID(svm->pasid) |
-				QI_DEV_EIOTLB_SID(sdev->sid) |
-				QI_DEV_EIOTLB_QDEP(sdev->qdep) |
-				QI_DEIOTLB_TYPE;
-		if (pages == -1) {
-			desc.qw1 = QI_DEV_EIOTLB_ADDR(-1ULL >> 1) |
-					QI_DEV_EIOTLB_SIZE;
-		} else if (pages > 1) {
-			/* The least significant zero bit indicates the size. So,
-			 * for example, an "address" value of 0x12345f000 will
-			 * flush from 0x123440000 to 0x12347ffff (256KiB). */
-			unsigned long last = address + ((unsigned long)(pages - 1) << VTD_PAGE_SHIFT);
-			unsigned long mask = __rounddown_pow_of_two(address ^ last);
-
-			desc.qw1 = QI_DEV_EIOTLB_ADDR((address & ~mask) |
-					(mask - 1)) | QI_DEV_EIOTLB_SIZE;
-		} else {
-			desc.qw1 = QI_DEV_EIOTLB_ADDR(address);
-		}
-		desc.qw2 = 0;
-		desc.qw3 = 0;
-		qi_submit_sync(sdev->iommu, &desc, 1, 0);
-	}
+	if (WARN_ON(!pages))
+		return;
+
+	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
+	if (info->ats_enabled)
+		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
+					 svm->pasid, sdev->qdep, address,
+					 order_base_2(pages));
 }
 
 static void intel_flush_svm_range_dev(struct intel_svm *svm,
-- 
2.25.1

