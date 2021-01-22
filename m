Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15433005CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbhAVOoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbhAVOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:43:59 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:43:18 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n7so3837479pgg.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8bgmkMu+cEZTApSrRWB5HvcRNQrWEtcL1QXInWauDE=;
        b=NeoXBeCQTaBfud0qeGvNFuMr/rKj66QvWFM/IlVGMLebhgbIjVYG/Q6nIJK8NHK4Sl
         ZrCHxkfZB34O1u0AGm9SyRwva/f6qn7eADga01VuQt6Hrsr1HEeH0p+I+1tGTRVYevdU
         rTr62El/rkdJEtLHPeRqNieKnHqWchSW1n1hevFfFgxO+NdGIsTph017WxPSAJMavRa3
         f87cEf6FZlZj5HEsWA1wjvzDE89n4zDhyMkmIZCd30Rs/r0Fmve8V2TyAWjdxSeiJ3+t
         Ji0I49Swxf/pjTgXXjghSfPCO2ffTJLT+FX7DJI3bccoTbRZyM1Ldph3zsohEomYDKUO
         7gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8bgmkMu+cEZTApSrRWB5HvcRNQrWEtcL1QXInWauDE=;
        b=tRrYO1aIVg6lNfSbz+KXB1uWltUiGmN8eN9itY5VnWkJ18ACN93S43gGC0Dv5PVv8B
         P0zGxGKoQROVEx0p35c6e+GdZ4ZKNNrNn7sSv3xEvjTIdmAh7FL13iJ1XOK+uZbvA5a0
         LCFH4+iypnWFwEpXBG3/WSxVHn828b555DgrOkn3nseiZfc2k/rZESrlGwMimjav/7Tx
         o7v3IGPnr82mC7poxFfL785KKOC0z3gB8QVKdQ1d4Prl5mI46hgj0crMVVVIqJuh5kY3
         9O65xqubiOQ88JQoEr0rNug2F54b716bHkhrW8Job/1ASD/nBZ76bl7E1Gorzp1KkGol
         ZUJQ==
X-Gm-Message-State: AOAM530OjLTbqTF7tlU4rMEoK5/ubT5MtTxRmzdY7PbuVKdmwdSh0oAv
        qoA03wHqnzVY/an/KVtn59dr4HhwEhAvWdLy9duKPg==
X-Google-Smtp-Source: ABdhPJwZyepCdNKfGlPfCypXOczzVQ5ENvAvpY6c8KVu1VmKtWT2y8Yq0nxaek3yvF1bCknMNjrag0Lm33hRtWeNhMA=
X-Received: by 2002:a65:430b:: with SMTP id j11mr4790496pgq.130.1611326598171;
 Fri, 22 Jan 2021 06:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20210122141125.36166-1-vincenzo.frascino@arm.com> <20210122141125.36166-5-vincenzo.frascino@arm.com>
