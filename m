Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419D02AA3DE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 09:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgKGI3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 03:29:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgKGI3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 03:29:37 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9F6420872
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 08:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604737775;
        bh=08/8FnudzZB2viUYeDFRJIxKOEcx5hbcNz5IGgSUx94=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cjuQiHKGHl6TT0P7e6MtM2VxmYOIwgRGqA6h9hjsAvo2+8RX4L4VHnubAGyltmLyw
         JhB4BzlFs+n+yNs3dzE6by7V8mEHT5TYnJwiTg1uixhQ+uQBFjylIpZ79jnz3Dvj8m
         F0LsZhBIPKW80R77Khig0BSNjksgei4pASp6zRfQ=
Received: by mail-ot1-f49.google.com with SMTP id y22so3582547oti.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 00:29:35 -0800 (PST)
X-Gm-Message-State: AOAM533elk75iXg8kOJDWHtUFozmIhQDJ99EUjPWtH9KaIeFBK2f69QO
        6TOFyo6FjIak3GV8UF07C+1L9DqZ9+Dyj+4m/iI=
X-Google-Smtp-Source: ABdhPJyqr9Fpeqyn0o1hv9967BwHx82BnlkxUxlQKLFEp1mw/JjJyUdVQKUTr7PUsTbemnfI1QT59NSTvjrh623yVMk=
X-Received: by 2002:a05:6830:4028:: with SMTP id i8mr3492132ots.90.1604737775170;
 Sat, 07 Nov 2020 00:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <20201107001056.225807-1-jiancai@google.com>
In-Reply-To: <20201107001056.225807-1-jiancai@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 7 Nov 2020 09:29:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG+qb267Hig6zoO=y6_BVsKsqHikvbJ83YsBD8SBaZ1xw@mail.gmail.com>
Message-ID: <CAMj1kXG+qb267Hig6zoO=y6_BVsKsqHikvbJ83YsBD8SBaZ1xw@mail.gmail.com>
Subject: Re: [PATCH v2] Make iwmmxt.S support Clang's integrated assembler
To:     Jian Cai <jiancai@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

On Sat, 7 Nov 2020 at 01:11, Jian Cai <jiancai@google.com> wrote:
>
> This patch replaces 6 IWMMXT instructions Clang's integrated assembler
> does not support in iwmmxt.S using macros, while making sure GNU
> assembler still emit the same instructions. This should be easier than
> providing full IWMMXT support in Clang.
>
> "Intel Wireless MMX Technology - Developer Guide - August, 2002" should
> be referenced for the encoding schemes of these extensions.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/975
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jian Cai <jiancai@google.com>

Please make sure you test this carefully on BE32, as the instruction
byte order used by .inst is LE IIRC

