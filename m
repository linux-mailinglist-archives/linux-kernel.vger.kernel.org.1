Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220142EF5B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbhAHQ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:26:38 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:40908 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbhAHQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:26:37 -0500
Received: by mail-ot1-f51.google.com with SMTP id j12so10135438ota.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 08:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4P0bI2KySEz7bF1VDbHcM0MRrhKTTvGeuLXsvdhijoA=;
        b=E9w0OKEtQG3oeOFXSu7dpJylpVP0KO65kBXqcokPxH+w5mpDu9IRjHfxRWw4xALAY8
         C2vom2zK+jm0cIE+Z0EV9GlvR6+pz8OsT51xX8DSj2ir240kSBEmaHU7oZ62YTa5/5c9
         0fkMz++ZGUyOzpOxuHs56SD52gt5fQFtCxutrg65lXmALTSijoedGyb4b4gnppzrxgav
         nqBARC55quTugSKi7Hk4ZQwPWFui8IqJPorQsFoIADFEvo5nKmabHyBnBPR+nFbZ4Af5
         Sqhv48dDQyWZB/6S2/5AZ7FBxcD8PFtMTCqL1uc/I0gXo2aGbWrLQWgSGU1GM6VIEGEv
         980w==
X-Gm-Message-State: AOAM533YO3eBD4jaAu0Paw8Yvh3n49nHQ+LOutDJizCtYUnD3BqFgXqL
        EVaeNiSwukQR/lO9yq0L+MXxmo5C23/clzGBSFI=
X-Google-Smtp-Source: ABdhPJy3k6nmCGv0rEESlquxP7okt0veCEhpEnm7rMrWlbYyLr9vLqjY+vBqL0DWfMxahjb4O55awdynuAirNoyHknM=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr3135433oth.250.1610123156661;
 Fri, 08 Jan 2021 08:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20210107092652.3438696-1-atish.patra@wdc.com> <20210107092652.3438696-2-atish.patra@wdc.com>
In-Reply-To: <20210107092652.3438696-2-atish.patra@wdc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Jan 2021 17:25:45 +0100
Message-ID: <CAMuHMdWf6K-5y02+WJ6Khu1cD6P0n5x1wYQikrECkuNtAA1pgg@mail.gmail.com>
Subject: Re: [PATCH 1/4] RISC-V: Do not allocate memblock while iterating
 reserved memblocks
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Thu, Jan 7, 2021 at 10:28 AM Atish Patra <atish.patra@wdc.com> wrote:
> Currently, resource tree allocates memory blocks while iterating on the
> list. It leads to following kernel warning because memblock allocation
> also invokes memory block reservation API.
>
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/resource.c:795
> __insert_resource+0x8e/0xd0
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 5.10.0-00022-ge20097fb37e2-dirty #549
> [    0.000000] epc: c00125c2 ra : c001262c sp : c1c01f50
> [    0.000000]  gp : c1d456e0 tp : c1c0a980 t0 : ffffcf20
> [    0.000000]  t1 : 00000000 t2 : 00000000 s0 : c1c01f60
> [    0.000000]  s1 : ffffcf00 a0 : ffffff00 a1 : c1c0c0c4
> [    0.000000]  a2 : 80c12b15 a3 : 80402000 a4 : 80402000
> [    0.000000]  a5 : c1c0c0c4 a6 : 80c12b15 a7 : f5faf600
> [    0.000000]  s2 : c1c0c0c4 s3 : c1c0e000 s4 : c1009a80
> [    0.000000]  s5 : c1c0c000 s6 : c1d48000 s7 : c1613b4c
> [    0.000000]  s8 : 00000fff s9 : 80000200 s10: c1613b40
> [    0.000000]  s11: 00000000 t3 : c1d4a000 t4 : ffffffff
>
> This is also unnecessary as we can pre-compute the total memblocks required
> for each memory region and allocate it before the loop. It save precious
> boot time not going through memblock allocation code every time.
>
> Fixes: 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Thanks for your patch!

I never saw the warning (on linux-on-litex-vexriscv), but instead I got:

    Failed to add a Kernel code resource at 40001000

after Initmem setup. Adding some debug info to init_resources() showed
that the memblock.reserved list kept on increasing, until memory
corruption happened (pointers started to look like ASCII strings), the
error message above is printed, and after which the boot continued.
Changing L1_CACHE_SHIFT in arch/riscv/include/asm/cache.h to 5 fixed that.

With this patch, the error message above is no longer printed, so
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Noted that the kernel still crashes later, with

    Unable to handle kernel paging request at virtual address 61636473

Again, 0x61636473 looks like ASCII, and your PATCH 3/4 for
L1_CACHE_SHIFT fixes that, too.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
