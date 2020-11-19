Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E132B9E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgKSXhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:37:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:49074 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgKSXhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:37:04 -0500
IronPort-SDR: z3ELu92UANKFKOFYiSfEAksyXZJ61TJaAjkNRr2Ylgt4x+SAjmmp1MCy0Jxw+rRDrx1fxCT75X
 +7dz2DmENLuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="235531201"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="235531201"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 15:37:02 -0800
IronPort-SDR: mK3lWHt7PJJF9NPTGdXTnSmNnH+tTUkLZB6K1Wau7MY95CsMYVvUHCsQdfkdCNr+C0bKlpQE7A
 gh31QLfByb+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="431392218"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 15:37:02 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v2 09/22] x86/fpu/xstate: Introduce wrapper functions for organizing xstate area access
Date:   Thu, 19 Nov 2020 15:32:44 -0800
Message-Id: <20201119233257.2939-10-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119233257.2939-1-chang.seok.bae@intel.com>
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task->fpu now has two possible xstate areas, fpu->state or fpu->state_ptr.
Instead of open code for accessing one of the two areas, rearrange them to
use a new wrapper.

Some open code (e.g., in KVM) is left unchanged as not going to use
fpu->state_ptr at the moment.

No functional change until the kernel supports dynamic user states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/fpu/internal.h | 10 ++++++----
 arch/x86/include/asm/fpu/xstate.h   | 10 ++++++++++
 arch/x86/include/asm/trace/fpu.h    |  6 ++++--
 arch/x86/kernel/fpu/core.c          | 27 ++++++++++++++++-----------
 arch/x86/kernel/fpu/regset.c        | 28 +++++++++++++++++-----------
 arch/x86/kernel/fpu/signal.c        | 23 +++++++++++++----------
 arch/x86/kernel/fpu/xstate.c        | 20 +++++++++++---------
 7 files changed, 77 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 66ed1f88191c..3201468ff4aa 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -210,10 +210,12 @@ static inline int copy_user_to_fregs(struct fregs_state __user *fx)
 
 static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 {
+	union fpregs_state *xstate = __xstate(fpu);
+
 	if (IS_ENABLED(CONFIG_X86_32))
-		asm volatile( "fxsave %[fx]" : [fx] "=m" (fpu->state.fxsave));
+		asm volatile("fxsave %[fx]" : [fx] "=m" (xstate->fxsave));
 	else
-		asm volatile("fxsaveq %[fx]" : [fx] "=m" (fpu->state.fxsave));
+		asm volatile("fxsaveq %[fx]" : [fx] "=m" (xstate->fxsave));
 }
 
 /* These macros all use (%edi)/(%rdi) as the single memory argument. */
@@ -411,7 +413,7 @@ static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
  */
 static inline int copy_kernel_to_xregs_err(struct fpu *fpu, u64 mask)
 {
-	struct xregs_state *xstate = &fpu->state.xsave;
+	struct xregs_state *xstate = __xsave(fpu);
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
@@ -440,7 +442,7 @@ static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask
 
 static inline void copy_kernel_to_fpregs(struct fpu *fpu)
 {
-	union fpregs_state *fpstate = &fpu->state;
+	union fpregs_state *fpstate = __xstate(fpu);
 
 	/*
 	 * AMD K7/K8 CPUs don't save/restore FDP/FIP/FOP unless an exception is
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 9183e2cdffe3..cc159bc9386d 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -102,6 +102,16 @@ extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
+static inline union fpregs_state *__xstate(struct fpu *fpu)
+{
+	return (fpu->state_ptr) ? fpu->state_ptr : &fpu->state;
+}
+
+static inline struct xregs_state *__xsave(struct fpu *fpu)
+{
+	return &__xstate(fpu)->xsave;
+}
+
 void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
 unsigned int get_xstate_size(u64 mask);
 int alloc_xstate_area(struct fpu *fpu, u64 mask, unsigned int *alloc_size);
diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
index bf88b3333873..4b21c34436f9 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -22,8 +22,10 @@ DECLARE_EVENT_CLASS(x86_fpu,
 		__entry->fpu		= fpu;
 		__entry->load_fpu	= test_thread_flag(TIF_NEED_FPU_LOAD);
 		if (boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-			__entry->xfeatures = fpu->state.xsave.header.xfeatures;
-			__entry->xcomp_bv  = fpu->state.xsave.header.xcomp_bv;
+			struct xregs_state *xsave = __xsave(fpu);
+
+			__entry->xfeatures = xsave->header.xfeatures;
+			__entry->xcomp_bv  = xsave->header.xcomp_bv;
 		}
 	),
 	TP_printk("x86/fpu: %p load: %d xfeatures: %llx xcomp_bv: %llx",
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 33956ae3de2b..dca4961fcc36 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -94,14 +94,18 @@ EXPORT_SYMBOL(irq_fpu_usable);
  */
 int copy_fpregs_to_fpstate(struct fpu *fpu)
 {
+	union fpregs_state *xstate = __xstate(fpu);
+
 	if (likely(use_xsave())) {
-		copy_xregs_to_kernel(&fpu->state.xsave);
+		struct xregs_state *xsave = &xstate->xsave;
+
+		copy_xregs_to_kernel(xsave);
 
 		/*
 		 * AVX512 state is tracked here because its use is
 		 * known to slow the max clock speed of the core.
 		 */
-		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
+		if (xsave->header.xfeatures & XFEATURE_MASK_AVX512)
 			fpu->avx512_timestamp = jiffies;
 		return 1;
 	}
@@ -115,7 +119,7 @@ int copy_fpregs_to_fpstate(struct fpu *fpu)
 	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
 	 * so we have to mark them inactive:
 	 */
-	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
+	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (xstate->fsave));
 
 	return 0;
 }
@@ -197,7 +201,7 @@ void fpstate_init(struct fpu *fpu)
 	union fpregs_state *state;
 
 	if (fpu)
-		state = &fpu->state;
+		state = __xstate(fpu);
 	else
 		state = &init_fpstate;
 
@@ -248,7 +252,7 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
 	 */
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_default_size);
+		memcpy(__xstate(dst_fpu), __xstate(src_fpu), fpu_kernel_xstate_default_size);
 
 	else if (!copy_fpregs_to_fpstate(dst_fpu))
 		copy_kernel_to_fpregs(dst_fpu);
