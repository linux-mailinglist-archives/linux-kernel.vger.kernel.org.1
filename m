Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA9C27BEED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgI2INO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:13:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:53020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgI2INN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:13:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14F04B28E;
        Tue, 29 Sep 2020 08:13:12 +0000 (UTC)
Subject: Re: [PATCH v2 for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1601283046-15329-1-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ea529528-0fcf-5a57-ebc7-1692bcf15b0f@suse.cz>
Date:   Tue, 29 Sep 2020 10:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1601283046-15329-1-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/20 10:50 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> memalloc_nocma_{save/restore} APIs can be used to skip page allocation
> on CMA area, but, there is a missing case and the page on CMA area could
> be allocated even if APIs are used. This patch handles this case to fix
> the potential issue.
> 
> Missing case is an allocation from the pcplist. MIGRATE_MOVABLE pcplist
> could have the pages on CMA area so we need to skip it if ALLOC_CMA isn't
> specified.
> 
> Fixes: 8510e69c8efe (mm/page_alloc: fix memalloc_nocma_{save/restore} APIs)
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

It's unfortunate, but hopefully we can still get the CMA in ZONE_MOVABLE one day
and get rid of all of this again? :)

For that reason I'd prefer simple solutions even if there's some potential
overhead. I think those tests should be in the noise, and avoided completely
with !CONFIG_CMA.

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fab5e97..104d2e1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3367,9 +3367,16 @@ struct page *rmqueue(struct zone *preferred_zone,
>  	struct page *page;
>  
>  	if (likely(order == 0)) {
> -		page = rmqueue_pcplist(preferred_zone, zone, gfp_flags,
> +		/*
> +		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
> +		 * we need to skip it when CMA area isn't allowed.
> +		 */
> +		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
> +				migratetype != MIGRATE_MOVABLE) {
> +			page = rmqueue_pcplist(preferred_zone, zone, gfp_flags,
>  					migratetype, alloc_flags);
> -		goto out;
> +			goto out;
> +		}
>  	}
>  
>  	/*
> @@ -3381,7 +3388,7 @@ struct page *rmqueue(struct zone *preferred_zone,
>  
>  	do {
>  		page = NULL;
> -		if (alloc_flags & ALLOC_HARDER) {
> +		if (order > 0 && alloc_flags & ALLOC_HARDER) {
>  			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
>  			if (page)
>  				trace_mm_page_alloc_zone_locked(page, order, migratetype);
> 

