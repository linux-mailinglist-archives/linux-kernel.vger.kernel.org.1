Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5552F754D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbhAOJ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbhAOJ1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:27:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E59D2343B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610702792;
        bh=MsmYg64gbUSN25ldXEMW1GVPCc9OvEpGcvUMo0/syYo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uqNGfYawiVFnEZlClWikFsk7jvqdm4WX++k1IxKyePCy7cITEk/8ukXCTwPDIbY31
         NYdO7iiTX8uRw7t1NzMyZLMdJDCZhTzV9H7XahJBPSsnJBXWQyFR8eCwsKvVsPrevy
         0tah4oLIzS0LZX27U2StsKI4mbwoYaLsdqzHZS7bohm7K3bULsHu8JdO9Rl/84/C7r
         6LF2NdhzHi06ea1lYTcAfhlyhGg2D9EbGmvalez0cEU7mcGic4u/90wGX9GQ/X+DmJ
         0101e3PU0d86Iw1BRJejLk2xpSrmGXyZ8dW8JMhOs0VHwMaRCkGlOCnxRvl23l/LPD
         Hg5T0Yz+rMWyA==
Received: by mail-oi1-f175.google.com with SMTP id q205so8857772oig.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 01:26:32 -0800 (PST)
X-Gm-Message-State: AOAM531unAZeusm2VZNrtN1SEbTbEeOqJUZWjRfXHqZPNujWYcEg658T
        qkFUnON2FCt8B6Ix+NHC3zEVDM1gfUy8fhkVEes=
X-Google-Smtp-Source: ABdhPJx67fcSlAjzJcLLJTZgMZtCyxxWQ0M3Q7fZdkaDyZ+rbSasRfNZu0+OmONxmKONGbJsXd3+Uq6heapEAjlYBzQ=
X-Received: by 2002:aca:e103:: with SMTP id y3mr4872739oig.11.1610702791868;
 Fri, 15 Jan 2021 01:26:31 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <CAK8P3a2DZ8xQp7R=H=wewHnT2=a_=M53QsZOueMVEf7tOZLKNg@mail.gmail.com> <60013F54.9050305@hisilicon.com>
In-Reply-To: <60013F54.9050305@hisilicon.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 15 Jan 2021 10:26:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a26Ca_59NiGGGv+CHYZSmkTRESpgV4aGFPhrY=KBa8aBA@mail.gmail.com>
Message-ID: <CAK8P3a26Ca_59NiGGGv+CHYZSmkTRESpgV4aGFPhrY=KBa8aBA@mail.gmail.com>
Subject: Re: [v2] Old platforms: bring out your dead
To:     Wei Xu <xuwei5@hisilicon.com>
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
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tony Prisk <linux@prisktech.co.nz>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 8:08 AM Wei Xu <xuwei5@hisilicon.com> wrote:
> On 2021/1/14 0:14, Arnd Bergmann wrote:
> > On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > * mmp -- added in 2009, DT support is active, but board files might go
> > * cns3xxx -- added in 2010, last fixed in 2019, probably no users left
> > * hisi (hip01/hip05) -- servers added in 2013, replaced with arm64 in 2016
>
> I think it is OK to drop the support of the hip01(arm32) and hip05(arm64).
> Could you also help to drop the support of the hip04(arm32) which I think nobody use as well?

Thank you for your reply! I actually meant to write hip04 instead of hip05,
so I was only asking about the two 32-bit targets. I would expect that
hip05 still has a few users, but wouldn't mind removing that as well if you
are sure there are none.

Since Zhen Lei is starting to upstream Kunpeng506 and Kunpeng509
support, can you clarify how much reuse of IP blocks there is between
hip04 and those? In particular, hip04 has custom code for (at least)
platmcpm, clk, irqchip, ethernet, and hw_rng, probably more as those
were only the ones I see on a quick grep.

If we remove hip04, should we remove all these drivers right away,
or keep some of them around?

      Arnd
