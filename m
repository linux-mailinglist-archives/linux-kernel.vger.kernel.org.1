Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21002DA99E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgLOJDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:03:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727282AbgLOJDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608022904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVXua2XfuxOIMusyudjNmNVLYRtRtCTodaIlSiH6G9A=;
        b=AnNMjysSGFQl32EymLXaQzkFpVICAXEa2lRFuTlZvDLSwL4BPjSQC3aHadimuJ56fh9ggd
        K+XgSeqEoS8oJpiw+XeV0/pBMsFtpzpuRSOgZOlKrUzOR30BpC4qIkLkG0YBCjZLC6Zmum
        jPxpCMyb4l+FIgrbjupI+zxTPhNTIqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-pClKqykwNpm38p695HUDGw-1; Tue, 15 Dec 2020 04:01:41 -0500
X-MC-Unique: pClKqykwNpm38p695HUDGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73A15107ACE4;
        Tue, 15 Dec 2020 09:01:39 +0000 (UTC)
Received: from localhost (ovpn-12-228.pek2.redhat.com [10.72.12.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F0C25D9DE;
        Tue, 15 Dec 2020 09:01:35 +0000 (UTC)
Date:   Tue, 15 Dec 2020 17:01:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, gopakumarr@vmware.com,
        akpm@linux-foundation.org, natechancellor@gmail.com,
        ndesaulniers@google.com, clang-built-linux@googlegroups.com,
        rostedt@goodmis.org, manir@vmware.com, lauyiuch@vmware.com,
        pjonasson@vmware.com, rajaramv@vmware.com
Subject: Re: [PATCH 2/2] mm: rename memmap_init() and memmap_init_zone()
Message-ID: <20201215090133.GB8928@MiWiFi-R3L-srv>
References: <20201213150942.20990-1-bhe@redhat.com>
 <20201213150942.20990-3-bhe@redhat.com>
 <c53c5290-b5c1-87bb-d562-348d4c8bd7eb@redhat.com>
 <20201214110448.GB198219@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214110448.GB198219@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/20 at 01:04pm, Mike Rapoport wrote:
> On Mon, Dec 14, 2020 at 11:00:07AM +0100, David Hildenbrand wrote:
> > On 13.12.20 16:09, Baoquan He wrote:
> > > The current memmap_init_zone() only handles memory region inside one zone.
> > > Actually memmap_init() does the memmap init of one zone. So rename both of
> > > them accordingly.
> > > 
> > > And also rename the function parameter 'range_start_pfn' and local variable
> > > 'range_end_pfn' to zone_start_pfn/zone_end_pfn.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
......  

> > >  	set_zone_contiguous(zone);
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 315c22974f0d..fac599deba56 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -6050,7 +6050,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
> > >   * (usually MIGRATE_MOVABLE). Besides setting the migratetype, no related
> > >   * zone stats (e.g., nr_isolate_pageblock) are touched.
> > >   */
> > > -void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> > > +void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone,
> > >  		unsigned long start_pfn, unsigned long zone_end_pfn,
> > >  		enum meminit_context context,
> > >  		struct vmem_altmap *altmap, int migratetype)
> > > @@ -6187,21 +6187,21 @@ static void __meminit zone_init_free_lists(struct zone *zone)
> > >  	}
> > >  }
> > >  
> > > -void __meminit __weak memmap_init(unsigned long size, int nid,
> > > +void __meminit __weak memmap_init_zone(unsigned long size, int nid,
> > >  				  unsigned long zone,
> > > -				  unsigned long range_start_pfn)
> > > +				  unsigned long zone_start_pfn)
> > 
> > Why are we not simply passing "struct zone" like
> > 
> > void __meminit __weak  memmap_init_zone(struct zone *zone)
> > 
> > from which we can derive
> > - nid
> > - zone idx
> > - zone_start_pfn
> > - spanned_pages / zone_end_pfn
> > 
> > At least when called from free_area_init_core() this should work just
> > fine I think.
>  
> There is also a custom memmap init in ia64 which at least should be
> tested ;-)

Right. Tried in arch/ia64/mm/init.c, the change is as below. Looks
simple, compiling passed on ia64 should be OK.


diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index af678197ac2d..4fa49a762d58 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -541,12 +541,14 @@ virtual_memmap_init(u64 start, u64 end, void *arg)
 	return 0;
 }
 
-void __meminit
-memmap_init_zone (unsigned long size, int nid, unsigned long zone,
-	     unsigned long start_pfn)
+void __meminit memmap_init_zone (struct zone *zone)
 {
+	unsigned long size = zone->spanned_size;
+	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
+	unsigned long start_pfn = zone->zone_start_pfn;
+
 	if (!vmem_map) {
-		memmap_init_range(size, nid, zone, start_pfn, start_pfn + size,
+		memmap_init_range(size, nid, zone_id, start_pfn, start_pfn + size,
 				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 	} else {
 		struct page *start;
@@ -556,7 +558,7 @@ memmap_init_zone (unsigned long size, int nid, unsigned long zone,
 		args.start = start;
 		args.end = start + size;
 		args.nid = nid;
-		args.zone = zone;
+		args.zone = zone_id;
 
 		efi_memmap_walk(virtual_memmap_init, &args);
 	}
> 
> More broadly, while Baoquan's fix looks Ok to me, I think we can
> calculate node->first_deferred_pfn earlier in, say,
> free_area_init_node() rather than do defer_init() check for each pfn.

Remember I ever tried to move the defer init up one level into memmap_init()
when making draft patch in the first place. I finally ended up with this
because there's overlap_memmap_init().

>  
> > >  {
> > >  	unsigned long start_pfn, end_pfn;
> > > -	unsigned long range_end_pfn = range_start_pfn + size;
> > > +	unsigned long zone_end_pfn = zone_start_pfn + size;
> > >  	int i;
> > >  
> > >  	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> > > -		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
> > > -		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
> > > +		start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
> > > +		end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
> > >  
> > >  		if (end_pfn > start_pfn) {
> > >  			size = end_pfn - start_pfn;
> > > -			memmap_init_zone(size, nid, zone, start_pfn, range_end_pfn,
> > > +			memmap_init_range(size, nid, zone, start_pfn, zone_end_pfn,
> > >  					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
> > >  		}
> > >  	}
> > > @@ -6903,7 +6903,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
> > >  		set_pageblock_order();
> > >  		setup_usemap(pgdat, zone, zone_start_pfn, size);
> > >  		init_currently_empty_zone(zone, zone_start_pfn, size);
> > > -		memmap_init(size, nid, j, zone_start_pfn);
> > > +		memmap_init_zone(size, nid, j, zone_start_pfn);
> > >  	}
> > >  }
> > >  
> > > 
> > 
> > 
> > -- 
> > Thanks,
> > 
> > David / dhildenb
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 

