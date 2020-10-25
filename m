Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815832980F5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 10:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414760AbgJYJSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 05:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1414752AbgJYJSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 05:18:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C580C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 02:18:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c194so8212883wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RaBV5OGSgizc6bOjbQAcBV6/+c0YkBXr0HBp0wiO2C4=;
        b=qYv8LP6BYP30hyFi4I6uJhDIbsZqGNJF95Lmm3CTlq9IUd4PeCDyeYWr8v613s8Zi0
         2bRuHQc/zWhruysDT2dcdfX9OOPxPxdhka9SmHSfXWqIz/l0MuDenz82f2i1J1+nUmZg
         2KGvYs8CdmSHYH8z6sMgVd2KIQpwxPCpyj0k/P/46aWsHMyk9qNKgFdKfrUmML82RMuq
         xkfSknx0o03zd1B16lde5AKl8y3jHaicMAytC83hSY+C7LzAUhv0FREpbpzn1v1m2Ebf
         CenGAa8vi2+9E/+Xxuu7WpTkxZM06TzMvfXD8VdUQtb1HpRPecK1f9SFQkkbetLTCxV2
         Ew6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaBV5OGSgizc6bOjbQAcBV6/+c0YkBXr0HBp0wiO2C4=;
        b=Yhtd6SToj9yb3Bnt/q3lxxBtrtFEYLx/3vpb7HAVImV0n3hDnED0OR10zCP+ROmRyg
         PI+nwfoO4U8VX0usqbUpjHTkVWJYxaThUnUnp7uvnuVp9HxMDokiOUq8Ft9Gt2Xs9eIt
         YuqXDx67T/Uh3sAkvrl56WaovvoWMBWhc1wdqVcvUE4ssqcbB3eD7DToVNKM+4gP59kt
         S+rRuSfilATB8GhG9s1HawUw+BqHpKfWmIy2fuWdPkXsVfb6+ACqDDHprv8N6v6mgPep
         h9JbBCkVp7VTcm4Sr0InxufDclU1auR90vxyrieoKqcHshA+PGRDbAf5mfHkH6Qt5LqQ
         6Wgg==
X-Gm-Message-State: AOAM530Je9DhYl1u8CxbTEjMt4vhU56bCVM9l/JKzOScc8hybglAupvI
        8RrxBj2034APFnV/aE3ejGqmizrJUW+JSAqu9Cx7+Q==
X-Google-Smtp-Source: ABdhPJzqljm3rNjuFJ0TcMA11xsO/2wA5XDCmDKyV+cnBRdnwYg9pK3iZWkiGftU6hNatz9ef03f2R7TCanD3XDyUCg=
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr11184462wml.134.1603617478740;
 Sun, 25 Oct 2020 02:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <1603448245-79429-1-git-send-email-guoren@kernel.org>
 <CAAhSdy1rqZBt5LSgs9yQwewwKXvaS23ou5Ah7Xfu3n7S9sK6RA@mail.gmail.com> <CAJF2gTQtcKf0R-8nJK=Jb5BdQZ1giZTEuqHjZdHEU4Gks-i+Qw@mail.gmail.com>
In-Reply-To: <CAJF2gTQtcKf0R-8nJK=Jb5BdQZ1giZTEuqHjZdHEU4Gks-i+Qw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 25 Oct 2020 14:47:47 +0530
Message-ID: <CAAhSdy3sQuErgEXp-cc15d=wJpFh6THe0dCMCQy4W-MO8ud5KQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] irqchip/irq-sifive-plic: Fixup wrong size of
 xxx_PER_HART and reg base
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, wesley@sifive.com,
        Yash Shah <yash.shah@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 8:40 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Fri, Oct 23, 2020 at 8:31 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Fri, Oct 23, 2020 at 3:48 PM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > ENABLE and CONTEXT registers contain M & S status for per-hart, so
