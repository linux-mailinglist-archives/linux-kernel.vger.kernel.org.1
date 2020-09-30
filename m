Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C6027F687
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbgJAAMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:12:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:47606 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730009AbgJAAL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:11:59 -0400
IronPort-SDR: VXcMnmoUy8vcCwN6LOZVdxA6ne5PM2XHHy6KNGpea1NP0aW92WeP4gKeL+wGPiWQsEPel1FVP5
 IpP3R5Yuk41w==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="162639987"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="162639987"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 17:11:53 -0700
IronPort-SDR: lVo9eSJj/IsN5Tg8pw5RGLMuIXcMyrmWK9AaVbfUi3wA8q7P8r6CKxmc7b53nZ13n3/xa6tn3D
 u74eIkb3wLXA==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="500276783"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 17:11:53 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        sohil.mehta@intel.com, ravi.v.shankar@intel.com,
        ricardo.neri@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, kyung.min.park@intel.com
Subject: [RESEND PATCH 3/4] iommu/vt-d: Audit IOMMUs for Interrupt Remapping features
Date:   Wed, 30 Sep 2020 16:53:08 -0700
Message-Id: <20200930235309.22841-4-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930235309.22841-1-kyung.min.park@intel.com>
References: <20200930235309.22841-1-kyung.min.park@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audit IOMMU Capability/Extended Capabilities for Interrupt Remapping.
Check if the IOMMUs have the consistent value for the features as below.
When the features are not matched among IOMMUs, report out the IOMMU
features during irq remapping initialization. Audit IOMMUs again
when a device is hot plugged.

Report out features when below features are mismatched:
  - Posted Interrupts (PI)
  - Extended Interrupt Mode (EIM)

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/Makefile        |  2 +-
 drivers/iommu/intel/audit.c         | 39 ++++++++++++++++++++++++-----
 drivers/iommu/intel/audit.h         |  4 +++
 drivers/iommu/intel/irq_remapping.c |  8 ++++++
 4 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index 02c26acb479f..b5760c4abc54 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -4,4 +4,4 @@ obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o audit.o
 obj-$(CONFIG_INTEL_IOMMU) += trace.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
-obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
+obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o audit.o
diff --git a/drivers/iommu/intel/audit.c b/drivers/iommu/intel/audit.c
index f783acabb402..e005bc61770a 100644
--- a/drivers/iommu/intel/audit.c
+++ b/drivers/iommu/intel/audit.c
@@ -27,6 +27,13 @@ bool get_cap_audit_svm_sanity(void)
 	return svm_sanity_check;
 }
 
+static inline void check_irq_capabilities(struct intel_iommu *a,
+					  struct intel_iommu *b)
+{
+	CHECK_FEATURE_MISMATCH(a, b, cap, pi_support, CAP_PI_MASK);
+	CHECK_FEATURE_MISMATCH(a, b, ecap, eim_support, ECAP_EIM_MASK);
+}
+
 static inline void check_dmar_capabilities(struct intel_iommu *a,
 					   struct intel_iommu *b)
 {
@@ -57,10 +64,17 @@ static inline void check_dmar_capabilities(struct intel_iommu *a,
 	CHECK_FEATURE_MISMATCH(a, b, ecap, coherent, ECAP_C_MASK);
 }
 
-static int audit_iommu_capabilities_hotplug(struct intel_iommu *hot_iommu)
+static int audit_iommu_capabilities_hotplug(struct intel_iommu *hot_iommu,
+					    bool audit_irq)
 {
 	bool mismatch = false;
 
+	if (audit_irq) {
+		CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, pi_support, CAP_PI_MASK);
+		CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, ecap, eim_support, ECAP_EIM_MASK);
+		goto out;
+	}
+
 	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, 5lp_support, CAP_FL5LP_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, fl1gp_support, CAP_FL1GP_MASK);
 	CHECK_FEATURE_MISMATCH_HOTPLUG(hot_iommu, cap, read_drain, CAP_RD_MASK);
@@ -103,7 +117,7 @@ static int audit_iommu_capabilities_hotplug(struct intel_iommu *hot_iommu)
 	return 0;
 }
 
-static int audit_iommu_capabilities(void)
+static int audit_iommu_capabilities(bool audit_irq)
 {
 	struct dmar_drhd_unit *first_drhd, *drhd;
 	struct intel_iommu *iommu;
@@ -117,8 +131,17 @@ static int audit_iommu_capabilities(void)
 		goto out;
 	}
 
