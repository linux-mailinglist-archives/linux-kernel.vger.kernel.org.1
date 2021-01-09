Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74452F03FB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 23:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbhAIWFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 17:05:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbhAIWFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 17:05:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BB4B23B01
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 22:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610229909;
        bh=LrYmjzX/0OTPPWbAK3r3McV+O3Ujjw+sxGKtvoRiOLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KgMpvWVmOYksXf3ptaH9FtwztFpRNjyDqTAJxghRAD260RUIOxmnJmRKYDb4ZGmAQ
         KP0z4d6aEarK+gpLPgmmWbJr0U750bKsV+kn2gfLHV0dKx+OXH0c1nIHFBhunqYSJ4
         FwcHHnra1BaT+FTHH4fpaRvETdJqF0XfMmHrbNBp1cB4Km8fl6nvbAdCBPL2MPcDPU
         OqyOaJ5fk1M+Mb8M7LUWZA51jp2oVVlcwNLDjvXDvWV38gdT3/ZZG1yS+yiXz/qPDO
         zdyM6nXU8czaftZjCfsZIeFQqk99KXlN78Yo3QBiF1HSoAt0/9dOcOtjDOBaqCFa7z
         HqoLlq+PGiZhQ==
Received: by mail-ot1-f54.google.com with SMTP id w3so13307465otp.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 14:05:09 -0800 (PST)
X-Gm-Message-State: AOAM533uKv0SKeyE+GmA2MMWyvFrS21c9eIOSuy+TSN0EcVj0L3ilLGm
        4oXLrYoGhQvUH/BDvxtdDip0087fWLDWV1SxZMk=
X-Google-Smtp-Source: ABdhPJxRP1xkAcr4bk0TZ07QGBirUbyl2wbVh+kTmQIp6xRoFA0T0cFkvqB20WwPa0H5WV+TExUuevrbQBIjM5q+oRY=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr7073248ots.251.1610229908590;
 Sat, 09 Jan 2021 14:05:08 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210108183251.25d53637@oasis.local.home>
In-Reply-To: <20210108183251.25d53637@oasis.local.home>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 9 Jan 2021 23:04:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1wmEubHuG=Sw2_Fzzh1EKUeSCW4N6H-aeOX4jVhY0KrA@mail.gmail.com>
Message-ID: <CAK8P3a1wmEubHuG=Sw2_Fzzh1EKUeSCW4N6H-aeOX4jVhY0KrA@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Steven Rostedt <rostedt@goodmis.org>
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 12:32 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 8 Jan 2021 23:55:06 +0100
> Arnd Bergmann <arnd@kernel.org> wrote:
>
> > * h8300: Steven Rostedt has repeatedly asked about it to be removed
> >    or fixed in 2020 with no reply. This was killed before in 2013, added back
> >    in 2015 but has been mostly stale again since 2016
>
> "I'm not dead yet!", "You're not fooling anyone!"
>
> The patch that I sent that fixes a critical bug in the architecture
> (irq disabling does no compiler barriers!), has been ignored since
> September 18th.
>
>   https://lore.kernel.org/lkml/20200918152507.711865ce@gandalf.local.home/
>
> I'm thinking to kill it and see if that causes any complaints.

I'm happy to queue the patches in my asm-generic tree if you send them
my way. Then they can spend some more time in linux-next and give
possible users one last chance to speak up.

       Arnd
