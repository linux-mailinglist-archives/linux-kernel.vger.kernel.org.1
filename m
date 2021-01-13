Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630EE2F4B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbhAMMSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbhAMMSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:18:54 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6548BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:18:14 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q7so1391804pgm.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9ahPQbje2YtpgJfeiSL5QGshwZQgdByQZ+Pya75CZA=;
        b=tNTCiQ7GMWzFkLEG7ORU88v39wGzGRYl9KFr3RxsiT/kZ8yHFPNarlkoMJ6e51SjQe
         Y7O6JMP99y80RKDjbTglivwznxqtotw4qFM1FdKW8PSOwydv2ZYD+3+1C5M8vdfcity6
         8gBkbKBbdujwHPmqJSI2TAXjTGbkA5MrsvY3wBy+pjYxyZGGESwMtiymUrTjH0K34C0G
         d12X2K0uhi+aBt3AJmhgr35zsVwAEUlVnVm9W1sEo41PsMOpk1/BLSKtsoF+sbYUK/Sz
         kHGFshIoPaGRjK8sBVqU8KtCjg71FLKK0Yjsw7zazNOk4i4VJUMqdQEA8Ano8ocNR3Nb
         TXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9ahPQbje2YtpgJfeiSL5QGshwZQgdByQZ+Pya75CZA=;
        b=gQtD7J/+hhWBaX4YA4Is4bHQ9ncuDRPMCZ0DcC8KLH+93zaj3dv3Aj1qWgmawlU2Ka
         GX+M5cD+Tj72kwwhdjhy4ThZIfXZjP39Kg5HGTzJCCTRrsX6Y0yyOmMzsjLL3w5gjN+A
         x0m65enVZgMS6P9Mx29crq7IQWi04klEdg7l5xnjClePbF+WkcjZGS+Eef60iRoeSqy0
         a51lfu7i76dXqGaNFPM5kRVx58cMFtgW3p0a81LiDwwOPQiWGNoCTtefN9dLzf4yNawO
         2cYZYaNenBLwnjrHaD+BJo8Vw5sR5rdA7fH1k78BXtWlSfS2h9VbK5nlKBzORDQEYSu8
         lZoA==
X-Gm-Message-State: AOAM530iicDhJVaw8tIkS/gtQ313h0Hy10ZBMRdTcgiwyfV2iIPn8UgQ
        I3QpB/eAdaH1KZmsx592zA9BqWYbqadjojNgk/M=
X-Google-Smtp-Source: ABdhPJyyTXHJ2TNL0QmMXflUHHAg5HOWiok28GMlB5NNiozRaE9LGKOGJEM26l8Uy6hfzfc9yIA8+XCmk58wESIBFV0=
X-Received: by 2002:a63:74b:: with SMTP id 72mr1873582pgh.4.1610540293878;
 Wed, 13 Jan 2021 04:18:13 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu> <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
 <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com> <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
 <CACRpkdaH-1s8DnRUPVRSQgqUE99MdWjKGLv_y6iYnXU6p4dwUg@mail.gmail.com>
In-Reply-To: <CACRpkdaH-1s8DnRUPVRSQgqUE99MdWjKGLv_y6iYnXU6p4dwUg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jan 2021 14:17:57 +0200
Message-ID: <CAHp75Ve3QqLqe2sQhNgdrDfKm2uSwXFwMr5_GgGf3tiuCp2DBQ@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@kernel.org>, Willy Tarreau <w@1wt.eu>,
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
        Viresh Kumar <viresh.kumar@linaro.org>,
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
        Yoshinori Sato <ysato@users.osdn.me>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 2:02 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jan 13, 2021 at 11:27 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jan 11, 2021 at 11:55 AM David Laight <David.Laight@aculab.com> wrote:
>
> > > basically 486 but have a few extra instructions - probably just cpuid
> > > and (IIRC) rdtsc.
> > > Designed for low power embedded use they won't ever have been suitable
> > > for a desktop - but are probably fast enough for some uses.
> > > I'm not sure how much keeping 486 support actually costs, 386 was a
> > > PITA - but the 486 fixed most of those issues.
> >
> > Right, we have "last of mohicans" (to date) Intel Quark family of CPUs
> > (486 core + few i586 features).
> > This is for the embedded world and probably not for powerful use.
>
> What is the status of PC/104?

Personally I have no idea, but...

> https://en.wikipedia.org/wiki/PC/104

...from this we learn about PC/104 consortium on site of which we may
learn about new products:
https://pc104.org/products/vcs-1-pc-104-system-for-precision-robotics-applications/

One and a half years ago, not dead to me.

-- 
With Best Regards,
Andy Shevchenko
