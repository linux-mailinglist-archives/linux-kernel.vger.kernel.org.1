Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D25F2EB0A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbhAEQzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:55:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726132AbhAEQzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609865623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mvbp9ydae0x8bD/hpneZjQLEAQC9nXZA01gZoxVO3D4=;
        b=LbThyeksSEDEHH++iPsPjq6QNxOg1CBvQI/bwmdDkOqRrtlN9SOqhfFDCMcXvWK0jsLWOf
        GJCPxCn3nNE5pSmHoswM8Jh+3nvqdbkUD2b7zHCDENYkcfT/9TagXRuKV3toy0dVtEDdDB
        /zL9IqyQLF5qgbWm+fDhhxF68EaNgXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-H9xuSLRIOo6Zu2iGm30Law-1; Tue, 05 Jan 2021 11:53:41 -0500
X-MC-Unique: H9xuSLRIOo6Zu2iGm30Law-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D920195D560;
        Tue,  5 Jan 2021 16:53:40 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2335E6D026;
        Tue,  5 Jan 2021 16:53:38 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] mm: simplify parater of function
 memmap_init_zone()
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org
References: <20210105074708.18483-1-bhe@redhat.com>
 <20210105074708.18483-3-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c79f9fea-ec5a-36cc-0841-5ae9a522b4e1@redhat.com>
Date:   Tue, 5 Jan 2021 17:53:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210105074708.18483-3-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> -void __meminit
> -memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> -	     unsigned long start_pfn)
> +void __meminit memmap_init_zone(struct zone *zone)
>  {
> +	unsigned long size = zone->spanned_pages;
> +	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
> +	unsigned long start_pfn = zone->zone_start_pfn;
> +

Nit: reverse Christmas tree.

>  	if (!vmem_map) {
> -		memmap_init_range(size, nid, zone, start_pfn, start_pfn + size,
> +		memmap_init_range(size, nid, zone_id, start_pfn, start_pfn + size,
>  				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>  	} else {
>  		struct page *start;
> @@ -556,7 +558,7 @@ memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  		args.start = start;
>  		args.end = start + size;
>  		args.nid = nid;
> -		args.zone = zone;
> +		args.zone = zone_id;
>  
>  		efi_memmap_walk(virtual_memmap_init, &args);
>  	}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 69ebf75be91c..b2a46ffdaf0b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6292,16 +6292,16 @@ static inline u64 init_unavailable_range(unsigned long spfn, unsigned long epfn,
>  }
>  #endif
>  
> -void __init __weak memmap_init_zone(unsigned long size, int nid,
> -			       unsigned long zone,
> -			       unsigned long zone_start_pfn)
> +void __init __weak memmap_init_zone(struct zone *zone)
>  {
>  	unsigned long start_pfn, end_pfn, hole_start_pfn = 0;
> -	unsigned long zone_end_pfn = zone_start_pfn + size;
> +	int i, nid = zone_to_nid(zone), zone_id = zone_idx(zone);
> +	unsigned long zone_start_pfn = zone->zone_start_pfn;
> +	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;

dito.

>  	u64 pgcnt = 0;
> -	int i;
>  
>  	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> +		unsigned long size;

You can just get rid of this parameter IMHO.

(Also, there is an empty line missing right now)


Apart from that LGTM

-- 
Thanks,

David / dhildenb

