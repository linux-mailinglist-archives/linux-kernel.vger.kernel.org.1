Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EFF2784E0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgIYKSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727324AbgIYKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:18:33 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601029110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=0XwP/uQuoeiMTNNBCFZ8KGy+E9qm/5GNoc7ZeWsjVJE=;
        b=glvZYklIEhDLnQ5zLJ1326AoD892e3raiQw2nRRmqq9ps4baHudDTinGdPW2KE7tw9x7/E
        509gKO357m8QRI+L/J/cZJUpe2Smg0Ml+QAyL39RJw7fst0HOpEs6lRLqe7mJF6eAVrU2d
        +uoXsf5RmL7BRtcGKTIqZSy9jirU+sQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-nFyL3JLPM3G1os6AcAagfg-1; Fri, 25 Sep 2020 06:18:29 -0400
X-MC-Unique: nFyL3JLPM3G1os6AcAagfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 638DF802EA3;
        Fri, 25 Sep 2020 10:18:27 +0000 (UTC)
Received: from [10.36.112.211] (ovpn-112-211.ams2.redhat.com [10.36.112.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A97301002C15;
        Fri, 25 Sep 2020 10:18:24 +0000 (UTC)
Subject: Re: [PATCH 1/9] mm, page_alloc: clean up pageset high and batch
 update
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-2-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <42a55288-b593-a5f8-ce7b-ca86d28fcc7a@redhat.com>
Date:   Fri, 25 Sep 2020 12:18:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922143712.12048-2-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.20 16:37, Vlastimil Babka wrote:
> The updates to pcplists' high and batch valued are handled by multiple
> functions that make the calculations hard to follow. Consolidate everything
> to pageset_set_high_and_batch() and remove pageset_set_batch() and
> pageset_set_high() wrappers.
> 
> The only special case using one of the removed wrappers was:
> build_all_zonelists_init()
>   setup_pageset()
>     pageset_set_batch()
> which was hardcoding batch as 0, so we can just open-code a call to
> pageset_update() with constant parameters instead.
> 
> No functional change.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/page_alloc.c | 49 ++++++++++++++++++++-----------------------------
>  1 file changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 60a0e94645a6..a163c5e561f2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5823,7 +5823,7 @@ static void build_zonelists(pg_data_t *pgdat)
>   * not check if the processor is online before following the pageset pointer.
>   * Other parts of the kernel may not check if the zone is available.
>   */
> -static void setup_pageset(struct per_cpu_pageset *p, unsigned long batch);
> +static void setup_pageset(struct per_cpu_pageset *p);
>  static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
>  static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>  
> @@ -5891,7 +5891,7 @@ build_all_zonelists_init(void)
>  	 * (a chicken-egg dilemma).
>  	 */
>  	for_each_possible_cpu(cpu)
> -		setup_pageset(&per_cpu(boot_pageset, cpu), 0);
> +		setup_pageset(&per_cpu(boot_pageset, cpu));
>  
>  	mminit_verify_zonelist();
>  	cpuset_init_current_mems_allowed();
> @@ -6200,12 +6200,6 @@ static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
>  	pcp->batch = batch;
>  }
>  
> -/* a companion to pageset_set_high() */
> -static void pageset_set_batch(struct per_cpu_pageset *p, unsigned long batch)
> -{
> -	pageset_update(&p->pcp, 6 * batch, max(1UL, 1 * batch));
> -}
> -
>  static void pageset_init(struct per_cpu_pageset *p)
>  {
>  	struct per_cpu_pages *pcp;
> @@ -6218,35 +6212,32 @@ static void pageset_init(struct per_cpu_pageset *p)
>  		INIT_LIST_HEAD(&pcp->lists[migratetype]);
>  }
>  
> -static void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
> +static void setup_pageset(struct per_cpu_pageset *p)
>  {
>  	pageset_init(p);
> -	pageset_set_batch(p, batch);
> +	pageset_update(&p->pcp, 0, 1);
>  }
>  
>  /*
> - * pageset_set_high() sets the high water mark for hot per_cpu_pagelist
> - * to the value high for the pageset p.
> + * Calculate and set new high and batch values for given per-cpu pageset of a
> + * zone, based on the zone's size and the percpu_pagelist_fraction sysctl.
>   */
> -static void pageset_set_high(struct per_cpu_pageset *p,
> -				unsigned long high)
> -{
> -	unsigned long batch = max(1UL, high / 4);
> -	if ((high / 4) > (PAGE_SHIFT * 8))
> -		batch = PAGE_SHIFT * 8;
> -
> -	pageset_update(&p->pcp, high, batch);
> -}
> -
>  static void pageset_set_high_and_batch(struct zone *zone,
> -				       struct per_cpu_pageset *pcp)
> +				       struct per_cpu_pageset *p)
>  {
> -	if (percpu_pagelist_fraction)
> -		pageset_set_high(pcp,
> -			(zone_managed_pages(zone) /
> -				percpu_pagelist_fraction));
> -	else
> -		pageset_set_batch(pcp, zone_batchsize(zone));
> +	unsigned long new_high, new_batch;
> +
> +	if (percpu_pagelist_fraction) {
> +		new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
> +		new_batch = max(1UL, new_high / 4);
> +		if ((new_high / 4) > (PAGE_SHIFT * 8))
> +			new_batch = PAGE_SHIFT * 8;
> +	} else {
> +		new_batch = zone_batchsize(zone);
> +		new_high = 6 * new_batch;
> +		new_batch = max(1UL, 1 * new_batch);
> +	}
> +	pageset_update(&p->pcp, new_high, new_batch);
>  }
>  
>  static void __meminit zone_pageset_init(struct zone *zone, int cpu)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

