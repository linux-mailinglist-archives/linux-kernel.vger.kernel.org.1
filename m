Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2F62FE16B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbhAUFRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:17:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbhAUFKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:10:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C5BA238EB;
        Thu, 21 Jan 2021 05:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611205793;
        bh=VQoVL5YWfcUFH/Rt5WChiTy0ghlSgObFvFGuziLJHYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VIzB8/sLkAFsu/XhcA3XnnGFREMlTUobzEauUghXf3xpfdXJd6Z/89Or/3fUBDir9
         OW7mG9//mZ7rDHl3H+OQsQmJDJdRVdy+ZvdJ3310aiIEy+Uv4zW0y5XitHUnNZV3M0
         gftId9FP9dBsEnAjSHlws6/Lua1Yl//S0bHC2bB78frbbwkwF7y3ACerNI5MOWXpop
         /rnKnVU9o3iFPvqF55Hvhe6VHE74VyCVdnHppUVPxjbZOiRXr805FarOVuxC5y1avb
         zz8ohaeju+1ylHHk4Rt5nPjt6OTAFZlrQtAp4iM8HUO4iaoN4HuMgRG76tYwvcenSf
         wV2As9dsuHRnQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 1/4] x86/fpu: Add kernel_fpu_begin_mask() to selectively initialize state
Date:   Wed, 20 Jan 2021 21:09:48 -0800
Message-Id: <aff1cac8b8fc7ee900cf73e8f2369966621b053f.1611205691.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611205691.git.luto@kernel.org>
References: <cover.1611205691.git.luto@kernel.org>
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

 - Code that wants MMX doesn't want or need MXCSR initialized.
   _mmx_memcpy(), for example, can run before CR4.OSFXSR gets set, and
   initializing MXCSR will fail.

 - Any future in-kernel users of XFD (eXtended Feature Disable)-capable
   dynamic states will need special handling.

Add a more specific API that allows callers specify exactly what they want.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/fpu/api.h | 15 +++++++++++++--
 arch/x86/kernel/fpu/core.c     |  9 +++++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index dcd9503b1098..38f4936045ab 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -16,14 +16,25 @@
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
+#define KFPU_387	_BITUL(0)	/* 387 state will be initialized */
+#define KFPU_MXCSR	_BITUL(1)	/* MXCSR will be initialized */
+
+extern void kernel_fpu_begin_mask(unsigned int kfpu_mask);
 extern void kernel_fpu_end(void);
 extern bool irq_fpu_usable(void);
 extern void fpregs_mark_activate(void);
 
+/* Code that is unaware of kernel_fpu_begin_mask() can use this */
+static inline void kernel_fpu_begin(void)
+{
+	kernel_fpu_begin_mask(KFPU_387 | KFPU_MXCSR);
+}
+
 /*
  * Use fpregs_lock() while editing CPU's FPU registers or fpu->state.
  * A context switch will (and softirq might) save CPU's FPU registers to
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index eb86a2b831b1..571220ac8bea 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -121,7 +121,7 @@ int copy_fpregs_to_fpstate(struct fpu *fpu)
 }
 EXPORT_SYMBOL(copy_fpregs_to_fpstate);
 
-void kernel_fpu_begin(void)
+void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
 	preempt_disable();
 
@@ -141,13 +141,14 @@ void kernel_fpu_begin(void)
 	}
 	__cpu_invalidate_fpregs_state();
 
-	if (boot_cpu_has(X86_FEATURE_XMM))
+	/* Put sane initial values into the control registers. */
+	if (likely(kfpu_mask & KFPU_MXCSR) && boot_cpu_has(X86_FEATURE_XMM))
 		ldmxcsr(MXCSR_DEFAULT);
 
-	if (boot_cpu_has(X86_FEATURE_FPU))
+	if (unlikely(kfpu_mask & KFPU_387) && boot_cpu_has(X86_FEATURE_FPU))
 		asm volatile ("fninit");
 }
-EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
 
 void kernel_fpu_end(void)
 {
-- 
2.29.2

