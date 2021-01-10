Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7C02F08BC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 18:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbhAJR2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 12:28:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbhAJR2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 12:28:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47A8A22B2C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 17:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610299649;
        bh=uYq6477OiI56lIBgdNUlz6nqs/ADh5xIf6X05DlpjCA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H5Q43gingz0nnRgP56E15WiBA3kcnb6cUoGqs+iaqqpHPnCJsFJvGoWXXC/8i7Ruj
         b3efPTNlkiuM+PaTEsoxOywK9m8tA7uJDOuS8FR/sREgZpdPKSCqUiq82NYXdWjF95
         PBrqY8DIZJgGVfYtW+vTo4EmUgHQwR5L1as6i8n4xLeH5K06Y671U14Iz0ookCA1xM
         RPlyx5dVoYnSbur/Ff2nH3wO0b7gCznsJPm0NJ4O7BahGTK0eUC05ryOVOor8VC+XI
         ce4bz89hQUkEV+wAud2UeoDLLbWZqtmikBbAMq6NER+bGBdY6IfFhgUMincdwksOAI
         4e+hsWjkYAX7w==
Received: by mail-ot1-f52.google.com with SMTP id d8so14736966otq.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 09:27:29 -0800 (PST)
X-Gm-Message-State: AOAM530zR+fjrMEDFMi2gTm2VQ8fIPtmdGQBEu2wkY3ifj+9KEBUaEN0
        Fyg0xon7gLLOKbrfQ8mx1Srowd+BAMyefERAzXs=
X-Google-Smtp-Source: ABdhPJy3XrEaFfL1UOoccHiZfyWKrbafxcruxNadL3M4DGl6IsEbdLfDNyOjDc1NyyB60t15vVBewyda4XgbmzxKi9s=
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr8713491otr.210.1610299648660;
 Sun, 10 Jan 2021 09:27:28 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <X/o4VZzW4m77AYDB@lunn.ch> <CAK8P3a3kg1u3QVj1JS92Js7ZO9HvgDfzBtEbN4HULpNfNEJfoA@mail.gmail.com>
 <X/svb+7x15IiVxU5@lunn.ch>
In-Reply-To: <X/svb+7x15IiVxU5@lunn.ch>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 10 Jan 2021 18:27:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3zkUjiQzscX5TH_PH9HhNEMa59soQ4gD7aX1fWJOBt6Q@mail.gmail.com>
Message-ID: <CAK8P3a3zkUjiQzscX5TH_PH9HhNEMa59soQ4gD7aX1fWJOBt6Q@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Tang <dt.tangr@gmail.com>,
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
        Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Mark Salter <msalter@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 5:48 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > For this platform, I'm most interested in whether there are still users
> > that rely on board files instead of DT. AFAIU we could just fold
> > the DT variant into arch-mvebu like kirkwood was, right?
>
> Hi Arnd
>
> I'm actually booting my device using a board file. But Debian
> flash-kernel is pretty unhappy about that. The bootloader i have on
> this machine is too old to passed DT blob. I will test appended DT
> blob still works. And see if we have any board files which also don't
> have a DT representation.

It may help to ask for these at
https://github.com/1000001101000/Debian_on_Buffalo/,
I already contacted them about mv78xx0. I tried to find
out how the Linkstation/Terastation board files map to the
dts files, but couldn't figure it out either. It seems they
want to keep supporting all those machines and can probably
help out ensure that there are dts files for each one.

      Arnd
