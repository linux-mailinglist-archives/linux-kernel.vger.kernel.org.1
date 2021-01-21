Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6222FF23D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388926AbhAURoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388921AbhAURjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:39:05 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587CEC061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:38:18 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f17so3419775ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDrQK38YWH6ufWHF22W6c9HR6S6Bjf6Z7SDs/k7GPu0=;
        b=QASvLy/un3A5BYYqY03or/BBTYWXyk6fdBL2nVZY1JFzsp9KxJwUb9tTrbfUqvboSm
         BzfHtJ130thPxcezY/cP6b4+WdONAD2lBRVH9518JwKqUDUePE8VIeRlKqFvhxeNOFbw
         cLh6QlY06uftHc60DMaYZUw+ncznTUWVqjfWBUxZ10uay6ayhbDh5kLXmJ7VV6C43A0X
         ZfQel9HScxRx9SOxPuIycvgsNKJ4/e0WKtN3OWLeciDNqJ85LTQPgerF2zqbeyLjZvIu
         T08nN/4G9nxR5rtpMQm2bYQOOZKyOQucUswV+vvUwftFj9TS1Y6mjawaotT6h+Qdqt2P
         OK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDrQK38YWH6ufWHF22W6c9HR6S6Bjf6Z7SDs/k7GPu0=;
        b=pxj5g+Vdy7F1E+1VEA5r8Hsy251LcqvOAuzmS25k/rBKXphFLODqQ7+MjlTES5yowA
         RuVIToJyX4IjQ59oXe8LqnnEqEWWo/pAppGBnpglLBT5dNCim+nctZ9UGAXkEUhRo1h7
         fWZkdzqau6UQTpyOyspwnYyXO3S5iGC3NLw37l5mLflV8LY1WZi8qh1HjIEpmL1LIkZP
         6hK5Sqg1DpOvA3QjCPkB+Sft5YO083A4GtlOUkQ82FttPOtdomXS/iZCE9PpWNpYYskO
         3pZy1dVQ6gQlerOxy9SDBw1blfEIEJtYwiCybiv5BnjWomIe8w4a2LkswbKf4ctXpQLu
         KKOA==
X-Gm-Message-State: AOAM530ZXIg4hYWq/O3vR/IKDkdxxDkYVPK7ArymNFZXkixw/cdk1TQm
        cV2TW3N29WNcw/rFWk/J3CdHkX70/1HJsIu0bAy/6s8b/SdMJA==
X-Google-Smtp-Source: ABdhPJwqQGpM533YqvCwhnF/6Z/497QMU2XNggpqjvf1i9DL5ICm6e3oXcoQO9NlLTDwNA68K0gOGSNCZ4FGeaIWhy8=
X-Received: by 2002:a2e:918d:: with SMTP id f13mr196763ljg.321.1611250696597;
 Thu, 21 Jan 2021 09:38:16 -0800 (PST)
MIME-Version: 1.0
References: <20210121163943.9889-1-vincenzo.frascino@arm.com> <20210121163943.9889-5-vincenzo.frascino@arm.com>
In-Reply-To: <20210121163943.9889-5-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 21 Jan 2021 18:38:05 +0100
Message-ID: <CAAeHK+y9HbV6yVJ0f819Y=_6ijkKq06rqJSY+mh4NF4qd8t_oA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] arm64: mte: Enable async tag check fault
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

On Thu, Jan 21, 2021 at 5:40 PM Vincenzo Frascino
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

Do we need a static bool reported like in do_tag_recovery() here?

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
