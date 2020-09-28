Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5627ABA4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgI1KOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgI1KOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:14:40 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61C0B20756
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601288079;
        bh=Wci5tV7IePv+k+r7FiAz6Qh4WR/IG6VpMQEgDKi+GdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=arK1PV2/g2quTmpn/JFKx1/yDXVZFC3hbkOAoHGATfCfNS6PPC2knI7SVZqZ4SAAA
         iDQs4CT49or4OyWrHKfSWrzdVj20X6SIN6MNam7og17lmAgRyLlFjmYyTGiO6n1Cs5
         P/EusjI16zoubPJTpYPfDCZI1q50fdp7doJa0zkk=
Received: by mail-oo1-f51.google.com with SMTP id b12so155266oop.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:14:39 -0700 (PDT)
X-Gm-Message-State: AOAM530+G09rQJxRwZKR5VEqAw0PotlgAXnWzXn/x78cc6XzGPWJoerc
        JcP2psyVp+YVJOuhHh7dTEQ6Spdh7Msq7Q1z1Dg=
X-Google-Smtp-Source: ABdhPJzx5dkXjvADA54XpJVJ4/mmVUv/23iGLH5nbcVUv8aKhI9yonkyWOtKkGkws3Y3VrC8/dZvWRQXaKBhQkRJRhA=
X-Received: by 2002:a4a:b443:: with SMTP id h3mr285534ooo.45.1601288078650;
 Mon, 28 Sep 2020 03:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200928092641.2070-1-thunder.leizhen@huawei.com> <20200928092641.2070-3-thunder.leizhen@huawei.com>
In-Reply-To: <20200928092641.2070-3-thunder.leizhen@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Sep 2020 12:14:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGK8x4eBL55mLMWVQWpFZKa+FSCaQj9_gieWCQSgG=xAQ@mail.gmail.com>
Message-ID: <CAMj1kXGK8x4eBL55mLMWVQWpFZKa+FSCaQj9_gieWCQSgG=xAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: decompressor: relax the loading restriction of
 the decompressed kernel
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 at 11:27, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> mov     r4, pc
> and     r4, r4, #0xf8000000     //truncated to 128MiB boundary
> add     r4, r4, #TEXT_OFFSET    //PA(_start)
>
> Currently, the decompressed kernel must be placed at the position: 128MiB
> boundary + TEXT_OFFSET. This limitation is just because we masked PC with
> 0xf80000000. Actually, we can directly obtain PA(_start) by using formula
> : VA(_start) + (PHYS_OFFSET - PAGE_OFFSET).
>
> So the "PA(_start) - TEXT_OFFSET" can be 2MiB boundary, 1MiB boundary,
> and so on.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

No, this won't work.

The whole reason for rounding to a multiple of 128 MB is that we
cannot infer the start of DRAM from the placement of the zImage (which
provides _start).

There are patches on the list by Geert [0] to obtain the start of DRAM
from the device tree directly, to work around this masking. And when
booting via EFI (which is supported by u-boot too these days), the
zImage could be anywhere in [32-bit addressable] memory, and the start
of DRAM is obtained from the EFI memory map.

Note to Geert: this is a followup to an effort by Zhen Lei and myself
[1] to lower the minimum alignment of PHYS_OFFSET from 16 MiB to 2
MiB, and this affects your patch as well.


[0] https://lore.kernel.org/linux-arm-kernel/20200902153606.13652-1-geert+renesas@glider.be/
[1] https://lore.kernel.org/linux-arm-kernel/20200921154117.757-1-ardb@kernel.org/


> ---
>  arch/arm/boot/compressed/head.S | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 434a16982e344fe..e5ba2ad2ea4700f 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -255,26 +255,16 @@ not_angel:
>
>  #ifdef CONFIG_AUTO_ZRELADDR
>                 /*
> -                * Find the start of physical memory.  As we are executing
> -                * without the MMU on, we are in the physical address space.
> -                * We just need to get rid of any offset by aligning the
> -                * address.
> -                *
> -                * This alignment is a balance between the requirements of
> -                * different platforms - we have chosen 128MB to allow
> -                * platforms which align the start of their physical memory
> -                * to 128MB to use this feature, while allowing the zImage
> -                * to be placed within the first 128MB of memory on other
> -                * platforms.  Increasing the alignment means we place
> -                * stricter alignment requirements on the start of physical
> -                * memory, but relaxing it means that we break people who
> -                * are already placing their zImage in (eg) the top 64MB
> -                * of this range.
> +                * Find ZRELADDR (Address where the decompressed kernel was
> +                * placed, usually == PHYS_OFFSET + TEXT_OFFSET). That's the
> +                * start physical address of the text section, PA(_start).
> +                * As we are executing without the MMU on, we are in the
> +                * physical address space.
>                  */
> -               mov     r4, pc
> -               and     r4, r4, #0xf8000000
> -               /* Determine final kernel image address. */
> -               add     r4, r4, #TEXT_OFFSET
> +               adr     r0, LC2
> +               ldmia   r0, {r3-r4}
> +               sub     r3, r0, r3              @ PHYS_OFFSET - PAGE_OFFSET
> +               add     r4, r4, r3              @ PA(_start)
>  #else
>                 ldr     r4, =zreladdr
>  #endif
> @@ -660,6 +650,11 @@ LC1:               .word   .L_user_stack_end - LC1 @ sp
>                 .word   _edata - LC1            @ r6
>                 .size   LC1, . - LC1
>
> +               .align  2
> +               .type   LC2, #object
> +LC2:           .word   LC2
> +               .word   _start                  @ start VA of text section
> +
>  .Lheadroom:
>                 .word   _end - restart + 16384 + 1024*1024
>
> --
> 1.8.3
>
>
