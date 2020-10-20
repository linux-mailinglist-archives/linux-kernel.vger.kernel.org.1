Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB32E293728
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389633AbgJTIwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389596AbgJTIwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:52:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BBCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:52:04 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 184so1146081lfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Un3D4/T6ilGeRpZiqdkM650/Jk7htjxHR9MazqfDiC4=;
        b=y0mgbxStx7dP1CEylEL0KfYe8ot1qWi3yw6hgBxDWSkjp3KkdzSVVcV6nEVyxLx1E5
         7y8Gy1QhY7NLvt+MPs+vK5JBPtp2rKPaaxllHob1UvkNmOrKTfE27/fwR0d1GF/tZXUq
         ZwovWj7Wr+adDV0FqCyAaYZkoj8NGPnTkQZGHbJ+GTBGHlxUm4Lgc1biVbBZT1S+ASMj
         cs+CQ8kpdQcQF++MnntcADPiAf2yTrg0wAWnaqIoLbmlc7ClsxqD46U/y1XAR8gOO+y6
         DQiyvoe37GUJSmKhYkyGz/OkdI6fWdo2pZJ50PQ8rgPKaiOcBhMyIxCT1iNcHXr+KeRb
         dApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Un3D4/T6ilGeRpZiqdkM650/Jk7htjxHR9MazqfDiC4=;
        b=P+NKIw/FMbSV1OaMU7iDHs2MgStXiyS8iT4pUOqiFcmM0CZZik1sNvyz2sta/q/aO0
         XheIdp4Ton0xqcDeprd3QT+fUykHWcVHgCDVugco8e0UIHVa/DSztoLcnjIDmTjYbEAB
         IWp2vcv4KfLogIkEvxIUtQaEBdxO2xmVxC5pVdzBOWHXQkl+m0O44UOCLnJcF1OC3fUh
         jpTaAZrbdnu0wqgXAsLtsDpJ1Dv9CsKCbaegiIDb/bJFsIc4QveX8NWqnBGu7+xucG5Y
         8BPkBcyPuHZZSTgzUgadmAI+SixkJgoxmUKndrT2bRT3zQAb1wBBhRVJLuyIamAxLNmG
         v2RA==
X-Gm-Message-State: AOAM530iRKHzStklV2Uq9PBI1gkeeQsdHlYr5klmRLFoyKUwOj7486LS
        CD3yMhh01Ccm2Gk/64TSWQU5bIsL2xXosj4Tp9llXQ==
X-Google-Smtp-Source: ABdhPJzlkzvvJ39eQc8fUTC6Aujw1h4QwmN2302mCuEJjspiHgnRtnMviG1InjkheEfRgPlqWclNNP7HQKFVh/B07L0=
X-Received: by 2002:a05:6512:2029:: with SMTP id s9mr556509lfs.273.1603183922516;
 Tue, 20 Oct 2020 01:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-5-git-send-email-sumit.garg@linaro.org> <0899dcad304ac8bf0ea7d5308ec2e263@kernel.org>
