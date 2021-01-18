Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97512F99D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbhARGWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:22:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730151AbhARGV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:21:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BDE62251F;
        Mon, 18 Jan 2021 06:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610950844;
        bh=yHUNxes0FjrxicUu+KbRSFti619OIcluX0Ar0TPOrf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeWC1+hqIQ1iawYzsBYheBTNxJDatHGMM4GJ88vDkAMkh6gECWwlKnbjDxSbqus3S
         eSMNtvUp/ccajiNGcV56kLUVjSBBycCfl5FqjshC7e0z2V4CyqGX8IlQsnKvDObX8j
         wxBB2KquN5nRxPBnQIEbaMPnRVtfIij0dwxQKJH9ZNxIm0h77ubEeZEqIlXR1bfnM5
         VVXuO9Gj6dU4P3RY/vu3yX+RQTAKkvicirKbFS5UMqy7NZVru7y/1JBLUg1rGSHMh5
         F+k30PSwRklBv6oT+rVcZwWTd8kUXK/LtlcyypAm7bX++MkhTdZu/ysCEZRjdg/tNF
         BycAW603TUckQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/4] x86/fpu: Add kernel_fpu_begin_mask() to selectively initialize state
Date:   Sun, 17 Jan 2021 22:20:38 -0800
Message-Id: <a9630f17c5bcafbfe297a0828c7b6c78b0f6dcbe.1610950681.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610950681.git.luto@kernel.org>
References: <cover.1610950681.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, requesting kernel FPU access doesn't distinguish which parts of
the extended ("FPU") state are needed.  This is nice for simplicity, but
there are a few cases in which it's suboptimal:

 - The vast majority of in-kernel FPU users want XMM/YMM/ZMM state but do
   not use legacy 387 state.  These users want MXCSR initialized but don't
   care about the FPU control word.  Skipping FNINIT would save time.
   (Empirically, FNINIT is several times slower than LDMXCSR.)

 - Code that wants MMX doesn't want need MXCSR or FCW initialized.
   _mmx_memcpy(), for example, can run before CR4.OSFXSR gets set, and
   initializing MXCSR will fail.

 - Any future in-kernel users of XFD (eXtended Feature Disable)-capable
   dynamic states will need special handling.

This patch adds a more specific API that allows callers specify exactly
what they want.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/fpu/api.h | 16 ++++++++++++++--
 arch/x86/kernel/fpu/core.c     | 17 +++++++++++------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index dcd9503b1098..133907a200ef 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -16,14 +16,26 @@
  * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
  * disables preemption so be careful if you intend to use it for long periods
  * of time.
- * If you intend to use the FPU in softirq you need to check first with
+ * If you intend to use the FPU in irq/softirq you need to check first with
  * irq_fpu_usable() if it is possible.
  */
-extern void kernel_fpu_begin(void);
+
+/* Kernel FPU states to initialize in kernel_fpu_begin_mask() */
+#define KFPU_387	_BITUL(0)	/* FCW will be initialized */
+#define KFPU_XYZMM	_BITUL(1)	/* MXCSR will be initialized */
+#define KFPU_MMX	0		/* nothing gets initialized */
+
+extern void kernel_fpu_begin_mask(unsigned int kfpu_mask);
 extern void kernel_fpu_end(void);
 extern bool irq_fpu_usable(void);
 extern void fpregs_mark_activate(void);
 
+/* Code that is unaware of kernel_fpu_begin_mask() can use this */
+static inline void kernel_fpu_begin(void)
+{
+	kernel_fpu_begin_mask(KFPU_387 | KFPU_XYZMM);
+}
+
 /*
  * Use fpregs_lock() while editing CPU's FPU registers or fpu->state.
  * A context switch will (and softirq might) save CPU's FPU registers to
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index eb86a2b831b1..52d05c806aa6 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -121,7 +121,7 @@ int copy_fpregs_to_fpstate(struct fpu *fpu)
 }
 EXPORT_SYMBOL(copy_fpregs_to_fpstate);
 
-void kernel_fpu_begin(void)
+void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
 	preempt_disable();
 
@@ -141,13 +141,18 @@ void kernel_fpu_begin(void)
 	}
 	__cpu_invalidate_fpregs_state();
 
-	if (boot_cpu_has(X86_FEATURE_XMM))
-		ldmxcsr(MXCSR_DEFAULT);
+	/* Put sane initial values into the control registers. */
+	if (likely(kfpu_mask & KFPU_XYZMM)) {
+		if (boot_cpu_has(X86_FEATURE_XMM))
+			ldmxcsr(MXCSR_DEFAULT);
+	}
 
-	if (boot_cpu_has(X86_FEATURE_FPU))
-		asm volatile ("fninit");
+	if (unlikely(kfpu_mask & KFPU_387)) {
+		if (boot_cpu_has(X86_FEATURE_FPU))
+			asm volatile ("fninit");
+	}
 }
-EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
 
 void kernel_fpu_end(void)
 {
-- 
2.29.2

