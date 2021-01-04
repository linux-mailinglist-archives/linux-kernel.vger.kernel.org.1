Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6C22E9819
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbhADPKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:10:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:39302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbhADPKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:10:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609773006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZpeYXPgcm8hAgvsFb4Y1uFrLlbOBYDWKHSBp2aTuULY=;
        b=bcXavfuLByb8ONfDYfE3H3OtN37COkQ1CCOfw2+nRK7GwLfsYiztzEdm0gfx61tNegju6H
        FyiAF3GD7iprwaQ/+JNPcm/0sS/5rEEgPqZyuQiYSGoRsFv78H+pwqL2XNEmDnTgSS/vSB
        /TDcg5bXZzTa7xluussbvlF8XHr4nKs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D58C7B7E1;
        Mon,  4 Jan 2021 15:10:06 +0000 (UTC)
Date:   Mon, 4 Jan 2021 16:10:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: uninitialized pmem struct pages
Message-ID: <20210104151005.GK13207@dhcp22.suse.cz>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <20210104142624.GI13207@dhcp22.suse.cz>
 <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-01-21 15:51:35, David Hildenbrand wrote:
> On 04.01.21 15:26, Michal Hocko wrote:
> > On Mon 04-01-21 11:45:39, David Hildenbrand wrote:
[....]
> >> One instance where this is still an issue is
> >> mm/memory-failure.c:memory_failure() and
> >> mm/memory-failure.c:soft_offline_page(). I thought for a while about
> >> "fixing" these, but to me it felt like fixing pfn_to_online_page() is
> >> actually the right approach.
> >>
> >> But worse, before ZONE_DEVICE hot-add
> >> 1. The whole section memmap does already exist (early sections always
> >> have a full memmap for the whole section)
> >> 2. The whole section memmap is initialized (although eventually with
> >> dummy node/zone 0/0 for memory holes until that part is fixed) and might
> >> be accessed by pfn walkers.
> >>
> >> So when hotadding ZONE_DEVICE we are modifying already existing and
> >> visible memmaps. Bad.
> > 
> > Could you elaborate please?
> 
> Simplistic example: Assume you have a VM with 64MB on x86-64.
> 
> We need exactly one memory section (-> one memory block device). We
> allocate the memmap for a full section - an "early section". So we have
> a memmap for 128MB, while 64MB are actually in use, the other 64MB is
> initialized (like a memory hole). pfn_to_online_page() would return a
> valid struct page for the whole section memmap.
> 
> The remaining 64MB can later be used for hot-adding ZONE_DEVICE memory,
> essentially re-initializing that part of the already-existing memmap.
> 
> See pfn_valid():
> 
> /*
>  * Traditionally early sections always returned pfn_valid() for
>  * the entire section-sized span.
>  */
> return early_section(ms) || pfn_section_valid(ms, pfn);
> 
> 
> Depending on the memory layout of the system, a pfn walker might just be
> about to stumble over this range getting re-initialized.

Right. But as long as pfn walkers are not synchronized with the memory
hotplug this is a general problem with any struct page. Whether it
belongs to pmem or a regular memory, no?

> >> 2. Deferred init of ZONE_DEVICE ranges
> >>
> >> memmap_init_zone_device() runs after the ZONE_DEVICE zone was resized
> >> and outside the memhp lock. I did not follow if the use of
> >> get_dev_pagemap() actually makes sure that memmap_init_zone_device() in
> >> pagemap_range() actually completed. I don't think it does.
> > 
> > So a pfn walker can see an unitialized struct page for a while, right?
> > 
> > The problem that I have encountered is that some zone device pages are
> > not initialized at all. That sounds like a different from those 2 above.
> > I am having hard time to track what kind of pages those are and why we
> > cannot initialized their zone/node and make them reserved at least.
> 
> And you are sure that these are in fact ZONE_DEVICE pages? Not memory
> holes e.g., tackled by

Well, the physical address matches the pmem range so I believe this is
the case.

[...]
> However, I do remember a discussion regarding "reserved altmap space"
> ZONE_DEVICE ranges, and whether to initialize them or leave them
> uninitialized. See comment in
> 
> commit 77e080e7680e1e615587352f70c87b9e98126d03
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Date:   Fri Oct 18 20:19:39 2019 -0700
> 
>     mm/memunmap: don't access uninitialized memmap in memunmap_pages()

yes, the reserved altmap space sounds like it might be it.

> "With an altmap, the memmap falling into the reserved altmap space are
> not initialized and, therefore, contain a garbage NID and a garbage zone.".
> 
> I think the issue is that the ZONE_DEVICE pages that *host* the memmap
> of other pages might be left uninitialized.
> 
> Like pfn_to_page(VIRT_TO_PFN(pfn_to_page(zone_device_pfn))), which falls
> onto ZONE_DEVICE with an altmap, could be uninitialized. This is very
> similar to our Oscar's vmemmap-on-hotadded-memory approach, however,
> there we implicitly initialize the memmap of these pages just by the way
> the vmemmap is placed at the beginning of the memory block.
> 
> If altmap-reserved space is placed partially into an early section that
> is marked as online (issue 1. I described), we have the same issue as
> 1., just a little harder to fix :)

Would it be possible to iterate over the reserved space and initialize
Node/zones at least?
 
Thanks!
-- 
Michal Hocko
SUSE Labs
