Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5DF2F4AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbhAMMDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbhAMMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:03:15 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E888EC061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:02:34 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id m10so2260862lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biav/OGJ1AqNN5vKT9LXYu4evCRBaP34li8Uk403On8=;
        b=ZdkvNIknLKDpptiFDCF6ktEBbv8J8NBGZIkml0bBmGrhzRLdLI7+wTOvo8GzZA9d2/
         EnC031LhCbDK+RVvdDs8RQfH2h05l6saC/U5y5QAYnGp3WM3lnfcyyBSlMHpUk1y9CqW
         gEd6AJrzhHSOiwPzUieAqfS68/6RwQnnD4RIf5HTEidr5SUOaph6ynhLkUMk5ssf7T4x
         Dfm2RZOXEeydnwoX8nnrW0sEobdhb0kRVljBMlp0x+nDZOODsF4xMQalNb/2d/VNtx79
         BWkl3bv81pj+V6peVoyxYdvM/UnnOqykOe7/csWr8pFwu/+Wi9vwRBC5m9UdilM8iFQD
         mPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biav/OGJ1AqNN5vKT9LXYu4evCRBaP34li8Uk403On8=;
        b=FpJM2yTLCR/SorfC5Pc168xcnVxAD0hwkFpig1x7kujcjqNLmfR9Rw4tXJNfjF9msk
         NFGGJwhNHG8qSAdE4mhzymSE+AhqMKnfNGze7M2O9fLcbeOa2iaDeOYYZWeprD7Dl7X0
         qCR03foDhPmwfDBvJ2KmwhRxxvJmiPHCEKDrbWgp8ZuzbTdRO5cHLi12HZwgcSv8XmP5
         52tD19eIN27ZitBTvx+Jq/q79H5+vKGeij3hUmYaoAPnVBqcZe+ncVXNGd3lXd4Bf122
         hJLzZy9vZHRAlhfLlTeUxQlOkkl4eq5Lj8nTXMvV9as3lHI/QtdPSP0GG57zvgqOjKuA
         /G5A==
X-Gm-Message-State: AOAM532wcjECwM1JILDIcMHBHu8GzKjJTmOvpy0SawWy2gbMzPPV3sLf
        i2CWtmfKlkxmZuWHyuMGvKj7Uj9DAXnGzZ6aMUo5IA==
X-Google-Smtp-Source: ABdhPJz2BTpLqXN69JXGylCi0jLqdXwjPBhLWpbeKJ7f6zCyyNYn5LX9wIyjGExoNYGWfwIiP2h+ipLEVy94WBL5Ij0=
X-Received: by 2002:a2e:3503:: with SMTP id z3mr866790ljz.74.1610539353417;
 Wed, 13 Jan 2021 04:02:33 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <20210109055645.GA2009@1wt.eu> <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
 <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com> <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
In-Reply-To: <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Jan 2021 13:02:20 +0100
Message-ID: <CACRpkdaH-1s8DnRUPVRSQgqUE99MdWjKGLv_y6iYnXU6p4dwUg@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
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

On Wed, Jan 13, 2021 at 11:27 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jan 11, 2021 at 11:55 AM David Laight <David.Laight@aculab.com> wrote:

> > basically 486 but have a few extra instructions - probably just cpuid
> > and (IIRC) rdtsc.
> > Designed for low power embedded use they won't ever have been suitable
> > for a desktop - but are probably fast enough for some uses.
> > I'm not sure how much keeping 486 support actually costs, 386 was a
> > PITA - but the 486 fixed most of those issues.
>
> Right, we have "last of mohicans" (to date) Intel Quark family of CPUs
> (486 core + few i586 features).
> This is for the embedded world and probably not for powerful use.

What is the status of PC/104?
https://en.wikipedia.org/wiki/PC/104

I have three GPIO drivers for PC/104 machines and these are for
embedded industrial usecases. I am curious about what CPUs these
beasts run on in practice? Are they getting upgraded?

Paging William, I think he work on these daily.

Yours,
Linus Walleij
