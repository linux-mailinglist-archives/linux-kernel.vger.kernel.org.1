Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79DF300998
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbhAVRMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:12:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729672AbhAVQ6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:58:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A71523AAA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611334685;
        bh=6SMPe6uOEEJkc0LcD8a6RNEpjILNI5INCVwDYDitodw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oZ9FsOEjMcqKU/XZ1CVm2kQSjoUjCBfZc/IPG4CfnEytjar64K0TcFdBBsW5rUORk
         iGZCnmVcPJhaVEuxt4zcizHa+ohMNmssApoiMR1p4pbzPbDfOwPw+Zad0dIMH3vryo
         JFj8Fqu6auCU8W2saVIeTMPKKVDYbuO60HBDFyCgILBYkDU/Wt/ubWgnaT4/y3kpBy
         9zekpsw/ABtdECSxkvl4/VwmPf62iJW7YP9kKMiiD0vacV8pwS3nSi8PkSN9Qzvznr
         Qj1u5nTOI4DGpHaRjoSBBWPZq8/d0fLkHCL6tfy4Iv3rCvIW4LyA8locpNYqOTMqak
         IN9djod1TkQMA==
Received: by mail-oi1-f178.google.com with SMTP id w124so6678583oia.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 08:58:05 -0800 (PST)
X-Gm-Message-State: AOAM5304T6+bU1oq6zT9bgd8U/BMcUuVyyCnRhrEDW8tnnxdJjQswnIq
        1tfMKEGMTwGwyq4go9g+lZr11TZuqVXTN5Xq5tI=
X-Google-Smtp-Source: ABdhPJwoAGXWDFdyeVqyQLLVv4ks4jW24DX2kxgqaX38EkldT0eOU/nuJnPnv/JltwX4cMVMd89TNty4k5bCvhENHNI=
X-Received: by 2002:aca:210f:: with SMTP id 15mr3786640oiz.174.1611334684332;
 Fri, 22 Jan 2021 08:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20210118141223.123667-1-frederic@kernel.org> <20210118141223.123667-7-frederic@kernel.org>
 <20210122165226.GD16371@worktop.programming.kicks-ass.net>
In-Reply-To: <20210122165226.GD16371@worktop.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 22 Jan 2021 17:57:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHLL1_WGztYoxGS=12zY5ZxGskptPf4nV78pL7m02pdOA@mail.gmail.com>
Message-ID: <CAMj1kXHLL1_WGztYoxGS=12zY5ZxGskptPf4nV78pL7m02pdOA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide preempt_schedule[_notrace]()
 static calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 at 17:53, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jan 18, 2021 at 03:12:21PM +0100, Frederic Weisbecker wrote:
> > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > +DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func());
> > +EXPORT_STATIC_CALL(preempt_schedule);
> > +#endif
>
> > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > +DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
> > +EXPORT_STATIC_CALL(preempt_schedule_notrace);
> > +#endif
>
> So one of the things I hates most of this is that is allows 'random'
> modules to hijack the preemption by rewriting these callsites. Once you
> export the key, we've lost.
>

Are these supposed to be switchable at any time? Or only at boot? In
the latter case, can't we drop the associated data structure in
__ro_after_init so it becomes R/O when booting completes?

