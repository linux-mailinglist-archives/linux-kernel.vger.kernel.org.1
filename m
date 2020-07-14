Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5BE21F6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGNQHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 12:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgGNQHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:07:06 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D1D622205;
        Tue, 14 Jul 2020 16:07:03 +0000 (UTC)
Date:   Tue, 14 Jul 2020 12:07:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 15/17] static_call: Allow early init
Message-ID: <20200714120701.332f310d@oasis.local.home>
In-Reply-To: <20200714155417.GZ10769@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
        <20200710134337.036717190@infradead.org>
        <20200710211426.298a3d94@oasis.local.home>
        <20200711050831.GY597537@hirez.programming.kicks-ass.net>
        <20200713162419.3a45f334@oasis.local.home>
        <20200714095117.GS10769@hirez.programming.kicks-ass.net>
        <20200714101636.5022a558@oasis.local.home>
        <20200714155417.GZ10769@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 17:54:17 +0200
Peter Zijlstra <peterz@infradead.org> wrote:
> > I guess that is, why did moving the initialization early require an
> > allocation where initializing it later did not? What allocation are we
> > avoiding?  
> 
> The other way around. Before this patch initialization required an
> allocation, with this patch init no longer requires one.
> 

Yeah, that's what I figured. Just didn't express myself that way.

