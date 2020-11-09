Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9801E2AC65D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgKIUxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:53:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgKIUxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:53:32 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 160E220789
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 20:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604955211;
        bh=D970hLafVWRKQt0xZ7autBoyj6uiyHR8hR2zojf4lsk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dAyxD+4XENXqFcjUe07LCTFgD469KXmRyhh/eeywhdOKOpNMjfpJ+V45wh7RCwdIj
         plTh6R9ofvLMwUOA1tsdefZzK6gKnI2Q1V5QYt+4p8B7dRp9adoEnmFd7kcVvUR4Yz
         UMR41eq9qaHjyDI1ChZTjFGajYsp5C8gcmgkIkSQ=
Received: by mail-ot1-f41.google.com with SMTP id j14so10363984ots.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 12:53:31 -0800 (PST)
X-Gm-Message-State: AOAM532mD6Gj43sqO+zeGDLEDo3AmZt3wu2URcznXU0RNf1DYWsPJrSy
        /J+SrbOHThalgM/T2iDoMv3PzompBu2J/I0FZX0=
X-Google-Smtp-Source: ABdhPJyMeq//Jxtyh4VtxOVwK/0psN5ILjQ7nSQcBIyw7h1AvHcyU5/UpPc8S+tQ0hRPGRSnVkIAZpwv3HIq2iPeDao=
X-Received: by 2002:a9d:62c1:: with SMTP id z1mr11316465otk.108.1604955210439;
 Mon, 09 Nov 2020 12:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20201109205155.1207545-1-ndesaulniers@google.com>
In-Reply-To: <20201109205155.1207545-1-ndesaulniers@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 9 Nov 2020 21:53:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEoSF7UXNjJS4A6VtDVbpe7kfqxdZkMS3Sxf1Sr=PvdLA@mail.gmail.com>
Message-ID: <CAMj1kXEoSF7UXNjJS4A6VtDVbpe7kfqxdZkMS3Sxf1Sr=PvdLA@mail.gmail.com>
Subject: Re: [PATCH] ARM: decompressor: avoid ADRL pseudo-instruction
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jian Cai <jiancai@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Nov 2020 at 21:52, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> As Ard notes in
> commit 54781938ec34 ("crypto: arm/sha256-neon - avoid ADRL pseudo
> instruction")
> commit 0f5e8323777b ("crypto: arm/sha512-neon - avoid ADRL pseudo
> instruction")
>
>   The ADRL pseudo instruction is not an architectural construct, but a
>   convenience macro that was supported by the ARM proprietary assembler
>   and adopted by binutils GAS as well, but only when assembling in 32-bit
>   ARM mode. Therefore, it can only be used in assembler code that is known
>   to assemble in ARM mode only, but as it turns out, the Clang assembler
>   does not implement ADRL at all, and so it is better to get rid of it
>   entirely.
>
>   So replace the ADRL instruction with a ADR instruction that refers to
>   a nearer symbol, and apply the delta explicitly using an additional
>   instruction.
>
> We can use the same technique to generate the same offset. It looks like
> the ADRL pseudo instruction assembles to two SUB instructions in this
> case. Because the largest immediate operand that can be specified for
> this instruction is 0x400, and the distance between the reference and
> the symbol are larger than that, we need to use an intermediary symbol
> (cache_off in this case) to calculate the full range.
>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Suggested-by: Jian Cai <jiancai@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm/boot/compressed/head.S | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 2e04ec5b5446..b3eac6f9a709 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -1440,7 +1440,9 @@ ENTRY(efi_enter_kernel)
>                 mov     r4, r0                  @ preserve image base
>                 mov     r8, r1                  @ preserve DT pointer
>
> - ARM(          adrl    r0, call_cache_fn       )
> + ARM(          sub     r0, pc, #.L__efi_enter_kernel-cache_off )
> + ARM(          sub     r0, r0, #cache_off-call_cache_fn        )
> +.L__efi_enter_kernel:
>   THUMB(                adr     r0, call_cache_fn       )
>                 adr     r1, 0f                  @ clean the region of code we
>                 bl      cache_clean_flush       @ may run with the MMU off
> --
> 2.29.2.222.g5d2a92d10f8-goog
>

This is already fixed in Russell's for-next tree.
