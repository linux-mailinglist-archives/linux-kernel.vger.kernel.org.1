Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316D5294BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 13:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441999AbgJUL26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 07:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439472AbgJUL25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:28:57 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6F1C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 04:28:57 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l2so2716035lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 04:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=knV9gjJnChMkbAAiapGos/nisqISwxGUwQ5ICUY9SUg=;
        b=oMwjGu5d2QaBow29jk3uxXPBSRt8XIJ8K6FbgrAPZwob9UZo3Mpw0ulnFdejS93Gg8
         cCd4dH3Mc6Z6EN+d8nXFPrQEptH2oGjL5KkqoMJRpsxsg6ljjPb8xFzLkGEGGbxFO+LY
         dNXHTbYRQbZ8MndYi/CHz9l080sCjAf2OUsdXlXSbAH346wOhwGVGpEsd+OnHjw4fApn
         jB5XYQKrxC31hBKBxiwTv4qMUOYTbOnPJm98bSiZP5nzXOaMLYjencOygWm/CKAB0pya
         HF1jS/vqyWpbykdrfebjbUDh+4A9a337H237d8KTggS55sQgYhv6vC07RYS4WSZWBXg2
         8YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knV9gjJnChMkbAAiapGos/nisqISwxGUwQ5ICUY9SUg=;
        b=VY7E9hWzcC76Fg9xuhHBGiGyI1AqoaOTOX1GrH7i3FYZQobi8ZM7n2YbhiDqeXl1Wu
         PXQQZjxhblVntIQjs2NkrJ9jRf9Z+bIQbXW1aEVVQufnKB/49kEJWALn6jqgfNOGK6U6
         nq93TOiWBw08cu5qSnSiQSXhI0RmEg+cygE7xae0LY3DrV8TA9Ew6jkSa35wgpYhQ6Bm
         /TXOT2mWV4ojPcZU4O+Uj+Wl4jBv5y4vukoBi8wWcWT8xCkNVyZuRvPZgUsxAoaDy8h3
         FlIdZpydsR/Bgv+6wHTtQ2gw/BzCAFBgrL0I6rNYuIIeEjnvEWjf6cZyGJel6pqFy7Mu
         mgAg==
X-Gm-Message-State: AOAM530rlcTRF5QB91qCgD5u+3sQCC1dqjNcJ9K0oPAzaw/yxf77JfT4
        Da/maW5/Ju1PkOz3hMyMwpzUUfbg9OU216TAG+50JA==
X-Google-Smtp-Source: ABdhPJyuJ7hRS8+AqAbMw+ZkSx/THvGKLhyC9h+4LUxQMRvKxEKbRpYz9J3KZlQPEqYZpRLlvhNRtoVRvH+ZUeLc0CU=
X-Received: by 2002:a19:5cb:: with SMTP id 194mr977000lff.205.1603279735968;
 Wed, 21 Oct 2020 04:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-6-git-send-email-sumit.garg@linaro.org> <d4a4a37b93f34da79b87519181bffb97@kernel.org>
 <CAFA6WYMe02J6Laa0PWDW4849KGnw8Hu2H5d6UfppeaaE4-Z0vw@mail.gmail.com> <ebf30013b05e8d038a63fe189f250b4b@kernel.org>
In-Reply-To: <ebf30013b05e8d038a63fe189f250b4b@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 21 Oct 2020 16:58:44 +0530
Message-ID: <CAFA6WYN1LgKt8vjh=y1SVrHbK795GyuEKeW8j63YDWDC5AZt6Q@mail.gmail.com>
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

On Wed, 21 Oct 2020 at 16:02, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-10-20 10:13, Sumit Garg wrote:
> > On Mon, 19 Oct 2020 at 17:50, Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2020-10-14 12:12, Sumit Garg wrote:
> >> > Enable NMI backtrace support on arm64 using IPI turned as an NMI
> >> > leveraging pseudo NMIs support. It is now possible for users to get a
> >> > backtrace of a CPU stuck in hard-lockup using magic SYSRQ.
> >> >
> >> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >> > ---
> >> >  arch/arm64/include/asm/irq.h |  6 ++++++
> >> >  arch/arm64/kernel/ipi_nmi.c  | 12 +++++++++++-
> >> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/arch/arm64/include/asm/irq.h
> >> > b/arch/arm64/include/asm/irq.h
> >> > index b2b0c64..e840bf1 100644
> >> > --- a/arch/arm64/include/asm/irq.h
> >> > +++ b/arch/arm64/include/asm/irq.h
> >> > @@ -6,6 +6,12 @@
> >> >
> >> >  #include <asm-generic/irq.h>
> >> >
> >> > +#ifdef CONFIG_SMP
> >> > +extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
> >> > +                                        bool exclude_self);
> >> > +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> >> > +#endif
> >> > +
> >> >  struct pt_regs;
> >> >
> >> >  static inline int nr_legacy_irqs(void)
> >> > diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> >> > index e0a9e03..e1dc19d 100644
> >> > --- a/arch/arm64/kernel/ipi_nmi.c
> >> > +++ b/arch/arm64/kernel/ipi_nmi.c
> >> > @@ -9,6 +9,7 @@
> >> >  #include <linux/interrupt.h>
> >> >  #include <linux/irq.h>
> >> >  #include <linux/kgdb.h>
> >> > +#include <linux/nmi.h>
> >> >  #include <linux/smp.h>
> >> >
> >> >  #include <asm/nmi.h>
> >> > @@ -25,12 +26,21 @@ void arch_send_call_nmi_func_ipi_mask(cpumask_t
> >> > *mask)
> >> >       __ipi_send_mask(ipi_desc, mask);
> >> >  }
> >> >
> >> > +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool
> >> > exclude_self)
> >> > +{
> >> > +     nmi_trigger_cpumask_backtrace(mask, exclude_self,
> >> > +                                   arch_send_call_nmi_func_ipi_mask);
> >> > +}
> >> > +
> >> >  static irqreturn_t ipi_nmi_handler(int irq, void *data)
> >> >  {
> >> >       unsigned int cpu = smp_processor_id();
> >> >
> >> > -     ipi_kgdb_nmicallback(cpu, get_irq_regs());
> >> > +     if (nmi_cpu_backtrace(get_irq_regs()))
> >> > +             goto out;
> >> >
> >> > +     ipi_kgdb_nmicallback(cpu, get_irq_regs());
> >> > +out:
> >> >       return IRQ_HANDLED;
> >> >  }
> >>
> >> Can't you have *both* a request for a backtrace and a KGDB call?
> >> It really shouldn't be either/or. It also outlines how well shared
> >> interrupts work with edge triggered signalling...
> >
> > Unfortunately, NMIs doesn't seem to support shared mode [1].
>
> You are totally missing the point: shared interrupts *cannot* work
> reliably with edge signalling. What I am saying here is that you need
> implement the sharing yourself in this function.

Ah, I see your point now. Will instead share this IPI among both handlers.

-Sumit

>
>          M.
> --
> Jazz is not dead. It just smells funny...
