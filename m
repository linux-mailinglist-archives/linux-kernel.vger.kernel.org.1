Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C202F4987
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbhAMLDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:03:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbhAMLD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:03:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C91A233A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535768;
        bh=XWUiSn4NUR3he8EUTvIP/v7uvWBzmVhRoEdWjHB6zhc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MGatXpaQfo/Y8zXaxcR27lvn62WSWF9ORnHYTo7TD2o809O+6QI2E8+ejU2iKrBFT
         /meeLz0+B5wtgkSEh1M/AGIos+BlwMO/6po3LKOw28ev5LqdX/u94xIto96qCM5BtH
         49gz5L0nni3/+LForSxuH3NnpKVmLoT2Lo8n8eBkfkf+LDfblr/l2jfoh61Yp994qC
         zlLU7LbRrjbtTxjNORU6jVwawXgsr/AJ4RG5C46CxwDCy+7A2gc2cdIr1Um5i3F7ia
         03WckDbNmREUoDzfLNuEtUsOavFTnGBBkIjWROORKmiZ+uRA/4bXCqmNVDgNL6E5t0
         zSxX550bBEgiQ==
Received: by mail-oi1-f179.google.com with SMTP id q205so1600644oig.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:02:48 -0800 (PST)
X-Gm-Message-State: AOAM533SflTUN1Bg4b1+768oDWFLv2E0FD9KVkV1UZMO/Y7vgROwG6pO
        aYVAKsXBfk6J7N+VbIKtKFBB+8ucby2IpuAwtS0=
X-Google-Smtp-Source: ABdhPJxw4S7HJq3mnBPCwf2+3LbnfN8YuFlvLRpS4q2XmGr7wCe5FtKI7ZJNHpPG1jMT7wyRz2WCpbzRy68uaaHSGQ0=
X-Received: by 2002:aca:44d:: with SMTP id 74mr823032oie.4.1610535767494; Wed,
 13 Jan 2021 03:02:47 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <CAHp75Vc8Hie93N++o1rTmJ_L=oM51XpHtqqKH+OByV8RtoRQ0g@mail.gmail.com>
In-Reply-To: <CAHp75Vc8Hie93N++o1rTmJ_L=oM51XpHtqqKH+OByV8RtoRQ0g@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 13 Jan 2021 12:02:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3gGKyTGPRh=VyJ8SZq-VXk-5ZFNu-WwssZmWVucy4bCQ@mail.gmail.com>
Message-ID: <CAK8P3a3gGKyTGPRh=VyJ8SZq-VXk-5ZFNu-WwssZmWVucy4bCQ@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Wed, Jan 13, 2021 at 11:31 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Jan 9, 2021 at 12:58 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > After v5.10 was officially declared an LTS kernel,
>
> I have a question here. Maybe I have missed something, but how LTS
> helps in this case? LTS AFAIR has a rule "upstream first". How can you
> provide a patch to be backported if there is no upstream for it
> anymore?

Platform specific bugs are usually not the problem here, and if something
does happen on deleted code, I would expect you can get an exception
to the "upstream first" rule.

What I was getting at here were the things in the second category, the
stuff that is is still maintained and working, but so old that it becomes a
burden for maintainers. If a maintainer knows who all the users are
and what they do with their machines, removing the platform from mainline
would be a chance to get everyone to use the same LTS version so they
can get bugfixes to common kernel code for a few more years and
benefit from everyone else testing the same codebase.

> > * 80486SX/DX: 80386 CPUs were dropped in 2012, and there are
> >   indications that 486 have no users either on recent kernels.
> >   There is still the Vortex86 family of SoCs, and the oldest of those were
> >   486SX-class, but all the modern ones are 586-class.
> > * Alpha 2106x: First generation that lacks some of the later features.
> >   Since all Alphas are ancient by now, it's hard to tell whether these have
> >   any fewer users.
>
> We still have Intel Quark available. I run vanilla from time to time
> on it due to the presence of peripherals I can't find elsewhere on x86
> boards.

While Quark is derived from a i486 pipeline, the kernel treats it as
CONFIG_M586TSC, as it contains fpu, rdtsc, cpuid and cmpxchg8b
instructions but no cmov or mmx. More importantly, you wouldn't find the
vintage i486 peripherals (drivers/ide, drivers/video/fbdev, VLB, ISA,
floppy) but instead have modern stuff like USB, PCIe, and eMMC.

     Arnd
