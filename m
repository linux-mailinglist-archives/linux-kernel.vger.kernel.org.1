Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3512F0FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbhAKKOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:14:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbhAKKOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:14:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1E73224F9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610360050;
        bh=JrKJaqgqnQU7RWPTWBaqBZW/vzVgVouxEBnHFo5k73A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GvW8SK1ktsVNmYFUi+MJ/KbIhO4NJzxKfHXRdKH8zaXn1qAD57JkM9NTA03Idl3zo
         2YUgIw/iGYCV6btKM39kf9bxeMefsbhN5jVK0kV6E0ntp/A+01jfxWm6d2idd7mx2X
         8lx/Bp3moRH3rwXA/W8nkgAgXi0/vC5ofhcNYt5NTOQSlFcIUqjDqS9MkLPkhFBgLa
         d5x/uzVH16BfJWRXXLQx3x+DCxbnosx46/fe/Jcpx8KIdARwBUUc6NmIFMwI5NQlOf
         o8y2GWPy0TZrhcnUKHvy/xlN7I0Y3jDl0+v9y0IGkz0JRK2pQ6tafDUzNxDOHncw8a
         LjFy3soPPXMsA==
Received: by mail-ot1-f44.google.com with SMTP id o11so16410429ote.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:14:10 -0800 (PST)
X-Gm-Message-State: AOAM531FdA61Cntj1H8/IKFyE1iBYOStJ6sqqjJEyO0hwsHEGIv7mUQA
        h5XKV3S3AkKH51QYTjVpoJq7e7mjXv9LWx+VoWA=
X-Google-Smtp-Source: ABdhPJzvCH74K6Nwmm84zj3r3DfnTOuqM8k068SVW2QyemhLsUMCHWkcaq63gMTrjwl2kNF2V1nfkdkODjGM8qhjo1k=
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr10397588otr.210.1610360049949;
 Mon, 11 Jan 2021 02:14:09 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <CAFr9PX=BV1YFcO_GQWsW3XEo8nndjUwArzW5Fg1fnWzt8fiwGw@mail.gmail.com>
In-Reply-To: <CAFr9PX=BV1YFcO_GQWsW3XEo8nndjUwArzW5Fg1fnWzt8fiwGw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 11 Jan 2021 11:13:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1N5dEWQfH+bKKPPag0Buyj2FUN4oGd_u=iQAGWg-6XxA@mail.gmail.com>
Message-ID: <CAK8P3a1N5dEWQfH+bKKPPag0Buyj2FUN4oGd_u=iQAGWg-6XxA@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Daniel Palmer <daniel@0x0f.com>
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

On Mon, Jan 11, 2021 at 2:40 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Hi Arnd,
>
> On Sat, 9 Jan 2021 at 07:56, Arnd Bergmann <arnd@kernel.org> wrote:
> > * 68000/68328 (Dragonball): these are less capable than the
> >   68020+ or the Coldfire MCF5xxx line and similar to the 68360
> >   that was removed in 2016.
>
> I have some patches for the DragonBall series to enable SPI etc there,
> some patches to support the SuperVZ variant, some tools to upload
> Linux via the integrated serial bootloader.

Ah, good to know. Note that I recently did some cleanups for dragonball,
which were Greg merged into 5.10, but I don't think that he or anyone
else tested them on real hardware.

> The DragonBall is probably what anyone that wants to build a 68K retro
> computer should use as the DRAM controller is integrated and it can
> access 32MB of SDRAM.

I generally wouldn't recommend MMU-less hardware for new projects
any more, when your primary goal is to run the latest Linux kernel.

As recently as 2017, there was a lot of work going into a bunch of
platforms (J2, STM32, SAMV7, pre-v4e Coldfire, ...) in both user space
and kernel, but that seems have significantly slowed down in the
past years (K210 being the notable exception). The fewer users there
are on other NOMMU targets, the harder I expect it to get for the
remaining ones to keep it from breaking.

Of course, for a retro computer, that may not be relevant. If you
just want to run Vintage operating systems (including older
Linux kernels) and you just do it for fun, then this sounds like a
good choice.

> I haven't tested it recently but it should still work and I have
> hardware and I'm willing to look after it if no one else wants to.

For the purpose of documenting the current state, it would be
great if you could just do a minimal test on linux-5.10 to see if
anything broke since you last ran it.

       Arnd
