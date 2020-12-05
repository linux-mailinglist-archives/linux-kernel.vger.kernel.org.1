Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66802CFF7D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 23:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgLEWTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 17:19:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:56557 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLEWTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 17:19:50 -0500
IronPort-SDR: XukCGyCpw2AbQhzQuCbQhiIEAXKBB9pyXjZdTiya14t8yCFDGrpMSHQN0BBxkhcWgFYFqOB+AS
 QASnLor5swcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9826"; a="152791257"
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="152791257"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 14:18:30 -0800
IronPort-SDR: CxiXNuLPII+ptf5BoWsN+xFFOkTs5NwYTNel7ZUTvVoRyk/uhywJiMebICO5qIPXdk5BjeZwWm
 Rr+iuUX3Yueg==
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="362584200"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 14:18:30 -0800
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, ravi.v.shankar@intel.com, kevin.tian@intel.com,
        ashok.raj@intel.com, ricardo.neri@intel.com, sohil.mehta@intel.com,
        Kyung Min Park <kyung.min.park@intel.com>
Subject: [PATCH v2 3/3] iommu/vt-d: Disable SVM in the platform when IOMMUs have inconsistencies
Date:   Sat,  5 Dec 2020 13:57:43 -0800
Message-Id: <20201205215743.27803-4-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201205215743.27803-1-kyung.min.park@intel.com>
References: <20201205215743.27803-1-kyung.min.park@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some IOMMU Capabilities must be consistent for Shared Virtual Memory (SVM).
Audit IOMMU Capability/Extended Capabilities and check if IOMMUs have
the consistent value for features as below. When the features are not
matched among IOMMUs, disable SVMs in the platform during DMAR
initialization. Audit IOMMUs again when a device is hot plugged.

Disable Shared Virtual Memory when below features are mistmatched:
  - First Level Translation Support (FLTS)
  - Process Address Space ID Support (PASID)
  - Extended Accessed Flag Support (EAFS)
  - Supervisor Support (SRS)
  - Execute Request Support (ERS)
  - Page Request Support (PRS)

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/cap_audit.c | 11 +++++++++++
 drivers/iommu/intel/cap_audit.h |  6 ++++++
 drivers/iommu/intel/svm.c       |  3 ++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index 0bc77a9bdeed..3bbeb4634bc6 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -130,6 +130,12 @@ static int cap_audit_hotplug(struct intel_iommu *iommu, enum cap_audit_type type
 	MINIMAL_FEATURE_HOTPLUG(iommu, ecap, mhmv, ECAP_MHMV_MASK, mismatch);
 	MINIMAL_FEATURE_HOTPLUG(iommu, ecap, iro, ECAP_IRO_MASK, mismatch);
 
+	if (IS_ENABLED(CONFIG_INTEL_IOMMU_SVM) &&
+	    intel_cap_svm_santiy() && !ecap_svm_sanity(iommu->ecap)) {
+		pr_warn("Abort Hot Plug IOMMU: SVM inconsistent\n");
+		mismatch = true;
+	}
+
 out:
 	if (mismatch) {
 		intel_iommu_cap_sanity = old_cap;
@@ -206,3 +212,8 @@ bool intel_cap_flts_sanity(void)
 {
 	return ecap_flts(intel_iommu_ecap_sanity);
 }
+
+bool intel_cap_svm_santiy(void)
+{
+	return ecap_svm_sanity(intel_iommu_ecap_sanity);
+}
diff --git a/drivers/iommu/intel/cap_audit.h b/drivers/iommu/intel/cap_audit.h
index 1ce1dc314950..beb2589e97e0 100644
--- a/drivers/iommu/intel/cap_audit.h
+++ b/drivers/iommu/intel/cap_audit.h
@@ -60,6 +60,11 @@
 #define ECAP_QI_MASK		BIT_ULL(1)
 #define ECAP_C_MASK		BIT_ULL(0)
 
+#define MINIMAL_SVM_ECAP (ECAP_FLTS_MASK | ECAP_PASID_MASK | ECAP_EAFS_MASK | \
+			  ECAP_SRS_MASK | ECAP_ERS_MASK | ECAP_PRS_MASK)
+
+#define ecap_svm_sanity(e)	(!(((e) & MINIMAL_SVM_ECAP) ^ MINIMAL_SVM_ECAP))
+
 #define DO_CHECK_FEATURE_MISMATCH(a, b, cap, feature, MASK) \
 do { \
 	if (cap##_##feature(a) != cap##_##feature(b)) { \
@@ -107,6 +112,7 @@ bool intel_cap_smts_sanity(void);
 bool intel_cap_pasid_sanity(void);
 bool intel_cap_nest_sanity(void);
 bool intel_cap_flts_sanity(void);
+bool intel_cap_svm_santiy(void);
 
 static inline bool scalable_mode_support(void)
 {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 3242ebd0bca3..7761e40a2d5a 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -22,6 +22,7 @@
 #include <asm/fpu/api.h>
 
 #include "pasid.h"
+#include "cap_audit.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, u32 pasid);
@@ -98,7 +99,7 @@ static inline bool intel_svm_capable(struct intel_iommu *iommu)
 
 void intel_svm_check(struct intel_iommu *iommu)
 {
-	if (!pasid_supported(iommu))
+	if (!intel_cap_svm_santiy())
 		return;
 
 	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
-- 
2.17.1

