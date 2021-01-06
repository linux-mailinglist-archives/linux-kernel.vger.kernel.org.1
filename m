Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716A72EBBFC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbhAFJ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:56:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:34810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbhAFJ4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:56:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609926920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AyhuOFryeJUwIu0CJ6EAPjrR45s4g3oEm7P1mBVda9Y=;
        b=V4znQ33PtuoQSebKcH/T9BBg2BulSvISub/eOka4m9ye1jOQxtwpqbgeGAo17I8/m7ta0d
        HByYX8Nsb4kPXIWsNVFB1nVkDIlsaczb9CVXor7VEDSg6jy/5+Iq0B6PX+tNv8uV30yR+J
        aBl6pac+4QobMUMA8Dw2Q9wncTDE75E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE951ACAF;
        Wed,  6 Jan 2021 09:55:20 +0000 (UTC)
Date:   Wed, 6 Jan 2021 10:55:20 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Teach pfn_to_online_page() about ZONE_DEVICE section
 collisions
Message-ID: <20210106095520.GJ13207@dhcp22.suse.cz>
References: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-01-21 20:07:18, Dan Williams wrote:
> While pfn_to_online_page() is able to determine pfn_valid() at
> subsection granularity it is not able to reliably determine if a given
> pfn is also online if the section is mixed with ZONE_DEVICE pfns.

I would call out the problem more explicitly. E.g. something like
"
This means that pfn_to_online_page can lead to false positives and allow
to return a struct page which is not fully initialized because it
belongs to ZONE_DEVICE (PUT AN EXAMPLE OF SUCH AN UNITIALIZED PAGE
HERE). That can lead to either crash on PagePoisoned assertion or a
silently broken page state with debugging disabled.
"

I would also appreciate a more specific note about how the existing HW
can trigger this. You have mentioned 64MB subsection examples in the
other email. It would be great to mention it here as well.

> Update move_pfn_range_to_zone() to flag (SECTION_TAINT_ZONE_DEVICE) a
> section that mixes ZONE_DEVICE pfns with other online pfns. With
> SECTION_TAINT_ZONE_DEVICE to delineate, pfn_to_online_page() can fall
> back to a slow-path check for ZONE_DEVICE pfns in an online section.
> 
> With this implementation of pfn_to_online_page() pfn-walkers mostly only
> need to check section metadata to determine pfn validity. In the
> rare case of mixed-zone sections the pfn-walker will skip offline
> ZONE_DEVICE pfns as expected.

The above paragraph is slightly confusing. You do not require
pfn-walkers to check anything right? Section metadata is something that
is and should be hidden from them. They are asking for an online page
and get it or NULL. Nothing more nothing less.

 
> Other notes:
> 
> Because the collision case is rare, and for simplicity, the
> SECTION_TAINT_ZONE_DEVICE flag is never cleared once set.

I do not see a problem with that.
 
> pfn_to_online_page() was already borderline too large to be a macro /
> inline function, but the additional logic certainly pushed it over that
> threshold, and so it is moved to an out-of-line helper.

Worth a separate patch.

The approach is sensible. Thanks!

I was worried that we do not have sufficient space for a new flag but
the comment explains we have 6 bits available.  I haven't double checked
that for the current state of the code. The comment is quite recent and
I do not remember any substantial changes in this area. Still something
that is rather fragile because an unexpected alignment would be a
runtime failure which is good to stop random corruptions but not ideal.

Is there any way to explicitly test for this? E.g. enforce a shared
section by qemu and then trigger a pfn walk?

> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Michal Hocko <mhocko@suse.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

[...]

> +static int zone_id(const struct zone *zone)
> +{
> +	struct pglist_data *pgdat = zone->zone_pgdat;
> +
> +	return zone - pgdat->node_zones;
> +}

We already have zone_idx()

> +
> +static void section_taint_zone_device(struct zone *zone, unsigned long pfn)
> +{
> +	struct mem_section *ms = __nr_to_section(pfn_to_section_nr(pfn));
> +
> +	if (zone_id(zone) != ZONE_DEVICE)
> +		return;
> +
> +	if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
> +		return;
> +
> +	ms->section_mem_map |= SECTION_TAINT_ZONE_DEVICE;
> +}
> +
>  /*
>   * Associate the pfn range with the given zone, initializing the memmaps
>   * and resizing the pgdat/zone data to span the added pages. After this
> @@ -707,6 +769,15 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  	resize_pgdat_range(pgdat, start_pfn, nr_pages);
>  	pgdat_resize_unlock(pgdat, &flags);
>  
> +	/*
> +	 * Subsection population requires care in pfn_to_online_page().
> +	 * Set the taint to enable the slow path detection of
> +	 * ZONE_DEVICE pages in an otherwise  ZONE_{NORMAL,MOVABLE}
> +	 * section.
> +	 */
> +	section_taint_zone_device(zone, start_pfn);
> +	section_taint_zone_device(zone, start_pfn + nr_pages);

I think it would be better to add the checks here and only set the flag
in the called function. SECTION_TAINT_ZONE_DEVICE should go to where we
define helpers for ther flags.

> +
>  	/*
>  	 * TODO now we have a visible range of pages which are not associated
>  	 * with their zone properly. Not nice but set_pfnblock_flags_mask
> 

-- 
Michal Hocko
SUSE Labs
