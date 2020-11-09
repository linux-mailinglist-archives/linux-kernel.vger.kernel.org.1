Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAB02AC6AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgKIVJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:09:43 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3E3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:09:43 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f18so3726010pgi.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnjA0vExtodqKNxAfLIMx+cONW4ftsoSQk+GuIJ8C3Q=;
        b=Mzn+lkPUKAagCrasvlj/MFdI2wxtH5U9jcoXzV73C9rLpSFg7sNLxJRw1MCX4K0APn
         /bvXA4koxkgoUCZF7aaLF8/wjkWuIrUUdy4usvMO3HQYyj1ojCVvr3j/JYp1GEbDh88J
         VPeftZHwG1Xfisry3+kiLECTYz6OktNlpGd8edleStz8LqLTcgXvMFCb5bdP3V8LvHBN
         o7DTnaSQD9t0X5+1tODMc3dxoUUmDIOddYJvrvgIgv/l42/+JGt1xxf7jdZQIIpAyMBb
         wdYdPsyRTVGM3hz9UHj7emaAvri7XTz0m8kOPe7StvlTQ2GKZ5OpdeVhUH+L3xpozID3
         J0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnjA0vExtodqKNxAfLIMx+cONW4ftsoSQk+GuIJ8C3Q=;
        b=dUE5pRAyDbD2mQnfRn4uMc46TnExGDdMG6P0sGksStQ9KPFCRvei5s7NlrgAsNpR4g
         6/4+0CbPRUGOP9bSGFPzFHLw/DmV3x6PhVHWIti5N5IiNPcL3zLkbMhQ6+zzHlm9BNrx
         tg4ezVND+mEt5UzKYIh1bTCbllDiay6Vvclh0F3/hnps/x1/zFhdmS4huILVcFDx0bfG
         spExP6GMeq7FmrG2OY4t2D/wR7NBls97Fx3KfuDtzzggJOgWYVynIJse+cxCoaF9vqK8
         w/bHnFxi50lmEv7A/wVUOpnxBmgbhLEhlK/RT+P3jAvwuNbXM8oZt2Ra5A9nsugZ2uy4
         zahg==
X-Gm-Message-State: AOAM530XO6ojnpbK30h5cxskFkk82pbnt8nmvz0c6TCF5oLCF8oerLS/
        4G//odRl42ovjMegh2VkLwRXzghTkwc2zOJynUtkiQ==
X-Google-Smtp-Source: ABdhPJwS3Dtj6FbqMVkJXCZDJQGzuD1lqxgTsfAoIUYREMZAmguhu0GdmXFgSGCrrr+zYXKXqGDZfHxP8ATkOptm7Ak=
X-Received: by 2002:a17:90b:110b:: with SMTP id gi11mr1095003pjb.25.1604956182606;
 Mon, 09 Nov 2020 13:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20201109205155.1207545-1-ndesaulniers@google.com> <CAMj1kXEoSF7UXNjJS4A6VtDVbpe7kfqxdZkMS3Sxf1Sr=PvdLA@mail.gmail.com>
In-Reply-To: <CAMj1kXEoSF7UXNjJS4A6VtDVbpe7kfqxdZkMS3Sxf1Sr=PvdLA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Nov 2020 13:09:31 -0800
Message-ID: <CAKwvOdmEu+mf0fVW+4gt1q7F3SkFcLvTbgjivv1qnTo3sBAO7A@mail.gmail.com>
Subject: Re: [PATCH] ARM: decompressor: avoid ADRL pseudo-instruction
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Mon, Nov 9, 2020 at 12:53 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 9 Nov 2020 at 21:52, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > As Ard notes in
> > commit 54781938ec34 ("crypto: arm/sha256-neon - avoid ADRL pseudo
> > instruction")
> > commit 0f5e8323777b ("crypto: arm/sha512-neon - avoid ADRL pseudo
> > instruction")
> >
> >   The ADRL pseudo instruction is not an architectural construct, but a
> >   convenience macro that was supported by the ARM proprietary assembler
> >   and adopted by binutils GAS as well, but only when assembling in 32-bit
> >   ARM mode. Therefore, it can only be used in assembler code that is known
> >   to assemble in ARM mode only, but as it turns out, the Clang assembler
> >   does not implement ADRL at all, and so it is better to get rid of it
> >   entirely.
> >
> >   So replace the ADRL instruction with a ADR instruction that refers to
> >   a nearer symbol, and apply the delta explicitly using an additional
> >   instruction.
> >
> > We can use the same technique to generate the same offset. It looks like
> > the ADRL pseudo instruction assembles to two SUB instructions in this
> > case. Because the largest immediate operand that can be specified for
> > this instruction is 0x400, and the distance between the reference and
> > the symbol are larger than that, we need to use an intermediary symbol
> > (cache_off in this case) to calculate the full range.
> >
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Suggested-by: Jian Cai <jiancai@google.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/arm/boot/compressed/head.S | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> > index 2e04ec5b5446..b3eac6f9a709 100644
> > --- a/arch/arm/boot/compressed/head.S
> > +++ b/arch/arm/boot/compressed/head.S
> > @@ -1440,7 +1440,9 @@ ENTRY(efi_enter_kernel)
> >                 mov     r4, r0                  @ preserve image base
> >                 mov     r8, r1                  @ preserve DT pointer
> >
> > - ARM(          adrl    r0, call_cache_fn       )
> > + ARM(          sub     r0, pc, #.L__efi_enter_kernel-cache_off )
> > + ARM(          sub     r0, r0, #cache_off-call_cache_fn        )
> > +.L__efi_enter_kernel:
> >   THUMB(                adr     r0, call_cache_fn       )
> >                 adr     r1, 0f                  @ clean the region of code we
> >                 bl      cache_clean_flush       @ may run with the MMU off
> > --
> > 2.29.2.222.g5d2a92d10f8-goog
> >
>
> This is already fixed in Russell's for-next tree.

Ah right, trolling through lore, there was:
https://lore.kernel.org/linux-arm-kernel/20200914095706.3985-1-ardb@kernel.org/

I didn't see anything in linux-next today, or
https://www.armlinux.org.uk/developer/patches/ Incoming or Applied.

Did it just get merged into the for-next branch, or is for-next not
getting pulled into linux-next?
-- 
Thanks,
~Nick Desaulniers
