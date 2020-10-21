Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3682947C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 07:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440432AbgJUFWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 01:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440425AbgJUFWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 01:22:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6508DC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 22:22:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l28so1305303lfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 22:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7iRfYHshncZxuEZuIuMxuQoZjVRgSMU4DFKkAcLgNbA=;
        b=XkQOesCgXddwoVsTjSBMFCndrNkCOBtPClB6oUhGpFk5oLPNoQR/zfobTxnfpGPHVR
         NdZgotMP1MmX4+/NXiZStkEdNrupXd0+/VwkFVerNhPdq6luzFevAmi94H8n9K4QorSA
         TBHm+jkPcAZlzFg5sEcwRfLimwGfAzIGizjyz6koxX4F+t5BolAOSh1vhn1Ki2ljlQZ0
         9dBiRv0hCczBImGDjn6kXga6PmMkIZhggnAmp1CeQyhYZfFti9KsYY0Z0kT7Gds1tRQj
         qXEknLqg21jXQzee7u1d5xHJlI2nMZMuJNiD2w48f/RNfiSsGImps/3+HfF9zo8DJ+Zp
         vvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7iRfYHshncZxuEZuIuMxuQoZjVRgSMU4DFKkAcLgNbA=;
        b=hDMzr84uPGOEYwbE9hddcHnKY6BLqCkWau3BzfqKlw9cA+rKh+G2QQddp9XEYia1ci
         HP6GgTG42en5LhVBJqT5XLYfkK2fI/TweoQLcFmnYvPdFvw6lxvQW9Q/LpeNCBcUyuwJ
         xYzj4PHRii7+Knn/5AHBzKMvw9e3rvo9CwNg5zXC/3D226Tes2RwDy/UmgBxbW9D/FK8
         4rRf7hOmO0csHJIPs8dC/eCSmK+V74vqw67YdM5yDPcSO6+ZHdL7gTlPfM8TzKBWhq1g
         iH+SZwEYP77a9C+8BWrjJWeOYujLN0ZDoEZk1PiXdYhCKRYGfHgODOUBfLCv0ccyL+vu
         CdUw==
X-Gm-Message-State: AOAM5305QXv0UiTTnhp2Bc/Eg37DMVh5GqXNhKaynhB6uA3Bu/pTwNiB
        csgADMLmvkvwn/44DSwTGyIphDmGegeIidgcIq1N+A==
X-Google-Smtp-Source: ABdhPJxV4nB04nApkulAMMx6rMpKdEqbco++Jukt4XOOgihXfek9zsCf9m9tj9VYpY1tvFKYfCKC02F7XgD0Z60wRXw=
X-Received: by 2002:ac2:50d0:: with SMTP id h16mr534128lfm.445.1603257741847;
 Tue, 20 Oct 2020 22:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-2-git-send-email-sumit.garg@linaro.org> <fbf6bfecf344a06af94e17ccabb817dd@kernel.org>
 <CAFA6WYPEw5x_3zDZSnkL23YjFWbF=VkUKefM6Ts46JLVaj2sDA@mail.gmail.com>
 <f3596e3ed70737d36f72056827d7d441@kernel.org> <CAFA6WYMEJb0o+PMmvLh1wDhZ+M4rChP3a1cNNoEsoMS1kDWwKA@mail.gmail.com>
 <20201020122535.paym32gksuhcqtwq@holly.lan> <abe358694e06a6076fb5838d1231eee6@kernel.org>
In-Reply-To: <abe358694e06a6076fb5838d1231eee6@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 21 Oct 2020 10:52:10 +0530
Message-ID: <CAFA6WYNG3EMuDSkp7P9s7_pfw0jAC+-CZcH6f6sRnpvLsyQE6Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] arm64: Add framework to turn IPI as NMI
To:     Marc Zyngier <maz@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 at 18:02, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-10-20 13:25, Daniel Thompson wrote:
> > On Tue, Oct 20, 2020 at 04:52:43PM +0530, Sumit Garg wrote:
>
> [...]
>
> >> So in general, IPI as a normal IRQ is still useful for debugging but
> >> it can't debug a core which is stuck in deadlock with interrupts
> >> disabled.
> >>
> >> And since we choose override default implementations for pseudo NMI
> >> support, we need to be backwards compatible for platforms which don't
> >> possess pseudo NMI support.
> >
> > Do the fallback implementations require a new IPI? The fallbacks
> > could rely on existing mechanisms such as the smp_call_function
> > family.
>
> Indeed. I'd be worried of using that mechanism for NMIs, but normal
> IPIs should stick to the normal cross-call stuff.

Yes, the fallback implementations could rely on existing cross-call
stuff but current framework only allows this fallback choice at
compile time and to make this choice at runtime, we need additional
framework changes like allowing arch_trigger_cpumask_backtrace() to
return a boolean in order to switch to fallback mode, similar would be
the case for kgdb.

I think this should be doable but I am still not sure regarding the
advantages of using existing IPI vs new IPI (which we will already use
in case of pseudo NMI support) as normal IRQ.

>
> The jury is still out on why this is a good idea, given that it
> doesn't work in the only interesting case (deadlocked CPUs).

I think CPU soft-lockups (interrupts enabled) is an interesting case
to debug as well.

-Sumit

>
>           M.
> --
> Jazz is not dead. It just smells funny...
