Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C5E2F1034
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbhAKKfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:35:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbhAKKfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:35:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FB97229C4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610361304;
        bh=1jvppqObcU17oix81bFxLol1bIiIGDiIxxYc0SeMzd0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XFwVHpq1zviVzktAOysLmRdCJoQ08eAqlJpjUZSh65lRn1FBlkgzBuLxRUMj7HE9V
         wOWOgbYxcExe64U+q9YZY4eXKt3n6tQSSP1GU12aIp2lMzZVtKmr4W360e64XSXg1Y
         a1eHNcQszfZSyLJKBqqlhg6NJ2XJozkIOxf7FmlI/aYn0xVKvAkJ6EpwurzuWO+U08
         1OxkwLbVTFbTcoX3T6S/t5b3DQDCAcrdlTrvfdafdujPS8qRsnZRxjsL6DQDehRnUu
         PLRr4+GdVCtwPDKRj7BYpYFbdnV/69H4128skR2C+rqZwAOATQCqD5mV2FwOKcJgX/
         6ezZq+92zYRkg==
Received: by mail-oi1-f176.google.com with SMTP id x13so19617903oic.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:35:04 -0800 (PST)
X-Gm-Message-State: AOAM533m1X6K9gnp0eTxGMeRyN7rsKHuFRzY92cKp6zxj050dJnsTlLx
        1YFgzfUlFTYxWCQGlwrTvw0HZXol032OARnXc5g=
X-Google-Smtp-Source: ABdhPJy2anaAv/SzvNP4vXQr2AWpGIAK1ktuNadzheO05rdvHbZiMYB82cZo3ghSdHWVQUulh3j6bViMqR9leEJJbqQ=
X-Received: by 2002:aca:44d:: with SMTP id 74mr9979507oie.4.1610361303387;
 Mon, 11 Jan 2021 02:35:03 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <CAMuHMdWiYkhN_S2t+hg0cDk84Qd950YE9-qGTgsdL_-2vPr1WQ@mail.gmail.com>
 <CAK8P3a3TNVj_Gw=GaEFELdF9Fo25XU_PFWS5N0+kb=R394KNVQ@mail.gmail.com> <20210111094022.GA5691@alpha.franken.de>
In-Reply-To: <20210111094022.GA5691@alpha.franken.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 11 Jan 2021 11:34:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1puMTgrP+VZEYLSsLTDn4J8hkEYab-UhbDotYjqDjNKg@mail.gmail.com>
Message-ID: <CAK8P3a1puMTgrP+VZEYLSsLTDn4J8hkEYab-UhbDotYjqDjNKg@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:40 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Mon, Jan 11, 2021 at 09:59:23AM +0100, Arnd Bergmann wrote:
> > On Mon, Jan 11, 2021 at 9:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > * MIPS R3000/TX39xx: 32-bit MIPS-II generation, mostly superseded by
> > > >   64-bit MIPS-III (R4000 and higher) starting in 1991. arch/mips still
> > > >   supports these in DECstation and Toshiba Txx9, but it appears that most
> > > >   of those machines are of the 64-bit kind. Later MIPS32 such as 4Kc and
> > > >   later are rather different and widely used.
> > >
> > > I have a (32-bit) RBTX4927 development board in my board farm, boot-test
> > > every bi-weekly renesas-drivers release on it, and fix kernel issues
> > > when they appear.
> >
> > Right, I was specifically thinking of the MIPS-II/R3000 ones here, I know
> > there are users on multiple actively maintained MIPS-III platforms.
>
> Maciej still runs R3k based machines.

Ok, got it.

       Arnd
