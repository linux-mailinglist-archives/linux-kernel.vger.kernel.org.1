Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE321E3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 01:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgGMXtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 19:49:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:36768 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgGMXsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:48:52 -0400
IronPort-SDR: MaIzknJHSb0YB1U4fDTTwNqs434G8/GTFv16Fc/wHCzLtT6NkGYNq/Oycz/hbp66gDmImg6+HX
 GOgaEBhf9f8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="148748425"
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="148748425"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 16:48:46 -0700
IronPort-SDR: +u5v99Qauxj+aa4U1fesuG05ebCxnQQjYZ0ob8rGZDfk8oEqaoWbzPfMN2IRNV2p3sTzpcAGn9
 3Vbp5SPlhVeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="281570466"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2020 16:48:46 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Joerg Roedel" <joro@8bytes.org>, "Ingo Molnar" <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Felix Kuehling" <Felix.Kuehling@amd.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        "amd-gfx" <amd-gfx@lists.freedesktop.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v6 10/12] x86/mmu: Allocate/free PASID
Date:   Mon, 13 Jul 2020 16:48:05 -0700
Message-Id: <1594684087-61184-11-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A PASID is allocated for an "mm" the first time any thread attaches
to an SVM capable device. Later device attachments (whether to the same
device or another SVM device) will re-use the same PASID.

The PASID is freed when the process exits (so no need to keep
reference counts on how many SVM devices are sharing the PASID).

Currently the ENQCMD feature cannot be used if CONFIG_INTEL_IOMMU_SVM
is not set. Add X86_FEATURE_ENQCMD to the disabled features mask as
appropriate and use cpu_feature_enabled() to check the feature.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
v5:
- Mark ENQCMD disabled when configured out and remove redundant
  CONFIG_INTEL_IOMMU_SVM check which is included in cpu_feature_enabled()
  in fixup_pasid_exception() (PeterZ and Dave Hansen)
- Reviewed by Lu Baolu

v4:
- Change PASID type to u32 (Christoph)

v3:
- Add sanity checks in alloc_pasid() and _free_pasid() (Baolu)
- Add a comment that the private PASID feature will be removed completely
  from IOMMU and don't track private PASID in mm (Thomas)

v2:
- Define a helper free_bind() to simplify error exit code in bind_mm()
  (Thomas)
- Fix a ret error code in bind_mm() (Thomas)
- Change pasid's type from "int" to "unsigned int" to have consistent
  pasid type in iommu (Thomas)
- Simplify alloc_pasid() a bit.

 arch/x86/include/asm/disabled-features.h |   9 +-
 arch/x86/include/asm/iommu.h             |   2 +
 arch/x86/include/asm/mmu_context.h       |  11 ++
 drivers/iommu/intel/svm.c                | 128 ++++++++++++++++++++---
 4 files changed, 137 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 4ea8584682f9..588d83e9da49 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -56,6 +56,12 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
+# define DISABLE_ENQCMD	0
+#else
+# define DISABLE_ENQCMD (1 << (X86_FEATURE_ENQCMD & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -75,7 +81,8 @@
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
-#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP)
+#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
+			 DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index bf1ed2ddc74b..ed41259fe7ac 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -26,4 +26,6 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 	return -EINVAL;
 }
 
+void __free_pasid(struct mm_struct *mm);
+
 #endif /* _ASM_X86_IOMMU_H */
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 47562147e70b..e1e7f1df6829 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -13,6 +13,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
+#include <asm/iommu.h>
 
 extern atomic64_t last_mm_ctx_id;
 
@@ -117,9 +118,19 @@ static inline int init_new_context(struct task_struct *tsk,
 	init_new_context_ldt(mm);
 	return 0;
 }
+
+static inline void free_pasid(struct mm_struct *mm)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return;
+
+	__free_pasid(mm);
+}
+
 static inline void destroy_context(struct mm_struct *mm)
 {
 	destroy_context_ldt(mm);
+	free_pasid(mm);
 }
 
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 8a0cf2f0dd54..4c788880b037 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -425,6 +425,69 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 	return ret;
 }
 
