Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6532965ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371566AbgJVUYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371551AbgJVUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:24:07 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9C2C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 13:24:07 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v190so1865821qki.21
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HdaEzwW485tOauxqLOPFR2PJAF06evpL8oosipyb9N4=;
        b=lIVRXpl0VYnVqLZkN59z5l6EB0oiuWQYvHmtdZOvGgLY1DycgKA7bfxTZolWpxPysq
         uPY8ErFQua5rvGjajXi6TAbgoI+aSLhe+N0PiuOUihjVjNHAr6XBZZBkcp4bE1Mz0GhR
         GEtMgSqvSMjP/EwI1/XRXHH8oGjnjguQF+Clr8AEuqdilMbhOh3g9xv3zhrBB+ie2nOx
         wTAhHLvzGhCQHGF+cwHgEnU9ZjnxkzKAvzo5ubuMb8Ewn/MfnxBk2c/zGC73G7usVhfz
         Nps59f9AEndYLXnnbequ/7aJ9P7jZbalqks1vwtStvcrVyKT61A/8SIBcJUasp6wWI9k
         hvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HdaEzwW485tOauxqLOPFR2PJAF06evpL8oosipyb9N4=;
        b=BG2derx58XzoqKyDLpz9xs44XnwjmRXNoOP5fqDD8lHLLVV2ipQD6U2kz5sD98pzCD
         CViQKG7MEH+DtV7Eq1F9VbPWH64UyTXOcexeAAozFUxdgKQzSc1R5rQV2khFKovBu8WJ
         lXSw7EcEDk8U0at53uXRyFrI9+DJpUzxBhdXq2aWyqGu64xffcTZ455EC3iPpBw/r7b4
         ctTpcMqK9nEt9d7KKOS1HJJrps9q14JmHlrP8mQ1alNlbxi/9LLv/64Kq0AHbxzHGsxw
         0GdByiI2t9WyaKHw7RRIHbcA+OvKRYpUsHlLWWZ5B3vaxw0uYXlEzFrYRQAI34lwJXtH
         Wo3w==
X-Gm-Message-State: AOAM533Y2cI3voJPiwScv+UyMFAJZ0By5Rn3HOT4/XnVNVJ8ZvfFrpN2
        SgYhVfv7gHUrKlsDycUMY4WXQGI4/3TTSt4Ta1Y=
X-Google-Smtp-Source: ABdhPJz/Sh6UUI+3VBKbiRt9YnloPvsrz1cGe/jkO3/yS7Oyq21RzG7T9W9c0Oa0QjO69qc+dVzDOd5vcpOAQ+D1hLQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e512:: with SMTP id
 l18mr4207892qvm.31.1603398246632; Thu, 22 Oct 2020 13:24:06 -0700 (PDT)
Date:   Thu, 22 Oct 2020 13:23:55 -0700
In-Reply-To: <20201022202355.3529836-1-samitolvanen@google.com>
Message-Id: <20201022202355.3529836-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201022202355.3529836-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH 2/2] arm64: scs: use vmapped IRQ and SDEI shadow stacks
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use scs_alloc() to allocate also IRQ and SDEI shadow stacks instead of
using statically allocated stacks.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/scs.h | 21 ++++++++++-
 arch/arm64/kernel/entry.S    |  6 ++--
 arch/arm64/kernel/irq.c      |  2 ++
 arch/arm64/kernel/scs.c      | 67 +++++++++++++++++++++++++++++++++---
 arch/arm64/kernel/sdei.c     |  7 ++++
 include/linux/scs.h          |  8 ++---
 kernel/scs.c                 |  4 +--
 7 files changed, 101 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index eaa2cd92e4c1..e9d2c3e67ff9 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -24,6 +24,25 @@
 	.endm
 #endif /* CONFIG_SHADOW_CALL_STACK */
 
-#endif /* __ASSEMBLY __ */
+#else /* __ASSEMBLY__ */
+
+#include <linux/scs.h>
+
+#ifdef CONFIG_SHADOW_CALL_STACK
+
+extern void scs_init_irq(void);
+
+extern void scs_free_sdei(void);
+extern int scs_init_sdei(void);
+
+#else
+
+static inline void scs_init_irq(void) {}
+static inline void scs_free_sdei(void) {}
+static inline int scs_init_sdei(void) { return -EOPNOTSUPP; }
+
+#endif
+
+#endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_SCS_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f30007dff35f..0f76fe8142e4 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -438,7 +438,7 @@ SYM_CODE_END(__swpan_exit_el0)
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 	/* also switch to the irq shadow stack */
-	adr_this_cpu scs_sp, irq_shadow_call_stack, x26
+	ldr_this_cpu scs_sp, irq_shadow_call_stack_ptr, x26
 #endif
 
 9998:
@@ -1094,9 +1094,9 @@ SYM_CODE_START(__sdei_asm_handler)
 #ifdef CONFIG_SHADOW_CALL_STACK
 	/* Use a separate shadow call stack for normal and critical events */
 	cbnz	w4, 3f
-	adr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_normal, tmp=x6
+	ldr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_normal_ptr, tmp=x6
 	b	4f
-3:	adr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_critical, tmp=x6
+3:	ldr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_critical_ptr, tmp=x6
 4:
 #endif
 
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 9cf2fb87584a..54ba3725bc0e 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -20,6 +20,7 @@
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
 #include <asm/daifflags.h>
