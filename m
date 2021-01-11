Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9502F1901
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbhAKO7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbhAKO73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:59:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DCF822A84
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610377128;
        bh=ww6Gpe7YL/eMYPGsKKGWwb+jWPe4WbloNUjLWHjxwYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wi2/Q+JcejnwuKtdPRBQWUIcp6yobEcGApM23Mf8vbO8LuPBGY4eRc8o9BnTBnvDN
         NK9N/cP0M4pJVsAF65SkP4amh869Rg+H0pDWym5qOjX8ZGKGszfdSR38zsj5ISzbPL
         isuIKBa0tF2wMiecjWQ5dra74mq8Uk+UR5FpHtYrr9g9KqwwUID1ye3Im0Awtqq1uX
         H/OfmLNmAmnweu82+dlUh9Xg7olsIaKWRZloXXNhleVxuHimWdT1VsjzVWnL6+9cX5
         Y+tnKViiId7AJSQzSuUGCeqYx2TpOnEAVzyY1uAztKS0i2K6pJIdj8wuElVK6sKwGt
         p532U2wrcASwg==
Received: by mail-oi1-f174.google.com with SMTP id p5so20359990oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:58:48 -0800 (PST)
X-Gm-Message-State: AOAM530ySwxTkCK56t7P3KSVVYmOOBE0/7k9J4i8brp6lGOBqBnqBqxN
        OAciO3pq2nd8N0XGzU5m5P3EedlPJ80zxDsNvgk=
X-Google-Smtp-Source: ABdhPJwnoMVjzWHgU9eYBAHjcmZ+WgwC0YDN8Vt3dB8+9tcVBxhzWKbJTXPT5UH1L3pOkWQuIfov+2eaox+znBCZsAg=
X-Received: by 2002:aca:fd91:: with SMTP id b139mr9928356oii.67.1610377127714;
 Mon, 11 Jan 2021 06:58:47 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210111174449.86c3848cb62b7aee6b94c42b@mail.ru>
In-Reply-To: <20210111174449.86c3848cb62b7aee6b94c42b@mail.ru>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 11 Jan 2021 15:58:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3bFkpT3nkfc2nimmuxSA7gNUgXGdkBOKmD7_jv1+DfQw@mail.gmail.com>
Message-ID: <CAK8P3a3bFkpT3nkfc2nimmuxSA7gNUgXGdkBOKmD7_jv1+DfQw@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Alexander Shiyan <shc_work@mail.ru>
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

On Mon, Jan 11, 2021 at 3:48 PM Alexander Shiyan <shc_work@mail.ru> wrote:
> On Fri, 8 Jan 2021 23:55:06 +0100 Arnd Bergmann <arnd@kernel.org> wrote:
> > Then there are ARM platforms that are old but have still seen some work
> > in the past years. If I hear nothing, these will all stay, but if maintainers
> > may want to drop them anyway, I can help with that:
> >
> > * clps711x -- prehistoric, converted to multiplatform+DT in 2016, no
> > changes since
> I still keep this architecture up and running (currently at 5.9.0).

Ok, great. Thanks for letting us know.

       Arnd
