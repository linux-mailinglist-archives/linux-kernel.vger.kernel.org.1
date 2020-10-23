Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7612975DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753605AbgJWRiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbgJWRiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:38:17 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A7721527;
        Fri, 23 Oct 2020 17:38:13 +0000 (UTC)
Date:   Fri, 23 Oct 2020 18:38:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, hch@lst.de, ardb@kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com
Subject: Re: [PATCH v4 5/7] arm64: mm: Set ZONE_DMA size based on
 devicetree's dma-ranges
Message-ID: <20201023173810.GH25736@gaia>
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
 <20201021123437.21538-6-nsaenzjulienne@suse.de>
 <20201022180632.GI1229@gaia>
 <a6ab535a70958b1f79b45583eef8ba7f7172f9ce.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6ab535a70958b1f79b45583eef8ba7f7172f9ce.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 05:27:49PM +0200, Nicolas Saenz Julienne wrote:
> On Thu, 2020-10-22 at 19:06 +0100, Catalin Marinas wrote:
> > On Wed, Oct 21, 2020 at 02:34:35PM +0200, Nicolas Saenz Julienne wrote:
> > > @@ -188,9 +186,11 @@ static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
> > >  static void __init zone_sizes_init(unsigned long min, unsigned long max)
> > >  {
> > >  	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> > > +	unsigned int __maybe_unused dt_zone_dma_bits;
> > >  
> > >  #ifdef CONFIG_ZONE_DMA
> > > -	zone_dma_bits = ARM64_ZONE_DMA_BITS;
> > > +	dt_zone_dma_bits = ilog2(of_dma_get_max_cpu_address(NULL));
> > > +	zone_dma_bits = min(32U, dt_zone_dma_bits);
> > 
> > A thought: can we remove the min here and expand ZONE_DMA to whatever
> > dt_zone_dma_bits says? More on this below.
> 
> On most platforms we'd get PHYS_ADDR_MAX, or something bigger than the actual
> amount of RAM. Which would ultimately create a system wide ZONE_DMA. At first
> sight, I don't see it breaking dma-direct in any way.
> 
> On the other hand, there is a big amount of MMIO devices out there that can
> only handle 32-bit addressing. Be it PCI cards or actual IP cores. To make
> things worse, this limitation is often expressed in the driver, not FW (with
> dma_set_mask() and friends). If those devices aren't behind an IOMMU we have be
> able to provide at least 32-bit addressable memory. See this comment from
> dma_direct_supported():
> 
> /*
>  * Because 32-bit DMA masks are so common we expect every architecture
>  * to be able to satisfy them - either by not supporting more physical
>  * memory, or by providing a ZONE_DMA32.  If neither is the case, the
>  * architecture needs to use an IOMMU instead of the direct mapping.
>  */
> 
> I think, for the common case, we're stuck with at least one zone spanning the
> 32-bit address space.

You are right, I guess it makes sense to keep a 32-bit zone as not all
devices would be described as such.

> > >  	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> > >  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
> > >  #endif
> > 
> > I was talking earlier to Ard and Robin on the ZONE_DMA32 history and the
> > need for max_zone_phys(). This was rather theoretical, the Seattle
> > platform has all RAM starting above 4GB and that led to an empty
> > ZONE_DMA32 originally. The max_zone_phys() hack was meant to lift
> > ZONE_DMA32 into the bottom of the RAM, on the assumption that such
> > 32-bit devices would have a DMA offset hardwired. We are not aware of
> > any such case on arm64 systems and even on Seattle, IIUC 32-bit devices
> > only work if they are behind an SMMU (so no hardwired offset).
> > 
> > In hindsight, it would have made more sense on platforms with RAM above
> > 4GB to expand ZONE_DMA32 to cover the whole memory (so empty
> > ZONE_NORMAL). Something like:
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index a53c1e0fb017..7d5e3dd85617 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -187,8 +187,12 @@ static void __init reserve_elfcorehdr(void)
> >   */
> >  static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
> >  {
> > -	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, zone_bits);
> > -	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
> > +	phys_addr_t zone_mask = 1ULL << zone_bits;
> > +
> > +	if (!(memblock_start_of_DRAM() & zone_mask))
> > +		zone_mask = PHYS_ADDR_MAX;
> > +
> > +	return min(zone_mask, memblock_end_of_DRAM());
> >  }
> >  
> >  static void __init zone_sizes_init(unsigned long min, unsigned long max)
> > 
> > I don't think this makes any difference for ZONE_DMA unless a
> > broken DT or IORT reports the max CPU address below the start of DRAM.
> > 
> > There's a minor issue if of_dma_get_max_cpu_address() matches
> > memblock_end_of_DRAM() but they are not a power of 2. We'd be left with
> > a bit of RAM at the end in ZONE_NORMAL due to ilog2 truncation.
> 
> I agree it makes no sense to create more than one zone when the beginning of
> RAM is located above the 32-bit address space. I'm all for disregarding the
> possibility of hardwired offsets. As a bonus, as we already discussed some time
> ago, this is something that never played well with current dma-direct code[1].
> 
> [1] https://lkml.org/lkml/2020/9/8/377

Maybe this one is still worth fixing, at least for consistency. But it's
not urgent.

My diff above has a side-effect that if dt_zone_dma_bits is below the
start of DRAM, ZONE_DMA gets expanded to PHYS_ADDR_MAX. If this was
32-bit, that's fine but if it was, say, 30-bit because of some firmware
misdescription with RAM starting at 2GB, we end up with no ZONE_DMA32. I
think max_zone_phys() could cap this at 32, as a safety mechanism:

static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
{
	phys_addr_t zone_mask = (1ULL << zone_bits) - 1;
	phys_addr_t phys_start = memblock_start_of_DRAM();

	if (!(phys_start & U32_MAX))
		zone_mask = PHYS_ADDR_MAX;
	else if (!(phys_start & zone_mask))
		zone_mask = U32_MAX;

	return min(zone_mask + 1, memblock_end_of_DRAM());
}

Assuming I got the shifting right, arm64_dma_phys_limit becomes:

 	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits, 32);

-- 
Catalin
