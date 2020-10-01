Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF8428089B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbgJAUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:43:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:58716 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbgJAUm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:42:57 -0400
IronPort-SDR: IbCg6aQLHVobgPGEPqxvsvyCD/sFJrdeQH2y227TYBY6XTRrtaIKPj7rs/W+9+Ca1GdBNa62N6
 DAjQc2dAAZwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170712"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170712"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:51 -0700
IronPort-SDR: +DUkE/8zJyJslT9ySukxirq1pOTg8++YPNStaFKAFvN6/mDmwk/3QHVTowWaUHvMbXid6/5AY1
 IldBB1Zc0eEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297040"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:51 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 05/22] x86/fpu/xstate: Introduce a new variable for dynamic user states
Date:   Thu,  1 Oct 2020 13:38:56 -0700
Message-Id: <20201001203913.9125-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel recently supported the dynamic supervisor states. The approach
does not save the register states at every context switch (even used), but
only when needed. It is not suitable for user states.

Introduce xfeatures_mask_user_dynamic to identify dynamic user states, and
rename these as related to the dynamic supervisor states:
	xfeatures_mask_supervisor_dynamic()
	XFEATURE_MASK_SUPERVISOR_DYNAMIC

No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/fpu/xstate.h | 12 +++++++-----
 arch/x86/kernel/fpu/xstate.c      | 29 +++++++++++++++++++----------
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 3fbf45727ad6..9aad91c0725b 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -56,7 +56,7 @@
  * - Don't set the bit corresponding to the dynamic supervisor feature in
  *   IA32_XSS at run time, since it has been set at boot time.
  */
-#define XFEATURE_MASK_DYNAMIC (XFEATURE_MASK_LBR)
+#define XFEATURE_MASK_SUPERVISOR_DYNAMIC (XFEATURE_MASK_LBR)
 
 /*
  * Unsupported supervisor features. When a supervisor feature in this mask is
@@ -66,7 +66,7 @@
 
 /* All supervisor states including supported and unsupported states. */
 #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
-				      XFEATURE_MASK_DYNAMIC | \
+				      XFEATURE_MASK_SUPERVISOR_DYNAMIC | \
 				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
 #ifdef CONFIG_X86_64
@@ -87,14 +87,16 @@ static inline u64 xfeatures_mask_user(void)
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
 
-static inline u64 xfeatures_mask_dynamic(void)
+static inline u64 xfeatures_mask_supervisor_dynamic(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_DYNAMIC & ~XFEATURE_MASK_LBR;
+		return XFEATURE_MASK_SUPERVISOR_DYNAMIC & ~XFEATURE_MASK_LBR;
 
-	return XFEATURE_MASK_DYNAMIC;
+	return XFEATURE_MASK_SUPERVISOR_DYNAMIC;
 }
 
+extern u64 xfeatures_mask_user_dynamic;
+
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 
 extern void __init update_regset_xstate_info(unsigned int size,
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index bab22766b79b..bf2b09bf9b38 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -59,6 +59,12 @@ static short xsave_cpuid_features[] __initdata = {
  */
 u64 xfeatures_mask_all __read_mostly;
 
+/*
+ * This represents user xstates, a subset of xfeatures_mask_all, saved in a
+ * dynamic kernel XSAVE buffer.
+ */
+u64 xfeatures_mask_user_dynamic __read_mostly;
+
 static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_comp_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
@@ -235,7 +241,7 @@ void fpu__init_cpu_xstate(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() |
-				     xfeatures_mask_dynamic());
+				     xfeatures_mask_supervisor_dynamic());
 	}
 }
 
@@ -682,7 +688,7 @@ static unsigned int __init get_xsaves_size(void)
  */
 static unsigned int __init get_xsaves_size_no_dynamic(void)
 {
-	u64 mask = xfeatures_mask_dynamic();
+	u64 mask = xfeatures_mask_supervisor_dynamic();
 	unsigned int size;
 
 	if (!mask)
@@ -769,6 +775,7 @@ static int __init init_xstate_size(void)
 static void fpu__init_disable_system_xstate(void)
 {
 	xfeatures_mask_all = 0;
+	xfeatures_mask_user_dynamic = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
 	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 }
@@ -835,6 +842,8 @@ void __init fpu__init_system_xstate(void)
 	}
 
 	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
+	/* Do not support the dynamically allocated area yet. */
+	xfeatures_mask_user_dynamic = 0;
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
@@ -882,7 +891,7 @@ void fpu__resume_cpu(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
-				     xfeatures_mask_dynamic());
+				     xfeatures_mask_supervisor_dynamic());
 	}
 }
 
@@ -1316,8 +1325,8 @@ void copy_supervisor_to_kernel(struct fpu *fpu)
  * @mask: Represent the dynamic supervisor features saved into the xsave area
  *
  * Only the dynamic supervisor states sets in the mask are saved into the xsave
- * area (See the comment in XFEATURE_MASK_DYNAMIC for the details of dynamic
- * supervisor feature). Besides the dynamic supervisor states, the legacy
+ * area (See the comment in XFEATURE_MASK_SUPERVISOR_DYNAMIC for the details of
+ * dynamic supervisor feature). Besides the dynamic supervisor states, the legacy
  * region and XSAVE header are also saved into the xsave area. The supervisor
  * features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
  * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not saved.
@@ -1326,7 +1335,7 @@ void copy_supervisor_to_kernel(struct fpu *fpu)
  */
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
 {
-	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
+	u64 dynamic_mask = xfeatures_mask_supervisor_dynamic() & mask;
 	u32 lmask, hmask;
 	int err;
 
@@ -1352,9 +1361,9 @@ void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
  * @mask: Represent the dynamic supervisor features restored from the xsave area
  *
  * Only the dynamic supervisor states sets in the mask are restored from the
- * xsave area (See the comment in XFEATURE_MASK_DYNAMIC for the details of
- * dynamic supervisor feature). Besides the dynamic supervisor states, the
- * legacy region and XSAVE header are also restored from the xsave area. The
+ * xsave area (See the comment in XFEATURE_MASK_SUPERVISOR_DYNAMIC for the
+ * details of dynamic supervisor feature). Besides the dynamic supervisor states,
+ * the legacy region and XSAVE header are also restored from the xsave area. The
  * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
  * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
  *
@@ -1362,7 +1371,7 @@ void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
  */
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask)
 {
-	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
+	u64 dynamic_mask = xfeatures_mask_supervisor_dynamic() & mask;
 	u32 lmask, hmask;
 	int err;
 
-- 
2.17.1

