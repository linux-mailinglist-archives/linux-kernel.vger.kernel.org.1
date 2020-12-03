Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB01C2CDC80
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501934AbgLCRdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:33:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728398AbgLCRdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607016713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Kw3ICG128+2J9hfH/6eDA8AJ9cHs2zQ+a6t6T0YiHA=;
        b=VQv19AXgv+9eRLUP+dzpsRFg4lWyJYTapsHn7x3o/Djc2j21Vmt12lr/J15g0dKupGX+c4
        0Omw/tLdxVhwUh1Izvb+sTq/digiM+qd/1Me+tp5T66lT3/sbJTr+HIXqV4nrXkrzOjYOU
        kJShilkCDgekNX98tcVpmdtqyQZO4jQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-cvg30N-UOCOj2l3fV_yxNQ-1; Thu, 03 Dec 2020 12:31:50 -0500
X-MC-Unique: cvg30N-UOCOj2l3fV_yxNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9379E1007476;
        Thu,  3 Dec 2020 17:31:48 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED7895D9CA;
        Thu,  3 Dec 2020 17:31:44 +0000 (UTC)
Date:   Thu, 3 Dec 2020 12:31:44 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X8khAMOK1y4yRijc@redhat.com>
References: <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
 <3bb709a7-6100-aa5c-4125-7ed80c6d9643@redhat.com>
 <20201126174601.GT123287@linux.ibm.com>
 <20201129123257.GY123287@linux.ibm.com>
 <X8bjgw5LPAZrSrwp@redhat.com>
 <20201202173923.GM123287@linux.ibm.com>
 <X8iERlMGfNCLxab5@redhat.com>
 <20201203105107.GR123287@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203105107.GR123287@linux.ibm.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 12:51:07PM +0200, Mike Rapoport wrote:
> On Thu, Dec 03, 2020 at 01:23:02AM -0500, Andrea Arcangeli wrote:
> > 5) pfn 0 is the classical case where pfn 0 is in a reserved zone in
> >    memblock.reserve that doesn't overlap any memblock.memory zone.
> 
> And, IMHO, this is the fundamental BUG.

We have a dozen arches that change all the time, new efi/e820 stuff,
always new bios configs, the memblock code must cope and be able to
cope with the caller being wrong or changing behavior if the e820 map
changes behaviour.

Trying to work around memblock core deficiencies in the caller is what
124049decbb121ec32742c94fb5d9d6bed8f24d8 already did, and it doesn't
work and it's not even clean thing to do.

In fact here there's really nothing to blame the caller for (i.e. the
e820 init code), unless you declare that there must be always overlap
(which I understood would break stuff for regions that must not have a
direct mapping).

The caller here is correct and it can be summarized as below:

    if (e820 map type != system_ram)
       memblock_reserve(range)
    else
       memblock_add(range)

Then:

   zone_boundaries = [ 16M, 4G, 0 ]
   free_area_init(zone_boundaries)

It's not the caller fault if the e820 map in the bios starts with:

pfn 0-1 reserved
pfn 1-N system RAM

This is better fixed in a way that must not require any change in the
caller...

> There is RAM at address 0, there is a DIMM there, so why on earth this
> should not be a part of memblock.memory?

How can you blame the caller if you explicitly didn't required that
.reserved ranges must always overlap .memory ranges? In fact it was
explained as a feature to avoid the direct mapping.

Declaring that there must be always overlap would be one way to cope
with this issue, but even then memblock must detect a wrong caller,
workaround it by doing a memblock_add call inside the
memblock_reserved and by printing a warning to improve the caller. It
shouldn't crash at boot with console off if the overlap is not there.

In my view the caller here is not to blame, all these issues are
because memblock needs improvement and must cope with any caller.

> >    The memblock_start_of_DRAM moves the start of the DMA zone above
> >    the pfn 0, so then pfn 0 already ends up in the no zone land David
> >    mentioned where it's not trivial to decide to give it a zoneid if
> >    it's not even spanned in the zone.
> > 
> >    Not just the zoneid, there's not even a nid.
> > 
> >    So we have a pfn with no zoneid, and no nid, and not part of the
> >    zone ranges, not part of the nid ranges not part of the
> >    memory.memblock.
> 
> We have a pfn that should have been in memblock.memory, in ZONE_DMA and
> in the first node with memory. If it was not trimmed from there 

