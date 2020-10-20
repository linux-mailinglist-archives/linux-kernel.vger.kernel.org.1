Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9883C2939FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 13:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393587AbgJTLW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 07:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392756AbgJTLW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 07:22:56 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7DDC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 04:22:56 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r127so1600074lff.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfL1HsOsvMr/cKkvteB8+ldzo29UdQmctvEANksNGLg=;
        b=rDXqJyw2mjh8lD8CeV68L9v5YPos74zRDXBlyQYZx5Lc93xQB68Ro8vvN649A2Tt/R
         e3HCiRo2x2JtgN0SvL9QWZMJ58DOkdRK7nhWXkXqJKCA49mT7TsLRnKjn6MCOkHbcF2e
         ah4s9+HAxkaXFfbZsgay3TvQ3MZ87kVLXGAwnPG4RIXJBmDU+Jpv/7fhDpc7vCZt+wfO
         25ZOvat7ofc7n2VDrFw1+kNphs1xRTPAU9m+sGht9rsH3hQx2SGaN+Ywyh3hCO21Is1E
         dpbcTNE5bru5EZWiZT1CtPjelid1pSlYmFZRNY70UU45sL6ZhX5RmrEIHjJ2ZJkjB1LA
         OIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfL1HsOsvMr/cKkvteB8+ldzo29UdQmctvEANksNGLg=;
        b=Fi8nmlTYqOkIUe4AYhAS+h8dIWye0A/oVUTGVYRRaz91uqDIe+8FsRm38wCJ5Fj2PF
         YKGYvZzuCjGcY4e5ePnJKtltVfFPVEhG4L+WpA/EwkZzwH8v7brbsKU69hJtUfUwMGx1
         DWxhem8C5FWTep+Xclx0Yrgcrji4Whmj+3bBzuXmp1NrG4nKKs7ZPYMJGFeL327+Dh0m
         c8NDY13pCbVzUHnAFk4ahSQjNjw/1nrSQGdOjbq/99MMDlfzJ+XmqnZdROFsiy/fMMYO
         Q5YgxBc9j7sr91v8HHzLH4lw0oDJy4kUIme6qB/CSQA8t3YrIKmGIXxfDFIiWvR8j8sw
         OzaA==
X-Gm-Message-State: AOAM531eZEWWThrlmA539A6NLvP/0o9jJ2zQWZLeLVp8SMy6z5B97m/I
        wA5KArf7r9ocNXHI1QhEw8BLBWK8dQH1gVaoaCc1Zw==
X-Google-Smtp-Source: ABdhPJyAA5RrgQGCwwgK+Ibr64I6D7FSBwkGa2v/t9LXQygNoCpJV+P0Kipb/EkHpzpIUq857GiqhRGH4K/heQexid4=
X-Received: by 2002:a19:c88c:: with SMTP id y134mr714182lff.283.1603192974687;
 Tue, 20 Oct 2020 04:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-2-git-send-email-sumit.garg@linaro.org> <fbf6bfecf344a06af94e17ccabb817dd@kernel.org>
 <CAFA6WYPEw5x_3zDZSnkL23YjFWbF=VkUKefM6Ts46JLVaj2sDA@mail.gmail.com> <f3596e3ed70737d36f72056827d7d441@kernel.org>
In-Reply-To: <f3596e3ed70737d36f72056827d7d441@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 20 Oct 2020 16:52:43 +0530
Message-ID: <CAFA6WYMEJb0o+PMmvLh1wDhZ+M4rChP3a1cNNoEsoMS1kDWwKA@mail.gmail.com>
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

On Tue, 20 Oct 2020 at 15:38, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-10-20 07:43, Sumit Garg wrote:
> > On Mon, 19 Oct 2020 at 17:07, Marc Zyngier <maz@kernel.org> wrote:
>
> [...]
>
> >> > +{
> >> > +     if (!ipi_desc)
> >> > +             return;
> >> > +
> >> > +     if (is_nmi) {
> >> > +             if (!prepare_percpu_nmi(ipi_id))
> >> > +                     enable_percpu_nmi(ipi_id, IRQ_TYPE_NONE);
> >> > +     } else {
> >> > +             enable_percpu_irq(ipi_id, IRQ_TYPE_NONE);
> >>
> >> I'm not keen on this. Normal IRQs can't reliably work, so why do you
> >> even bother with this?
> >
> > Yeah I agree but we need to support existing functionality for kgdb
> > roundup and sysrq backtrace using normal IRQs as well.
>
> When has this become a requirement? I don't really see the point in
> implementing something that is known not to work.
>

For kgdb:

Default implementation [1] uses smp_call_function_single_async() which
in turn will invoke IPI as a normal IRQ to roundup CPUs.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/debug/debug_core.c#n244

For sysrq backtrace:

Default implementation [2] fallbacks to smp_call_function() (IPI as a
normal IRQ) to print backtrace in case architecture doesn't provide
arch_trigger_cpumask_backtrace() hook.

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/sysrq.c#n250

So in general, IPI as a normal IRQ is still useful for debugging but
it can't debug a core which is stuck in deadlock with interrupts
disabled.

And since we choose override default implementations for pseudo NMI
support, we need to be backwards compatible for platforms which don't
possess pseudo NMI support.

-Sumit

>          M.
> --
> Jazz is not dead. It just smells funny...
