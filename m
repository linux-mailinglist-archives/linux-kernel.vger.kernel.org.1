Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2E1BA97B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgD0QAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 12:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728499AbgD0QA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:00:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F061EC03C1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d206so20883470ybh.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QBR6Lbc359enZ9GCab/6TfVF8noXTmNT1IXJtHim5eo=;
        b=s7wahkpCHDvKVqyAdAzdYD9E2iIkX0QxZ2uWff9IdYz7cIH8w3dZYbRll1nlGNY8Ol
         /Iz+TGe6pY5G1fxDi/RDNT9D3k1VGAhDZnthmSTpwmoo6UmGy7Ntd6qxgQLnuwafxpfV
         /rWs1NzleEaUVzNyaxRA23BWkgXxxaVzS1TkiC6SzK3erPidXLqYnZteyZ+mP+yPjen2
         se5wE5LfLkDibsKs+zL7MF6u2aYQ9SKASNsrE11tYtfliRRMHKF1a2mIegifWsb/iQof
         Wx58HkUfpJ+vmcluKuznlOVb7rSbtIA3Dq3tLXHjWJs1ZwRhPRUxTkshNKedBNYlcffu
         V7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QBR6Lbc359enZ9GCab/6TfVF8noXTmNT1IXJtHim5eo=;
        b=nO4AI4XeHF/001+WvlCgK5HeTehsmFhizQJJ7GgQ9gbHrgJZU+A3zJBvxRXr8DsFGV
         KmCbpv1cw5sE750+VXod4n5VShylgXNTlD7flRFf5syMG+uPTBE9oFAlKrI/QowDkxhD
         Bvlr/NkO0WVqYLnjqYpYNgY0RhpJMBi3XrnuxdDOOyWxFetepT7Mb/Rh5yasnxJ2HBut
         E+R0Enz0vycifaaFa5yeH1Nvj0JRaGgEqfELBGWQ0gLVo322ce7YjbWuMDSvKX0NGfQw
         FOhyyNxKOD7Lw0OWWj95Ymkj4TB1ShWJ6iqq+r3OnCt+XWS2m9P+VNpiphnhkbS0Cxq1
         2Lcg==
X-Gm-Message-State: AGi0PuaxD/0kxximf0sExuyL9LR5aLF1mdb57cACtaOpv5P0NKdljr6B
        FEVbl6ont0BRJMpNzqi0nqqWdnyh5kGm/oRzE9s=
X-Google-Smtp-Source: APiQypIg1Fxqu2AHiC+o+ltA4wFCSgwiteBygrQAq5XLPj1AxM9UmaZg0zP0NYErifBqdO4h510rY8jJhoQl/C1Hg+g=
X-Received: by 2002:a25:a3a1:: with SMTP id e30mr35450525ybi.10.1588003225936;
 Mon, 27 Apr 2020 09:00:25 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:00:07 -0700
In-Reply-To: <20200427160018.243569-1-samitolvanen@google.com>
Message-Id: <20200427160018.243569-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200427160018.243569-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 01/12] add support for Clang's Shadow Call Stack (SCS)
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds generic support for Clang's Shadow Call Stack,
which uses a shadow stack to protect return addresses from being
overwritten by an attacker. Details are available here:

  https://clang.llvm.org/docs/ShadowCallStack.html

Note that security guarantees in the kernel differ from the ones
documented for user space. The kernel must store addresses of
shadow stacks in memory, which means an attacker capable reading
and writing arbitrary memory may be able to locate them and hijack
control flow by modifying the stacks.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 Makefile                       |  6 +++
 arch/Kconfig                   | 24 ++++++++++++
 include/linux/compiler-clang.h |  6 +++
 include/linux/compiler_types.h |  4 ++
 include/linux/scs.h            | 72 ++++++++++++++++++++++++++++++++++
 init/init_task.c               |  8 ++++
 kernel/Makefile                |  1 +
 kernel/fork.c                  |  9 +++++
 kernel/sched/core.c            |  2 +
 kernel/scs.c                   | 68 ++++++++++++++++++++++++++++++++
 10 files changed, 200 insertions(+)
 create mode 100644 include/linux/scs.h
 create mode 100644 kernel/scs.c

diff --git a/Makefile b/Makefile
index 679f302a8b8b..33dc0d0cdd08 100644
--- a/Makefile
+++ b/Makefile
@@ -866,6 +866,12 @@ ifdef CONFIG_LIVEPATCH
 KBUILD_CFLAGS += $(call cc-option, -flive-patching=inline-clone)
 endif
 