@@ -384,7 +388,7 @@ static void fpu__clear(struct fpu *fpu, bool user_only)
 	if (user_only) {
 		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
 		    xfeatures_mask_supervisor())
-			copy_kernel_to_xregs(&fpu->state.xsave,
+			copy_kernel_to_xregs(__xsave(fpu),
 					     xfeatures_mask_supervisor());
 		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
 	} else {
@@ -451,6 +455,7 @@ EXPORT_SYMBOL_GPL(fpregs_mark_activate);
 
 int fpu__exception_code(struct fpu *fpu, int trap_nr)
 {
+	union fpregs_state *xstate = __xstate(fpu);
 	int err;
 
 	if (trap_nr == X86_TRAP_MF) {
@@ -466,11 +471,11 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
 		 * fully reproduce the context of the exception.
 		 */
 		if (boot_cpu_has(X86_FEATURE_FXSR)) {
-			cwd = fpu->state.fxsave.cwd;
-			swd = fpu->state.fxsave.swd;
+			cwd = xstate->fxsave.cwd;
+			swd = xstate->fxsave.swd;
 		} else {
-			cwd = (unsigned short)fpu->state.fsave.cwd;
-			swd = (unsigned short)fpu->state.fsave.swd;
+			cwd = (unsigned short)xstate->fsave.cwd;
+			swd = (unsigned short)xstate->fsave.swd;
 		}
 
 		err = swd & ~cwd;
@@ -484,7 +489,7 @@ int fpu__exception_code(struct fpu *fpu, int trap_nr)
 		unsigned short mxcsr = MXCSR_DEFAULT;
 
 		if (boot_cpu_has(X86_FEATURE_XMM))
-			mxcsr = fpu->state.fxsave.mxcsr;
+			mxcsr = xstate->fxsave.mxcsr;
 
 		err = ~(mxcsr >> 7) & mxcsr;
 	}
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 5e13e58d11d4..8d863240b9c6 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -37,7 +37,7 @@ int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 	fpu__prepare_read(fpu);
 	fpstate_sanitize_xstate(fpu);
 
-	return membuf_write(&to, &fpu->state.fxsave, sizeof(struct fxregs_state));
+	return membuf_write(&to, &__xstate(fpu)->fxsave, sizeof(struct fxregs_state));
 }
 
 int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
@@ -45,6 +45,7 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 		const void *kbuf, const void __user *ubuf)
 {
 	struct fpu *fpu = &target->thread.fpu;
+	union fpregs_state *xstate;
 	int ret;
 
 	if (!boot_cpu_has(X86_FEATURE_FXSR))
@@ -53,20 +54,22 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 	fpu__prepare_write(fpu);
 	fpstate_sanitize_xstate(fpu);
 
+	xstate = __xstate(fpu);
+
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 &fpu->state.fxsave, 0, -1);
+				 &xstate->fxsave, 0, -1);
 
 	/*
 	 * mxcsr reserved bits must be masked to zero for security reasons.
 	 */
