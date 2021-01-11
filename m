Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72DE2F0DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbhAKIUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:20:24 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:39795 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbhAKIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:20:23 -0500
Received: by mail-oo1-f44.google.com with SMTP id k9so3917496oop.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RnZdbI3asH8PEPPSzjCJDBfk3jaPeti8mCF848WSZhc=;
        b=p8GaFm89GWi7R12+IV3i4bSJIUPDYgZneT4LN4LO4KP7g56vqBlpFuRijr5+WRwQww
         pI/FkljPUXKtlQ+ToNdGAka+l9oA2qNcwWO83fExDE58B2vGlFV3cJKmKKwdzzTDa9We
         r++2deWntOUfUytL158y4pSpbg5vr336jfiMLt8r1ZkvFKe14uRQ/VGz9Mg+bLVhsUrO
         0+4k/iKyJ64zN4d6GLfqMwJHynV2DO1ITcQGDxn/mzql3zpeLpTXCqpJcTYYIzAjLdEA
         55nJe1z3NiZdFtbQeFrdX+MPw25bdI9QqmzD7gK0CiVrmESlklvLLNJqdZKEi6JN9OZt
         A/EA==
X-Gm-Message-State: AOAM530+4t1CkEl5EZnhVv2liv31XNd4VPFijJspNqrv2GuooBFcTg5X
        tYGThOnH/jH/RnFAoSDLkPGq3P2rlLQOhdPUoKE=
X-Google-Smtp-Source: ABdhPJxo//LOA1NJsq1u7P5al9TztJRyJuJNYoTWU3fzhtBTGb4ierpk2jcw26KsnWxKko3a9J8Pq/7ilGCUQYi9xEw=
X-Received: by 2002:a4a:ca14:: with SMTP id w20mr11245802ooq.11.1610353183024;
 Mon, 11 Jan 2021 00:19:43 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jan 2021 09:19:31 +0100
Message-ID: <CAMuHMdWiYkhN_S2t+hg0cDk84Qd950YE9-qGTgsdL_-2vPr1WQ@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Arnd Bergmann <arnd@kernel.org>
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

Hi Arnd,

On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> * MIPS R3000/TX39xx: 32-bit MIPS-II generation, mostly superseded by
>   64-bit MIPS-III (R4000 and higher) starting in 1991. arch/mips still
>   supports these in DECstation and Toshiba Txx9, but it appears that most
>   of those machines are of the 64-bit kind. Later MIPS32 such as 4Kc and
>   later are rather different and widely used.

I have a (32-bit) RBTX4927 development board in my board farm, boot-test
every bi-weekly renesas-drivers release on it, and fix kernel issues
when they appear.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