+ifdef CONFIG_SHADOW_CALL_STACK
+CC_FLAGS_SCS	:= -fsanitize=shadow-call-stack
+KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
+export CC_FLAGS_SCS
+endif
+
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 786a85d4ad40..334a3d9b19df 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -533,6 +533,30 @@ config STACKPROTECTOR_STRONG
 	  about 20% of all kernel functions, which increases the kernel code
 	  size by about 2%.
 
+config ARCH_SUPPORTS_SHADOW_CALL_STACK
+	bool
+	help
+	  An architecture should select this if it supports Clang's Shadow
+	  Call Stack, has asm/scs.h, and implements runtime support for shadow
+	  stack switching.
+
+config SHADOW_CALL_STACK
+	bool "Clang Shadow Call Stack"
+	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
+	help
+	  This option enables Clang's Shadow Call Stack, which uses a
+	  shadow stack to protect function return addresses from being
+	  overwritten by an attacker. More information can be found in
+	  Clang's documentation:
+
+	    https://clang.llvm.org/docs/ShadowCallStack.html
+
+	  Note that security guarantees in the kernel differ from the
+	  ones documented for user space. The kernel must store addresses
+	  of shadow stacks in memory, which means an attacker capable of
+	  reading and writing arbitrary memory may be able to locate them
+	  and hijack control flow by modifying the stacks.
+
 config HAVE_ARCH_WITHIN_STACK_FRAMES
 	bool
 	help
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 333a6695a918..18fc4d29ef27 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -42,3 +42,9 @@
  * compilers, like ICC.
  */
 #define barrier() __asm__ __volatile__("" : : : "memory")
+
+#if __has_feature(shadow_call_stack)
+# define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
+#else
+# define __noscs
+#endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e970f97a7fcb..97b62f47a80d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -193,6 +193,10 @@ struct ftrace_likely_data {
 # define randomized_struct_fields_end
 #endif
 
+#ifndef __noscs
+# define __noscs
+#endif
+
 #ifndef asm_volatile_goto
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
diff --git a/include/linux/scs.h b/include/linux/scs.h
new file mode 100644
index 000000000000..060eeb3d1390
--- /dev/null
+++ b/include/linux/scs.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Shadow Call Stack support.
+ *
+ * Copyright (C) 2019 Google LLC
+ */
+
+#ifndef _LINUX_SCS_H
+#define _LINUX_SCS_H
+
+#include <linux/gfp.h>
+#include <linux/poison.h>
+#include <linux/sched.h>
+#include <asm/page.h>
+
+#ifdef CONFIG_SHADOW_CALL_STACK
+
+/*
+ * In testing, 1 KiB shadow stack size (i.e. 128 stack frames on a 64-bit
+ * architecture) provided ~40% safety margin on stack usage while keeping
+ * memory allocation overhead reasonable.
+ */
+#define SCS_SIZE		1024UL
+#define GFP_SCS			(GFP_KERNEL | __GFP_ZERO)
+
+/* An illegal pointer value to mark the end of the shadow stack. */
+#define SCS_END_MAGIC		(0x5f6UL + POISON_POINTER_DELTA)
+
+#define task_scs(tsk)		(task_thread_info(tsk)->scs_base)
+#define task_scs_offset(tsk)	(task_thread_info(tsk)->scs_offset)
+
+extern void scs_init(void);
+
+static inline void scs_task_reset(struct task_struct *tsk)
+{
+	/*
+	 * Reset the shadow stack to the base address in case the task
+	 * is reused.
+	 */
+	task_scs_offset(tsk) = 0;
+}
+
+extern int scs_prepare(struct task_struct *tsk, int node);
+
+static inline unsigned long *__scs_magic(void *s)
+{
+	return (unsigned long *)(s + SCS_SIZE) - 1;
+}
+
+static inline bool scs_corrupted(struct task_struct *tsk)
+{
+	unsigned long *magic = __scs_magic(task_scs(tsk));
+
+	return (task_scs_offset(tsk) >= SCS_SIZE - 1 ||
+		READ_ONCE_NOCHECK(*magic) != SCS_END_MAGIC);
+}
+
+extern void scs_release(struct task_struct *tsk);
+
+#else /* CONFIG_SHADOW_CALL_STACK */
+
+#define task_scs(tsk)	NULL
+
+static inline void scs_init(void) {}
+static inline void scs_task_reset(struct task_struct *tsk) {}
+static inline int scs_prepare(struct task_struct *tsk, int node) { return 0; }
+static inline bool scs_corrupted(struct task_struct *tsk) { return false; }
+static inline void scs_release(struct task_struct *tsk) {}
+
+#endif /* CONFIG_SHADOW_CALL_STACK */
+
+#endif /* _LINUX_SCS_H */
diff --git a/init/init_task.c b/init/init_task.c
index bd403ed3e418..169e34066d35 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/audit.h>
 #include <linux/numa.h>