-	for_each_active_iommu(iommu, drhd)
-		check_dmar_capabilities(first_drhd->iommu, iommu);
+	for_each_active_iommu(iommu, drhd) {
+		if (audit_irq)
+			check_irq_capabilities(first_drhd->iommu, iommu);
+		else
+			check_dmar_capabilities(first_drhd->iommu, iommu);
+	}
+
+	if (audit_irq) {
+		ret = 0;
+		goto out;
+	}
 
 	if (get_cap_audit_svm_sanity())
 		intel_iommu_ecap_sanity = (intel_iommu_ecap_sanity & ~MINIMAL_SVM_ECAP) |
@@ -134,9 +157,13 @@ int intel_iommu_audit_capabilities(enum cap_audit_type type, struct intel_iommu
 {
 	switch (type) {
 	case CAP_AUDIT_STATIC_DMAR:
-		return audit_iommu_capabilities();
+		return audit_iommu_capabilities(false);
+	case CAP_AUDIT_STATIC_IRQR:
+		return audit_iommu_capabilities(true);
 	case CAP_AUDIT_HOTPLUG_DMAR:
-		return audit_iommu_capabilities_hotplug(iommu);
+		return audit_iommu_capabilities_hotplug(iommu, false);
+	case CAP_AUDIT_HOTPLUG_IRQR:
+		return audit_iommu_capabilities_hotplug(iommu, true);
 	default:
 		return -EFAULT;
 	}
diff --git a/drivers/iommu/intel/audit.h b/drivers/iommu/intel/audit.h
index e3a370405f82..6dfebe8e8fbe 100644
--- a/drivers/iommu/intel/audit.h
+++ b/drivers/iommu/intel/audit.h
@@ -11,6 +11,7 @@
  * Capability Register Mask
  */
 #define CAP_FL5LP_MASK		BIT(60)
+#define CAP_PI_MASK		BIT(59)
 #define CAP_FL1GP_MASK		BIT(56)
 #define CAP_RD_MASK		BIT(55)
 #define CAP_WD_MASK		BIT(54)
@@ -38,6 +39,7 @@
 #define ECAP_NEST_MASK		BIT(26)
 #define ECAP_SC_MASK		BIT(7)
 #define ECAP_PT_MASK		BIT(6)
+#define ECAP_EIM_MASK		BIT(4)
 #define ECAP_DT_MASK		BIT(2)
 #define ECAP_QI_MASK		BIT(1)
 #define ECAP_C_MASK		BIT(0)
@@ -65,7 +67,9 @@ do { \
 
 enum cap_audit_type {
 	CAP_AUDIT_STATIC_DMAR,
+	CAP_AUDIT_STATIC_IRQR,
 	CAP_AUDIT_HOTPLUG_DMAR,
+	CAP_AUDIT_HOTPLUG_IRQR,
 };
 
 int intel_iommu_audit_capabilities(enum cap_audit_type type, struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 8f4ce72570ce..7c77e0754896 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -23,6 +23,7 @@
 #include <asm/msidef.h>
 
 #include "../irq_remapping.h"
+#include "audit.h"
 
 enum irq_mode {
 	IRQ_REMAPPING,
@@ -737,6 +738,9 @@ static int __init intel_prepare_irq_remapping(void)
 	if (dmar_table_init() < 0)
 		return -ENODEV;
 
+	if (intel_iommu_audit_capabilities(CAP_AUDIT_STATIC_IRQR, NULL))
+		goto error;
+
 	if (!dmar_ir_support())
 		return -ENODEV;
 
@@ -1470,6 +1474,10 @@ static int dmar_ir_add(struct dmar_drhd_unit *dmaru, struct intel_iommu *iommu)
 	int ret;
 	int eim = x2apic_enabled();
 
+	ret = intel_iommu_audit_capabilities(CAP_AUDIT_HOTPLUG_IRQR, iommu);
+	if (ret)
+		return ret;
+
 	if (eim && !ecap_eim_support(iommu->ecap)) {
 		pr_info("DRHD %Lx: EIM not supported by DRHD, ecap %Lx\n",
 			iommu->reg_phys, iommu->ecap);
-- 
2.17.1

