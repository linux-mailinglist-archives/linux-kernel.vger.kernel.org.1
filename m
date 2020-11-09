Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5B2AC78C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgKIVpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:45:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbgKIVpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:45:34 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9DCA21D46
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 21:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604958332;
        bh=WDTIyhqTjCVRPEgsuMxOm4KcjksVm4jG/r82gsohB9w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2uMJxTjAZ+Fmj2DYoBwoBRhiKlV95YfFIXjN9kyQFC/FrXTAK44isT/RERDl2G4AC
         Me6Xxg4QrF61xdxd4rFHr57eifG4BViidKws8+VYTfeViPr9ScCtf060i38sC4lz52
         SIGorGlFqkqJipeBZT8QVh5GR3/pn1rTxa7mKPt4=
Received: by mail-oi1-f174.google.com with SMTP id m13so11884091oih.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:45:32 -0800 (PST)
X-Gm-Message-State: AOAM533/CuI+Xbi3K3J1MQqnDyCpj/z14o8IvgKTXPcoHNt82EEV5hJQ
        i3fYG9lJLr1F3ZNwuR+Zzdu993Sl2ogJZnV8Sqk=
X-Google-Smtp-Source: ABdhPJzEnqI1Z/TX9NvRZvQgFX5/6W28aQEKPArEiMNUGJjEVC89xMcimY5633FuYe9XHLrWITtaoyf+QzDIAT/1C9Y=
X-Received: by 2002:aca:c60c:: with SMTP id w12mr868574oif.174.1604958331811;
 Mon, 09 Nov 2020 13:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20201109205155.1207545-1-ndesaulniers@google.com>
 <CAMj1kXEoSF7UXNjJS4A6VtDVbpe7kfqxdZkMS3Sxf1Sr=PvdLA@mail.gmail.com> <CAKwvOdmEu+mf0fVW+4gt1q7F3SkFcLvTbgjivv1qnTo3sBAO7A@mail.gmail.com>
In-Reply-To: <CAKwvOdmEu+mf0fVW+4gt1q7F3SkFcLvTbgjivv1qnTo3sBAO7A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 9 Nov 2020 22:45:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEC6TvkYScMPk0++6atLZe1yrkrUwMRkat33WEwym9t0g@mail.gmail.com>
Message-ID: <CAMj1kXEC6TvkYScMPk0++6atLZe1yrkrUwMRkat33WEwym9t0g@mail.gmail.com>
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

On Mon, 9 Nov 2020 at 22:09, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, Nov 9, 2020 at 12:53 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 9 Nov 2020 at 21:52, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > As Ard notes in
> > > commit 54781938ec34 ("crypto: arm/sha256-neon - avoid ADRL pseudo
> > > instruction")
> > > commit 0f5e8323777b ("crypto: arm/sha512-neon - avoid ADRL pseudo
> > > instruction")
> > >
> > >   The ADRL pseudo instruction is not an architectural construct, but a
> > >   convenience macro that was supported by the ARM proprietary assembler
> > >   and adopted by binutils GAS as well, but only when assembling in 32-bit
> > >   ARM mode. Therefore, it can only be used in assembler code that is known
> > >   to assemble in ARM mode only, but as it turns out, the Clang assembler
> > >   does not implement ADRL at all, and so it is better to get rid of it
> > >   entirely.
> > >
> > >   So replace the ADRL instruction with a ADR instruction that refers to
> > >   a nearer symbol, and apply the delta explicitly using an additional
> > >   instruction.
> > >
> > > We can use the same technique to generate the same offset. It looks like
> > > the ADRL pseudo instruction assembles to two SUB instructions in this
> > > case. Because the largest immediate operand that can be specified for
> > > this instruction is 0x400, and the distance between the reference and
> > > the symbol are larger than that, we need to use an intermediary symbol
> > > (cache_off in this case) to calculate the full range.
> > >
> > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > Suggested-by: Jian Cai <jiancai@google.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  arch/arm/boot/compressed/head.S | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> > > index 2e04ec5b5446..b3eac6f9a709 100644
> > > --- a/arch/arm/boot/compressed/head.S
> > > +++ b/arch/arm/boot/compressed/head.S
> > > @@ -1440,7 +1440,9 @@ ENTRY(efi_enter_kernel)
> > >                 mov     r4, r0                  @ preserve image base
> > >                 mov     r8, r1                  @ preserve DT pointer
> > >
> > > - ARM(          adrl    r0, call_cache_fn       )
> > > + ARM(          sub     r0, pc, #.L__efi_enter_kernel-cache_off )
> > > + ARM(          sub     r0, r0, #cache_off-call_cache_fn        )
> > > +.L__efi_enter_kernel:
> > >   THUMB(                adr     r0, call_cache_fn       )
> > >                 adr     r1, 0f                  @ clean the region of code we
> > >                 bl      cache_clean_flush       @ may run with the MMU off
> > > --
> > > 2.29.2.222.g5d2a92d10f8-goog
> > >
> >
> > This is already fixed in Russell's for-next tree.
>
> Ah right, trolling through lore, there was:
> https://lore.kernel.org/linux-arm-kernel/20200914095706.3985-1-ardb@kernel.org/
>
> I didn't see anything in linux-next today, or
> https://www.armlinux.org.uk/developer/patches/ Incoming or Applied.
>
> Did it just get merged into the for-next branch, or is for-next not
> getting pulled into linux-next?


It should appear tomorrow.
