Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0D42F0881
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 17:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbhAJQ44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 11:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAJQ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 11:56:55 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAE1C061794;
        Sun, 10 Jan 2021 08:56:15 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id 75so15792469ilv.13;
        Sun, 10 Jan 2021 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKFxtZ3MA1PKC7fQRzQuhIwAWj5Sp3scHNbQ2Tc7EH4=;
        b=mToZRZwNPiZjfe5V9jrrTgRBlzapqmekmtoVL0XI8r7k1/H7L1LXNJ7zWLbbFH/JPq
         KkQzLjJvQ2gEQuCD3QkBsXC2pTZkoUNfok/lcvyivGrAmSf3sly0Ot1aD8sVImMMgwWi
         XJOEzkm2hBigyFBBOiGFT1wvCjY3P+wYhU544/oL3LWzF1GUHRi6RccU5tZ2UpWnAAUj
         wNP411tGMGEauGK8cpbeC4++oFf7XxzCozxvvgpAA35QbN7T8/juCCiBgUDZ2xiCi9n/
         ce1/+NsK0LxQ8q2GYyqEDE5r4L6trBMqRqZTYToc+VZc0bbYSjDMdTGQbe0Vv8Wf/xTK
         BgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKFxtZ3MA1PKC7fQRzQuhIwAWj5Sp3scHNbQ2Tc7EH4=;
        b=Act4TzDIemBqj4mjE3uJdOglDW7mINvzArPFFtx9hUY57xNIGojgTgBN1NOl/+Hsq4
         guj1NQUNsQ1VkhKx463lxUt4vc0RN8O5bRKF/7+aaPxFybPn6DzjuJpOMdjyXNCoAgjI
         ULEF4NeP0HJRI7sx0Tg0oeFCc0uWfB2S3tLrKU6hB2xNs5s7QJF7ms8zcKhEP9srk8QI
         p/8thPY8i+HZNvrZxB9ULIotQn6UXR28OUP1VgtJx5s1qQ9gabe+oJ0AoBwO1TP6PN4R
         FIs+BVkLWTz/yEykmZR0oEiuDkXxkxOkeOEoW21w4dlj5RcDR9p47mGSOYUJJdH8t2zG
         81Qg==
X-Gm-Message-State: AOAM531tzI2DJdyZj4uD70Cg2nrO7LUnfc0YvIU5GVTRGXyWvTQDI9Q7
        DLsLQNXU/ygPW1Po9TFJEU2RxrEkB4BevI4Phyw=
X-Google-Smtp-Source: ABdhPJyrwdAvCazfY5N+dTkLBKNP7hm6JxjkEEkvJ4Gi+OeekmE3NipkBuEEWb+NWAe3EsqliZQe/6Xrj99SgXyUWkw=
X-Received: by 2002:a92:c112:: with SMTP id p18mr12633974ile.89.1610297774384;
 Sun, 10 Jan 2021 08:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20201229145130.2680442-1-aford173@gmail.com> <20210104071152.GA19063@pengutronix.de>
