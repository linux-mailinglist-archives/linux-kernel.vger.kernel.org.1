Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE9D2ED087
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 14:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbhAGNUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 08:20:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728359AbhAGNUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610025526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LD2V9ZmDJck9nrtp+0qP7602QSITv2R4SHWYRUA24HM=;
        b=AeJxY7hrZF9kQPN5ndYeZVo/Z3VsJosuH64dg/fF6MDOOvj84Jxw4IZUnt7AT0/O8J2E1a
        24jlAWlt4RMmJHn8qkNmA17KPl7j5W8fR0igB5SCL8dRksObj9I756b+IPAOR2D7JJMRhW
        gkMrrYiQO+VqI7H6ShXl0Zcr18diuLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-zvzF2XRtP1uRRXUpQpVxgA-1; Thu, 07 Jan 2021 08:18:42 -0500
X-MC-Unique: zvzF2XRtP1uRRXUpQpVxgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCB18800D62;
        Thu,  7 Jan 2021 13:18:41 +0000 (UTC)
Received: from localhost (ovpn-12-191.pek2.redhat.com [10.72.12.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30E475C8AA;
        Thu,  7 Jan 2021 13:18:37 +0000 (UTC)
Date:   Thu, 7 Jan 2021 21:18:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rppt@kernel.org
Subject: Re: [PATCH v3 2/4] mm: simplify parater of function
 memmap_init_zone()
Message-ID: <20210107131835.GD4820@MiWiFi-R3L-srv>
References: <20210105074708.18483-1-bhe@redhat.com>
 <20210105074708.18483-3-bhe@redhat.com>
 <c79f9fea-ec5a-36cc-0841-5ae9a522b4e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79f9fea-ec5a-36cc-0841-5ae9a522b4e1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/21 at 05:53pm, David Hildenbrand wrote:
> [...]
> 
> > -void __meminit
> > -memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> > -	     unsigned long start_pfn)
> > +void __meminit memmap_init_zone(struct zone *zone)
> >  {
> > +	unsigned long size = zone->spanned_pages;
> > +	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
> > +	unsigned long start_pfn = zone->zone_start_pfn;
> > +
> 
> Nit: reverse Christmas tree.

Ah, yes, I will reorder these lines.

> 
> >  	if (!vmem_map) {
> > -		memmap_init_range(size, nid, zone, start_pfn, start_pfn + size,
> > +		memmap_init_range(size, nid, zone_id, start_pfn, start_pfn + size,
> >  				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
> >  	} else {
> >  		struct page *start;
> > @@ -556,7 +558,7 @@ memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> >  		args.start = start;
> >  		args.end = start + size;
> >  		args.nid = nid;
> > -		args.zone = zone;
> > +		args.zone = zone_id;
> >  
> >  		efi_memmap_walk(virtual_memmap_init, &args);
> >  	}
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 69ebf75be91c..b2a46ffdaf0b 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6292,16 +6292,16 @@ static inline u64 init_unavailable_range(unsigned long spfn, unsigned long epfn,
> >  }
> >  #endif
> >  
> > -void __init __weak memmap_init_zone(unsigned long size, int nid,
> > -			       unsigned long zone,
> > -			       unsigned long zone_start_pfn)
> > +void __init __weak memmap_init_zone(struct zone *zone)
> >  {
> >  	unsigned long start_pfn, end_pfn, hole_start_pfn = 0;
> > -	unsigned long zone_end_pfn = zone_start_pfn + size;
> > +	int i, nid = zone_to_nid(zone), zone_id = zone_idx(zone);
> > +	unsigned long zone_start_pfn = zone->zone_start_pfn;
> > +	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
> 
> dito.

OK.

> 
> >  	u64 pgcnt = 0;
> > -	int i;
> >  
> >  	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> > +		unsigned long size;
> 
> You can just get rid of this parameter IMHO.

Someone possibly like a intermediate local variable better in this case,
but I am fine to both, will change as you suggested.

> 
> (Also, there is an empty line missing right now)

Sure. Thanks.

> 
> 
> Apart from that LGTM
> 
> -- 
> Thanks,
> 
> David / dhildenb

