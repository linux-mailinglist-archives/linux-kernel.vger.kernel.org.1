Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A904268A60
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgINLyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgINLuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:50:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D37C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:50:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a17so18377223wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iJIrFiPrthxhWR/A1W4z3Dcqg+LQz4AuT3GYaAloBA=;
        b=FqbYrnRQxKtvT4FZdy8KmgpIW72P0WkrZEi2B7ArJtMBbSoRZflgSaJAXYG/zwTnU+
         QLtnMCMTZQ3EmMhMGAWP8vk0KHeffvl9kHstfSZi0ZCLaog7Xu6jnyCgM8J3maTU9JQV
         9G2t3RB/ZyialxoMtxnjhVqZ/Yz5D7M7qB+epat9cWSN1/fyRrEHd81t/Gxr8P2ja8lL
         Ky4e/ACib+0SodL8CDuBNdT0EmEvzDM74RllOsoa1DxI6E7DIyx32bmXsefayTzUm8Mz
         DJibCIphznDl0cMKQZpeNVCTRqadEL6PLO2+dHNvk0LKMoE9t60VbDrPFHSJ1SPcA+yl
         VN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iJIrFiPrthxhWR/A1W4z3Dcqg+LQz4AuT3GYaAloBA=;
        b=SJq+D3P9CkEhyJY4YdLTj/abySTno9yCLqvPcMtJ0pITzjhodjNvUQK3vP4incfOBB
         eCeFYe88BC6IclT7y9aZ3YTceL3VZeIguSMF/DBWCQj/jWnD0qmwPZzHWJi0UrK8Jywk
         PSgK76G+ve9ME2O4+oun8iuXHS3T2eWEPLxwB6PGpQ+2noZ11RAyjy3LI8vU+vwkuCKB
         rcXnrqlblqY15qZaY7of/7hkmB7ImLOaiXoIfYaTZ8y4wDvaCY2lwToT0rOqQGYdZdcU
         VJpnij7j5AK5z0Zvt1RT9pZPt+5OUoJv32REWkvwnU2eSWTvoknxHlMdvJLvqAd7nNrY
         qoIA==
X-Gm-Message-State: AOAM530Jdu9sIHI22LrI9G4P+X9qIgMlCSTuOQ5slv6v8MSm5zFy4R5V
        ymsEWEcSlRTzCnuO0eZQJ6qXIu6p2PhohEEMLZrCt1LSi2urVw==
X-Google-Smtp-Source: ABdhPJy6MIIdbvLYKBOQIzmZLcO7OWcE4uQ0vDEm/jLOAh6B4JGz5ZPiZggdqVLrP+uq6zNUPFLurlO2Qnos9mx+P/g=
X-Received: by 2002:adf:db48:: with SMTP id f8mr16058134wrj.144.1600084204302;
 Mon, 14 Sep 2020 04:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200912002341.4869-1-atish.patra@wdc.com> <20200912104502.GF2142832@kernel.org>
In-Reply-To: <20200912104502.GF2142832@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 14 Sep 2020 17:19:52 +0530
Message-ID: <CAAhSdy1D2BC4Z=nf7Tv6znQMMGwaVNH0QhO0Oj6gqYwwbnLt_g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Consider sparse memory while removing unusable memory
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 4:15 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> Hello Atish,
>
> On Fri, Sep 11, 2020 at 05:23:41PM -0700, Atish Patra wrote:
> > Currently, any usable memory area beyond page_offset is removed by adding the
> > memory sizes from each memblock. That may not work for sparse memory
> > as memory regions can be very far apart resulting incorrect removal of some
> > usable memory.
>
> If I understand correctly, the memory with physical addresses larger
> than (-PAGE_OFFSET) cannot be used. Since it was aready
> memblock_add()'ed during device tree parsing, you need to remove it from
> memblock.

-PAGE_OFFSET represents the size of memory addressable by the kernel and
not the last physical address.

mem_start + (-PAGE_OFFSET) will be the last physical address usable by kernel.

>
> For that you can use memblock_enforce_memory_limit(-PAGE_OFFSET).

I think we should use memblock_enforce_memory_limit(mem_start - PAGE_OFFSET).

Regards,
Anup

>
> > Just use the start of the first memory block and the end of the last memory
> > block to compute the size of the total memory that can be used.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/mm/init.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 787c75f751a5..188281fc2816 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -147,7 +147,6 @@ void __init setup_bootmem(void)
> >  {
> >       struct memblock_region *reg;
> >       phys_addr_t mem_size = 0;
> > -     phys_addr_t total_mem = 0;
> >       phys_addr_t mem_start, end = 0;
> >       phys_addr_t vmlinux_end = __pa_symbol(&_end);
> >       phys_addr_t vmlinux_start = __pa_symbol(&_start);
> > @@ -155,18 +154,17 @@ void __init setup_bootmem(void)
> >       /* Find the memory region containing the kernel */
> >       for_each_memblock(memory, reg) {
> >               end = reg->base + reg->size;
> > -             if (!total_mem)
> > +             if (!mem_start)
> >                       mem_start = reg->base;
> >               if (reg->base <= vmlinux_start && vmlinux_end <= end)
> >                       BUG_ON(reg->size == 0);
> > -             total_mem = total_mem + reg->size;
> >       }
> >
> >       /*
> >        * Remove memblock from the end of usable area to the
> >        * end of region
> >        */
> > -     mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
> > +     mem_size = min(end - mem_start, (phys_addr_t)-PAGE_OFFSET);
> >       if (mem_start + mem_size < end)
> >               memblock_remove(mem_start + mem_size,
> >                               end - mem_start - mem_size);
> > --
> > 2.24.0
> >
>
> --
> Sincerely yours,
> Mike.
