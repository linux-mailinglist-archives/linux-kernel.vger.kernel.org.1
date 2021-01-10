Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFFF2F05B2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 07:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbhAJGYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 01:24:22 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49013 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbhAJGYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 01:24:21 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10A6LDVW002917;
        Sun, 10 Jan 2021 07:21:13 +0100
Date:   Sun, 10 Jan 2021 07:21:13 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Tang <dt.tangr@gmail.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yoshinori Sato <ysato@users.osdn.me>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Mark Salter <msalter@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: Old platforms: bring out your dead
Message-ID: <20210110062113.GA2912@1wt.eu>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu>
 <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 10:52:53PM +0100, Arnd Bergmann wrote:
(... i486 ...)
> As with the other older platforms, the main question to ask is:
> Are there users that are better off running a future LTS kernel on this
> hardware than the v5.10.y version or something older?

I think this is the most important part of the question. Because the
possible use case I've described actually doesn't correspond to a
"prod" machine but to a machine that's powered on every 5 years for
some old data recovery. In such a case users just start with an old
system (possibly the one that's still on them if present), and this
doesn't warrant an up-to-date OS.

Moreover, just as I experienced when maintaining 2.4, there's a point
where support for old stuff starts to break again by lack of testing.
And just because of this, users shouldn't always expect to see their
old machines boot fine on a recent kernel. Sometimes there may even be
difficulties setting up a compatible toolchain.

So actually the question shouldn't be "does anyone want such old
machines to still be supported" but "does anyone *need* them to be
supported". And I suspect that for most of them the response is "no",
it's just a convenience.

Just my two cents,
Willy
