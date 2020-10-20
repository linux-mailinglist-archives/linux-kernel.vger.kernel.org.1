Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49641293B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405909AbgJTMZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405883AbgJTMZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:25:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B05AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:25:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f21so1576632wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3072bhtqw85ZZ5q7Kctyban1EX+IQGqUQ7FPQjYg1z4=;
        b=wHX2QGknolq+aCKeuj9TVr+qoMxLXBjgtUghPnFszojrsW6EbHc/uowWZr3oiQOZTF
         wjj9SooPyLN4foolShHgoIU2Q0GySZDa5dv2BW8l21yX96A/9E5/k3OkANImPibS1JcH
         6KD4pO3CacnW64Re+l4bsoTJRDdfvpDYMWmoq2recYkWijVKuGWxmYmDJWrW0L+h5Ewv
         mkDfIdFx/pREKABAM+ROXjidtORbC3FSPmjaxRt790Qq8su4y3VMtXlkYqC0AY7s5NYf
         5fJ/6vD/5hRywuOIrq/quCtoMLWNY9AIK5nSc3sHeHpf3sUabKHwHBke+muGJJAfA2MA
         HycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3072bhtqw85ZZ5q7Kctyban1EX+IQGqUQ7FPQjYg1z4=;
        b=mMKryIGXzrsFcQf4d8vJ2AkVuTJw6mCrIz+UDr5nrrOILQ3iG+QmdfgvVboW3yEU1E
         Ij4Mz7n+8ZAFEQcL/rUdq1Oq8zft5CYBgEZM2JBmqmz9xUg7/z8NzkmcPAO3MdUpOWw3
         ofZYVwlojO4kzNOALuJXXbaxIVuFOmTE0Fs7PpebrjP7Y2wDHnSsiEJDbgYqpLWqP+Pp
         PJqV9Tr2Ct03fRVn9hVizbiyDfJ/23quUP1wAQUm+o33JN0hqTsXLsoVDBdfEaV036ip
         TP7sq1q+FySzQ+yJb26SuGHDPhARwhAJJZDkT6tl8RFW8AZrL0DoSce+L+tO9oLmbd8m
         ioCw==
X-Gm-Message-State: AOAM530MSKZ6NNGZtnQtucZKkryIm8ALn8GDh7+ajtZiSZRZ3EiCrlQi
        kc1101uGWkmvK9koKvL0niZdsw==
X-Google-Smtp-Source: ABdhPJzP1NmHjrHQMM7HL0GJ31rTvRXR+Qg05Vlyi4JFfNOui5H76szu2fy1qjFZmseIDVS6BOU98g==
X-Received: by 2002:a1c:de8a:: with SMTP id v132mr860371wmg.173.1603196737971;
        Tue, 20 Oct 2020 05:25:37 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z11sm2739295wrh.70.2020.10.20.05.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:25:37 -0700 (PDT)
Date:   Tue, 20 Oct 2020 13:25:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        julien.thierry.kdev@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] arm64: Add framework to turn IPI as NMI
Message-ID: <20201020122535.paym32gksuhcqtwq@holly.lan>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-2-git-send-email-sumit.garg@linaro.org>
 <fbf6bfecf344a06af94e17ccabb817dd@kernel.org>
 <CAFA6WYPEw5x_3zDZSnkL23YjFWbF=VkUKefM6Ts46JLVaj2sDA@mail.gmail.com>
 <f3596e3ed70737d36f72056827d7d441@kernel.org>
 <CAFA6WYMEJb0o+PMmvLh1wDhZ+M4rChP3a1cNNoEsoMS1kDWwKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMEJb0o+PMmvLh1wDhZ+M4rChP3a1cNNoEsoMS1kDWwKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 04:52:43PM +0530, Sumit Garg wrote:
> On Tue, 20 Oct 2020 at 15:38, Marc Zyngier <maz@kernel.org> wrote:
> >
> > On 2020-10-20 07:43, Sumit Garg wrote:
> > > On Mon, 19 Oct 2020 at 17:07, Marc Zyngier <maz@kernel.org> wrote:
> >
> > [...]
> >
> > >> > +{
> > >> > +     if (!ipi_desc)
> > >> > +             return;
> > >> > +
> > >> > +     if (is_nmi) {
> > >> > +             if (!prepare_percpu_nmi(ipi_id))
> > >> > +                     enable_percpu_nmi(ipi_id, IRQ_TYPE_NONE);
> > >> > +     } else {
> > >> > +             enable_percpu_irq(ipi_id, IRQ_TYPE_NONE);
> > >>
> > >> I'm not keen on this. Normal IRQs can't reliably work, so why do you
> > >> even bother with this?
> > >
> > > Yeah I agree but we need to support existing functionality for kgdb
> > > roundup and sysrq backtrace using normal IRQs as well.
> >
> > When has this become a requirement? I don't really see the point in
> > implementing something that is known not to work.
> >
> 
> For kgdb:
> 
> Default implementation [1] uses smp_call_function_single_async() which
> in turn will invoke IPI as a normal IRQ to roundup CPUs.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/debug/debug_core.c#n244
> 
> For sysrq backtrace:
> 
> Default implementation [2] fallbacks to smp_call_function() (IPI as a
> normal IRQ) to print backtrace in case architecture doesn't provide
> arch_trigger_cpumask_backtrace() hook.
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/sysrq.c#n250
> 
> So in general, IPI as a normal IRQ is still useful for debugging but
> it can't debug a core which is stuck in deadlock with interrupts
> disabled.
> 
> And since we choose override default implementations for pseudo NMI
> support, we need to be backwards compatible for platforms which don't
> possess pseudo NMI support.

Do the fallback implementations require a new IPI? The fallbacks
could rely on existing mechanisms such as the smp_call_function
family.


Daniel.
