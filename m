Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88BF2B0151
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgKLImk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:42:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgKLImj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:42:39 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BD12220B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605170558;
        bh=3WU6N2ZILepl5b98DXzdtZr+wQt3TxvVpbJ3nAlSlyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wVujH/uoUzdSad5CLikVIzp7R/CQ2+Q/TXnNgWs2y0iTderijVO3ILbSDcUeD5B9D
         ttNBPGq8nBVjziG9OxSaentw+Y4z9UBT3NuWMwkZav15jFaPtn1dP/mwd5RkTvBmx3
         /NIA5M+q7FcDlmFm7G4ZYPhYKV2ZpvOOyg3/K82Q=
Received: by mail-oi1-f173.google.com with SMTP id c80so5540589oib.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 00:42:37 -0800 (PST)
X-Gm-Message-State: AOAM532WRyYv10eq0FaTaMSVHFTD2grxZiMFhCj0rx2Bl51IiyLLbF67
        F2hXU8ipMMq/cREwornEKJE3VPpMDPiWnc6fAsM=
X-Google-Smtp-Source: ABdhPJzlRrD6SMM9ThaguUMD72AuWIdBmOM2ivE1fF89C7rL+WNmyTykZomlv/EDx8X+kkDpGWtmh3PKhpen4qwvVPs=
X-Received: by 2002:aca:c60c:: with SMTP id w12mr5177268oif.174.1605170557102;
 Thu, 12 Nov 2020 00:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <20201107001056.225807-1-jiancai@google.com>
In-Reply-To: <20201107001056.225807-1-jiancai@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 12 Nov 2020 09:42:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEAhyTfFZg4_+wTZ5+obQpAzFknC4vR1bNrRG6GpW4D0Q@mail.gmail.com>
Message-ID: <CAMj1kXEAhyTfFZg4_+wTZ5+obQpAzFknC4vR1bNrRG6GpW4D0Q@mail.gmail.com>
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

For the change itself,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

Although I must admit I am still on the fence when it comes to the
policy around rewriting perfectly valid code like this to accommodate
a toolchain that nobody is likely to use to build the code in
question.

Perhaps we should at least add some rationale to the commit log why
Clang's integrated assembler is something we should care about? I take
it this is not about diagnostics or CFI but simply about avoiding the
need to carry cross-binutils in the first place?

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
