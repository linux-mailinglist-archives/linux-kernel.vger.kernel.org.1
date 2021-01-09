Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC4A2F03DA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 22:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAIVfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 16:35:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbhAIVfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 16:35:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C9FB23AC4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 21:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610228114;
        bh=C9grJ2sigt5fuSK/Z8PeC49oSn9fwkGab6Hte6VsHpc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gdoXOkJJrm60vuW+kC/EjljCcWCXmJWTrfVWhSnm4EU38Q5UE5ohA386s/AqEiRhr
         M4j7AxdYCYNAM/TY9PDPStKGYGnLsJMTvirgmyXC9tNgS12FQKGdkYJY6XWkyFcB8u
         MLJMEguFDzDFrj72rDcJC+pRCKx7yX83bXRCSZcpFpOvizlfQCeKuUsjf+JmL52qGW
         VveeTPHdOnEohA55M6MM2+9termVAWetFg0dZhwMrWCqJP8fUTmlNlp2Z6NkCr/Efn
         x+TK//s/dYQoqmvPyzg/Da4HcVOB13ZSD+GuIfVE0pWCb4Pt68f0FjDdtI0THK0HAJ
         Tjm4KUsd2BTUQ==
Received: by mail-oi1-f178.google.com with SMTP id 9so15788336oiq.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 13:35:14 -0800 (PST)
X-Gm-Message-State: AOAM533ibWM6FCmolsYGupwrpTuK7KKilpEcYiZ6mzCQYMU9HMtI9MjU
        Jyl8gcOjJj2pMTWqVARGCOLGekiucuKCOBVRH+I=
X-Google-Smtp-Source: ABdhPJzt0kb8n6V1PgKRQpiM/Fk4Hc6Tboxx1iyo75YZ7PCxouY4Ae+Gm0RXZDGXp7BWyi/5CqCjX+d+RtBLJrG3zgQ=
X-Received: by 2002:aca:44d:: with SMTP id 74mr6275134oie.4.1610228113353;
 Sat, 09 Jan 2021 13:35:13 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109174357.GB1551@shell.armlinux.org.uk>
In-Reply-To: <20210109174357.GB1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 9 Jan 2021 22:34:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a03+C6aoR-f0nr4Gf_O6e=ppPoEMPMPya59cT826a0=Pg@mail.gmail.com>
Message-ID: <CAK8P3a03+C6aoR-f0nr4Gf_O6e=ppPoEMPMPya59cT826a0=Pg@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
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

On Sat, Jan 9, 2021 at 6:43 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Jan 08, 2021 at 11:55:06PM +0100, Arnd Bergmann wrote:
> > * dove -- added in 2009, obsoleted by mach-mvebu in 2015
>
> May be obsoleted, but I still use this for my dove cubox with
> additional patches.

What is the status of these patches? I also still have a set of patches
to integrate it with the other ARMv7 machines into multiplatform,
and a series to change some of the PCI handling in all plat-orion
platforms, that I was hoping to either upstream or drop once the
platform itself gets removed.

Did you give up on moving the Cubox to DT, or is this something you
still want to get back?

> > * footbridge -- added in prehistory, stable since ~2013, rmk and LinusW
> >   have one
>
> Yes, and still running:
> Linux flint 5.6.12+ #94 Sat Oct 17 23:44:28 BST 2020 armv4l armv4l armv4l GNU/Linux
>
> > * iop32x -- added in 2006, no notable changes other than my cleanup, but
> >   I think there are still users
>
> I have two TheCUS N2100s here, one still powered up and running and
> one is currently available if anyone wants the machine. Both may
> become available if anyone wants them later in 2021. I notice
> Heiner Kallweit has been patching some of this code recently.
>
> > * rpc -- prehistoric, but I think Russell still uses his machine
>
> Yes, and I have sent some patches in the 5.x timeframe, and I do
> have some further ones I could send, mostly around SCSI stuff.
> It is my only machine that gives me access to some old tape backups
> and syquest cartridges (not that any of that contains "modern" data.)
>
> > * sa1100 -- prehistoric, but rmk and LinusW sporadically working in it
>
> I also have some further patches that have been hanging around for
> some time to modernise sa1100 a bit.

Ok, that roughly all matches what I was guessing. As I wrote, I
saw most of them have been getting updates and assumed we want
to keep them, but I was not sure if any of them have come to the point
where it's no longer worth updating kernels past v5.10.y for any
reason.

     Arnd
