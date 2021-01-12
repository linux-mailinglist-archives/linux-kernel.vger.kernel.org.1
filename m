Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A1A2F260A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 03:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbhALCGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 21:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbhALCGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 21:06:51 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB252C061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 18:06:10 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id o6so782538iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 18:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=SA+ZWySdSGRKOuQ9QFJ4S4pXmYgE52dFwJbIuiWKKOc=;
        b=kw/kceOh7/102c5+8+2q4LskqQrb7/YPIqw/ZT6t7gVmYQvqwYqcH24i1uWyPIVmhV
         a3ppwSMhUpYUNz3WZxNwvnRp9YfMVZudVX10YwMrGH3OKbjD3wI3MbkFlSbVXWhK0hI9
         hnvZnljU9b6rm8oZ6P8fM88ErVlXbIGuEWnWNbg0pSkBHFY9wYNPvr4Q6uroAsvYEFIn
         HiquTwgVStHj0Fp2KZ6iAU0rbGF2acQqviOiNLOMVDdAXHqdKTGPfiecBwGrbJFXHHgb
         COO5FNGMJgThvhnibBNy3vgrh38xdsOiK8ikkMQ2jcfJbEIfAYYDhghx9/5vEe8gmmN5
         FFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SA+ZWySdSGRKOuQ9QFJ4S4pXmYgE52dFwJbIuiWKKOc=;
        b=msbdlv3YHkYucw58a6YnbQGkpIUVL4kGJEA8v0gyLjvN1Wur0Qr8G1ruBg9wwoOZlQ
         8fARa19EKJksdJDQJLriGIA6bl0zqMG/pAfgfywr7U6bVm3OwubmEXrOQ+ccJcBCTGCX
         lDYMv58yD1Yd8gTpf4NmcBTF32NOXxqK9IZu9f0MMDb1COvGylDKzCaupJeXQmAW0fBR
         fLGO7IiNr1f8zge7uKGvoWBcaXL+3Ih1LyiBVH3lHijOAuUXI53Q/G4CFYp6lQIeFcr5
         QXh6Kp8CzFBLWWBf/kop5jL4bA0aSj9SMI/121Mr5dITjqPkAsRnNadJtL4qkQ0QSnMo
         ODaA==
X-Gm-Message-State: AOAM532aLg6KPWgueDe46vnHraprCqPSObhahR2jjvwRID8qzJRwyEEI
        h3f7qqZK1BVpB3I3bzLx6zH6+0reord+uf9EkcSDxbMYk66c
X-Google-Smtp-Source: ABdhPJwRZAISa2oPkM0NmB6upeFC46GWWA8ZNT8lnFvUr3n8W4QM4Z3bsW7a9zos3y0/nrblDyDQtd4sWnSXCroYqSY=
X-Received: by 2002:a92:4101:: with SMTP id o1mr1877398ila.82.1610417170016;
 Mon, 11 Jan 2021 18:06:10 -0800 (PST)
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Mon, 11 Jan 2021 21:05:59 -0500
Message-ID: <CAP8WD_aUn4UrfNr9ROeNQ0x=xCXfS-mceUAM=fXz1n12Smmd6A@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
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

Arnd,

> * 80486SX/DX: 80386 CPUs were dropped in 2012, and there are
>   indications that 486 have no users either on recent kernels.
>   There is still the Vortex86 family of SoCs, and the oldest of those were
>   486SX-class, but all the modern ones are 586-class.

I actively use the i486DX systems for regression testing and they have
proven useful for detecting bugs in both the kernel and GCC (see
below).

I am also about to use them as testing systems for kernel programming
students. I would hate to lose this platform as a student learning
opportunity.

Here are just some of the patches that I have worked on myself:

Kernel patches i486 testing uncovered:

x86/boot: Fix another __read_cr4() case on 486
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=192d1dccbfc5b901b66527df9df80304693cf06e

x86/CPU: Change query logic so CPUID is enabled before testing
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=2893cc8ff892fa74972d8dc0e1d0dc65116daaa3

GCC patches i486 contributed to:

ibgcc calls __get_cpuid with 0 level breaks on early 486
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=a6c78ea30381cc28ea0b2cf8f0bd584a91dda948

ICE in gen_lowpart_general, at rtlhooks.c:63
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=980c8afc0961da4b4567a5abe85b6048d501a1ad

So, these systems are _quietly_ being used, and helping to contribute,
it's just not glamorous, eye-catching work.

- Matthew Whitehead
