Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075F6279E75
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 07:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgI0Fid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 01:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgI0Fid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 01:38:33 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4342DC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 22:38:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x23so3122852wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 22:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZCfebmeIyQM8Y/MGP8rYATaRiT/OcK0QURRwQB2nGD8=;
        b=RiWp7bza8WWGrzKDwE7UTtZxN4Dno//C5p0F6OPIop77Th0P7xLbMAItUCMNkniyjl
         40gNuRoXhGYgagR5IUOziTUbFM13yfMpvWCKGNRxZQUHIryxydfHj7AIaA35NFkIom2h
         yLuYMvKnmcR8M+cYySisgmkgn0tRNIAHYTFaMoazE8pOaidQpAl3evzc8+ZqydDmYvfd
         cGhCyjHUfTARELvsG7phubW/wbCTE4ATdWyWUQsQIlZ37CPzW6/M3YL6C2mmLnzl4EO3
         xoxXLHu+iLLMdmN7kUvtbquwVZS7fKC1KS4AFBspElx1U/4RbPmkqSHgyW3zJeW23OI/
         EQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCfebmeIyQM8Y/MGP8rYATaRiT/OcK0QURRwQB2nGD8=;
        b=nW2fKAvM1aCl5QAW8sk0g55xOARR2VcUOKyW6eBq9RAuzX7uRV6/1HUd39WG0U6byT
         yfIimhK8OfyGXUVRBCb+FjPUbvZ6QoTrVeuzBHye34JYSXi/UNFWpUqPD9ToaAb4wlr+
         MSuyI/CDb3NPHzOvKtBz28do7UFocQW+nap9XK9lu2BiId41eKTrS0ipkuQwmuRYpmq+
         eROyfoYIoyyZKpQ191M1Rj75AKJ1bNewY+878ftTVhZyVy/rUquVDf5oPfYBUyHH3e1t
         lRGAQfzVYeNd48ctObJx5vRdolXxerSxWJc+0dP9+jH9iqWARBA2/akqO9l4oeU/Lrz2
         H2RA==
X-Gm-Message-State: AOAM532p5mzooOk23L52NhjHrw4O3zx0cop9c0RCIriGe0m6pIqcHNIa
        u6UVgYOiVVdhIWAjzzfTPQKpq3e9LLthnWDyR07Ehg==
X-Google-Smtp-Source: ABdhPJzcSZYowLUeEtgs7Yq0yFbU1X/2LLoJ8I3s8qUjfYVf0CVYCVuPVGr8tDNA8DdroS0gDhDvpYknyaeVFp5ux14=
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr5662256wmj.134.1601185109900;
 Sat, 26 Sep 2020 22:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <4950cd11fcf66bc3606f309d6289577b5dc65b2e.camel@wdc.com> <mhng-bcea0448-fc43-406d-a56c-53e16306e12d@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-bcea0448-fc43-406d-a56c-53e16306e12d@palmerdabbelt-glaptop1>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 27 Sep 2020 11:08:17 +0530