In-Reply-To: <0899dcad304ac8bf0ea7d5308ec2e263@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 20 Oct 2020 14:21:51 +0530
Message-ID: <CAFA6WYMNKGYYvuFA1PoLz+CQS3B+7DEkbj6_k4bZ5euA37VXZA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] arm64: kgdb: Round up cpus using IPI as NMI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        julien.thierry.kdev@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Oct 2020 at 17:45, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-10-14 12:12, Sumit Garg wrote:
> > arm64 platforms with GICv3 or later supports pseudo NMIs which can be
> > leveraged to round up CPUs which are stuck in hard lockup state with
> > interrupts disabled that wouldn't be possible with a normal IPI.
> >
> > So instead switch to round up CPUs using IPI turned as NMI. And in
> > case a particular arm64 platform doesn't supports pseudo NMIs,
> > this IPI will act as a normal IPI which maintains existing kgdb
> > functionality.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/include/asm/kgdb.h |  8 ++++++++
> >  arch/arm64/kernel/ipi_nmi.c   |  5 ++++-
> >  arch/arm64/kernel/kgdb.c      | 21 +++++++++++++++++++++
> >  3 files changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/kgdb.h
> > b/arch/arm64/include/asm/kgdb.h
> > index 21fc85e..6f3d3af 100644
> > --- a/arch/arm64/include/asm/kgdb.h
> > +++ b/arch/arm64/include/asm/kgdb.h
> > @@ -24,6 +24,14 @@ static inline void arch_kgdb_breakpoint(void)
> >  extern void kgdb_handle_bus_error(void);
> >  extern int kgdb_fault_expected;
> >
> > +#ifdef CONFIG_KGDB
> > +extern void ipi_kgdb_nmicallback(int cpu, void *regs);
> > +#else
> > +static inline void ipi_kgdb_nmicallback(int cpu, void *regs)
> > +{
> > +}
> > +#endif
> > +
> >  #endif /* !__ASSEMBLY__ */
> >
> >  /*
> > diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> > index a959256..e0a9e03 100644
> > --- a/arch/arm64/kernel/ipi_nmi.c
> > +++ b/arch/arm64/kernel/ipi_nmi.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> > +#include <linux/kgdb.h>
> >  #include <linux/smp.h>
> >
> >  #include <asm/nmi.h>
> > @@ -26,7 +27,9 @@ void arch_send_call_nmi_func_ipi_mask(cpumask_t
> > *mask)
> >
> >  static irqreturn_t ipi_nmi_handler(int irq, void *data)
> >  {
> > -     /* nop, NMI handlers for special features can be added here. */
> > +     unsigned int cpu = smp_processor_id();
> > +
> > +     ipi_kgdb_nmicallback(cpu, get_irq_regs());
>
> Please add a return value to ipi_kgdb_nmicallback(), and check it
> before returning IRQ_HANDLED.

Okay.

>
> Thinking a bit more about the whole thing, you should have a way to
> avoid requesting the NMI if there is no user for it (there is nothing
> worse than an enabled interrupt without handlers...).

I think IPIs or SGIs (for arm64) are different from normal interrupts
in this aspect as if there is no handler then we can be sure that
corresponding SGI won't be invoked as their invocation is controlled
via software.

This is the similar case with other IPIs as well whose handlers are
optionally enabled, see:
- IPI_CPU_CRASH_STOP
- IPI_TIMER
- IPI_IRQ_WORK
- IPI_WAKEUP

>
> >
> >       return IRQ_HANDLED;
> >  }
> > diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> > index 1a157ca3..0991275 100644
> > --- a/arch/arm64/kernel/kgdb.c
> > +++ b/arch/arm64/kernel/kgdb.c
> > @@ -17,6 +17,7 @@
> >
> >  #include <asm/debug-monitors.h>
> >  #include <asm/insn.h>
> > +#include <asm/nmi.h>
> >  #include <asm/traps.h>
> >
> >  struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
> > @@ -353,3 +354,23 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt
> > *bpt)
> >       return aarch64_insn_write((void *)bpt->bpt_addr,
> >                       *(u32 *)bpt->saved_instr);
> >  }
> > +
> > +void ipi_kgdb_nmicallback(int cpu, void *regs)
> > +{
> > +     if (atomic_read(&kgdb_active) != -1)
> > +             kgdb_nmicallback(cpu, regs);
> > +}
> > +
> > +#ifdef CONFIG_SMP
>
> There is no such thing as an arm64 UP kernel.
>

Okay, will remove this #ifdef.

> > +void kgdb_roundup_cpus(void)
> > +{
> > +     struct cpumask mask;
> > +
> > +     cpumask_copy(&mask, cpu_online_mask);
> > +     cpumask_clear_cpu(raw_smp_processor_id(), &mask);
> > +     if (cpumask_empty(&mask))
> > +             return;
> > +
> > +     arch_send_call_nmi_func_ipi_mask(&mask);
>
> Surely you can come up with a less convoluted name for this function.
> arm64_send_nmi() would be plenty in my opinion.

Okay, will use it instead.

-Sumit

>
> > +}
> > +#endif
>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