> ---
>  arch/arm/kernel/iwmmxt.S | 89 ++++++++++++++++++++--------------------
>  arch/arm/kernel/iwmmxt.h | 47 +++++++++++++++++++++
>  2 files changed, 92 insertions(+), 44 deletions(-)
>  create mode 100644 arch/arm/kernel/iwmmxt.h
>
> diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
> index 0dcae787b004..d2b4ac06e4ed 100644
> --- a/arch/arm/kernel/iwmmxt.S
> +++ b/arch/arm/kernel/iwmmxt.S
> @@ -16,6 +16,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/assembler.h>
> +#include "iwmmxt.h"
>
>  #if defined(CONFIG_CPU_PJ4) || defined(CONFIG_CPU_PJ4B)
>  #define PJ4(code...)           code
> @@ -113,33 +114,33 @@ concan_save:
>
>  concan_dump:
>
> -       wstrw   wCSSF, [r1, #MMX_WCSSF]
> -       wstrw   wCASF, [r1, #MMX_WCASF]
> -       wstrw   wCGR0, [r1, #MMX_WCGR0]
> -       wstrw   wCGR1, [r1, #MMX_WCGR1]
> -       wstrw   wCGR2, [r1, #MMX_WCGR2]
> -       wstrw   wCGR3, [r1, #MMX_WCGR3]
> +       wstrw   wCSSF, r1, MMX_WCSSF
> +       wstrw   wCASF, r1, MMX_WCASF
> +       wstrw   wCGR0, r1, MMX_WCGR0
> +       wstrw   wCGR1, r1, MMX_WCGR1
> +       wstrw   wCGR2, r1, MMX_WCGR2
> +       wstrw   wCGR3, r1, MMX_WCGR3
>
>  1:     @ MUP? wRn
>         tst     r2, #0x2
>         beq     2f
>
> -       wstrd   wR0,  [r1, #MMX_WR0]
> -       wstrd   wR1,  [r1, #MMX_WR1]
> -       wstrd   wR2,  [r1, #MMX_WR2]
> -       wstrd   wR3,  [r1, #MMX_WR3]
> -       wstrd   wR4,  [r1, #MMX_WR4]
> -       wstrd   wR5,  [r1, #MMX_WR5]
> -       wstrd   wR6,  [r1, #MMX_WR6]
> -       wstrd   wR7,  [r1, #MMX_WR7]
> -       wstrd   wR8,  [r1, #MMX_WR8]
> -       wstrd   wR9,  [r1, #MMX_WR9]
> -       wstrd   wR10, [r1, #MMX_WR10]
> -       wstrd   wR11, [r1, #MMX_WR11]
> -       wstrd   wR12, [r1, #MMX_WR12]
> -       wstrd   wR13, [r1, #MMX_WR13]
> -       wstrd   wR14, [r1, #MMX_WR14]
> -       wstrd   wR15, [r1, #MMX_WR15]
> +       wstrd   wR0,  r1, MMX_WR0
> +       wstrd   wR1,  r1, MMX_WR1
> +       wstrd   wR2,  r1, MMX_WR2
> +       wstrd   wR3,  r1, MMX_WR3
> +       wstrd   wR4,  r1, MMX_WR4
> +       wstrd   wR5,  r1, MMX_WR5
> +       wstrd   wR6,  r1, MMX_WR6
> +       wstrd   wR7,  r1, MMX_WR7
> +       wstrd   wR8,  r1, MMX_WR8
> +       wstrd   wR9,  r1, MMX_WR9
> +       wstrd   wR10, r1, MMX_WR10
> +       wstrd   wR11, r1, MMX_WR11
> +       wstrd   wR12, r1, MMX_WR12
> +       wstrd   wR13, r1, MMX_WR13
> +       wstrd   wR14, r1, MMX_WR14
> +       wstrd   wR15, r1, MMX_WR15
>
>  2:     teq     r0, #0                          @ anything to load?
>         reteq   lr                              @ if not, return
> @@ -147,30 +148,30 @@ concan_dump:
>  concan_load:
>
>         @ Load wRn
> -       wldrd   wR0,  [r0, #MMX_WR0]
> -       wldrd   wR1,  [r0, #MMX_WR1]
> -       wldrd   wR2,  [r0, #MMX_WR2]
> -       wldrd   wR3,  [r0, #MMX_WR3]
> -       wldrd   wR4,  [r0, #MMX_WR4]
> -       wldrd   wR5,  [r0, #MMX_WR5]
> -       wldrd   wR6,  [r0, #MMX_WR6]
> -       wldrd   wR7,  [r0, #MMX_WR7]
> -       wldrd   wR8,  [r0, #MMX_WR8]
> -       wldrd   wR9,  [r0, #MMX_WR9]
> -       wldrd   wR10, [r0, #MMX_WR10]
> -       wldrd   wR11, [r0, #MMX_WR11]
> -       wldrd   wR12, [r0, #MMX_WR12]
> -       wldrd   wR13, [r0, #MMX_WR13]
> -       wldrd   wR14, [r0, #MMX_WR14]
> -       wldrd   wR15, [r0, #MMX_WR15]
> +       wldrd   wR0,  r0, MMX_WR0
> +       wldrd   wR1,  r0, MMX_WR1
> +       wldrd   wR2,  r0, MMX_WR2
> +       wldrd   wR3,  r0, MMX_WR3
> +       wldrd   wR4,  r0, MMX_WR4
> +       wldrd   wR5,  r0, MMX_WR5
> +       wldrd   wR6,  r0, MMX_WR6
> +       wldrd   wR7,  r0, MMX_WR7
> +       wldrd   wR8,  r0, MMX_WR8
> +       wldrd   wR9,  r0, MMX_WR9
> +       wldrd   wR10, r0, MMX_WR10
> +       wldrd   wR11, r0, MMX_WR11
> +       wldrd   wR12, r0, MMX_WR12
> +       wldrd   wR13, r0, MMX_WR13
> +       wldrd   wR14, r0, MMX_WR14
> +       wldrd   wR15, r0, MMX_WR15
>
>         @ Load wCx
> -       wldrw   wCSSF, [r0, #MMX_WCSSF]
> -       wldrw   wCASF, [r0, #MMX_WCASF]
> -       wldrw   wCGR0, [r0, #MMX_WCGR0]
> -       wldrw   wCGR1, [r0, #MMX_WCGR1]
> -       wldrw   wCGR2, [r0, #MMX_WCGR2]
> -       wldrw   wCGR3, [r0, #MMX_WCGR3]
> +       wldrw   wCSSF, r0, MMX_WCSSF
> +       wldrw   wCASF, r0, MMX_WCASF
> +       wldrw   wCGR0, r0, MMX_WCGR0
> +       wldrw   wCGR1, r0, MMX_WCGR1
> +       wldrw   wCGR2, r0, MMX_WCGR2
> +       wldrw   wCGR3, r0, MMX_WCGR3
>
>         @ clear CUP/MUP (only if r1 != 0)
>         teq     r1, #0
> diff --git a/arch/arm/kernel/iwmmxt.h b/arch/arm/kernel/iwmmxt.h
> new file mode 100644
> index 000000000000..fb627286f5bb
> --- /dev/null
> +++ b/arch/arm/kernel/iwmmxt.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __IWMMXT_H__
> +#define __IWMMXT_H__
> +
> +.irp b, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
> +.set .LwR\b, \b
> +.set .Lr\b, \b
> +.endr
> +
> +.set .LwCSSF, 0x2
> +.set .LwCASF, 0x3
> +.set .LwCGR0, 0x8
> +.set .LwCGR1, 0x9
> +.set .LwCGR2, 0xa
> +.set .LwCGR3, 0xb
> +
> +.macro wldrd, reg:req, base:req, offset:req
> +.inst 0xedd00100 | (.L\reg << 12) | (.L\base << 16) | (\offset >> 2)
> +.endm
> +
> +.macro wldrw, reg:req, base:req, offset:req
> +.inst 0xfd900100 | (.L\reg << 12) | (.L\base << 16) | (\offset >> 2)
> +.endm
> +
> +.macro wstrd, reg:req, base:req, offset:req
> +.inst 0xedc00100 | (.L\reg << 12) | (.L\base << 16) | (\offset >> 2)
> +.endm
> +
> +.macro wstrw, reg:req, base:req, offset:req
> +.inst 0xfd800100 | (.L\reg << 12) | (.L\base << 16) | (\offset >> 2)
> +.endm
> +
> +#ifdef __clang__
> +
> +#define wCon c1
> +
> +.macro tmrc, dest:req, control:req
> +mrc p1, 0, \dest, \control, c0, 0
> +.endm
> +
> +.macro tmcr, control:req, src:req
> +mcr p1, 0, \src, \control, c0, 0
> +.endm
> +#endif
> +
> +#endif
> --
> 2.29.1.341.ge80a0c044ae-goog
>
