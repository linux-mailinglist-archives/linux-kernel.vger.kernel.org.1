Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C230027F688
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgJAAMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:12:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:47611 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731263AbgJAAL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:11:59 -0400
IronPort-SDR: zgEkZxWQibBe4+JD+x0D4dOi55x3Y16hq0qS33I1sLfDIkYC+9QBegEFJQAodbH30nx3Syhby8
 xyKwEVdD5I5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="162639991"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="162639991"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 17:11:53 -0700
IronPort-SDR: siWcgfDe4B8i//3Kid0VOiIRRaudQVGpf14GOLMbcVJBdLUjv4EDSyUEllJ5prWv3FVf71+b6J
 iKIWQurRDxPg==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="500276825"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 17:11:53 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        sohil.mehta@intel.com, ravi.v.shankar@intel.com,
        ricardo.neri@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, kyung.min.park@intel.com
Subject: [RESEND PATCH 4/4] iommu/vt-d: Scale capability to the lowest supported between the IOMMUs
Date:   Wed, 30 Sep 2020 16:53:09 -0700
Message-Id: <20200930235309.22841-5-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930235309.22841-1-kyung.min.park@intel.com>
References: <20200930235309.22841-1-kyung.min.park@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audit IOMMU Capability/Extended Capabilities and check if the IOMMUs
have the consistent value for features as below. Find common denominator
for the features and set to the lowest supported value for each IOMMU.

Abort hot plug when the hot plugged IOMMU does not meet the aforementioned
common denominator.

Set capability to the lowest supported when below features are mismatched:
  - Maximum Address Mask Value (MAMV)
  - Second Level Large Page Support (SLLPS)
  - Maximum Guest Address Width (MGAW)
  - Supported Adjusted Guest Address Width (SAGAW)
  - Number of Domains supported (ND)
  - Pasid Size Supported (PSS)

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/audit.c | 23 +++++++++++++++++++++++
 drivers/iommu/intel/audit.h | 27 +++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  1 +
 3 files changed, 51 insertions(+)

diff --git a/drivers/iommu/intel/audit.c b/drivers/iommu/intel/audit.c
index e005bc61770a..7e12c963c2b7 100644
--- a/drivers/iommu/intel/audit.c
+++ b/drivers/iommu/intel/audit.c
@@ -40,6 +40,13 @@ static inline void check_dmar_capabilities(struct intel_iommu *a,
 	if (MINIMAL_SVM_ECAP & (a->ecap ^ b->ecap))
 		set_cap_audit_svm_sanity(false);
 
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_MAMV_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_SLLPS_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_MGAW_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_SAGAW_MASK);
+	MINIMAL_FEATURE_IOMMU(b, cap, CAP_NDOMS_MASK);
+	MINIMAL_FEATURE_IOMMU(b, ecap, ECAP_PSS_MASK);
+
 	CHECK_FEATURE_MISMATCH(a, b, cap, 5lp_support, CAP_FL5LP_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, cap, fl1gp_support, CAP_FL1GP_MASK);
 	CHECK_FEATURE_MISMATCH(a, b, cap, read_drain, CAP_RD_MASK);
@@ -98,6 +105,14 @@ static int audit_iommu_capabilities_hotplug(struct intel_iommu *hot_iommu,
 	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, qis, ECAP_QI_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, coherent, ECAP_C_MASK);
 
