Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6772F1014
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbhAKK3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:29:14 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39031 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbhAKK3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:29:13 -0500
Received: by mail-ot1-f42.google.com with SMTP id d8so16406655otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:28:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpcWXKVTLJqhKI2vj6chuqUz7sdp9RxF3q2k5tNxX+I=;
        b=dY9CpdiZ77EDs1BLPE7cO7wC2V/5sgfubKZbGaSQB6RGKeK7hOA2O4LZmVB8f8HIzI
         UlplaTkmuy8E4m6tfXGmj/czMpyavfdanarffPcAqaRL0u1Luqm8Y7Zol1hlU1hCMZgI
         vWpmOct4YJf6CneYzAvcb4I5IKvzX1SGZel+4x1oHpMT8kg2scGuai+GeaF6xcgv1bk6
         1e5hhbluuJ/PnZ9gqR+dhJ5SHTVkFSJxp8x6WvL991z2OwSBYojy0ZhiKdayboOGdfI8
         VqddTgrm3nH4e5dER0+fq0D2XUysEu39DMXBBgShud3GRkqs9kpwmYeauFJ9MuRfKIN1
         8+dQ==
X-Gm-Message-State: AOAM533Jcepv2hGZT77/csHwCRd9W7KIk8Av3MsZ42jBz2o+5S6pPL+D
        hqujN8gzFKe/dCUE7YDQPN+Dkn011DFyW3T1Bis=
X-Google-Smtp-Source: ABdhPJwqATWhbF2EYw19RFdRsmtHHMxAbxUCHL1o29CluZwOGg2AllOgVF3iAvffCVs0QxM+/sauDv/zGmLSLDIzSls=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr10355898otr.107.1610360912569;
 Mon, 11 Jan 2021 02:28:32 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <CAMuHMdWiYkhN_S2t+hg0cDk84Qd950YE9-qGTgsdL_-2vPr1WQ@mail.gmail.com>
 <CAK8P3a3TNVj_Gw=GaEFELdF9Fo25XU_PFWS5N0+kb=R394KNVQ@mail.gmail.com> <CAMuHMdUod26OPXyYG_xmkYgeKELdBJtmojYxDQoz53Dxip77Nw@mail.gmail.com>
In-Reply-To: <CAMuHMdUod26OPXyYG_xmkYgeKELdBJtmojYxDQoz53Dxip77Nw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jan 2021 11:28:20 +0100
Message-ID: <CAMuHMdWEwm76v9op9QKWefFc0XqGsqBQshPxR768cFcv9r8H4Q@mail.gmail.com>
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

On Mon, Jan 11, 2021 at 10:16 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Jan 11, 2021 at 9:59 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Mon, Jan 11, 2021 at 9:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > * MIPS R3000/TX39xx: 32-bit MIPS-II generation, mostly superseded by
> > > >   64-bit MIPS-III (R4000 and higher) starting in 1991. arch/mips still
> > > >   supports these in DECstation and Toshiba Txx9, but it appears that most
> > > >   of those machines are of the 64-bit kind. Later MIPS32 such as 4Kc and
> > > >   later are rather different and widely used.
> > >
> > > I have a (32-bit) RBTX4927 development board in my board farm, boot-test
> > > every bi-weekly renesas-drivers release on it, and fix kernel issues
> > > when they appear.
> >
> > Right, I was specifically thinking of the MIPS-II/R3000 ones here, I know
> > there are users on multiple actively maintained MIPS-III platforms.
> >
> > Regarding 32-bit vs 64-bit kernels, can you clarify what makes this one
> > a 32-bit board? Is this just your preference for which kernel you install,
> > or are there dependencies on firmware or hardware that require running
> > this machine in 32-bit mode?
>
> TX492x is 32-bit (/proc/cpuinfo says mips1/mips2/mips3), TX493x is 64-bit.
> As Debian dropped support for mips3 and older, I'm stuck at a Jessie nfsroot.

Upon closer look, all TX49xx are 64-bit, but the VxWorks boot loader
refuses to boot 64-bit kernels ("Size is incorrect"), hence I settled
for a 32-bit kernel config a long time ago.
Probably I need to write a 32-bit bootwrapper first. which would allow
me to upgrade the Debian userland beyond jessie using mips64el?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
