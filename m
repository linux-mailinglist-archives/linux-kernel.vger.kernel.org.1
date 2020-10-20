Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7446A29351D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 08:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404456AbgJTGoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 02:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbgJTGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:44:11 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017E5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 23:44:11 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l28so721111lfp.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 23:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKisSdPFhHMNCtICMhbcUEw2QFiANpq0wtVTr5Ou8mA=;
        b=pczU+Uf/yI647JWhv0sya2r4YrL9tI4JWCh6LvA9chOvYy2GPBsRbEcTC20uK+3d6E
         rFY5Ijutq6Aqt+btCji2ciQ/aMCrRRuCVyN+bB1C1tcjLN2RIReFjomdZiLY3Oohp2iQ
         BxsAJXNfO1swTyvUzivQOWeLDKMvhwkQplSJzMdJcBLE+savmOmxCZ73APJpj+grPYpf
         XHtE2s326Yq/nWId6foQABkSQosJ7jRCMezMiLuI01YXOmKjtCkI/EV9g7REp2aNOGxa
         d1heWwjBQ0zzxTSYWoumVf/sNlmsF9n+ZTsApPCHtloEtp4oAigfLkoNNFzE0sQ/9sB8
         VTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKisSdPFhHMNCtICMhbcUEw2QFiANpq0wtVTr5Ou8mA=;
        b=rjwGpJw4irxs9DrmrMDIHAzDLTHxhofzr4/pZAK5D0rKPqXtk1ONrQGtDiI/Cu+0a0
         DU1zNjMut8seli4krTBRcE/OMAgJSZbO0MzpnTpXcQEH+CJKvmTvStiyxMqYx4hDb/Lj
         CLUsNpF7HjszD5uYJcdLb8yh7v2U3zaZqpNYuqBP6Jcoxbww2qDjs9OUN2usO/3UYVIW
         TZ/GbyffKnEeTcLxP1502dTCkuL8+8j8Rh8BFPZ6tNHLVgHslV1e2VBmQ4Ygl/+B6M1S
         BfdDzttix+oju7lyK2Z54hLtAsaPjz83Mo1Xz/Ew0P30LNYJRwHChoveJ8zT6Ih1UOJu
         x+YQ==
X-Gm-Message-State: AOAM531QPEutKRCZVNCBIDSodMQePNVethOcSvLfViziAlu133ee5lTv
        9EALNWcp0bYkuUVcvNzv+9dI4a7POtJNks3VD568aA==
X-Google-Smtp-Source: ABdhPJxCfdB+h+Yd0esHC1CUz+lgNJ2ChJECAocPjHWHYswWINkY1Vts8K7Hv2oG2TJTut9zB+s4+DYfxlB6AcqL55g=
X-Received: by 2002:a05:6512:2029:: with SMTP id s9mr405613lfs.273.1603176249396;
 Mon, 19 Oct 2020 23:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-2-git-send-email-sumit.garg@linaro.org> <fbf6bfecf344a06af94e17ccabb817dd@kernel.org>
In-Reply-To: <fbf6bfecf344a06af94e17ccabb817dd@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 20 Oct 2020 12:13:57 +0530
Message-ID: <CAFA6WYPEw5x_3zDZSnkL23YjFWbF=VkUKefM6Ts46JLVaj2sDA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] arm64: Add framework to turn IPI as NMI
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

On Mon, 19 Oct 2020 at 17:07, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-10-14 12:12, Sumit Garg wrote:
> > Introduce framework to turn an IPI as NMI using pseudo NMIs. In case a
> > particular platform doesn't support pseudo NMIs, then request IPI as a
> > regular IRQ.
> >
> > The main motivation for this feature is to have an IPI that can be
> > leveraged to invoke NMI functions on other CPUs. And current
> > prospective
> > users are NMI backtrace and KGDB CPUs round-up whose support is added
> > via future patches.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/include/asm/nmi.h | 16 +++++++++
> >  arch/arm64/kernel/Makefile   |  2 +-
> >  arch/arm64/kernel/ipi_nmi.c  | 77
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 94 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/include/asm/nmi.h
> >  create mode 100644 arch/arm64/kernel/ipi_nmi.c
> >
> > diff --git a/arch/arm64/include/asm/nmi.h
> > b/arch/arm64/include/asm/nmi.h
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
> > index bbaf0bc..525a1e0 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -17,7 +17,7 @@ obj-y                       := debug-monitors.o entry.o irq.o fpsimd.o              \
> >                          return_address.o cpuinfo.o cpu_errata.o              \
> >                          cpufeature.o alternative.o cacheinfo.o               \
> >                          smp.o smp_spin_table.o topology.o smccc-call.o       \
> > -                        syscall.o proton-pack.o
> > +                        syscall.o proton-pack.o ipi_nmi.o
> >
> >  targets                      += efi-entry.o
> >
> > diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> > new file mode 100644
> > index 0000000..a959256
> > --- /dev/null
> > +++ b/arch/arm64/kernel/ipi_nmi.c
> > @@ -0,0 +1,77 @@
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
>
> This definitely is the *wrong* default. If nothing is explicitly
> handling the interrupt, it should be reported as such to the core
> code to be disabled if this happens too often.

Okay will fix default as "IRQ_NONE".

>
> > +}
> > +
> > +void ipi_nmi_setup(int cpu)
>
> The naming is awful. "ipi" is nowhere specific enough (we already have
> another 7 of them), and this doesn't necessarily uses pseudo-NMIs, since
> you are requesting IRQs.

How about following naming conventions?

- dynamic_ipi_setup()
- dynamic_ipi_teardown()
- set_smp_dynamic_ipi()

>
> > +{
> > +     if (!ipi_desc)
> > +             return;
> > +
> > +     if (is_nmi) {
> > +             if (!prepare_percpu_nmi(ipi_id))
> > +                     enable_percpu_nmi(ipi_id, IRQ_TYPE_NONE);
> > +     } else {
> > +             enable_percpu_irq(ipi_id, IRQ_TYPE_NONE);
>
> I'm not keen on this. Normal IRQs can't reliably work, so why do you
> even bother with this?

Yeah I agree but we need to support existing functionality for kgdb
roundup and sysrq backtrace using normal IRQs as well.

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
>
> Updating global state without checking for errors doesn't seem
> like a great move.

Are you worried about failure from request_percpu_irq()? If yes, there
is an explicit warning for that and if you like I can add an
additional check while updating the global state.

BTW, this is written on an existing pattern as for other 7 IPIs requests [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/smp.c#n988

-Sumit

>
>          M.
> --
> Jazz is not dead. It just smells funny...
