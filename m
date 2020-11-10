Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5092AE1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbgKJVfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:35:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJVfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:35:32 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 022BE2074B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 21:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044132;
        bh=ttwuWSL7bQX3ZiTCFdG/qTiwhfcSq07Wu6lKeQu2TjU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p0q11j1nr8QXpkwyEOL7feW0NPv6VqGiy5ZoDlRVm5sCHC6Vi4ziJJbeFsi3BsecN
         DzFlC8bk5YuxSc0lGLnavS9VQmMjoKpia/K2mBU5DQe64PNeyp1PkMT5HXOx0CJUka
         9rnqkyfyucgIFOfypVKvmjaZtAxncFSytjwW8p0c=
Received: by mail-ot1-f46.google.com with SMTP id g19so116862otp.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:35:31 -0800 (PST)
X-Gm-Message-State: AOAM530a11ykdhhihzFp1zXFHOsU6LsT3wFcWWmlFMyUkPrVgo12M1rK
        iJ3ubgt8ezGjcHjRE0lSWwsCnTLHLoJhFx9yCDY=
X-Google-Smtp-Source: ABdhPJzMNowRak8oZ0DwWdHuN4b0ZePrBOwqgxOwJ9Ef4kB0mBcR7HSi/aHmQUjM7UXyjppnG3ENZJZunKWd3iXv2EE=
X-Received: by 2002:a9d:62c1:: with SMTP id z1mr14939625otk.108.1605044131223;
 Tue, 10 Nov 2020 13:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <20201107001056.225807-1-jiancai@google.com>
 <CAMj1kXG+qb267Hig6zoO=y6_BVsKsqHikvbJ83YsBD8SBaZ1xw@mail.gmail.com>
 <CAKwvOd=pHgT3LsjYH10eXQjLPtiOKDj-8nJwjQ=NMSFLTG1xAg@mail.gmail.com>
 <CAMj1kXHDzj3Q-sCv1szseUC7g2bWRFeVP6WME-sMqDf+0wyU8Q@mail.gmail.com>
 <CAKwvOdkXz5wOwKQDsi5jt21ov3xETSByAqxGLQ=7U6Gsp46zcQ@mail.gmail.com>
 <CA+SOCLJSSR62VfWhKx9R1cxT-CHXD7RN08eJBYxUH8zzyWos9Q@mail.gmail.com>
 <CAKwvOdkpHdQF9Ko8FbP_SN=QfDiMq8ra5TSj_KHGRCbJdyYm6w@mail.gmail.com> <CAK8P3a1tU8g4HfsoYH4qa6C4Kv8QE3nv=UPSyH7824GXCYwUDQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1tU8g4HfsoYH4qa6C4Kv8QE3nv=UPSyH7824GXCYwUDQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 10 Nov 2020 22:35:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFzECLh2kNWW8Pheu6AvTFqN+t4KO3-iSgxyZKHJNjAjw@mail.gmail.com>
Message-ID: <CAMj1kXFzECLh2kNWW8Pheu6AvTFqN+t4KO3-iSgxyZKHJNjAjw@mail.gmail.com>
Subject: Re: [PATCH v2] Make iwmmxt.S support Clang's integrated assembler
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jian Cai <jiancai@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 at 21:38, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Nov 10, 2020 at 9:11 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Tue, Nov 10, 2020 at 12:10 PM Jian Cai <jiancai@google.com> wrote:
> > >
> > > I tried to verify with ixp4xx_defconfig, and I noticed it also used CONFIG_CPU_BIG_ENDIAN=y to enable big endianness as follows,
> > >
> > > linux$ grep ENDIAN arch/arm/configs/ixp4xx_defconfig
> > > CONFIG_CPU_BIG_ENDIAN=y
> > >
> > > Also it appeared arch/arm/kernel/iwmmxt.o was not built with ixp4xx_defconfig. The commands I used
> > >
> > > linux$ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make CC=clang ixp4xx_defconfig
> > > linux$ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j32 CC=clang
> > > linux$ ls arch/arm/kernel/iwmmxt.o
> > > ls: cannot access 'arch/arm/kernel/iwmmxt.o': No such file or directory
> > >
> > > Did I miss any steps?
> >
> > Yes, you need to manually enable CONFIG_IWMMXT in menuconfig or via
> > `scripts/configs -e`.
>
> To clarify: ixp4xx and pxa3xx were two platforms based on the XScale core.
> ixp4xx was commonly used in big-endian mode but lacked iWMMXt. pxa3xx
> had iWMMXt but doesn't allow enabling big-endian mode because of a Kconfig
> dependency, meaning that nobody has ever tried it, and it's likely broken.
>
> Later 'mvebu' parts (Armada 510) do have iWMMXt and allow big-endian
> mode, but those are BE8, with non-reversed byteorder for the instructions.
>
> So none of this matters in practice, but it's very satifiying to know
> it is finally
> all working with the integrated assembler in all those combinations, at
> least in theory!
>

Thanks for the perspective. I wasn't aware of all these details, but I
just wanted to confirm that .inst works as expected in all
configurations.