-	fpu->state.fxsave.mxcsr &= mxcsr_feature_mask;
+	xstate->fxsave.mxcsr &= mxcsr_feature_mask;
 
 	/*
 	 * update the header bits in the xsave header, indicating the
 	 * presence of FP and SSE state.
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVE))
-		fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
+		xstate->xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
 
 	return ret;
 }
@@ -80,7 +83,7 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	xsave = &fpu->state.xsave;
+	xsave = __xsave(fpu);
 
 	fpu__prepare_read(fpu);
 
@@ -120,7 +123,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	if ((pos != 0) || (count < fpu_user_xstate_size))
 		return -EFAULT;
 
-	xsave = &fpu->state.xsave;
+	xsave = __xsave(fpu);
 
 	fpu__prepare_write(fpu);
 
@@ -224,7 +227,7 @@ static inline u32 twd_fxsr_to_i387(struct fxregs_state *fxsave)
 void
 convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
 {
-	struct fxregs_state *fxsave = &tsk->thread.fpu.state.fxsave;
+	struct fxregs_state *fxsave = &__xstate(&tsk->thread.fpu)->fxsave;
 	struct _fpreg *to = (struct _fpreg *) &env->st_space[0];
 	struct _fpxreg *from = (struct _fpxreg *) &fxsave->st_space[0];
 	int i;
@@ -297,7 +300,7 @@ int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 		return fpregs_soft_get(target, regset, to);
 
 	if (!boot_cpu_has(X86_FEATURE_FXSR)) {
-		return membuf_write(&to, &fpu->state.fsave,
+		return membuf_write(&to, &__xstate(fpu)->fsave,
 				    sizeof(struct fregs_state));
 	}
 
@@ -318,6 +321,7 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 {
 	struct fpu *fpu = &target->thread.fpu;
 	struct user_i387_ia32_struct env;
+	union fpregs_state *xstate;
 	int ret;
 
 	fpu__prepare_write(fpu);
@@ -326,9 +330,11 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 	if (!boot_cpu_has(X86_FEATURE_FPU))
 		return fpregs_soft_set(target, regset, pos, count, kbuf, ubuf);
 
+	xstate = __xstate(fpu);
+
 	if (!boot_cpu_has(X86_FEATURE_FXSR))
 		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-					  &fpu->state.fsave, 0,
+					  &xstate->fsave, 0,
 					  -1);
 
 	if (pos > 0 || count < sizeof(env))
@@ -336,14 +342,14 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &env, 0, -1);
 	if (!ret)
-		convert_to_fxsr(&target->thread.fpu.state.fxsave, &env);
+		convert_to_fxsr(&__xstate(&target->thread.fpu)->fxsave, &env);
 
 	/*
 	 * update the header bit in the xsave header, indicating the
 	 * presence of FP.
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVE))
-		fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FP;
+		xstate->xsave.header.xfeatures |= XFEATURE_MASK_FP;
 	return ret;
 }
 
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 09c836d94684..7857d38e86a9 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -58,7 +58,7 @@ static inline int check_for_xstate(struct fxregs_state __user *buf,
 static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
 {
 	if (use_fxsr()) {
-		struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
+		struct xregs_state *xsave = __xsave(&tsk->thread.fpu);
 		struct user_i387_ia32_struct env;
 		struct _fpstate_32 __user *fp = buf;
 
@@ -152,8 +152,8 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  *
  * Try to save it directly to the user frame with disabled page fault handler.
  * If this fails then do the slow path where the FPU state is first saved to
- * task's fpu->state and then copy it to the user frame pointed to by the
- * aligned pointer 'buf_fx'.
+ * task->fpu and then copy it to the user frame pointed to by the aligned
+ * pointer 'buf_fx'.
  *
  * If this is a 32-bit frame with fxstate, put a fsave header before
  * the aligned state at 'buf_fx'.
@@ -216,7 +216,7 @@ sanitize_restored_user_xstate(struct fpu *fpu,
 			      struct user_i387_ia32_struct *ia32_env,
 			      u64 user_xfeatures, int fx_only)
 {
-	struct xregs_state *xsave = &fpu->state.xsave;
+	struct xregs_state *xsave = __xsave(fpu);
 	struct xstate_header *header = &xsave->header;
 
 	if (use_xsave()) {
@@ -253,7 +253,7 @@ sanitize_restored_user_xstate(struct fpu *fpu,
 		xsave->i387.mxcsr &= mxcsr_feature_mask;
 
 		if (ia32_env)
-			convert_to_fxsr(&fpu->state.fxsave, ia32_env);
+			convert_to_fxsr(&__xstate(fpu)->fxsave, ia32_env);
 	}
 }
 
@@ -295,6 +295,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
+	union fpregs_state *xstate;
 	u64 user_xfeatures = 0;
 	int fx_only = 0;
 	int ret = 0;
@@ -335,6 +336,8 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	if ((unsigned long)buf_fx % 64)
 		fx_only = 1;
 
+	xstate = __xstate(fpu);
+
 	if (!ia32_fxstate) {
 		/*
 		 * Attempt to restore the FPU registers directly from user
@@ -363,7 +366,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			 */
 			if (test_thread_flag(TIF_NEED_FPU_LOAD) &&
 			    xfeatures_mask_supervisor())
