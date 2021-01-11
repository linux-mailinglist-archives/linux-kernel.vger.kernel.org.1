Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569722F2222
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbhAKVsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:48:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731959AbhAKVsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:48:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E53E22D05
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 21:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610401660;
        bh=Y4SXqrUhlLBhYuxs0PmAaiZYlongqif+XAugbu8q28Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iepkmSsC0Mi+2rtoh1iLmJ23/r1NvxnN6Z6m1jw4hei1iUNLoaM0IU0A2h9DmlXGZ
         kFT0MjZHUUkquQpWeHCNWuso8T2L5RvzazCjp1v+7xZJ1161drdCn23dK/ZHwxuAIR
         O0n39eMLJaqIxQSKCEsJYQjFHr77b+JVi/LKSqc8Lw7Kh4yfDplkUF9kf08kVwfa9n
         TPvfcix60WULkh/L4BMRNbtf3OFwMyS3KgnHq44ja39XZkWeUrJfqnDI74/gSwI5xd
         vufb284VKuoTzvZ/U+hIzaT2gjUYb9L2GURTlPw6aLqov1ywE+KtZ16vjrCFNbpyFa
         fNjdqj57cFfRg==
Received: by mail-oi1-f174.google.com with SMTP id x13so181479oic.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:47:40 -0800 (PST)
X-Gm-Message-State: AOAM533HKG7LV1wB4FyN49ZlOSm0Tdf3kQXWzA1Vh8rZhZ6Y/V2c4Rav
        fnu/uwaj/RVhwMadRnu/p336fybl29/Th0wHcmI=
X-Google-Smtp-Source: ABdhPJwCj08bsKPmvXmJPm6WPHbhSyvHZzwODOSsn4etOP80l/iTzuWW8xjNOH4Z523crEsy7rJvGMT+4MmLB9sLhwk=
X-Received: by 2002:aca:fd91:: with SMTP id b139mr491333oii.67.1610401659284;
 Mon, 11 Jan 2021 13:47:39 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210111111047.mgrdho7frjukxfze@vireshk-i7> <CAK8P3a0j2XrV9a0Rm_3LaKAgKW8Kzneu-KXcfSU0zHS6S9ou8w@mail.gmail.com>
 <AM0PR04MB556964159EEB85C87124E4A7EBAB0@AM0PR04MB5569.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB556964159EEB85C87124E4A7EBAB0@AM0PR04MB5569.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 11 Jan 2021 22:47:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0+M2UHe+DqqmTSrAs94rZ1Uw6g1ibttU6PVivCi2RCkg@mail.gmail.com>
Message-ID: <CAK8P3a0+M2UHe+DqqmTSrAs94rZ1Uw6g1ibttU6PVivCi2RCkg@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Mattias Wallin <mattias.wallin@se.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:15 PM Mattias Wallin <mattias.wallin@se.com> wro=
te:
> >On Mon, Jan 11, 2021 at 12:10 PM Viresh Kumar <viresh.kumar@linaro.org> =
wrote:
> >> On 08-01-21, 23:55, Arnd Bergmann wrote:
> >> > * spear -- added in 2010, no notable changes since 2015
> >>
> >> I started an email chain with the ST folks to see if there are any
> >> concerns with this getting removed and it was confirmed by Mattias
> >> (Cc'd) from Schneider Electric (one of SPEAr's customers) that they
> >> indeed use mainline on spear320s and the spear1380 boards, while they
> >> also have access to spear1310 board which they don't use that often.
>
> > Thank you for reaching out to them!
>
> > Do we actually support spear1380 with the mainline kernel? I've
> > never seen anything other than 1310 and 1340 models mentioned.
> > If Schneider have additional patches on top of mainline for this,
> > it would be good to get those merged as well. Is there a kernel
> > source tree available somewhere?
>
> > Rob Herring had mentioned that it would be nice to see SPEAr
> > get removed eventually because it was only partially converted
> > to devicetree, with some AUXDATA() (on 300/310/320/6xx) and
> > some dmaengine channel data still in source format. These need
> > to be finished before we can kill off AUXDATA.
>
> Thanks for taking the time Arnd and Viresh
>
> The spear1380 is not supported in mainline but it's quite similar to 1310=
 and 1340.
> The spear13xx comes in a few flavors. 1310 and 1340 are the standard ones=
 sold by ST and the 1380 are the customized version for Schneider Electric =
needs. One part of the chip is customizable but the base is the same in all=
 13xx. So a few IP blocks differ between the flavors. I can try to send you=
 the 1380 stuff as well.
>
> There is currently no external source tree for our kernel easy available.
>
> If the AUXDATA on 3xx is a problem I can try to start focus on sending fo=
r patches in that area. We have patches that move some more parts over to d=
evicetree (compared to mainline) but we haven't converted all. I will inves=
tigate if we have something that helps in that area.

This sounds great, thanks! I think the main work that needs to
be done here is to convert the DT over to use the regular
dma-controller binding (as used on spear13xx) for the pl080.
Please contact Vinod Koul, Linus Walleij and me in a separate
email thread if you have questions about that.

Looking forward to getting those patches,

      Arnd
