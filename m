Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73255285E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgJGLea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgJGLeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:34:14 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2EC061755;
        Wed,  7 Oct 2020 04:34:14 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id bl9so901048qvb.10;
        Wed, 07 Oct 2020 04:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gd24hGze2dlKa1wOLIr4c2viYI7MlJtHZphDgoFUVs=;
        b=nej5WNcIK56SyOCybSZumZqJf6A/JHEfjj+e5VIiFKbJBj6j7UWT81hQlpCTN37QGo
         NvnDzREDJxVx9252ux3ihNf+AC2FgEuJhUyjBIjDG909ls7E6QR5TTMewcZStskxnYXc
         k9OsItoE1oB7RI1mFp0plZooxsP2BJhrpy17w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gd24hGze2dlKa1wOLIr4c2viYI7MlJtHZphDgoFUVs=;
        b=i2j5ZPFca502knq7LRCLWNdZkX9dHE+ofl8ZruLHpQQRNInQgFbCuBizhcfMi9NK9l
         O4X2rr2gl1NXKu2hI0bLxvuZbua7SjJ1v0HKP0JFtL+GjM47pzJRuZxODP+6rQqrWtVF
         suKdOlIgeXrGlWSdfmVdctKPhq1WZNsP14oosFKON817eX+R7MfzzDPtyvXX+Fwk67Tx
         auRQKjgQUXtJeNjSjAjO87LPmFakLkNUnD9KygyePofZ7IAs3cSDf/Kph+/FTZ4/1yT7
         9OG6dMyv03DhRVu3ylCyZSCbFjIETOi2I63hKVR9QIn/UnTDb53S/IuKuIjmjFDMe2hp
         Zw7g==
X-Gm-Message-State: AOAM533kC8NQp1dPbO1HDaDJIoG4wC6wuViN8CBRSkInL2IY13tK2MxL
        WR1WIsQp3uVraBUCWrcNndaoBm7AgPWwAqyHxVA=
X-Google-Smtp-Source: ABdhPJxHGdLEOTYZ/YuiJaeWNOoKwHPMWh2RBpBkOnkUGWbXX9IQhzyjEUxAW3FfGri+qbzFdcHFn6OEjIS9aoHCpWo=
X-Received: by 2002:ad4:51c6:: with SMTP id p6mr2793618qvq.18.1602070453395;
 Wed, 07 Oct 2020 04:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
 <20200928070108.14040-2-ryan_chen@aspeedtech.com> <CACPK8XcjmxBGUfDxE2WB3zBgG8OCoRMogfG=Fk5f+wNZu0pjMg@mail.gmail.com>
 <HK0PR06MB338059A24B66C14675298D0BF2320@HK0PR06MB3380.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB338059A24B66C14675298D0BF2320@HK0PR06MB3380.apcprd06.prod.outlook.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 7 Oct 2020 11:34:01 +0000
