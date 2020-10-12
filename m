Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD65428B489
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbgJLMWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388435AbgJLMWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:22:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE749C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 05:22:01 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id v6so2494193lfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5uQKNQALLpgdlcTiZCyohg/vJ9Vde3kITcCMI00DlQ=;
        b=fH1zJ8HNuzgC60t5ViAk9wobk5pi7MSyH6EQtPWXeKAkvU1+wFJwnDKDCH+5OXyLuD
         i0pUDSAybOWvKqXkDBqeUHASMki1bAWBTU6h0D24P2LGwXUg6fxYa6F1gjUoVkGOxCxJ
         pwAWe8wtsAXiWGmn7HpaYLfM0q0oB5LIE534+F9HXYpYzGGBUfc5Ult49JHJbUPZDvld
         41oB/DyCB6Euh9i0HARmgGQpH4g8jeuRT2GBq16P66xwlH9KbFcCj0PpMCB2QTBKlNKf
         cefMeLc5VWEDV3JUfUeIvdlgkYGNt3DeUOuk0a1nvlJI/s084FpiiF8bXxV3XmQ2EatQ
         2KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5uQKNQALLpgdlcTiZCyohg/vJ9Vde3kITcCMI00DlQ=;
        b=JdwHlm2L+FSkbhj/C3PDX1zJB+LXdUodSg56Ax/MUYqL1+MH8tl+Ec3U9LDTaFtv4E
         4IpucBujV0nIA7vG8X+hBR+ennLru5uMPXnisCXERMans7tWZ7DbBX7PtwncWVOQ9vjN
         CmTAIAPD+grOvrDoZdIU1sQ2ukDZRp3Aqa/xl5vJBvEWoX3/ZdE/SHPM9M2ydpHugBZU
         6WuOBD4Pf6cU6HD3Vo6tiaOdorZlxeBbmVrEH21JF/A+vV+AjcG133wh4tS5WVH/M2jx
         4NPlZMvUaJTSptVHvHngKkTbEEfTRoTVZ/W4oGH5YOY5xwwpr0nFYc+YdXEx1jFhAsIW
         /Tfg==
X-Gm-Message-State: AOAM532ZmLt/kOlLL0Er61tFuaMeiWUgg1qZHC10QL+QxKjSNBi+Ebyp
        kvYMCSWM0eR1ns/e0Xgi9ARaLpK/qEkGOwe1LnJsr1Ib9Ij6Cg==
X-Google-Smtp-Source: ABdhPJxbxACdsPa8z7j3x1/jLOi3qgxjqlWljUhX9hvtHIj3G232T1dQ5fDBy5Aqdasp98jFz6v+6WJI0jlW2ywbYEs=
X-Received: by 2002:a19:c88c:: with SMTP id y134mr7465078lff.283.1602505320370;
 Mon, 12 Oct 2020 05:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
 <1599830924-13990-2-git-send-email-sumit.garg@linaro.org> <20201010015855.vksetnj4luft5enc@gabell>
