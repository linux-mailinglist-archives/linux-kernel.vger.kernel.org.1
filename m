Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E4128BAC3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389582AbgJLOYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgJLOX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:23:59 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 000E9208B6;
        Mon, 12 Oct 2020 14:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602512639;
        bh=mkV3zHZdLWkkkiotMkWaHSfgaeAhT3IEqlhrwfXJLpw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0rXs3HhXixR1Sr37VrUEPvUFG1NCTuJpfMTLxVMP92+0rAz5djPDI+ROp0ZyKO0xl
         3S9JxTOG3bQA1KMy3Ynj60I3PBNyAG4ehU+u927VFzGinJ7Eofns7pBdP7py3rMWyl
         A/Cfj22OgdukPF1xOzZyrZAF81y+S2lUL/io4i7w=
Received: by mail-ot1-f53.google.com with SMTP id l4so15969929ota.7;
        Mon, 12 Oct 2020 07:23:58 -0700 (PDT)
X-Gm-Message-State: AOAM530IGnyID9T/B1WQ73MCBaZyPFVjEqSwH4m9BmtkjQyKBql9ogIk
        xYMHAm6WGCwD/ZtEXytm+sH0ut6vXkw/aHpKP20=
X-Google-Smtp-Source: ABdhPJxdPTaQgCziNQnn1xG1IdFeKsHKlCipNToXN2Mp8aZ6g8wZ+Ii9TOczjjBJ/F+8iATwtdtq/fW0RpyMunMLK3M=
X-Received: by 2002:a9d:6c92:: with SMTP id c18mr9080953otr.108.1602512638334;
 Mon, 12 Oct 2020 07:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
 <20201010151235.20585-2-nsaenzjulienne@suse.de> <20201012113748.GE9844@gaia>
In-Reply-To: <20201012113748.GE9844@gaia>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 12 Oct 2020 16:23:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFUH7gv-dPVNM8xa5SBHhSndCQu4QFy5os2vAkaO_yecg@mail.gmail.com>
Message-ID: <CAMj1kXFUH7gv-dPVNM8xa5SBHhSndCQu4QFy5os2vAkaO_yecg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        iommu@lists.linux-foundation.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 at 13:37, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Sat, Oct 10, 2020 at 05:12:31PM +0200, Nicolas Saenz Julienne wrote:
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index f6902a2b4ea6..0eca5865dcb1 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -196,14 +196,16 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
> >       unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> >
> >  #ifdef CONFIG_ZONE_DMA
> > +     zone_dma_bits = ARM64_ZONE_DMA_BITS;
> > +
> >       if (IS_ENABLED(CONFIG_ACPI)) {
> >               extern unsigned int acpi_iort_get_zone_dma_size(void);
> >
> >               zone_dma_bits = min(zone_dma_bits,
> >                                   acpi_iort_get_zone_dma_size());
> > -             arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> >       }
> >
> > +     arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> >       max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
> >  #endif
> >  #ifdef CONFIG_ZONE_DMA32
> > @@ -394,11 +396,6 @@ void __init arm64_memblock_init(void)
> >
> >       early_init_fdt_scan_reserved_mem();
> >
> > -     if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> > -             zone_dma_bits = ARM64_ZONE_DMA_BITS;
> > -             arm64_dma_phys_limit = max_zone_phys(ARM64_ZONE_DMA_BITS);
> > -     }
>
> arm64_dma_phys_limit is used by memblock_alloc_low() (via
> ARCH_LOW_ADDRESS_LIMIT). I think it's too late to leave its
> initialisation to zone_sizes_init().
>

The only generic caller of memblock_alloc_low() is swiotlb_init(),
which is called much later. So at that point, we definitely need
ARCH_LOW_ADDRESS_LIMIT to be set correctly, but that means doing it in
zone_sizes_init() is early enough.

So the only problematic reference seems to be crashkernel_reserve() afaict.