> > > ref to the specification the correct definition is double to the
> > > current value.
> > >
> > > The value of hart_base and enable_base should be calculated by real
> > > physical hartid not software id. Sometimes the CPU node's <reg>
> > > from dts is not equal to the sequence index.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > ---
> > >  drivers/irqchip/irq-sifive-plic.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > > index eaa3e9f..2e56576 100644
> > > --- a/drivers/irqchip/irq-sifive-plic.c
> > > +++ b/drivers/irqchip/irq-sifive-plic.c
> > > @@ -44,16 +44,16 @@
> > >   * Each hart context has a vector of interrupt enable bits associated with it.
> > >   * There's one bit for each interrupt source.
> > >   */
> > > -#define ENABLE_BASE                    0x2000
> > > -#define     ENABLE_PER_HART            0x80
> > > +#define ENABLE_BASE                    0x2080
> > > +#define     ENABLE_PER_HART            0x100
> > >
> > >  /*
> > >   * Each hart context has a set of control registers associated with it.  Right
> > >   * now there's only two: a source priority threshold over which the hart will
> > >   * take an interrupt, and a register to claim interrupts.
> > >   */
> > > -#define CONTEXT_BASE                   0x200000
> > > -#define     CONTEXT_PER_HART           0x1000
> > > +#define CONTEXT_BASE                   0x201000
> > > +#define     CONTEXT_PER_HART           0x2000
> > >  #define     CONTEXT_THRESHOLD          0x00
> > >  #define     CONTEXT_CLAIM              0x04
> > >
> > > @@ -358,10 +358,10 @@ static int __init plic_init(struct device_node *node,
> > >                 cpumask_set_cpu(cpu, &priv->lmask);
> > >                 handler->present = true;
> > >                 handler->hart_base =
> > > -                       priv->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
> > > +                       priv->regs + CONTEXT_BASE + hartid * CONTEXT_PER_HART;
> > >                 raw_spin_lock_init(&handler->enable_lock);
> > >                 handler->enable_base =
> > > -                       priv->regs + ENABLE_BASE + i * ENABLE_PER_HART;
> > > +                       priv->regs + ENABLE_BASE + hartid * ENABLE_PER_HART;
> > >                 handler->priv = priv;
> > >  done:
> > >                 for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
> > > --
> > > 2.7.4
> > >
> >
> > There is no one-to-one mapping between PLIC context and HARTID. Instead,
> > we have many-to-one mapping between PLIC contexts and HARTID. In other
> > words, we have one PLIC context for each interrupt capable mode (i.e.
> > M/S-mode) of each HART.
> >
> > For example, on SiFive Unleashed we have 5 HARTs but HARTID=0 has
> > only M-mode capable of taking interrupts so we have total (1 + 2x4) = 9
> > PLIC contexts.
> That's OK, but what the bug I want to point out is enable_base &
> context_base should be calculated by 'hartid' not 'i'.

There is no relation between PLIC context number and HART IDs. The
PLIC context to HART mapping is discovered from the "interrupts-extended"
DT property of PLIC DT node. The "i" in the loop is PLIC context number.

The PLIC spec does not mandate any ordering/pattern of PLIC context to
HART mappings. Also, the interrupts-extended DT property is generic
enough to represent any kind of PLIC context to HART mappings.

Your patch breaks SiFive Unleashed board and NoMMU kernel because
of incorrect assumptions about PLIC contexts to HART mappings.

>
> For example, how we deal with below dts configuration:
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 timebase-frequency = <3000000>;
>                 cpu@0 {
>                         device_type = "cpu";
>                         reg = <2>;  //********* different from index
>                         status = "okay";
>                         compatible = "riscv";
>                         riscv,isa = "rv64imafdcsu";
>                         mmu-type = "riscv,sv39";
>                         cpu0_intc: interrupt-controller {
>                                 #interrupt-cells = <1>;
>                                 compatible = "riscv,cpu-intc";
>                                 interrupt-controller;
>                         };
>                 };
>                 cpu@1 {
>                         device_type = "cpu";
>                         reg = <3>; //********* different from index
>                         status = "fail";
>                         compatible = "riscv";
>                         riscv,isa = "rv64imafdcsu";
>                         mmu-type = "riscv,sv39";
>                         cpu1_intc: interrupt-controller {
>                                 #interrupt-cells = <1>;
>                                 compatible = "riscv,cpu-intc";
>                                 interrupt-controller;
>                         };
>                 };
>       }

For above DTS configuration, we need a PLIC with just 4 contexts
(irrespective to the HART IDs).

