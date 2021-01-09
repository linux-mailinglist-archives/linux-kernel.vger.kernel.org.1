Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE92C2EFC0B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbhAIARa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbhAIAR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:17:29 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D84C061573
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 16:16:49 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x20so26977751lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 16:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9KyxT3qE7M6Jv73UCC5B3og/bJPG8bzWpnw5q1nVw4=;
        b=OCQaLhPpFcRQIPK4vdLdRMgS1n6C9sq5sozG7zQCnYgkEJKiXRlA5wqWIJOw6uRZN0
         bTEcKyKZng8vdRDG3d/k38Fo99xH1+3Tu0dObsmEi5sYuZJ9N+HrStiA7qw9jVSpmkVZ
         cAuRhZ9NOyAM6oOaMh9mZqYLSd5achlE4+aGTjPq36YD9tG7jm46wPE0a//Vam809csb
         laept4VBv7cBLmgjdabw312P13yY3Su6sKtx9c8Zazfw3EC74bORbh0oCookhVtCGoIc
         LcQXA/6ZMK6IQW/R20VZoZPTee5tIUXBeo4DodilU5HuBLyka53y6k6Ip2SGLyF0NDRP
         xxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9KyxT3qE7M6Jv73UCC5B3og/bJPG8bzWpnw5q1nVw4=;
        b=GptVvBYR5EZitC6N89fvKJo7lkDZ9MXApcMizsWpLqmGPQuH36N3AGBfhR/rbgHmBb
         Ic0P9/dClKUO1pet7CXu05mez9QFXypUHewoi10rpekeiNoMV3BZfXZEW14WbCoDn14h
         caCP7dnjtVfhBWuODn3JoPpK3sYrOk9MnUjSjD4D0lnAK4uG5uuKrKZ71yaFLiqLLdiI
         yhO5EzjwvGLwoUuXJwtp4h+baEGoZZRnP3qcJsi3O3SSWfadkfgQDePRW9da5OVFhp5C
         EA1xr6wqwcZ5ZEdOJpCkK7w1IZCinx9K+eU+0M4DkrbkEL8jEj9Im1tW29WI1egjgIdy
         8UKg==
X-Gm-Message-State: AOAM5333OfqUMd0CoExIUBXP87Ay4YBy+ayKX+q/WjlEJy2GOIueQ/DN
        0r3Hlh3bAsGGOg5RjQatB4BMA+6r1tCNnFPxuVJdHA==
X-Google-Smtp-Source: ABdhPJxyjteAOb5WFikJC8LkqJn6zs3wVF8qBSucYttlVOsX99+9t+sYmighgxvF6l9uYluW3iX6OGDtDHkYjnvIZNk=
X-Received: by 2002:a19:495d:: with SMTP id l29mr2444219lfj.465.1610151407630;
 Fri, 08 Jan 2021 16:16:47 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 9 Jan 2021 01:16:36 +0100
Message-ID: <CACRpkdbJkiHR9FSfJTH_5d_qRU1__dRXHM1TL40iqNRKbGQfrQ@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrea Adami <andrea.adami@gmail.com>
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

On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:

> * u300 -- added in 2009, no notable changes since 2013

We can delete this, I don't see any use for it moving forward.
I'll send patches to drop it.

> * ep93xx -- added in 2006, LinusW still working on it, any users left?

I was contacted by a user of this platform, using it with mainline and
fixing bugs in the GPIO driver for this kernel cycle. So it has users.

> * gemini -- added in 2009, LinusW still working on it

This has active support and users through OpenWrt on the
D-Link DNS-313 and DIR-685.

> * ixp4xx -- prehistoric, but LinusW and I are still working on it

One more developer has contacted me showing strong interest
in the platform.

> * nomadik -- added in 2009, LinusW keeps fixing it, probably no other users

I use this for various subsystem testing actually (for the hardware that
is on the board, not necessarily Nomadik per se). So it is in pretty
active use.

> * sa1100 -- prehistoric, but rmk and LinusW sporadically working in it

There were some users from OpenEmbedded some years back
and active patches from Andrea Adami beside RMK and me. Paging
Andrea to see if he still has interest in the platform. (I don't.)

Yours,
Linus Walleij
