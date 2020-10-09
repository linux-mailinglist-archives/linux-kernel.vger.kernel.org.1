Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEFE28903A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbgJIRqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 13:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbgJIRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 13:46:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10E0C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NfLuiWpiuHU0oAhMGr8qzcwwieL815Axda8e2Q3A81s=; b=M0KckyOuyxPS0nmB3LYN9sa48F
        qyB9pKC2FUM0R5+tlsRWrebh0z8uEX3nYCT4ME6kelxOPCAD7J9mToQzVZSQcNGVB7/FbO7+LvfET
        N+VMU2FDnWdpP5q+Ip50EJdJKHtddLkTZQwE7ifZ423WJdNTJDfz69eLnJ9wz/OxLXKtGl5qxjL8T
        eib3OOTN6mGLlvW+Yv//n9DbPco3Sx0HtLVH2oYFTY1D4KYNwPy2wlLFz0SmYSapQ+0s/ZYtSLxog
        kPG8EENOjs09L9BcApf3+OU/+eJPMQ1zUGt0vDe8SMuJu/F+FtCmdb2MdrjuzvmQgBII8KmJnZiyS
        vl62PotA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQwSr-0001mQ-E5; Fri, 09 Oct 2020 17:45:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB1E930008D;
        Fri,  9 Oct 2020 19:45:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9BB3214324A9; Fri,  9 Oct 2020 19:45:54 +0200 (CEST)
Date:   Fri, 9 Oct 2020 19:45:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 0/5] allow overriding default preempt mode from
 command line
Message-ID: <20201009174554.GS2611@hirez.programming.kicks-ass.net>
References: <20201009122926.29962-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009122926.29962-1-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 02:29:21PM +0200, Michal Hocko wrote:
> Hi,
> let me repost the pile that has grown from the initial patch based on
> the review feedback I have collected from Peter. I do realize that he
> also suggested to go from the other direction and implement this for the
> full preemption mode first. As I've said I believe this would require to
> examine all CONFIG_PREEMPTION code paths and preempt_mode=[none,voluntary]
> is already quite useful for distributions which are targeting high
> throuhput and desktop environments. Adding full preemption on top is
> definitely desirable and something we will be looking into. This is the
> first step in that direction.

Just for giggles, configure a x86_64-PREEMPT kernel and apply the below.
It builds and boots here, except for "preempt=zero", which hangs
somewhere early.

It should be able to switch preemption mode at runtime too, but I've not
bothered to wire that up.

Also, some of it is utterly yuck ;-)

---
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3bc9b3bb178c..0941dc919d35 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3894,6 +3894,11 @@
 			Format: {"off"}
 			Disable Hardware Transactional Memory
 
+	preempt={none,voluntary}
+			Set the preemption mode.
+			none - equivalent to CONFIG_PREEMPT_NONE
+			voluntary - equivalent to CONFIG_PREEMPT_VOLUNTARY
+
 	print-fatal-signals=
 			[KNL] debug: print fatal signals
 
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 69485ca13665..ca4f64229da9 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -5,6 +5,7 @@
 #include <asm/rmwcc.h>
 #include <asm/percpu.h>
 #include <linux/thread_info.h>
+#include <linux/static_call_types.h>
 
 DECLARE_PER_CPU(int, __preempt_count);
 
@@ -103,16 +104,27 @@ static __always_inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
-  extern asmlinkage void preempt_schedule_thunk(void);
-# define __preempt_schedule() \
-	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT)
 
-  extern asmlinkage void preempt_schedule(void);
-  extern asmlinkage void preempt_schedule_notrace_thunk(void);
-# define __preempt_schedule_notrace() \
-	asm volatile ("call preempt_schedule_notrace_thunk" : ASM_CALL_CONSTRAINT)
+extern asmlinkage void preempt_schedule(void);
+extern asmlinkage void preempt_schedule_thunk(void);
+DECLARE_STATIC_CALL(preempt_schedule, preempt_schedule_thunk);
+
+#define __preempt_schedule() \
+do { \
+	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule)); \
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
+} while (0)
+
+extern asmlinkage void preempt_schedule_notrace(void);
+extern asmlinkage void preempt_schedule_notrace_thunk(void);
+DECLARE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_thunk);
+
+#define __preempt_schedule_notrace() \
+do { \
+	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule_notrace)); \
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
+} while (0)
 
