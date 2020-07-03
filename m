Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE4213A5C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 14:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGCMyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 08:54:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:25746 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgGCMxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:50 -0400
IronPort-SDR: 5SGHXZZA9haiSBfiZXqlPPCKIDlt25VSim/EYJG4uIDWxFJ7rPIXjJ53xMLTmvk59IJO0MUoMh
 XiArHebU5C+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598404"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598404"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:48 -0700
IronPort-SDR: jpdY2RhZ/t8wfR+pY/XQW+it+xdfPxkRocmk6EQr4BU8Oi/HZApB7aWIUvfhenkwA2U+tDiwvX
 kX4zIEg0tpiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265964045"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:48 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 19/23] x86/fpu: Use proper mask to replace full instruction mask
Date:   Fri,  3 Jul 2020 05:49:25 -0700
Message-Id: <1593780569-62993-20-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

When saving xstate to a kernel/user XSAVE area with the XSAVE family of
instructions, the current code applies the 'full' instruction mask (-1),
which tries to XSAVE all possible features. This method relies on
hardware to trim 'all possible' down to what is enabled in the
hardware. The code works well for now. However, there will be a
problem, if some features are enabled in hardware, but are not suitable
to be saved into all kernel XSAVE buffers, like task->fpu, due to
performance consideration.

One such example is the Last Branch Records (LBR) state. The LBR state
only contains valuable information when LBR is explicitly enabled by
the perf subsystem, and the size of an LBR state is large (808 bytes
for now). To avoid both CPU overhead and space overhead at each context
switch, the LBR state should not be saved into task->fpu like other
state components. It should be saved/restored on demand when LBR is
enabled in the perf subsystem. Current copy_xregs_to_* will trigger a
buffer overflow for such cases.

Three sites use the '-1' instruction mask which must be updated.

Two are saving/restoring the xstate to/from a kernel-allocated XSAVE
buffer and can use 'xfeatures_mask_all', which will save/restore all of
the features present in a normal task FPU buffer.

The last one saves the register state directly to a user buffer. It
could
also use 'xfeatures_mask_all'. Just as it was with the '-1' argument,
any supervisor states in the mask will be filtered out by the hardware
and not saved to the buffer.  But, to be more explicit about what is
expected to be saved, use xfeatures_mask_user() for the instruction
mask.

KVM includes the header file fpu/internal.h. To avoid 'undefined
xfeatures_mask_all' compiling issue, move copy_fpregs_to_fpstate() to
fpu/core.c and export it, because:
- The xfeatures_mask_all is indirectly used via copy_fpregs_to_fpstate()
  by KVM. The function which is directly used by other modules should be
  exported.
- The copy_fpregs_to_fpstate() is a function, while xfeatures_mask_all
  is a variable for the "internal" FPU state. It's safer to export a
  function than a variable, which may be implicitly changed by others.
- The copy_fpregs_to_fpstate() is a big function with many checks. The
  removal of the inline keyword should not impact the performance.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/fpu/internal.h | 47 ++++++-------------------------------
 arch/x86/kernel/fpu/core.c          | 39 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 42159f4..d3724dc 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -274,7 +274,7 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
  */
 static inline void copy_xregs_to_kernel_booting(struct xregs_state *xstate)
 {
-	u64 mask = -1;
+	u64 mask = xfeatures_mask_all;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
@@ -320,7 +320,7 @@ static inline void copy_kernel_to_xregs_booting(struct xregs_state *xstate)
  */
 static inline void copy_xregs_to_kernel(struct xregs_state *xstate)
 {
-	u64 mask = -1;
+	u64 mask = xfeatures_mask_all;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
@@ -356,6 +356,9 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
  */
 static inline int copy_xregs_to_user(struct xregs_state __user *buf)
 {
+	u64 mask = xfeatures_mask_user();
+	u32 lmask = mask;
+	u32 hmask = mask >> 32;
 	int err;
 
 	/*
@@ -367,7 +370,7 @@ static inline int copy_xregs_to_user(struct xregs_state __user *buf)
 		return -EFAULT;
 
 	stac();
-	XSTATE_OP(XSAVE, buf, -1, -1, err);
+	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
 	clac();
 
 	return err;
@@ -408,43 +411,7 @@ static inline int copy_kernel_to_xregs_err(struct xregs_state *xstate, u64 mask)
 	return err;
 }
 
-/*
- * These must be called with preempt disabled. Returns
- * 'true' if the FPU state is still intact and we can
- * keep registers active.
- *
- * The legacy FNSAVE instruction cleared all FPU state
- * unconditionally, so registers are essentially destroyed.
- * Modern FPU state can be kept in registers, if there are
- * no pending FP exceptions.
- */
-static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
-{
-	if (likely(use_xsave())) {
-		copy_xregs_to_kernel(&fpu->state.xsave);
-
-		/*
-		 * AVX512 state is tracked here because its use is
-		 * known to slow the max clock speed of the core.
-		 */
-		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
-			fpu->avx512_timestamp = jiffies;
-		return 1;
-	}
-
-	if (likely(use_fxsr())) {
-		copy_fxregs_to_kernel(fpu);
-		return 1;
-	}
-
-	/*
-	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
-	 * so we have to mark them inactive:
-	 */
-	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
-
-	return 0;
-}
+extern int copy_fpregs_to_fpstate(struct fpu *fpu);
 
 static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
 {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 06c8189..1bb7532 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -82,6 +82,45 @@ bool irq_fpu_usable(void)
 }
 EXPORT_SYMBOL(irq_fpu_usable);
 
+/*
+ * These must be called with preempt disabled. Returns
+ * 'true' if the FPU state is still intact and we can
+ * keep registers active.
+ *
+ * The legacy FNSAVE instruction cleared all FPU state
+ * unconditionally, so registers are essentially destroyed.
+ * Modern FPU state can be kept in registers, if there are
+ * no pending FP exceptions.
+ */
+int copy_fpregs_to_fpstate(struct fpu *fpu)
+{
+	if (likely(use_xsave())) {
+		copy_xregs_to_kernel(&fpu->state.xsave);
+
+		/*
+		 * AVX512 state is tracked here because its use is
+		 * known to slow the max clock speed of the core.
+		 */
+		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
+			fpu->avx512_timestamp = jiffies;
+		return 1;
+	}
+
+	if (likely(use_fxsr())) {
+		copy_fxregs_to_kernel(fpu);
+		return 1;
+	}
+
+	/*
+	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
+	 * so we have to mark them inactive:
+	 */
+	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
+
+	return 0;
+}
+EXPORT_SYMBOL(copy_fpregs_to_fpstate);
+
 void kernel_fpu_begin(void)
 {
 	preempt_disable();
-- 
2.7.4

