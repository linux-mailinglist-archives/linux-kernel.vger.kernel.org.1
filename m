Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B902ACAC7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgKJBzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKJBzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:55:54 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411C9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 17:55:53 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c20so9948132pfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 17:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1en5VjSPjbMPhawIIcRIlXt+Lt4izcOc7t6s2LqN7Q=;
        b=mJgpiuAk/LXqIpi7OXNbBVM23srYhWn/WrR/27ZAxqPogfEifGl+gVDX7HrzP02ffK
         WHkX5uOW/GGENK4m2YDZW6/3FKOu9mSCQrNIWNpqmJetMhw/3ctugW6UwkA5YkkAl30s
         cBXYzY3Un3D8OeT7BcIvdLOjaogNtcqCUQgvAA63W8TEszBNTvwAPUDr25/gE8RDl5UM
         ZEQXIEBxqgAt2KHYYstu3mvbzzH3mygheJTGtClh9mlvzBFHC7GEd2UKv4Y3GfR1bXX/
         87rmYvSNWHmNdQ3CNEGtFshXSRWqtKZrtxLimx2v/7eVSe8BVDCWEH6FiuI6EejjqA33
         2v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1en5VjSPjbMPhawIIcRIlXt+Lt4izcOc7t6s2LqN7Q=;
        b=j916JcXqg8enG50rPXa/lzAP0TRQUa2QUGw70BMlhw+d+23ZBOqplgC5/CeElZEhK7
         hhUODSwSx54aQRkt1Ez1gWWCpPRIlIxFhlHeoMllBxyKhjtY0sKIkcmRiW9LHkUVGOtP
         4CutxV0gbyVaEtAwrpb0Sc/QtEgkyEMkPit9Gb00lJrVJpmTfesjcQSOI4D9O5OzgNFr
         U4okxCZg9QwhHoQzVk9DGfN7dpJ0srbY+yA+OI3mXaia+ThgietjbTt2+TPe0cWjGVYz
         fXFg0Ja7SoM15+u4oLshOAbSNI3M+ueMmTkEn7aAEk+c2MOSzVJjpLwln7o6MjK0mLpe
         CCvA==
X-Gm-Message-State: AOAM531rfQlSKSXECmpBCFUQ0yZN3zAySTzwPVPC/xy7as5Vh0ktetkU
        y+lx3sbd6K7ksdqzTRT57VKgw5c9X/wpC0LJSNAdtA==
X-Google-Smtp-Source: ABdhPJxjZ02jGzfuyRScXKwzi9zaxMiWV+n087kdRAervyAPm8llGHicBZxtZlxbTa8vg4x7tBWy2cNQM6IixZBZtyY=
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr2331926pjj.101.1604973352482;
 Mon, 09 Nov 2020 17:55:52 -0800 (PST)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <20201107001056.225807-1-jiancai@google.com>
 <CAMj1kXG+qb267Hig6zoO=y6_BVsKsqHikvbJ83YsBD8SBaZ1xw@mail.gmail.com>
In-Reply-To: <CAMj1kXG+qb267Hig6zoO=y6_BVsKsqHikvbJ83YsBD8SBaZ1xw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Nov 2020 17:55:41 -0800
Message-ID: <CAKwvOd=pHgT3LsjYH10eXQjLPtiOKDj-8nJwjQ=NMSFLTG1xAg@mail.gmail.com>
Subject: Re: [PATCH v2] Make iwmmxt.S support Clang's integrated assembler
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Sat, Nov 7, 2020 at 12:29 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 7 Nov 2020 at 01:11, Jian Cai <jiancai@google.com> wrote:
> >
> > This patch replaces 6 IWMMXT instructions Clang's integrated assembler
> > does not support in iwmmxt.S using macros, while making sure GNU
> > assembler still emit the same instructions. This should be easier than
> > providing full IWMMXT support in Clang.
> >
> > "Intel Wireless MMX Technology - Developer Guide - August, 2002" should
> > be referenced for the encoding schemes of these extensions.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/975
> >
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Jian Cai <jiancai@google.com>
>
> Please make sure you test this carefully on BE32, as the instruction
> byte order used by .inst is LE IIRC

Unless that was a recent-ish change in GAS, it looks like I get the
same disassembly/encodings before/after this patch for
CONFIG_BIG_ENDIAN with GNU as.

$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make CC=clang -j71 defconfig
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make CC=clang -j71 menuconfig
<enable CPU_BIG_ENDIAN>
$ grep BIG_ENDIAN .config
CONFIG_CPU_BIG_ENDIAN=y
CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make CC=clang -j71
arch/arm/kernel/iwmmxt.o
$ arm-linux-gnueabi-objdump -dr arch/arm/kernel/iwmmxt.o > gas_before.txt
$ b4 am https://lore.kernel.org/lkml/20201107001056.225807-1-jiancai@google.com/
-o - | git am
$ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make CC=clang -j71
arch/arm/kernel/iwmmxt.o
$ arm-linux-gnueabi-objdump -dr arch/arm/kernel/iwmmxt.o > gas_after.txt
$ diff -u gas_before.txt gas_after.txt
$ echo $?
0

(Orthogonal, it looks like llvm-objdump has issues decoding
elf32-bigarm that we'll need to fix.)

Either way the patch LGTM for IWMMXT, thanks Jian for the patch and
Ard for the suggestions.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
