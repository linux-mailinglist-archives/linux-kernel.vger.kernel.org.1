Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51BF2C80B2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgK3JNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:13:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:40666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgK3JNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:13:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35F69AC95;
        Mon, 30 Nov 2020 09:12:39 +0000 (UTC)
Date:   Mon, 30 Nov 2020 10:12:37 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v2 2/4] mm,memory_hotplug: Allocate memmap from the
 added memory range
Message-ID: <20201130091236.GB3825@linux>
References: <20201125112048.8211-1-osalvador@suse.de>
 <20201125112048.8211-3-osalvador@suse.de>
 <20201127151536.GV31550@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127151536.GV31550@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 04:15:36PM +0100, Michal Hocko wrote:
> > Vmemap page tables can map arbitrary memory.
> > That means that we can simply use the beginning of each memory section and
> > map struct pages there.
> 
> Did you mean each memory block rather than section?

Yes, sorry, I did not update that part.

> > struct pages which back the allocated space then just need to be treated
> > carefully.
> > 
> > Implementation wise we will reuse vmem_altmap infrastructure to override
> > the default allocator used by __populate_section_memmap. Once the memmap is
> > allocated, we are going to need a way to mark altmap pfns used for the allocation.
> > If MHP_MEMMAP_ON_MEMORY flag was passed, we will set up the layout of the
> > altmap structure in add_memory_resouce(), and then we will call
> > mhp_mark_vmemmap_pages() to properly mark those pages.
> > 
> > Online/Offline:
> > 
> >  In the memory_block structure, a new field is created in order to
> >  store the number of vmemmap_pages.
> 
> Is this really needed? We know how many pfns are required for a block of
> a specific size, right?
> 
> I have only glanced through the patch so I might be missing something
> but I am really wondering why you haven't chosen to use altmap directly
> here.

Well, this is my bad, I did not update the changelog wrt. to the previous version
so it might be confusing.
I will make sure to update it for the next submission, but let me explain it
here to shed some light.

We no longer need to use mhp_mark_vmemap_pages to mark vmemmap pages pages.
Prior to online_pages(), the whole range is offline, so no one should be
messing with any pages within that range.
The initialization of the pages takes places in online_pages():

We have:

start_pfn = first_pfn_of_the_range
buddy_start_pfn = first_pfn_of_the_range + nr_vmemmap_pages


We do have:

+	if (nr_vmemmap_pages)
+		move_pfn_range_to_zone(zone, pfn, nr_vmemmap_pages, NULL,
+				       MIGRATE_UNMOVABLE);
+	move_pfn_range_to_zone(zone, buddy_start_pfn, buddy_nr_pages, NULL,
+			       MIGRATE_ISOLATE);

Now, all the range is initialized and marked PageReserved, but we only send
to buddy (buddy_start_pfn, end_pfn].

And so, (start_pfn, buddy_start_pfn - 1] reamins PageReserved.
And we know that pfn walkers to skip Reserved pages.

About the altmap part.
Altmap is used in the hot-add phase in add_memory_resource.

The thing is, we could avoid adding the memory_block's nr_vmemmap_pages field
, but we would have to mark the vmemmap pages as we used to do in previous
implementations (see [1]), but I find this way cleaner, and it adds much less
code (previous implementions can be see in [2]), and as a starter I find it
much better.

> It would be also good to describe how does a pfn walker recognize such a
> page? Most of them will simply ignore it but e.g. hotplug walker will
> need to skip over those because they are not preventing offlining as
> they will go away with the memory block together.

Wrt. hotplug walker, same as above, we only care to migrate the
(buddy_start_pfn, end_pfn], so the first pfn to migrate and isolate is set to
buddy_start_pfn.

Other pfns walkers should merely skip vmemmap pages because they are Reserved.

> Some basic description of testing done would be suitable as well.

Well, that is:

 - Hot-add memory to a specific numa node
 - Online memory
 - numactl -H and /proc/zoneinfo reflects the truth and nr_vmemmap_pages are
   extracted where they have to be
 - Start a memory stress program and bind it to the numa node we added memory
   so we make sure it gets exercised
 - Wait for a while and when node's free pages have decreased considerably,
   offline memory
 - Check that memory went offline and check /proc/zoneinfo and numactl -H
   again
 - Hot-remove range


[1] https://patchwork.kernel.org/project/linux-mm/patch/20201022125835.26396-3-osalvador@suse.de/
[2] https://patchwork.kernel.org/project/linux-mm/cover/20201022125835.26396-1-osalvador@suse.de/
 
-- 
Oscar Salvador
SUSE L3
