Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79F22F03EA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 22:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbhAIVxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 16:53:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbhAIVxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 16:53:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C63E423AC6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 21:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610229190;
        bh=HEqZj2HKCVGkWXS6z1aZpQYQPvyew/qWMqRtqfGnMKI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V9ld5dwKb15Agn8zL8BFKnLlI7txOwTrHoBcmlZ8nhzDfIk6CO3fq1nUA9qh4zTOZ
         cHynqOXjjfSSr7/OZ2sVD7WQsFs7D2Jg7WeskRLcdpuvDGJsw1Shd+fT06So5Fzr6y
         gUbN+47sbWiPYKz9NiD7lfkY2h1xb89fUp9IS3N0fw+sIzODarC1WTXA5t4oWzXGdi
         /H54sWGdjOuCp48/+gyRpAF0RBWC0+4nj0q3SY+dBfF5KzkBjm14ZbAlE2CmOE3C7Z
         sRBDr4o2GSUg0SJjF9bl2KHCCAeboGx+K/1jDM0pxqr+Uwlqiyq+HlZ4pe4nnvBW7c
         +hv1/H4ECbW5w==
Received: by mail-oi1-f181.google.com with SMTP id s2so15841937oij.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 13:53:10 -0800 (PST)
X-Gm-Message-State: AOAM533uiB9cqfVLYuYkBua97apu3ieEvcpfORnPZeRm13lSluaBr18L
        snlAs4DHuDYA5eA5It0YXFIbiud+14AhDCLhbOQ=
X-Google-Smtp-Source: ABdhPJyDlCIzcbqftlg/c/ozGcKG+KcymIYX/peu6PftQah90HLPYzRDhGKsfnXdEX684bGJhZH+Ij59dnOsWsbgN+w=
X-Received: by 2002:aca:44d:: with SMTP id 74mr6300975oie.4.1610229190164;
 Sat, 09 Jan 2021 13:53:10 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu>
In-Reply-To: <20210109055645.GA2009@1wt.eu>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 9 Jan 2021 22:52:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
Message-ID: <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
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
        Yoshinori Sato <ysato@users.osdn.me>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 6:56 AM Willy Tarreau <w@1wt.eu> wrote:
>
> On Fri, Jan 08, 2021 at 11:55:06PM +0100, Arnd Bergmann wrote:
> > * 80486SX/DX: 80386 CPUs were dropped in 2012, and there are
> >   indications that 486 have no users either on recent kernels.
> >   There is still the Vortex86 family of SoCs, and the oldest of those were
> >   486SX-class, but all the modern ones are 586-class.
>
> These also are the last generation of fanless x86 boards with 100% compatible
> controllers, that some people have probably kept around because these don't
> age much and have plenty of connectivity. I've used an old one a few times
> to plug in an old floppy drive, ISA SCSI controllers to access an old tape
> drive and a few such things. That doesn't mean that it's a good justification
> not to remove them, what I rather mean is that *if* there is no benefit
> in dropping them maybe we can keep them. On the other hand, good luck for
> running a modern OS on these, when 16MB-32MB RAM was about the maximum that
> was commonly found by then (though if people kept them around that's probably
> because they were well equipped, like that 64MB 386DX I'm having :-)).

I think there were 486s with up to 256MB, which would still qualify as barely
usable for a minimal desktop, or as comfortable for a deeply embedded
system. The main limit was apparently the cacheable RAM, which is limited
by the amount of L2 cache -- you needed a rare 1MB of external L2-cache to
have 256MB of cached RAM, while more common 256KB of cache would
be good for 64MB. Vortex86SX has no FPU or L2 cache at all, but supports
256MB of DDR2.

I checked some distros and found that aside from Debian inadvertently
dropping i486 a long time ago, Slackware 14.2 (from 2016) also requires
an i586 or higher now. Slackware 14.1 (from 2013) is still supported
on i486 but ships with a Linux-3.10 kernel.  archlinux32 is the only
binary distro I could find that still officially supports i486, which in their
case means anything below an i686 (cmov+mmx+sse). If it gets
dropped, it might require some users to stay on LTS kernels
after the distro moves to i586-only kernel, but as there are no
long-term supported releases, there is also no need to coordinate
the timing.

As with the other older platforms, the main question to ask is:
Are there users that are better off running a future LTS kernel on this
hardware than the v5.10.y version or something older?

     Arnd