Message-ID: <CAAhSdy1EeeNcyHbk-MN+auKX+mZmvF=W=S-UPuRhrqVBjch4ow@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Check clint_time_val before use
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 5:50 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Sat, 26 Sep 2020 03:31:29 PDT (-0700), Damien Le Moal wrote:
> > On Sat, 2020-09-26 at 15:51 +0530, Anup Patel wrote:
> >> The NoMMU kernel is broken for QEMU virt machine from Linux-5.9-rc6
> >> because the get_cycles() and friends are called very early from
> >> rand_initialize() before CLINT driver is probed. To fix this, we
> >> should check clint_time_val before use in get_cycles() and friends.
>
> I don't think this is the right way to solve that problem, as we're essentially
> just lying about the timer rather than informing the system we can't get
> timer-based entropy right now.  MIPS is explicit about this, I don't see any
> reason why we shouldn't be as well.
>
> Does this fix the boot issue (see below for the NULL)?  There's some other
> random-related arch functions so this might not be quite the right way to do
> it.
>
> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> index 7f659dda0032..7e39b0068932 100644
> --- a/arch/riscv/include/asm/timex.h
> +++ b/arch/riscv/include/asm/timex.h
> @@ -33,6 +33,18 @@ static inline u32 get_cycles_hi(void)
>  #define get_cycles_hi get_cycles_hi
>  #endif /* CONFIG_64BIT */
>
> +/*
> + * Much like MIPS, we may not have a viable counter to use at an early point in
> + * the boot process.  Unfortunately we don't have a fallback, so instead we
> + * just return 0.
> + */
> +static inline unsigned long random_get_entropy(void)
> +{
> +       if (unlikely(clint_time_val == NULL))
> +               return 0;
> +       return get_cycles();
> +}
> +
>  #else /* CONFIG_RISCV_M_MODE */
>
>  static inline cycles_t get_cycles(void)
>
> >> Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation
> >> for M-mode systems")
> >> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> >> ---
> >> Changes since v1:
> >>  - Explicitly initialize clint_time_val to NULL in CLINT driver to
> >>    avoid hang on Kendryte K210
> >> ---
> >>  arch/riscv/include/asm/timex.h    | 12 +++++++++---
> >>  drivers/clocksource/timer-clint.c |  2 +-
> >>  2 files changed, 10 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> >> index 7f659dda0032..6e7b04874755 100644
> >> --- a/arch/riscv/include/asm/timex.h
> >> +++ b/arch/riscv/include/asm/timex.h
> >> @@ -17,18 +17,24 @@ typedef unsigned long cycles_t;
> >>  #ifdef CONFIG_64BIT
> >>  static inline cycles_t get_cycles(void)
> >>  {
> >> -    return readq_relaxed(clint_time_val);
> >> +    if (clint_time_val)
> >> +            return readq_relaxed(clint_time_val);
> >> +    return 0;
> >>  }
> >>  #else /* !CONFIG_64BIT */
> >>  static inline u32 get_cycles(void)
> >>  {
> >> -    return readl_relaxed(((u32 *)clint_time_val));
> >> +    if (clint_time_val)
> >> +            return readl_relaxed(((u32 *)clint_time_val));
> >> +    return 0;
> >>  }
> >>  #define get_cycles get_cycles
> >>
> >>  static inline u32 get_cycles_hi(void)
> >>  {
> >> -    return readl_relaxed(((u32 *)clint_time_val) + 1);
> >> +    if (clint_time_val)
> >> +            return readl_relaxed(((u32 *)clint_time_val) + 1);
> >> +    return 0;
> >>  }
> >>  #define get_cycles_hi get_cycles_hi
> >>  #endif /* CONFIG_64BIT */
> >> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> >> index d17367dee02c..8dbec85979fd 100644
> >> --- a/drivers/clocksource/timer-clint.c
> >> +++ b/drivers/clocksource/timer-clint.c
> >> @@ -37,7 +37,7 @@ static unsigned long clint_timer_freq;
> >>  static unsigned int clint_timer_irq;
> >>
> >>  #ifdef CONFIG_RISCV_M_MODE
> >> -u64 __iomem *clint_time_val;
> >> +u64 __iomem *clint_time_val = NULL;
>
> This one I definately don't get.  According the internet, the C standard says
>
>     If an object that has static storage duration is not initialized
>     explicitly, it is initialized implicitly as if every member that has
>     arithmetic type were assigned 0 and every member that has pointer type were
>     assigned a null pointer constant.
>
> so unless I'm missing something there shouldn't be any difference between these
> two lines.  When I just apply this I get exactly the same "objdump -dt" before
> and after.  I do see some difference in assembly, but only when I don't pass
> "-fno-common" and that ends up being passed during my Linux builds.

Even checkpatch complains about explicit NULL assignment to global variables.

I will send v3 with a different approach to fix this so hopefully with
v3 we will
not require explicit NULL assignment.

Regards,
Anup

>
> >>  #endif
> >>
> >>  static void clint_send_ipi(const struct cpumask *target)
> >
> > For Kendryte:
> >
> > Tested-by: Damien Le Moal <damien.lemoal@wdc.com>
> >
> > --
> > Damien Le Moal
> > Western Digital
