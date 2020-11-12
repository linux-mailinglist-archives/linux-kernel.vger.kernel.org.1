Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C802B09E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgKLQ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:26:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728426AbgKLQ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605198384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gADRODkz7b7+htThGHhl7MJRqc4Axl7JtPNCwFSxMo=;
        b=L3+F2btLuVFoUvLP/niAIoP3+Wf8u4ELcs+NNh8JoMzhy+hB6XVl/27Sqk03fXvY1E2kEB
        wpG0K4bkPvpzO/0rhzcvirR+WoVl5uzggVxZ+f/21VSNxw0sNhkfnzYUtcdMqXe2hdL8Ll
        48ztaHLwzUayKEkVjOOhckMRPn2Skto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-PJNcsBbxNXqtP0PHvk9--g-1; Thu, 12 Nov 2020 11:26:19 -0500
X-MC-Unique: PJNcsBbxNXqtP0PHvk9--g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B194E18B9ED2;
        Thu, 12 Nov 2020 16:26:17 +0000 (UTC)
Received: from [10.36.115.61] (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A468E55776;
        Thu, 12 Nov 2020 16:26:15 +0000 (UTC)
Subject: Re: [PATCH v3 5/7] mm, page_alloc: cache pageset high and batch in
 struct zone
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>
References: <20201111092812.11329-1-vbabka@suse.cz>
 <20201111092812.11329-6-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <34b9c883-8b77-435f-73b9-ccaa1677fc52@redhat.com>
Date:   Thu, 12 Nov 2020 17:26:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201111092812.11329-6-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.20 10:28, Vlastimil Babka wrote:
> All per-cpu pagesets for a zone use the same high and batch values, that are
> duplicated there just for performance (locality) reasons. This patch adds the
> same variables also to struct zone as a shared copy.
> 
> This will be useful later for making possible to disable pcplists temporarily
> by setting high value to 0, while remembering the values for restoring them
> later. But we can also immediately benefit from not updating pagesets of all
> possible cpus in case the newly recalculated values (after sysctl change or
> memory online/offline) are actually unchanged from the previous ones.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>   include/linux/mmzone.h |  6 ++++++
>   mm/page_alloc.c        | 16 ++++++++++++++--
>   2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 7385871768d4..bb9188de2718 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -470,6 +470,12 @@ struct zone {
>   #endif
>   	struct pglist_data	*zone_pgdat;
>   	struct per_cpu_pageset __percpu *pageset;
> +	/*
> +	 * the high and batch values are copied to individual pagesets for
> +	 * faster access
> +	 */
> +	int pageset_high;
> +	int pageset_batch;
>   
>   #ifndef CONFIG_SPARSEMEM
>   	/*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8b43d6d1a288..25bc9bb77696 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5912,6 +5912,9 @@ static void build_zonelists(pg_data_t *pgdat)
>    * Other parts of the kernel may not check if the zone is available.
>    */
>   static void pageset_init(struct per_cpu_pageset *p);
> +/* These effectively disable the pcplists in the boot pageset completely */
> +#define BOOT_PAGESET_HIGH	0
> +#define BOOT_PAGESET_BATCH	1
>   static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
>   static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>   
> @@ -6301,8 +6304,8 @@ static void pageset_init(struct per_cpu_pageset *p)
>   	 * need to be as careful as pageset_update() as nobody can access the
>   	 * pageset yet.
>   	 */
> -	pcp->high = 0;
> -	pcp->batch = 1;
> +	pcp->high = BOOT_PAGESET_HIGH;
> +	pcp->batch = BOOT_PAGESET_BATCH;
>   }
>   
>   /*
> @@ -6326,6 +6329,13 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
>   		new_batch = max(1UL, 1 * new_batch);
>   	}
>   
> +	if (zone->pageset_high == new_high &&
> +	    zone->pageset_batch == new_batch)
> +		return;
> +
> +	zone->pageset_high = new_high;
> +	zone->pageset_batch = new_batch;
> +
>   	for_each_possible_cpu(cpu) {
>   		p = per_cpu_ptr(zone->pageset, cpu);
>   		pageset_update(&p->pcp, new_high, new_batch);
> @@ -6386,6 +6396,8 @@ static __meminit void zone_pcp_init(struct zone *zone)
>   	 * offset of a (static) per cpu variable into the per cpu area.
>   	 */
>   	zone->pageset = &boot_pageset;
> +	zone->pageset_high = BOOT_PAGESET_HIGH;
> +	zone->pageset_batch = BOOT_PAGESET_BATCH;
>   
>   	if (populated_zone(zone))
>   		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%u\n",
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