My incremental patch already solves how to extend the zones spans and
the nid spans by taking memblock.reserved into account, not just
memblock.memory, but still without actually messing with the direct
mapping, otherwise I would have called memblock_add instead of walking
memblock.reserved when detecting the nid and zoneid ranges.

> 
> >    We can't really skip the initialization of the the pfn 0, it has to
> >    get the zoneid 0 treatment or if pfn 1 ends up in compaction code,
> >    we'd crash again. (although we'd crash with a nice PagePoison(page)
> >    == true behavior)
> 
> Agree. Struct page for pfn should get the same zoneid and nodeid as pfn 1.

How are you sure there's no a zone ID 0 that starts at pfn 0 and ends
at pfn 1 and the zone dma starts at pfn 1? In such case the pfn 0
would have a zoneid different from pfn 1.

I'm not exactly sure why we should initialize a pfn 0 with a zoneid of
a zone whose pfn 0 is not part of, that looks wrong.

I'm not exactly sure why you don't fix the zone->zone_start_pfn and
the respective nid node_start_pfn to start from pfn 0 instead, just
like I did in my patch.

> From 84a1c2531374706f3592a638523278aa29aaa448 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Thu, 3 Dec 2020 11:40:17 +0200
> Subject: [PATCH] fixup for "mm: refactor initialization of stuct page for holes"
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/page_alloc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ce2bdaabdf96..86fde4424e87 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6227,7 +6227,8 @@ void __init __weak memmap_init(unsigned long size, int nid,
>  			       unsigned long zone,
>  			       unsigned long range_start_pfn)
>  {
> -	unsigned long start_pfn, end_pfn, next_pfn = 0;
> +	static unsigned long hole_start_pfn;
> +	unsigned long start_pfn, end_pfn;
>  	unsigned long range_end_pfn = range_start_pfn + size;
>  	u64 pgcnt = 0;
>  	int i;
> @@ -6235,7 +6236,6 @@ void __init __weak memmap_init(unsigned long size, int nid,
>  	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
>  		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
>  		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
> -		next_pfn = clamp(next_pfn, range_start_pfn, range_end_pfn);
>  
>  		if (end_pfn > start_pfn) {
>  			size = end_pfn - start_pfn;
> @@ -6243,10 +6243,10 @@ void __init __weak memmap_init(unsigned long size, int nid,
>  					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>  		}
>  
> -		if (next_pfn < start_pfn)
> -			pgcnt += init_unavailable_range(next_pfn, start_pfn,
> -							zone, nid);
> -		next_pfn = end_pfn;
> +		if (hole_start_pfn < start_pfn)
> +			pgcnt += init_unavailable_range(hole_start_pfn,
> +							start_pfn, zone, nid);
> +		hole_start_pfn = end_pfn;
>  	}
>  
>  	/*
> @@ -6256,8 +6256,8 @@ void __init __weak memmap_init(unsigned long size, int nid,
>  	 * considered initialized. Make sure that memmap has a well defined
>  	 * state.
>  	 */
> -	if (next_pfn < range_end_pfn)
> -		pgcnt += init_unavailable_range(next_pfn, range_end_pfn,
> +	if (hole_start_pfn < range_end_pfn)
> +		pgcnt += init_unavailable_range(hole_start_pfn, range_end_pfn,
>  						zone, nid);
>  

1) this looks very specific for pfn 0

2) it's not optimal to call init_unavailable_range(0,) the first time
   at every zone initialization, that's a pretty inefficient loop for
   large RAM systems.

3) you give pfn 0 a zoneid despite it's not part of the zone, that
   looks wrong from a zoneid initialization point of view.


The bug here is that the DMA zone starts in pfn 1 which doesn't make
any technical sense since the start of the pageblock would then be
beyond the start_zone_pfn.

I don't really see how you can fix this, without ending with an even
bigger undefined special case to keep in mind where a pfn gets
initialized beyond the zone.

If something the real good alternative to changing the zone_start_pfn
to start from 0 and not from 1, is to keep the pfn 0 PagePoison and to
never call __setPageReserved on it in reserve_bootmem_region. That is
also a very clean solution where everything remains in check. The
poison is effectively a NO_NODEID NO_NID because that pfn 0 really is
not spanned in any nid or any zone. Although we need to ensure
compaction won't ever try to access it by means of checking
zone_start_pfn that it can't rewind to the start of the
pageblock. It'll cause an inefficiency but that also looks cleaner
than giving a random zoneid beyond the zone span, to pfn 0.

Thanks,
Andrea

