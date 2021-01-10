Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544502F096D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 20:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbhAJTwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 14:52:30 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60236 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbhAJTw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 14:52:29 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kygkT-00HMyn-Ut; Sun, 10 Jan 2021 20:51:37 +0100
Date:   Sun, 10 Jan 2021 20:51:37 +0100
From:   Andrew Lunn <andrew@lunn.ch>
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
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
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: Old platforms: bring out your dead
Message-ID: <X/tayUwdMuhmuo+n@lunn.ch>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <X/o4VZzW4m77AYDB@lunn.ch>
 <CAK8P3a3kg1u3QVj1JS92Js7ZO9HvgDfzBtEbN4HULpNfNEJfoA@mail.gmail.com>
 <X/svb+7x15IiVxU5@lunn.ch>
 <CAK8P3a3zkUjiQzscX5TH_PH9HhNEMa59soQ4gD7aX1fWJOBt6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3zkUjiQzscX5TH_PH9HhNEMa59soQ4gD7aX1fWJOBt6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 06:27:12PM +0100, Arnd Bergmann wrote:
> On Sun, Jan 10, 2021 at 5:48 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > For this platform, I'm most interested in whether there are still users
> > > that rely on board files instead of DT. AFAIU we could just fold
> > > the DT variant into arch-mvebu like kirkwood was, right?
> >
> > Hi Arnd
> >
> > I'm actually booting my device using a board file. But Debian
> > flash-kernel is pretty unhappy about that. The bootloader i have on
> > this machine is too old to passed DT blob. I will test appended DT
> > blob still works. And see if we have any board files which also don't
> > have a DT representation.
 
Hi Arnd

Appended DT works fine for my device.

> It may help to ask for these at
> https://github.com/1000001101000/Debian_on_Buffalo/,

Thanks for the link.

I looked at the remaining board files and i'm cooking up a set of
patches. I don't see any reason to keep the Marvell reference designs
around, especially since one has been converted to DT and gives a good
example how the others could be converted.

The two WiFi devices have been dropped by OpenWRT, too little
RAM/FLASH. OpenWRT seems like the most likely downstream user, so if
they have given up supporting them, i think it is safe for mainline to
drop them.

I checked with the ts78xx Maintainer and he says we can drop that.

Kurobox Pro has a DTS file, so i've dropped to board file.

What is left are NAS boxes. The low FLASH is not really an issue for
them, they can run with the OS on the disk. And they are the sort of
device which does have a long life.

       Andrew
