Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067152F03F8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 23:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbhAIWAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 17:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbhAIWAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 17:00:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A60123AC6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 21:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610229580;
        bh=wpNwFNK3KqhpUUJvQnNMnQmGPxhcN8AV75yUk0Lw4cM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WTXvGEpoV6EXI0ILtnKc/+c3xkSiTmDZILMLUkrj/Ux5FHjzVA7zi6Y52oNfrgjav
         br2G/fa3Itm/3X2d7pxxrddna8273yLoeeRRi8TPyCbd1O5ZEPEla3gQqvddvAnUMR
         qq5Ct8iwOw6lc8skXggNVFQW7ETvvcjmc8N9FiHdAvcuYSQpcr9N04vG32lNQpzHn1
         94TZIp6sq7fb7QnOsVQ/OXEmVk8oUqrmjhmuTFWaCeoH+4CgkHMX4s0j3nOX3sB+R0
         sD3p/6gkktPcwHU0YoBMAaPp1nrz82oRpD5CxPBsU473c1oFtRwxUjT7nKOv0PTpv5
         OJc9QkyeCe2WQ==
Received: by mail-oo1-f44.google.com with SMTP id j21so3248641oou.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 13:59:40 -0800 (PST)
X-Gm-Message-State: AOAM5335JXj35S2rrse5uSFEFx90lYZeCdXCjqfF/u2xVuW9UqMnGctM
        7ng5W6+etSGNXcfbD4ALPyUgv0q4GPbLoQwzJgY=
X-Google-Smtp-Source: ABdhPJwi/IN+9Mt5wBDOhPW01gO2pSKAS7ppMgu8edujZ1ojGRqR+cTESE8LBq4K1alAaq8JthWG4qcCTci/2rHD1H8=
X-Received: by 2002:a4a:4592:: with SMTP id y140mr8344745ooa.26.1610229579930;
 Sat, 09 Jan 2021 13:59:39 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <CACRpkdbJkiHR9FSfJTH_5d_qRU1__dRXHM1TL40iqNRKbGQfrQ@mail.gmail.com>
In-Reply-To: <CACRpkdbJkiHR9FSfJTH_5d_qRU1__dRXHM1TL40iqNRKbGQfrQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 9 Jan 2021 22:59:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3te9sYaWGCBMsG+rGQ26-55SV=T2jNLxi5mSZM=UfnEw@mail.gmail.com>
Message-ID: <CAK8P3a3te9sYaWGCBMsG+rGQ26-55SV=T2jNLxi5mSZM=UfnEw@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrea Adami <andrea.adami@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 1:18 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> > * u300 -- added in 2009, no notable changes since 2013
>
> We can delete this, I don't see any use for it moving forward.
> I'll send patches to drop it.

Ok, thanks for confirming.

> > * ep93xx -- added in 2006, LinusW still working on it, any users left?
>
> I was contacted by a user of this platform, using it with mainline and
> fixing bugs in the GPIO driver for this kernel cycle. So it has users.
>
> > * gemini -- added in 2009, LinusW still working on it
>
> This has active support and users through OpenWrt on the
> D-Link DNS-313 and DIR-685.
>
> > * ixp4xx -- prehistoric, but LinusW and I are still working on it
>
> One more developer has contacted me showing strong interest
> in the platform.
>
> > * nomadik -- added in 2009, LinusW keeps fixing it, probably no other users
>
> I use this for various subsystem testing actually (for the hardware that
> is on the board, not necessarily Nomadik per se). So it is in pretty
> active use.
>
> > * sa1100 -- prehistoric, but rmk and LinusW sporadically working in it
>
> There were some users from OpenEmbedded some years back
> and active patches from Andrea Adami beside RMK and me. Paging
> Andrea to see if he still has interest in the platform. (I don't.)

And thanks for confirming that we still want to keep all of these.

One thing I'd really like to see for the ep93xx is to have it
use the COMMON_CLK interfaces. I have patches for OMAP1
that I need to finalize, and then this one will be the last ARM
platform without it. I also still hope we can eventually get ep93xx
into multiplatform build.

      Arnd