+static void free_bind(struct intel_svm *svm, struct intel_svm_dev *sdev,
+		      bool new_pasid)
+{
+	if (new_pasid)
+		ioasid_free(svm->pasid);
+	kfree(svm);
+	kfree(sdev);
+}
+
+/*
+ * If this mm already has a PASID, use it. Otherwise allocate a new one.
+ * Let the caller know if a new PASID is allocated via 'new_pasid'.
+ */
+static int alloc_pasid(struct intel_svm *svm, struct mm_struct *mm,
+		       u32 pasid_max, bool *new_pasid,
+		       unsigned int flags)
+{
+	u32 pasid;
+
+	*new_pasid = false;
+
+	/*
+	 * Reuse the PASID if the mm already has a PASID and not a private
+	 * PASID is requested.
+	 */
+	if (mm && mm->pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
+		void *p;
+
+		/*
+		 * Since the mm has a PASID already, the PASID should be
+		 * bound and unbound to the mm before calling this allocation.
+		 * So the PASID must be allocated by bind_mm() previously and
+		 * should still exist in ioasid; but its data must be cleared
+		 * already by unbind_mm().
+		 *
+		 * Do a sanity check here to ensure the PASID has the right
+		 * status before reusing it.
+		 */
+		p = ioasid_find(NULL, mm->pasid, NULL);
+		if (IS_ERR(p) || p)
+			return INVALID_IOASID;
+
+		/*
+		 * Once the PASID is allocated for this mm, it
+		 * stays with the mm until the mm is dropped. Reuse
+		 * the PASID which has been already allocated for the
+		 * mm instead of allocating a new one.
+		 */
+		ioasid_set_data(mm->pasid, svm);
+
+		return mm->pasid;
+	}
+
+	/* Allocate a new pasid. Do not use PASID 0, reserved for init PASID. */
+	pasid = ioasid_alloc(NULL, PASID_MIN, pasid_max - 1, svm);
+	if (pasid != INVALID_IOASID) {
+		/* A new pasid is allocated. */
+		*new_pasid = true;
+	}
+
+	return pasid;
+}
+
 /* Caller must hold pasid_mutex, mm reference */
 static int
 intel_svm_bind_mm(struct device *dev, unsigned int flags,
@@ -518,6 +581,8 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 	init_rcu_head(&sdev->rcu);
 
 	if (!svm) {
+		bool new_pasid;
+
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm) {
 			ret = -ENOMEM;
@@ -529,12 +594,9 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		if (pasid_max > intel_pasid_max_id)
 			pasid_max = intel_pasid_max_id;
 
-		/* Do not use PASID 0, reserved for RID to PASID */
-		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
-					  pasid_max - 1, svm);
+		svm->pasid = alloc_pasid(svm, mm, pasid_max, &new_pasid, flags);
 		if (svm->pasid == INVALID_IOASID) {
-			kfree(svm);
-			kfree(sdev);
+			free_bind(svm, sdev, new_pasid);
 			ret = -ENOSPC;
 			goto out;
 		}
@@ -547,9 +609,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				ioasid_free(svm->pasid);
-				kfree(svm);
-				kfree(sdev);
+				free_bind(svm, sdev, new_pasid);
 				goto out;
 			}
 		}
@@ -565,12 +625,20 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
-			ioasid_free(svm->pasid);
-			kfree(svm);
-			kfree(sdev);
+			free_bind(svm, sdev, new_pasid);
 			goto out;
 		}
 
+		if (mm && new_pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
+			/*
+			 * Track the new pasid in the mm. The pasid will be
+			 * freed at process exit.
+			 *
+			 * The private PASID feature will be removed soon from
+			 * IOMMU. Don't track requested private PASID in the mm.
+			 */
+			mm->pasid = svm->pasid;
+		}
 		list_add_tail(&svm->list, &global_svm_list);
 	} else {
 		/*
@@ -640,7 +708,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-				ioasid_free(svm->pasid);
+				/* Clear data in the pasid. */
+				ioasid_set_data(pasid, NULL);
 				if (svm->mm)
 					mmu_notifier_unregister(&svm->notifier, svm->mm);
 				list_del(&svm->list);
@@ -1001,3 +1070,38 @@ u32 intel_svm_get_pasid(struct iommu_sva *sva)
 
 	return pasid;
 }
+
+/*
+ * An invalid pasid is either 0 (init PASID value) or bigger than max PASID
+ * (PASID_MAX - 1).
+ */
+static bool invalid_pasid(u32 pasid)
+{
+	return (pasid == INIT_PASID) || (pasid >= PASID_MAX);
+}
+
+/* On process exit free the PASID (if one was allocated). */
+void __free_pasid(struct mm_struct *mm)
+{
+	u32 pasid = mm->pasid;
+	void *p;
+
+	/* No need to free invalid pasid. */
+	if (invalid_pasid(pasid))
+		return;
+
+	/* The pasid shouldn't be bound to any mm by now. */
+	p = ioasid_find(NULL, pasid, NULL);
+	if (!IS_ERR_OR_NULL(p)) {
+		pr_err("PASID %d is still in use\n", pasid);
+
+		return;
+	}
+
+	/*
+	 * Since the pasid is not bound to any svm, there is no race
+	 * here with binding/unbinding and no need to protect the free
+	 * operation by pasid_mutex.
+	 */
+	ioasid_free(pasid);
+}
-- 
2.19.1

