Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B012C92C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbgK3Xfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388692AbgK3Xfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:35:30 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95382C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:34:50 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t14so8691643qvc.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/2hpXChav6Wt/RpcbVyRVD6Lx6UtoR7/piGzUBFcDPA=;
        b=OP+NuPPVKjRdl73IZILK5SqdKD4Ht7FixlV8PA26OKMxjg6NUNaSCQQQNc2lbAac3K
         h1tLLOXfkP/uccCUDN2SRKeBbQpAO+m37Klbfs/YBX/ltEAXIEW77i0UKV8LrGlsqf2P
         /+/faMrqoARnijNtjnwAmwoQZrRUIUzPQgd9vtZuj1FUXhFPNYgyDCtZsZWCaGVGtJ+r
         FcenFt6d6RLzZSF1mSI2tM1UcswgM+eAdr/lLCacaYgd2GRf49kp5rjwcBwr6xmdqBoX
         5xL/srF1pLiVrDoS78yuk0GSdP8R+Sx7/7/VmEU+GUgdKsbDDb+hLlU1rii1VPQtX71/
         xaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/2hpXChav6Wt/RpcbVyRVD6Lx6UtoR7/piGzUBFcDPA=;
        b=BAuPFUUUc8dnPAAilMM95XgEkWLrzItsovLWyNvZke7Ef98mRmcwzyKP0BMZGgeSkJ
         vYjqwaZB1lkPUtSW3vlWABTQm8wHS5Th7kl2jV92Lf5oOzOtA/kMNxjH1jhH4shBmL/+
         MQ2EaZq/0vhfzJTqiY23gwUQ5FGuYYqx04L7KrraDbL7UMeuVtURLhTzwKH9q84BKKSD
         1JHCtszrtWtvZ4wYnMBJzGXNwAxgoPn31Fmf8mX88tWOn9FTGl+CJHsT99w7nTVY1DX6
         IQGE+OrxcYkFlNHgeI0raetuqdTlUz3ZP1Jx9HRmcOk/Ubsq46rJzw+XXd637rMmp2sO
         NwLw==
X-Gm-Message-State: AOAM532VdqcN7Xe+6OpqJCdFBMD3kjgkB8RZ9m96SPM+h2lUBqvT6/kc
        CYI6k1frvzEmk5n7FpIPVke1vAufXJikLnYk7Ew=
X-Google-Smtp-Source: ABdhPJwHdvyygNPpCKDDdCrsa4Ck+vRg8Gp4MXUT40WxgVL9b6BDd+oHfOski3MhrYW0e3f5GXiTcQzqE8SrmlXMELQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e6e7:: with SMTP id
 m7mr233889qvn.11.1606779289826; Mon, 30 Nov 2020 15:34:49 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:34:42 -0800
In-Reply-To: <20201130233442.2562064-1-samitolvanen@google.com>
Message-Id: <20201130233442.2562064-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201130233442.2562064-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 2/2] arm64: scs: use vmapped IRQ and SDEI shadow stacks
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
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/Makefile |  1 -
 arch/arm64/kernel/entry.S  |  6 ++--
 arch/arm64/kernel/irq.c    | 19 +++++++++++
 arch/arm64/kernel/scs.c    | 16 ---------
 arch/arm64/kernel/sdei.c   | 70 ++++++++++++++++++++++++++++++++++++++
 include/linux/scs.h        |  4 ---
 6 files changed, 92 insertions(+), 24 deletions(-)
 delete mode 100644 arch/arm64/kernel/scs.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index bbaf0bc4ad60..86364ab6f13f 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -58,7 +58,6 @@ obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
 obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
-obj-$(CONFIG_SHADOW_CALL_STACK)		+= scs.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
 
 obj-y					+= vdso/ probes/
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index b295fb912b12..5c2ac4b5b2da 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -441,7 +441,7 @@ SYM_CODE_END(__swpan_exit_el0)
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 	/* also switch to the irq shadow stack */
-	adr_this_cpu scs_sp, irq_shadow_call_stack, x26
+	ldr_this_cpu scs_sp, irq_shadow_call_stack_ptr, x26
 #endif
 
 9998:
@@ -1097,9 +1097,9 @@ SYM_CODE_START(__sdei_asm_handler)
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
index 9cf2fb87584a..5b7ada9d9559 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/kprobes.h>
+#include <linux/scs.h>
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
 #include <asm/daifflags.h>
@@ -27,6 +28,22 @@ DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
 
 DEFINE_PER_CPU(unsigned long *, irq_stack_ptr);
 
