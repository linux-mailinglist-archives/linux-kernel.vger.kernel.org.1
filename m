Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6AA2F03C5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 22:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAIVTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 16:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbhAIVTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 16:19:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4098923B06
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610227144;
        bh=Wjea4p5+v2kGiIayT2K3Sh3zDjCRWJD4Fck7JFH4Zyo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a9TTNsVRzg8vY38vokz4xmcPrROYebYKEHP9VYEPxTbxbSeD4G/GEdT+HaCqvSR0r
         hE8KWIKhQIknhA1lz8v5iW7SWUBBx+fOzBMf7jCsBA71Bl/c3VrQJ9j/q9kan0TNcE
         wY8n/B0bpc4CTDJCLGQHmjLm882GkftFN1jYMKqMqqryZUkh/MckQzFnjw6bA1Nn2f
         PrQtxH8kqHkCv7oRPVLM2w+zCYEnyDkN0ZBXHBlQTdzdbs/TxOtczuAkjglgywWz/l
         c8QIZN+5sRcrjfoXB503LjpAq/k2enO6h+2uD8VmI2c00hiia1SUb5Ec9ZcNFf6Q3Z
         bCB7wG3WEOaqA==
Received: by mail-oi1-f171.google.com with SMTP id x13so15758434oic.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 13:19:04 -0800 (PST)
X-Gm-Message-State: AOAM530UrMFAxPuvpW943GsQ0bYVtmtkqDcvpNfB2uxLiF5gRW2KkTzE
        9WMG3DNFWYZKIcBTyUws0qeVVsTQaQAMXb8m35w=
X-Google-Smtp-Source: ABdhPJzQiqVekODuktQ+EHHy0liRQR7v04i4JCK6kZhOteCjh568553Wdh3815F4OmNSsfPRnHTF9KtzzHO/VdqCuqg=
X-Received: by 2002:aca:fd91:: with SMTP id b139mr5868474oii.67.1610227143442;
 Sat, 09 Jan 2021 13:19:03 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <0f363c27-608d-76be-3af5-189d812f805d@gmail.com>
In-Reply-To: <0f363c27-608d-76be-3af5-189d812f805d@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 9 Jan 2021 22:18:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1aomu9U9=5QvvwaJYTVfp_s8peeA78DVOZmg97Y3L8_w@mail.gmail.com>
Message-ID: <CAK8P3a1aomu9U9=5QvvwaJYTVfp_s8peeA78DVOZmg97Y3L8_w@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Florian Fainelli <f.fainelli@gmail.com>
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

On Sat, Jan 9, 2021 at 6:34 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 1/8/2021 2:55 PM, Arnd Bergmann wrote:
> > * bcm/kona -- added in 2013, no notable changes after 2014
>
> I have a development board that I occasionally turn on for testing
> upstream kernels, it has not broken in a while which is why it did not
> get much updates. I don't feel strongly with respect to keep it or
> dropping it though.

Does that include all Kona-family SoCs or just one of them?
I see Kconfig listing bcm23550, bcm2166x and five variants of
bcm281xx.

We've seen a bit of a comeback of older phones making it into
mainline, so it's possible this platform might see a revival as well.
I now found a list of phones with partial postmarketos support [1]
and ongoing work as of last year.

Let's leave it untouched for now and see if any of those make
it upstream. If only the reference boards are supported and
nobody wants to use new kernels on commercial hardware in a
few years, we can then remove it.

       Arnd

[1] https://wiki.postmarketos.org/wiki/Broadcom_chipsets
