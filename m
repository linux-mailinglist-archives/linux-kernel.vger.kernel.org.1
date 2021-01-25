Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CF3302807
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbhAYQid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730812AbhAYQgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:36:55 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8039C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:36:14 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e9so1680858pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxIHznqwAGESe2xc5cpCSnujQzQI1SoVg8yAGG62ByY=;
        b=hj5zUO9EOYdqo9s5O/GMHCMj3BisbPvYUkcwSQyPR4AiJF7/Y04KNsFnQ89dQ3LvNU
         vqQh9iJjBYuMr1mUZ8JoXc2mLIk0/C1HrQgIBt9KFskDzMu60iVIHc2LmHmc7N3xVHEe
         MaJ9Dv5aTshT2t1q03/HH/U1n4Oq+wKzpcxPrOvZLdx0vVfVAKnrJ/AIoYUZuDMUEGrp
         4PQWwpSeFCPWV1Nuc7OmG71IZ4bbcxYi5bZtsQsG9BTrvi6OXmCzWRTHAuCSleEqRyZD
         I96nTfF97c3ZQcJkuOtMIIcF+liw85+UgkocuVHVa0lAeiNL4sZuxymevlevQ+FYEDrO
         j+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxIHznqwAGESe2xc5cpCSnujQzQI1SoVg8yAGG62ByY=;
        b=Tj1BzTCCj6kRuU93f0PyExvUG0tR2Tefqu+0j8tPDaiWZ9SfuwQXLPXxd6qKfLZPlO
         ztUTW+owF7JJpUOc8R9OGEBb8xy4UN6L2MLk1p12RfcvbR49QttEDR8okDS9D3Xa5+bV
         kk7PSvH8Mmf1DP8XIYKREgV2JXC2KgwLx7PEeHcLI7p8yMu06HwKqJA6t5RQVX1XR1n0
         Ia6Ql2ZpihzVT1TL5S3M8cCv3+g6zcbRLfAEimlrySNER77inQjG0iTgT23nPwPmTvGj
         tPPvEOh2CgOO+fKcb2LDZErOqX4GVNh6yPozC5EXLTZWhPF/E6U8YX+rnxxZWF+lffME
         vzlw==
X-Gm-Message-State: AOAM532dTz4vjYI2zBNR0BrCk+ALOK7W7SngBWgKu/eH4khan/y38Nm7
        HW5ylBk3Wts1N1Mds2MlcRClPAojyU32Cg==
X-Google-Smtp-Source: ABdhPJxq4D/dblNlcs9Dr9mo/IDgF1x3tUjJRoNjHlM1Odxl8EBvPhUEDS3/0kQM3bjIgLRiIWH9qQ==
X-Received: by 2002:a17:90a:5208:: with SMTP id v8mr1041060pjh.224.1611592574186;
        Mon, 25 Jan 2021 08:36:14 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id z15sm17163658pfr.89.2021.01.25.08.36.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:36:13 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V2 6/6] x86_32: use cpu_current_thread_sp0 instead of cpu_tss_rw.x86_tss.sp1
Date:   Tue, 26 Jan 2021 01:34:34 +0800
Message-Id: <20210125173444.22696-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210125173444.22696-1-jiangshanlai@gmail.com>
References: <CALCETrWPnvNr9S2hsxL+pbhNWv0OOL7tBq1XmABPjYK7zZSJbw@mail.gmail.com>
 <20210125173444.22696-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

sp1 is not used by hardware and is used as thread.sp0.  We should just
use new percpu variable.

And remove unneeded TSS_sp1.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_32.S        | 6 +++---
 arch/x86/include/asm/processor.h | 2 ++
 arch/x86/include/asm/switch_to.h | 2 +-
 arch/x86/kernel/asm-offsets.c    | 1 -
 arch/x86/kernel/cpu/common.c     | 9 ++++++++-
 arch/x86/kernel/process.c        | 2 --
 6 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 3cb42efb3c04..22cd3d8fd23e 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -472,7 +472,7 @@
 	movl	%esp, %esi
 
 	/* Load top of task-stack into %edi */
-	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %edi
+	movl	PER_CPU_VAR(cpu_current_thread_sp0), %edi
 
 	/* Special case - entry from kernel mode via entry stack */
 #ifdef CONFIG_VM86
@@ -658,7 +658,7 @@
 	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %edi
 
 	/* Bytes on the task-stack to ecx */
-	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %ecx
+	movl	PER_CPU_VAR(cpu_current_thread_sp0), %ecx
 	subl	%esi, %ecx
 
 	/* Allocate stack-frame on entry-stack */
@@ -916,7 +916,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Switch to task stack */
 	movl	%esp, %eax
-	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %esp
+	movl	PER_CPU_VAR(cpu_current_thread_sp0), %esp
 
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 886d32da1318..4265884c33e7 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -774,6 +774,8 @@ static inline void spin_lock_prefetch(const void *x)
 
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
+DECLARE_PER_CPU(unsigned long, cpu_current_thread_sp0);
+
 #else
 #define INIT_THREAD { }
 
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index b5f0d2ff47e4..e27eb7974797 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -69,7 +69,7 @@ static inline void update_task_stack(struct task_struct *task)
 	if (static_cpu_has(X86_FEATURE_XENPV))
 		load_sp0(task->thread.sp0);
 	else
-		this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
+		this_cpu_write(cpu_current_thread_sp0, task->thread.sp0);
 #else
 	/* Xen PV enters the kernel on the thread stack. */
 	if (static_cpu_has(X86_FEATURE_XENPV))
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 60b9f42ce3c1..3b63b6062792 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -98,6 +98,5 @@ static void __used common(void)
 
 	/* Offset for fields in tss_struct */
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
-	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f3d7fd7e9684..b2c37d369137 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1789,12 +1789,19 @@ EXPORT_PER_CPU_SYMBOL(__preempt_count);
 /*
  * On x86_32, vm86 modifies tss.sp0, so sp0 isn't a reliable way to find
  * the top of the kernel stack.  Use an extra percpu variable to track the
- * top of the kernel stack directly.
+ * top of the kernel stack directly and an percpu variable to track the
+ * thread.sp0 for using in entry code.  cpu_current_top_of_stack and
+ * cpu_current_thread_sp0 are different value because of the non-zero
+ * stack-padding on 32bit.  See more comment at TOP_OF_KERNEL_STACK_PADDING
+ * and vm86.
  */
 DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) =
 	(unsigned long)&init_thread_union + THREAD_SIZE;
 EXPORT_PER_CPU_SYMBOL(cpu_current_top_of_stack);
 
+DEFINE_PER_CPU(unsigned long, cpu_current_thread_sp0) = TOP_OF_INIT_STACK;
+EXPORT_PER_CPU_SYMBOL(cpu_current_thread_sp0);
+
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU_ALIGNED(struct stack_canary, stack_canary);
 #endif
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 296de77da4b2..e6d4b5399a81 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -64,8 +64,6 @@ __visible DEFINE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw) = {
 		.sp0 = (1UL << (BITS_PER_LONG-1)) + 1,
 
 #ifdef CONFIG_X86_32
-		.sp1 = TOP_OF_INIT_STACK,
-
 		.ss0 = __KERNEL_DS,
 		.ss1 = __KERNEL_CS,
 #endif
-- 
2.19.1.6.gb485710b

