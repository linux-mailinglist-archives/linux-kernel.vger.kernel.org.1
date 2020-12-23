Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DF42E1F25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgLWQDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:03:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:1634 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgLWQDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:03:03 -0500
IronPort-SDR: icNMMbUsgyZxBeaeIr7zZ5avSyRE65LIp773JrB2fxlbJbMXF211R5XW8ZjmweknuGLmSeGa86
 6erXLyciXGjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="194483189"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="194483189"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 08:01:40 -0800
IronPort-SDR: U55u0IZCmVU4lqg8HKOasplSWFyK5T6bvsjufI3FqErTP1PxLRgXo1x53AsB6JVMxiLJAZckCp
 YyH0o7fze32w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="458027997"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2020 08:01:40 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v3 13/21] x86/fpu/xstate: Expand dynamic context switch buffer on first use
Date:   Wed, 23 Dec 2020 07:57:09 -0800
Message-Id: <20201223155717.19556-14-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223155717.19556-1-chang.seok.bae@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's Extended Feature Disable (XFD) feature is an extension of the XSAVE
architecture. XFD allows the kernel to enable a feature state in XCR0 and
to receive a #NM trap when a task uses instructions accessing that state.
In this way, Linux can defer allocating the large XSAVE buffer until tasks
need it.

XFD introduces two MSRs: IA32_XFD to enable/disable the feature and
IA32_XFD_ERR to assist the #NM trap handler. Both use the same
state-component bitmap format, used by XCR0.

Use this hardware capability to find the right time to expand the xstate
buffer. Introduce two sets of helper functions for that:

1. The first set is primarily for interacting with the XFD hardware:
	xdisable_setbits()
	xdisable_getbits()
	xdisable_switch()

2. The second set is for managing the first-use status and handling #NM
   trap:
	xfirstuse_enabled()
	xfirstuse_not_detected()

The #NM handler induces the xstate buffer expansion to save the first-used
states.

If the standard (uncompacted) format is used in the kernel, the XSAVE
buffer has the maximum size already, and so XFD is not needed. The XFD
feature is enabled only when the compacted format is in use.

No functional change until the kernel enables dynamic user states and XFD.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Changed to enable XFD only when the compacted format is used.
* Updated the changelog with task->fpu removed. (Boris Petkov)

Changes from v1:
* Inlined the XFD-induced #NM handling code (Andy Lutomirski)
---
 arch/x86/include/asm/cpufeatures.h  |  1 +
 arch/x86/include/asm/fpu/internal.h | 51 ++++++++++++++++++++++++++++-
 arch/x86/include/asm/msr-index.h    |  2 ++
 arch/x86/kernel/cpu/cpuid-deps.c    |  1 +
 arch/x86/kernel/fpu/xstate.c        | 37 +++++++++++++++++++--
 arch/x86/kernel/process.c           |  5 +++
 arch/x86/kernel/process_32.c        |  2 +-
 arch/x86/kernel/process_64.c        |  2 +-
 arch/x86/kernel/traps.c             | 40 ++++++++++++++++++++++
 9 files changed, 135 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dad350d42ecf..5b6496ee3703 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -275,6 +275,7 @@
 #define X86_FEATURE_XSAVEC		(10*32+ 1) /* XSAVEC instruction */
 #define X86_FEATURE_XGETBV1		(10*32+ 2) /* XGETBV with ECX = 1 instruction */
 #define X86_FEATURE_XSAVES		(10*32+ 3) /* XSAVES/XRSTORS instructions */
+#define X86_FEATURE_XFD			(10*32+ 4) /* eXtended Feature Disabling */
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index d409a6ae0c38..5eba9a466249 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -573,11 +573,58 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  * Misc helper functions:
  */
 
+/* The first-use detection helpers: */
+
+static inline void xdisable_setbits(u64 value)
+{
+	wrmsrl_safe(MSR_IA32_XFD, value);
+}
+
+static inline u64 xdisable_getbits(void)
+{
+	u64 value;
+
+	rdmsrl_safe(MSR_IA32_XFD, &value);
+	return value;
+}
+
+static inline u64 xfirstuse_enabled(void)
+{
+	/* All the dynamic user components are first-use enabled. */
+	return xfeatures_mask_user_dynamic;
+}
+
+/*
+ * Convert fpu->firstuse_bv to xdisable configuration in MSR IA32_XFD.
+ * xdisable_setbits() only uses this.
+ */
+static inline u64 xfirstuse_not_detected(struct fpu *fpu)
+{
+	u64 firstuse_bv = (fpu->state_mask & xfirstuse_enabled());
+
+	/*
+	 * If first-use is not detected, set the bit. If the detection is
+	 * not enabled, the bit is always zero in firstuse_bv. So, make
+	 * following conversion:
+	 */
+	return  (xfirstuse_enabled() ^ firstuse_bv);
+}
+
+/* Update MSR IA32_XFD based on fpu->firstuse_bv */
+static inline void xdisable_switch(struct fpu *prev, struct fpu *next)
+{
+	if (!static_cpu_has(X86_FEATURE_XFD) || !xfirstuse_enabled())
+		return;
+
+	if (unlikely(prev->state_mask != next->state_mask))
+		xdisable_setbits(xfirstuse_not_detected(next));
+}
+
 /*
  * Load PKRU from the FPU context if available. Delay loading of the
  * complete FPU state until the return to userland.
  */
