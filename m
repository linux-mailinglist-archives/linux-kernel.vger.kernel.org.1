Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7142F4C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbhAMNqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:46:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbhAMNp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:45:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18F84235F9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610545518;
        bh=RtlaE9J65v12+J/6lbmgii2+Y3BY+wZws9oPMNRLbyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bwt77kQzi3TUQ3xGOdoqZYt9J0R1/7yQGCsTaMsjG1QPB/92EMmML2cJWqV4aaSt9
         VMAGoQAI9Yel8nl0qw+QsfGHPyc0/HGPEzpWrqlZZ5jDB3q5Ot7nra8AGCNI7snRHm
         bWgHbs1Gg5jY5tFXkRkE+9pLjB70VIR8DDTcsPhcr03gFUTVSKMAzInXlJMajmwg1a
         X8gFWnCK3dJ4l0IU2/8wsqzOFUW+kjZsoJyRA24/1bkwejXH7vmS45kMgB3GjMrtZM
         LlWtOmk0m/TDxaGdZGxQLp0cZyxgCSn6gviV6rAXxCQxSHkfPBRb3kOXu8vdwBcxjV
         rRK5agVcZgbdA==
Received: by mail-ot1-f48.google.com with SMTP id w3so1869462otp.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:45:17 -0800 (PST)
X-Gm-Message-State: AOAM532iWxkOIiFVvKbSvzF5KzQmbH5HSJenblTK8/WWRNpnJ6W2f3jk
        Dsscxacr4Ns36vsaN4PnFvF9uFQYzLGNjiFGifg=
X-Google-Smtp-Source: ABdhPJx2v6CKPuAGtI2BQ/naF3Kn3i6GYnzkXFTxcVDUbUl5u9LFkg7OLK4TAHz1wQBhfS+590IiFSovP/PAJvXkK9w=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr1247229otm.305.1610545517013;
 Wed, 13 Jan 2021 05:45:17 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu> <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
 <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com> <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
 <CACRpkdaH-1s8DnRUPVRSQgqUE99MdWjKGLv_y6iYnXU6p4dwUg@mail.gmail.com>
In-Reply-To: <CACRpkdaH-1s8DnRUPVRSQgqUE99MdWjKGLv_y6iYnXU6p4dwUg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 13 Jan 2021 14:44:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1QLdPOcQoNWOYNGgN1vMNv2oOtittr1H1pVLrbbN4pPA@mail.gmail.com>
Message-ID: <CAK8P3a1QLdPOcQoNWOYNGgN1vMNv2oOtittr1H1pVLrbbN4pPA@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Willy Tarreau <w@1wt.eu>,
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
        Yoshinori Sato <ysato@users.osdn.me>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 1:02 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Jan 13, 2021 at 11:27 AM Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jan 11, 2021 at 11:55 AM David Laight <David.Laight@aculab.com> wrote:
> > > basically 486 but have a few extra instructions - probably just cpuid
> > > and (IIRC) rdtsc.
> > > Designed for low power embedded use they won't ever have been suitable
> > > for a desktop - but are probably fast enough for some uses.
> > > I'm not sure how much keeping 486 support actually costs, 386 was a
> > > PITA - but the 486 fixed most of those issues.
> >
> > Right, we have "last of mohicans" (to date) Intel Quark family of CPUs
> > (486 core + few i586 features).
> > This is for the embedded world and probably not for powerful use.
>
> What is the status of PC/104?
> https://en.wikipedia.org/wiki/PC/104
>
> I have three GPIO drivers for PC/104 machines and these are for
> embedded industrial usecases. I am curious about what CPUs these
> beasts run on in practice? Are they getting upgraded?

I had a look at those earlier when trying to find out what the remaining
users of CONFIG_ISA are. It turns out that you can still easily get new
x86 hardware with PC/104+ (combined ISA and PCI, not PCIe)
connectors, see e.g. https://www.versalogic.com/product/SandCat/.

Like the older VMEbus based systems, these would have at least 10
years of hardware availability (sometimes much more) and are indeed
designed for use over decades after that.

On the other hand, the set of ISA-style peripherals that you would
connect here has little overlap with the those you'd find on a 1990's
PC or Unix workstation, and I would expect that a lot of device
drivers for them were never submitted for mainline because they are
application specific.

We have a couple of ARMv5-generation systems with PC/104
support,  added before the start of the git history:

* s3c2410/bast
* s3c2410/vr1000
* pxa25x/viper
* pxa27x/zeus

I would assume that some of those are still operational somewhere
in the world (along with similar machines without mainline support),
but none have seen in field kernel updates for years.

There is also ep93xx/ts72xx, which has a  PC/104 connector
but no Linux support for it. A new version of the board was
added in 2017, so there are clearly still users, but they would
need add-on patches to use PC/104.

      Arnd
