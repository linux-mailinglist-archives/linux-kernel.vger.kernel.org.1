Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C327F686
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbgJAAL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:11:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:47606 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730009AbgJAALz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:11:55 -0400
IronPort-SDR: CEEw26XUFGAREIlhx7yCgFaYQjah+2DWuKO88FuevhHJhuo7voEUBVnKHI3OE79e+Cn6rEnCJj
 Zvrfmi9FiW+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="162639979"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="162639979"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 17:11:53 -0700
IronPort-SDR: UJ6yNBdwokIZ8gHYcu/Il8lkSteIouYhw1iTI4xQ+9sDaK6ZGaq5ltClEPvu+SjmtHj8atlfJA
 YD1cWwMx41Ew==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="500276721"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 17:11:52 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        sohil.mehta@intel.com, ravi.v.shankar@intel.com,
        ricardo.neri@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, kyung.min.park@intel.com
Subject: [RESEND PATCH 1/4] iommu/vt-d: Disable SVM in the platform when IOMMUs have inconsistencies
Date:   Wed, 30 Sep 2020 16:53:06 -0700
Message-Id: <20200930235309.22841-2-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930235309.22841-1-kyung.min.park@intel.com>
References: <20200930235309.22841-1-kyung.min.park@intel.com>
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
 drivers/iommu/intel/Makefile |  2 +-
 drivers/iommu/intel/audit.c  | 95 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/audit.h  | 29 +++++++++++
 drivers/iommu/intel/iommu.c  | 12 ++++-
 4 files changed, 136 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/intel/audit.c
 create mode 100644 drivers/iommu/intel/audit.h

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index fb8e1e8c8029..02c26acb479f 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o
+obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o audit.o
 obj-$(CONFIG_INTEL_IOMMU) += trace.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
