Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F222DA86E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 08:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLOHTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 02:19:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbgLOHTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 02:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608016705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I246izeO8jvYhXeQCpg8Ld1WEf10HywTAxqVDlzwlkE=;
        b=JJ0iBz/+kFM3vaJR2RIz+41L6Rua54eeC2x32OjvGECRVJ8fNOTteTJK6n56RsR0aFbJ6u
        PDTGLqoNXOJG77iux2jCa+gNi3OoX23bXFzoYWGj2WsICXLu5TCDCsjLKv8ZNyN9sIQRM4
        bBAbchZdDJliW0v91MNeedDPrbVe9OM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-pc0B0HFyNzy2yCSEATnWdw-1; Tue, 15 Dec 2020 02:18:21 -0500
X-MC-Unique: pc0B0HFyNzy2yCSEATnWdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 735631E7C6;
        Tue, 15 Dec 2020 07:18:19 +0000 (UTC)
Received: from localhost (ovpn-12-228.pek2.redhat.com [10.72.12.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7907013470;
        Tue, 15 Dec 2020 07:18:15 +0000 (UTC)
Date:   Tue, 15 Dec 2020 15:18:12 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        gopakumarr@vmware.com, akpm@linux-foundation.org, rppt@kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        clang-built-linux@googlegroups.com, rostedt@goodmis.org,
        manir@vmware.com, lauyiuch@vmware.com, pjonasson@vmware.com,
        rajaramv@vmware.com
Subject: Re: [PATCH 2/2] mm: rename memmap_init() and memmap_init_zone()
Message-ID: <20201215071812.GA8928@MiWiFi-R3L-srv>
References: <20201213150942.20990-1-bhe@redhat.com>
 <20201213150942.20990-3-bhe@redhat.com>
 <c53c5290-b5c1-87bb-d562-348d4c8bd7eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c53c5290-b5c1-87bb-d562-348d4c8bd7eb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/20 at 11:00am, David Hildenbrand wrote:
> On 13.12.20 16:09, Baoquan He wrote:
> > The current memmap_init_zone() only handles memory region inside one zone.
> > Actually memmap_init() does the memmap init of one zone. So rename both of
> > them accordingly.
> > 
> > And also rename the function parameter 'range_start_pfn' and local variable
> > 'range_end_pfn' to zone_start_pfn/zone_end_pfn.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/ia64/mm/init.c |  6 +++---
> >  include/linux/mm.h  |  2 +-
> >  mm/memory_hotplug.c |  2 +-
> >  mm/page_alloc.c     | 16 ++++++++--------
> >  4 files changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> > index 27ca549ff47e..af678197ac2d 100644
> > --- a/arch/ia64/mm/init.c
> > +++ b/arch/ia64/mm/init.c
> > @@ -535,18 +535,18 @@ virtual_memmap_init(u64 start, u64 end, void *arg)
> >  		    / sizeof(struct page));
> >  
> >  	if (map_start < map_end)
> > -		memmap_init_zone((unsigned long)(map_end - map_start),
> > +		memmap_init_range((unsigned long)(map_end - map_start),
> >  				 args->nid, args->zone, page_to_pfn(map_start), page_to_pfn(map_end),
> >  				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
> >  	return 0;
> >  }
> >  
> >  void __meminit
> > -memmap_init (unsigned long size, int nid, unsigned long zone,
> > +memmap_init_zone (unsigned long size, int nid, unsigned long zone,
> >  	     unsigned long start_pfn)
> 
> While at it s/zone /zone/ please. :)

Yeah, when I git grep 'memmap_init(', I didn't searched the one in ia64,
didn't adjust it since I saw so many functions got a space between
name and parenthesis in arch/ia64/mm/. I will clean up this one anyway.

> 
> >  {
> >  	if (!vmem_map) {
> > -		memmap_init_zone(size, nid, zone, start_pfn, start_pfn + size,
> > +		memmap_init_range(size, nid, zone, start_pfn, start_pfn + size,
> >  				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
> >  	} else {
> >  		struct page *start;
...

> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 315c22974f0d..fac599deba56 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6050,7 +6050,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
> >   * (usually MIGRATE_MOVABLE). Besides setting the migratetype, no related
> >   * zone stats (e.g., nr_isolate_pageblock) are touched.
> >   */
> > -void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> > +void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone,
> >  		unsigned long start_pfn, unsigned long zone_end_pfn,
> >  		enum meminit_context context,
> >  		struct vmem_altmap *altmap, int migratetype)
> > @@ -6187,21 +6187,21 @@ static void __meminit zone_init_free_lists(struct zone *zone)
> >  	}
> >  }
> >  
> > -void __meminit __weak memmap_init(unsigned long size, int nid,
> > +void __meminit __weak memmap_init_zone(unsigned long size, int nid,
> >  				  unsigned long zone,
> > -				  unsigned long range_start_pfn)
> > +				  unsigned long zone_start_pfn)
> 
> Why are we not simply passing "struct zone" like
> 
> void __meminit __weak  memmap_init_zone(struct zone *zone)
> 
> from which we can derive
> - nid
> - zone idx
> - zone_start_pfn
> - spanned_pages / zone_end_pfn
> 
> At least when called from free_area_init_core() this should work just
> fine I think.

Yes, passing 'struct zone *zone' looks much better, I will append a patch to
do this. Thanks.

> 
> 
> 
> >  {
> >  	unsigned long start_pfn, end_pfn;
> > -	unsigned long range_end_pfn = range_start_pfn + size;
> > +	unsigned long zone_end_pfn = zone_start_pfn + size;
> >  	int i;
> >  
> >  	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> > -		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
> > -		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
> > +		start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
> > +		end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
> >  
> >  		if (end_pfn > start_pfn) {
> >  			size = end_pfn - start_pfn;
> > -			memmap_init_zone(size, nid, zone, start_pfn, range_end_pfn,
> > +			memmap_init_range(size, nid, zone, start_pfn, zone_end_pfn,
> >  					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
> >  		}
> >  	}
> > @@ -6903,7 +6903,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
> >  		set_pageblock_order();
> >  		setup_usemap(pgdat, zone, zone_start_pfn, size);
> >  		init_currently_empty_zone(zone, zone_start_pfn, size);
> > -		memmap_init(size, nid, j, zone_start_pfn);
> > +		memmap_init_zone(size, nid, j, zone_start_pfn);
> >  	}
> >  }
> >  
> > 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 

