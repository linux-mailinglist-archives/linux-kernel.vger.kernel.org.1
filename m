Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9E2FA26C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392597AbhAROCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392580AbhAROBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:01:38 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733B4C061575;
        Mon, 18 Jan 2021 06:00:58 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q2so31250734iow.13;
        Mon, 18 Jan 2021 06:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J69oNnMS41D9yDZn/fO8F12yvvP9bT2WOakN9kUY+ng=;
        b=f5iXqZAg0l0PwEs1MTuPy2ZFU0fsjhjaI1bJcaOKYRJP2YfmpVkI/ObWVoj/waNRlW
         RDPkjLomnDTFeCUVczgLFHH+tadgRliLPudcDIE7b/9vb2v+yY8jWzs7liR8n3Smxle+
         uMj5H0tKr3Xye97Mg4b9Tf4bOFPJ/KFOmZV1+P2+K3Y9q+/LrenE2Os8YTsWGwb7QhDf
         yP6zAPOuKgabuUXYw10ANagcJlgzxSKhLy7kIxc6CLDMiCRM+AKFEAoEQ9w3BaGNq0iK
         VFF/SqT/L+eY5Y8VQW2QuvsDgurGyWgZHADFQaEEvhI0Oz6XkuxbYsXdy31d2m1qt27U
         kdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J69oNnMS41D9yDZn/fO8F12yvvP9bT2WOakN9kUY+ng=;
        b=mS5c6XUmVP2+JST0quw1Fu7FsdhzvooLZoMr7vffQAlWM48C2/ZuC33128VVwYnuOS
         A0D1GkvajRDm0J326VGSInoUiIBzrJx5c3TItWBklzmjaQQLbJ+uSc2RjaYnA0THdHmp
         sS6g7d4sRRYtqu63j6yMGLgkR5rTKZRdJAfgjVj1A6OnhyvudZDh1SQaWglVYd/UkYKh
         SdLGmrAntjivDbYF5x0A+kCyvSwti/37FevkpOd+vo2Q3fopPR2sUfxFoW0Z8RRIe7vv
         N0dgenwD4yaHgoYUAEtlfbg6uScskqi6XQEkzAN6fKudYGXhYGgsEDZwMu32gjCx3d6Q
         BMRw==
X-Gm-Message-State: AOAM531bAIb2P8Mo/J06YAKDK1vHKdwyJh+wRecY1DgwbB5XXGXBUQRV
        BY0e425SKkNt/pLUIsrOHPQ0FZyl3YiFl8UgWVM=
X-Google-Smtp-Source: ABdhPJyLL6nSrjfqKCjo4H7d/G1lW6LXV2OXObw6baLbAwsRP2qFMUzQLghfl+x9djUD5ekJbygJTymEhe1Vgw4hwL8=
X-Received: by 2002:a05:6e02:152c:: with SMTP id i12mr6137116ilu.46.1610978457643;
 Mon, 18 Jan 2021 06:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20210115182909.314756-1-aford173@gmail.com> <20210118125204.hxsanoohwvdtdvym@fsr-ub1664-175>
In-Reply-To: <20210118125204.hxsanoohwvdtdvym@fsr-ub1664-175>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 18 Jan 2021 08:00:43 -0600
Message-ID: <CAHCN7x+CXUuPN7upiv3D+REOU4d_=i30no+SkRzUjWY58o=uUQ@mail.gmail.com>
Subject: Re: [PATCH V3] clk: imx: Fix reparenting of UARTs not associated with sdout
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
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

