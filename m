Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90512295DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897608AbgJVLxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503697AbgJVLxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:53:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566C3C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 04:53:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m16so1596061ljo.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 04:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/p1cdqDg3sSy4J66J5AdsRM0OOyUaw4jr+T+WwHHoBY=;
        b=bKKT7PqBzLn7aHCb3uqtSN7ClSWLctjRr5jOL1V1Mk6FBEBs4V8M+3ivstxhYVB+km
         UdUh3lr9wBDr+O6cNGPnFX3+WOMveHNChR4sQAjfZo+jbEMdg57wllMc9JSaUssILTxT
         qY0qsDLxrRgmnZQ8YJr6qJAjJs+AegWaH9elw74/70ATqrqbjDMt1itC66OP1Yzipr9y
         tgsZwaghjhMvOXSPpqQpzeuXWYcvyr/mkqBG9HdfhDbN+u8Nuex2rWlHAOqKVgktvzgv
         T6U2Ie7aT8SgxCNro7djwC6w5itZBjhDArQq7XsBthFokDd4bpGqKJOWR8LSxJ4b7ssw
         sZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/p1cdqDg3sSy4J66J5AdsRM0OOyUaw4jr+T+WwHHoBY=;
        b=F4NgRF9Mfy9LjDOF8JKnyuG9sFbbS5ve4CU0JWRBC+n6qa35UO4dqj0wpOtyMvopxS
         tmaeUyHc+DGVIvyg/jurZ1Py2bG4u0mLrjGAk0svBWPwKogm7vnVwFhyu7X8Mo6C2NzS
         pHqzeMOU92I1eferEp8txTC1pDex7UcdczmzWN5VGqYlbGEm+VC5mFsB9GiG02J0TdWc
         gM/EBPbnr7Ej2F9Swemik52ZDcOh1P6k/t6wM4hXu3LLYf+K+HIQpqvfrhoHY/6Y1IdM
         dzZ5aN4QtxWMgF5D9VY3QrFGN3GvBoEYVJNT34woJzqmwqDoBlPtRSR18Sx3R22cFOz3
         nJcA==
X-Gm-Message-State: AOAM532gLHPKzr4OS8vVgAE9xXG5ZlyepiJiHf4ZDi9hrNtiePNhVLMU
        2MTz/fjnYCwX4Og03hiSO1k6qzPqInNZmOAE59AGiA==
X-Google-Smtp-Source: ABdhPJy6WmhVH6MPUajsCzsGwwHuyX/WPScvir7ZQSEHe3QGmI/bVeWlm+z9NRu1UrsTMbm1RFBeBcndxA+vuWHf7RI=
X-Received: by 2002:a2e:808a:: with SMTP id i10mr775733ljg.427.1603367583805;
 Thu, 22 Oct 2020 04:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-2-git-send-email-sumit.garg@linaro.org> <fbf6bfecf344a06af94e17ccabb817dd@kernel.org>
 <CAFA6WYPEw5x_3zDZSnkL23YjFWbF=VkUKefM6Ts46JLVaj2sDA@mail.gmail.com>
 <f3596e3ed70737d36f72056827d7d441@kernel.org> <CAFA6WYMEJb0o+PMmvLh1wDhZ+M4rChP3a1cNNoEsoMS1kDWwKA@mail.gmail.com>
 <1d41e0e4e6ee6c794b83d2c75c3748da@kernel.org>
In-Reply-To: <1d41e0e4e6ee6c794b83d2c75c3748da@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 22 Oct 2020 17:22:52 +0530
Message-ID: <CAFA6WYOr5g1VLpHJtS5WCE1x_Xe6g9FQPSXOwiC1Ew5rKJyRwQ@mail.gmail.com>
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

On Wed, 21 Oct 2020 at 15:57, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-10-20 12:22, Sumit Garg wrote:
> > On Tue, 20 Oct 2020 at 15:38, Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2020-10-20 07:43, Sumit Garg wrote:
> >> > On Mon, 19 Oct 2020 at 17:07, Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> [...]
> >>
> >> >> > +{
> >> >> > +     if (!ipi_desc)
> >> >> > +             return;
> >> >> > +
> >> >> > +     if (is_nmi) {
> >> >> > +             if (!prepare_percpu_nmi(ipi_id))
> >> >> > +                     enable_percpu_nmi(ipi_id, IRQ_TYPE_NONE);
> >> >> > +     } else {
> >> >> > +             enable_percpu_irq(ipi_id, IRQ_TYPE_NONE);
> >> >>
> >> >> I'm not keen on this. Normal IRQs can't reliably work, so why do you
> >> >> even bother with this?
> >> >
> >> > Yeah I agree but we need to support existing functionality for kgdb
> >> > roundup and sysrq backtrace using normal IRQs as well.
> >>
> >> When has this become a requirement? I don't really see the point in
> >> implementing something that is known not to work.
> >>
> >
> > For kgdb:
> >
> > Default implementation [1] uses smp_call_function_single_async() which
> > in turn will invoke IPI as a normal IRQ to roundup CPUs.
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/debug/debug_core.c#n244
> >
> > For sysrq backtrace:
> >
> > Default implementation [2] fallbacks to smp_call_function() (IPI as a
> > normal IRQ) to print backtrace in case architecture doesn't provide
> > arch_trigger_cpumask_backtrace() hook.
> >
> > [2]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/sysrq.c#n250
> >
> > So in general, IPI as a normal IRQ is still useful for debugging but
> > it can't debug a core which is stuck in deadlock with interrupts
> > disabled.
>
> And that's not something we implement today for good reasons:
> it *cannot* work reliably. What changed that we all of a sudden need it?
>
> > And since we choose override default implementations for pseudo NMI
> > support, we need to be backwards compatible for platforms which don't
> > possess pseudo NMI support.
>
> No. There is nothing to be "backward compatible" with, because
> - this isn't a userspace visible feature
> - *it doesn't work*
>
> So please drop this non-feature from this series.
>

Okay, fair enough. I will drop support for new IPI being normal IRQ
and instead update sysrq backtrace and kgdb roundup frameworks to use
existing cross-calls stuff in case a platform doesn't possess pseudo
NMI support.

-Sumit

>          M.
> --
> Jazz is not dead. It just smells funny...
