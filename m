Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE213013CC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 08:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbhAWHtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 02:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbhAWHtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 02:49:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F20C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 23:48:23 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e9so4602658plh.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 23:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+xbZX/2e1z7nI1cqqB7yK+NOPJmUSvroF8oxJesYkM=;
        b=bNd35H4D7fiWw8HBFu6LT/Qag6Bg7+kfJHOGxWFgYLjxkS0A/oVnqv9GD90Yw/G1Ab
         M7QYzf7wYhCgfRCCByS0igm4gU5UQzk0ORNfOVS5aXYh/lCfdcnf2efVE/GUzxn4YSuG
         1J6qVU8Q/ivlaEJ2hJViXyfCxO+4jntib2Ek5h3YF84CSqhlkNhmLmo3krggtlch+3s2
         SNx3utePp5yTTPkGAXDRzy7ZLzlOhW8Y0LCmW9NcH/E/f5asCefGoLZgqGf1XJ7IHgNZ
         0WRmLwzDh2rececCMjGO8/31lwFpcct8i6bTfloBgookfU/WtGvio9QCNb8fAVCfMIB7
         YA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+xbZX/2e1z7nI1cqqB7yK+NOPJmUSvroF8oxJesYkM=;
        b=S/yPfRPhoeXONEmy6c0EV31VBhbW20qbBHcEG6zhBOQXA02MdWgzUxgdQYhssXtodm
         im6yM4j8vqiVkYfYC2GnsJxmz4lpbarapsEeN/j0WT/NS+t3q9SR6TQfrGTYQOdgERzM
         jaQ9uXqpZuRAPT4P54Mr51N/7yVnprEqljnmV2ZRJe9Sap+NeTdjvCEVrKKR35fmNi6Y
         AF+Qxcz+/gaNYk1hvGJpEkVCQGLXsqzc9IedqmkIkpU7/XEe6yifKHikilE9feVG9Cum
         pQAGvD5VfDCWgwGIL9mswVTLl4wEhDcgAySZihtRrG1KHY1wjMHvgI0A2BblcbwzxMJr
         m1OQ==
X-Gm-Message-State: AOAM532vIA0feMERqff+Z3EKbUYlpHFQGfYaNATpdhZLYW7gSVUy25lf
        WFlqkg/ufXt7qESk0uIn4ikCSYzuH5I=
X-Google-Smtp-Source: ABdhPJzWTZtXbwtcaK4ho/vZgRFvdEDZLD7qBl2zvhT2NNja+AlIABIwT8lsqQFzjH0uy8FHfwhv+Q==
X-Received: by 2002:a17:90a:de06:: with SMTP id m6mr2232484pjv.167.1611388101660;
        Fri, 22 Jan 2021 23:48:21 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id x141sm10331259pfc.128.2021.01.22.23.48.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 23:48:20 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>
Subject: [PATCH] x86_64: move cpu_current_top_of_stack out of TSS
Date:   Sat, 23 Jan 2021 16:48:54 +0800
Message-Id: <20210123084900.3118-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When X86_BUG_CPU_MELTDOWN & KPTI, cpu_current_top_of_stack lives in the
TSS which is also in the user CR3 and it becomes a coveted fruit.  An
attacker can fetch the kernel stack top from it and continue next steps
of actions based on the kernel stack.

The address might not be very usefull for attacker, but it is not so
necessary to be in TSS either.  It is only accessed when CR3 is kernel CR3
and gs_base is kernel gs_base which means it can be in any percpu variable.

The major reason it is in TSS might be performance because it is hot in
cache and tlb since we just access sp2 as the scratch space in syscall.

So we can move it to a percpu variable near other hot percpu variables,
such as current_task, __preempt_count, and they are in the same
cache line.

