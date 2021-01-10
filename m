Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C26D2F0953
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 20:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbhAJTVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 14:21:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbhAJTVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 14:21:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1AEA22BEF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610306453;
        bh=SOcdvz0F2frLusDQda6GECMU6+0uWIDBtKiC2MOCWnE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q4RbjVReskhFOf1XNsAe6x4I/HDd6I9zkQm0Tk4YBN6Xhdj8TStGDMVSgNWbLFRuV
         5DtMNbFMC6rbV5lobOgovNZ1LTU6XXV2/UF/2SEhzpsTjfYeiS3pPbmdmw9QkVguS3
         XY6tVWBePAk6Xdh0k/JqmYmKZbgeCxF0RVPOA/3dCkeVAQqhPkEqIO+SuJCXvZcmUl
         wP5XLVvtCGvBF4rgcfNnH++3iZ2i/ezaPCANPpnCTS5Mg/C9mMFSWkhcIG4xmAG2f6
         ERgptWkjQlu3qUYek+X+nFydGj8ZPdpKZRPUXDTx3N1QS0GuYkvXbD6Xt+N8NbWT5Y
         AcCuim+9SjlRQ==
Received: by mail-ot1-f43.google.com with SMTP id a109so14959155otc.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 11:20:53 -0800 (PST)
X-Gm-Message-State: AOAM5330LwZcXmnKmtOfY2Gr8Xr5JASTk/lHyziaaP0XTT2knZId6omo
        OcMeRXl9zHpipX4ZXs3tHJwpXjpvlk1hDbHjAGA=
X-Google-Smtp-Source: ABdhPJzq7HIg2qyGfOUSpYP1xdvOZl4qHXisv1Kuu0aqWD3y22P7JQIazJUkWPszGdgSL4izGI/FZyf2mdUrTcQNrHU=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr10020096ooj.15.1610306452255;
 Sun, 10 Jan 2021 11:20:52 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <67171E13-6786-4B44-A8C2-3302963B055F@gmail.com> <CAK8P3a0o=1KjPtp0Ah8Afe5vvG1b72+77HRFh4Z06HUGwN6+Ew@mail.gmail.com>
 <1702853.1557dWfJA4@linux-e202.suse.de>
In-Reply-To: <1702853.1557dWfJA4@linux-e202.suse.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 10 Jan 2021 20:20:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ggCWBEVP6qYS_p1bHdG1cbHvrN7iR8SfkhWrZ=jDzeQ@mail.gmail.com>
Message-ID: <CAK8P3a1ggCWBEVP6qYS_p1bHdG1cbHvrN7iR8SfkhWrZ=jDzeQ@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Fabian Vogt <fabian@ritter-vogt.de>
Cc:     Daniel Tang <dt.tangr@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jamie Iles <jamie@jamieiles.com>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Alex Elder <elder@linaro.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Mark Salter <msalter@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 7:12 PM Fabian Vogt <fabian@ritter-vogt.de> wrote:
> Am Samstag, 9. Januar 2021, 23:20:48 CET schrieb Arnd Bergmann:
> > On Sat, Jan 9, 2021 at 1:06 AM Daniel Tang <dt.tangr@gmail.com> wrote:
> > >
> > > Hi Arnd,
> > >
> > > On 9 Jan 2021, at 9:55 am, Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > * nspire -- added in 2013, no notable changes after 2015
>
> Most of the platform is just the DT sources and some small drivers around it,
> so it's actually fairly low maintenance. So far the migration away from
> panel-simple in 2019
> (https://lore.kernel.org/linux-arm-kernel/20190805085847.25554-1-linus.walleij@linaro.org)
> was the biggest required change so far.

Sure, there is no problem in keeping it around as long as it is used.
There were a couple of platforms that had not seen a lot of changes
in the past five years but that are still in active use, I just used it as
an indication that I should ask about the status. A lot of the other
platforms that list only ever had an incomplete port and were
abandoned before they were fully supported in upstream kernels.

> > Would either of you already have a guess for how long it makes
> > sense to update kernels on it?
> >
> > I see that this is one of the more limited platforms with just 32MB
> > of RAM (64MB in case of CX), and kernels only get more bloated over
> > time, so I expect at some point you will be stuck with running old
> > software.
>
> The kernel overhead isn't actually that bad. I just built today's 2ff90100ace8
> and booted it with a busybox-based initrd. free -m reports:
> total used free shared buffers
>    58   12   46      0       0
>
> Relatively speaking, still mostly unused ;-) The stock OS actually uses more!
> With 32MiB, the situation is definitely worse, but still manageable. Should
> that change in the future, dropping just the Classic/CM variants would be a
> possible option, but that still seems far enough away.

Ok, makes sense.

> > Wikipedia tells me that new models came out recently. Are you
> > planning to add support for those as well?
>
> Yes, someone from the community actually managed to boot Linux on a CX II-T,
> and I'm hoping to get that upstreamed soon. Most of the hardware changes are
> supported by drivers already and so this is mainly just another device tree.

Nice!

       Arnd
