Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45CA27BEC5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgI2IES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgI2IES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:04:18 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFC1C061755;
        Tue, 29 Sep 2020 01:04:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id nw23so13705799ejb.4;
        Tue, 29 Sep 2020 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUa+xvZy/7cB0wwXcdXBfj8jGK+yRtDAUkUhMRWpR4o=;
        b=MjqLYoEE+qBSg/GzATHWw9GBatBo9v4SP5jOwtI0jwd2c5/87LSVOJPLIhWmJPu5Bb
         BjV4QwVm6Hd8uRdNydG2qxRrHXeQVlOGphsDLJH0Jv976yNEovylTs9cm+rH5PA0+DVn
         6w4vf14iFU+t7q3Hr95x8Z8N7SGTwg097ndN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUa+xvZy/7cB0wwXcdXBfj8jGK+yRtDAUkUhMRWpR4o=;
        b=s0VELAV9NqfHacOB7EXnCzl+7Mk78UJ+Rg7jlByDA61PDa3cGxlkJ9cGetLoIeqiWu
         RlFZ+NBWud7G1SSvu8CbMs+8e3be1ZY9/mWLdb0I++FmC1Th9ClVCXaKy9ic3i363Kvj
         6dLR0Ywr5dI43iILD/joUpiZP3DHIwjZfX9Y5CNVfKqvUKb85LSgiEWwbpIGcro3bNMp
         H2v4f5qCoQ5vXeJLA4L5aGfSKy1uuZWRBnj50ESw8XEB7ZRva9xW32cYBqKYadD6iZEd
         vIOzxfu6k6Km/vg8QlrVfuSMEbtwnh8moGB49lQ6F93CkBzPM4LGZOHYpVApAJpkMZaz
         iYGA==
X-Gm-Message-State: AOAM531ZkPFFiH79/TcM1BcTzprb8n+9nitg30lNXkx+wa0LeATNNFqI
        6y3UB7DLZB5Gk6vaKgSyDzWthJElN7J1SVdxJuqAqLufMCk=
X-Google-Smtp-Source: ABdhPJxEODavPJEfXr23rNjBTzc8oqyeWOJt3o9hhYbv3h/UzopdrVvnBL6Foc1EMWfAe7OigZ3oD9sHc8JF/HOuqbc=
X-Received: by 2002:a17:906:4cd6:: with SMTP id q22mr2567547ejt.139.1601366656755;
 Tue, 29 Sep 2020 01:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com> <20200928070108.14040-2-ryan_chen@aspeedtech.com>
