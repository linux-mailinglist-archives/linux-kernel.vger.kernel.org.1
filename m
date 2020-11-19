Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19B22B906B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgKSKsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:48:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:54218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgKSKsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:48:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85D91AA4F;
        Thu, 19 Nov 2020 10:48:49 +0000 (UTC)
Date:   Thu, 19 Nov 2020 11:48:47 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH 3/3] mm,memory_hotplug: Allocate memmap from the
 added memory range
Message-ID: <20201119104847.GA5281@localhost.localdomain>
References: <20201022125835.26396-1-osalvador@suse.de>
 <20201022125835.26396-4-osalvador@suse.de>
 <3cc37927-538e-ae7d-27bc-45aaabe06b3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc37927-538e-ae7d-27bc-45aaabe06b3a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:38:52PM +0100, David Hildenbrand wrote:
> Sorry for the late replay, fairly busy with all kinds of things.

Heh, no worries, I appreciate the time :-)

> > diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> > index b02fd51e5589..6b57bf90ca72 100644
> > --- a/drivers/acpi/acpi_memhotplug.c
> > +++ b/drivers/acpi/acpi_memhotplug.c
> > @@ -195,7 +195,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
> >   			node = memory_add_physaddr_to_nid(info->start_addr);
> >   		result = __add_memory(node, info->start_addr, info->length,
> > -				      MHP_NONE);
> > +				      MEMHP_MEMMAP_ON_MEMORY);
> 
> I'd suggest moving that into a separate patch.

Fine by me

> > diff --git a/include/linux/memory.h b/include/linux/memory.h
> > index 439a89e758d8..7cc93de5856c 100644
> > --- a/include/linux/memory.h
> > +++ b/include/linux/memory.h
> > @@ -30,6 +30,7 @@ struct memory_block {
> >   	int phys_device;		/* to which fru does this belong? */
> >   	struct device dev;
> >   	int nid;			/* NID for this memory block */
> > +	unsigned long nr_vmemmap_pages;	/* Number for vmemmap pages */
> 
> Maybe also document that these pages are directly at the beginning of the
> memory block.

Sure

> > -static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> > +static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> > +				unsigned long nr_vmemmap_pages)
> >   {
> >   	return -EINVAL;
> >   }
> > @@ -369,10 +372,12 @@ extern int add_memory_driver_managed(int nid, u64 start, u64 size,
> >   				     mhp_t mhp_flags);
> >   extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
> >   				   unsigned long nr_pages,
> > +				   unsigned long nr_vmemmap_pages,
> >   				   struct vmem_altmap *altmap, int migratetype);
> >   extern void remove_pfn_range_from_zone(struct zone *zone,
> >   				       unsigned long start_pfn,
> > -				       unsigned long nr_pages);
> > +				       unsigned long nr_pages,
> > +				       unsigned long nr_vmemmap_pages);
> 
> I think we should not pass nr_vmemmap_pages down here but instead do two
> separate calls to move_pfn_range_to_zone()/remove_pfn_range_from_zone() from
> online_pages()/offline_pages()
> 
> 1. for vmemmap pages, migratetype = MIGRATE_UNMOVABLE
> 2. for remaining pages, migratetype = MIGRATE_ISOLATE

Ok, that was the other option, it might be even cleaner.

> > +	valid_start_pfn = pfn + nr_vmemmap_pages;
> > +	valid_nr_pages = nr_pages - nr_vmemmap_pages;
> 
> Hm, valid sounds strange. More like "free_start_pfn" or "buddy_start_pfn".

Agreed, I might lean towards buddy_start_pfn.

> > -	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
> > +	move_pfn_range_to_zone(zone, pfn, nr_pages, nr_vmemmap_pages, NULL,
> > +			       MIGRATE_ISOLATE);
> 
> As mentioned, I'd suggest properly initializing the memmap here
> 
> if (nr_vmemmap_pages) {
> 	move_pfn_range_to_zone(zone, pfn, nr_vmemmap_pages, NULL,
> 			       MIGRATE_UNMOVABLE);
> }
> move_pfn_range_to_zone(zone, valid_start_pfn, valid_nr_pages, NULL,

Sure, agreed.

> > +	if (!support_memmap_on_memory(size))
> > +		mhp_flags &= ~MEMHP_MEMMAP_ON_MEMORY;
> 
> Callers (e.g., virtio-mem) might rely on this. We should reject this with
> -EINVAL and provide a way for callers to test whether this flag is possible.

Uhm, we might want to make "support_memmap_on_memory" public, and
callers who might want to it use can check its return value?
Or do you have something else in mind?

Agreed on the -EINVAIL.

> > +	if (mhp_flags & MEMHP_MEMMAP_ON_MEMORY)
> > +		mhp_mark_vmemmap_pages(params.altmap);
> 
> Do we really still need that? Pages are offline, so we're messing with an
> invalid memmap. online_pages() should handle initializing the memmap of
> these pages.

Yeah, on a second thought we do not need this.
Since the pages are still offline, no one should be messing with that
range yet anyway.

> 
> [...]
> 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index e74ca22baaa1..043503fb8c6e 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -8761,6 +8761,13 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
> >   	spin_lock_irqsave(&zone->lock, flags);
> >   	while (pfn < end_pfn) {
> >   		page = pfn_to_page(pfn);
> > +		/*
> > +		 * Skip vmemmap pages
> > +		 */
> > +		if (PageVmemmap(page)) {
> > +			pfn += vmemmap_nr_pages(page);
> > +			continue;
> > +		}
> 
> I'd assume calling code can handle that and exclude isolating such pages.

The thing is that __offline_isolated_pages calls offline_mem_sections(),
so we really need the first pfn, and not the "pfn + nr_vmemmap_pages".
Instead of skipping it in the loop, I might just skip it before entering
the loop.

Thanks!

-- 
Oscar Salvador
SUSE L3
