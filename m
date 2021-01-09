Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F52F2F0415
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 23:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAIWVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 17:21:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbhAIWVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 17:21:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C29EF216C4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 22:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610230864;
        bh=Y9R/my2GEg7iOxdLFyP/D3K/HvvBPrPKxXovy3Qc/Mk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CdLwVyQRYCTDrZ2zGeBsSFmHAK+k2yWdFLAfG8Q0MLz7bpJF3uLxPOj0i+m/AFcET
         u/RBo1glqYzUhh/txrTc+oe5C9aRcyel9JRHoH6W/Qz149cwXdkneJD7rZmdQoeSSg
         1cgspTTaetDr4pDeq+r+UlxxcmtdJ2T1anqYUrYjG/ADFD24QZ1WHePEonT1F62Rvx
         z3LsZop8zQBTsR9hHd6trEtaOPumpv/yZ0WKxDixIDd72M7ctYMz33rmVp5BbkqJkc
         wY1a1jukYz8kbCnaMNAGOHsz3+knFSETQAydR0fPFjxiplxOXHU+CSo6AQT4Oq0OdG
         mEatyG+q9xRzw==
Received: by mail-oi1-f179.google.com with SMTP id d189so15805346oig.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 14:21:04 -0800 (PST)
X-Gm-Message-State: AOAM533X4OuM4yXP9jN5uW3MiPL3a1F4nwSEeHZON6Yt6iKBaS+SZPmW
        jaMDdDoeuUFy3NmX3NWTmmwfKxzZkX1ldljgLSQ=
X-Google-Smtp-Source: ABdhPJxooODkmHZ+0nOYWJoRf96Yp+8E/Mn1ECT8Rj2cjSQ74IVO9A80t4WqWyRetAA6yREpgOakl3cUwt0aeSc7Gns=
X-Received: by 2002:aca:44d:: with SMTP id 74mr6348858oie.4.1610230864221;
 Sat, 09 Jan 2021 14:21:04 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <67171E13-6786-4B44-A8C2-3302963B055F@gmail.com>
In-Reply-To: <67171E13-6786-4B44-A8C2-3302963B055F@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 9 Jan 2021 23:20:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0o=1KjPtp0Ah8Afe5vvG1b72+77HRFh4Z06HUGwN6+Ew@mail.gmail.com>
Message-ID: <CAK8P3a0o=1KjPtp0Ah8Afe5vvG1b72+77HRFh4Z06HUGwN6+Ew@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Daniel Tang <dt.tangr@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
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
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        fabian@ritter-vogt.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 1:06 AM Daniel Tang <dt.tangr@gmail.com> wrote:
>
> Hi Arnd,
>
> On 9 Jan 2021, at 9:55 am, Arnd Bergmann <arnd@kernel.org> wrote:
>
> * nspire -- added in 2013, no notable changes after 2015
>
>
> I believe this is still in active use. I=E2=80=99ve CC=E2=80=99d Fabian i=
nto this thread who=E2=80=99s
> probably in a better position to respond to this.

Ok, moving it to the "keep around for now list" as well, to be on the
safe side. Would either of you already have a guess for how long it makes
sense to update kernels on it?

I see that this is one of the more limited platforms with just 32MB
of RAM (64MB in case of CX), and kernels only get more bloated over
time, so I expect at some point you will be stuck with running old
software.

Wikipedia tells me that new models came out recently. Are you
planning to add support for those as well?

      Arnd