In-Reply-To: <20200928070108.14040-2-ryan_chen@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 29 Sep 2020 08:04:04 +0000
Message-ID: <CACPK8XcjmxBGUfDxE2WB3zBgG8OCoRMogfG=Fk5f+wNZu0pjMg@mail.gmail.com>
Subject: Re: [PATCH 1/1] clk: aspeed: modify some default clks are critical
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bmc-sw@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 at 07:01, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> In ASPEED SoC LCLK is LPC clock for all SuperIO device, UART1/UART2 are
> default for Host SuperIO UART device, eSPI clk for Host eSPI bus access
> eSPI slave channel, those clks can't be disable should keep default,
> otherwise will affect Host side access SuperIO and SPI slave device.
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/clk/clk-aspeed.c  | 8 ++++----
>  drivers/clk/clk-ast2600.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 411ff5fb2c07..d348c4fd3f9f 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -54,15 +54,15 @@ static const struct aspeed_gate_data aspeed_gates[] = {
>         [ASPEED_CLK_GATE_DCLK] =        {  5, -1, "dclk-gate",          NULL,   CLK_IS_CRITICAL }, /* DAC */
>         [ASPEED_CLK_GATE_REFCLK] =      {  6, -1, "refclk-gate",        "clkin", CLK_IS_CRITICAL },
>         [ASPEED_CLK_GATE_USBPORT2CLK] = {  7,  3, "usb-port2-gate",     NULL,   0 }, /* USB2.0 Host port 2 */
> -       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",          NULL,   0 }, /* LPC */
> +       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",          NULL,   CLK_IS_CRITICAL }, /* LPC */
>         [ASPEED_CLK_GATE_USBUHCICLK] =  {  9, 15, "usb-uhci-gate",      NULL,   0 }, /* USB1.1 (requires port 2 enabled) */
>         [ASPEED_CLK_GATE_D1CLK] =       { 10, 13, "d1clk-gate",         NULL,   0 }, /* GFX CRT */
>         [ASPEED_CLK_GATE_YCLK] =        { 13,  4, "yclk-gate",          NULL,   0 }, /* HAC */
>         [ASPEED_CLK_GATE_USBPORT1CLK] = { 14, 14, "usb-port1-gate",     NULL,   0 }, /* USB2 hub/USB2 host port 1/USB1.1 dev */
> -       [ASPEED_CLK_GATE_UART1CLK] =    { 15, -1, "uart1clk-gate",      "uart", 0 }, /* UART1 */
> -       [ASPEED_CLK_GATE_UART2CLK] =    { 16, -1, "uart2clk-gate",      "uart", 0 }, /* UART2 */
> +       [ASPEED_CLK_GATE_UART1CLK] =    { 15, -1, "uart1clk-gate",      "uart", CLK_IS_CRITICAL }, /* UART1 */
> +       [ASPEED_CLK_GATE_UART2CLK] =    { 16, -1, "uart2clk-gate",      "uart", CLK_IS_CRITICAL }, /* UART2 */
>         [ASPEED_CLK_GATE_UART5CLK] =    { 17, -1, "uart5clk-gate",      "uart", 0 }, /* UART5 */
> -       [ASPEED_CLK_GATE_ESPICLK] =     { 19, -1, "espiclk-gate",       NULL,   0 }, /* eSPI */
> +       [ASPEED_CLK_GATE_ESPICLK] =     { 19, -1, "espiclk-gate",       NULL,   CLK_IS_CRITICAL }, /* eSPI */

This is fine for systems that have eSPI. For systems that do not use
eSPI, the clocks are not "required".

I was sent a similar patch by Jae some time ago:

 https://lore.kernel.org/openbmc/697a184b-ef99-a46e-bf98-4d339b3aafd8@linux.intel.com/

Better is to associate drivers with these clocks, and those drivers
will ensure they are left enabled.

Alternatively, we will need to come up with a device tree binding to
describe the hardware requirement that these clocks are left on.

Cheers,

Joel

>         [ASPEED_CLK_GATE_MAC1CLK] =     { 20, 11, "mac1clk-gate",       "mac",  0 }, /* MAC1 */
>         [ASPEED_CLK_GATE_MAC2CLK] =     { 21, 12, "mac2clk-gate",       "mac",  0 }, /* MAC2 */
>         [ASPEED_CLK_GATE_RSACLK] =      { 24, -1, "rsaclk-gate",        NULL,   0 }, /* RSA */
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index bbacaccad554..6802a2d5bbe2 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -86,8 +86,8 @@ static const struct aspeed_gate_data aspeed_g6_gates[] = {
>         /* Reserved 26 */
>         [ASPEED_CLK_GATE_EMMCCLK]       = { 27, 16, "emmcclk-gate",     NULL,    0 },   /* For card clk */
>         /* Reserved 28/29/30 */
> -       [ASPEED_CLK_GATE_LCLK]          = { 32, 32, "lclk-gate",        NULL,    0 }, /* LPC */
> -       [ASPEED_CLK_GATE_ESPICLK]       = { 33, -1, "espiclk-gate",     NULL,    0 }, /* eSPI */
> +       [ASPEED_CLK_GATE_LCLK]          = { 32, 32, "lclk-gate",        NULL,    CLK_IS_CRITICAL }, /* LPC */
> +       [ASPEED_CLK_GATE_ESPICLK]       = { 33, -1, "espiclk-gate",     NULL,    CLK_IS_CRITICAL }, /* eSPI */
>         [ASPEED_CLK_GATE_REF1CLK]       = { 34, -1, "ref1clk-gate",     "clkin", CLK_IS_CRITICAL },
>         /* Reserved 35 */
>         [ASPEED_CLK_GATE_SDCLK]         = { 36, 56, "sdclk-gate",       NULL,    0 },   /* SDIO/SD */
> @@ -102,8 +102,8 @@ static const struct aspeed_gate_data aspeed_g6_gates[] = {
>         [ASPEED_CLK_GATE_I3C5CLK]       = { 45,  45, "i3c5clk-gate",    NULL,    0 },   /* I3C5 */
>         [ASPEED_CLK_GATE_I3C6CLK]       = { 46,  46, "i3c6clk-gate",    NULL,    0 },   /* I3C6 */
>         [ASPEED_CLK_GATE_I3C7CLK]       = { 47,  47, "i3c7clk-gate",    NULL,    0 },   /* I3C7 */
> -       [ASPEED_CLK_GATE_UART1CLK]      = { 48,  -1, "uart1clk-gate",   "uart",  0 },   /* UART1 */
> -       [ASPEED_CLK_GATE_UART2CLK]      = { 49,  -1, "uart2clk-gate",   "uart",  0 },   /* UART2 */
> +       [ASPEED_CLK_GATE_UART1CLK]      = { 48,  -1, "uart1clk-gate",   "uart",  CLK_IS_CRITICAL },     /* UART1 */
> +       [ASPEED_CLK_GATE_UART2CLK]      = { 49,  -1, "uart2clk-gate",   "uart",  CLK_IS_CRITICAL },     /* UART2 */
>         [ASPEED_CLK_GATE_UART3CLK]      = { 50,  -1, "uart3clk-gate",   "uart",  0 },   /* UART3 */
>         [ASPEED_CLK_GATE_UART4CLK]      = { 51,  -1, "uart4clk-gate",   "uart",  0 },   /* UART4 */
>         [ASPEED_CLK_GATE_MAC3CLK]       = { 52,  52, "mac3clk-gate",    "mac34", 0 },   /* MAC3 */
> --
> 2.17.1
>
