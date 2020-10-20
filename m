Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6387A2935B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405055AbgJTHZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405036AbgJTHZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:25:07 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB811C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:25:06 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c21so886535ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFAymQB2VOJ4KqiBW6CIIX7WVz/95SQLzKrOC+AcK7M=;
        b=UU9fv3TX1Idl0ZF5nRqwPtZqh2KrQur59xb/KO68AV619Hi683xOkZPqV0DprRVr9C
         pcLP4tpdvcQwwnmg6vA1E4KUlU7e4Rlb8/cTOIOxTCgwcnYUlnUsmM50q0X22F+09m3g
         lYA0iwCXt64o8BKSbCRA+tSSFePqB+k+zXChXsNCo51epWTnXUwj3swFHL/Po7/+2j6I
         3p0fM71PSmHp7FSRXep/2DPiMfanrUXBLnoCebm4iyn2uwonBI8CLRSDhezsFpH11bSG
         o57k44SMRg+fbmJGatt68vRgwCRnnlAAuViJSOZbK+3tgeDB8pH1EeMdCH4jETlJbwTm
         /+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFAymQB2VOJ4KqiBW6CIIX7WVz/95SQLzKrOC+AcK7M=;
        b=mGfhKnhVqYAB5MoY1pT/q9wpMDdbk4mmhHVIUaqjm38J8+0XZeDKdJ02Cops/PTk1G
         81pQbKO6JdUsbL5W3ETvH1IDdpG4aZyzkPQcuf5CGxi4Gf0gqv61SbzYM4JUm6rg/aR4
         EJCfrfuesZdqEgAgkjURLZxwQHuk1dr9oa2Q/ysjIdIi+G1HFTz2NwcHpTRaRkJ+RlBk
         bGja0olFt5xEMXt/g1J0CVoTNVTa6uulQ5ZjfYxnav3i8ysHKXplUNPnbGDnSI67N6nA
         wWPUEWOGc+yx/2Z4eu6FEzxtvBHVfVmwqcEgKf1/AadmbVH6XH+vChsnIOoJi708TCSh
         4oTg==
X-Gm-Message-State: AOAM5314Rjk0oh+gxgg1mypYb2a3eNjLoTQzEO6lELWV8JQa5ImcmjNm
        xE6P0yYYt4K8QkWjezNd4bvDR+xfwDQT/sdsnqqToQ==
X-Google-Smtp-Source: ABdhPJzICliDiG4TEYZv/LnXNOTyuv/fLxshlpvP4WJfDe5kyAJCZ1j6frOcxjozui1tsGRvMnuCxXV16CPYd6o/To8=
X-Received: by 2002:a2e:9a9a:: with SMTP id p26mr537984lji.4.1603178705428;
 Tue, 20 Oct 2020 00:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-3-git-send-email-sumit.garg@linaro.org> <294754db12f4cd8a8ec9329a44e1cf02@kernel.org>
In-Reply-To: <294754db12f4cd8a8ec9329a44e1cf02@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 20 Oct 2020 12:54:53 +0530
Message-ID: <CAFA6WYNAVsYTLtzHQvnJOTKG5E4iUo6FNTCQ8zHzg3_hm42kOA@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] irqchip/gic-v3: Enable support for SGIs to act as NMIs
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

On Mon, 19 Oct 2020 at 17:37, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-10-14 12:12, Sumit Garg wrote:
> > Add support to handle SGIs as regular NMIs. As SGIs or IPIs defaults to
> > a
>
> There is nothing "regular" about NMIs.

Okay, will do s/regular/pseudo/.

> Drop "or IPIs".
> s/defaults/default/
>

Ack.

> > special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI
> > handler update in case of SGIs.
> >
> > Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
> > as IRQs/NMIs happen as part of this routine.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3.c
> > b/drivers/irqchip/irq-gic-v3.c
> > index 16fecc0..5efc865 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -477,6 +477,11 @@ static int gic_irq_nmi_setup(struct irq_data *d)
> >       if (WARN_ON(gic_irq(d) >= 8192))
> >               return -EINVAL;
> >
> > +     if (get_intid_range(d) == SGI_RANGE) {
> > +             gic_irq_set_prio(d, GICD_INT_NMI_PRI);
> > +             return 0;
> > +     }
> > +
>
> Please follow the existing control flow, or rework it to be organised by
> range.

Okay.

>
> >       /* desc lock should already be held */
> >       if (gic_irq_in_rdist(d)) {
> >               u32 idx = gic_get_ppi_index(d);
> > @@ -514,6 +519,11 @@ static void gic_irq_nmi_teardown(struct irq_data
> > *d)
> >       if (WARN_ON(gic_irq(d) >= 8192))
> >               return;
> >
> > +     if (get_intid_range(d) == SGI_RANGE) {
> > +             gic_irq_set_prio(d, GICD_INT_DEF_PRI);
> > +             return;
> > +     }
>
> Same here.

Okay.

-Sumit

>
> > +
> >       /* desc lock should already be held */
> >       if (gic_irq_in_rdist(d)) {
> >               u32 idx = gic_get_ppi_index(d);
> > @@ -1708,6 +1718,7 @@ static int __init gic_init_bases(void __iomem
> > *dist_base,
> >
> >       gic_dist_init();
> >       gic_cpu_init();
> > +     gic_enable_nmi_support();
> >       gic_smp_init();
> >       gic_cpu_pm_init();
> >
> > @@ -1719,8 +1730,6 @@ static int __init gic_init_bases(void __iomem
> > *dist_base,
> >                       gicv2m_init(handle, gic_data.domain);
> >       }
> >
> > -     gic_enable_nmi_support();
> > -
> >       return 0;
> >
> >  out_free:
>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