> > I'm not seeing why this trick is needed when we moved the init early as
> > compared to doing the same thing later on.  
> 
> We use the trick to avoid the alloc, which is what enables early init.
> 
> So, before:
>  - init required alloc
>  - alloc prohibits early use
> 
> after:
>  - init no longer require alloc
>    - because horrible pointer reuse
>  - early use possible
> 
> > > @@ -192,16 +222,35 @@ static int __static_call_init(struct mod
> > >                 if (key != prev_key) {
> > >                         prev_key = key;
> > >  
> > > +                       if (!mod) {
> > > +                               key->sites = site;
> > > +                               key->type |= 1;
> > > +                               goto do_transform;
> > > +                       }
> > > +  
> > 
> > We want to avoid calling kzalloc() early?
> > 
> > If so, this should have a comment here stating so and why.  
> 
> Fair enough; and I think I even see a further optimiation.
> 
> How's this:
> 
> ---
> Subject: static_call: Allow early init
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri, 4 Oct 17:21:10 CEST 2019
> 
> In order to use static_call() to wire up x86_pmu, we need to
> initialize earlier; copy some of the tricks from jump_label to enable
> this.
> 
> Primarily we overload key->next to store a sites pointer when there
> are no modules, this avoids having to use kmalloc() to initialize the
> sites and allows us to run much earlier.

Can we add a statement that says something like: "Because x86 now calls
static_call_init() before the setup of the memory allocator, we must
avoid using kmalloc() and friends for core kernel static calls." ?

This was the missing piece for me.

> 
> (arguably, this is much much earlier than needed for perf, but it
> might allow other uses.)
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/setup.c       |    2 +
>  arch/x86/kernel/static_call.c |    8 ++++-
>  include/linux/static_call.h   |   15 ++++++++-
>  kernel/static_call.c          |   67 +++++++++++++++++++++++++++++++++++++++---
>  4 files changed, 85 insertions(+), 7 deletions(-)
> 
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -19,6 +19,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/tboot.h>
>  #include <linux/usb/xhci-dbgp.h>
> +#include <linux/static_call.h>
>  
>  #include <uapi/linux/mount.h>
>  
> @@ -848,6 +849,7 @@ void __init setup_arch(char **cmdline_p)
>  	early_cpu_init();
>  	arch_init_ideal_nops();
>  	jump_label_init();
> +	static_call_init();
>  	early_ioremap_init();
>  
>  	setup_olpc_ofw_pgd();
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -11,7 +11,7 @@ enum insn_type {
>  	RET = 3,  /* tramp / site cond-tail-call */
>  };
>  
> -static void __static_call_transform(void *insn, enum insn_type type, void *func)
> +static void __ref __static_call_transform(void *insn, enum insn_type type, void *func)
>  {
>  	int size = CALL_INSN_SIZE;
>  	const void *code;
> @@ -33,11 +33,17 @@ static void __static_call_transform(void
>  		code = text_gen_insn(RET_INSN_OPCODE, insn, func);
>  		size = RET_INSN_SIZE;
>  		break;
> +
> +	default: /* GCC is a moron -- it figures @code can be uninitialized below */
> +		BUG();
>  	}
>  
>  	if (memcmp(insn, code, size) == 0)
>  		return;
>  
> +	if (unlikely(system_state == SYSTEM_BOOTING))
> +		return text_poke_early(insn, code, size);
> +
>  	text_poke_bp(insn, code, size, NULL);
>  }
>  
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -136,6 +136,8 @@ extern void arch_static_call_transform(v
>  
>  #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
>  
> +extern void __init static_call_init(void);
> +
>  struct static_call_mod {
>  	struct static_call_mod *next;
>  	struct module *mod; /* for vmlinux, mod == NULL */
> @@ -144,7 +146,12 @@ struct static_call_mod {
>  
>  struct static_call_key {
>  	void *func;
> -	struct static_call_mod *mods;
> +	union {
> +		/* bit 0: 0 = mods, 1 = sites */
> +		unsigned long type;
> +		struct static_call_mod *mods;
> +		struct static_call_site *sites;
> +	};
>  };
>  
>  extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
> @@ -155,7 +162,7 @@ extern int static_call_text_reserved(voi
>  	DECLARE_STATIC_CALL(name, _func);				\
>  	struct static_call_key STATIC_CALL_KEY(name) = {		\
>  		.func = _func,						\
> -		.mods = NULL,						\
> +		.type = 1,						\
>  	};								\
>  	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
>  
> @@ -180,6 +187,8 @@ extern int static_call_text_reserved(voi
>  
>  #elif defined(CONFIG_HAVE_STATIC_CALL)
>  
> +static inline void static_call_init(void) { }
> +
>  struct static_call_key {
>  	void *func;
>  };
> @@ -225,6 +234,8 @@ static inline int static_call_text_reser
>  
>  #else /* Generic implementation */
>  
> +static inline void static_call_init(void) { }
> +
>  struct static_call_key {
>  	void *func;
>  };
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -94,10 +94,31 @@ static inline void static_call_sort_entr
>  	     static_call_site_cmp, static_call_site_swap);
>  }
>  
> +static inline bool static_call_key_has_mods(struct static_call_key *key)
> +{
> +	return !(key->type & 1);
> +}
> +
> +static inline struct static_call_mod *static_call_key_next(struct static_call_key *key)
> +{
> +	if (!static_call_key_has_mods(key))
> +		return NULL;
> +
> +	return key->mods;
> +}
> +
> +static inline struct static_call_site *static_call_key_sites(struct static_call_key *key)
> +{
> +	if (static_call_key_has_mods(key))
> +		return NULL;
> +
> +	return (struct static_call_site *)(key->type & ~1);
> +}
> +
>  void __static_call_update(struct static_call_key *key, void *tramp, void *func)
>  {
>  	struct static_call_site *site, *stop;
> -	struct static_call_mod *site_mod;
> +	struct static_call_mod *site_mod, first;
>  
>  	cpus_read_lock();
>  	static_call_lock();
> @@ -116,13 +137,22 @@ void __static_call_update(struct static_
>  	if (WARN_ON_ONCE(!static_call_initialized))
>  		goto done;
>  
> -	for (site_mod = key->mods; site_mod; site_mod = site_mod->next) {
> +	first = (struct static_call_mod){
> +		.next = static_call_key_next(key),
> +		.mod = NULL,
> +		.sites = static_call_key_sites(key),
> +	};
> +
> +	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
>  		struct module *mod = site_mod->mod;
>  
>  		if (!site_mod->sites) {
>  			/*
>  			 * This can happen if the static call key is defined in
>  			 * a module which doesn't use it.
> +			 *
> +			 * It also happens in the has_mods case, where the
> +			 * 'first' entry has no sites associated with it.
>  			 */
>  			continue;
>  		}
> @@ -192,16 +222,45 @@ static int __static_call_init(struct mod
>  		if (key != prev_key) {
>  			prev_key = key;
>  
> +			/*

Can we add to this comment:

			 * Some architectures (x86) call this before the memory
			 * allocator is set up.
> +			 * For vmlinux (!mod) avoid the allocation by storing
> +			 * the sites pointer in the key itself. Also see
> +			 * __static_call_update()'s @first.

-- Steve

> +			 */
> +			if (!mod) {
> +				key->sites = site;
> +				key->type |= 1;
> +				goto do_transform;
> +			}
> +
>  			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
>  			if (!site_mod)
>  				return -ENOMEM;
>  
> +			/*
> +			 * When the key has a direct sites pointer, extract
> +			 * that into an explicit struct static_call_mod, so we
> +			 * can have a list of modules.
> +			 */
> +			if (static_call_key_sites(key)) {
> +				site_mod->mod = NULL;
> +				site_mod->next = NULL;
> +				site_mod->sites = static_call_key_sites(key);
> +
> +				key->mods = site_mod;
> +
> +				site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
> +				if (!site_mod)
> +					return -ENOMEM;
> +			}
> +
>  			site_mod->mod = mod;
>  			site_mod->sites = site;
> -			site_mod->next = key->mods;
> +			site_mod->next = static_call_key_next(key);
>  			key->mods = site_mod;
>  		}
>  
> +do_transform:
>  		arch_static_call_transform(site_addr, NULL, key->func,
>  				static_call_is_tail(site));
>  	}
> @@ -348,7 +407,7 @@ int static_call_text_reserved(void *star
>  	return __static_call_mod_text_reserved(start, end);
>  }
>  
> -static void __init static_call_init(void)
> +void __init static_call_init(void)
>  {
>  	int ret;
>  