+	/* Abort hot plug if the hot plug iommu feature is smaller than global */
+	MINIMAL_FEATURE_HOTPLUG(hot_iommu, cap, mamv, CAP_MAMV_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(hot_iommu, cap, super_page_val, CAP_SLLPS_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(hot_iommu, cap, mgaw, CAP_MGAW_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(hot_iommu, cap, sagaw, CAP_SAGAW_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(hot_iommu, cap, ndoms, CAP_NDOMS_MASK, mismatch);
+	MINIMAL_FEATURE_HOTPLUG(hot_iommu, ecap, pss, ECAP_PSS_MASK, mismatch);
+
 	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
 		goto out;
 
@@ -147,6 +162,14 @@ static int audit_iommu_capabilities(bool audit_irq)
 		intel_iommu_ecap_sanity = (intel_iommu_ecap_sanity & ~MINIMAL_SVM_ECAP) |
 					   (first_drhd->iommu->ecap & MINIMAL_SVM_ECAP);
 
+	/* scale capability to the lowest supported value */
+	for_each_active_iommu(iommu, drhd) {
+		iommu->cap = (intel_iommu_cap_sanity & MINIMAL_FEATURE_CAP) |
+			     (~MINIMAL_FEATURE_CAP & iommu->cap);
+		iommu->ecap = (intel_iommu_ecap_sanity & ECAP_PSS_MASK) |
+			      (~ECAP_PSS_MASK & iommu->ecap);
+	}
+
 	ret = 0;
 out:
 	rcu_read_unlock();
diff --git a/drivers/iommu/intel/audit.h b/drivers/iommu/intel/audit.h
index 6dfebe8e8fbe..a293e71ce9ab 100644
--- a/drivers/iommu/intel/audit.h
+++ b/drivers/iommu/intel/audit.h
@@ -13,9 +13,14 @@
 #define CAP_FL5LP_MASK		BIT(60)
 #define CAP_PI_MASK		BIT(59)
 #define CAP_FL1GP_MASK		BIT(56)
+#define CAP_MAMV_MASK		GENMASK_ULL(53, 48)
 #define CAP_RD_MASK		BIT(55)
 #define CAP_WD_MASK		BIT(54)
 #define CAP_PSI_MASK		BIT(39)
+#define CAP_SLLPS_MASK		GENMASK_ULL(37, 34)
+#define CAP_MGAW_MASK		GENMASK_ULL(21, 16)
+#define CAP_SAGAW_MASK		GENMASK_ULL(12, 8)
+#define CAP_NDOMS_MASK		GENMASK_ULL(2, 0)
 #define CAP_CM_MASK		BIT(7)
 #define CAP_PHMR_MASK		BIT(6)
 #define CAP_PLMR_MASK		BIT(5)
@@ -32,6 +37,7 @@
 #define ECAP_PDS_MASK		BIT(42)
 #define ECAP_DIT_MASK		BIT(41)
 #define ECAP_PASID_MASK		BIT(40)
+#define ECAP_PSS_MASK		GENMASK_ULL(39, 35)
 #define ECAP_EAFS_MASK		BIT(34)
 #define ECAP_SRS_MASK		BIT(31)
 #define ECAP_ERS_MASK		BIT(30)
@@ -47,6 +53,9 @@
 #define MINIMAL_SVM_ECAP (ECAP_FLTS_MASK | ECAP_PASID_MASK | ECAP_EAFS_MASK | \
 			  ECAP_SRS_MASK | ECAP_ERS_MASK | ECAP_PRS_MASK)
 
+#define MINIMAL_FEATURE_CAP (CAP_MAMV_MASK | CAP_SLLPS_MASK | CAP_MGAW_MASK | \
+			     CAP_SAGAW_MASK | CAP_NDOMS_MASK)
+
 #define DO_CHECK_FEATURE_MISMATCH(a, b, cap, feature, MASK) \
 do { \
 	if (cap##_##feature(a) != cap##_##feature(b)) { \
@@ -65,6 +74,24 @@ do { \
 					  (b)->cap, cap, feature, MASK); \
 } while (0)
 
+#define MINIMAL_FEATURE_IOMMU(iommu, cap, MASK) \
+do { \
+	u64 min_feature = intel_iommu_##cap##_sanity & MASK; \
+	min_feature = min_t(u64, min_feature, (iommu)->cap & (MASK)); \
+	intel_iommu_##cap##_sanity = (intel_iommu_##cap##_sanity & ~(MASK)) | \
+				     min_feature; \
+} while (0)
+
+#define MINIMAL_FEATURE_HOTPLUG(iommu, cap, feature, MASK, mismatch) \
+do { \
+	if ((intel_iommu_##cap##_sanity & (MASK)) > \
+	    (cap##_##feature((iommu)->cap))) \
+		mismatch = true; \
+	else \
+		(iommu)->cap = ((iommu)->cap & ~(MASK)) | \
+		(intel_iommu_##cap##_sanity & (MASK)); \
+} while (0)
+
 enum cap_audit_type {
 	CAP_AUDIT_STATIC_DMAR,
 	CAP_AUDIT_STATIC_IRQR,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6744f00a144a..297a10091bb5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -154,6 +154,7 @@
 #define cap_max_fault_reg_offset(c) \
 	(cap_fault_reg_offset(c) + cap_num_fault_regs(c) * 16)
 
+#define cap_mamv(c)		(((c) >> 48) & 0x3f)
 #define cap_zlr(c)		(((c) >> 22) & 1)
 #define cap_isoch(c)		(((c) >> 23) & 1)
 #define cap_mgaw(c)		((((c) >> 16) & 0x3f) + 1)
-- 
2.17.1

