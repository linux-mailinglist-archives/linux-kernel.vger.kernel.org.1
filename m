Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B728F2F7FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbhAOPiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:38:50 -0500
Received: from foss.arm.com ([217.140.110.172]:43068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbhAOPiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:38:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0E60D6E;
        Fri, 15 Jan 2021 07:38:03 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F28C3F70D;
        Fri, 15 Jan 2021 07:37:59 -0800 (PST)
Date:   Fri, 15 Jan 2021 15:37:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v3 3/4] arm64: mte: Enable async tag check fault
Message-ID: <20210115153756.GC44111@C02TD0UTHF1T.local>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115120043.50023-4-vincenzo.frascino@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 12:00:42PM +0000, Vincenzo Frascino wrote:
> MTE provides a mode that asynchronously updates the TFSR_EL1 register
> when a tag check exception is detected.
> 
> To take advantage of this mode the kernel has to verify the status of
> the register at:
>   1. Context switching
>   2. Return to user/EL0 (Not required in entry from EL0 since the kernel
>   did not run)
>   3. Kernel entry from EL1
>   4. Kernel exit to EL1
> 
> If the register is non-zero a trace is reported.
> 
> Add the required features for EL1 detection and reporting.
> 
> Note: ITFSB bit is set in the SCTLR_EL1 register hence it guaranties that
> the indirect writes to TFSR_EL1 are synchronized at exception entry to
> EL1. On the context switch path the synchronization is guarantied by the
> dsb() in __switch_to().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/mte.h     | 21 +++++++++++++++++++
>  arch/arm64/kernel/entry-common.c | 11 ++++++++++
>  arch/arm64/kernel/mte.c          | 35 ++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index d02aff9f493d..1a715963d909 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -92,5 +92,26 @@ static inline void mte_assign_mem_tag_range(void *addr, size_t size)
>  
>  #endif /* CONFIG_ARM64_MTE */
>  
> +#ifdef CONFIG_KASAN_HW_TAGS
> +void mte_check_tfsr_el1_no_sync(void);
> +static inline void mte_check_tfsr_el1(void)
> +{
> +	mte_check_tfsr_el1_no_sync();
> +	/*
> +	 * The asynchronous faults are synch'ed automatically with

Nit: can we please use "sync" rather than "synch", to match what we do
elsewhere, e.g. mte_check_tfsr_el1_no_sync immediately above. The
inconsistency is unfortunate and distracting.

> +	 * TFSR_EL1 on kernel entry but for exit an explicit dsb()
> +	 * is required.
> +	 */
> +	dsb(ish);
> +}

Did you mean to have the barrier /before/ checking the TFSR? I'm
confused as to why it's after the check if the point of it is to ensure
that TFSR has been updated.

I don't understand this difference between the entry/exit paths; are you
relying on a prior DSB in the entry path?

Is the DSB alone sufficient to update the TFSR (i.e. is an indirect
write ordered before a direct read)? ... or do you need a DSB + ISB
here?

It's probably worth a comment as to why the ISH domain is correct here
rather than NSH or SY. I'm not entirely certain if ISH is necessary or
sufficient, but it depends on the completion rules.

[...]

> >  
>  /*
> @@ -47,6 +49,13 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> +	/*
> +	 * The dsb() in mte_check_tfsr_el1() is required to relate
> +	 * the asynchronous tag check fault to the context in which
> +	 * it happens.
> +	 */
> +	mte_check_tfsr_el1();

I think this comment is misplaced, given that mte_check_tfsr_el1() isn't
even in the same file.

If you need to do different things upon entry/exit, I'd rather we had
separate functions, e.g.

* mte_check_tfsr_entry();
* mte_check_tfsr_exit();

... since then it's immediately obvious in context as to whether we're
using the right function, and then we can have a comment within each of
the functions explaining what we need to do in that specific case.

>  	if (interrupts_enabled(regs)) {
>  		if (regs->exit_rcu) {
>  			trace_hardirqs_on_prepare();
> @@ -243,6 +252,8 @@ asmlinkage void noinstr enter_from_user_mode(void)
>  
>  asmlinkage void noinstr exit_to_user_mode(void)
>  {
> +	mte_check_tfsr_el1();
> +
>  	trace_hardirqs_on_prepare();
>  	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
>  	user_enter_irqoff();
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index df7a1ae26d7c..6cb92e9d6ad1 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -180,6 +180,32 @@ void mte_enable_kernel(enum kasan_hw_tags_mode mode)
>  	isb();
>  }
>  
> +#ifdef CONFIG_KASAN_HW_TAGS
> +void mte_check_tfsr_el1_no_sync(void)
> +{
> +	u64 tfsr_el1;
> +
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

I thing it's worth spelling out what TF0 == 1 means, e.g.

	/*
	 * The kernel should never trigger an asynchronous fault on a
	 * TTBR0 address, so we should never see TF0 set.
	 * For futexes we disable checks via PSTATE.TCO.
	 */

... what about regular uaccess using LDTR/STTR? What happens for those?

> +	WARN_ON(tfsr_el1 & SYS_TFSR_EL1_TF0);

It's probably worth giving this a message so that we can debug it more
easily, e.g.

	WARN(tfsr_el1 & SYS_TFSR_EL1_TF0,
	     "Kernel async tag fault on TTBR0 address");

> +	if (tfsr_el1 & SYS_TFSR_EL1_TF1) {

It might be worth wrapping this with an unlikely(), given we hope this
never happens.

Thanks,
Mark.

> +		write_sysreg_s(0, SYS_TFSR_EL1);
> +		isb();
> +
> +		pr_err("MTE: Asynchronous tag exception detected!");
> +	}
> +}
> +#endif
> +
>  static void update_sctlr_el1_tcf0(u64 tcf0)
>  {
>  	/* ISB required for the kernel uaccess routines */
> @@ -245,6 +271,15 @@ void mte_thread_switch(struct task_struct *next)
>  	/* avoid expensive SCTLR_EL1 accesses if no change */
>  	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
>  		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
> +
> +	/*
> +	 * Check if an async tag exception occurred at EL1.
> +	 *
> +	 * Note: On the context switch path we rely on the dsb() present
> +	 * in __switch_to() to guarantee that the indirect writes to TFSR_EL1
> +	 * are synchronized before this point.
> +	 */
> +	mte_check_tfsr_el1_no_sync();
>  }
>  
>  void mte_suspend_exit(void)
> -- 
> 2.30.0
> 
