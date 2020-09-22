Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533F4274B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIVVZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:25:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:47565 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIVVZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:25:50 -0400
IronPort-SDR: qnOw3k5FQ3PQHh1jBoiU6i11/xU6vGpYvXHx6F+J3zHrKJHHgtoWE6PqhUNTj41VQvw4NrHub6
 +IHNp+nKwMcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="158093406"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="158093406"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 14:20:50 -0700
IronPort-SDR: L5jiwMm5kQnjG9OEhGz/u9w4d/4vmV8CiE1O29DfmNzWuaoLngu+7LOiiF1aczi3pj765lSkcu
 +sACR7NgpO8Q==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="511368019"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 14:20:49 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        sohil.mehta@intel.com, ravi.v.shankar@intel.com,
        ricardo.neri@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, Kyung Min Park <kyung.min.park@intel.com>
Subject: [PATCH 2/4] iommu/vt-d: Report out when IOMMU features have inconsistencies
Date:   Tue, 22 Sep 2020 14:02:38 -0700
Message-Id: <20200922210240.27178-3-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922210240.27178-1-kyung.min.park@intel.com>
References: <20200922210240.27178-1-kyung.min.park@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU features as below can have incompatibilities among IOMMUs.
Audit IOMMU Capability/Extended Capability and check if the IOMMUs have
the consistent value for features as below. Report out when features as
below have incompatibility among IOMMUs.

Report out features when below features are mismatched:
  - First Level 5 Level Paging Support (FL5LP)
  - First Level 1 GByte Page Support (FL1GP)
  - Read Draining (DRD)
  - Write Draining (DWD)
  - Page Selective Invalidation (PSI)
  - Caching Mode (CM)
  - Protected High/Low-Memory Region (PHMR/PLMR)
  - Scalable Mode Page Walk Coherency (SMPWC)
  - First Level Translation Support (FLTS)
  - Second Level Translation Support (SLTS)
  - Second Level Accessed/Dirty Support (SLADS)
  - Virtual Command Support (VCS)
  - Scalable Mode Translation Support (SMTS)
  - Device TLB Invalidation Throttle (DIT)
  - Page Drain Support (PDS)
  - Nested Translation Support (NEST)
  - Snoop Control (SC)
  - Pass Through (PT)
  - Device TLB Support (DT)
  - Queued Invalidation (QI)
  - Page walk Coherency (C)

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/audit.c | 48 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/audit.h | 43 +++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  2 ++
 3 files changed, 93 insertions(+)

diff --git a/drivers/iommu/intel/audit.c b/drivers/iommu/intel/audit.c
index 2893170f5b6c..f783acabb402 100644
--- a/drivers/iommu/intel/audit.c
+++ b/drivers/iommu/intel/audit.c
@@ -13,6 +13,8 @@
 #include "audit.h"
 
 static bool svm_sanity_check = true;
+/* global variables that hold feature consistency and minimum features */
+static u64 intel_iommu_cap_sanity = ~0ULL;
 static u64 intel_iommu_ecap_sanity = ~0ULL;
 
 static void set_cap_audit_svm_sanity(bool svm_sanity)
@@ -30,12 +32,58 @@ static inline void check_dmar_capabilities(struct intel_iommu *a,
 {
 	if (MINIMAL_SVM_ECAP & (a->ecap ^ b->ecap))
 		set_cap_audit_svm_sanity(false);
+
+	CHECK_FEATURE_MISMATCH(a, b, cap, 5lp_support, CAP_FL5LP_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, fl1gp_support, CAP_FL1GP_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, read_drain, CAP_RD_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, write_drain, CAP_WD_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, pgsel_inv, CAP_PSI_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, caching_mode, CAP_CM_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, phmr, CAP_PHMR_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, cap, plmr, CAP_PLMR_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, smpwc, ECAP_SMPWC_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, flts, ECAP_FLTS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, slts, ECAP_SLTS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, slads, ECAP_SLADS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, vcs, ECAP_VCS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, smts, ECAP_SMTS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, pds, ECAP_PDS_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, dit, ECAP_DIT_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, nest, ECAP_NEST_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, sc_support, ECAP_SC_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, pass_through, ECAP_PT_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, dev_iotlb_support, ECAP_DT_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, qis, ECAP_QI_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, coherent, ECAP_C_MASK);
 }
 
 static int audit_iommu_capabilities_hotplug(struct intel_iommu *hot_iommu)
 {
 	bool mismatch = false;
 
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, 5lp_support, CAP_FL5LP_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, fl1gp_support, CAP_FL1GP_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, read_drain, CAP_RD_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, write_drain, CAP_WD_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, pgsel_inv, CAP_PSI_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, caching_mode, CAP_CM_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, phmr, CAP_PHMR_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, plmr, CAP_PLMR_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, smpwc, ECAP_SMPWC_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, flts, ECAP_FLTS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, slts, ECAP_SLTS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, slads, ECAP_SLADS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, vcs, ECAP_VCS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, smts, ECAP_SMTS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, pds, ECAP_PDS_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, dit, ECAP_DIT_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, nest, ECAP_NEST_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, sc_support, ECAP_SC_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, pass_through, ECAP_PT_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, dev_iotlb_support, ECAP_DT_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, qis, ECAP_QI_MASK);
+	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, coherent, ECAP_C_MASK);
+
 	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
 		goto out;
 