> I've tried a number of things, but this is the only one I could come up
> with that actually stands a chance against malicious modules (vbox and
> the like).
>
> It's somewhat elaborate, but afaict it actually works.
>
> ---
>
> --- a/arch/x86/include/asm/preempt.h
> +++ b/arch/x86/include/asm/preempt.h
> @@ -114,7 +114,7 @@ DECLARE_STATIC_CALL(preempt_schedule, __
>
>  #define __preempt_schedule() \
>  do { \
> -       __ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule)); \
> +       __STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule); \
>         asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
>  } while (0)
>
> @@ -127,7 +127,7 @@ DECLARE_STATIC_CALL(preempt_schedule_not
>
>  #define __preempt_schedule_notrace() \
>  do { \
> -       __ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule_notrace)); \
> +       __STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule_notrace); \
>         asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
>  } while (0)
>
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -93,7 +93,7 @@ DECLARE_STATIC_CALL(might_resched, __con
>
>  static __always_inline void might_resched(void)
>  {
> -       static_call(might_resched)();
> +       static_call_mod(might_resched)();
>  }
>
>  #else
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1880,7 +1880,7 @@ DECLARE_STATIC_CALL(cond_resched, __cond
>
>  static __always_inline int _cond_resched(void)
>  {
> -       return static_call(cond_resched)();
> +       return static_call_mod(cond_resched)();
>  }
>
>  #else
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -107,6 +107,10 @@ extern void arch_static_call_transform(v
>
>  #define STATIC_CALL_TRAMP_ADDR(name) &STATIC_CALL_TRAMP(name)
>
> +#define static_call_register(name) \
> +       __static_call_register(&STATIC_CALL_KEY(name), \
> +                              &STATIC_CALL_TRAMP(name))
> +
>  #else
>  #define STATIC_CALL_TRAMP_ADDR(name) NULL
>  #endif
> @@ -138,6 +142,7 @@ struct static_call_key {
>         };
>  };
>
> +extern int __static_call_register(struct static_call_key *key, void *tramp);
>  extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
>  extern int static_call_mod_init(struct module *mod);
>  extern int static_call_text_reserved(void *start, void *end);
> @@ -162,6 +167,9 @@ extern long __static_call_return0(void);
>
>  #define static_call_cond(name) (void)__static_call(name)
>
> +#define EXPORT_STATIC_CALL_TRAMP(name)                                 \
> +       EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
> +
>  #define EXPORT_STATIC_CALL(name)                                       \
>         EXPORT_SYMBOL(STATIC_CALL_KEY(name));                           \
>         EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
> @@ -194,6 +202,11 @@ struct static_call_key {
>
>  #define static_call_cond(name) (void)__static_call(name)
>
> +static inline int __static_call_register(struct static_call_key *key, void *tramp)
> +{
> +       return 0;
> +}
> +
>  static inline
>  void __static_call_update(struct static_call_key *key, void *tramp, void *func)
>  {
> @@ -213,6 +226,9 @@ static inline long __static_call_return0
>         return 0;
>  }
>
> +#define EXPORT_STATIC_CALL_TRAMP(name)                                 \
> +       EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
> +
>  #define EXPORT_STATIC_CALL(name)                                       \
>         EXPORT_SYMBOL(STATIC_CALL_KEY(name));                           \
>         EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
> --- a/include/linux/static_call_types.h
> +++ b/include/linux/static_call_types.h
> @@ -39,17 +39,39 @@ struct static_call_site {
>
>  #ifdef CONFIG_HAVE_STATIC_CALL
>
> +#define __raw_static_call(name)        (&STATIC_CALL_TRAMP(name))
> +
> +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> +
>  /*
>   * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
>   * the symbol table so that objtool can reference it when it generates the
>   * .static_call_sites section.
>   */
> +#define __STATIC_CALL_ADDRESSABLE(name) \
> +       __ADDRESSABLE(STATIC_CALL_KEY(name))
> +
>  #define __static_call(name)                                            \
>  ({                                                                     \
> -       __ADDRESSABLE(STATIC_CALL_KEY(name));                           \
> -       &STATIC_CALL_TRAMP(name);                                       \
> +       __STATIC_CALL_ADDRESSABLE(name);                                \
> +       __raw_static_call(name);                                        \
>  })
>
> +#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
> +
> +#define __STATIC_CALL_ADDRESSABLE(name)
> +#define __static_call(name)    __raw_static_call(name)
> +
> +#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
> +
> +#ifdef MODULE
> +#define __STATIC_CALL_MOD_ADDRESSABLE(name)
> +#define static_call_mod(name)  __raw_static_call(name)
> +#else
> +#define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
> +#define static_call_mod(name)  __static_call(name)
> +#endif
> +
>  #define static_call(name)      __static_call(name)
>
>  #else
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5268,7 +5268,7 @@ EXPORT_SYMBOL(preempt_schedule);
>
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func());
> -EXPORT_STATIC_CALL(preempt_schedule);
> +EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
>  #endif
>
>
> @@ -5326,7 +5326,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notra
>
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
> -EXPORT_STATIC_CALL(preempt_schedule_notrace);
> +EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
>  #endif
>
>  #endif /* CONFIG_PREEMPTION */
> @@ -6879,10 +6879,10 @@ EXPORT_SYMBOL(__cond_resched);
>
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
> -EXPORT_STATIC_CALL(cond_resched);
> +EXPORT_STATIC_CALL_TRAMP(cond_resched);
>
>  DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
> -EXPORT_STATIC_CALL(might_resched);
> +EXPORT_STATIC_CALL_TRAMP(might_resched);
>  #endif
>
>  /*
> @@ -8096,6 +8096,13 @@ void __init sched_init(void)
>
>         init_uclamp();
>
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +       static_call_register(cond_resched);
> +       static_call_register(might_resched);
> +       static_call_register(preempt_schedule);
> +       static_call_register(preempt_schedule_notrace);
> +#endif
> +
>         scheduler_running = 1;
>  }
>
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -323,10 +323,85 @@ static int __static_call_mod_text_reserv
>         return ret;
>  }
>
> +struct static_call_ass {
> +       struct rb_node node;
> +       struct static_call_key *key;
> +       unsigned long tramp;
> +};
> +
> +static struct rb_root static_call_asses;
> +
> +#define __node_2_ass(_n) \
> +       rb_entry((_n), struct static_call_ass, node)
> +
> +static inline bool ass_less(struct rb_node *a, const struct rb_node *b)
> +{
> +       return __node_2_ass(a)->tramp < __node_2_ass(b)->tramp;
> +}
> +
> +static inline int ass_cmp(const void *a, const struct rb_node *b)
> +{
> +       if (*(unsigned long *)a < __node_2_ass(b)->tramp)
> +               return -1;
> +
> +       if (*(unsigned long *)a > __node_2_ass(b)->tramp)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +int __static_call_register(struct static_call_key *key, void *tramp)
> +{
> +       struct static_call_ass *ass = kzalloc(sizeof(*ass), GFP_KERNEL);
> +       if (!ass)
> +               return -ENOMEM;
> +
> +       ass->key = key;
> +       ass->tramp = (unsigned long)tramp;
> +
> +       /* trampolines should be aligned */
> +       WARN_ON_ONCE(ass->tramp & STATIC_CALL_SITE_FLAGS);
> +
> +       rb_add(&ass->node, &static_call_asses, &ass_less);
> +       return 0;
> +}
> +
> +static struct static_call_ass *static_call_find_ass(unsigned long addr)
> +{
> +       struct rb_node *node = rb_find(&addr, &static_call_asses, &ass_cmp);
> +       if (!node)
> +               return NULL;
> +       return __node_2_ass(node);
> +}
> +
>  static int static_call_add_module(struct module *mod)
>  {
> -       return __static_call_init(mod, mod->static_call_sites,
> -                                 mod->static_call_sites + mod->num_static_call_sites);
> +       struct static_call_site *start = mod->static_call_sites;
> +       struct static_call_site *stop = start + mod->num_static_call_sites;
> +       struct static_call_site *site;
> +
> +       for (site = start; site != stop; site++) {
> +               unsigned long addr = (unsigned long)static_call_key(site);
> +               struct static_call_ass *ass;
> +
> +               /*
> +                * Gotta fix up the keys that point to the trampoline.
> +                */
> +               if (!kernel_text_address(addr))
> +                       continue;
> +
> +               ass = static_call_find_ass(addr);
> +               if (!ass) {
> +                       pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
> +                               static_call_addr(site));
> +                       return -EINVAL;
> +               }
> +
> +               site->key = ((unsigned long)ass->key - (unsigned long)&site->key) |
> +                           (site->key & STATIC_CALL_SITE_FLAGS);
> +       }
> +
> +       return __static_call_init(mod, start, stop);
>  }
>
>  static void static_call_del_module(struct module *mod)
> @@ -392,6 +467,11 @@ static struct notifier_block static_call
>
>  #else
>
> +int __static_call_register(struct static_call_key *key, void *tramp)
> +{
> +       return 0;
> +}
> +
>  static inline int __static_call_mod_text_reserved(void *start, void *end)
>  {
>         return 0;
> --- a/tools/include/linux/static_call_types.h
> +++ b/tools/include/linux/static_call_types.h
> @@ -39,17 +39,39 @@ struct static_call_site {
>
>  #ifdef CONFIG_HAVE_STATIC_CALL
>
> +#define __raw_static_call(name)        (&STATIC_CALL_TRAMP(name))
> +
> +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> +
>  /*
>   * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
>   * the symbol table so that objtool can reference it when it generates the
>   * .static_call_sites section.
>   */
> +#define __STATIC_CALL_ADDRESSABLE(name) \
> +       __ADDRESSABLE(STATIC_CALL_KEY(name))
> +
>  #define __static_call(name)                                            \
>  ({                                                                     \
> -       __ADDRESSABLE(STATIC_CALL_KEY(name));                           \
> -       &STATIC_CALL_TRAMP(name);                                       \
> +       __STATIC_CALL_ADDRESSABLE(name);                                \
> +       __raw_static_call(name);                                        \
>  })
>
> +#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
> +
> +#define __STATIC_CALL_ADDRESSABLE(name)
> +#define __static_call(name)    __raw_static_call(name)
> +
> +#endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
> +
> +#ifdef MODULE
> +#define __STATIC_CALL_MOD_ADDRESSABLE(name)
> +#define static_call_mod(name)  __raw_static_call(name)
> +#else
> +#define __STATIC_CALL_MOD_ADDRESSABLE(name) __STATIC_CALL_ADDRESSABLE(name)
> +#define static_call_mod(name)  __static_call(name)
> +#endif
> +
>  #define static_call(name)      __static_call(name)
>
>  #else
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -502,8 +502,16 @@ static int create_static_call_sections(s
>
>                 key_sym = find_symbol_by_name(file->elf, tmp);
>                 if (!key_sym) {
> -                       WARN("static_call: can't find static_call_key symbol: %s", tmp);
> -                       return -1;
> +                       if (!module) {
> +                               WARN("static_call: can't find static_call_key symbol: %s", tmp);
> +                               return -1;
> +                       }
> +                       /*
> +                        * For static_call_mod() we allow the key to be the
> +                        * trampoline address. This is fixed up in
> +                        * static_call_add_module().
> +                        */
> +                       key_sym = insn->call_dest;
>                 }
>                 free(key_name);
>