Message-ID: <CACPK8XdBmkhZ8mcSFmDAFV8k7Qj7ajBL8TVKfK8c+5aneUMHZw@mail.gmail.com>
Subject: Re: [PATCH 1/1] clk: aspeed: modify some default clks are critical
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 at 08:40, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> > From: Joel Stanley <joel@jms.id.au>
> > Sent: Tuesday, September 29, 2020 4:04 PM
> > To: Ryan Chen <ryan_chen@aspeedtech.com>; Jae Hyun Yoo
> > <jae.hyun.yoo@linux.intel.com>; Andrew Jeffery <andrew@aj.id.au>
> > Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> > <sboyd@kernel.org>; linux-clk@vger.kernel.org; Linux ARM
> > <linux-arm-kernel@lists.infradead.org>; linux-aspeed
> > <linux-aspeed@lists.ozlabs.org>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; BMC-SW <BMC-SW@aspeedtech.com>
> > Subject: Re: [PATCH 1/1] clk: aspeed: modify some default clks are critical
> >
> > On Mon, 28 Sep 2020 at 07:01, Ryan Chen <ryan_chen@aspeedtech.com>
> > wrote:
> > >
> > > In ASPEED SoC LCLK is LPC clock for all SuperIO device, UART1/UART2
> > > are default for Host SuperIO UART device, eSPI clk for Host eSPI bus
> > > access eSPI slave channel, those clks can't be disable should keep
> > > default, otherwise will affect Host side access SuperIO and SPI slave device.
> > >
> > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > > ---
> > >  drivers/clk/clk-aspeed.c  | 8 ++++----  drivers/clk/clk-ast2600.c | 8
> > > ++++----
> > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c index
> > > 411ff5fb2c07..d348c4fd3f9f 100644
> > > --- a/drivers/clk/clk-aspeed.c
> > > +++ b/drivers/clk/clk-aspeed.c
> > > @@ -54,15 +54,15 @@ static const struct aspeed_gate_data aspeed_gates[]
> > = {
> > >         [ASPEED_CLK_GATE_DCLK] =        {  5, -1, "dclk-gate",
> > NULL,   CLK_IS_CRITICAL }, /* DAC */
> > >         [ASPEED_CLK_GATE_REFCLK] =      {  6, -1, "refclk-gate",
> > "clkin", CLK_IS_CRITICAL },
> > >         [ASPEED_CLK_GATE_USBPORT2CLK] = {  7,  3, "usb-port2-gate",
> > NULL,   0 }, /* USB2.0 Host port 2 */
> > > -       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",
> > NULL,   0 }, /* LPC */
> > > +       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",
> > NULL,   CLK_IS_CRITICAL }, /* LPC */
> > >         [ASPEED_CLK_GATE_USBUHCICLK] =  {  9, 15, "usb-uhci-gate",
> > NULL,   0 }, /* USB1.1 (requires port 2 enabled) */
> > >         [ASPEED_CLK_GATE_D1CLK] =       { 10, 13, "d1clk-gate",
> > NULL,   0 }, /* GFX CRT */
> > >         [ASPEED_CLK_GATE_YCLK] =        { 13,  4, "yclk-gate",
> > NULL,   0 }, /* HAC */
> > >         [ASPEED_CLK_GATE_USBPORT1CLK] = { 14, 14, "usb-port1-gate",
> > NULL,   0 }, /* USB2 hub/USB2 host port 1/USB1.1 dev */
> > > -       [ASPEED_CLK_GATE_UART1CLK] =    { 15, -1, "uart1clk-gate",
> > "uart", 0 }, /* UART1 */
> > > -       [ASPEED_CLK_GATE_UART2CLK] =    { 16, -1, "uart2clk-gate",
> > "uart", 0 }, /* UART2 */
> > > +       [ASPEED_CLK_GATE_UART1CLK] =    { 15, -1, "uart1clk-gate",
> > "uart", CLK_IS_CRITICAL }, /* UART1 */
> > > +       [ASPEED_CLK_GATE_UART2CLK] =    { 16, -1, "uart2clk-gate",
> > "uart", CLK_IS_CRITICAL }, /* UART2 */
> > >         [ASPEED_CLK_GATE_UART5CLK] =    { 17, -1, "uart5clk-gate",
> > "uart", 0 }, /* UART5 */
> > > -       [ASPEED_CLK_GATE_ESPICLK] =     { 19, -1, "espiclk-gate",
> > NULL,   0 }, /* eSPI */
> > > +       [ASPEED_CLK_GATE_ESPICLK] =     { 19, -1, "espiclk-gate",
> > NULL,   CLK_IS_CRITICAL }, /* eSPI */
> >
> > This is fine for systems that have eSPI. For systems that do not use eSPI, the
> > clocks are not "required".
> >
> > I was sent a similar patch by Jae some time ago:
> >
> >
> > https://lore.kernel.org/openbmc/697a184b-ef99-a46e-bf98-4d339b3aafd8@lin
> > ux.intel.com/
> >
> > Better is to associate drivers with these clocks, and those drivers will ensure
> > they are left enabled.
> >
> > Alternatively, we will need to come up with a device tree binding to describe
> > the hardware requirement that these clocks are left on.
> >
> ASPEED BMC SoC have SuperIO device that default enable, even without BMC fw boot.
> Host can use SUART1/SUART2/GPIO....
> That the reason even Linux kernel boot should not change the SoC default clk, that is the impact.

Ok, that makes sense. Linux will not enable these clocks if a driver
is loaded for them though, so we should load a driver for them.

ESPI: We do not have an upstream driver for eSPI, but once you submit
one this will solve the eSPI issue.

LPC: The existing LPC driver will enable the clock, so by loading that
this clock will be left enabled.

UART1/UART2: This is harder, as the SUART mode means the BMC does not
load a driver for these devices. We could add a property to the device
tree to describe the clocks that must be left on?

Cheers,

Joel