diff --git a/drivers/iommu/intel/audit.h b/drivers/iommu/intel/audit.h
index 887900d9517d..e3a370405f82 100644
--- a/drivers/iommu/intel/audit.h
+++ b/drivers/iommu/intel/audit.h
@@ -7,19 +7,62 @@
  * Author: Kyung Min Park <kyung.min.park@intel.com>
  */
 
+/*
+ * Capability Register Mask
+ */
+#define CAP_FL5LP_MASK		BIT(60)
+#define CAP_FL1GP_MASK		BIT(56)
+#define CAP_RD_MASK		BIT(55)
+#define CAP_WD_MASK		BIT(54)
+#define CAP_PSI_MASK		BIT(39)
+#define CAP_CM_MASK		BIT(7)
+#define CAP_PHMR_MASK		BIT(6)
+#define CAP_PLMR_MASK		BIT(5)
+
 /*
  * Extended Capability Register Mask
  */
+#define ECAP_SMPWC_MASK		BIT(48)
 #define ECAP_FLTS_MASK		BIT(47)
+#define ECAP_SLTS_MASK		BIT(46)
+#define ECAP_SLADS_MASK		BIT(45)
+#define ECAP_VCS_MASK		BIT(44)
+#define ECAP_SMTS_MASK		BIT(43)
+#define ECAP_PDS_MASK		BIT(42)
+#define ECAP_DIT_MASK		BIT(41)
 #define ECAP_PASID_MASK		BIT(40)
 #define ECAP_EAFS_MASK		BIT(34)
 #define ECAP_SRS_MASK		BIT(31)
 #define ECAP_ERS_MASK		BIT(30)
 #define ECAP_PRS_MASK		BIT(29)
+#define ECAP_NEST_MASK		BIT(26)
+#define ECAP_SC_MASK		BIT(7)
+#define ECAP_PT_MASK		BIT(6)
+#define ECAP_DT_MASK		BIT(2)
+#define ECAP_QI_MASK		BIT(1)
+#define ECAP_C_MASK		BIT(0)
 
 #define MINIMAL_SVM_ECAP (ECAP_FLTS_MASK | ECAP_PASID_MASK | ECAP_EAFS_MASK | \
 			  ECAP_SRS_MASK | ECAP_ERS_MASK | ECAP_PRS_MASK)
 
+#define DO_CHECK_FEATURE_MISMATCH(a, b, cap, feature, MASK) \
+do { \
+	if (cap##_##feature(a) != cap##_##feature(b)) { \
+		intel_iommu_##cap##_sanity &= ~(MASK); \
+		pr_info("IOMMU feature %s inconsistent.", #feature); \
+	} \
+} while (0)
+
+#define CHECK_FEATURE_MISMATCH(a, b, cap, feature, MASK) \
+	DO_CHECK_FEATURE_MISMATCH((a)->cap, (b)->cap, cap, feature, MASK)
+
+#define CHECK_FEATURE_MISMATCH_HOTPLUG(b, cap, feature, MASK) \
+do { \
+	if (cap##_##feature(intel_iommu_##cap##_sanity)) \
+		DO_CHECK_FEATURE_MISMATCH(intel_iommu_##cap##_sanity, \
+					  (b)->cap, cap, feature, MASK); \
+} while (0)
+
 enum cap_audit_type {
 	CAP_AUDIT_STATIC_DMAR,
 	CAP_AUDIT_HOTPLUG_DMAR,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b1ed2f25f7c0..6744f00a144a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -171,8 +171,10 @@
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
+#define ecap_slads(e)		(((e) >> 45) & 0x1)
 #define ecap_vcs(e)		(((e) >> 44) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
+#define ecap_pds(e)		(((e) >> 42) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
 #define ecap_pss(e)		((e >> 35) & 0x1f)
-- 
2.17.1

