Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1C32F0EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbhAKJVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:21:05 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37943 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbhAKJVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:21:05 -0500
Received: by mail-ot1-f50.google.com with SMTP id j20so16268754otq.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:20:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rmwhyNXbq4MY6/VpR00SmcZIknXd36E9FyB45m10Ro=;
        b=uWuLlfx4b80mCxUuaagpUP/yYopwe7/mYaAZYet/3J3UgqX0sgyYHLTfOPP7BcHNVs
         xoxgn5b+n0MuozvHKzm803G5YAAozaZxJzj6XErqbRf8ufRYBLSnIIO6Lb6gpypkvmoi
         Q/ZKyAuQlpgPIcNKAgYep09bVSPCAUgJKJMpoLSfH95BNzmaepJJdI1mS6nDQ/46VYRK
         WnkSOAQBHRQq9gRE98YyYYKoNGLRo8BvDQrq0VWheTXNSp07NBZG/XD3/hPT/mx1btOl
         haEXdjm+eMuDPVusHd57L9XxOSgTh130eucicS5GvyTql/ymDEn2kAhPNLB61+VgXDIT
         qU4A==
X-Gm-Message-State: AOAM531tLxGChQpS9zn+iHbXpQTaNVYGDnIK7JX8LKM/GP8DA8GCC1Ml
        ys4sqgIQ+/p9LhPa2JBz2ux2xr9yd5FlD5Awo2Q=
X-Google-Smtp-Source: ABdhPJxP9tFz13HF1n/nmY4rlevANwUy9sFxQjf373+EHUKoHtEAWtnAs0LzqWROKfYvGlGG5l6kpBxsf9VQIx/KOz4=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr10435943otc.145.1610356823993;
 Mon, 11 Jan 2021 01:20:23 -0800 (PST)
MIME-Version: 1.0
References: <CAFr9PX=BV1YFcO_GQWsW3XEo8nndjUwArzW5Fg1fnWzt8fiwGw@mail.gmail.com>
 <e1b2de15-b4ad-68bb-4fae-cf0f3ecd4b79@physik.fu-berlin.de>
In-Reply-To: <e1b2de15-b4ad-68bb-4fae-cf0f3ecd4b79@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jan 2021 10:20:12 +0100
Message-ID: <CAMuHMdUia3-DroA3VOA5jkYYWP+Rip5yse-nd00JuV8uFnVp1Q@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Daniel Palmer <daniel@0x0f.com>,
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
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, Jan 11, 2021 at 10:16 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> > On Sat, 9 Jan 2021 at 07:56, Arnd Bergmann <arnd@kernel.org> wrote:
> >> * 68000/68328 (Dragonball): these are less capable than the
> >>   68020+ or the Coldfire MCF5xxx line and similar to the 68360
> >>   that was removed in 2016.
> >
> > I have some patches for the DragonBall series to enable SPI etc there,
> > some patches to support the SuperVZ variant, some tools to upload
> > Linux via the integrated serial bootloader.
> > The DragonBall is probably what anyone that wants to build a 68K retro
> > computer should use as the DRAM controller is integrated and it can
> > access 32MB of SDRAM.
>
> Sounds interesting. Do these SoCs come with an MMU? And do they use the
> ColdFire instruction set or do they run plain 68k code?

No MMU, plain m68k code.

68328 Soc = 68000 core + some peripherals,
68360 SoC = CPU32 core (based on 68020 + some peripherals.

Anyone working on integrating m68k (and SPARC and MIPS?) softcores in
LiteX? ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
