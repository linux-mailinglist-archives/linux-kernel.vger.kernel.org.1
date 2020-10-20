Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D651F293599
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404917AbgJTHRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbgJTHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:17:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F46C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:17:03 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b1so814398lfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqfbzt/qDzJfLfhorr1LgGLqTXS/OCrC1Rjql2HHPMM=;
        b=pixOfe/LlMMXGSm5PFqV3GzwGaKRnNcGMQ53dh3WqtVVHs0AD14SBQ+hAFp9Q2lVRx
         yiXswGWtZ/4iFHOPdQjxW6wcevek2jcW50T8J7cTP5ToK6xYthpqI4rrxp81Xkp33Q5/
         xV5GIvIS3aX0bkgfKjQhX3RRMnD82YVvIIW54i+i5Idjd3GF+C5VQi2jwc9tcuOj/p0W
         gQJmjen7UIpB64+r0H5CUmYRCQuAiJwOfWrAplFfZk46xxPudigz2StWhTrUWMzVr4Dj
         xqy9cdhyLRFT0RQ4RR8ZaiokWwu4rhmu0KfGjpUXYcgn1/LDhMitUbw43wYvCkSunBjs
         ZXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqfbzt/qDzJfLfhorr1LgGLqTXS/OCrC1Rjql2HHPMM=;
        b=giJYvECNbQjJA6iqUOAXCaROgm9Df6kreJGwdVgvLWADMQnkUJU6wnBWns7pt/+KEq
         knsJBQ9S5LXSvPHql2JchAoXBoD/QFdPz2KQE621IRntDYd6tH2vlvOscd4qkdO2DCUw
         NcO+vSFvAXngQ7MsBeh08y0IgqnXIYtnmoPBXlQpxfe0SVo+YV1HsqDysJCO3LVohoTA
         QJhLHaql3mKsk6qsgzvjOxYABmQrh+7W46ml5QrhC87BC7xbqZqcnldPMFHBmc8J2zgm
         2V/Xau02VojId7WRWHDG4GU920aedbZ06qNu/o+VW+XrrjbVGtwzT19ZWEN+A/XBPVAh
         MMoA==
X-Gm-Message-State: AOAM532y/tpLcikWB8yDT8AoKqs0PjPfgc7M8NMtQ2koqmGCiW64LSpv
        Q7gwnNJ14vtZMUzBV7R4KQxtX9RmrfjonVvZDKvXtQ==
X-Google-Smtp-Source: ABdhPJyljvU8t34fPXWrkGHEmjcTnmj0A7FHynrsuw2TPqALkHhNoboqAWhvd41VpIUiw+zC9Vv/rdO+co9ft5k0ZCk=
X-Received: by 2002:a05:6512:2029:: with SMTP id s9mr445264lfs.273.1603178222429;
 Tue, 20 Oct 2020 00:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-4-git-send-email-sumit.garg@linaro.org> <1c68b74251dc72b0cd74706280ea96f7@kernel.org>
In-Reply-To: <1c68b74251dc72b0cd74706280ea96f7@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 20 Oct 2020 12:46:51 +0530
Message-ID: <CAFA6WYODXzOoH=NiurikiK6wepsdfmnmUd4BzEJnguaSGzW7GQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] arm64: smp: Allocate and setup IPI as NMI
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

On Mon, 19 Oct 2020 at 17:29, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-10-14 12:12, Sumit Garg wrote:
> > Allocate an unused IPI that can be turned as NMI using ipi_nmi
> > framework.
>
> This doesn't do any allocation, as far as I can see. It relies on
> the initial grant from the interrupt controller to be larger than
> what the kernel currently uses.
>

Okay, will update the commit message as s/Allocate/Assign/.

-Sumit

> > Also, invoke corresponding NMI setup/teardown APIs.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/kernel/smp.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 82e75fc..129ebfb 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -43,6 +43,7 @@
> >  #include <asm/daifflags.h>
> >  #include <asm/kvm_mmu.h>
> >  #include <asm/mmu_context.h>
> > +#include <asm/nmi.h>
> >  #include <asm/numa.h>
> >  #include <asm/processor.h>
> >  #include <asm/smp_plat.h>
> > @@ -962,6 +963,8 @@ static void ipi_setup(int cpu)
> >
> >       for (i = 0; i < nr_ipi; i++)
> >               enable_percpu_irq(ipi_irq_base + i, 0);
> > +
> > +     ipi_nmi_setup(cpu);
> >  }
> >
> >  #ifdef CONFIG_HOTPLUG_CPU
> > @@ -974,6 +977,8 @@ static void ipi_teardown(int cpu)
> >
> >       for (i = 0; i < nr_ipi; i++)
> >               disable_percpu_irq(ipi_irq_base + i);
> > +
> > +     ipi_nmi_teardown(cpu);
> >  }
> >  #endif
> >
> > @@ -995,6 +1000,9 @@ void __init set_smp_ipi_range(int ipi_base, int n)
> >               irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
> >       }
> >
> > +     if (n > nr_ipi)
> > +             set_smp_ipi_nmi(ipi_base + nr_ipi);
> > +
> >       ipi_irq_base = ipi_base;
> >
> >       /* Setup the boot CPU immediately */
>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
