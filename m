Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2DC1B1836
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 23:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgDTVSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 17:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726021AbgDTVSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:18:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82C4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:18:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d17so5723632pgo.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I17SvgP3468YaEZJ/m4ZeQYc9PSBmKeATPZO1LtBfTU=;
        b=XnbwyLaH7oxybL3ROw+62qMqb6U8ZOn3MLAaPYqeeh+VuVLkQNRb3nWFLiH9BwR2UR
         sbbVScuejmAiyvNPyxXICkWwFKWG0PpwnZEeN43Ngtm27+vb+YWt3zwPsRXvZuj689HF
         fYbSTVujfki3XSuRzMQMpiQebTqSfvME3FQtGM+9HbuL+7BEeSe0pUdrwZ07pFcg20Un
         2m7XBjrFngOcMpgWWHxGDck8annUfzdJhxNT8BIU8kpWqrEkuSxsbuRyHwJPs71/4XUy
         QNd3JhuxImU8I1Q3PBefsRGrK1shSg18iwPgvpF5PlqpDJ18U2gU1CEsFxIrNQixCFNj
         B7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I17SvgP3468YaEZJ/m4ZeQYc9PSBmKeATPZO1LtBfTU=;
        b=BKZw3GhaPyb6QA/uGS6HSADYQWEcH2v7HmbnntUTj47Ia9jycYhwgdV8wv4GxxR1gi
         Foi3ys/VWQjlxRjWxdfSwdAbevGbAGl53RS0uhVso4pRAXlJBWQEh9KXIuWMK/KSCAhT
         cf4ks+OcxwB2MkaVmtiwd36tjRRwZtoNGUBo9cm8JdaaTtIKFpFgg+oJZu1c8zBx9YZ8
         ml8GnW20WlrLHJZm6HCg6AH00+lhbXr0M9llVDV/w6h67BtW0sIWF0CvCwnwhdqYy2L+
         dCbHFfbCb7m1iXGuN/v3LWE36teIYaSlHsWDeLwEFEHJ8uHNTbfCOTia/ss2ZZUjesnK
         Wl9Q==
X-Gm-Message-State: AGi0PubgnlBfEIVhLCkFO/kIAM1a7B9LbYrxXlOfB0HlPEOupYNO60EV
        WlWon22FrU8E2zdNGapN1pM2cg==
X-Google-Smtp-Source: APiQypLUjqh4gwB0agDoF7ZPn9MBLUchmrqjGKnG9TkryWTgi8fxU4nmUmPmgkJbrKA1PcXpLA4w9w==
X-Received: by 2002:a63:ef02:: with SMTP id u2mr18271584pgh.21.1587417517829;
        Mon, 20 Apr 2020 14:18:37 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id s10sm407267pfd.124.2020.04.20.14.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:18:36 -0700 (PDT)
Date:   Mon, 20 Apr 2020 14:18:30 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 01/12] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <20200420211830.GA5081@google.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-2-samitolvanen@google.com>
 <20200420171727.GB24386@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420171727.GB24386@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 06:17:28PM +0100, Will Deacon wrote:
> > +ifdef CONFIG_SHADOW_CALL_STACK
> > +CC_FLAGS_SCS	:= -fsanitize=shadow-call-stack
> > +KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
> > +export CC_FLAGS_SCS
> > +endif
> 
> CFLAGS_SCS would seem more natural to me, although I see ftrace does it this
> way.

Right, I followed ftrace's example here.

> > +config SHADOW_CALL_STACK
> > +	bool "Clang Shadow Call Stack"
> > +	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
> > +	help
> > +	  This option enables Clang's Shadow Call Stack, which uses a
> > +	  shadow stack to protect function return addresses from being
> > +	  overwritten by an attacker. More information can be found in
> > +	  Clang's documentation:
> > +
> > +	    https://clang.llvm.org/docs/ShadowCallStack.html
> > +
> > +	  Note that security guarantees in the kernel differ from the ones
> > +	  documented for user space. The kernel must store addresses of shadow
> > +	  stacks used by other tasks and interrupt handlers in memory, which
> > +	  means an attacker capable of reading and writing arbitrary memory
> > +	  may be able to locate them and hijack control flow by modifying
> > +	  shadow stacks that are not currently in use.
> 
> Shouldn't some of this depend on CC_IS_CLANG?

Sure, I'll add CC_IS_CLANG here in the next version. Note that we do
check for compiler support before selecting ARCH_SUPPORTS_SHADOW_CALL_STACK.
The flags are architecture-specific, so the check is done in the arch Kconfig.

