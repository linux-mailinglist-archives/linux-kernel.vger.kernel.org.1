Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A8C279836
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 12:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgIZJ5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 05:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIZJ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 05:57:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A01DC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 02:57:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e2so1837820wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7RiAAzjPvo//bkBjb7L92b9sRrqJWtIiA4pr+XMHBk=;
        b=slrSgc1bSJfkGs1cBAiYGxnx9x8rn5rWjkSmIYr5TVY4w8f+NAHhfUrRglPYBJy6Wl
         MfwttVheYGBpzoS7ygX8pCTc5DTiPd34B+RKmz1u0CtyUXmB4KyAbKhzOUAX/bvrRrvZ
         l3YnRrb0qIXpy2qif26lQUphbsqVPVZm//XzgFRoedPewA+rc0UW52hVDn9BLjUaZLtp
         67QPP2cvffaW9JNyghHL52FsF6tSn80Wva0ppmGozeuDDuZy0xgZIru6dHbXB0blWxdx
         RdBlychlkopKx8cCiIMrz5LGL7a4qfBQFD/BNTdjEgEYs79MDAH/KxEvg7jziuw33+YF
         uhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7RiAAzjPvo//bkBjb7L92b9sRrqJWtIiA4pr+XMHBk=;
        b=oMjViQd949r5F8ENr61INVH7qlwizwxEq9QT+rQFqeA0i6oJivJNxKTl4bW4jfXKQ0
         HLXiYxREGJIK0KihTTzhdkRnKZIvhFIADkgUSso5hTBIB4BQkBvhMYTAL5hNu86bf0iG
         KTCuHJLl6InIbD4AeDnTrMmNc/LckoLJKNoACk2RD5HwF62z1JWT21opjsoFBdsF18Om
         CNenxxnYVheoilusJ1UNgPH5vyosxbpynULYrf/5cfrtwZYFyZfoN8bRiQ/vRuZm9Stp
         /y83d3n2Z4u7/PSwinRUO1glzsDgmtVglBUnhZUXAbTaslC4tpgvQ1LvNtz8byx+lX2e
         uqbg==
X-Gm-Message-State: AOAM533Cy+PGLFiq+FQynyZEmUi1Iq1NsAENHNBOxJxcuufW5YnG4HNm
        jDBjxc4b5S33pk5vJ0qxVxy1vGLUOZTiv8CXv3Tb/A==
X-Google-Smtp-Source: ABdhPJzMIyVfRdC+xHpVsteyN8vvFBZh/hjPoOGslAfJmO8Z00Hkjt/ut6W72sQLm5ZHEPu5JIBqM4wNfH/XtaQSnE0=
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr2016423wmj.134.1601114247209;
 Sat, 26 Sep 2020 02:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200926072750.807764-1-anup.patel@wdc.com> <1ee25b9bca3956d15a4a0dbf83f43d1ead454220.camel@wdc.com>
 <DM6PR04MB62017875C739101DF83280ED8D370@DM6PR04MB6201.namprd04.prod.outlook.com>
 <0e1990c99bf2a342cd2e78ec7ecfc2fdecaf67fb.camel@wdc.com>
In-Reply-To: <0e1990c99bf2a342cd2e78ec7ecfc2fdecaf67fb.camel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 26 Sep 2020 15:27:15 +0530
Message-ID: <CAAhSdy0-rj3LWf+Ma6PTJkiwnMPq-mRXdvR+esfZefhcZeyayA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Check clint_time_val before use
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 3:16 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On Sat, 2020-09-26 at 09:31 +0000, Anup Patel wrote:
> > > -----Original Message-----
> > > From: Damien Le Moal <Damien.LeMoal@wdc.com>
> > > Sent: 26 September 2020 14:55
> > > To: paul.walmsley@sifive.com; palmer@dabbelt.com;
> > > palmerdabbelt@google.com; Anup Patel <Anup.Patel@wdc.com>;
> > > aou@eecs.berkeley.edu
> > > Cc: anup@brainfault.org; linux-riscv@lists.infradead.org; Atish Patra
> > > <Atish.Patra@wdc.com>; Alistair Francis <Alistair.Francis@wdc.com>; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH] RISC-V: Check clint_time_val before use
> > >
> > > On Sat, 2020-09-26 at 12:57 +0530, Anup Patel wrote:
> > > > The NoMMU kernel is broken for QEMU virt machine from Linux-5.9-rc6
> > > > because the get_cycles() and friends are called very early from
> > > > rand_initialize() before CLINT driver is probed. To fix this, we
> > > > should check clint_time_val before use in get_cycles() and friends.
> > > >
> > > > Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation
> > > > for M-mode systems")
> > > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > > ---
> > > >  arch/riscv/include/asm/timex.h | 12 +++++++++---
> > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/timex.h
> > > > b/arch/riscv/include/asm/timex.h index 7f659dda0032..52b42bb1602c
> > > > 100644
> > > > --- a/arch/riscv/include/asm/timex.h
> > > > +++ b/arch/riscv/include/asm/timex.h
> > > > @@ -17,18 +17,24 @@ typedef unsigned long cycles_t;  #ifdef
> > > > CONFIG_64BIT  static inline cycles_t get_cycles(void)  {
> > > > - return readq_relaxed(clint_time_val);
> > > > + if (clint_time_val)
> > > > +         return readq_relaxed(clint_time_val);
> > > > + return 0;
> > > >  }
> > > >  #else /* !CONFIG_64BIT */
> > > >  static inline u32 get_cycles(void)
> > > >  {
> > > > - return readl_relaxed(((u32 *)clint_time_val));
> > > > + if (clint_time_val)
> > > > +         return readl_relaxed(((u32 *)clint_time_val));
> > > > + return 0;
> > > >  }
> > > >  #define get_cycles get_cycles
> > > >
> > > >  static inline u32 get_cycles_hi(void)  {
> > > > - return readl_relaxed(((u32 *)clint_time_val) + 1);
> > > > + if (clint_time_val)
> > > > +         return readl_relaxed(((u32 *)clint_time_val) + 1);
> > > > + return 0
> > > >  }
> > > >  #define get_cycles_hi get_cycles_hi
> > > >  #endif /* CONFIG_64BIT */
> > >
> > > Applying this on top of rc6, I now get a hang on Kendryte boot...
> > > No problems without the patch on the other hand.
> >
> > Not sure about the issue with Kendryte but I get a crash on
> > QEMU virt machine without this patch.
>
> With this applied in addition to your patch, it works.
>
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-
> clint.c
> index d17367dee02c..8dbec85979fd 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -37,7 +37,7 @@ static unsigned long clint_timer_freq;
>  static unsigned int clint_timer_irq;
>
>  #ifdef CONFIG_RISCV_M_MODE
> -u64 __iomem *clint_time_val;
> +u64 __iomem *clint_time_val = NULL;
>  #endif
>
>  static void clint_send_ipi(const struct cpumask *target)

Ahh, clint_time_val is an uninitialized variable.

I will send a v2 with your SoB.

Regards,
Anup

>
> --
> Damien Le Moal
> Western Digital