The PLIC context to HART mapping can be described using the
interrupts-extended DT property of PLIC DT node as follows:
    interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9
                                         &cpu1_intc 11 &cpu1_intc 9>;

>
> >
> > I would also like to highlight that this patch is forcing PLIC driver to always
> > use PLIC S-mode context for each HART which breaks the Linux RISC-V
> > NoMMU kernel.
> Yes, I forgot M-mode and I will correct it.
>
> >
> > There is no issue with the existing defines because these are aligned with
> > above and latest PLIC spec.
> > (Refer, https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc)
> >
> > NACK to this patch from my side.
>
> Here is my new patch which fixup m-mode linux:
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c
> b/drivers/irqchip/irq-sifive-plic.c
> index 4048657..e34e1d9 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -45,7 +45,13 @@
>   * There's one bit for each interrupt source.
>   */
>  #define ENABLE_BASE                    0x2000
> -#define     ENABLE_PER_HART            0x80
> +#define     ENABLE_PER_HART            0x100
> +#ifdef CONFIG_RISCV_M_MODE
> +#define     ENABLE_OFFSET              0
> +#else
> +#define     ENABLE_OFFSET              0x80
> +#endif
> +
>
>  /*
>   * Each hart context has a set of control registers associated with it.  Right
> @@ -53,9 +59,14 @@
>   * take an interrupt, and a register to claim interrupts.
>   */
>  #define CONTEXT_BASE                   0x200000
> -#define     CONTEXT_PER_HART           0x1000
> +#define     CONTEXT_PER_HART           0x2000
>  #define     CONTEXT_THRESHOLD          0x00
>  #define     CONTEXT_CLAIM              0x04
> +#ifdef CONFIG_RISCV_M_MODE
> +#define     CONTEXT_OFFSET             0
> +#else
> +#define     CONTEXT_OFFSET             0x1000
> +#endif
>
>  #define        PLIC_DISABLE_THRESHOLD          0x7
>  #define        PLIC_ENABLE_THRESHOLD           0
> @@ -358,10 +369,10 @@ static int __init plic_init(struct device_node *node,
>                 cpumask_set_cpu(cpu, &priv->lmask);
>                 handler->present = true;
>                 handler->hart_base =
> -                       priv->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
> +                       priv->regs + CONTEXT_BASE + hartid *
> CONTEXT_PER_HART + CONTEXT_OFFSET;
>                 raw_spin_lock_init(&handler->enable_lock);
>                 handler->enable_base =
> -                       priv->regs + ENABLE_BASE + i * ENABLE_PER_HART;
> +                       priv->regs + ENABLE_BASE + hartid *
> ENABLE_PER_HART + ENABLE_OFFSET;
>                 handler->priv = priv;
>  done:
>                 for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
>

This modified patch still breaks SiFive Unleashed board because
it has following PLIC context to HART mappings:
PLIC_context_0 (offset 0x0000) => HART0_M_mode_irq
PLIC_context_1 (offset 0x1000) => HART1_M_mode_irq
PLIC_context_2 (offset 0x2000) => HART1_S_mode_irq
PLIC_context_3 (offset 0x3000) => HART2_M_mode_irq
PLIC_context_4 (offset 0x4000) => HART2_S_mode_irq
PLIC_context_5 (offset 0x5000) => HART3_M_mode_irq
PLIC_context_6 (offset 0x6000) => HART3_S_mode_irq
PLIC_context_7 (offset 0x7000) => HART4_M_mode_irq
PLIC_context_8 (offset 0x8000) => HART4_S_mode_irq

As-per your patch, the Linux S-mode kernel will use
PLIC_context_3 (offset 0x3000) for HART1 which is in-correct
because PLIC_context_3 maps to HART2 M-mode IRQ.

Further with your patch, the Linux M-mode kernel will use
PLIC_context_2 (offset 0x2000) for HART1 which is in-correct
because PLIC_context_2 maps to HART1 S-mode IRQ.

Clearly your modified patch breaks both Linux S-mode kernel
and Linux M-mode kernel on SiFive Unleashed board.

The current driver handles all above cases correctly by parsing
the PLIC context to HART mappings from the interrupts-extended
DT property. I don't see any bug here.

Regards,
Anup
