Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E512DE9A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 20:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbgLRTNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 14:13:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgLRTNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 14:13:35 -0500
X-Gm-Message-State: AOAM532UgAu0tVw4M6pOGtvK3lDCkRCFksPs+hbL+9p5dMhZxBFPGr53
        8rwYeQF4bARnFadghE8Dutcdw2a5WRjwMsvVIK8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608318775;
        bh=M3XYsoe56BnAgHbgckjNbYBGqy/lUNDgoENvpoooxrA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GlK57PJLJsGhyMtfhl7r2bs1SnnefOO88mACbcLCTRriFY6JwEl4yGkV/UP1Mrz/q
         orouY8/PuVpTgtm/uQyve7CQW4/oGhVFZF9No6c0C6FNmqjCVc8V360lU2Op8urge7
         kaG58LMfpqUemT4STBqLltQ5IaBPDVZ7QwIEOOTIctW5HbKBRjHwywHdV8tWQtAArT
         PY92aYo9UDBJ/Y2JKPy3B8jVg8DecJG3skYy2d3eikbaiqP3ZomNV+j1lgegmOmrJx
         S0Zk/s9pFFjFLfL/IPW0m4WV1rjK4ccabi3hhiCQySs38E1tL3WdCUxN07zHpnsPSs
         0mjg2Ez3mgqhQ==
X-Google-Smtp-Source: ABdhPJzmEA6SHX9befzguH8deKoV62VBJPf9tAN12iAj+5uYuBRc7SISI6JDsquvjca1i87CSn7K1/YS75fCwi9UFhQ=
X-Received: by 2002:aca:d98a:: with SMTP id q132mr3827949oig.33.1608318774271;
 Fri, 18 Dec 2020 11:12:54 -0800 (PST)
MIME-Version: 1.0
References: <5fdc89c3.1c69fb81.c9707.68bb@mx.google.com> <3e1680ed-94b8-74c9-ffe6-c2bd71f2a705@collabora.com>
 <20201218140018.GZ1551@shell.armlinux.org.uk> <CAMj1kXH-z91_EOpw8_5DCm22DiaU7FxzsCMmWV3-4=uM-FCM1g@mail.gmail.com>
 <CAMj1kXGnLCwXFRJAcmgLxRq6LXH5pyi1T8d0_5DPur4ez7yAPQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGnLCwXFRJAcmgLxRq6LXH5pyi1T8d0_5DPur4ez7yAPQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 18 Dec 2020 20:12:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFidG0sOVqxPkP6TbWJy4cE-x9t7RxRsQ7sQfb1-TUEqQ@mail.gmail.com>
Message-ID: <CAMj1kXFidG0sOVqxPkP6TbWJy4cE-x9t7RxRsQ7sQfb1-TUEqQ@mail.gmail.com>
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

On Fri, 18 Dec 2020 at 20:12, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 18 Dec 2020 at 15:01, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 18 Dec 2020 at 15:00, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Fri, Dec 18, 2020 at 01:48:09PM +0000, Guillaume Tucker wrote:
> > > > Please see the bisection report below about a boot failure on
> > > > ox820-cloudengines-pogoplug-series-3.  There was also a bisection
> > > > yesterday with next-20201216 which landed on the same commit, on
> > > > the same platform and also with oxnas_v6_defconfig.  I'm not
> > > > aware of any other platform on kernelci.org showing the same
> > > > regression.
> > >
> > > Ah, I bet I know what's happening.
> > >
> > > We test for the presence of VFP by issuing an instruction to read
> > > FPSID. If VFP is not present, this will raise an undefined instruction
> > > exception, and we expect to head into the vfp_testing_entry code.
> > >
> > > I bet Pogoplug, being an ARM11 MPCore platform, either raises an
> > > exception here.
> > >
> > > We probably need to also rework the code in vfp_init() as well to
> > > register a temporary hook when reading the FPSID.
> > >
> >
> > Thanks for diagnosing that - I wasn't quite sure what was going on.
> >
> > I will look into this later today.
>
> Working again with my fix applied:

https://kernelci.org/test/plan/id/5fdcebf1a6350e2bd1c94cd3/

I'll drop it into the patch system tomorrow (unless there is a
pressing need to do it earlier)