-				copy_kernel_to_xregs(&fpu->state.xsave,
+				copy_kernel_to_xregs(&xstate->xsave,
 						     xfeatures_mask_supervisor());
 			fpregs_mark_activate();
 			fpregs_unlock();
@@ -430,7 +433,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		ret = copy_kernel_to_xregs_err(fpu, user_xfeatures | xfeatures_mask_supervisor());
 
 	} else if (use_fxsr()) {
-		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
+		ret = __copy_from_user(&xstate->fxsave, buf_fx, state_size);
 		if (ret) {
 			ret = -EFAULT;
 			goto err_out;
@@ -446,14 +449,14 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 		}
 
-		ret = copy_kernel_to_fxregs_err(&fpu->state.fxsave);
+		ret = copy_kernel_to_fxregs_err(&xstate->fxsave);
 	} else {
-		ret = __copy_from_user(&fpu->state.fsave, buf_fx, state_size);
+		ret = __copy_from_user(&xstate->fsave, buf_fx, state_size);
 		if (ret)
 			goto err_out;
 
 		fpregs_lock();
-		ret = copy_kernel_to_fregs_err(&fpu->state.fsave);
+		ret = copy_kernel_to_fregs_err(&xstate->fsave);
 	}
 	if (!ret)
 		fpregs_mark_activate();
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 8f10c7badeba..f8884dcdcc7c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -192,14 +192,16 @@ unsigned int get_xstate_size(u64 mask)
  */
 void fpstate_sanitize_xstate(struct fpu *fpu)
 {
-	struct fxregs_state *fx = &fpu->state.fxsave;
+	union fpregs_state *xstate = __xstate(fpu);
+	struct xregs_state *xsave = &xstate->xsave;
+	struct fxregs_state *fx = &xstate->fxsave;
 	int feature_bit;
 	u64 xfeatures;
 
 	if (!use_xsaveopt())
 		return;
 
-	xfeatures = fpu->state.xsave.header.xfeatures;
+	xfeatures = xsave->header.xfeatures;
 
 	/*
 	 * None of the feature bits are in init state. So nothing else
@@ -244,7 +246,7 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 			int offset = xstate_comp_offsets[feature_bit];
 			int size = xstate_sizes[feature_bit];
 
-			memcpy((void *)fx + offset,
+			memcpy((void *)xsave + offset,
 			       (void *)&init_fpstate.xsave + offset,
 			       size);
 		}
@@ -995,7 +997,7 @@ static void *__raw_xsave_addr(struct fpu *fpu, int xfeature_nr)
 	}
 
 	if (fpu)
-		xsave = &fpu->state.xsave;
+		xsave = __xsave(fpu);
 	else
 		xsave = &init_fpstate.xsave;
 
@@ -1039,7 +1041,7 @@ void *get_xsave_addr(struct fpu *fpu, int xfeature_nr)
 		  "get of unsupported state");
 
 	if (fpu)
-		xsave = &fpu->state.xsave;
+		xsave = __xsave(fpu);
 	else
 		xsave = &init_fpstate.xsave;
 
@@ -1243,7 +1245,7 @@ void copy_xstate_to_kernel(struct membuf to, struct fpu *fpu)
 	unsigned last = 0;
 	int i;
 
-	xsave = &fpu->state.xsave;
+	xsave = __xsave(fpu);
 
 	/*
 	 * The destination is a ptrace buffer; we put in only user xstates:
@@ -1321,7 +1323,7 @@ int copy_kernel_to_xstate(struct fpu *fpu, const void *kbuf)
 		}
 	}
 
-	xsave = &fpu->state.xsave;
+	xsave = __xsave(fpu);
 
 	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
 		offset = offsetof(struct fxregs_state, mxcsr);
@@ -1379,7 +1381,7 @@ int copy_user_to_xstate(struct fpu *fpu, const void __user *ubuf)
 		}
 	}
 
-	xsave = &fpu->state.xsave;
+	xsave = __xsave(fpu);
 
 	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
 		offset = offsetof(struct fxregs_state, mxcsr);
@@ -1424,7 +1426,7 @@ void copy_supervisor_to_kernel(struct fpu *fpu)
 	max_bit = __fls(xfeatures_mask_supervisor());
 	min_bit = __ffs(xfeatures_mask_supervisor());
 
-	xstate = &fpu->state.xsave;
+	xstate = __xsave(fpu);
 	lmask = xfeatures_mask_supervisor();
 	hmask = xfeatures_mask_supervisor() >> 32;
 	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
-- 
2.17.1

