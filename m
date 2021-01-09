Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD82F03C6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 22:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbhAIVU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 16:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbhAIVUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 16:20:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED39F23B00
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 21:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610227185;
        bh=5A1fmjF0y6VRqP4afm9dtv0eNN7aNNXcfMhZiYQfBEQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gkwg+rdBariwYcSIMlYiUdGfkSAJ0vSn4UoubJjk4VWU/cKVm2yo+fJEU1rI5rJhf
         gVg0puF3vXfnp6B2kuf7uSyFZQ9WRBKvritunLlRbFSvhJLQSwFuEmPbjvhYSdaed1
         EJyM8wqfGRtLAYQIZEEIOf+AvYC3IX0Hc8v1vc4DpFCC0c7DgdDhu35HC0zEBEdMLQ
         E1xtYnwYTvlOajXsvtHXty5puj33FNNCf8KX6bjGO8Au++yuocFdi91FoFnlXSYXla
         KmpDbI5h/QVwIv/FDEzkBYRTezZuHOEfnBe1ItYlmWdVSoHGt0ckZOsOuTvm1ZIhXO
         fsGGDyuAw9VCQ==
Received: by mail-oi1-f177.google.com with SMTP id 15so15756260oix.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 13:19:44 -0800 (PST)
X-Gm-Message-State: AOAM531LohwSHdlBXgqFRmwpc2CYKWUz6cR02tMthEg+I8nTWtZLa/g+
        7BVX5mRPC23rHlvP+zOAyhHyyp5PhGRaMILCZ3k=
X-Google-Smtp-Source: ABdhPJyHe7Oz5r5F5EevitD3IOqUKI7OuSbLUkoxs51+zUczh7ZUciI74Qn6VehAg3JmLb9kRa7dJoXf1NisNFYJAGA=
X-Received: by 2002:aca:44d:: with SMTP id 74mr6254282oie.4.1610227184309;
 Sat, 09 Jan 2021 13:19:44 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <87a6thzwv9.fsf@tarshish>
In-Reply-To: <87a6thzwv9.fsf@tarshish>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 9 Jan 2021 22:19:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a24FAuGSpiS3t6LHQ59+n+gf_owFr1MkFe-MEV-Z=AhdQ@mail.gmail.com>
Message-ID: <CAK8P3a24FAuGSpiS3t6LHQ59+n+gf_owFr1MkFe-MEV-Z=AhdQ@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
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

On Sat, Jan 9, 2021 at 9:21 PM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Hi Arnd,
>
> On Sat, Jan 09 2021, Arnd Bergmann wrote:
> > * digicolor -- added in 2014, no notable changes after 2015
>
> I have access to the hardware and I'm still interested in maintaining
> mainline kernel support for it.

Ok, dropping it from the list, thanks for your reply!

         Arnd
