Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0EF2B8811
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgKRXFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKRXFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:05:40 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030E1C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 15:05:58 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id s2so1851656plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 15:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pK9Er3U8wzUpc5Ph5vwpd9eRfxvPgKOSxbNh1R/cIyQ=;
        b=qBtqEPVu57Elst2R12JNUW2yDdqme72UJq+j8B0KRMqaTWXE4Jb1RBA0uBEPC+4gUC
         cwNzl/PBwFYa9lfSCljv6SI+9YLvJMAcAKQcf6332IEIGFx1bEyB4t843r3loVTouYCp
         EBHO4763PSurh/yifzv5CkiyWsX0GIot99a3ebjYWhIaP+pJf9JTpCnZzl8MYI9WDwFG
         OMufIi9lNxEy0cLWZxlOh/WB5GlWXES1d7XwB75xaVa+bsosmHlEG6ddnN4dnjZLgt82
         e1LLxc1B9mN0WtxIB00A8ae/+yjvn6BeKYjEAtIMCqcJ3G9dlk89fKRWfIG8JcYCVn8u
         3k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pK9Er3U8wzUpc5Ph5vwpd9eRfxvPgKOSxbNh1R/cIyQ=;
        b=eJbhLwvZtlSdxCA4iyKqE4blfhTzlaiBADVYxQTgkhohPclTlPpGcLj7TEOBBX0aIf
         92bBxPJFeVbq2jxf+RLjeK6mvA2FS1pZOazFY1fi6ibYISsGIpNYsmOXVNA9kZ/Uh3d4
         G/aapi3YNekPwd/+JMCXL8tDJXIBASXpLzz1X3bJrIlfSIet4QE48l7fv8trFMQuI0Kt
         +G2DGcqzZxffZp4DzQ94cF24TfRLmEmJXc3eTdeZvK5PCS85KTN4aIu1UGkBfcMdVlp0
         3X86x/YOFYMIp2pnJak2xmefPg+bUBGl7UGG/dALkzEEZ03Ra988XCB7zQ387LCTGLil
         Nqbw==
X-Gm-Message-State: AOAM532yOFL5TZ+2iD0YaWpRh2cnYyHez/xokHxs/Tcrv5+y6WEXdjv+
        eiVXY9oTz3A/XrHtyOXtohqj/PcO5hyuCB7iw2UGDQ==
X-Google-Smtp-Source: ABdhPJx1KDsDxRgKYnaY8s7A1LaCEAgZ3k75SP2XAXWwuKK+TgoYSXGDwJEdbrp/TZpc04v4UBtcYvQauYdJ5LEX4To=
X-Received: by 2002:a17:902:221:b029:d8:f938:b112 with SMTP id
 30-20020a1709020221b02900d8f938b112mr6374426plc.10.1605740757172; Wed, 18 Nov
 2020 15:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20201112183839.1009297-1-natechancellor@gmail.com>
 <CAKwvOdkShrqgNDWO0bsPcPZLx-+u79mfmPrGy7CnSKZVdcYzSA@mail.gmail.com>
 <20201113005347.GA3625030@ubuntu-m3-large-x86> <CAMj1kXHYG7d-BDtbZ-4+wGdHb0rxXiMLuSvSMW_JFHgp3G6kTg@mail.gmail.com>
 <CAKwvOdk1ir=D---9xVAxcErJWSGVxK1Mv6AC=TK3RVwNdcvFjw@mail.gmail.com>
In-Reply-To: <CAKwvOdk1ir=D---9xVAxcErJWSGVxK1Mv6AC=TK3RVwNdcvFjw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 18 Nov 2020 15:05:45 -0800
Message-ID: <CAKwvOdnauFdUgS0Ww=O-PHrXWhXQEEYd806NUcy8_7MOG0Uo2g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Always link with '-z norelro'
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Abbott Liu <liuwenliang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jian Cai <jiancai@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Dan Rue <dan.rue@linaro.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:34 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Nov 12, 2020 at 10:06 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 13 Nov 2020 at 01:53, Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Thu, Nov 12, 2020 at 04:44:46PM -0800, Nick Desaulniers wrote:
> > > > On Thu, Nov 12, 2020 at 10:41 AM Nathan Chancellor
> > > > <natechancellor@gmail.com> wrote:
> > > > >
> > > > > Commit 3bbd3db86470 ("arm64: relocatable: fix inconsistencies in linker
> > > > > script and options") added '-z norelro' to the arm64 Makefile when
> > > > > CONFIG_RELOCATABLE was set to help support ld.lld because ld.lld
> > > > > defaults to '-z relro' but the kernel does not use program headers or
> > > > > adhere to the section layout that is required for RELRO to work.
> > > > >
> > > > > Commit 3b92fa7485eb ("arm64: link with -z norelro regardless of
> > > > > CONFIG_RELOCATABLE") unconditionally added it to LDFLAGS_vmlinux because
> > > > > an error occurs with CONFIG_KASAN set even when CONFIG_RELOCATABLE is
> > > > > unset.
> > > > >
> > > > > As it turns out, ARM experiences the same error after CONFIG_KASAN was
> > > > > implemented, meaning that '-z norelro' needs to be added to that
> > > > > Makefile as well (multi_v7_defconfig + CONFIG_KASAN=y + LD=ld.lld):
> > > > >
> > > > > $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- LLVM=1 zImage
> > > > > ld.lld: error: section: .exit.data is not contiguous with other relro sections
> > > > >
> > > > > To avoid playing whack-a-mole with different architectures over time,
> > > > > hoist '-z norelro' into the main Makefile. This does not affect ld.bfd
> > > > > because '-z norelro' is the default for it.

Fangrui pointed out off list that this might need an ld-option wrapper
for older versions of GNU binutils.  Dan was showing me some build
logs today, and I thought I spotted such warnings about `-z norelro
will be ignored`.
-- 
Thanks,
~Nick Desaulniers