In-Reply-To: <20201010015855.vksetnj4luft5enc@gabell>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 12 Oct 2020 17:51:49 +0530
Message-ID: <CAFA6WYMkLq_TuP+98y15FJT--hK24WHeVnDWc46DMmNE08WP3A@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] arm64: Add framework to turn IPI as NMI
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        julien.thierry.kdev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Oct 2020 at 07:28, Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
> Hi Sumit,
>
> On Fri, Sep 11, 2020 at 06:58:40PM +0530, Sumit Garg wrote:
> > Introduce framework to turn an IPI as NMI using pseudo NMIs. In case a
> > particular platform doesn't support pseudo NMIs, then request IPI as a
> > regular IRQ.
> >
> > The main motivation for this feature is to have an IPI that can be
> > leveraged to invoke NMI functions on other CPUs. And current prospective
> > users are NMI backtrace and KGDB CPUs round-up whose support is added
> > via future patches.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/include/asm/nmi.h | 16 +++++++++
> >  arch/arm64/kernel/Makefile   |  2 +-
> >  arch/arm64/kernel/ipi_nmi.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 97 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/include/asm/nmi.h
> >  create mode 100644 arch/arm64/kernel/ipi_nmi.c
> >
> > diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
> > new file mode 100644
> > index 0000000..3433c55
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/nmi.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_NMI_H
> > +#define __ASM_NMI_H
> > +
> > +#ifndef __ASSEMBLER__
> > +
> > +#include <linux/cpumask.h>
> > +
> > +extern void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask);
> > +
> > +void set_smp_ipi_nmi(int ipi);
> > +void ipi_nmi_setup(int cpu);
> > +void ipi_nmi_teardown(int cpu);
> > +
> > +#endif /* !__ASSEMBLER__ */
> > +#endif
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index a561cbb..022c26b 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -19,7 +19,7 @@ obj-y                       := debug-monitors.o entry.o irq.o fpsimd.o              \
> >                          return_address.o cpuinfo.o cpu_errata.o              \
> >                          cpufeature.o alternative.o cacheinfo.o               \
> >                          smp.o smp_spin_table.o topology.o smccc-call.o       \
> > -                        syscall.o
> > +                        syscall.o ipi_nmi.o
> >
> >  targets                      += efi-entry.o
> >
> > diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> > new file mode 100644
> > index 0000000..355ef92
> > --- /dev/null
> > +++ b/arch/arm64/kernel/ipi_nmi.c
> > @@ -0,0 +1,80 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * NMI support for IPIs
> > + *
> > + * Copyright (C) 2020 Linaro Limited
> > + * Author: Sumit Garg <sumit.garg@linaro.org>
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/smp.h>
> > +
> > +#include <asm/nmi.h>
> > +
> > +static struct irq_desc *ipi_desc __read_mostly;
> > +static int ipi_id __read_mostly;
> > +static bool is_nmi __read_mostly;
> > +
> > +void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask)
> > +{
> > +     if (WARN_ON_ONCE(!ipi_desc))
> > +             return;
> > +
> > +     __ipi_send_mask(ipi_desc, mask);
> > +}
> > +
> > +static irqreturn_t ipi_nmi_handler(int irq, void *data)
> > +{
> > +     /* nop, NMI handlers for special features can be added here. */
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +void ipi_nmi_setup(int cpu)
> > +{
> > +     if (!ipi_desc)
> > +             return;
>
> ipi_nmi_setup() may be called twice for CPU0:
>
>   set_smp_ipi_range => set_smp_ipi_nmi => ipi_nmi_setup
>                     => ipi_setup => ipi_nmi_setup
>
> Actually, I got the following error message via the second ipi_nmi_setup():
>
>   GICv3: Pseudo-NMIs enabled using relaxed ICC_PMR_EL1 synchronisation
>   GICv3: Cannot set NMI property of enabled IRQ 8
>   genirq: Failed to setup NMI delivery: irq 8
>
> Why don't we have a check to prevent that? Like as:
>
>        if (cpumask_test_cpu(cpu, ipi_desc->percpu_enabled))
>                return;
>

See my reply in the other thread.

> > +
> > +     if (is_nmi) {
> > +             if (!prepare_percpu_nmi(ipi_id))
> > +                     enable_percpu_nmi(ipi_id, 0);
>
> It would be better to use IRQ_TYPE_NONE instead of 0.
>
>                         enable_percpu_nmi(ipi_id, IRQ_TYPE_NONE);
>

Ack.

> > +     } else {
> > +             enable_percpu_irq(ipi_id, 0);
>
> Same as here:
>                 enable_percpu_irq(ipi_id, IRQ_TYPE_NONE);
>

Ack.

-Sumit

> Thanks,
> Masa
>
> > +     }
> > +}
> > +
> > +void ipi_nmi_teardown(int cpu)
> > +{
> > +     if (!ipi_desc)
> > +             return;
> > +
> > +     if (is_nmi) {
> > +             disable_percpu_nmi(ipi_id);
> > +             teardown_percpu_nmi(ipi_id);
> > +     } else {
> > +             disable_percpu_irq(ipi_id);
> > +     }
> > +}
> > +
> > +void __init set_smp_ipi_nmi(int ipi)
> > +{
> > +     int err;
> > +
> > +     err = request_percpu_nmi(ipi, ipi_nmi_handler, "IPI", &cpu_number);
> > +     if (err) {
> > +             err = request_percpu_irq(ipi, ipi_nmi_handler, "IPI",
> > +                                      &cpu_number);
> > +             WARN_ON(err);
> > +             is_nmi = false;
> > +     } else {
> > +             is_nmi = true;
> > +     }
> > +
> > +     ipi_desc = irq_to_desc(ipi);
> > +     irq_set_status_flags(ipi, IRQ_HIDDEN);
> > +     ipi_id = ipi;
> > +
> > +     /* Setup the boot CPU immediately */
> > +     ipi_nmi_setup(smp_processor_id());
> > +}
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
