Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70412F206D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391370AbhAKULM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:11:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbhAKULL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:11:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06C5A22D04
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610395831;
        bh=PAmmi3WEVNu+XF6HOJcil+oslU7LNAsHmQgcOS7diCQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I72FBlX3qlW+aQzowCV1kutMZCcjqCNlHANlEy56XF4khfePE8vAFKtaOyxpBmZFn
         B6NjqJihUBs54hyj5AzkMnr0rWvztprNKR5+0RjffvcIQOm6FZ4/k1wnKUee/QzUMK
         E425Q0mrtlV3u+QP7OlKDTFwmM5pjuw6fJ86CkMyPWXlq4QGUUToBdCzIVpkro33uU
         +9mGqeE69Mc/xxwE9jUBfgQXFhGuPTAURPxw/EtZLwHkopQJaJhE6C/bYhzvkSMu82
         AavvbOQlGXWSjoqT0oUtw+K66nkm4KWiSqaGTkXS5lZbdzstJkd9x3FokPKXg5D+LX
         IgxnwWfNWrWgg==
Received: by mail-oi1-f177.google.com with SMTP id f132so605951oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:10:30 -0800 (PST)
X-Gm-Message-State: AOAM531oEdAiFLiuCmq6TP6iNBau94lnzn5+dZNf8IOw+gT06qovQnlw
        qyJv1MiLR/YRqcvd2ygLtNHWDmgvDeGP1sMO+Wc=
X-Google-Smtp-Source: ABdhPJx8fWqrvTGn3wI1Z2wCm0FLpeaYFvG+O8ZhOkp3Nmb7sRZiqysCgyKK2zfCfep7SqLqul//v+L6P1GustpH12g=
X-Received: by 2002:aca:44d:: with SMTP id 74mr353245oie.4.1610395829991; Mon,
 11 Jan 2021 12:10:29 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210111205814.0e6d3493@windsurf.home>
In-Reply-To: <20210111205814.0e6d3493@windsurf.home>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 11 Jan 2021 21:10:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2bhqa60Jd=kO5sOq+mKqA_Krnrbk3UJE2W97aF_EYj0A@mail.gmail.com>
Message-ID: <CAK8P3a2bhqa60Jd=kO5sOq+mKqA_Krnrbk3UJE2W97aF_EYj0A@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 8:58 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
> > On Fri, 8 Jan 2021 23:55:06 +0100 Arnd Bergmann <arnd@kernel.org> wrote=
:
>
> So overall, I'd say that yes we could probably drop arch/arm/mach-dove/.

Russell mentioned that he still uses a cubox with an out-of-tree
board file for dove.

> > * spear -- added in 2010, no notable changes since 2015
>
> Well, I did quite a few improvements in spear DTs in 2017, some
> improvements to the NAND FSMC driver for Spear, and my colleague Miqu=C3=
=A8l
> Raynal fixed an issue in the Spear NOR driver in 2019.
>
> We have one customer running a 4.14 upstream kernel on a Spear600
> product, and this was a fairly "recent" port, in the sense that the
> product was originally running WinCE, and we ported Linux to it many
> years later after the product was first shipped.

Ok, thanks for the list, very helpful. Sorry I missed your DT changes
when I went through the logs there.
Viresh already pointed out Schneider Electric as a user of multiple
SPEAr SoCs.

> > * lpc32xx -- added in 2010, multiplatform 2019, hardware is EOL
>
> As late as early 2020, we were finishing the migration of one of our
> customer LPC32xx platform to a recent mainline kernel.
>
> So in fact for us at Bootlin, it happens pretty regularly to see users
> of "legacy" platforms having a need for an updated kernel. From the
> above, you can see that even legacy SoCs such as Spear600 and LPC32xx
> are still used in products were kernel are being updated.

I had put the lpc32xx in the list of code that is still updated and
should not get removed unless the maintainers think it is near
its end of useful life (which I did not really expect in this case).

        Arnd
