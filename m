Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7BD28A301
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbgJJW7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731907AbgJJTyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:15 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 044D82173E;
        Sat, 10 Oct 2020 10:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602326202;
        bh=drBUl94hJDiJbg7EAVxrflroZLL9cGY6sJkpslPiZ5s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rKy3ckBBBgFebn68RQgydnukpiggooqY/F0UdxKn+PD4vBKQFsw9OUH0z/Br8qzHL
         vqXLEt7HvxX5ixXoMa6fe3GoyAotCaowYAzljQILgN2nuY+ugEd4yxrmWqTA8qruKo
         /9s7DKu5OmwTNMIx2nhbM/00epBYdkcLbPkrKE5w=
Received: by mail-ot1-f53.google.com with SMTP id t15so11384074otk.0;
        Sat, 10 Oct 2020 03:36:41 -0700 (PDT)
X-Gm-Message-State: AOAM531/rG6LPQrqOxjVBKIVhE2Av8dXVvs63RBl0ahzfOuczDXaT0FR
        x5c2mSSNBIy/Oa+qSD2JbfgRlSYodiryUiaMJl0=
X-Google-Smtp-Source: ABdhPJyRUmME/uNQCpEvmy5TmuigC5HqxkAmy4br3cKJSuYPDqK1iFTDzWqlHrlHAracvofdjaHYJW7dOhpWJoeIxWo=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr12561956otq.77.1602326201362;
 Sat, 10 Oct 2020 03:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201001172320.GQ21544@gaia> <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia> <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201009071013.GA12208@lst.de> <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
 <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de> <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
 <20201009152433.GA19953@e121166-lin.cambridge.arm.com> <CAMj1kXFuqw3qNRAB78OzvMws+t7=B6L8pASA36D2fxXobbvpUA@mail.gmail.com>
 <20201009171051.GL23638@gaia>
In-Reply-To: <20201009171051.GL23638@gaia>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 10 Oct 2020 12:36:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEWeqGVr=QV7zQ+dXBK=t_Lh+W9q1+kLLdBw8=Pj798Ng@mail.gmail.com>
Message-ID: <CAMj1kXEWeqGVr=QV7zQ+dXBK=t_Lh+W9q1+kLLdBw8=Pj798Ng@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020 at 19:10, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Oct 09, 2020 at 06:23:06PM +0200, Ard Biesheuvel wrote:
> > On Fri, 9 Oct 2020 at 17:24, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > We can move this check to IORT code and call it from arm64 if it
> > > can be made to work.
> >
> > Finding the smallest value in the IORT, and assigning it to
> > zone_dma_bits if it is < 32 should be easy. But as I understand it,
> > having these separate DMA and DMA32 zones is what breaks kdump, no? So
> > how is this going to fix the underlying issue?
>
> If zone_dma_bits is 32, ZONE_DMA32 disappears into ZONE_DMA (GFP_DMA32
> allocations fall back to ZONE_DMA).
>
> kdump wants DMA-able memory and, without a 30-bit ZONE_DMA, that would
> be the bottom 32-bit. With the introduction of ZONE_DMA, this suddenly
> became 1GB. We could change kdump to allocate ZONE_DMA32 but this one
> may also be small as it lost 1GB to ZONE_DMA. However, the kdump kernel
> would need to be rebuilt without ZONE_DMA since it won't have any. IIRC
> (it's been a while since I looked), the kdump allocation couldn't span
> multiple zones.
>
> In a separate thread, we try to fix kdump to use allocations above 4G as
> a fallback but this only fixes platforms with enough RAM (and maybe it's
> only those platforms that care about kdump).
>

One thing that strikes me as odd is that we are applying the same
shifting logic to ZONE_DMA as we are applying to ZONE_DMA32, i.e., if
DRAM starts outside of the zone, it is shifted upwards.

On a typical ARM box, this gives me

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000]   DMA32    [mem 0x00000000c0000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000000fffffffff]

i.e., the 30-bit addressable range has bit 31 set, which is weird.

I wonder if it wouldn't be better (and less problematic in the general
case) to drop this logic for ZONE_DMA, and simply let it remain empty
unless there is really some memory there.