+
+DECLARE_PER_CPU(unsigned long *, irq_shadow_call_stack_ptr);
+
+#ifdef CONFIG_SHADOW_CALL_STACK
+DEFINE_PER_CPU(unsigned long *, irq_shadow_call_stack_ptr);
+#endif
+
+static void init_irq_scs(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(irq_shadow_call_stack_ptr, cpu) =
+			scs_alloc(cpu_to_node(cpu));
+}
+
 #ifdef CONFIG_VMAP_STACK
 static void init_irq_stacks(void)
 {
@@ -54,6 +71,8 @@ static void init_irq_stacks(void)
 void __init init_IRQ(void)
 {
 	init_irq_stacks();
+	if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK))
+		init_irq_scs();
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
diff --git a/arch/arm64/kernel/scs.c b/arch/arm64/kernel/scs.c
deleted file mode 100644
index e8f7ff45dd8f..000000000000
--- a/arch/arm64/kernel/scs.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Shadow Call Stack support.
- *
- * Copyright (C) 2019 Google LLC
- */
-
-#include <linux/percpu.h>
-#include <linux/scs.h>
-
-DEFINE_SCS(irq_shadow_call_stack);
-
-#ifdef CONFIG_ARM_SDE_INTERFACE
-DEFINE_SCS(sdei_shadow_call_stack_normal);
-DEFINE_SCS(sdei_shadow_call_stack_critical);
-#endif
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 7689f2031c0c..d12fd786b267 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -7,6 +7,7 @@
 #include <linux/hardirq.h>
 #include <linux/irqflags.h>
 #include <linux/sched/task_stack.h>
+#include <linux/scs.h>
 #include <linux/uaccess.h>
 
 #include <asm/alternative.h>
@@ -37,6 +38,14 @@ DEFINE_PER_CPU(unsigned long *, sdei_stack_normal_ptr);
 DEFINE_PER_CPU(unsigned long *, sdei_stack_critical_ptr);
 #endif
 
+DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
+DECLARE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
+
+#ifdef CONFIG_SHADOW_CALL_STACK
+DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
+DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
+#endif
+
 static void _free_sdei_stack(unsigned long * __percpu *ptr, int cpu)
 {
 	unsigned long *p;
@@ -90,6 +99,59 @@ static int init_sdei_stacks(void)
 	return err;
 }
 
+static void _free_sdei_scs(unsigned long * __percpu *ptr, int cpu)
+{
+	void *s;
+
+	s = per_cpu(*ptr, cpu);
+	if (s) {
+		per_cpu(*ptr, cpu) = NULL;
+		scs_free(s);
+	}
+}
+
+static void free_sdei_scs(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		_free_sdei_scs(&sdei_shadow_call_stack_normal_ptr, cpu);
+		_free_sdei_scs(&sdei_shadow_call_stack_critical_ptr, cpu);
+	}
+}
+
+static int _init_sdei_scs(unsigned long * __percpu *ptr, int cpu)
+{
+	void *s;
+
+	s = scs_alloc(cpu_to_node(cpu));
+	if (!s)
+		return -ENOMEM;
+	per_cpu(*ptr, cpu) = s;
+
+	return 0;
+}
+
+static int init_sdei_scs(void)
+{
+	int cpu;
+	int err = 0;
+
+	for_each_possible_cpu(cpu) {
+		err = _init_sdei_scs(&sdei_shadow_call_stack_normal_ptr, cpu);
+		if (err)
+			break;
+		err = _init_sdei_scs(&sdei_shadow_call_stack_critical_ptr, cpu);
+		if (err)
+			break;
+	}
+
+	if (err)
+		free_sdei_scs();
+
+	return err;
+}
+
 static bool on_sdei_normal_stack(unsigned long sp, struct stack_info *info)
 {
 	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
@@ -138,6 +200,14 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 			return 0;
 	}
 
+	if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
+		if (init_sdei_scs()) {
+			if (IS_ENABLED(CONFIG_VMAP_STACK))
+				free_sdei_stacks();
+			return 0;
+		}
+	}
+
 	sdei_exit_mode = (conduit == SMCCC_CONDUIT_HVC) ? SDEI_EXIT_HVC : SDEI_EXIT_SMC;
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
diff --git a/include/linux/scs.h b/include/linux/scs.h
index 2a506c2a16f4..18122d9e17ff 100644
--- a/include/linux/scs.h
+++ b/include/linux/scs.h
@@ -22,10 +22,6 @@
 /* An illegal pointer value to mark the end of the shadow stack. */
 #define SCS_END_MAGIC		(0x5f6UL + POISON_POINTER_DELTA)
 
-/* Allocate a static per-CPU shadow stack */
-#define DEFINE_SCS(name)						\
-	DEFINE_PER_CPU(unsigned long [SCS_SIZE/sizeof(long)], name)	\
-
 #define task_scs(tsk)		(task_thread_info(tsk)->scs_base)
 #define task_scs_sp(tsk)	(task_thread_info(tsk)->scs_sp)
 
-- 
2.29.2.454.gaff20da3a2-goog