tools/testing/selftests/seccomp/seccomp_benchmark desn't show any
performance lost in "getpid native" result.  And actually, the result
changes from 93ns before patch to 92ns after patch when !KPTI, and the
test is very stable although the test desn't show a higher degree of
precision but enough to know it doesn't cause degression for the test.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/processor.h   | 10 ----------
 arch/x86/include/asm/switch_to.h   |  7 +------
 arch/x86/include/asm/thread_info.h |  6 ------
 arch/x86/kernel/cpu/common.c       |  3 +++
 arch/x86/kernel/process.c          |  8 ++------
 arch/x86/mm/pti.c                  |  7 +++----
 6 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c20a52b5534b..886d32da1318 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -314,11 +314,6 @@ struct x86_hw_tss {
 struct x86_hw_tss {
 	u32			reserved1;
 	u64			sp0;
-
-	/*
-	 * We store cpu_current_top_of_stack in sp1 so it's always accessible.
-	 * Linux does not use ring 1, so sp1 is not otherwise needed.
-	 */
 	u64			sp1;
 
 	/*
@@ -428,12 +423,7 @@ struct irq_stack {
 
 DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
 
-#ifdef CONFIG_X86_32
 DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
-#else
-/* The RO copy can't be accessed with this_cpu_xyz(), so use the RW copy. */
-#define cpu_current_top_of_stack cpu_tss_rw.x86_tss.sp1
-#endif
 
 #ifdef CONFIG_X86_64
 struct fixed_percpu_data {
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 9f69cc497f4b..4f0bc8533a54 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -71,12 +71,7 @@ static inline void update_task_stack(struct task_struct *task)
 	else
 		this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
-	/*
-	 * x86-64 updates x86_tss.sp1 via cpu_current_top_of_stack. That
-	 * doesn't work on x86-32 because sp1 and
-	 * cpu_current_top_of_stack have different values (because of
-	 * the non-zero stack-padding on 32bit).
-	 */
+	/* XENPV keeps its entry stack to be kernel stack.  */
 	if (static_cpu_has(X86_FEATURE_XENPV))
 		load_sp0(task_top_of_stack(task));
 #endif
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 0d751d5da702..3dc93d8df425 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -197,12 +197,6 @@ static inline int arch_within_stack_frames(const void * const stack,
 #endif
 }
 
-#else /* !__ASSEMBLY__ */
-
-#ifdef CONFIG_X86_64
-# define cpu_current_top_of_stack (cpu_tss_rw + TSS_sp1)
-#endif
-
 #endif
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 35ad8480c464..f3d7fd7e9684 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1745,6 +1745,9 @@ DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
+DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
+EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
+
 /* May not be marked __init: used by software suspend */
 void syscall_init(void)
 {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 145a7ac0c19a..7c4d0184a44a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -63,14 +63,10 @@ __visible DEFINE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw) = {
 		 */
 		.sp0 = (1UL << (BITS_PER_LONG-1)) + 1,
 
-		/*
-		 * .sp1 is cpu_current_top_of_stack.  The init task never
-		 * runs user code, but cpu_current_top_of_stack should still
-		 * be well defined before the first context switch.
-		 */
+#ifdef CONFIG_X86_32
+		/* .sp1 is used via TSS_entry2task_stack when swtiching stack */
 		.sp1 = TOP_OF_INIT_STACK,
 
-#ifdef CONFIG_X86_32
 		.ss0 = __KERNEL_DS,
 		.ss1 = __KERNEL_CS,
 #endif
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 1aab92930569..e101cd87d038 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -440,10 +440,9 @@ static void __init pti_clone_user_shared(void)
 
 	for_each_possible_cpu(cpu) {
 		/*
-		 * The SYSCALL64 entry code needs to be able to find the
-		 * thread stack and needs one word of scratch space in which
-		 * to spill a register.  All of this lives in the TSS, in
-		 * the sp1 and sp2 slots.
+		 * The SYSCALL64 entry code needs one word of scratch space
+		 * in which to spill a register.  It lives in the sp2 slot
+		 * of the CPU's TSS.
 		 *
 		 * This is done for all possible CPUs during boot to ensure
 		 * that it's propagated to all mms.
-- 
2.19.1.6.gb485710b

