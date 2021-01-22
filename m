Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADD8300A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbhAVR3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbhAVQyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:54:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFABDC061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 08:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8IascDNf6FAnEtA+11CRmKoVyAivv5B5eZWXtQ5Bf+8=; b=l/WZr2w/nx49qYUSYzuuejmZfQ
        8/TlGs9V4usvu7cZ7+77Jvu3xJQJHaYg/GyMzj5f0zcQIGrD9FnrR89v+9u/+lmblGIc9tWTzxaf+
        KzCq+4xSUDceNJAU5kBB0Er2uDysjlkEpGNJiXHc6g1lRIGa0496+sm/rpdWlnlTwKZbkp4U8vhAi
        dsm+0sBFZie+vjUivXQzz+u72gaOw6bJxoxmZKfRVwzcMI9LArzlDX5HOb+2ncJYBw8C29WUCfbS2
        jrAYUGFpAf4M5bwVkqtuxG8d3LrwdBOw5/AO76qG6sjgiVQw2zjEaKyp9xj+k0OKT9n/hGp20MCpW
        1VuPtOVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2zfh-000yp6-Az; Fri, 22 Jan 2021 16:52:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69A059842C2; Fri, 22 Jan 2021 17:52:26 +0100 (CET)
Date:   Fri, 22 Jan 2021 17:52:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, rostedt@goodmis.org,
        jbaron@akamai.com, ardb@kernel.org
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <20210122165226.GD16371@worktop.programming.kicks-ass.net>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118141223.123667-7-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 03:12:21PM +0100, Frederic Weisbecker wrote:
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func());
> +EXPORT_STATIC_CALL(preempt_schedule);
> +#endif

> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
> +EXPORT_STATIC_CALL(preempt_schedule_notrace);
> +#endif

So one of the things I hates most of this is that is allows 'random'
modules to hijack the preemption by rewriting these callsites. Once you
export the key, we've lost.

I've tried a number of things, but this is the only one I could come up
with that actually stands a chance against malicious modules (vbox and
the like).

It's somewhat elaborate, but afaict it actually works.

---

