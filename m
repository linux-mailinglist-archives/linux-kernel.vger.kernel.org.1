Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7370C2C318A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgKXT75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbgKXT7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:59:55 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA8C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:59:54 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id f19so2549644qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=WXbcQWvdWDLVC5jHOswTFrpCLxCuVOiUOcyyKJaeh/g=;
        b=hurQCtcsEarRy0HRrRrdpGlHFG8T6ntiY+W8DibV3UoYqNtuiPUoho9HjblqNH52ve
         9muorssfxUCj/uJuGe2RRWCVB5sKHeKxDzL9PlWr8sHuUL/0Td/nQ9dcfme3BK4JaECN
         0LyZTZcb9isPJuGGbU5djI5HJn1hEl/UERcsnV1LZGeOMd1xbMAjlC+sanpB2L3sTgkq
         pQcj6IKUIfsgrDvR2t3g0+w/UT+kiKzFix3w2yhFNmtfw6QW9hXqB+nJhNXrh/LSl1/K
         xUOjnKcnK73gCxt/HHZOQmWYlVRDMgCiZuNbOZUjeKx0rR9QRzWM7Fjqb5g9ZTloPyvq
         Aa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WXbcQWvdWDLVC5jHOswTFrpCLxCuVOiUOcyyKJaeh/g=;
        b=qR+6uQlYdEFxkyxfrx0RP9GqOkAmfFXMilKxTIsOcVkg+5jsNaCjbWFgIdGTlKUwMB
         V1tsI7Joq3Bz1puIvNeN2gnzta41otOOjez6+CMMSBiaMYEfTLwOOfu69KBCVLGKFLAh
         ish2CafF1PQR7L+703jf/ftKVWzBRap+9CnJoTp89piD8yuQj51HmYePIdQOe4IOEW4Q
         KZbtzp1IVex8KyVosijTm7go/YhZf3pU5R83hl0siIyb+cOsuaGACwVtS2N8d5Tba1Az
         n1eg6Piro2nfsRKItCTwLR8WWFVpHv3/Aff6m1kORfKVxBMq5uAUEbrjqNVgT/+kdKdm
         UMug==
X-Gm-Message-State: AOAM532DGlAcEreawzd2LD869aqzqZbx8UQjc/B+toTvxcZCwlIZ4b6O
        2G5Hw1GkIKfOXNFXiodzXhQE6y91Y08LxMAkLNM=
X-Google-Smtp-Source: ABdhPJwz/b68ErbwAINA1DmsvIFCJSbOy4bc1aE3NJXrgYnPJF4Xsm8gnyly0MqpDkHkNvc5NEgy+sTiYJlDL/Kzg3M=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4661:: with SMTP id
 z1mr239900qvv.19.1606247993327; Tue, 24 Nov 2020 11:59:53 -0800 (PST)
Date:   Tue, 24 Nov 2020 11:59:40 -0800
In-Reply-To: <20201124195940.27061-1-samitolvanen@google.com>
Message-Id: <20201124195940.27061-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201124195940.27061-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 2/2] arm64: scs: use vmapped IRQ and SDEI shadow stacks
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
 arch/arm64/kernel/Makefile |  1 -
 arch/arm64/kernel/entry.S  |  6 ++--
 arch/arm64/kernel/irq.c    | 19 ++++++++++
 arch/arm64/kernel/scs.c    | 16 ---------
 arch/arm64/kernel/sdei.c   | 71 +++++++++++++++++++++++++++++++-------
 include/linux/scs.h        |  4 ---
 6 files changed, 81 insertions(+), 36 deletions(-)
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
index 7689f2031c0c..cbc370d3bb4f 100644
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
@@ -48,13 +57,31 @@ static void _free_sdei_stack(unsigned long * __percpu *ptr, int cpu)
 	}
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
 static void free_sdei_stacks(void)
 {
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		_free_sdei_stack(&sdei_stack_normal_ptr, cpu);
-		_free_sdei_stack(&sdei_stack_critical_ptr, cpu);
+		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
+			_free_sdei_stack(&sdei_stack_normal_ptr, cpu);
+			_free_sdei_stack(&sdei_stack_critical_ptr, cpu);
+		}
+
+		if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
+			_free_sdei_scs(&sdei_shadow_call_stack_normal_ptr, cpu);
+			_free_sdei_scs(&sdei_shadow_call_stack_critical_ptr, cpu);
+		}
 	}
 }
 
@@ -70,18 +97,40 @@ static int _init_sdei_stack(unsigned long * __percpu *ptr, int cpu)
 	return 0;
 }
 
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
 static int init_sdei_stacks(void)
 {
 	int cpu;
 	int err = 0;
 
 	for_each_possible_cpu(cpu) {
-		err = _init_sdei_stack(&sdei_stack_normal_ptr, cpu);
-		if (err)
-			break;
-		err = _init_sdei_stack(&sdei_stack_critical_ptr, cpu);
-		if (err)
-			break;
+		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
+			err = _init_sdei_stack(&sdei_stack_normal_ptr, cpu);
+			if (err)
+				break;
+			err = _init_sdei_stack(&sdei_stack_critical_ptr, cpu);
+			if (err)
+				break;
+		}
+		if (IS_ENABLED(CONFIG_SHADOW_CALL_STACK)) {
+			err = _init_sdei_scs(&sdei_shadow_call_stack_normal_ptr, cpu);
+			if (err)
+				break;
+			err = _init_sdei_scs(&sdei_shadow_call_stack_critical_ptr, cpu);
+			if (err)
+				break;
+		}
 	}
 
 	if (err)
@@ -133,10 +182,8 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 		return 0;
 	}
 
-	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
-		if (init_sdei_stacks())
-			return 0;
-	}
+	if (init_sdei_stacks())
+		return 0;
 
 	sdei_exit_mode = (conduit == SMCCC_CONDUIT_HVC) ? SDEI_EXIT_HVC : SDEI_EXIT_SMC;
 
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