+#include <linux/scs.h>
 
 #include <asm/pgtable.h>
 #include <linux/uaccess.h>
@@ -50,6 +51,13 @@ static struct sighand_struct init_sighand = {
 	.signalfd_wqh	= __WAIT_QUEUE_HEAD_INITIALIZER(init_sighand.signalfd_wqh),
 };
 
+#ifdef CONFIG_SHADOW_CALL_STACK
+unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)]
+		__init_task_data = {
+	[(SCS_SIZE / sizeof(long)) - 1] = SCS_END_MAGIC
+};
+#endif
+
 /*
  * Set up the first task table, touch at your own risk!. Base=0,
  * limit=0x1fffff (=2MB)
diff --git a/kernel/Makefile b/kernel/Makefile
index 4cb4130ced32..c332eb9d4841 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
 obj-$(CONFIG_IRQ_WORK) += irq_work.o
 obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
+obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 8c700f881d92..f6339f9d232d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
 #include <linux/kasan.h>
+#include <linux/scs.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -456,6 +457,8 @@ void put_task_stack(struct task_struct *tsk)
 
 void free_task(struct task_struct *tsk)
 {
+	scs_release(tsk);
+
 #ifndef CONFIG_THREAD_INFO_IN_TASK
 	/*
 	 * The task is finally done with both the stack and thread_info,
@@ -840,6 +843,8 @@ void __init fork_init(void)
 			  NULL, free_vm_stack_cache);
 #endif
 
+	scs_init();
+
 	lockdep_init_task(&init_task);
 	uprobes_init();
 }
@@ -899,6 +904,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (err)
 		goto free_stack;
 
+	err = scs_prepare(tsk, node);
+	if (err)
+		goto free_stack;
+
 #ifdef CONFIG_SECCOMP
 	/*
 	 * We must handle setting up seccomp filters once we're under
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..934e03cfaec7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11,6 +11,7 @@
 #include <linux/nospec.h>
 
 #include <linux/kcov.h>
+#include <linux/scs.h>
 
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
@@ -6040,6 +6041,7 @@ void init_idle(struct task_struct *idle, int cpu)
 	idle->se.exec_start = sched_clock();
 	idle->flags |= PF_IDLE;
 
+	scs_task_reset(idle);
 	kasan_unpoison_task_stack(idle);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/scs.c b/kernel/scs.c
new file mode 100644
index 000000000000..43624be9ad90
--- /dev/null
+++ b/kernel/scs.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Shadow Call Stack support.
+ *
+ * Copyright (C) 2019 Google LLC
+ */
+
+#include <linux/kasan.h>
+#include <linux/scs.h>
+#include <linux/slab.h>
+#include <asm/scs.h>
+
+static struct kmem_cache *scs_cache;
+
+static void *scs_alloc(int node)
+{
+	void *s;
+
+	s = kmem_cache_alloc_node(scs_cache, GFP_SCS, node);
+	if (s) {
+		*__scs_magic(s) = SCS_END_MAGIC;
+		/*
+		 * Poison the allocation to catch unintentional accesses to
+		 * the shadow stack when KASAN is enabled.
+		 */
+		kasan_poison_object_data(scs_cache, s);
+	}
+
+	return s;
+}
+
+static void scs_free(void *s)
+{
+	kasan_unpoison_object_data(scs_cache, s);
+	kmem_cache_free(scs_cache, s);
+}
+
+void __init scs_init(void)
+{
+	scs_cache = kmem_cache_create("scs_cache", SCS_SIZE, 0, 0, NULL);
+}
+
+int scs_prepare(struct task_struct *tsk, int node)
+{
+	void *s;
+
+	s = scs_alloc(node);
+	if (!s)
+		return -ENOMEM;
+
+	task_scs(tsk) = s;
+	task_scs_offset(tsk) = 0;
+
+	return 0;
+}
+
+void scs_release(struct task_struct *tsk)
+{
+	void *s;
+
+	s = task_scs(tsk);
+	if (!s)
+		return;
+
+	WARN_ON(scs_corrupted(tsk));
+
+	scs_free(s);
+}
-- 
2.26.2.303.gf8c07b1a785-goog

