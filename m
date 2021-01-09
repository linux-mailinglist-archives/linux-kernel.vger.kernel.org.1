Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3C2F0443
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 00:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAIXNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 18:13:16 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:59204 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbhAIXNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 18:13:16 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kyNPB-00HBcJ-NF; Sun, 10 Jan 2021 00:12:21 +0100
Date:   Sun, 10 Jan 2021 00:12:21 +0100
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
Message-ID: <X/o4VZzW4m77AYDB@lunn.ch>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Then there are ARM platforms that are old but have still seen some work
> in the past years. If I hear nothing, these will all stay, but if maintainers
> may want to drop them anyway, I can help with that:

Hi Arnd

I notice orion5x is not on this list. Is that because of Debian still
building for it?

I just blew the dust out of my orion5x RDK and booted 5.11-rc2 on it.
orion5x_defconfig needs a few updates, but otherwise it seems to work
O.K.

But i have no idea if there are any real users out there running
modern kernels.

       Andrew
