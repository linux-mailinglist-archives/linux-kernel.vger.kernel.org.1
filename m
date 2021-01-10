Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401AD2F09E6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 22:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbhAJVeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 16:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbhAJVet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 16:34:49 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99476C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 13:34:08 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u11so1425392ljo.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 13:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwDBLOl5CVCeF0P0kwdlt2wM1kUvDpLPAJMSKBRxg9M=;
        b=O1MZL5FC+wG8LIdfmsRaBa6/thw+/g110wanUmPYu2Ronl3gKSXhlOepCDQ+s6TL2N
         xu11epSwwnwpR0Bj54+iV/ib3911s52X9WzFsGqI81Iay78IYobCO+weAiK+SbwsY3/a
         t9Pl6C3ogoeCKkHD5FIusF45oWvRd0Hlj1JKnO2WcGVMtlR8cqGBbB30f0U6UvQqaaY9
         BoW60rRmLNxfhsS/OSB6KecyuATGVVV7IwNJM3aWzGDD1d2EFAwvROE/K61qJ3+c6V1N
         8cTpm6YT70O4fpROcy1vHfMjyrCH7Yeo9dMGwCe9wazTfwm06XqA4xJpkNFVEps8Ceuj
         3Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwDBLOl5CVCeF0P0kwdlt2wM1kUvDpLPAJMSKBRxg9M=;
        b=Rny6L5G4jumSX1qM4Zugu/xY1f8oL1f09ANuYI+d5SHQcs80Y9IQCwNmODs1Dcj5XJ
         gHRe+xdfMjWOqvBoQlo7m6TgxEitHej1qtPU4ZnamYgpi38I/tRxxjHrZob4v1Jl3zuw
         5+ZWkred5XitciMWyVbDVR+bAep8FRE5Fv/7TKzNEFbO0v3sstwe7qg2vtoBQ9lxeUFx
         UzOUsgwkvB2BcpzChyRA+8gST7DDTqJrfmPPm252RW9IaqhXtenFkdMemnvcrdLxBDzc
         vZEt+IzmAswTFXit2QmB3Y8F3AOUMGRuS2HR3DedmomIJL2gcwy7JE12ctftCkN0aL7s
         7/UQ==
X-Gm-Message-State: AOAM530/RZTciwKyjpKaTP7SGVg5bGetcJ1xgrgJ7Frj5Zlq3shnlafI
        5H7MJky1DkZ58KSdobtS/htm0JTIH+yYekS0FerUfA==
X-Google-Smtp-Source: ABdhPJygTM2XUlD9axbmB+KpgakdlAh9kwrXgblXhejGBkbE8aGkF9u6DQX7GQV57RzFX+IaNT9AA+PnJGf0xvJ0BhQ=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr6350880ljj.326.1610314447060;
 Sun, 10 Jan 2021 13:34:07 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <67171E13-6786-4B44-A8C2-3302963B055F@gmail.com> <CAK8P3a0o=1KjPtp0Ah8Afe5vvG1b72+77HRFh4Z06HUGwN6+Ew@mail.gmail.com>
 <1702853.1557dWfJA4@linux-e202.suse.de>
In-Reply-To: <1702853.1557dWfJA4@linux-e202.suse.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 10 Jan 2021 22:33:56 +0100
Message-ID: <CACRpkdYaMASWWDTX7hTt+xQnVPA=WTWNFk2eDnTjKoJF=LA7LQ@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Fabian Vogt <fabian@ritter-vogt.de>
Cc:     Daniel Tang <dt.tangr@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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

On Sun, Jan 10, 2021 at 7:16 PM Fabian Vogt <fabian@ritter-vogt.de> wrote:
> Am Samstag, 9. Januar 2021, 23:20:48 CET schrieb Arnd Bergmann:
> > On Sat, Jan 9, 2021 at 1:06 AM Daniel Tang <dt.tangr@gmail.com> wrote:

> > > * nspire -- added in 2013, no notable changes after 2015
>
> Most of the platform is just the DT sources and some small drivers around it,
> so it's actually fairly low maintenance. So far the migration away from
> panel-simple in 2019
> (https://lore.kernel.org/linux-arm-kernel/20190805085847.25554-1-linus.walleij@linaro.org)
> was the biggest required change so far.

What we're seeing here is actually a port that is:
- Finished
- Has a complete set of working drivers
- Supported
- Just works

I.e. it doesn't see much patches because it is pretty much perfect.

We are so unused to this situation that it can be mistaken for
the device being abandoned.

I think it was Russell who first pointed out that this is actually
the case for a few machines.

> > Would either of you already have a guess for how long it makes
> > sense to update kernels on it?
> >
> > I see that this is one of the more limited platforms with just 32MB
> > of RAM (64MB in case of CX), and kernels only get more bloated over
> > time, so I expect at some point you will be stuck with running old
> > software.
>
> The kernel overhead isn't actually that bad. I just built today's 2ff90100ace8
> and booted it with a busybox-based initrd. free -m reports:
> total used free shared buffers
>    58   12   46      0       0
>
> Relatively speaking, still mostly unused ;-) The stock OS actually uses more!
> With 32MiB, the situation is definitely worse, but still manageable. Should
> that change in the future, dropping just the Classic/CM variants would be a
> possible option, but that still seems far enough away.

64 MB is perfectly fine to run Linux. OpenWrt-type distributions (also
OpenEmbedded/YOCTO) run just fine with that. 32 MB certainly works.
For example this is the Gemini D-Link DNS-313 which is my NAS
and works perfectly on 64MB:

root@DNS-313:~# free -m
              total        used        free      shared  buff/cache   available
Mem:          56136       21032       28612           0        6492       23812
Swap:        131128        1280      129848

Not even using the fallback swap.

I can add that at the time it is syncing a backup AND playing back
a 1080p movie over SMB. The trick is using ksmbd rather than
Samba. ksmbd is much less memory-intensive.

I like to use this device for NAS since it is good at I/O, stable,
maintained by myself and JustWorks(TM).

Yours,
Linus Walleij
