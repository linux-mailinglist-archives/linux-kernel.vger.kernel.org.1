Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8532AD088
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgKJHgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgKJHgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:36:11 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A531D2080A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604993770;
        bh=SywJL0OWB8D8wbkNu7717xgFNVjoh9tformafpK+9AY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OR/fFoSXTlsuizgoyetJwe0P5JYi2LfWR8vx+jfQ+mA8XhDNN6pskhk7WpPrnylvc
         d4dtO0GW/XXMCzjaxNpRZNCDo1T00AF+zZ0UKkVx9Cq7lxqxvVCv75Pw2Kl6FwnCeL
         wFhJ+sYT3zjb0lYsJzTwp8mqXvR1D/9c0hMACI1Q=
Received: by mail-ot1-f53.google.com with SMTP id z16so11616902otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 23:36:10 -0800 (PST)
X-Gm-Message-State: AOAM530JJ0EsfS4J6z1tizJttoDA4/ZbzcAg1Ylm5d+03q0hfjD33k7V
        AHkm9NZ2LeVfBPzdjmlCmsgsMRdz6EUilz1mGtc=
X-Google-Smtp-Source: ABdhPJz23enoW+9NvW7HSDcAH0mTBaBe9X0MisI0iv8pxkv4uXFamMZsL32hvnwJX1eeH/cZ1m4/Pc/OyT5q9ohgO4g=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr3941559otd.90.1604993769849;
 Mon, 09 Nov 2020 23:36:09 -0800 (PST)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <20201107001056.225807-1-jiancai@google.com>
 <CAMj1kXG+qb267Hig6zoO=y6_BVsKsqHikvbJ83YsBD8SBaZ1xw@mail.gmail.com> <CAKwvOd=pHgT3LsjYH10eXQjLPtiOKDj-8nJwjQ=NMSFLTG1xAg@mail.gmail.com>
In-Reply-To: <CAKwvOd=pHgT3LsjYH10eXQjLPtiOKDj-8nJwjQ=NMSFLTG1xAg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 10 Nov 2020 08:35:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHDzj3Q-sCv1szseUC7g2bWRFeVP6WME-sMqDf+0wyU8Q@mail.gmail.com>
Message-ID: <CAMj1kXHDzj3Q-sCv1szseUC7g2bWRFeVP6WME-sMqDf+0wyU8Q@mail.gmail.com>
Subject: Re: [PATCH v2] Make iwmmxt.S support Clang's integrated assembler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jian Cai <jiancai@google.com>, Manoj Gupta <manojgupta@google.com>,
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

On Tue, 10 Nov 2020 at 02:55, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Sat, Nov 7, 2020 at 12:29 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Sat, 7 Nov 2020 at 01:11, Jian Cai <jiancai@google.com> wrote:
> > >
> > > This patch replaces 6 IWMMXT instructions Clang's integrated assembler
> > > does not support in iwmmxt.S using macros, while making sure GNU
> > > assembler still emit the same instructions. This should be easier than
> > > providing full IWMMXT support in Clang.
> > >
> > > "Intel Wireless MMX Technology - Developer Guide - August, 2002" should
> > > be referenced for the encoding schemes of these extensions.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/975
> > >
> > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > Signed-off-by: Jian Cai <jiancai@google.com>
> >
> > Please make sure you test this carefully on BE32, as the instruction
> > byte order used by .inst is LE IIRC
>
> Unless that was a recent-ish change in GAS, it looks like I get the
> same disassembly/encodings before/after this patch for
> CONFIG_BIG_ENDIAN with GNU as.
>
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make CC=clang -j71 defconfig
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make CC=clang -j71 menuconfig
> <enable CPU_BIG_ENDIAN>
> $ grep BIG_ENDIAN .config
> CONFIG_CPU_BIG_ENDIAN=y
> CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make CC=clang -j71
> arch/arm/kernel/iwmmxt.o
> $ arm-linux-gnueabi-objdump -dr arch/arm/kernel/iwmmxt.o > gas_before.txt
> $ b4 am https://lore.kernel.org/lkml/20201107001056.225807-1-jiancai@google.com/
> -o - | git am
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make CC=clang -j71
> arch/arm/kernel/iwmmxt.o
> $ arm-linux-gnueabi-objdump -dr arch/arm/kernel/iwmmxt.o > gas_after.txt
> $ diff -u gas_before.txt gas_after.txt
> $ echo $?
> 0
>
> (Orthogonal, it looks like llvm-objdump has issues decoding
> elf32-bigarm that we'll need to fix.)
>
> Either way the patch LGTM for IWMMXT, thanks Jian for the patch and
> Ard for the suggestions.
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>


BE32 != BE8

Please use, e.g., ixp4xx_defconfig with IWMMXT and BE enabled. It
seems like .inst does the right thing here, i.e., the assembler knows
that it should emit BE for BE32 and LE for BE8, but it needs to be
confirmed.
