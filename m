Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8288428C786
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 05:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgJMDXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 23:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgJMDXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 23:23:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95935C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 20:23:04 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f21so6782332qko.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 20:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8avc/64suYQeMp5GgzA5tmw2pJjaDuZSyAtFHq8gm34=;
        b=fVshXDeXRvRHKXbkyOJuRjmLohKcGDX7DDjrMtShzKZFXCDWpDYpbtuY+9/lW0oSzn
         v31Y9XdnWd7q2wMfv4McLozcmD21u7PQ+peYEDpsaxn+Nwf4on/ItmLJgoPxnggt+dSG
         4BmOONWVL5NGd5aeA1Co45HuViM2EoXkePxtaJnVYtuzKej4z68hlFlNZYGza2Kb6I6M
         KeM75AbjHbF4Cp4YlbCjsyYAQ/af4CxPjze0OrDmeo9gRqNmO12G1+FxnZja2YYiyJ3C
         Us6YNnhsANN9wHX6gdjni8JiDL6NZcg+9eDp6WcUXAVrAyaa6Z+hX2vukQUeJJy7uHPW
         enAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8avc/64suYQeMp5GgzA5tmw2pJjaDuZSyAtFHq8gm34=;
        b=V3o/W7nryNaIYaZT2NyVDfQ3HJ8Cf207G6r7NwdmaT1hRRKg+JkpEMhRxryj+npcr5
         ONORaqRZtMwjerG4ioztMqrgGkLEv065oWcVscsZjO/misIhhyA/qeGz2fWROSiytBmD
         PIuB2aNEf8LjZ1LLQ1I+cha+ssSw/pvR6+lfDlqCxxQvzQ6wAbdQevDnULX5SjoFiHta
         NiwPailGj08/Q4zEfZc6isIjS2ilZsthj2rVgRTnsVp6AAx+F1W/2zyk1eWvmVe7vwus
         cxG8SQcKqfSlxO0tyXzvEKv50qIXI8TppAMKPdThievm5x3yk+aJpFwSDf64WM0VNxyr
         Dmkg==
X-Gm-Message-State: AOAM530hX5QRhxWLWS3RvualPDU0L/R0ZCxQP/RDTLYWMWv2QwbB1T1L
        9md5BcJ7v8YarRK2OpesSA==
X-Google-Smtp-Source: ABdhPJyHjdm9v8cbZa7XC7+SU1TiL3kuhYJVBffwraE+SqHVz0Unk73Y35kuNXvQXVMGxEraIGfRMw==
X-Received: by 2002:a05:620a:677:: with SMTP id a23mr2355679qkh.428.1602559383716;
        Mon, 12 Oct 2020 20:23:03 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id w45sm506123qtw.96.2020.10.12.20.23.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Oct 2020 20:23:02 -0700 (PDT)
Date:   Mon, 12 Oct 2020 23:23:00 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>
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
Subject: Re: [PATCH v4 1/5] arm64: Add framework to turn IPI as NMI
Message-ID: <20201013032300.djsxeasxaqbzjhzr@gabell>
References: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
 <1599830924-13990-2-git-send-email-sumit.garg@linaro.org>
 <20201010015855.vksetnj4luft5enc@gabell>
 <877drypgqb.wl-maz@kernel.org>
 <20201010151307.vq74if4mndjn4nhm@gabell>
 <CAFA6WYOHs+yYvdR-6eQR3ZJPK8nF3sN0fbd8XsQ8pwGL63cdCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOHs+yYvdR-6eQR3ZJPK8nF3sN0fbd8XsQ8pwGL63cdCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 05:49:09PM +0530, Sumit Garg wrote:
> Hi Masa,
> 
> On Sat, 10 Oct 2020 at 20:43, Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> >
> > On Sat, Oct 10, 2020 at 10:34:04AM +0100, Marc Zyngier wrote:
> > > On Sat, 10 Oct 2020 02:58:55 +0100,
> > > Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> > >
> > > [...]
> > >
> > > > > +void ipi_nmi_setup(int cpu)
> > > > > +{
> > > > > + if (!ipi_desc)
> > > > > +         return;
> > > >
> > > > ipi_nmi_setup() may be called twice for CPU0:
> > > >
> > > >   set_smp_ipi_range => set_smp_ipi_nmi => ipi_nmi_setup
> > > >                     => ipi_setup => ipi_nmi_setup
> > > >
> > > > Actually, I got the following error message via the second ipi_nmi_setup():
> > > >
> > > >   GICv3: Pseudo-NMIs enabled using relaxed ICC_PMR_EL1 synchronisation
> > > >   GICv3: Cannot set NMI property of enabled IRQ 8
> > > >   genirq: Failed to setup NMI delivery: irq 8
> > > >
> 
> Ah, thanks for catching this which I missed during my testing.
> 
> > > > Why don't we have a check to prevent that? Like as:
> > > >
> > > >        if (cpumask_test_cpu(cpu, ipi_desc->percpu_enabled))
> > > >                return;
> > >
> > > That's definitely the wrong thing to do. prepare_nmi_setup() shouldn't
> > > be called twice, and papering over it isn't acceptable.
> >
> > Got it. How about moving ipi_nmi_setup() from ipi_setup() to
> > secondary_start_kernel() ? so that CPU0 can call ipi_nmi_setup() only
> > from set_smp_ipi_nmi().
> >
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -245,6 +245,7 @@ asmlinkage notrace void secondary_start_kernel(void)
> >         notify_cpu_starting(cpu);
> >
> >         ipi_setup(cpu);
> > +       ipi_nmi_setup(cpu);
> >
> >         store_cpu_topology(cpu);
> >         numa_add_cpu(cpu);
> > @@ -966,8 +967,6 @@ static void ipi_setup(int cpu)
> >
> >         for (i = 0; i < nr_ipi; i++)
> >                 enable_percpu_irq(ipi_irq_base + i, 0);
> > -
> > -       ipi_nmi_setup(cpu);
> >  }
> >
> >  #ifdef CONFIG_HOTPLUG_CPU
> >
> 
> IMO, it would be more consistent to keep invocation of ipi_nmi_setup()
> from ipi_setup(). So let me remove other invocation from
> set_smp_ipi_nmi():
> 
> diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> index d3aa430..000e457 100644
> --- a/arch/arm64/kernel/ipi_nmi.c
> +++ b/arch/arm64/kernel/ipi_nmi.c
> @@ -87,7 +87,4 @@ void __init set_smp_ipi_nmi(int ipi)
>         ipi_desc = irq_to_desc(ipi);
>         irq_set_status_flags(ipi, IRQ_HIDDEN);
>         ipi_id = ipi;
> -
> -       /* Setup the boot CPU immediately */
> -       ipi_nmi_setup(smp_processor_id());
>  }
> 
> Do let me know if this works for you?

Yes, make sense to me.

Thanks!
Masa
