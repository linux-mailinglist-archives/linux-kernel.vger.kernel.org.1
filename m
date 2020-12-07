Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302D52D152A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgLGPw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgLGPwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:52:25 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93918C061749;
        Mon,  7 Dec 2020 07:51:45 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id y5so13809102iow.5;
        Mon, 07 Dec 2020 07:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYz7RogK/K3ng3n1DTHUn/3sWgf0KmqiKSNRx0uTMWo=;
        b=qsd97huoIFeX39CRRtYbj7nNFonLXhk4CefxZ7PHg6K6WHCIq+sN2FRaA82iQmLGH4
         6iVlEHDE4ULsLaruUHmMFW44tgFbLIBUQ5bZ8r5AuxpRVOpZ8ZS1HYaTzusdHpofEkR1
         czYFiwHExEqmnhRxv8Zo98PWxRQuu144njHWrRM8AXPufCUuoZPaI2o1MKC4HeQw7Yny
         yKXYEUAYsDrFkJfZusnRSfwWNSYMxbxmczOAlPKyW/e1B2Erpk6yC+yeG2+gjmBMNquO
         2ODhVPwHYXQPSp/Icz3TOy3rfypSvZ0z0qApnhDy5ejnA/idlqgVQ5wGQt3CNH+wEwWt
         qerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYz7RogK/K3ng3n1DTHUn/3sWgf0KmqiKSNRx0uTMWo=;
        b=O+DKwxQeuUEy8NaPo/2JJhFBSLmoaIbDuXm1bDquy1WPZPV/i2tYzEHr+OTsAs7otF
         XBMC+BdEwYuAlXCH7gAj7gl3ekFnCmbx0N9ri2ZsS1tbZyZ9Hwg9BYGtTQPKMWQDMfgX
         97pWkWkTViQ1RGXF+tfkvJ0ioQGF3vf2JE3ZnVXV1MfF4H48qT2BFVyrw1UICjHYrMIJ
         4wOtHAmm9RYNmAZwsi+uc4crZuYC8u+pfwJ7/wXTJfwkoVAfpt/K5q/sOyUrrTTxydY+
         9E+BdI+fh66yNMwKE92750rlVZLTRI2wf/OdUPDE/UOx1skI3WTyyXPFdjcAB3AGJzyg
         kCeQ==
X-Gm-Message-State: AOAM533WWK+OfncItBR/6jMpHMBU1z2uLzYS2XK5In57jDq2HspTbJT3
        fCT8UDcFaAnefiHXLKRunu5EfHgQOFaOQrgxKts=
X-Google-Smtp-Source: ABdhPJy/TVMlbkFldjHrZwMtSRREASJy8F3Pp7g+s3SU6qZZeUKNgEieCDpmIYzV2PnIUK1U+NqazgU5XilVQsJ3cVM=
X-Received: by 2002:a5d:9401:: with SMTP id v1mr20648355ion.142.1607356304774;
 Mon, 07 Dec 2020 07:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20201204183154.94002-1-aford173@gmail.com> <20201207052438.GA3977@pengutronix.de>
In-Reply-To: <20201207052438.GA3977@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 7 Dec 2020 09:51:33 -0600
Message-ID: <CAHCN7xJ8kmCxijvzpi+gj=R-QmPc6pqmsMzU5CRt3pQ9B98k+w@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: Fix reparenting of UARTs not associated with sdout
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        charles.steves@logicpd.com, Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 6, 2020 at 11:24 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> Hi Adam,
>
> On Fri, Dec 04, 2020 at 12:31:54PM -0600, Adam Ford wrote:
> > The default clock source on i.MX8M Mini and Nano boards use a 24MHz clock,
> > but users who need to re-parent the clock source run into issues because
> > all the UART clocks are enabled whether or not they're needed by sdout.
> >
> > Any attempt to change the parent results in an busy error because the
> > clocks have been enabled already.
> >
> >   clk: failed to reparent uart1 to sys_pll1_80m: -16
> >
> > Instead of pre-initializing all UARTS, scan the device tree to see if UART
> > clock is used as stdout before initializing it.  Only enable the UART clock
> > if it's needed in order to delay the clock initialization until after the
> > re-parenting of the clocks.
> >
> > Fixes: 9461f7b33d11c ("clk: fix CLK_SET_RATE_GATE with clock rate protection")
> > Suggested-by: Aisheng Dong <aisheng.dong@nxp.com>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> > index 47882c51cb85..6dcc5fbd8f3f 100644
> > --- a/drivers/clk/imx/clk.c
> > +++ b/drivers/clk/imx/clk.c
> > @@ -163,12 +163,18 @@ __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
> >
> >  void imx_register_uart_clocks(struct clk ** const clks[])
> >  {
> > +     struct clk *uart_clk;
> >       if (imx_keep_uart_clocks) {
> >               int i;
> >
> >               imx_uart_clocks = clks;
> > -             for (i = 0; imx_uart_clocks[i]; i++)
> > -                     clk_prepare_enable(*imx_uart_clocks[i]);
> > +             for (i = 0; imx_uart_clocks[i]; i++) {
> > +                     uart_clk = of_clk_get(of_stdout, i);
>
> This looks wrong. imx_uart_clocks is an array containing all clocks that
> could possibly be used for an UART. With of_clk_get(of_stdout, i) you
> get the nth clock for one specific UART.
> What you have to do here is: For each of imx_uart_clocks[] you have to
> iterate over all clocks of the of_stdout node.

Sascha,

Thanks for the review.

I agree that I'm using the wrong index when checking of_stdout, but I
am not sure we need to loop through  imx_uart_clocks at all.
I looked at the NXP repo, and they just focus on looping through
of_stdout and don't reference the imx_uart_clocks. Can't we just loop
through the of_stdout and enable any clocks found in that?

adam


>
> Sascha
>
> > +                     if (IS_ERR(uart_clk))
> > +                             continue;
> > +                     clk_prepare_enable(uart_clk);
> > +                     clk_put(uart_clk);
> > +             }
> >       }
> >  }
> >
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