In-Reply-To: <20210122141125.36166-5-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 22 Jan 2021 15:43:07 +0100
Message-ID: <CAAeHK+zdcVJDYzXupc7Uq43toRZT3CKoJJNwJkdipoDNMMqbng@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] arm64: mte: Enable async tag check fault
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 3:11 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
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
> The dsb(nsh) in mte_check_tfsr_exit() is provisional pending
> confirmation by the architects.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/mte.h     | 32 +++++++++++++++++++++++
>  arch/arm64/kernel/entry-common.c |  6 +++++
>  arch/arm64/kernel/mte.c          | 44 ++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
>
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index d02aff9f493d..237bb2f7309d 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -92,5 +92,37 @@ static inline void mte_assign_mem_tag_range(void *addr, size_t size)
>
>  #endif /* CONFIG_ARM64_MTE */
>
> +#ifdef CONFIG_KASAN_HW_TAGS
> +void mte_check_tfsr_el1(void);
> +
> +static inline void mte_check_tfsr_entry(void)
> +{
> +       mte_check_tfsr_el1();
> +}
> +
> +static inline void mte_check_tfsr_exit(void)
> +{
> +       /*
> +        * The asynchronous faults are sync'ed automatically with
> +        * TFSR_EL1 on kernel entry but for exit an explicit dsb()
> +        * is required.
> +        */
> +       dsb(nsh);
> +       isb();
> +
> +       mte_check_tfsr_el1();
> +}
> +#else
> +static inline void mte_check_tfsr_el1(void)
> +{
> +}
> +static inline void mte_check_tfsr_entry(void)
> +{
> +}
> +static inline void mte_check_tfsr_exit(void)
> +{
> +}
> +#endif /* CONFIG_KASAN_HW_TAGS */
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_MTE_H  */
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 5346953e4382..31666511ba67 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -37,6 +37,8 @@ static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
>         lockdep_hardirqs_off(CALLER_ADDR0);
>         rcu_irq_enter_check_tick();
>         trace_hardirqs_off_finish();
> +
> +       mte_check_tfsr_entry();
>  }
>
>  /*
> @@ -47,6 +49,8 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs)
>  {
>         lockdep_assert_irqs_disabled();
>
> +       mte_check_tfsr_exit();
> +
>         if (interrupts_enabled(regs)) {
>                 if (regs->exit_rcu) {
>                         trace_hardirqs_on_prepare();
> @@ -243,6 +247,8 @@ asmlinkage void noinstr enter_from_user_mode(void)
>
>  asmlinkage void noinstr exit_to_user_mode(void)
>  {
> +       mte_check_tfsr_exit();
> +
>         trace_hardirqs_on_prepare();
>         lockdep_hardirqs_on_prepare(CALLER_ADDR0);
>         user_enter_irqoff();
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 92078e1eb627..7763ac1f2917 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -182,6 +182,37 @@ bool mte_report_once(void)
>         return READ_ONCE(report_fault_once);
>  }
>
> +#ifdef CONFIG_KASAN_HW_TAGS
> +void mte_check_tfsr_el1(void)
> +{
> +       u64 tfsr_el1;
> +
> +       if (!system_supports_mte())
> +               return;
> +
> +       tfsr_el1 = read_sysreg_s(SYS_TFSR_EL1);
> +
> +       /*
> +        * The kernel should never trigger an asynchronous fault on a
> +        * TTBR0 address, so we should never see TF0 set.
> +        * For futexes we disable checks via PSTATE.TCO.
> +        */
> +       WARN_ONCE(tfsr_el1 & SYS_TFSR_EL1_TF0,
> +                 "Kernel async tag fault on TTBR0 address");
> +
> +       if (unlikely(tfsr_el1 & SYS_TFSR_EL1_TF1)) {
> +               /*
> +                * Note: isb() is not required after this direct write
> +                * because there is no indirect read subsequent to it
> +                * (per ARM DDI 0487F.c table D13-1).
> +                */
> +               write_sysreg_s(0, SYS_TFSR_EL1);
> +
> +               kasan_report_async();
> +       }
> +}
> +#endif
> +
>  static void update_sctlr_el1_tcf0(u64 tcf0)
>  {
>         /* ISB required for the kernel uaccess routines */
> @@ -247,6 +278,19 @@ void mte_thread_switch(struct task_struct *next)
>         /* avoid expensive SCTLR_EL1 accesses if no change */
>         if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
>                 update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
> +       else
> +               isb();
> +
> +       /*
> +        * Check if an async tag exception occurred at EL1.
> +        *
> +        * Note: On the context switch path we rely on the dsb() present
> +        * in __switch_to() to guarantee that the indirect writes to TFSR_EL1
> +        * are synchronized before this point.
> +        * isb() above is required for the same reason.
> +        *
> +        */
> +       mte_check_tfsr_el1();
>  }
>
>  void mte_suspend_exit(void)
> --
> 2.30.0
>

Acked-by: Andrey Konovalov <andreyknvl@google.com>
