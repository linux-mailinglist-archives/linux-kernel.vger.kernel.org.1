Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5D12F48AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbhAMK17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbhAMK17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:27:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D848AC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:27:18 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b5so904564pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bb7P/RgeCN4wHZ9ctamzI3f0LI9M5JaYaDEfMiG22CU=;
        b=a9aOhXhNvEVqKkI++xVcy32Wdczi0r0NkfcwCwBlN4Waaa7VpcswSseXSITCmAs+ed
         IivTC6Bw71oV0zQmaYjdfcf86C1XSWKxIqKrcnIrDNPO6eqJSiviXfI2N87pIWsaQY9e
         GrVAhnVAcAb07Axkdkp5f4QoCwrpIa3q+E/JpsPrDH3qerjlupCoVtNg8SLT1C+u+5Xq
         M1de+cYbne6Ii0rYMNfTedTSfCr3Q1osR53/6w7EuI8QCr63i9cw6+mKl83HFNTuzCIo
         MtAmnxnW4io3pVGR7Z5HTG81H4n6r/qp5A14tUfoO50rslDfK+kBUdGE8oE5JR/jGxWW
         6ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bb7P/RgeCN4wHZ9ctamzI3f0LI9M5JaYaDEfMiG22CU=;
        b=P0NQ8JyJX3D46L3QgE5l+xb6Pr5BAxw8tMH4/AF4UKxRyBP2TR7QB2Xn7IwIlTc/bI
         KVlYuOgXpa3jx39ivjdSRIhQeDgStwxsbEXiCsAwg14VRgvVPPmpkioOvNOHHgpGH/Hy
         XLNjyPDesmqYkreIR4KIqF/O+QasAO5M0c05pAjpXMepbPt62vFEryqLHGXUe1EOkk63
         stQ3Xx48vMzomiVBAsg+vYd9cdhhhzgrPSOY5T1eIQsMWPAyD3khYoxYjWHqtRfWcwYs
         vjfaWwxixMONNyjd7rjAraXuJqWzm9st6KnfVVNELCiFEf1E7+TStcbMzszs82CFqr+D
         Dk6w==
X-Gm-Message-State: AOAM531mx/TOKnKKm5yZ2zlhBAfvJc4w5Qw7K1jifvFk5ez5Zedvcdgd
        Z/nkoTr/aRd/Ca+9xsV5Dax7T7pJs74zTPu45u0=
X-Google-Smtp-Source: ABdhPJyvKQfadxeq0CM+vz0GStXqGNp7tzAY6AggqbXs47YeqApZfTRgFt85Fm0hz5k0uAMqdIuCHNnaJ0lRDHObyCY=
X-Received: by 2002:a17:90a:1050:: with SMTP id y16mr1633937pjd.181.1610533638357;
 Wed, 13 Jan 2021 02:27:18 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu> <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
 <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com>
In-Reply-To: <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jan 2021 12:27:01 +0200
Message-ID: <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     David Laight <David.Laight@aculab.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Willy Tarreau <w@1wt.eu>,
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
        Yoshinori Sato <ysato@users.osdn.me>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:55 AM David Laight <David.Laight@aculab.com> wrote:
> From: Arnd Bergmann
> > Sent: 09 January 2021 21:53
> >
> > On Sat, Jan 9, 2021 at 6:56 AM Willy Tarreau <w@1wt.eu> wrote:
> > >
> > > On Fri, Jan 08, 2021 at 11:55:06PM +0100, Arnd Bergmann wrote:
> > > > * 80486SX/DX: 80386 CPUs were dropped in 2012, and there are
> > > >   indications that 486 have no users either on recent kernels.
> > > >   There is still the Vortex86 family of SoCs, and the oldest of those were
> > > >   486SX-class, but all the modern ones are 586-class.
> > >
> > > These also are the last generation of fanless x86 boards with 100% compatible
> > > controllers, that some people have probably kept around because these don't
> > > age much and have plenty of connectivity. I've used an old one a few times
> > > to plug in an old floppy drive, ISA SCSI controllers to access an old tape
> > > drive and a few such things. That doesn't mean that it's a good justification
> > > not to remove them, what I rather mean is that *if* there is no benefit
> > > in dropping them maybe we can keep them. On the other hand, good luck for
> > > running a modern OS on these, when 16MB-32MB RAM was about the maximum that
> > > was commonly found by then (though if people kept them around that's probably
> > > because they were well equipped, like that 64MB 386DX I'm having :-)).
> >
> > I think there were 486s with up to 256MB, which would still qualify as barely
> > usable for a minimal desktop, or as comfortable for a deeply embedded
> > system. The main limit was apparently the cacheable RAM, which is limited
> > by the amount of L2 cache -- you needed a rare 1MB of external L2-cache to
> > have 256MB of cached RAM, while more common 256KB of cache would
> > be good for 64MB. Vortex86SX has no FPU or L2 cache at all, but supports
> > 256MB of DDR2.
>
> There are also some newer (well less than 30 year old) cpus that are

(less than 10 years actually)

> basically 486 but have a few extra instructions - probably just cpuid
> and (IIRC) rdtsc.
> Designed for low power embedded use they won't ever have been suitable
> for a desktop - but are probably fast enough for some uses.
> I'm not sure how much keeping 486 support actually costs, 386 was a
> PITA - but the 486 fixed most of those issues.

Right, we have "last of mohicans" (to date) Intel Quark family of CPUs
(486 core + few i586 features).
This is for the embedded world and probably not for powerful use.

-- 
With Best Regards,
Andy Shevchenko
