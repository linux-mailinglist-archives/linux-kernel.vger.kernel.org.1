Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAEC2F1258
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbhAKMd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbhAKMd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:33:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89F0F22AAF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610368395;
        bh=yXKODVd5TEykAAHQEUTv6Lm1lMaSuUtCpmCOou3eymQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PnjnHhKW4LH8QVex919JalF9HdZb30dCk/UUEbYm5nMt0D0PflszGL2OytxaMu89k
         KaxUpJGNWxI+90fOJE2C4Mg70ti7qMx4j/csMhJ2OkcpnlmR2bx9RDet/6paGPPUCc
         S/Xi8S4zb6Yl4M5fLxkCvkJ8wLioDM2dRRMpsoWQ5128uwvM6lSD0L6Y9XAhUs5OKV
         cL+qRkpGsXXpZiddHZKc5Ajpb6NBYrRGxMnUfXgquQH+RYjCIEgDgMr8QqHnX63opT
         RQQVNId6AD1hvtqqh1coI9z+hO4x5HH1pTRJfDnd3QiXAUUMWyUYsKhxFGsM7tiPVn
         KMK/iJgpzM2ag==
Received: by mail-oi1-f170.google.com with SMTP id s2so19952873oij.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:33:15 -0800 (PST)
X-Gm-Message-State: AOAM532K0VEKXsoAI/0H9gYKYedc8QbX014B0HUKoj1s94ctgEHrhpjy
        K9jiGW+VCTpWudkTYz5wPKFZv1Qs0GGx47qO7l4=
X-Google-Smtp-Source: ABdhPJwg0xCZhOMudD1jN7Qzr5yMYHVlTwVmqGCcjFEU/lh7xdcaeMJ07+Dk8nP/y61I2n4L4OA27cjMHbngG1WAzMI=
X-Received: by 2002:aca:44d:: with SMTP id 74mr10251000oie.4.1610368394083;
 Mon, 11 Jan 2021 04:33:14 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <67171E13-6786-4B44-A8C2-3302963B055F@gmail.com> <CAK8P3a0o=1KjPtp0Ah8Afe5vvG1b72+77HRFh4Z06HUGwN6+Ew@mail.gmail.com>
 <1702853.1557dWfJA4@linux-e202.suse.de> <CACRpkdYaMASWWDTX7hTt+xQnVPA=WTWNFk2eDnTjKoJF=LA7LQ@mail.gmail.com>
 <20210111003320.GQ1551@shell.armlinux.org.uk>
In-Reply-To: <20210111003320.GQ1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 11 Jan 2021 13:32:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3C0mWHm+7GvtK92Nw0unZ8NTViXUVd_QysYgot8tuM7A@mail.gmail.com>
Message-ID: <CAK8P3a3C0mWHm+7GvtK92Nw0unZ8NTViXUVd_QysYgot8tuM7A@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Mark Salter <msalter@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 1:33 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Sun, Jan 10, 2021 at 10:33:56PM +0100, Linus Walleij wrote:
> > On Sun, Jan 10, 2021 at 7:16 PM Fabian Vogt <fabian@ritter-vogt.de> wrote:
> > > Am Samstag, 9. Januar 2021, 23:20:48 CET schrieb Arnd Bergmann:
> > > (https://lore.kernel.org/linux-arm-kernel/20190805085847.25554-1-linus.walleij@linaro.org)
> > > was the biggest required change so far.
> >
> > What we're seeing here is actually a port that is:
> > - Finished
> > - Has a complete set of working drivers
> > - Supported
> > - Just works
> >
> > I.e. it doesn't see much patches because it is pretty much perfect.
> >
> > We are so unused to this situation that it can be mistaken for
> > the device being abandoned.
> >
> > I think it was Russell who first pointed out that this is actually
> > the case for a few machines.
>
> Yes indeed. I find it utterly rediculous that there is a perception
> that you constantly need to be patching a bit of software for it to
> not be seen as abandoned. If a piece of software works and does what
> it needs to do, why does it need to be continually patched? It makes
> no sense to me.

I don't know where you got the impression that this is what I
want to do. I used this as a first approximation because it reduced
the number of platforms to look at from 71 to under 20, just by
looking at what patches went into the kernel. I could further get the
number down to the 14 platforms listed in this email by knowing
some of the users of platforms that did not see a lot of updates but
are well supported, like highbank or dove.

We have already confirmed axxia, digicolor, kona and nspire
as platforms that we want to keep for now, and a new volunteer
to maintain axxia, and I did not get the impression that any of
the maintainers were overly stressed out by being sent an
email inquiry five years after the last contact. I would prefer
an occasional Tested-by tag for the cleanup patches that did make
it in (yes, I counted those as activity), but I understand that
everyone is busy and these are low-maintenance platforms.

> I have my xf86-video-armada which I use on the Dove Cubox and iMX6
> platforms. It does what I need it to, and I haven't updated the
> userspace on these platforms for a while. Therefore, I've no reason
> to patch that code, and no one has sent me patches. Does that mean
> it's abandoned? Absolutely not.

I listed the dove platform in the first table specifically because the
plan back in 2014 was to completely remove the platform once that
hardware is working with the modern mach-mvebu platform, and
I hoped that the transition had finished by now.

      Arnd