-static inline void switch_fpu_finish(struct fpu *new_fpu)
+static inline void switch_fpu_finish(struct fpu *old_fpu, struct fpu *new_fpu)
 {
 	u32 pkru_val = init_pkru_value;
 	struct pkru_state *pk;
@@ -587,6 +634,8 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 
 	set_thread_flag(TIF_NEED_FPU_LOAD);
 
+	xdisable_switch(old_fpu, new_fpu);
+
 	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return;
 
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 972a34d93505..f8b5f9b3c845 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -617,6 +617,8 @@
 #define MSR_IA32_BNDCFGS_RSVD		0x00000ffc
 
 #define MSR_IA32_XSS			0x00000da0
+#define MSR_IA32_XFD			0x000001c4
+#define MSR_IA32_XFD_ERR		0x000001c5
 
 #define MSR_IA32_APICBASE		0x0000001b
 #define MSR_IA32_APICBASE_BSP		(1<<8)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index d502241995a3..a9e8e160ae30 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -71,6 +71,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
+	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
 	{}
 };
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 1d7d0cce6cc5..592e67ff6fa7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -133,6 +133,21 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
+static bool xfeature_disable_supported(int xfeature_nr)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (!boot_cpu_has(X86_FEATURE_XFD))
+		return false;
+
+	/*
+	 * If state component 'i' supports xfeature disable (first-use
+	 * detection), ECX[2] return 1; otherwise, 0.
+	 */
+	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
+	return ecx & 4;
+}
+
 /*
  * Available once those arrays for the offset, size, and alignment info are set up,
  * by setup_xstate_features().
@@ -316,6 +331,9 @@ void fpu__init_cpu_xstate(void)
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() |
 				     xfeatures_mask_supervisor_dynamic());
 	}
+
+	if (boot_cpu_has(X86_FEATURE_XFD))
+		xdisable_setbits(xfirstuse_enabled());
 }
 
 static bool xfeature_enabled(enum xfeature xfeature)
@@ -515,8 +533,9 @@ static void __init print_xstate_offset_size(void)
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		if (!xfeature_enabled(i))
 			continue;
-		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d\n",
-			 i, xstate_comp_offsets[i], i, xstate_sizes[i]);
+		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d (%s)\n",
+			i, xstate_comp_offsets[i], i, xstate_sizes[i],
+			(xfeatures_mask_user_dynamic & BIT_ULL(i)) ? "on-demand" : "default");
 	}
 }
 
@@ -945,9 +964,18 @@ void __init fpu__init_system_xstate(void)
 	}
 
 	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
-	/* Do not support the dynamically allocated buffer yet. */
 	xfeatures_mask_user_dynamic = 0;
 
+	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+		u64 feature_mask = BIT_ULL(i);
+
+		if (!(xfeatures_mask_user() & feature_mask))
+			continue;
+
+		if (xfeature_disable_supported(i))
+			xfeatures_mask_user_dynamic |= feature_mask;
+	}
+
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
 	err = init_xstate_size();
@@ -999,6 +1027,9 @@ void fpu__resume_cpu(void)
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
 				     xfeatures_mask_supervisor_dynamic());
 	}
+
+	if (boot_cpu_has(X86_FEATURE_XFD))
+		xdisable_setbits(xfirstuse_not_detected(&current->thread.fpu));
 }
 
 /*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 326b16aefb06..3c335870051c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -102,6 +102,11 @@ void arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
 	*size = fpu_kernel_xstate_min_size;
 }
 
+void arch_release_task_struct(struct task_struct *tsk)
+{
+	free_xstate_buffer(&tsk->thread.fpu);
+}
+
 /*
  * Free thread data structures etc..
  */
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4f2f54e1281c..7bd5d08eeb41 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -213,7 +213,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	this_cpu_write(current_task, next_p);
 
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish(prev_fpu, next_fpu);
 
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in();
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index df342bedea88..4f3bef245863 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -595,7 +595,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(current_task, next_p);
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
-	switch_fpu_finish(next_fpu);
+	switch_fpu_finish(prev_fpu, next_fpu);
 
 	/* Reload sp0. */
 	update_task_stack(next_p);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e19df6cde35d..5dca7e70794f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1094,10 +1094,50 @@ DEFINE_IDTENTRY(exc_spurious_interrupt_bug)
 	 */
 }
 
+static __always_inline bool handle_xfirstuse_event(struct fpu *fpu)
+{
+	bool handled = false;
+	u64 event_mask;
+
+	/* Check whether the first-use detection is running. */
+	if (!static_cpu_has(X86_FEATURE_XFD) || !xfirstuse_enabled())
+		return handled;
+
+	rdmsrl_safe(MSR_IA32_XFD_ERR, &event_mask);
+
+	/* The trap event should happen to one of first-use enabled features */
+	WARN_ON(!(event_mask & xfirstuse_enabled()));
+
+	/* If IA32_XFD_ERR is empty, the current trap has nothing to do with. */
+	if (!event_mask)
+		return handled;
+
+	/*
+	 * The first-use event is presumed to be from userspace, so it should have
+	 * nothing to do with interrupt context.
+	 */
+	if (WARN_ON(in_interrupt()))
+		return handled;
+
+	if (alloc_xstate_buffer(fpu, event_mask))
+		return handled;
+
+	xdisable_setbits(xfirstuse_not_detected(fpu));
+
+	/* Clear the trap record. */
+	wrmsrl_safe(MSR_IA32_XFD_ERR, 0);
+	handled = true;
+
+	return handled;
+}
+
 DEFINE_IDTENTRY(exc_device_not_available)
 {
 	unsigned long cr0 = read_cr0();
 
+	if (handle_xfirstuse_event(&current->thread.fpu))
+		return;
+
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
 		struct math_emu_info info = { };
-- 
2.17.1

