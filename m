Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0381E280892
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgJAUm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:42:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:58718 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbgJAUmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:42:53 -0400
IronPort-SDR: GVX9BPZYfltfSKUTjYC81oQ95GwuPm3lP0ee8BA0fB9dOc0UPWIAEbdZPC0D1T+mDoOOQThrhG
 ozhm8Ewui/yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170703"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170703"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:51 -0700
IronPort-SDR: hA2ui/CMNYQtO43dUEb6zOgyLUrFm2RwmEgCDUnXj5fKil44RoGN/pwHMOIUQTftBI1jaA5zVc
 6/UT2LwN1UZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297028"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:51 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 02/22] x86/fpu/xstate: Modify xstate copy helper prototypes to access all the possible areas
Date:   Thu,  1 Oct 2020 13:38:53 -0700
Message-Id: <20201001203913.9125-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xstate infrastructure is not flexible to support dynamic areas in
task->fpu. Make the xstate copy functions to access task->fpu directly.

No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/fpu/xstate.h |  8 ++++----
 arch/x86/kernel/fpu/regset.c      |  6 +++---
 arch/x86/kernel/fpu/signal.c      | 17 ++++++++---------
 arch/x86/kernel/fpu/xstate.c      | 19 +++++++++++++++----
 4 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 14ab815132d4..a315b055212f 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -105,10 +105,10 @@ const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
 struct membuf;
-void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave);
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
-void copy_supervisor_to_kernel(struct xregs_state *xsave);
+void copy_xstate_to_kernel(struct membuf to, struct fpu *fpu);
+int copy_kernel_to_xstate(struct fpu *fpu, const void *kbuf);
+int copy_user_to_xstate(struct fpu *fpu, const void __user *ubuf);
+void copy_supervisor_to_kernel(struct fpu *fpu);
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
 
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 4c4d9059ff36..5e13e58d11d4 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -85,7 +85,7 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 	fpu__prepare_read(fpu);
 
 	if (using_compacted_format()) {
-		copy_xstate_to_kernel(to, xsave);
+		copy_xstate_to_kernel(to, fpu);
 		return 0;
 	} else {
 		fpstate_sanitize_xstate(fpu);
@@ -126,9 +126,9 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 
 	if (using_compacted_format()) {
 		if (kbuf)
-			ret = copy_kernel_to_xstate(xsave, kbuf);
+			ret = copy_kernel_to_xstate(fpu, kbuf);
 		else
-			ret = copy_user_to_xstate(xsave, ubuf);
+			ret = copy_user_to_xstate(fpu, ubuf);
 	} else {
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, xsave, 0, -1);
 		if (!ret)
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 9f009525f551..adbf63114bc2 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -212,11 +212,11 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 }
 
 static inline void
-sanitize_restored_user_xstate(union fpregs_state *state,
+sanitize_restored_user_xstate(struct fpu *fpu,
 			      struct user_i387_ia32_struct *ia32_env,
 			      u64 user_xfeatures, int fx_only)
 {
-	struct xregs_state *xsave = &state->xsave;
+	struct xregs_state *xsave = &fpu->state.xsave;
 	struct xstate_header *header = &xsave->header;
 
 	if (use_xsave()) {
@@ -253,7 +253,7 @@ sanitize_restored_user_xstate(union fpregs_state *state,
 		xsave->i387.mxcsr &= mxcsr_feature_mask;
 
 		if (ia32_env)
-			convert_to_fxsr(&state->fxsave, ia32_env);
+			convert_to_fxsr(&fpu->state.fxsave, ia32_env);
 	}
 }
 
@@ -396,7 +396,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		 * current supervisor states first and invalidate the FPU regs.
 		 */
 		if (xfeatures_mask_supervisor())
-			copy_supervisor_to_kernel(&fpu->state.xsave);
+			copy_supervisor_to_kernel(fpu);
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__fpu_invalidate_fpregs_state(fpu);
@@ -406,18 +406,18 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
 
 		if (using_compacted_format()) {
-			ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
+			ret = copy_user_to_xstate(fpu, buf_fx);
 		} else {
 			ret = __copy_from_user(&fpu->state.xsave, buf_fx, state_size);
 
 			if (!ret && state_size > offsetof(struct xregs_state, header))
 				ret = validate_user_xstate_header(&fpu->state.xsave.header);
+
 		}
 		if (ret)
 			goto err_out;
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
-					      fx_only);
+		sanitize_restored_user_xstate(fpu, envp, user_xfeatures, fx_only);
 
 		fpregs_lock();
 		if (unlikely(init_bv))
@@ -437,8 +437,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			goto err_out;
 		}
 
