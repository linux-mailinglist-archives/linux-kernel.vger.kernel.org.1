Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C292F203A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391458AbhAKT7F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Jan 2021 14:59:05 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57903 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbhAKT7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:59:02 -0500
X-Originating-IP: 90.2.82.147
Received: from windsurf.home (aputeaux-654-1-223-147.w90-2.abo.wanadoo.fr [90.2.82.147])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 95A43E0003;
        Mon, 11 Jan 2021 19:58:15 +0000 (UTC)
Date:   Mon, 11 Jan 2021 20:58:14 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Tang <dt.tangr@gmail.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Alex Elder <elder@linaro.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Mark Salter <msalter@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: Old platforms: bring out your dead
Message-ID: <20210111205814.0e6d3493@windsurf.home>
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I haven't gone through the full thread, so sorry if some of the below
information duplicates stuff that was already said.

On Fri, 8 Jan 2021 23:55:06 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> * asm9260 -- added in 2014, no notable changes after 2015
> * axxia -- added in 2014, no notable changes after 2015
> * bcm/kona -- added in 2013, no notable changes after 2014
> * digicolor -- added in 2014, no notable changes after 2015
> * dove -- added in 2009, obsoleted by mach-mvebu in 2015

arch/arm/mach-dove has two remaining board files, cm-a510.c and
dove-db-setup.c. The former is covered by the
dove-cm-a510.dtsi/dove-sbc-a510.dts DTs and the latter by
dove-dove-db.dts.

However, dove-dove-db.dts doesn't seem to have all the features of
dove-db-setup.c. The DT only enables UART, SDIO, SATA, SPI and I2C0.
The board file has PCIe, Ethernet, USB.

The dove-sbc-a510.dts seems much more complete, as it includes
Ethernet, PCIe, USB in addition to SATA, SDIO, I2C, SPI, UART, etc.

So overall, I'd say that yes we could probably drop arch/arm/mach-dove/.

> * spear -- added in 2010, no notable changes since 2015

Well, I did quite a few improvements in spear DTs in 2017, some
improvements to the NAND FSMC driver for Spear, and my colleague Miquèl
Raynal fixed an issue in the Spear NOR driver in 2019.

We have one customer running a 4.14 upstream kernel on a Spear600
product, and this was a fairly "recent" port, in the sense that the
product was originally running WinCE, and we ported Linux to it many
years later after the product was first shipped.

> * lpc32xx -- added in 2010, multiplatform 2019, hardware is EOL

As late as early 2020, we were finishing the migration of one of our
customer LPC32xx platform to a recent mainline kernel.

So in fact for us at Bootlin, it happens pretty regularly to see users
of "legacy" platforms having a need for an updated kernel. From the
above, you can see that even legacy SoCs such as Spear600 and LPC32xx
are still used in products were kernel are being updated.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
