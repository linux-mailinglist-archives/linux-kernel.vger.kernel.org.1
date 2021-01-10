Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550702F0900
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 19:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbhAJSQp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 10 Jan 2021 13:16:45 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:47291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJSQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 13:16:45 -0500
Received: from linux-e202.suse.de ([87.156.29.153]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mr8O8-1kD0WB40Jy-00oGN1; Sun, 10 Jan 2021 19:12:38 +0100
From:   Fabian Vogt <fabian@ritter-vogt.de>
To:     Daniel Tang <dt.tangr@gmail.com>, Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: Old platforms: bring out your dead
Date:   Sun, 10 Jan 2021 19:12:24 +0100
Message-ID: <1702853.1557dWfJA4@linux-e202.suse.de>
In-Reply-To: <CAK8P3a0o=1KjPtp0Ah8Afe5vvG1b72+77HRFh4Z06HUGwN6+Ew@mail.gmail.com>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com> <67171E13-6786-4B44-A8C2-3302963B055F@gmail.com> <CAK8P3a0o=1KjPtp0Ah8Afe5vvG1b72+77HRFh4Z06HUGwN6+Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FZfLnsMqM+HOkFR0A8Q+7hD0yEN6vJJp7umyK7UxHG2SFbYGYqe
 prdJag+bq2hU69eIOwNmBTT4vgJPuhGBNVxvuFE/d/xc3TK0NlHfYK3/AbsEtp7ERFWCgHh
 oeteavuGRbdJA8qmy3CJCrDABvp8xwdHwVTivZ83/VthdOYNS4VD8xikOz/5n7HaRM08BC0
 Rh7tAL3GZueJ+hxcFuyVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vSk/mHijXw4=:tQjamyoZ/Bl2bxHBtUPnQy
 Tf6sDTYDvd4imhZ+OoEbEKp6+Q57Ben7GYfkyK3KB14DEqrp166WQZDxzxcxFvTCxCJ+wITS8
 y48uvjBfwbsOHcc4lxDaZu+kD8K1HWhWN8kIUbevevUOgTUxPkyxgvan+A0p0gWabG0YgoodA
 wNPmylbeRb4hwrsGhGdFBCdgjRgFPdIYD+Cd343vgd0nDKsiGh8xdDWurhiFtjX/JeOriQCLa
 rreNPrQ9rbrNmykF8ncUYShuoKFwepqP/Lpq3HJ60hSMH6Smx17vEw+hQgqamCM8OqVGnY/Z4
 SidCTK+SMWopl6NWLbfZiptvng4HJQvO+T8lAo6ylN/YFXP6D3xlQYYEMyYvXSEtwyoh8WYUy
 xlJe5sqqiyNMjLDaOXMCbbACAhCpv+oo4nRuHFM8fDcLop3v18H9KSagb/sxBTUBu9zezY1tl
 xuTTsPGAQg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Samstag, 9. Januar 2021, 23:20:48 CET schrieb Arnd Bergmann:
> On Sat, Jan 9, 2021 at 1:06 AM Daniel Tang <dt.tangr@gmail.com> wrote:
> >
> > Hi Arnd,
> >
> > On 9 Jan 2021, at 9:55 am, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > * nspire -- added in 2013, no notable changes after 2015

Most of the platform is just the DT sources and some small drivers around it,
so it's actually fairly low maintenance. So far the migration away from
panel-simple in 2019
(https://lore.kernel.org/linux-arm-kernel/20190805085847.25554-1-linus.walleij@linaro.org)
was the biggest required change so far.

> > I believe this is still in active use. I’ve CC’d Fabian into this thread who’s
> > probably in a better position to respond to this.
> 
> Ok, moving it to the "keep around for now list" as well, to be on the
> safe side.

Thanks!

> Would either of you already have a guess for how long it makes
> sense to update kernels on it?
> 
> I see that this is one of the more limited platforms with just 32MB
> of RAM (64MB in case of CX), and kernels only get more bloated over
> time, so I expect at some point you will be stuck with running old
> software.

The kernel overhead isn't actually that bad. I just built today's 2ff90100ace8
and booted it with a busybox-based initrd. free -m reports:
total used free shared buffers
   58   12   46      0       0

Relatively speaking, still mostly unused ;-) The stock OS actually uses more!
With 32MiB, the situation is definitely worse, but still manageable. Should
that change in the future, dropping just the Classic/CM variants would be a
possible option, but that still seems far enough away.

> Wikipedia tells me that new models came out recently. Are you
> planning to add support for those as well?

Yes, someone from the community actually managed to boot Linux on a CX II-T,
and I'm hoping to get that upstreamed soon. Most of the hardware changes are
supported by drivers already and so this is mainly just another device tree.

Cheers,
Fabian

>       Arnd