+#include <asm/scs.h>
 #include <asm/vmap_stack.h>
 
 /* Only access this in an NMI enter/exit */
@@ -54,6 +55,7 @@ static void init_irq_stacks(void)
 void __init init_IRQ(void)
 {
 	init_irq_stacks();
+	scs_init_irq();
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
diff --git a/arch/arm64/kernel/scs.c b/arch/arm64/kernel/scs.c
index e8f7ff45dd8f..f85cebf8122a 100644
--- a/arch/arm64/kernel/scs.c
+++ b/arch/arm64/kernel/scs.c
@@ -6,11 +6,70 @@
  */
 
 #include <linux/percpu.h>
-#include <linux/scs.h>
+#include <asm/scs.h>
 
-DEFINE_SCS(irq_shadow_call_stack);
+DEFINE_PER_CPU(unsigned long *, irq_shadow_call_stack_ptr);
+
+DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
+DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
 
 #ifdef CONFIG_ARM_SDE_INTERFACE
-DEFINE_SCS(sdei_shadow_call_stack_normal);
-DEFINE_SCS(sdei_shadow_call_stack_critical);
+DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
+DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
 #endif
+
+void scs_init_irq(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(irq_shadow_call_stack_ptr, cpu) =
+			scs_alloc(cpu_to_node(cpu));
+}
+
+
+void scs_free_sdei(void)
+{
+	int cpu;
+	void *s;
+
+	if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		s = per_cpu(sdei_shadow_call_stack_normal_ptr, cpu);
+		if (s)
+			scs_free(s);
+
+		s = per_cpu(sdei_shadow_call_stack_critical_ptr, cpu);
+		if (s)
+			scs_free(s);
+	}
+}
+
+int scs_init_sdei(void)
+{
+	int cpu;
+	void *s;
+
+	if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
+		return 0;
+
+	for_each_possible_cpu(cpu) {
+		s = scs_alloc(cpu_to_node(cpu));
+		if (!s)
+			goto err;
+		per_cpu(sdei_shadow_call_stack_normal_ptr, cpu) = s;
+
+		s = scs_alloc(cpu_to_node(cpu));
+		if (!s)
+			goto err;
+		per_cpu(sdei_shadow_call_stack_critical_ptr, cpu) = s;
+	}
+
+	return 0;
+
+err:
+	scs_free_sdei();
+	return -ENOMEM;
+}
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 7689f2031c0c..04519a7cb51d 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -13,6 +13,7 @@
 #include <asm/kprobes.h>
 #include <asm/mmu.h>
 #include <asm/ptrace.h>
+#include <asm/scs.h>
 #include <asm/sections.h>
 #include <asm/stacktrace.h>
 #include <asm/sysreg.h>
@@ -138,6 +139,12 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 			return 0;
 	}
 
+	if (scs_init_sdei()) {
+		if (IS_ENABLED(CONFIG_VMAP_STACK))
+			free_sdei_stacks();
+		return 0;
+	}
+
 	sdei_exit_mode = (conduit == SMCCC_CONDUIT_HVC) ? SDEI_EXIT_HVC : SDEI_EXIT_SMC;
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
diff --git a/include/linux/scs.h b/include/linux/scs.h
index 86e3c4b7b714..6b35a83576d4 100644
--- a/include/linux/scs.h
+++ b/include/linux/scs.h
@@ -21,13 +21,11 @@
 /* An illegal pointer value to mark the end of the shadow stack. */
 #define SCS_END_MAGIC		(0x5f6UL + POISON_POINTER_DELTA)
 
-/* Allocate a static per-CPU shadow stack */
-#define DEFINE_SCS(name)						\
-	DEFINE_PER_CPU(unsigned long [SCS_SIZE/sizeof(long)], name)	\
-
 #define task_scs(tsk)		(task_thread_info(tsk)->scs_base)
 #define task_scs_sp(tsk)	(task_thread_info(tsk)->scs_sp)
 
+void *scs_alloc(int node);
+void scs_free(void *s);
 void scs_init(void);
 int scs_prepare(struct task_struct *tsk, int node);
 void scs_release(struct task_struct *tsk);
@@ -56,6 +54,8 @@ static inline bool task_scs_end_corrupted(struct task_struct *tsk)
 
 #else /* CONFIG_SHADOW_CALL_STACK */
 
+static inline void *scs_alloc(int node) { return NULL; }
+static inline void scs_free(void *s) {}
 static inline void scs_init(void) {}
 static inline void scs_task_reset(struct task_struct *tsk) {}
 static inline int scs_prepare(struct task_struct *tsk, int node) { return 0; }
diff --git a/kernel/scs.c b/kernel/scs.c
index 2136edba548d..8df4a92cd939 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -24,7 +24,7 @@ static void __scs_account(void *s, int account)
 #define NR_CACHED_SCS 2
 static DEFINE_PER_CPU(void *, scs_cache[NR_CACHED_SCS]);
 
-static void *scs_alloc(int node)
+void *scs_alloc(int node)
 {
 	int i;
 	void *s;
@@ -63,7 +63,7 @@ static void *scs_alloc(int node)
 	return s;
 }
 
-static void scs_free(void *s)
+void scs_free(void *s)
 {
 	int i;
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