--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -114,7 +114,7 @@ DECLARE_STATIC_CALL(preempt_schedule, __
 
 #define __preempt_schedule() \
 do { \
-	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule)); \
+	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule); \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
@@ -127,7 +127,7 @@ DECLARE_STATIC_CALL(preempt_schedule_not
 
 #define __preempt_schedule_notrace() \
 do { \
-	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule_notrace)); \
+	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule_notrace); \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -93,7 +93,7 @@ DECLARE_STATIC_CALL(might_resched, __con
 
 static __always_inline void might_resched(void)
 {
-	static_call(might_resched)();
+	static_call_mod(might_resched)();
 }
 
 #else
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1880,7 +1880,7 @@ DECLARE_STATIC_CALL(cond_resched, __cond
 
 static __always_inline int _cond_resched(void)
 {
-	return static_call(cond_resched)();
+	return static_call_mod(cond_resched)();
 }
 
 #else
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -107,6 +107,10 @@ extern void arch_static_call_transform(v
 
 #define STATIC_CALL_TRAMP_ADDR(name) &STATIC_CALL_TRAMP(name)
 
+#define static_call_register(name) \
+	__static_call_register(&STATIC_CALL_KEY(name), \
+			       &STATIC_CALL_TRAMP(name))
+
 #else
 #define STATIC_CALL_TRAMP_ADDR(name) NULL
 #endif
@@ -138,6 +142,7 @@ struct static_call_key {
 	};
 };
 
+extern int __static_call_register(struct static_call_key *key, void *tramp);
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
 extern int static_call_mod_init(struct module *mod);
 extern int static_call_text_reserved(void *start, void *end);
@@ -162,6 +167,9 @@ extern long __static_call_return0(void);
 
 #define static_call_cond(name)	(void)__static_call(name)
 
+#define EXPORT_STATIC_CALL_TRAMP(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
@@ -194,6 +202,11 @@ struct static_call_key {
 
 #define static_call_cond(name)	(void)__static_call(name)
 
+static inline int __static_call_register(struct static_call_key *key, void *tramp)
+{
+	return 0;
+}
+
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
@@ -213,6 +226,9 @@ static inline long __static_call_return0
 	return 0;
 }
 
+#define EXPORT_STATIC_CALL_TRAMP(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -39,17 +39,39 @@ struct static_call_site {
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
+#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
+
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
 /*
  * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
  * the symbol table so that objtool can reference it when it generates the
  * .static_call_sites section.
  */
+#define __STATIC_CALL_ADDRESSABLE(name) \
+	__ADDRESSABLE(STATIC_CALL_KEY(name))
+
 #define __static_call(name)						\
 ({									\
-	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
-	&STATIC_CALL_TRAMP(name);					\
+	__STATIC_CALL_ADDRESSABLE(name);				\
+	__raw_static_call(name);					\
 })
 
+#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#define __STATIC_CALL_ADDRESSABLE(name)
+#define __static_call(name)	__raw_static_call(name)
+
+#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#ifdef MODULE
+#define __STATIC_CALL_MOD_ADDRESSABLE(name)
+#define static_call_mod(name)	__raw_static_call(name)
+#else
+#define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
+#define static_call_mod(name)	__static_call(name)
+#endif
+
 #define static_call(name)	__static_call(name)
 
 #else
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5268,7 +5268,7 @@ EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func());
-EXPORT_STATIC_CALL(preempt_schedule);
+EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
 #endif
 
 
@@ -5326,7 +5326,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notra
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
-EXPORT_STATIC_CALL(preempt_schedule_notrace);
+EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 #endif
 
 #endif /* CONFIG_PREEMPTION */
@@ -6879,10 +6879,10 @@ EXPORT_SYMBOL(__cond_resched);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
-EXPORT_STATIC_CALL(cond_resched);
+EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
-EXPORT_STATIC_CALL(might_resched);
+EXPORT_STATIC_CALL_TRAMP(might_resched);
 #endif
 
 /*
@@ -8096,6 +8096,13 @@ void __init sched_init(void)
 
 	init_uclamp();
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+	static_call_register(cond_resched);
+	static_call_register(might_resched);
+	static_call_register(preempt_schedule);
+	static_call_register(preempt_schedule_notrace);
+#endif
+
 	scheduler_running = 1;
 }
 
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -323,10 +323,85 @@ static int __static_call_mod_text_reserv
 	return ret;
 }
 
+struct static_call_ass {
+	struct rb_node node;
+	struct static_call_key *key;
+	unsigned long tramp;
+};
+
+static struct rb_root static_call_asses;
+
+#define __node_2_ass(_n) \
+	rb_entry((_n), struct static_call_ass, node)
+
+static inline bool ass_less(struct rb_node *a, const struct rb_node *b)
+{
+	return __node_2_ass(a)->tramp < __node_2_ass(b)->tramp;
+}
+
+static inline int ass_cmp(const void *a, const struct rb_node *b)
+{
+	if (*(unsigned long *)a < __node_2_ass(b)->tramp)
+		return -1;
+
+	if (*(unsigned long *)a > __node_2_ass(b)->tramp)
+		return 1;
+
+	return 0;
+}
+
+int __static_call_register(struct static_call_key *key, void *tramp)
+{
+	struct static_call_ass *ass = kzalloc(sizeof(*ass), GFP_KERNEL);
+	if (!ass)
+		return -ENOMEM;
+
+	ass->key = key;
+	ass->tramp = (unsigned long)tramp;
+
+	/* trampolines should be aligned */
+	WARN_ON_ONCE(ass->tramp & STATIC_CALL_SITE_FLAGS);
+
+	rb_add(&ass->node, &static_call_asses, &ass_less);
+	return 0;
+}
+
+static struct static_call_ass *static_call_find_ass(unsigned long addr)
+{
+	struct rb_node *node = rb_find(&addr, &static_call_asses, &ass_cmp);
+	if (!node)
+		return NULL;
+	return __node_2_ass(node);
+}
+
 static int static_call_add_module(struct module *mod)
 {
-	return __static_call_init(mod, mod->static_call_sites,
-				  mod->static_call_sites + mod->num_static_call_sites);
+	struct static_call_site *start = mod->static_call_sites;
+	struct static_call_site *stop = start + mod->num_static_call_sites;
+	struct static_call_site *site;
+
+	for (site = start; site != stop; site++) {
+		unsigned long addr = (unsigned long)static_call_key(site);
+		struct static_call_ass *ass;
+
+		/*
+		 * Gotta fix up the keys that point to the trampoline.
+		 */
+		if (!kernel_text_address(addr))
+			continue;
+
+		ass = static_call_find_ass(addr);
+		if (!ass) {
+			pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
+				static_call_addr(site));
+			return -EINVAL;
+		}
+
+		site->key = ((unsigned long)ass->key - (unsigned long)&site->key) |
+			    (site->key & STATIC_CALL_SITE_FLAGS);
+	}
+
+	return __static_call_init(mod, start, stop);
 }
 
 static void static_call_del_module(struct module *mod)
@@ -392,6 +467,11 @@ static struct notifier_block static_call
 
 #else
 
+int __static_call_register(struct static_call_key *key, void *tramp)
+{
+	return 0;
+}
+
 static inline int __static_call_mod_text_reserved(void *start, void *end)
 {
 	return 0;
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -39,17 +39,39 @@ struct static_call_site {
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 
+#define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
+
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
 /*
  * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
  * the symbol table so that objtool can reference it when it generates the
  * .static_call_sites section.
  */
+#define __STATIC_CALL_ADDRESSABLE(name) \
+	__ADDRESSABLE(STATIC_CALL_KEY(name))
+
 #define __static_call(name)						\
 ({									\
-	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
-	&STATIC_CALL_TRAMP(name);					\
+	__STATIC_CALL_ADDRESSABLE(name);				\
+	__raw_static_call(name);					\
 })
 
+#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#define __STATIC_CALL_ADDRESSABLE(name)
+#define __static_call(name)	__raw_static_call(name)
+
+#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
+
+#ifdef MODULE
+#define __STATIC_CALL_MOD_ADDRESSABLE(name)
+#define static_call_mod(name)	__raw_static_call(name)
+#else
+#define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
+#define static_call_mod(name)	__static_call(name)
+#endif
+
 #define static_call(name)	__static_call(name)
 
 #else
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -502,8 +502,16 @@ static int create_static_call_sections(s
 
 		key_sym = find_symbol_by_name(file->elf, tmp);
 		if (!key_sym) {
-			WARN("static_call: can't find static_call_key symbol: %s", tmp);
-			return -1;
+			if (!module) {
+				WARN("static_call: can't find static_call_key symbol: %s", tmp);
+				return -1;
+			}
+			/*
+			 * For static_call_mod() we allow the key to be the
+			 * trampoline address. This is fixed up in
+			 * static_call_add_module().
+			 */
+			key_sym = insn->call_dest;
 		}
 		free(key_name);
 