On Mon, Jan 18, 2021 at 6:52 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> On 21-01-15 12:29:08, Adam Ford wrote:
>
> ...
>
> > diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
> > index a66cabfbf94f..66192fe0a898 100644
> > --- a/drivers/clk/imx/clk-imx25.c
> > +++ b/drivers/clk/imx/clk-imx25.c
> > @@ -73,16 +73,6 @@ enum mx25_clks {
> >
> >  static struct clk *clk[clk_max];
> >
> > -static struct clk ** const uart_clks[] __initconst = {
> > -     &clk[uart_ipg_per],
> > -     &clk[uart1_ipg],
> > -     &clk[uart2_ipg],
> > -     &clk[uart3_ipg],
> > -     &clk[uart4_ipg],
> > -     &clk[uart5_ipg],
> > -     NULL
> > -};
> > -
>
> I'm assuming there is another patch that updates the dts files. Right ?

I have only been able to test this on an i.MX8M Mini.  I need to set
the parent clock of the i.MX8M Mini to an 80 MHz clock in order to run
the UART at 4Mbps.   With this patch, I can stop enabling the all the
UART clocks early and allow the clock parent configuration to occur.
From what I can tell, the remaining clocks should get activated as
they are needed, because I was able to use Bluetooth connected to
UART1 running at 4MBps using a 80MHz clock source with this patch, and
the clk_summary shows the clock is running at the proper speed.
Without this patch, the UART fails to re-parent, so I'm stuck at lower
speeds and that means choppy Bluetooth audio.

The Kernel that NXP hosts on Code Aurora that they use for Yocto
attempts scan through stdout to only enable those clocks [1].  I
attempted to push it upstream, but it was rejected [2].  Sascha
suggested creating an array which could be filled when the clocks are
enabled and that array would be used to deactivate the clocks at
shutdown.  That's what I attempted to do here.

I don't have older imx boards to know if their device trees are
configured in such a way without modifications to the device tree or
not, but since it appears to work for NXP in [2], I assumed it would
work here.

[1] - https://source.codeaurora.org/external/imx/linux-imx/commit/drivers/clk/imx/clk.c?h=imx_5.4.47_2.2.0&id=754ae82cc55b7445545fc2f092a70e0f490e9c1b
[2] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201229145130.2680442-1-aford173@gmail.com/

>
> TBH, I'm against the idea of having to call consumer API from a clock provider driver.
> I'm still investigating a way of moving the uart clock control calls in drivers/serial/imx,
> where they belong.

That makes sense.

>
> >  static int __init __mx25_clocks_init(void __iomem *ccm_base)
> >  {
> >       BUG_ON(!ccm_base);
> > @@ -228,7 +218,7 @@ static int __init __mx25_clocks_init(void __iomem *ccm_base)
> >        */
> >       clk_set_parent(clk[cko_sel], clk[ipg]);
> >
> > -     imx_register_uart_clocks(uart_clks);
> > +     imx_register_uart_clocks(6);
>
> Suggestion: Maybe the number of clocks can be determined by the existing clocks in that dts node.
> Hardcoding is not a good ideea here.

The tables were hard-coded before, so the idea was to pass the maximum
number of clocks instead the entire table.  The higher-level clock
code wouldn't necessarily know the maximum number of UART clocks since
the number of UARTs may change depending on the SoC.  So that
hard-coded number was simply the number of entries that were
previously used in the array that was previously passed.  When
creating a table of active clocks, it could use the number passed to
define an array, and fill the array with data grabbed from of_stdout.

If you want, I could leave the existing UART clocks alone, and create
a new function that uses the array of clocks passed to it to count the
number of available clocks.  It would limit the scope of the change to
clk/imx/clk.c.  I think that would be easier than trying to parse the
DT for a bunch of compatible flags looking for a bunch of UARTS and
their respective clocks.

If you'd rather do something in the serial imx driver, I can hold off.

adam
>
> ...
>
> >
> > diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> > index 47882c51cb85..158fe302a8b7 100644
> > --- a/drivers/clk/imx/clk.c
> > +++ b/drivers/clk/imx/clk.c
> > @@ -147,8 +147,10 @@ void imx_cscmr1_fixup(u32 *val)
> >  }
> >
> >  #ifndef MODULE
> > -static int imx_keep_uart_clocks;
> > -static struct clk ** const *imx_uart_clocks;
> > +
> > +static bool imx_keep_uart_clocks;
> > +static int imx_enabled_uart_clocks;
> > +static struct clk **imx_uart_clocks;
> >
> >  static int __init imx_keep_uart_clocks_param(char *str)
> >  {
> > @@ -161,24 +163,43 @@ __setup_param("earlycon", imx_keep_uart_earlycon,
> >  __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
> >             imx_keep_uart_clocks_param, 0);
> >
> > -void imx_register_uart_clocks(struct clk ** const clks[])
> > +void imx_register_uart_clocks(unsigned int clk_count)
> >  {
> > +#ifdef CONFIG_OF
> >       if (imx_keep_uart_clocks) {
> >               int i;
> >
> > -             imx_uart_clocks = clks;
> > -             for (i = 0; imx_uart_clocks[i]; i++)
> > -                     clk_prepare_enable(*imx_uart_clocks[i]);
> > +             imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
> > +             imx_enabled_uart_clocks = 0;
> > +
> > +             for (i = 0; i < clk_count; i++) {
> > +                     imx_uart_clocks[imx_enabled_uart_clocks] = of_clk_get(of_stdout, i);
> > +
> > +                     /* Stop if there are no more of_stdout references */
> > +                     if (IS_ERR(imx_uart_clocks[imx_enabled_uart_clocks]))
> > +                             return;
> > +
> > +                     /* Only enable the clock if it's not NULL */
> > +                     if (imx_uart_clocks[imx_enabled_uart_clocks])
> > +                             clk_prepare_enable(imx_uart_clocks[imx_enabled_uart_clocks++]);
> > +             }
> >       }
> > +#else
> > +     /* i.MX boards use device trees now.  For build tests without CONFIG_OF, do nothing */
> > +     imx_enabled_uart_clocks = 0;
> > +#endif
>
> Don't really see the point of this #ifdef here. Just makes the code more messy.
>

I added the #ifdef here because I got an e-mail from a bot from a
previous attempt.  The bot failed to build, because the build test
using a different defconfig file that doesn't enable CONFIG_OF.  For
the purposes of using this code, the CONFIG_OF is required, but
without changes to Kconfig, this seemed like an easy way to prevent
build errors for the bot.  I didn't want to break something else by
changing the Kconfig dependencies because I wasn't sure how many build
bots exist.

adam
> >  }
> >
> >  static int __init imx_clk_disable_uart(void)
> >  {
> > -     if (imx_keep_uart_clocks && imx_uart_clocks) {
> > +     if (imx_keep_uart_clocks && imx_enabled_uart_clocks) {
> >               int i;
> >
> > -             for (i = 0; imx_uart_clocks[i]; i++)
> > -                     clk_disable_unprepare(*imx_uart_clocks[i]);
> > +             for (i = 0; i < imx_enabled_uart_clocks; i++) {
> > +                     clk_disable_unprepare(imx_uart_clocks[i]);
> > +                     clk_put(imx_uart_clocks[i]);
> > +             };
> > +             kfree(imx_uart_clocks);
> >       }
> >
> >       return 0;
> > diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> > index 4f04c8287286..7571603bee23 100644
> > --- a/drivers/clk/imx/clk.h
> > +++ b/drivers/clk/imx/clk.h
> > @@ -11,9 +11,9 @@ extern spinlock_t imx_ccm_lock;
> >  void imx_check_clocks(struct clk *clks[], unsigned int count);
> >  void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
> >  #ifndef MODULE
> > -void imx_register_uart_clocks(struct clk ** const clks[]);
> > +void imx_register_uart_clocks(unsigned int clk_count);
> >  #else
> > -static inline void imx_register_uart_clocks(struct clk ** const clks[])
> > +static inline void imx_register_uart_clocks(unsigned int clk_count)
> >  {
> >  }
> >  #endif
> > --
> > 2.25.1
> >