diff --git a/drivers/iommu/intel/audit.c b/drivers/iommu/intel/audit.c
new file mode 100644
index 000000000000..2893170f5b6c
--- /dev/null
+++ b/drivers/iommu/intel/audit.c
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * audit.c - audit iommu capabilities for boot time and hot plug
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ * Author: Kyung Min Park <kyung.min.park@intel.com>
+ */
+
+#define pr_fmt(fmt)	"DMAR: " fmt
+
+#include <linux/intel-iommu.h>
+#include "audit.h"
+
+static bool svm_sanity_check = true;
+static u64 intel_iommu_ecap_sanity = ~0ULL;
+
+static void set_cap_audit_svm_sanity(bool svm_sanity)
+{
+	svm_sanity_check = svm_sanity;
+}
+
+bool get_cap_audit_svm_sanity(void)
+{
+	return svm_sanity_check;
+}
+
+static inline void check_dmar_capabilities(struct intel_iommu *a,
+					   struct intel_iommu *b)
+{
+	if (MINIMAL_SVM_ECAP & (a->ecap ^ b->ecap))
+		set_cap_audit_svm_sanity(false);
+}
+
+static int audit_iommu_capabilities_hotplug(struct intel_iommu *hot_iommu)
+{
+	bool mismatch = false;
+
+	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
+		goto out;
+
+	if (!get_cap_audit_svm_sanity() && (hot_iommu->flags & VTD_FLAG_SVM_CAPABLE)) {
+		pr_warn("Disable SVM in the IOMMU: SVM disabled at boot time.\n");
+		hot_iommu->flags = hot_iommu->flags & ~VTD_FLAG_SVM_CAPABLE;
+	} else if (get_cap_audit_svm_sanity() && (MINIMAL_SVM_ECAP &
+		   (hot_iommu->ecap ^ intel_iommu_ecap_sanity))) {
+		pr_warn("Abort Hot Plug IOMMU: SVM inconsistent.\n");
+		mismatch = true;
+	}
+
+out:
+	if (mismatch)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int audit_iommu_capabilities(void)
+{
+	struct dmar_drhd_unit *first_drhd, *drhd;
+	struct intel_iommu *iommu;
+	int ret = -EFAULT;
+
+	rcu_read_lock();
+	first_drhd = list_first_or_null_rcu(&dmar_drhd_units, typeof(*drhd),
+					    list);
+	if (!first_drhd) {
+		ret = 0;
+		goto out;
+	}
+
+	for_each_active_iommu(iommu, drhd)
+		check_dmar_capabilities(first_drhd->iommu, iommu);
+
+	if (get_cap_audit_svm_sanity())
+		intel_iommu_ecap_sanity = (intel_iommu_ecap_sanity & ~MINIMAL_SVM_ECAP) |
+					   (first_drhd->iommu->ecap & MINIMAL_SVM_ECAP);
+
+	ret = 0;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+int intel_iommu_audit_capabilities(enum cap_audit_type type, struct intel_iommu *iommu)
+{
+	switch (type) {
+	case CAP_AUDIT_STATIC_DMAR:
+		return audit_iommu_capabilities();
+	case CAP_AUDIT_HOTPLUG_DMAR:
+		return audit_iommu_capabilities_hotplug(iommu);
+	default:
+		return -EFAULT;
+	}
+}
diff --git a/drivers/iommu/intel/audit.h b/drivers/iommu/intel/audit.h
new file mode 100644
index 000000000000..887900d9517d
--- /dev/null
+++ b/drivers/iommu/intel/audit.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * audit.h - audit iommu capabilities header
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ * Author: Kyung Min Park <kyung.min.park@intel.com>
+ */
+
+/*
+ * Extended Capability Register Mask
+ */
+#define ECAP_FLTS_MASK		BIT(47)
+#define ECAP_PASID_MASK		BIT(40)
+#define ECAP_EAFS_MASK		BIT(34)
+#define ECAP_SRS_MASK		BIT(31)
+#define ECAP_ERS_MASK		BIT(30)
+#define ECAP_PRS_MASK		BIT(29)
+
+#define MINIMAL_SVM_ECAP (ECAP_FLTS_MASK | ECAP_PASID_MASK | ECAP_EAFS_MASK | \
+			  ECAP_SRS_MASK | ECAP_ERS_MASK | ECAP_PRS_MASK)
+
+enum cap_audit_type {
+	CAP_AUDIT_STATIC_DMAR,
+	CAP_AUDIT_HOTPLUG_DMAR,
+};
+
+int intel_iommu_audit_capabilities(enum cap_audit_type type, struct intel_iommu *iommu);
+bool get_cap_audit_svm_sanity(void);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 87b17bac04c2..ab8300ee9791 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -49,6 +49,7 @@
 
 #include "../irq_remapping.h"
 #include "pasid.h"
+#include "audit.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
@@ -3230,6 +3231,10 @@ static int __init init_dmars(void)
 		goto error;
 	}
 
+	ret = intel_iommu_audit_capabilities(CAP_AUDIT_STATIC_DMAR, NULL);
+	if (ret)
+		goto free_iommu;
+
 	for_each_iommu(iommu, drhd) {
 		if (drhd->ignored) {
 			iommu_disable_translation(iommu);
@@ -3300,7 +3305,8 @@ static int __init init_dmars(void)
 
 		if (!ecap_pass_through(iommu->ecap))
 			hw_pass_through = 0;
-		intel_svm_check(iommu);
+		if (get_cap_audit_svm_sanity())
+			intel_svm_check(iommu);
 	}
 
 	/*
@@ -4366,6 +4372,10 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (g_iommus[iommu->seq_id])
 		return 0;
 
+	ret = intel_iommu_audit_capabilities(CAP_AUDIT_HOTPLUG_DMAR, iommu);
+	if (ret)
+		goto out;
+
 	if (hw_pass_through && !ecap_pass_through(iommu->ecap)) {
 		pr_warn("%s: Doesn't support hardware pass through.\n",
 			iommu->name);
-- 
2.17.1

