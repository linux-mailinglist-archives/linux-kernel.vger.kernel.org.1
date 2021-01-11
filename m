Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082AB2F2042
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404142AbhAKUAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404093AbhAKUAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:00:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9949322D01
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610395163;
        bh=DkYBZDbPhgJvDOak3NtotnviFgu1SawdXOAitWkbLx4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GSso80L150gxh6tIHamwhq21TTt2W1HOSSor8S52GBa87W34hmS+G0MZMUoB/vKBl
         XVmcb/tl5O/14uiw7ymugunVQel8bxctJdImLwU4urMBVchUrnBAqqYRRTl/wSNBbA
         0RIDSuYW3Fy+BkgT/1M4gp87TgMxPrSizwi/+1nHGop5nioJvP6BttV3zHrFQALBTM
         E816OBdbdm5BYG23e50x01xij5cXMP3VZSgnhgUYzjW7wBPZXlULTVp6L92O0HpJCD
         wMWWww6eaCvq0g4B9KQAOz21UM4jcwVeKaQp3uCGRic/gW4qKE+vTgRkGmbTjPHVYD
         lUoWb1vhQ0xCw==
Received: by mail-oi1-f173.google.com with SMTP id q25so580055oij.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:59:23 -0800 (PST)
X-Gm-Message-State: AOAM533TSWyF6nayq/fOvTz9Up5SrEQ8gBh/uQ+kMl6CP45sU5cpdNZm
        FVCaZ1N/QbXNQXu9xZ+lBhUyiH6DJtjZeV6xyGs=
X-Google-Smtp-Source: ABdhPJz4IXUsfuLdcfFiNnOZMxx8IEUq3eLQdK4STom3WhKVkD9BNtBQ9RrGmk3a7msTWRj0U0TZRWXsGd1dG3wafSM=
X-Received: by 2002:aca:e103:: with SMTP id y3mr283995oig.11.1610395162789;
 Mon, 11 Jan 2021 11:59:22 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210111111047.mgrdho7frjukxfze@vireshk-i7>
In-Reply-To: <20210111111047.mgrdho7frjukxfze@vireshk-i7>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 11 Jan 2021 20:59:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0j2XrV9a0Rm_3LaKAgKW8Kzneu-KXcfSU0zHS6S9ou8w@mail.gmail.com>
Message-ID: <CAK8P3a0j2XrV9a0Rm_3LaKAgKW8Kzneu-KXcfSU0zHS6S9ou8w@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Mattias Wallin <mattias.wallin@se.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
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

On Mon, Jan 11, 2021 at 12:10 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-01-21, 23:55, Arnd Bergmann wrote:
> > * spear -- added in 2010, no notable changes since 2015
>
> I started an email chain with the ST folks to see if there are any
> concerns with this getting removed and it was confirmed by Mattias
> (Cc'd) from Schneider Electric (one of SPEAr's customers) that they
> indeed use mainline on spear320s and the spear1380 boards, while they
> also have access to spear1310 board which they don't use that often.

Thank you for reaching out to them!

Do we actually support spear1380 with the mainline kernel? I've
never seen anything other than 1310 and 1340 models mentioned.
If Schneider have additional patches on top of mainline for this,
it would be good to get those merged as well. Is there a kernel
source tree available somewhere?

Rob Herring had mentioned that it would be nice to see SPEAr
get removed eventually because it was only partially converted
to devicetree, with some AUXDATA() (on 300/310/320/6xx) and
some dmaengine channel data still in source format. These need
to be finished before we can kill off AUXDATA.

      Arnd
