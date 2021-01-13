Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8202F51BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbhAMSMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbhAMSMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:12:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D14C233ED;
        Wed, 13 Jan 2021 18:11:24 +0000 (UTC)
Date:   Wed, 13 Jan 2021 18:11:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 3/4] arm64: mte: Enable async tag check fault
Message-ID: <20210113181121.GF27045@gaia>
References: <20210107172908.42686-1-vincenzo.frascino@arm.com>
 <20210107172908.42686-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107172908.42686-4-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 05:29:07PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index d02aff9f493d..a60d3718baae 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -39,6 +39,7 @@ void mte_free_tag_storage(char *storage);
>  /* track which pages have valid allocation tags */
>  #define PG_mte_tagged	PG_arch_2
>  
> +void mte_check_tfsr_el1(void);
>  void mte_sync_tags(pte_t *ptep, pte_t pte);
>  void mte_copy_page_tags(void *kto, const void *kfrom);
>  void flush_mte_state(void);
> @@ -56,6 +57,9 @@ void mte_assign_mem_tag_range(void *addr, size_t size);
>  /* unused if !CONFIG_ARM64_MTE, silence the compiler */
>  #define PG_mte_tagged	0
>  
> +static inline void mte_check_tfsr_el1(void)
> +{
> +}

I think we should enable this dummy function when !CONFIG_KASAN_HW_TAGS.
It saves us an unnecessary function call in a few places.

>  static inline void mte_sync_tags(pte_t *ptep, pte_t pte)
>  {
>  }
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 5346953e4382..74b020ce72d7 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -37,6 +37,8 @@ static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
>  	lockdep_hardirqs_off(CALLER_ADDR0);
>  	rcu_irq_enter_check_tick();
>  	trace_hardirqs_off_finish();
> +
> +	mte_check_tfsr_el1();
>  }
>  
>  /*
> @@ -47,6 +49,8 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> +	mte_check_tfsr_el1();
> +
>  	if (interrupts_enabled(regs)) {
>  		if (regs->exit_rcu) {
>  			trace_hardirqs_on_prepare();
> @@ -243,6 +247,8 @@ asmlinkage void noinstr enter_from_user_mode(void)
>  
>  asmlinkage void noinstr exit_to_user_mode(void)
>  {
> +	mte_check_tfsr_el1();

While for kernel entry the asynchronous faults are sync'ed automatically
with TFSR_EL1, we don't have this for exit, so we'd need an explicit
DSB. But rather than placing it here, it's better if we add a bool sync
argument to mte_check_tfsr_el1() which issues a dsb() before checking
the register. I think that's the only place where such argument would be
true (for now).

> +
>  	trace_hardirqs_on_prepare();
>  	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
>  	user_enter_irqoff();
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 5d992e16b420..26030f0b79fe 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -185,6 +185,34 @@ void mte_enable_kernel(enum kasan_arg_mode mode)
>  	isb();
>  }
>  
> +void mte_check_tfsr_el1(void)
> +{
> +	u64 tfsr_el1;
> +
> +	if (!IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> +		return;

If we define the static inline when !CONFIG_KASAN_HW_TAGS, we could add
the #ifdef here around the whole function.

> +	if (!system_supports_mte())
> +		return;
> +
> +	tfsr_el1 = read_sysreg_s(SYS_TFSR_EL1);
> +
> +	/*
> +	 * The kernel should never hit the condition TF0 == 1
> +	 * at this point because for the futex code we set
> +	 * PSTATE.TCO.
> +	 */
> +	WARN_ON(tfsr_el1 & SYS_TFSR_EL1_TF0);
> +
> +	if (tfsr_el1 & SYS_TFSR_EL1_TF1) {
> +		write_sysreg_s(0, SYS_TFSR_EL1);
> +		isb();
> +
> +		pr_err("MTE: Asynchronous tag exception detected!");
> +	}
> +}
> +NOKPROBE_SYMBOL(mte_check_tfsr_el1);

Do we need this to be NOKPROBE_SYMBOL? It's not that low level.

> +
>  static void update_sctlr_el1_tcf0(u64 tcf0)
>  {
>  	/* ISB required for the kernel uaccess routines */
> @@ -250,6 +278,15 @@ void mte_thread_switch(struct task_struct *next)
>  	/* avoid expensive SCTLR_EL1 accesses if no change */
>  	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
>  		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
> +
> +	/*
> +	 * Check if an async tag exception occurred at EL1.
> +	 *
> +	 * Note: On the context switch patch we rely on the dsb() present

s/patch/path/

> +	 * in __switch_to() to guaranty that the indirect writes to TFSR_EL1

s/guaranty/guarantee/ (well, still valid though I think rarely used).

> +	 * are synchronized before this point.
> +	 */
> +	mte_check_tfsr_el1();
>  }
>  
>  void mte_suspend_exit(void)
> -- 
> 2.30.0

-- 
Catalin
