Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC0C2DE9A0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 20:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbgLRTMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 14:12:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732969AbgLRTMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 14:12:47 -0500
X-Gm-Message-State: AOAM531w/AVn/JOAraZA2uzhyPB754cq8l7A/6ATQGvAYVhaijY2XG9p
        GIn809jJkAQPVsIb2lkYijtbW+tPZMA2+NiiurY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608318737;
        bh=URaSneZyJ5V1zt1qyhgBSKobWWAmbXcUNROkoAPm0b4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=btIBaPqtRcANPLErHvNsY9N2/x5ew3Pg6Ya3J5Ujasx4y46mAxZjt/eSotYw5izUA
         O6KezxX5Xs6WCDS+FtkJZEhuEfn3RHmeg5xclpsWo5AuAfJ/BUBih4LoXWteX45sfA
         cjZ+Z7LZuYIMB0LQFzOysNGdnkMPw5TjhuJ5EJI7lwML208y/3adFJ+rC4kRQ/T7t/
         mV65y3WzEWnhPmKhxgNy+KFcZrWYaRQYwTD16ZBC6g7ZFtS2EFgabbVwHNcpaJA+/C
         E0dIwiYY4uQisMl6mwajvrdhdyCTtygltnY3VWuzyANzca1tesrBCQ3F15ASVZEEKI
         LCoAvikigGKXQ==
X-Google-Smtp-Source: ABdhPJw6DkAMltlKAmiO5rFpS6nrrQsu9eZX3emJ6MKuCHbhn64wWODVNnE7HBG4Ri1YBxD4BpZsfWGKRZaUFMoPzdY=
X-Received: by 2002:aca:dd03:: with SMTP id u3mr3866250oig.47.1608318736292;
 Fri, 18 Dec 2020 11:12:16 -0800 (PST)
MIME-Version: 1.0
References: <5fdc89c3.1c69fb81.c9707.68bb@mx.google.com> <3e1680ed-94b8-74c9-ffe6-c2bd71f2a705@collabora.com>
 <20201218140018.GZ1551@shell.armlinux.org.uk> <CAMj1kXH-z91_EOpw8_5DCm22DiaU7FxzsCMmWV3-4=uM-FCM1g@mail.gmail.com>
In-Reply-To: <CAMj1kXH-z91_EOpw8_5DCm22DiaU7FxzsCMmWV3-4=uM-FCM1g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 18 Dec 2020 20:12:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGnLCwXFRJAcmgLxRq6LXH5pyi1T8d0_5DPur4ez7yAPQ@mail.gmail.com>
Message-ID: <CAMj1kXGnLCwXFRJAcmgLxRq6LXH5pyi1T8d0_5DPur4ez7yAPQ@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on ox820-cloudengines-pogoplug-series-3
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci-results@groups.io,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernelci@groups.io" <kernelci@groups.io>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 at 15:01, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 18 Dec 2020 at 15:00, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Dec 18, 2020 at 01:48:09PM +0000, Guillaume Tucker wrote:
> > > Please see the bisection report below about a boot failure on
> > > ox820-cloudengines-pogoplug-series-3.  There was also a bisection
> > > yesterday with next-20201216 which landed on the same commit, on
> > > the same platform and also with oxnas_v6_defconfig.  I'm not
> > > aware of any other platform on kernelci.org showing the same
> > > regression.
> >
> > Ah, I bet I know what's happening.
> >
> > We test for the presence of VFP by issuing an instruction to read
> > FPSID. If VFP is not present, this will raise an undefined instruction
> > exception, and we expect to head into the vfp_testing_entry code.
> >
> > I bet Pogoplug, being an ARM11 MPCore platform, either raises an
> > exception here.
> >
> > We probably need to also rework the code in vfp_init() as well to
> > register a temporary hook when reading the FPSID.
> >
>
> Thanks for diagnosing that - I wasn't quite sure what was going on.
>
> I will look into this later today.

Working again with my fix applied:
