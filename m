Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4788B2F0EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbhAKJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:17:10 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:42495 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbhAKJRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:17:09 -0500
Received: by mail-ot1-f54.google.com with SMTP id 11so16237434oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:16:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbLH4yGYqbtLKF6oBWytPMqudqDk3RPsz1g1dGPkH40=;
        b=FBTSO5D4B0wmpksbvRx5eZaRYY3eqZrvW5VvvfUes4isgjNqbw9Q5ohwRfLqyUag59
         kptNXCjG1F1+rGO4tV+KTGgeuYkIte7X2G4tyZ+U9HVgdsh7paDChvu0sl6jKCXN4vuk
         udAuSGA6VdYvvWJcd3tzf2+jK3M2dh/mRwgh1nDgvJI2wHI7RL5Koo/axy0ncO7Nur6G
         xa7gZpxXgp0ZQx1D3YWSmcEQk3DGq+pU+uLCCJgNvCTXhwATLO5WKB3A135BGgVj5aM2
         tQ1bHUMcYNxAK00o/YlQ0uGjgd6WYdMXpHSBtlOFjLpmXcPVlMwjIVd40A/nVdaoTLeD
         5Rgg==
X-Gm-Message-State: AOAM531dHWFcLItHhWrqT2MF52dpcgOP04lJGo1t2llX4m4+EV70R2io
        7W2fE/BeXtPzVhiNwinsN+D56jIglQYLaXIcmM8=
X-Google-Smtp-Source: ABdhPJzJsjUbVcVpKewqdTIkdfgOGgN0UhmT48yM4kHOx2SafgEcdazp3jzXue/PMKiIAM40oihXbdDthTVlgdbZORk=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr10429218otc.145.1610356588773;
 Mon, 11 Jan 2021 01:16:28 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <CAMuHMdWiYkhN_S2t+hg0cDk84Qd950YE9-qGTgsdL_-2vPr1WQ@mail.gmail.com> <CAK8P3a3TNVj_Gw=GaEFELdF9Fo25XU_PFWS5N0+kb=R394KNVQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3TNVj_Gw=GaEFELdF9Fo25XU_PFWS5N0+kb=R394KNVQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jan 2021 10:16:17 +0100
Message-ID: <CAMuHMdUod26OPXyYG_xmkYgeKELdBJtmojYxDQoz53Dxip77Nw@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Arnd Bergmann <arnd@kernel.org>
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

Hi Arnd,

On Mon, Jan 11, 2021 at 9:59 AM Arnd Bergmann <arnd@kernel.org> wrote:
> On Mon, Jan 11, 2021 at 9:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > * MIPS R3000/TX39xx: 32-bit MIPS-II generation, mostly superseded by
> > >   64-bit MIPS-III (R4000 and higher) starting in 1991. arch/mips still
> > >   supports these in DECstation and Toshiba Txx9, but it appears that most
> > >   of those machines are of the 64-bit kind. Later MIPS32 such as 4Kc and
> > >   later are rather different and widely used.
> >
> > I have a (32-bit) RBTX4927 development board in my board farm, boot-test
> > every bi-weekly renesas-drivers release on it, and fix kernel issues
> > when they appear.
>
> Right, I was specifically thinking of the MIPS-II/R3000 ones here, I know
> there are users on multiple actively maintained MIPS-III platforms.
>
> Regarding 32-bit vs 64-bit kernels, can you clarify what makes this one
> a 32-bit board? Is this just your preference for which kernel you install,
> or are there dependencies on firmware or hardware that require running
> this machine in 32-bit mode?

TX492x is 32-bit (/proc/cpuinfo says mips1/mips2/mips3), TX493x is 64-bit.
As Debian dropped support for mips3 and older, I'm stuck at a Jessie nfsroot.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