> > +config SHADOW_CALL_STACK_VMAP
> > +	bool "Use virtually mapped shadow call stacks"
> > +	depends on SHADOW_CALL_STACK
> > +	help
> > +	  Use virtually mapped shadow call stacks. Selecting this option
> > +	  provides better stack exhaustion protection, but increases per-thread
> > +	  memory consumption as a full page is allocated for each shadow stack.
> 
> Given that this feature applies only to arm64 kernels built with clang, it
> feels weird to further segment that userbase with another config option.
> Does Android enable SHADOW_CALL_STACK_VMAP? If not, maybe we should ditch
> it for now and add it when we have a user.

Android doesn't enable the VMAP option right now due to increased memory
overhead. I'll drop it from v12.

> > +/*
> > + * A random number outside the kernel's virtual address space to mark the
> > + * end of the shadow stack.
> > + */
> > +#define SCS_END_MAGIC	0xaf0194819b1635f6UL
> 
> This seems like it might be arm64-specific. Why not choose something based
> off CONFIG_ILLEGAL_POINTER_VALUE (see linux/poison.h)?

Sure, I'll use POISON_POINTER_DELTA here.

> > +static inline void *__scs_base(struct task_struct *tsk)
> 
> Please avoid using 'inline' in C files unless there's a good reason not
> to let the compiler figure it out.

Ack.

> > +{
> > +	/*
> > +	 * To minimize risk the of exposure, architectures may clear a
> 
> Should be "the risk of exposure".

Thanks.

> > +	 * The shadow call stack is aligned to SCS_SIZE, and grows
> > +	 * upwards, so we can mask out the low bits to extract the base
> > +	 * when the task is not running.
> > +	 */
> > +	return (void *)((unsigned long)task_scs(tsk) & ~(SCS_SIZE - 1));
> 
> Could we avoid forcing this alignment it we stored the SCS pointer as a
> (base,offset) pair instead? That might be friendlier on the allocations
> later on.

The idea is to avoid storing the current task's shadow stack address in
memory, which is why I would rather not store the base address either.

> > +static inline void scs_set_magic(void *s)
> > +{
> > +	*scs_magic(s) = SCS_END_MAGIC;
> 
> You added task_set_scs() for this sort of thing, so I'm not convinced you
> need this extra helper.

Agreed, I'll drop this.

> > +	if (s)
> > +		scs_set_magic(s);
> > +	/* TODO: poison for KASAN, unpoison in scs_free */
> 
> We don't usually commit these. What's missing?

At the time, KASAN didn't support poisoning vmalloc'ed memory, but looks
like that was fixed a while back.

> > +static int scs_cleanup(unsigned int cpu)
> > +{
> > +	int i;
> > +	void **cache = per_cpu_ptr(scs_cache, cpu);
> > +
> > +	for (i = 0; i < NR_CACHED_SCS; i++) {
> > +		vfree(cache[i]);
> > +		cache[i] = NULL;
> > +	}
> 
> Hmm, can this run concurrently with another CPU doing a stack allocation
> with this_cpu_cmpxchg()? It probably works out on arm64 thanks to the use
> of atomics, but we shouldn't be relying on that in core code.

This is essentially identical to the code in kernel/fork.c. Anyway, all
of this code goes away with the VMAP option.

> > +void __init scs_init(void)
> > +{
> > +	scs_cache = kmem_cache_create("scs_cache", SCS_SIZE, SCS_SIZE,
> > +				0, NULL);
> > +	WARN_ON(!scs_cache);
> 
> Memory allocation failure should be noisy enough without this.

Sure, I'll remove the warning.

> > +void scs_task_reset(struct task_struct *tsk)
> > +{
> > +	/*
> > +	 * Reset the shadow stack to the base address in case the task
> > +	 * is reused.
> > +	 */
> > +	task_set_scs(tsk, __scs_base(tsk));
> > +}
> 
> Why isn't this in the header?

> > +bool scs_corrupted(struct task_struct *tsk)
> > +{
> > +	unsigned long *magic = scs_magic(__scs_base(tsk));
> > +
> > +	return READ_ONCE_NOCHECK(*magic) != SCS_END_MAGIC;
> > +}
> 
> Same here.

I'll move both to the header file.

> > +void scs_release(struct task_struct *tsk)
> > +{
> > +	void *s;
> > +
> > +	s = __scs_base(tsk);
> > +	if (!s)
> > +		return;
> > +
> > +	WARN_ON(scs_corrupted(tsk));
> > +
> > +	task_set_scs(tsk, NULL);
> 
> Aren't we about to free the task here? What does clearing the scs pointer
> achieve?

True, it doesn't achieve much, only leaves one fewer shadow stack pointer
in memory. I'll drop this from the next version.

Sami