-		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
-					      fx_only);
+		sanitize_restored_user_xstate(fpu, envp, user_xfeatures, fx_only);
 
 		fpregs_lock();
 		if (use_xsave()) {
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index ee4946c60ab1..e3a9bddc39d9 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1067,14 +1067,17 @@ static void copy_part(struct membuf *to, unsigned *last, unsigned offset,
  * It supports partial copy but pos always starts from zero. This is called
  * from xstateregs_get() and there we check the CPU has XSAVES.
  */
-void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
+void copy_xstate_to_kernel(struct membuf to, struct fpu *fpu)
 {
 	struct xstate_header header;
 	const unsigned off_mxcsr = offsetof(struct fxregs_state, mxcsr);
+	struct xregs_state *xsave;
 	unsigned size = to.left;
 	unsigned last = 0;
 	int i;
 
+	xsave = &fpu->state.xsave;
+
 	/*
 	 * The destination is a ptrace buffer; we put in only user xstates:
 	 */
@@ -1123,8 +1126,9 @@ void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
  * Convert from a ptrace standard-format kernel buffer to kernel XSAVES format
  * and copy to the target thread. This is called from xstateregs_set().
  */
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+int copy_kernel_to_xstate(struct fpu *fpu, const void *kbuf)
 {
+	struct xregs_state *xsave;
 	unsigned int offset, size;
 	int i;
 	struct xstate_header hdr;
@@ -1137,6 +1141,8 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
+	xsave = &fpu->state.xsave;
+
 	for (i = 0; i < XFEATURE_MAX; i++) {
 		u64 mask = ((u64)1 << i);
 
@@ -1176,8 +1182,9 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
  * xstateregs_set(), as well as potentially from the sigreturn() and
  * rt_sigreturn() system calls.
  */
-int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
+int copy_user_to_xstate(struct fpu *fpu, const void __user *ubuf)
 {
+	struct xregs_state *xsave;
 	unsigned int offset, size;
 	int i;
 	struct xstate_header hdr;
@@ -1191,6 +1198,8 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
+	xsave = &fpu->state.xsave;
+
 	for (i = 0; i < XFEATURE_MAX; i++) {
 		u64 mask = ((u64)1 << i);
 
@@ -1231,9 +1240,10 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
  * old states, and is intended to be used only in __fpu__restore_sig(), where
  * user states are restored from the user buffer.
  */
-void copy_supervisor_to_kernel(struct xregs_state *xstate)
+void copy_supervisor_to_kernel(struct fpu *fpu)
 {
 	struct xstate_header *header;
+	struct xregs_state *xstate;
 	u64 max_bit, min_bit;
 	u32 lmask, hmask;
 	int err, i;
@@ -1247,6 +1257,7 @@ void copy_supervisor_to_kernel(struct xregs_state *xstate)
 	max_bit = __fls(xfeatures_mask_supervisor());
 	min_bit = __ffs(xfeatures_mask_supervisor());
 
+	xstate = &fpu->state.xsave;
 	lmask = xfeatures_mask_supervisor();
 	hmask = xfeatures_mask_supervisor() >> 32;
 	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
-- 
2.17.1

