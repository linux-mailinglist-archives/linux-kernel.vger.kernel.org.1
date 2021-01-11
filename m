Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F0B2F103A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbhAKKiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:38:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbhAKKiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:38:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08F0F227C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610361440;
        bh=6G1vQMI+RmWGO2MiYs0O6CIsNyH049vZiLMXcbGgM0k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hIlWQ/FbzusvJSGGnVwi5q0D2RlFhd3JCMABDXSraP4Js0gXjyYc/4PUWsxNIi5q5
         WXJ7KrlgUFl6ikHNjXu9nfK7jgpmePhgzJGUkGFOchuobBUJCydyoe+j1rvBluRrE9
         D9I5zncDeIZJ9OwfYejpLKwxeiTs+s9f8Ar0cX3R6NbefeinG1CgLOQYmAKw0n+Z38
         1Ru3c+8v9v+ja5aF6Vz43AI8i4UlRhYIgO6MsSp59p2lrudEz6JQTub+BpLO4k96Eo
         O7F9mjGXXmWxvTP3fchqdByyd8kfBUbpvR6Jk5XbLaYRae8aZGlCVEgogquDjl4Na4
         syVezvqqKhPng==
Received: by mail-ot1-f42.google.com with SMTP id a109so16463199otc.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:37:19 -0800 (PST)
X-Gm-Message-State: AOAM531jFQuTSOk0Jx7FLLwpDJqoN7Tw5ZnnuD8ircy8i+pMk7NT3oqQ
        dYku6E7AmYHSF1SPQPgHhDmRmcZcGH4CL0dJRTc=
X-Google-Smtp-Source: ABdhPJzGHzTR0OnFdne+o46XOLbCPwtNJ3cY1fffePw33Cn3MIFminQKAXPx0wxtxd5CMEPTB/TujMA2BwR+xucqSOQ=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr10526720otm.305.1610361439166;
 Mon, 11 Jan 2021 02:37:19 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <CAMuHMdWiYkhN_S2t+hg0cDk84Qd950YE9-qGTgsdL_-2vPr1WQ@mail.gmail.com>
 <CAK8P3a3TNVj_Gw=GaEFELdF9Fo25XU_PFWS5N0+kb=R394KNVQ@mail.gmail.com>
 <CAMuHMdUod26OPXyYG_xmkYgeKELdBJtmojYxDQoz53Dxip77Nw@mail.gmail.com> <CAMuHMdWEwm76v9op9QKWefFc0XqGsqBQshPxR768cFcv9r8H4Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWEwm76v9op9QKWefFc0XqGsqBQshPxR768cFcv9r8H4Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 11 Jan 2021 11:37:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2sFKpsVJMC=1hgaSMVihDWW1kVXN=r+QeN9tCwGmkt9A@mail.gmail.com>
Message-ID: <CAK8P3a2sFKpsVJMC=1hgaSMVihDWW1kVXN=r+QeN9tCwGmkt9A@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:28 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> > > Regarding 32-bit vs 64-bit kernels, can you clarify what makes this one
> > > a 32-bit board? Is this just your preference for which kernel you install,
> > > or are there dependencies on firmware or hardware that require running
> > > this machine in 32-bit mode?
> >
> > TX492x is 32-bit (/proc/cpuinfo says mips1/mips2/mips3), TX493x is 64-bit.
> > As Debian dropped support for mips3 and older, I'm stuck at a Jessie nfsroot.
>
> Upon closer look, all TX49xx are 64-bit, but the VxWorks boot loader
> refuses to boot 64-bit kernels ("Size is incorrect"), hence I settled
> for a 32-bit kernel config a long time ago.

Ah, that makes sense.

> Probably I need to write a 32-bit bootwrapper first. which would allow
> me to upgrade the Debian userland beyond jessie using mips64el?

No, I don't think it would help you here, as Debian Stretch requires
either MIPS32r2 or MIPS64r2 processors, so neither MIPS-II nor
MIPS-III work any more.

Not sure what others are running on their pre-r2 hardware these days.

       Arnd
