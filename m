Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AF42FF0BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388219AbhAUQnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733096AbhAUQlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:41:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A09523A54
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611247233;
        bh=puSY6uhE0WSvNJj3Ra4/jrZiRTQj5xzHz1Mnh6amjVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RKPz+W5dnwEknFMKsoy4SzAS4BJvarJlMokvPGn5I3ULtVf6wtfIV3pY6x5zaXtyf
         Zs1OEGM08q88qQIR0u6zo1QjnDsFfdx8dzq4SrDVCw+3lErDLAWwOgWb7LLQFJD6UG
         dr+/hDcChz/YFYQmNhXr9Z2ZLLh0XQnlDtO68kevFT2DwW0osXriBljLxmGmCTZ5s7
         Sy+2ZOSgjekIvoTHGa+4rCg4n+UgzmHP6Y0xdOv1r93LdquilGRyyQyxNlAZ65Vbw+
         kv8QoIfxAQJTPj4UwLzKwXL9/kblg2zVymsNbHmJ9O8T3pxMBQtcLhV64Hbmtwp7/j
         GrvTJiPsP/E7A==
Received: by mail-ed1-f49.google.com with SMTP id b2so3267497edm.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 08:40:33 -0800 (PST)
X-Gm-Message-State: AOAM5335ERds/WRXJru3LyXcHsCKuPxYwQ0HJ4buj+/R8GjShJ+VSnuj
        CXLtM7Ep/LsNPYOLFYgcuYSkcRWhx/lF6ppxUQ==
X-Google-Smtp-Source: ABdhPJxvpkfC/5dDivh89wg+nSyrWVVNwuQ0JsmZCEpFOCrEISk4ujD4yuIQM5MSsJ6d3Zz7sn9itcUaCzYRsktcm1I=
X-Received: by 2002:a50:e78b:: with SMTP id b11mr11884224edn.165.1611247231619;
 Thu, 21 Jan 2021 08:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com> <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
 <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
In-Reply-To: <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 Jan 2021 10:40:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJq_wfLrJm8rwspkgz81Be2V9WTudRjMAXSrZD50ewFYA@mail.gmail.com>
Message-ID: <CAL_JsqJq_wfLrJm8rwspkgz81Be2V9WTudRjMAXSrZD50ewFYA@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 6:52 AM Mohamed Mediouni
<mohamed.mediouni@caramail.com> wrote:
>
>
>
> > On 21 Jan 2021, at 13:44, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
> > <mohamed.mediouni@caramail.com> wrote:
> >
> >> +#ifdef CONFIG_SMP
> >> +static void apple_aic_ipi_send_mask(struct irq_data *d,
> >> +                                   const struct cpumask *mask)
> >
> > Not sure we care about the #ifdef here, given that arch/arm64 does not
> > allow building a kernel without CONFIG_SMP.
> >
> >> +       /*
> >> +     * Ensure that stores to Normal memory are visible to the
> >> +     * other CPUs before issuing the IPI.
> >> +     */
> >> +       wmb();
> >> +
> >> +       for_each_cpu (cpu, mask) {
> >> +               smp_mb__before_atomic();
> >> +               atomic_or(1u << irqnr, per_cpu_ptr(&aic_ipi_mask, cpu)=
);
> >> +               smp_mb__after_atomic();
> >> +               lcpu =3D get_cpu();
> >> +               if (aic.fast_ipi) {
> >> +                       if ((lcpu >> 2) =3D=3D (cpu >> 2))
> >> +                               write_sysreg(cpu & 3, SR_APPLE_IPI_LOC=
AL);
> >> +                       else
> >> +                               write_sysreg((cpu & 3) | ((cpu >> 2) <=
< 16),
> >> +                                            SR_APPLE_IPI_REMOTE);
> >> +               } else
> >> +                       writel(lcpu =3D=3D cpu ? REG_IPI_FLAG_SELF :
> >> +                                                  (REG_IPI_FLAG_OTHER=
 << cpu),
> >> +                              aic.base + REG_IPI_SET);
> >> +               put_cpu();
> >> +       }
> >> +
> >> +       /* Force the above writes to be executed */
> >> +       if (aic.fast_ipi)
> >> +               isb();
> >> +}
> >
> > Since this just loops over all CPUs, I'd probably just turn it into
> > an ipi_send_single() callback and have the caller do the
> > loop for simplicity.
> >
> > I also have the feeling that splitting one hardware IPI into multiple
> > logical interrupts, which are then all registered by the same irq
> > handler adds a little more complexity than necessary.
> >
> > Changing this would of course require modifications to
> > arch/arm64/kernel/smp.c, which is hardwired to use
> > CONFIG_GENERIC_IRQ_IPI in smp_cross_call(), and allowing
> > a different code path there may be worse than emulating an
> > irqchip.
> >
> >> @@ -186,8 +325,11 @@ static int __init apple_aic_init(struct device_no=
de *node,
> >>       if (WARN(!aic.base, "unable to map aic registers\n"))
> >>               return -EINVAL;
> >>
> >> +       aic.fast_ipi =3D of_property_read_bool(node, "fast-ipi");
> >
> > Where is this property documented, and what decides which one to use?
> It=E2=80=99s getting documented in the next patch set.
>
> This property is there to enable support for older iPhone processors
> later on, some of which do not have fast IPI support.
>
> On Apple M1, fast-ipi is always on.

This should be implied by the compatible string which needs to be more
specific and include the SoC name.

Rob
