Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5982B5631
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 02:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgKQBUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 20:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgKQBUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 20:20:33 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE568C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 17:20:31 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 62so14828401pgg.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 17:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pAwfts0XCRV1ZtALd8qKrZVsKZpsyUQ82CfQDJP6mE=;
        b=Su1SqnM3Ufvm/RE0OTLhFPHMkUzQaXCATpeyfzwFhNQtV8ylLKbOMExg2su0KdmaF+
         8kX5p0PG8ymRH9/xZNCMvh+4TM/dUnKt2VNJ6YZllmCjoV253fHwE7upct6JJDyD4W1U
         bpyuVwvr2GeikJsbmRtrnSh8Ub4oqadPlVAhVTz8sc8icqOa/sUD6U90Lh40fZzL7wVA
         l611QaCYVIVg/N/lyGU9XInsGuHJfR9ISFUZLTEBfxG79f9g6EmM6pkyvo7Hg9zODPyI
         10fS+akvupI9ETFOomqAtODb76KQrWcpB9IE7UjcaOQn7f2Rk3cCJQDG28Yur3KW02ma
         Jrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pAwfts0XCRV1ZtALd8qKrZVsKZpsyUQ82CfQDJP6mE=;
        b=SGyqJnqHHCX7XtMyBveCVAkIemsLN8sAl3oxiHe2/apckbG9os7xNqFRcsTO/MGKdd
         RjBpUe6zq8wdFXifSnpkFsFIX6jmGAOItn2W5s4YbDUva4ygUjC76R8inEqjKEkIY/2Z
         ReM2ILPVEQa4OcVGM8CJDKNfB5MFKHBkdN0HWSbRAf2HsbUnbl/BL7ic0PuB94E98aKP
         pAoTMPKlRz1miq1r1ZmTpvS9/WqF3/X1s84PCOa1+YYe1MMIZj/xxcCkf2cBrfXip3Zr
         JK4Qc1WOMc6xdDhSldC/NOuyzsZWpW7Itjiw9dPoh2ZlBHk2/6vlYYhdqQ0pyoI1UfEy
         QKTg==
X-Gm-Message-State: AOAM532opXJSi+mwyu44b5e57KqanrSSYnDXMg+ftON1R+B05vzUHEJA
        dsYLiaKfSuq2aPAUyLfvi71X0Qk0h+iCqeBqQsOjLA==
X-Google-Smtp-Source: ABdhPJxUSojWhy0Ru7A4FLlh6dgWeBanh3oodbxnCT28dXB4n+YC9dqzOCN/QOFIQp2RdlWBowQXs9Q6uD/Y1EbKQKQ=
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr1857507pjj.101.1605576031321;
 Mon, 16 Nov 2020 17:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20201112200718.2747316-1-jiancai@google.com> <20201117003724.2381423-1-jiancai@google.com>
In-Reply-To: <20201117003724.2381423-1-jiancai@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Nov 2020 17:20:19 -0800
Message-ID: <CAKwvOd=LxU-eJ-Rf9fH-0P8dWiqU335ntG2RzHrn5SvRHDNG5g@mail.gmail.com>
Subject: Re: [PATCH v4] Make iwmmxt.S support Clang's integrated assembler
To:     Jian Cai <jiancai@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 4:37 PM Jian Cai <jiancai@google.com> wrote:
>
> This patch replaces 6 IWMMXT instructions Clang's integrated assembler
> does not support in iwmmxt.S using macros, while making sure GNU
> assembler still emit the same instructions. This should be easier than
> providing full IWMMXT support in Clang.  This is one of the last bits of
> kernel code that could be compiled but not assembled with clang. Once
> all of it works with IAS, we no longer need to special-case 32-bit Arm
> in Kbuild, or turn off CONFIG_IWMMXT when build-testing.
>
> "Intel Wireless MMX Technology - Developer Guide - August, 2002" should
> be referenced for the encoding schemes of these extensions.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/975
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jian Cai <jiancai@google.com>

Since only the commit message changed since V2, carry forward:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes v3 -> v4:
> Forgot to include iwmmxt.h in v3.
>
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
> 2.29.2.299.gdc1121823c-goog
>


-- 
Thanks,
~Nick Desaulniers
