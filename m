Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78F328A2FF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390789AbgJJW7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732633AbgJJTyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:39 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1DFA21655;
        Sat, 10 Oct 2020 12:38:57 +0000 (UTC)
Date:   Sat, 10 Oct 2020 13:38:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
Message-ID: <20201010123854.GA27186@gaia>
References: <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201009071013.GA12208@lst.de>
 <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
 <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
 <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
 <20201009152433.GA19953@e121166-lin.cambridge.arm.com>
 <CAMj1kXFuqw3qNRAB78OzvMws+t7=B6L8pASA36D2fxXobbvpUA@mail.gmail.com>
 <20201009171051.GL23638@gaia>
 <CAMj1kXEWeqGVr=QV7zQ+dXBK=t_Lh+W9q1+kLLdBw8=Pj798Ng@mail.gmail.com>
 <e62784bde26293c26fcc2fee50133dc445c084ab.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e62784bde26293c26fcc2fee50133dc445c084ab.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 12:53:19PM +0200, Nicolas Saenz Julienne wrote:
> On Sat, 2020-10-10 at 12:36 +0200, Ard Biesheuvel wrote:
> > On Fri, 9 Oct 2020 at 19:10, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Fri, Oct 09, 2020 at 06:23:06PM +0200, Ard Biesheuvel wrote:
> > > > On Fri, 9 Oct 2020 at 17:24, Lorenzo Pieralisi
> > > > <lorenzo.pieralisi@arm.com> wrote:
> > > > > We can move this check to IORT code and call it from arm64 if it
> > > > > can be made to work.
> > > > 
> > > > Finding the smallest value in the IORT, and assigning it to
> > > > zone_dma_bits if it is < 32 should be easy. But as I understand it,
> > > > having these separate DMA and DMA32 zones is what breaks kdump, no? So
> > > > how is this going to fix the underlying issue?
> > > 
> > > If zone_dma_bits is 32, ZONE_DMA32 disappears into ZONE_DMA (GFP_DMA32
> > > allocations fall back to ZONE_DMA).
> > > 
> > > kdump wants DMA-able memory and, without a 30-bit ZONE_DMA, that would
> > > be the bottom 32-bit. With the introduction of ZONE_DMA, this suddenly
> > > became 1GB. We could change kdump to allocate ZONE_DMA32 but this one
> > > may also be small as it lost 1GB to ZONE_DMA. However, the kdump kernel
> > > would need to be rebuilt without ZONE_DMA since it won't have any. IIRC
> > > (it's been a while since I looked), the kdump allocation couldn't span
> > > multiple zones.
> > > 
> > > In a separate thread, we try to fix kdump to use allocations above 4G as
> > > a fallback but this only fixes platforms with enough RAM (and maybe it's
> > > only those platforms that care about kdump).
> > > 
> > 
> > One thing that strikes me as odd is that we are applying the same
> > shifting logic to ZONE_DMA as we are applying to ZONE_DMA32, i.e., if
> > DRAM starts outside of the zone, it is shifted upwards.
> > 
> > On a typical ARM box, this gives me
> > 
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000080000000-0x00000000bfffffff]
> > [    0.000000]   DMA32    [mem 0x00000000c0000000-0x00000000ffffffff]
> > [    0.000000]   Normal   [mem 0x0000000100000000-0x0000000fffffffff]
> > 
> > i.e., the 30-bit addressable range has bit 31 set, which is weird.
> 
> Yes I agree it's weird, and IMO plain useless. I sent a series this summer to
> address this[1], which ultimately triggered the discussion we're having right
> now.

I don't mind assuming that ZONE_DMA is always from pfn 0 (i.e. no
dma_offset for such constrained devices). But if ZONE_DMA32 is squeezed
out with ZONE_DMA extended to 4GB, it should allow non-zero upper 32
bits. IIRC we do have SoCs with RAM starting above 4GB.

However, your patch didn't completely solve the problem for non-RPi4
platforms as there's hardware with RAM starting at 0 that doesn't need
the 1GB ZONE_DMA. We may end up with a combination of the two
approaches.

> Although with with your latest patch and the DT counterpart, we should be OK.
> It would be weird for a HW description to define DMA constraints that are
> impossible to reach on that system.

I don't remember the difficulties with parsing a DT early for inferring
the ZONE_DMA requirements. Could we not check the dma-ranges property in
the soc node? I can see bcm2711.dtsi defines a 30-bit address range. We
are not interested in the absolute physical/bus addresses, just the
size to check whether it's smaller than 32-bit.

> > I wonder if it wouldn't be better (and less problematic in the general
> > case) to drop this logic for ZONE_DMA, and simply let it remain empty
> > unless there is really some memory there.
> 
> From my experience, you can't have empty ZONE_DMA when enabled. Empty
> ZONE_DMA32 is OK though. Although I'm sure it's something that can be changed.

Indeed, because we still have GFP_DMA around which can't fall back to
ZONE_DMA32 (well, unless CONFIG_ZONE_DMA is disabled).

-- 
Catalin
