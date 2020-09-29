Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBA027BEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgI2IIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:08:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgI2IIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:08:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601366895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NZqgpEnGlw/yFJNzuNE8kt5bwOkINOL/tVi9oJX+05o=;
        b=HzJ4ZMtnnrbiIh4xaB7E3DZLBL0ByMmwB6hy1JWMoZMQDAxQCuYHIqBbKPbZJuPk44UVIO
        FSeCNdRwj1cTYJO6ed/2lbwFy7dt+JPs+JKBzlj5Og49fBkTMek+T/7zNuB0E9BatVvzzu
        ZWUE17GS0NuWXxRRqakPGN0Rc2JOl5E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C6BEAFB2;
        Tue, 29 Sep 2020 08:08:15 +0000 (UTC)
Date:   Tue, 29 Sep 2020 10:08:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
Message-ID: <20200929080814.GB22035@dhcp22.suse.cz>
References: <1601283046-15329-1-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601283046-15329-1-git-send-email-iamjoonsoo.kim@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-09-20 17:50:46, Joonsoo Kim wrote:
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

This approach looks definitely better than the previous version.

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

But this condition is not clear to me. __rmqueue_smallest doesn't access
pcp lists. Maybe I have missed the point in the original discussion but
this deserves a comment at least.

> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
