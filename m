Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D752F4B35
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAMMWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbhAMMWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:22:47 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3997C061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:22:06 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y8so973383plp.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rI8P5PWESGlQoMNfKJlDMDZN77XRS6tO+BP9N8huPI=;
        b=rKvjxRe6+WSKz55pz6aeTlxXPdpcm0IWEr9PoRSlnPmvyU4g/yrluQuIKL53L0ouEC
         NH4OobnrCR9DcKC5LVmsJY70XgLJpmGMu1zlJVGggnRbRagRWNRY+OUps1sQK/AZuay3
         kMiTtO7/2s6ucY1zfSBRx9R7JQm7E+CiGSwM0CBAueM8HExk5C3YmBTOB6BQdMfJ5N8o
         KWFZzHiqNF3E3Cp+2W8gt1upaGfila8aKoJj+kPQHVTDjHCXH38+EPUJM0YEjzRPeJXq
         H1dgNoNHpqprqDbAvB/0xDsiLjD5ebS8EWKd9e6G52xAFP1SgkPn6oKcuMacpKCIqMbD
         AlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rI8P5PWESGlQoMNfKJlDMDZN77XRS6tO+BP9N8huPI=;
        b=BduTJ9MuJY33H5FUuHyV8UcVjGtyk8fGJcXP8fn1rv4J2mKeDGcIXqqj+22uHIF9qt
         AzFMf5r6ow7hS3MtTBa9u6rEY7gFffNoNVzpENjhmjCNI3YkBZOUC75zGxQVB/FC/5X1
         N9ZxFRTdjJrn2cl0J64GsZZYe2QRJKCOUOxzAtCpD61xFeuwnlNAreYXvvWKnAPHViNt
         nKo5kSKO8iKSnzH8FQ5TADG0Ipk1qmh+5E1psaQNFXgjYwYQ5v3EXox5H6igFm1wrgb4
         Ju91sDYOCKIetzNmtyBBsPkiWzl4oCOcv6TIZoa6Y4YMk8xBw9sU/inJfR8SIik4y4Xc
         Srqg==
X-Gm-Message-State: AOAM532TXpgLC52aod3EqIe2f3uK/cwbmcJpPN5XThIcJqgYr4PUNZd/
        i+ZaYN5Hw+2ryIJ/fwugl5MmCjh25n1/FbWf+b4=
X-Google-Smtp-Source: ABdhPJzoXe3rNSii8IpjkaZiCPX2/WSISNfumIJ9fxe01U5lMwWBS8KWI9i/vSOFy22d11+qY7hIctXTfTNa0QlpfI8=
X-Received: by 2002:a17:902:e98c:b029:da:cb88:f11d with SMTP id
 f12-20020a170902e98cb02900dacb88f11dmr1945433plb.17.1610540526504; Wed, 13
 Jan 2021 04:22:06 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu> <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
 <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com> <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
 <CACRpkdaH-1s8DnRUPVRSQgqUE99MdWjKGLv_y6iYnXU6p4dwUg@mail.gmail.com> <CAHp75Ve3QqLqe2sQhNgdrDfKm2uSwXFwMr5_GgGf3tiuCp2DBQ@mail.gmail.com>
In-Reply-To: <CAHp75Ve3QqLqe2sQhNgdrDfKm2uSwXFwMr5_GgGf3tiuCp2DBQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jan 2021 14:21:49 +0200
Message-ID: <CAHp75VceqwbfQ=z34K=soKu4-qvLVEtobFg1sO4jukRcT7BXBg@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@kernel.org>, Willy Tarreau <w@1wt.eu>,
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

On Wed, Jan 13, 2021 at 2:17 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jan 13, 2021 at 2:02 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Wed, Jan 13, 2021 at 11:27 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Jan 11, 2021 at 11:55 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > > > basically 486 but have a few extra instructions - probably just cpuid
> > > > and (IIRC) rdtsc.
> > > > Designed for low power embedded use they won't ever have been suitable
> > > > for a desktop - but are probably fast enough for some uses.
> > > > I'm not sure how much keeping 486 support actually costs, 386 was a
> > > > PITA - but the 486 fixed most of those issues.
> > >
> > > Right, we have "last of mohicans" (to date) Intel Quark family of CPUs
> > > (486 core + few i586 features).
> > > This is for the embedded world and probably not for powerful use.
> >
> > What is the status of PC/104?
>
> Personally I have no idea, but...
>
> > https://en.wikipedia.org/wiki/PC/104
>
> ...from this we learn about PC/104 consortium on site of which we may
> learn about new products:
> https://pc104.org/products/vcs-1-pc-104-system-for-precision-robotics-applications/

It's ARM based for which Wiki says:

"Non-x86 PC/104 CPU boards based on ARM or PowerPC are also
commercially available. However, such boards are not capable of
running off-the-shelf PC software. In these cases, a Board Support
Package is usually provided by the manufacturer for the supported
operating system(s)."

WRT x86 I run the search
https://pc104.org/product-search-results/?kw=x86&post_tag=&product_type=&specifications=&pc-bus-technology=&user=Filter+by+Member+Company
seems like all of them are based on Vortex86DX.

> One and a half years ago, not dead to me.

-- 
With Best Regards,
Andy Shevchenko
