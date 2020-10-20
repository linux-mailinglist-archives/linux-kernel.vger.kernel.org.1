Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7545E2937BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392625AbgJTJOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391111AbgJTJOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:14:08 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08232C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:14:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h20so1218618lji.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XILf1TitNgPwZdU8rNRrEBNDtKYyonEO028htn0pzI=;
        b=nB2l+1HXl3dOaS2PZrVTIcr3p5/9SMKS8f12EVEk7KK23Q+s0Xc9TgNw3iFzlgyVUq
         Znoapr+g0WvqnuBYbdFI1pM0Q2X6tN3NVfT0Po1XlaJqlwdKkFrPglO8vupj8OxQCSIe
         RuGDF6Awfnk5mBBfiDmPUMsPJnE4bQTgqzYguiozr6cLJ7AUxqHgeDPJ3FEieaubUptE
         KxEHOGIrcTsktonxP6s7JNZnMJ86c4NSpDGVjHeWLp8jX69PFHLMOyLzWpWlv9IYnItt
         EPdpKOIielY7CU8G/xn3Sh2zNfmPWK2E1He8hcxekBTXBCzYgChe7WcISBFSUsBtVRJN
         bPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XILf1TitNgPwZdU8rNRrEBNDtKYyonEO028htn0pzI=;
        b=VzkvpS3uOELs025FxoDXoCoBpAWQPI+8PAxdoULq9iRhvs0UpwMu5oyUN0F0FABshP
         RHVNrA/b1pQiy+csIwZMeNlN9BBQ40orxUqHBPHmzszUpEj+NcwmMvdJcRTQDPLE3edb
         Bqf71rszCUXRL10v17n+2yrPhFq3FRTVTJ5S1/PyLmx6CvDsczD7JoJj2aWZTLKiHaVx
         duT4Vn/g9g2QVpDX49Ii4DU3+dN2EjEyw/sPguvxVYobOENMbZkuw+3VhaZ5ykNxsVYe
         c1eWy0IkJBHPBU/urc1KNjTdFNaoRqrISti80UQgBx5PPcQ9lU40kc46R0Xo3ebbHNR2
         mIbg==
X-Gm-Message-State: AOAM530cTQeMKjP31JOs1YADPDCzUn5iE80QRoqUvgUmG+501p60ohYT
        k5P/nZp7hp3G9hplsB2pygulxOk2ux8st29wTY5IdQ==
X-Google-Smtp-Source: ABdhPJwqIdRN9gUyRMuuZtvq5jmDOe1lXpoqg4zoq+txYg23wb/Fm+E3mLWSHk4kXm2XfRq0c7Icy4j5w+05FLzl6IE=
X-Received: by 2002:a2e:a41b:: with SMTP id p27mr835731ljn.30.1603185246494;
 Tue, 20 Oct 2020 02:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-6-git-send-email-sumit.garg@linaro.org> <d4a4a37b93f34da79b87519181bffb97@kernel.org>
In-Reply-To: <d4a4a37b93f34da79b87519181bffb97@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 20 Oct 2020 14:43:54 +0530
Message-ID: <CAFA6WYMe02J6Laa0PWDW4849KGnw8Hu2H5d6UfppeaaE4-Z0vw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] arm64: ipi_nmi: Add support for NMI backtrace
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

On Mon, 19 Oct 2020 at 17:50, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-10-14 12:12, Sumit Garg wrote:
> > Enable NMI backtrace support on arm64 using IPI turned as an NMI
> > leveraging pseudo NMIs support. It is now possible for users to get a
> > backtrace of a CPU stuck in hard-lockup using magic SYSRQ.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/include/asm/irq.h |  6 ++++++
> >  arch/arm64/kernel/ipi_nmi.c  | 12 +++++++++++-
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/irq.h
> > b/arch/arm64/include/asm/irq.h
> > index b2b0c64..e840bf1 100644
> > --- a/arch/arm64/include/asm/irq.h
> > +++ b/arch/arm64/include/asm/irq.h
> > @@ -6,6 +6,12 @@
> >
> >  #include <asm-generic/irq.h>
> >
> > +#ifdef CONFIG_SMP
> > +extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
> > +                                        bool exclude_self);
> > +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> > +#endif
> > +
> >  struct pt_regs;
> >
> >  static inline int nr_legacy_irqs(void)
> > diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> > index e0a9e03..e1dc19d 100644
> > --- a/arch/arm64/kernel/ipi_nmi.c
> > +++ b/arch/arm64/kernel/ipi_nmi.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> >  #include <linux/kgdb.h>
> > +#include <linux/nmi.h>
> >  #include <linux/smp.h>
> >
> >  #include <asm/nmi.h>
> > @@ -25,12 +26,21 @@ void arch_send_call_nmi_func_ipi_mask(cpumask_t
> > *mask)
> >       __ipi_send_mask(ipi_desc, mask);
> >  }
> >
> > +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool
> > exclude_self)
> > +{
> > +     nmi_trigger_cpumask_backtrace(mask, exclude_self,
> > +                                   arch_send_call_nmi_func_ipi_mask);
> > +}
> > +
> >  static irqreturn_t ipi_nmi_handler(int irq, void *data)
> >  {
> >       unsigned int cpu = smp_processor_id();
> >
> > -     ipi_kgdb_nmicallback(cpu, get_irq_regs());
> > +     if (nmi_cpu_backtrace(get_irq_regs()))
> > +             goto out;
> >
> > +     ipi_kgdb_nmicallback(cpu, get_irq_regs());
> > +out:
> >       return IRQ_HANDLED;
> >  }
>
> Can't you have *both* a request for a backtrace and a KGDB call?
> It really shouldn't be either/or. It also outlines how well shared
> interrupts work with edge triggered signalling...

Unfortunately, NMIs doesn't seem to support shared mode [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/irq/manage.c#n1480

-Sumit

>
>          M.
> --
> Jazz is not dead. It just smells funny...
