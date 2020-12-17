Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743762DCF6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgLQKWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQKWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:22:10 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D57BC061794;
        Thu, 17 Dec 2020 02:21:30 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id f16so26719399otl.11;
        Thu, 17 Dec 2020 02:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fmCagwmO0CnAeob5/vidWI9EjHv0fIAy+mJaEfTvxA=;
        b=AYA4Cu98I2vSXxCLrK3T/kDlns03u2SXZ6kBj4/eP51H2zVF05BW4aTxcsMgYTns70
         AQSJb3AnvTAkqI+V4uJaXqsRhZGjMrCpr64o/M1pK/KPDgkzZEQk7HVNpvjUUOiqMc5S
         i70iEURiq1hVzBId3mDmA3yPXANE55OexzqY4b8l+QZv0CqIYUADs2KVmbWqAWRKOq0U
         aii+yM4LRB2LRRLJw3jO/1saG2CprHXRYuOqhPLjA4rercZ3tPHi5E9G/rgvTQ3YYJWZ
         Q2Xhchvc2Lp5cganSXq8esdibnLiPNOmx5B0IuHtDeRK96CRRjrTaxiWzxzVfSJwCHCh
         vfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fmCagwmO0CnAeob5/vidWI9EjHv0fIAy+mJaEfTvxA=;
        b=VjtfKBD5I4SwGuAhrRkolxClMKEuocer9damHlOK9pHQmoHXJeny9j1p1aoKZSt/Wr
         zPrvVpBWMFXoWbZsFu4k3Cr+LPuEbUkh78231afJqN7JX9zPoRuDKHwxb6hM0/PiYA88
         2WAvw91diRTHcBfKwPgJ/+85q+27HAl6dup8Re6pO+nbS32Q5mBkuuCj7Zuk/cMtuLiR
         IExE7ht473+04SZliHRy5S7f/bF0B8UPIgPztBmZl/pLY0QqWvLQZh1SeINLm7sXePvW
         4CB5JRgtNIAoe4nBKizNtYpIV7Amvk4dVFcL3JjLviBSPvY7/8bLSxLvZsETAQoJy91k
         1Qfg==
X-Gm-Message-State: AOAM533l6lMW30+EwaS6q49Dree+1b2WFGRjO6XwvDoWrKvZpCt+u9yr
        qVWtx9I9M3elFbtxVO2DzzQEUIBuydoZjfhmuBE=
X-Google-Smtp-Source: ABdhPJw9v2AlpigQ+z2cm/dNLrJsBXjYvT8vPM4qgw8CtUPyrwIRun/XFksLuzELcwRn+vnWPjEUgcm4c8saBqFc1yQ=
X-Received: by 2002:a05:6830:2144:: with SMTP id r4mr3235078otd.72.1608200489934;
 Thu, 17 Dec 2020 02:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20201122095556.21597-1-sergio.paracuellos@gmail.com>
 <20201122095556.21597-4-sergio.paracuellos@gmail.com> <160819619591.1580929.9915856168932644762@swboyd.mtv.corp.google.com>
 <CAMhs-H_6x7rTLPd8sABvzBqNJE2WeRJUGxG5VoqW4EvGy1hhPA@mail.gmail.com> <160819993289.1580929.17666667936736079931@swboyd.mtv.corp.google.com>
In-Reply-To: <160819993289.1580929.17666667936736079931@swboyd.mtv.corp.google.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 17 Dec 2020 11:21:19 +0100
Message-ID: <CAMhs-H8Pun8XwchyFbReQxHY7be4Vgque1iu1yVC+C3XkcwmGg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] clk: ralink: add clock driver for mt7621 SoC
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>,
        COMMON CLK FRAMEWORK <linux-clk@vger.kernel.org>,
        evicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:MIPS <linux-mips@vger.kernel.org>, open list:STAGING
        SUBSYSTEM <devel@driverdev.osuosl.org>, NeilBrown" <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 11:12 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Sergio Paracuellos (2020-12-17 01:54:18)
