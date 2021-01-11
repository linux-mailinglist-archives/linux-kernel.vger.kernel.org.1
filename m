Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5AF2F0EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbhAKJAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:00:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbhAKJAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:00:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27A0922B3A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610355581;
        bh=ybK5U+BUdI/pR3b5T1Dl4Bho1Rzl4FeKk+oMZheLGLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oYOGz8iRjB6gT7LGQTIvmjjlbkTVgNFV16Iv5lOpEYl42PTzz/cGZ1PbOkycLN/Fb
         3W8WKJOxjej8yhSCS253Osksp+OK8huzmyeKnso3d0OVicTBQu7bX5SkWrnFe2oVqv
         fTQHAOXrHo9TQNufgcI5GMgjzeU1mFt3eV8oBhnDeaULOxQHsAc8GdWZDUEsdLvfRv
         Iq62lOcSx3+dAmNEdSJ12ywdjRAV+H85VqFVN7vvN8mMzxfPibnZ9ar6yp9CU/mpXq
         49veFvDKWkvp/yhR7/XSvnCL2MAX6iQV9oGYAe3S4ayuaL6Xz4uIx4dlDetmMBFLu0
         2Wrt2B72YUl4w==
Received: by mail-ot1-f43.google.com with SMTP id 11so16201060oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 00:59:41 -0800 (PST)
X-Gm-Message-State: AOAM533chRoq+TQobOCCypQoaTj521Q5NOAntZVlzVutkX2nMDOMUmWH
        PVLDm6ahMKxDOhYO2TD/wiMa/m7PvwzUxNlITNo=
X-Google-Smtp-Source: ABdhPJyJdWIN/3oMwPmrSVTEmowKiKlaukdf+1svNcF71wYiTOofYL4DsZZY5Q2W6C+ANSD79TxZX+lV9hDtm/8s8lQ=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr10780215ots.251.1610355580235;
 Mon, 11 Jan 2021 00:59:40 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <CAMuHMdWiYkhN_S2t+hg0cDk84Qd950YE9-qGTgsdL_-2vPr1WQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWiYkhN_S2t+hg0cDk84Qd950YE9-qGTgsdL_-2vPr1WQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 11 Jan 2021 09:59:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3TNVj_Gw=GaEFELdF9Fo25XU_PFWS5N0+kb=R394KNVQ@mail.gmail.com>
Message-ID: <CAK8P3a3TNVj_Gw=GaEFELdF9Fo25XU_PFWS5N0+kb=R394KNVQ@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Mon, Jan 11, 2021 at 9:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > * MIPS R3000/TX39xx: 32-bit MIPS-II generation, mostly superseded by
> >   64-bit MIPS-III (R4000 and higher) starting in 1991. arch/mips still
> >   supports these in DECstation and Toshiba Txx9, but it appears that most
> >   of those machines are of the 64-bit kind. Later MIPS32 such as 4Kc and
> >   later are rather different and widely used.
>
> I have a (32-bit) RBTX4927 development board in my board farm, boot-test
> every bi-weekly renesas-drivers release on it, and fix kernel issues
> when they appear.

Right, I was specifically thinking of the MIPS-II/R3000 ones here, I know
there are users on multiple actively maintained MIPS-III platforms.

Regarding 32-bit vs 64-bit kernels, can you clarify what makes this one
a 32-bit board? Is this just your preference for which kernel you install,
or are there dependencies on firmware or hardware that require running
this machine in 32-bit mode?

(MIPS is not my area anyway, I'm just curious)

       Arnd
