Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E1D2B9912
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgKSRK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:10:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgKSRK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:10:56 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F167241A6;
        Thu, 19 Nov 2020 17:10:52 +0000 (UTC)
Date:   Thu, 19 Nov 2020 17:10:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     James Morse <james.morse@arm.com>, robh+dt@kernel.org, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        will@kernel.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        Chen Zhou <chenzhou10@huawei.com>
Subject: Re: [PATCH v6 1/7] arm64: mm: Move reserve_crashkernel() into
 mem_init()
Message-ID: <20201119171048.GD4376@gaia>
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
 <20201103173159.27570-2-nsaenzjulienne@suse.de>
 <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
 <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
 <X6rZRvWyigCJxAVW@trantor>
 <b5336064145a30aadcfdb8920226a8c63f692695.camel@suse.de>
 <20201113112901.GA3212@gaia>
 <ba343af12fc60bce36837cc090a39c9e42457788.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba343af12fc60bce36837cc090a39c9e42457788.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 03:09:58PM +0100, Nicolas Saenz Julienne wrote:
> On Fri, 2020-11-13 at 11:29 +0000, Catalin Marinas wrote:
> [...]
> > > > > Let me stress that knowing the DMA constraints in the system before reserving
> > > > > crashkernel's regions is necessary if we ever want it to work seamlessly on all
> > > > > platforms. Be it small stuff like the Raspberry Pi or huge servers with TB of
> > > > > memory.
> > > > 
> > > > Indeed. So we have 3 options (so far):
> > > > 
> > > > 1. Allow the crashkernel reservation to go into the linear map but set
> > > >    it to invalid once allocated.
> > > > 
> > > > 2. Parse the flattened DT (not sure what we do with ACPI) before
> > > >    creating the linear map. We may have to rely on some SoC ID here
> > > >    instead of actual DMA ranges.
> > > > 
> > > > 3. Assume the smallest ZONE_DMA possible on arm64 (1GB) for crashkernel
> > > >    reservations and not rely on arm64_dma_phys_limit in
> > > >    reserve_crashkernel().
> > > > 
> > > > I think (2) we tried hard to avoid. Option (3) brings us back to the
> > > > issues we had on large crashkernel reservations regressing on some
> > > > platforms (though it's been a while since, they mostly went quiet ;)).
> > > > However, with Chen's crashkernel patches we end up with two
> > > > reservations, one in the low DMA zone and one higher, potentially above
> > > > 4GB. Having a fixed 1GB limit wouldn't be any worse for crashkernel
> > > > reservations than what we have now.
> > > > 
> > > > If (1) works, I'd go for it (James knows this part better than me),
> > > > otherwise we can go for (3).
> > > 
> > > Overall, I'd prefer (1) as well, and I'd be happy to have a got at it. If not
> > > I'll append (3) in this series.
> > 
> > I think for 1 we could also remove the additional KEXEC_CORE checks,
> > something like below, untested:
> > 
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 3e5a6913acc8..27ab609c1c0c 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -477,7 +477,8 @@ static void __init map_mem(pgd_t *pgdp)
> >  	int flags = 0;
> >  	u64 i;
> >  
> > -	if (rodata_full || debug_pagealloc_enabled())
> > +	if (rodata_full || debug_pagealloc_enabled() ||
> > +	    IS_ENABLED(CONFIG_KEXEC_CORE))
> >  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >  
> >  	/*
> > @@ -487,11 +488,6 @@ static void __init map_mem(pgd_t *pgdp)
> >  	 * the following for-loop
> >  	 */
> >  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> > -#ifdef CONFIG_KEXEC_CORE
> > -	if (crashk_res.end)
> > -		memblock_mark_nomap(crashk_res.start,
> > -				    resource_size(&crashk_res));
> > -#endif
> >  
> >  	/* map all the memory banks */
> >  	for_each_mem_range(i, &start, &end) {
> > @@ -518,21 +514,6 @@ static void __init map_mem(pgd_t *pgdp)
> >  	__map_memblock(pgdp, kernel_start, kernel_end,
> >  		       PAGE_KERNEL, NO_CONT_MAPPINGS);
> >  	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> > -
> > -#ifdef CONFIG_KEXEC_CORE
> > -	/*
> > -	 * Use page-level mappings here so that we can shrink the region
> > -	 * in page granularity and put back unused memory to buddy system
> > -	 * through /sys/kernel/kexec_crash_size interface.
> > -	 */
> > -	if (crashk_res.end) {
> > -		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
> > -			       PAGE_KERNEL,
> > -			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> > -		memblock_clear_nomap(crashk_res.start,
> > -				     resource_size(&crashk_res));
> > -	}
> > -#endif
> >  }
> >  
> >  void mark_rodata_ro(void)
> 
> So as far as I'm concerned this is good enough for me. I took the time to
> properly test crashkernel on RPi4 using the series, this patch, and another
> small fix to properly update /proc/iomem.
> 
> I'll send v7 soon, but before, James (or anyone for that matter) any obvious
> push-back to Catalin's solution?

I talked to James earlier and he was suggesting that we check the
command line for any crashkernel reservations and only disable block
mappings in that case, see the diff below on top of the one I already
sent (still testing it).

If you don't have any other changes for v7, I'm happy to pick v6 up on
top of the no-block-mapping fix.

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ed71b1c305d7..acdec0c67d3b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -469,6 +469,21 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
+static bool crash_mem_map __initdata;
+
+static int __init enable_crash_mem_map(char *arg)
+{
+	/*
+	 * Proper parameter parsing is done by reserve_crashkernel(). We only
+	 * need to know if the linear map has to avoid block mappings so that
+	 * the crashkernel reservations can be unmapped later.
+	 */
+	crash_mem_map = false;
+
+	return 0;
+}
+early_param("crashkernel", enable_crash_mem_map);
+
 static void __init map_mem(pgd_t *pgdp)
 {
 	phys_addr_t kernel_start = __pa_symbol(_stext);
@@ -477,8 +492,7 @@ static void __init map_mem(pgd_t *pgdp)
 	int flags = 0;
 	u64 i;
 
-	if (rodata_full || debug_pagealloc_enabled() ||
-	    IS_ENABLED(CONFIG_KEXEC_CORE))
+	if (rodata_full || debug_pagealloc_enabled() || crash_mem_map)
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
