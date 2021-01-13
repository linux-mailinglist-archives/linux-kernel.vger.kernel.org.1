Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77FA2F4EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbhAMPgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:36:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbhAMPf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:35:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C93823382;
        Wed, 13 Jan 2021 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610552118;
        bh=2fAgPs8iRZixNE2rGkHki+efkxNdgYDH4FZy5LEv3VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1A4eKBwHqwQQ2qYuC89b9+He4HlKjY0H1dYtNxwyMT1oMmsGzwt+gLl63i2hjr1b
         9sgIxpyB+ZheqIH0ZoEmwq1UQ0WAVGYMFLywO98V8JVaxMLEKFhfm4Vterv2EU3E5Z
         WWy3f8OpFdPxLS1J7URvHGbvbvWE109iF1jVLsswncBHyEPBbnpTfBDeGOyrr7NSfP
         3GV2yongEt7ACqpbIeZNbXwKqoIvbsjPvuFt2C2tvbH6M2wpqT7muGV1QwcJR5LETC
         VeWPNG8dZ6HLSVFLjyz9VIwyobCOsMVGIOB3tNwRBxL4W3fNsZb1qR8ZLP9xniiOV5
         8BfaF45qcxrkA==
Date:   Wed, 13 Jan 2021 17:35:09 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/setup: don't remove E820_TYPE_RAM for pfn 0
Message-ID: <20210113153509.GH1106298@kernel.org>
References: <20210111194017.22696-1-rppt@kernel.org>
 <20210111194017.22696-2-rppt@kernel.org>
 <6ba6bde3-1520-5cd0-f987-32d543f0b79f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ba6bde3-1520-5cd0-f987-32d543f0b79f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 01:56:45PM +0100, David Hildenbrand wrote:
> On 11.01.21 20:40, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The first 4Kb of memory is a BIOS owned area and to avoid its allocation
> > for the kernel it was not listed in e820 tables as memory. As the result,
> > pfn 0 was never recognised by the generic memory management and it is not a
> > part of neither node 0 nor ZONE_DMA.
> > 
> > If set_pfnblock_flags_mask() would be ever called for the pageblock
> > corresponding to the first 2Mbytes of memory, having pfn 0 outside of
> > ZONE_DMA would trigger
> > 
> > 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
> > 
> > Along with reserving the first 4Kb in e820 tables, several first pages are
> > reserved with memblock in several places during setup_arch(). These
> > reservations are enough to ensure the kernel does not touch the BIOS area
> > and it is not necessary to remove E820_TYPE_RAM for pfn 0.
> > 
> > Remove the update of e820 table that changes the type of pfn 0 and move the
> > comment describing why it was done to trim_low_memory_range() that reserves
> > the beginning of the memory.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/x86/kernel/setup.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 740f3bdb3f61..3412c4595efd 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -660,17 +660,6 @@ static void __init trim_platform_memory_ranges(void)
> >  
> >  static void __init trim_bios_range(void)
> >  {
> > -	/*
> > -	 * A special case is the first 4Kb of memory;
> > -	 * This is a BIOS owned area, not kernel ram, but generally
> > -	 * not listed as such in the E820 table.
> > -	 *
> > -	 * This typically reserves additional memory (64KiB by default)
> > -	 * since some BIOSes are known to corrupt low memory.  See the
> > -	 * Kconfig help text for X86_RESERVE_LOW.
> > -	 */
> > -	e820__range_update(0, PAGE_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > -
> >  	/*
> >  	 * special case: Some BIOSes report the PC BIOS
> >  	 * area (640Kb -> 1Mb) as RAM even though it is not.
> > @@ -728,6 +717,15 @@ early_param("reservelow", parse_reservelow);
> >  
> >  static void __init trim_low_memory_range(void)
> >  {
> > +	/*
> > +	 * A special case is the first 4Kb of memory;
> > +	 * This is a BIOS owned area, not kernel ram, but generally
> > +	 * not listed as such in the E820 table.
> > +	 *
> > +	 * This typically reserves additional memory (64KiB by default)
> > +	 * since some BIOSes are known to corrupt low memory.  See the
> > +	 * Kconfig help text for X86_RESERVE_LOW.
> > +	 */
> >  	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
> >  }
> >  	
> > 
> 
> The only somewhat-confusing thing is that in-between
> e820__memblock_setup() and trim_low_memory_range(), we already have
> memblock allocations. So [0..4095] might look like ordinary memory until
> we reserve it later on.
> 
> E.g., reserve_real_mode() does a
> 
> mem = memblock_find_in_range(0, 1<<20, size, PAGE_SIZE);
> ...
> memblock_reserve(mem, size);
> set_real_mode_mem(mem);
> 
> which looks kind of suspicious to me. Most probably I am missing
> something, just wanted to point that out. We might want to do such
> trimming/adjustments before any kind of allocations.

You are right and it looks suspicious, but the first page is reserved at
the very beginning of x86::setup_arch() and, moreover, memblock never
allocates it (look at memblock::memblock_find_in_range_node()).

As for the range 0x1000 <-> reserve_low, we are unlikely to allocate it in
the default top-down mode. The bottom-up mode was only allocating memory
above the kernel so this would also prevent allocation of the lowest
memory, at least until the recent changes for CMA allocation:

https://lore.kernel.org/lkml/20201217201214.3414100-1-guro@fb.com

That said, we'd better consolidate all the trim_some_memory() and move it
closer to the beginning of setup_arch().
I'm going to take a look at it in the next few days.
 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