In-Reply-To: <20210104071152.GA19063@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 10 Jan 2021 10:56:03 -0600
Message-ID: <CAHCN7x+uyMgADOKYy5pT8SmruaqL3T7dOk=hVQUTOWQsHvLaKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: imx: enable the earlycon uart clocks by parsing
 from dt
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 1:12 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> Hi Adam,
>
> On Tue, Dec 29, 2020 at 08:51:28AM -0600, Adam Ford wrote:
> > Remove the earlycon uart clocks that are hard cord in platforms
> > clock driver, instead of parsing the earlycon uart port from dt
>
> "instead parse the earlycon uart..."
>
> Otherwise it's confusing what you mean here.
>
> > and enable these clocks from clock property in dt node.
> >
> > Fixes: 9461f7b33d11c ("clk: fix CLK_SET_RATE_GATE with clock rate protection")
> > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > Based on NXP's code base and adapted for 5.11-rc1.
> > https://source.codeaurora.org/external/imx/linux-imx/commit/drivers/clk/imx/clk.c?h=imx_5.4.47_2.2.0&id=754ae82cc55b7445545fc2f092a70e0f490e9c1b
> >
> > The original signed-off was retained.
> > Added the fixes tag.
> > ---
> >  drivers/clk/imx/clk.c | 43 +++++++++++++++++++++++++++++--------------
> >  1 file changed, 29 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> > index 47882c51cb85..c32b46890945 100644
> > --- a/drivers/clk/imx/clk.c
> > +++ b/drivers/clk/imx/clk.c
> > @@ -148,7 +148,7 @@ void imx_cscmr1_fixup(u32 *val)
> >
> >  #ifndef MODULE
> >  static int imx_keep_uart_clocks;
> > -static struct clk ** const *imx_uart_clocks;
> > +static bool imx_uart_clks_on;
> >
> >  static int __init imx_keep_uart_clocks_param(char *str)
> >  {
> > @@ -161,25 +161,40 @@ __setup_param("earlycon", imx_keep_uart_earlycon,
> >  __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
> >             imx_keep_uart_clocks_param, 0);
> >
> > -void imx_register_uart_clocks(struct clk ** const clks[])
> > +static void imx_earlycon_uart_clks_onoff(bool is_on)
>
> "is_on" sounds like it's the current state of the clock, but actually
> the variable is used for the desired state, so I suggest using plain
> "on" as name.

Sascha,

I think I'll try to keep the existing structure of imx/clk.c in place
so this function won't be needed.  It was part of NXP's custom kernel,
but I have a different idea that I'll explain below.
>
> >  {
> > -     if (imx_keep_uart_clocks) {
> > -             int i;
> > +     struct clk *uart_clk;
> > +     int i = 0;
> >
> > -             imx_uart_clocks = clks;
> > -             for (i = 0; imx_uart_clocks[i]; i++)
> > -                     clk_prepare_enable(*imx_uart_clocks[i]);
> > -     }
> > +     if (!imx_keep_uart_clocks || (!is_on && !imx_uart_clks_on))
> > +             return;
> > +
> > +     /* only support dt */
> > +     if (!of_stdout)
> > +             return;
> > +
> > +     do {
> > +             uart_clk = of_clk_get(of_stdout, i++);
>
> of_clk_get() allocates memory and gets you a reference to the clock. You
> have to release the clock with clk_put(). I think what you have to do
> here is to fill an array with clks when called from
> imx_register_uart_clocks() and when called from imx_clk_disable_uart()
> use that array to clk_disable_unprepare()/clk_put() the clocks.

I have another revision pending which modifies
imx_register_uart_clocks() to receive the number of available UART
clocks from the calling SoC. It will then allocate an array of clock
structures equal to that size.   Instead of enabling all UART clocks,
it will then go through of_clk_get(of_stdout, ...) to fill the array
and keep track of the number of devices it's assigned to the array.
Most likely the array will be larger than the number of of_stdout
entries.

Because it keeps track of the number of enabled UART's, it will use
that to go through the array and only try to unprepare/disable and put
that many clocks.  Once all the clocks have been disabled and put, the
entire clock array will be freed.

It will be more closely related to how the current imx/clk.c file is
now instead of using NXP's custom kernel, but it will also allow me to
remove the static arrays setting up the UART clocks for each SoC.

Does that sound OK to you?

I need to run some tests on my i.MX6Q board before I submit it, but
tests on my i.MX8MM are looking promising.  I can re-parent the UART
that I need reparented, and it fails if I try to reparent when that
UART is assigned to stdout.

adam
>
> Sascha
>
> > +             if (IS_ERR(uart_clk))
> > +                     break;
> > +
> > +             if (is_on)
> > +                     clk_prepare_enable(uart_clk);
> > +             else
> > +                     clk_disable_unprepare(uart_clk);
> > +     } while (true);
> > +
> > +     if (is_on)
> > +             imx_uart_clks_on = true;
> > +}
> > +void imx_register_uart_clocks(struct clk ** const clks[])
> > +{
> > +     imx_earlycon_uart_clks_onoff(true);
> >  }
> >
> >  static int __init imx_clk_disable_uart(void)
> >  {
> > -     if (imx_keep_uart_clocks && imx_uart_clocks) {
> > -             int i;
> > -
> > -             for (i = 0; imx_uart_clocks[i]; i++)
> > -                     clk_disable_unprepare(*imx_uart_clocks[i]);
> > -     }
> > +     imx_earlycon_uart_clks_onoff(false);
> >
> >       return 0;
> >  }
> > --
> > 2.25.1
> >
> >
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
