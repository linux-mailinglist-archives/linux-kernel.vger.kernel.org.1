Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E992F1912
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbhAKPB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730264AbhAKPBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:01:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D0E722795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610377274;
        bh=eKy50e4DY4SL9/AcF52lTzbb2W9yqyrDJvJZDmzYAls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GyEoQrJMV8yVDQ0DHdjDPzpz3/ewOYhXJvb+1yMjTYgllWy3sWRrFpIPuNpr0lISD
         IBR7QCsmzOE1NBiCHCkOv32ANRzIWRzU5MQCvy8CAt4LTvNH+/Vp5iSz6vRWpWurLp
         5MIc0Uf7I2qAbwXXQwAfW6aQH3BH+UycqmjJ48NOrioR5/7H+k6rnlYuM+QUiFD7bu
         bk7/+VSYotWLOaqeHwsjMa70nW+6vrWXrDmB4ipQDBeDZlH0ZoHa3UWptxNRxAM/F8
         ut3yC6SEphFSaHt5HsKJyIMbDi04adbmoMOOPS8rCd8avlwcxaRlntrZo0pU6ecKdM
         BjQIoAdODnQrQ==
Received: by mail-ot1-f46.google.com with SMTP id w3so17084953otp.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:01:14 -0800 (PST)
X-Gm-Message-State: AOAM531aSpQoyp9fN0FPEJj9KMCWaB0WeuuC2IAmkg7p7z82E/KGxcrT
        nCgF7A/rnE2OS1isBnhijy8lepM+5n9vC2iStwQ=
X-Google-Smtp-Source: ABdhPJw8HZVruPoahj4S7PvQGqsa+IY423HuaTrj9hH8ma5vxU2COhZP9sOB7P3/mz8uywP7nQ5+83UFCZ4dQXAGnAI=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr11703458ots.251.1610377272945;
 Mon, 11 Jan 2021 07:01:12 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <41dc7795afda9f776d8cd0d3075f776cf586e97c.camel@redhat.com>
In-Reply-To: <41dc7795afda9f776d8cd0d3075f776cf586e97c.camel@redhat.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 11 Jan 2021 16:00:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2HzAFCyK6Y+-NDgFDCyzqeZqBwzGK3L-FR2toTP+szAQ@mail.gmail.com>
Message-ID: <CAK8P3a2HzAFCyK6Y+-NDgFDCyzqeZqBwzGK3L-FR2toTP+szAQ@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Mark Salter <msalter@redhat.com>
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 3:22 PM Mark Salter <msalter@redhat.com> wrote:
>
> On Fri, 2021-01-08 at 23:55 +0100, Arnd Bergmann wrote:
> > * c6x: Added in 2011, this has seen very few updates since, but
> >     Mark still Acks patches when they come. Like most other DSP platforms,
> >     the model of running Linux on a DSP appears to have been obsoleted
> >     by using Linux on ARM with on-chip DSP cores running bare-metal code.
>
> Hi Arnd,
>
> So this has been on my mind for a while now. I no longer have working hw
> for c6x and TI hasn't been forthcoming with replacements. I'm totally fine
> with removing it from mainline. In any case, I'm not really in a position
> to go forward as maintainer.

Ok, let's remove it then. I'm happy to take patches through my
asm-generic tree. If someone shows up later that does have an
interest in the platform for future kernels, I'll drop the branch or
revert it after it gets merged.

       Arnd
