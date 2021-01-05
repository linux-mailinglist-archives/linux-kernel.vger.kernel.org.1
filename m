Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87B92EB072
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbhAEQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:48:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729101AbhAEQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609865200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQ/JWdP+ZPuOVG9p+BYjTh339vKnJxeTgO0ZBYjWFtI=;
        b=BBee7EyEycp998VrBzGKOs/XgeqVCkjSR9+twUODd7A2HayZ8CjOPcdlznM20jvSbRIFu4
        klM90vq2O626owQhAzgry/SN0ErfdzaNHNzY/YVE9IsS0RjgbALMPt6SGa4hL0hN84O1jy
        e7Uui1lNw0ZO9tC1goyKbQ4Hr702/lM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-ucwlct3CO_SlGuFY5Y0V9A-1; Tue, 05 Jan 2021 11:44:07 -0500
X-MC-Unique: ucwlct3CO_SlGuFY5Y0V9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FC4F190A7A0;
        Tue,  5 Jan 2021 16:44:06 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34A8C5D735;
        Tue,  5 Jan 2021 16:44:05 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] mm: remove unneeded local variable in
 free_area_init_core
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org
References: <20210105074708.18483-1-bhe@redhat.com>
 <20210105074708.18483-5-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1bb89972-a942-e196-577c-aedb71aef8ee@redhat.com>
Date:   Tue, 5 Jan 2021 17:44:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210105074708.18483-5-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.21 08:47, Baoquan He wrote:
> Local variable 'zone_start_pfn' is not needed since there's only
> one call site in free_area_init_core(). Let's remove it and pass
> zone->zone_start_pfn directly to init_currently_empty_zone().
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/page_alloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e0ce6fb6373b..9cacb8652239 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6986,7 +6986,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  	for (j = 0; j < MAX_NR_ZONES; j++) {
>  		struct zone *zone = pgdat->node_zones + j;
>  		unsigned long size, freesize, memmap_pages;
> -		unsigned long zone_start_pfn = zone->zone_start_pfn;
>  
>  		size = zone->spanned_pages;
>  		freesize = zone->present_pages;
> @@ -7035,7 +7034,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  
>  		set_pageblock_order();
>  		setup_usemap(zone);
> -		init_currently_empty_zone(zone, zone_start_pfn, size);
> +		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
>  		memmap_init_zone(zone);
>  	}
>  }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