> >
> > On Thu, Dec 17, 2020 at 10:09 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Sergio Paracuellos (2020-11-22 01:55:53)
> > > > diff --git a/drivers/clk/ralink/Makefile b/drivers/clk/ralink/Makefile
> > > > new file mode 100644
> > > > index 000000000000..cf6f9216379d
> > > > --- /dev/null
> > > > +++ b/drivers/clk/ralink/Makefile
> > > > @@ -0,0 +1,2 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +obj-$(CONFIG_CLK_MT7621) += clk-mt7621.o
> > > > diff --git a/drivers/clk/ralink/clk-mt7621.c b/drivers/clk/ralink/clk-mt7621.c
> > > > new file mode 100644
> > > > index 000000000000..4e929f13fe7c
> > > > --- /dev/null
> > > > +++ b/drivers/clk/ralink/clk-mt7621.c
> > > > @@ -0,0 +1,435 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Mediatek MT7621 Clock Driver
> > > > + * Author: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > + */
> > > > +
> > > > +#include <linux/bitops.h>
> > > > +#include <linux/clk-provider.h>
> > > > +#include <linux/mfd/syscon.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <asm/mach-ralink/ralink_regs.h>
> > >
> > > Is it possible to drop this include? Doing so would make this portable
> > > and compilable on more architectures so us cross compilers can check
> > > build stuff and make changes easily.
> >
> > No, this is not possible. This old arch makes some global functions
> > there to properly access different registers in the palmbus. It is not
> > also well documented so it is really difficult to make something
> > better with this.
> > This is needed to use 'rt_memc_r32'
> > (arch/mips/include/asm/mach-ralink/ralink_regs.h) for reading
> > MEMC_REG_CPU_PLL.
> >
> > This is a not documented register and is not in the syscon related
> > part and we need it to derive the clock frequency for the XTAL clock.
>
> Ok.
>
> > > > +static int mt7621_gate_ops_init(struct device_node *np,
> > > > +                                struct mt7621_gate *sclk)
> > > > +{
> > > > +       struct clk_init_data init = {
> > > > +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> > >
> > > Why ignore unused? Are they CLK_IS_CRITICAL? Can they be enabled at
> > > driver probe instead of here? Or left out of the kernel entirely if they
> > > shouldn't be turned off?
> >
> > Because all the platform drivers are not changed to use this gates yet
> > and all gates are enabled by default (related registers are set to all
> > ones),  kernel disables all the stuff because they are not being
> > referenced, but yes, you are right, I think I can call
> > clk_prepare_enable for all of them at init time and avoid this
> > 'CLK_IGNORE_UNUSED' flag to don't break anything of the current other
> > upstream code.
>
> Does something crash if they're turned off? We have CLK_IS_CRITICAL for
> that. The CLK_IGNORE_UNUSED flag is sort of deprecated now.

Well, as drivers are not getting into account gates and not referenced
real hw bits are disabled by kernel because nobody requested them so
for example my uart gets down and cannot really see anything :). I
think call to 'clk_prepare_enable' should be enough since by default
all of them are setting up in registers, so call that will also
reference them...

>
> > > > +
> > > > +#define CLK_BASE(_name, _parent, _recalc) {                            \
> > > > +       .init = &(struct clk_init_data) {                               \
> > > > +               .name = _name,                                          \
> > > > +               .ops = &(const struct clk_ops) {                        \
> > > > +                       .recalc_rate = _recalc,                         \
> > > > +               },                                                      \
> > > > +               .parent_names = (const char *const[]) { _parent },      \
> > >
> > > Please use clk_parent_data instead
> >
> > parent can also be NULL here and num_parents zero, but I will search
> > what do you really mean with this 'clk_parent_data' :).
>
> Heh, 'git grep clk_parent_data -- drivers/clk/' should give some clues.

Thanks, will do!

>
> > > > +free_clk_prov:
> > > > +       kfree(clk_prov);
> > > > +}
> > > > +
> > > > +CLK_OF_DECLARE(mt7621_clk, "mediatek,mt7621-clk", mt7621_clk_init);
> > >
> > > Any reason to use this vs. a platform driver?
> >
> > We need clocks available in 'plat_time_init' before setting up the
> > timer for the GIC, so to maintain all the clock driver in a simple
> > file and using only one device tree node and no separate the gates
> > into another platform driver, I think this is the only way to go, but
> > please correct me if I am wrong.
>
> We can register the few clks like that early with
> CLK_OF_DECLARE_DRIVER() and then have a platform driver register the
> rest of the clks that aren't required early. This lets us hook into the
> driver framework better while still getting those few clks to turn on
> early enough for the timers.

I see. I will explore the way to do this as you are suggesting here, thanks!

Best regards,
    Sergio Paracuellos
