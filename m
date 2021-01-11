Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643D82F0AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 02:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbhAKBjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 20:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbhAKBjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 20:39:52 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C767FC061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 17:39:11 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id b64so13415644qkc.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 17:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSn5Y5uJK/+IyEV47xmLezdCxCclHi6QEB/FGHKgcuI=;
        b=FD/3lTV2zarQtOPn6hW/jXzvj0xl9hms0lH1ySJYa1pO5xf7rOMotgjDJz+EEBWkhp
         ihzEHyRt90AGqJN3n5/VV/pYomoQCT+rWOSn+AwBAhRgWgYXNk3rJfeDBnItZZlQ0DD8
         baFQ3gXzvBS01gG9/a+Dd9gpVeftZQSB8D8b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSn5Y5uJK/+IyEV47xmLezdCxCclHi6QEB/FGHKgcuI=;
        b=q+nFbI0LXIn/FMofH1+roOdtwi4B8niHaNrP3mzjXf4MjscDQ0loj8bd6v/D+9I+PP
         LlG/3bkGapWh8ORJ+EK+YHj5gKLp8wZ1mmo8T9XbZgl78OPwEXCZWqRENi40ZAYYZNpR
         dO9ljXbU5/9OauQoxYIHWbLmlLw09ZwAgS7DexihKasOUvoYc/pBHijWP1hiZvER8uFB
         edDYigHVL0PVA1Pas4QB/mn8M01KgvbwX3g9sSZoMnfNy1FtUZ/y68qld81k+fH9zLgu
         2ctf0sO0xHTios4IG2ffaLsBCyKJweJVCC4ttte4PPTXLXofxLSP68+O8IQmdG8FW0My
         gmDg==
X-Gm-Message-State: AOAM533S+Hv/IcLLiAw/nIDRzJiziBPxLBeE7BPCACtN1iQ5m4Z2HH4M
        8BRd2NxgMjo7JXyADNQ5mcKbpcu1+0vKpza/rT4Urg==
X-Google-Smtp-Source: ABdhPJyYdF0HiEVfal7e5Z8TGQ1m9QShz3O/ZWAm0igXEtdPK1D+aDQo9mmpwOEHoNE1FLGcnhJ9M3gdAxVO0GqiIYA=
X-Received: by 2002:a05:620a:2009:: with SMTP id c9mr14472866qka.159.1610329150899;
 Sun, 10 Jan 2021 17:39:10 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 11 Jan 2021 10:39:00 +0900
Message-ID: <CAFr9PX=BV1YFcO_GQWsW3XEo8nndjUwArzW5Fg1fnWzt8fiwGw@mail.gmail.com>
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

On Sat, 9 Jan 2021 at 07:56, Arnd Bergmann <arnd@kernel.org> wrote:
> * 68000/68328 (Dragonball): these are less capable than the
>   68020+ or the Coldfire MCF5xxx line and similar to the 68360
>   that was removed in 2016.

I have some patches for the DragonBall series to enable SPI etc there,
some patches to support the SuperVZ variant, some tools to upload
Linux via the integrated serial bootloader.
The DragonBall is probably what anyone that wants to build a 68K retro
computer should use as the DRAM controller is integrated and it can
access 32MB of SDRAM.
I haven't tested it recently but it should still work and I have
hardware and I'm willing to look after it if no one else wants to.

Thanks,

Daniel