-  extern asmlinkage void preempt_schedule_notrace(void);
 #endif
 
 #endif /* __ASM_PREEMPT_H */
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index ca9a380d9c0b..0f19f4fefcf6 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -16,7 +16,12 @@ static void __ref __static_call_transform(void *insn, enum insn_type type, void
 	int size = CALL_INSN_SIZE;
 	const void *code;
 
-	switch (type) {
+	if (type < 2 && func == &__static_call_return0) {
+
+		static const u8 ret0[5] = { 0x66, 0x66, 0x48, 0x31, 0xc0 };
+		code = ret0;
+
+	} else switch (type) {
 	case CALL:
 		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
 		break;
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index c25b8e41c0ea..88baab97a910 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -14,6 +14,7 @@
 #include <linux/typecheck.h>
 #include <linux/printk.h>
 #include <linux/build_bug.h>
+#include <linux/static_call_types.h>
 #include <asm/byteorder.h>
 #include <asm/div64.h>
 #include <uapi/linux/kernel.h>
@@ -192,12 +193,21 @@ struct completion;
 struct pt_regs;
 struct user;
 
-#ifdef CONFIG_PREEMPT_VOLUNTARY
-extern int _cond_resched(void);
-# define might_resched() _cond_resched()
-#else
-# define might_resched() do { } while (0)
-#endif
+extern int __cond_resched(void);
+DECLARE_STATIC_CALL(cond_resched, __cond_resched);
+
+static __always_inline int _cond_resched(void)
+{
+	return static_call(cond_resched)();
+}
+
+extern void __might_resched(void);
+DECLARE_STATIC_CALL(might_resched, __might_resched);
+
+static __always_inline void might_resched(void)
+{
+	static_call(might_resched)();
+}
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 extern void ___might_sleep(const char *file, int line, int preempt_offset);
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 59eb5cd567d7..483b015ac32f 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -64,9 +64,7 @@ extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
 void rcu_all_qs(void);
-#endif
 
 /* RCUtree hotplug events */
 int rcutree_prepare_cpu(unsigned int cpu);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d383cf09e78f..0443da7cca0c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1820,11 +1820,6 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
  * value indicates whether a reschedule was done in fact.
  * cond_resched_lock() will drop the spinlock before scheduling,
  */
-#ifndef CONFIG_PREEMPTION
-extern int _cond_resched(void);
-#else
-static inline int _cond_resched(void) { return 0; }
-#endif
 
 #define cond_resched() ({			\
 	___might_sleep(__FILE__, __LINE__, 0);	\
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 695da4c9b338..f47b8f5ffa69 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -107,26 +107,11 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #define STATIC_CALL_TRAMP_ADDR(name) &STATIC_CALL_TRAMP(name)
 
-/*
- * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
- * the symbol table so that objtool can reference it when it generates the
- * .static_call_sites section.
- */
-#define __static_call(name)						\
-({									\
-	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
-	&STATIC_CALL_TRAMP(name);					\
-})
-
 #else
 #define STATIC_CALL_TRAMP_ADDR(name) NULL
 #endif
 
 
-#define DECLARE_STATIC_CALL(name, func)					\
-	extern struct static_call_key STATIC_CALL_KEY(name);		\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
-
 #define static_call_update(name, func)					\
 ({									\
 	BUILD_BUG_ON(!__same_type(*(func), STATIC_CALL_TRAMP(name)));	\
@@ -136,6 +121,8 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
+extern int __static_call_return0(void);
+
 extern int __init static_call_init(void);
 
 struct static_call_mod {
@@ -174,7 +161,6 @@ extern int static_call_text_reserved(void *start, void *end);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define static_call(name)	__static_call(name)
 #define static_call_cond(name)	(void)__static_call(name)
 
 #define EXPORT_STATIC_CALL(name)					\
@@ -187,6 +173,8 @@ extern int static_call_text_reserved(void *start, void *end);
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
+static inline int __static_call_return0(void) { return 0; }
+
 static inline int static_call_init(void) { return 0; }
 
 struct static_call_key {
@@ -207,7 +195,6 @@ struct static_call_key {
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define static_call(name)	__static_call(name)
 #define static_call_cond(name)	(void)__static_call(name)
 
 static inline
@@ -234,6 +221,8 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #else /* Generic implementation */
 
+static inline int __static_call_return0(void) { return 0; }
+
 static inline int static_call_init(void) { return 0; }
 
 struct static_call_key {
@@ -252,9 +241,6 @@ struct static_call_key {
 		.func = NULL,						\
 	}
 
-#define static_call(name)						\
-	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
-
 static inline void __static_call_nop(void) { }
 
 /*
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 89135bb35bf7..08f78b1b88b4 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/stringify.h>
+#include <linux/compiler.h>
 
 #define STATIC_CALL_KEY_PREFIX		__SCK__
 #define STATIC_CALL_KEY_PREFIX_STR	__stringify(STATIC_CALL_KEY_PREFIX)
@@ -32,4 +33,30 @@ struct static_call_site {
 	s32 key;
 };
 
+#define DECLARE_STATIC_CALL(name, func)					\
+	extern struct static_call_key STATIC_CALL_KEY(name);		\
+	extern typeof(func) STATIC_CALL_TRAMP(name);
+
+#ifdef CONFIG_HAVE_STATIC_CALL
+
+/*
+ * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
+ * the symbol table so that objtool can reference it when it generates the
+ * .static_call_sites section.
+ */
+#define __static_call(name)						\
+({									\
+	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
+	&STATIC_CALL_TRAMP(name);					\
+})
+
+#define static_call(name)	__static_call(name)
+
+#else
+
+#define static_call(name)						\
+	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+
+#endif /* CONFIG_HAVE_STATIC_CALL */
+
 #endif /* _STATIC_CALL_TYPES_H */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 0a1e20f8d4e8..de0665b1890d 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -359,6 +359,8 @@ void irqentry_exit_cond_resched(void)
 	}
 }
 
+DECLARE_STATIC_KEY_TRUE(irq_preemption_key);
+
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
 	lockdep_assert_irqs_disabled();
@@ -384,7 +386,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		}
 
 		instrumentation_begin();
-		if (IS_ENABLED(CONFIG_PREEMPTION))
+		if (static_branch_likely(&irq_preemption_key))
 			irqentry_exit_cond_resched();
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8160ab5263f8..f872fb0ac560 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4709,6 +4709,9 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
 NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
+DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule);
+EXPORT_STATIC_CALL(preempt_schedule);
+
 /**
  * preempt_schedule_notrace - preempt_schedule called by tracing
  *
@@ -4761,6 +4764,9 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 }
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
+DEFINE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace);
+EXPORT_STATIC_CALL(preempt_schedule_notrace);
+
 #endif /* CONFIG_PREEMPTION */
 
 /*
@@ -6111,18 +6117,29 @@ SYSCALL_DEFINE0(sched_yield)
 	return 0;
 }
 
-#ifndef CONFIG_PREEMPTION
-int __sched _cond_resched(void)
+int __sched __cond_resched(void)
 {
 	if (should_resched(0)) {
 		preempt_schedule_common();
 		return 1;
 	}
+#ifndef CONFIG_PREEMPT_RCU
 	rcu_all_qs();
+#endif
 	return 0;
 }
-EXPORT_SYMBOL(_cond_resched);
-#endif
+EXPORT_SYMBOL(__cond_resched);
+
+DEFINE_STATIC_CALL(cond_resched, __cond_resched);
+EXPORT_STATIC_CALL(cond_resched);
+
+void __sched __might_resched(void)
+{
+	__cond_resched();
+}
+
+DEFINE_STATIC_CALL(might_resched, __might_resched);
+EXPORT_STATIC_CALL(might_resched);
 
 /*
  * __cond_resched_lock() - if a reschedule is pending, drop the given lock,
@@ -8481,3 +8498,86 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 {
         trace_sched_update_nr_running_tp(rq, count);
 }
+
+DEFINE_STATIC_KEY_TRUE(irq_preemption_key);
+
+/*
+ * SC:cond_resched
+ * SC:might_resched
+ * SC:preempt_schedule
+ * SC:preempt_schedule_notrace
+ * SB:irq_preemption_key
+ *
+ *
+ * ZERO
+ *   cond_resched             <- RET0
+ *   might_resched            <- NOP
+ *   preempt_schedule         <- NOP
+ *   preempt_schedule_notrace <- NOP
+ *   irq_preemption_key       <- false
+ *
+ * NONE:
+ *   cond_resched             <- __cond_resched
+ *   might_resched            <- NOP
+ *   preempt_schedule         <- NOP
+ *   preempt_schedule_notrace <- NOP
+ *   irq_preemption_key       <- false
+ *
+ * VOLUNTARY:
+ *   cond_resched             <- __cond_resched
+ *   might_resched            <- __might_resched
+ *   preempt_schedule         <- NOP
+ *   preempt_schedule_notrace <- NOP
+ *   irq_preemption_key       <- false
+ *
+ * FULL:
+ *   cond_resched             <- RET0
+ *   might_resched            <- NOP
+ *   preempt_schedule         <- preempt_schedule
+ *   preempt_schedule_notrace <- preempt_schedule_notrace
+ *   irq_preemption_key       <- true
+ */
+static int __init setup_preempt_mode(char *str)
+{
+	if (!strcmp(str, "zero")) {
+		static_call_update(cond_resched, __static_call_return0);
+		static_call_update(might_resched, (void (*)(void))NULL);
+		static_call_update(preempt_schedule, (void (*)(void))NULL);
+		static_call_update(preempt_schedule_notrace, (void (*)(void))NULL);
+		static_branch_disable(&irq_preemption_key);
+		printk("XXX PREEMPT: %s\n", str);
+	} else if (!strcmp(str, "none")) {
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, (void (*)(void))NULL);
+		static_call_update(preempt_schedule, (void (*)(void))NULL);
+		static_call_update(preempt_schedule_notrace, (void (*)(void))NULL);
+		static_branch_disable(&irq_preemption_key);
+		printk("XXX PREEMPT: %s\n", str);
+	} else if (!strcmp(str, "voluntary")) {
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, __might_resched);
+		static_call_update(preempt_schedule, (void (*)(void))NULL);
+		static_call_update(preempt_schedule_notrace, (void (*)(void))NULL);
+		static_branch_disable(&irq_preemption_key);
+		printk("XXX PREEMPT: %s\n", str);
+	} else if (!strcmp(str, "ponies")) {
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, (void (*)(void))NULL);
+		static_call_update(preempt_schedule, preempt_schedule_thunk);
+		static_call_update(preempt_schedule_notrace, preempt_schedule_notrace_thunk);
+		static_branch_enable(&irq_preemption_key);
+		printk("XXX PREEMPT: %s\n", str);
+	} else if (!strcmp(str, "full")) {
+		static_call_update(cond_resched, __static_call_return0);
+		static_call_update(might_resched, (void (*)(void))NULL);
+		static_call_update(preempt_schedule, preempt_schedule_thunk);
+		static_call_update(preempt_schedule_notrace, preempt_schedule_notrace_thunk);
+		static_branch_enable(&irq_preemption_key);
+		printk("XXX PREEMPT: %s\n", str);
+	} else {
+		pr_warn("Unsupported preempt mode %s\n", str);
+		return 1;
+	}
+	return 0;
+}
+__setup("preempt=", setup_preempt_mode);
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 84565c2a41b8..1aa17e399448 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -438,6 +438,11 @@ int __init static_call_init(void)
 }
 early_initcall(static_call_init);
 
+int __static_call_return0(void)
+{
+	return 0;
+}
+
 #ifdef CONFIG_STATIC_CALL_SELFTEST
 
 static int func_a(int x)
