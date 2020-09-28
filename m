Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB327B877
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgI1XwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgI1XwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:52:16 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A39B2207D8;
        Mon, 28 Sep 2020 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601337136;
        bh=wFhp55ulXjxuuIoaT0rVvAcVgZE0echpnHPUtNYAzCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NC7nJD6uGd78qkf48jTtE1RBIgE33wxNfXuWqjZLRm5fsfTb4jyLY/LcVJzorvCkM
         0pAWGrxMv1T5+gTxUUh6YrvU14dMc0NpQ3DwrrQskblkfs1LOGOAQaSISYnrXc2wwL
         iHtAqWUQVF1DR5P24hiEwrUkpRHgihEA0Ks0tUrY=
Date:   Mon, 28 Sep 2020 16:52:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     js1304@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
Message-Id: <20200928165215.f46924bfff9a109131048f81@linux-foundation.org>
In-Reply-To: <1601283046-15329-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1601283046-15329-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 17:50:46 +0900 js1304@gmail.com wrote:

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

Changelog doesn't describe the end-user visible effects of the bug. 
Please send this description?

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

We still really really don't want to be adding overhead to the page
allocation hotpath for a really really obscure feature from a single
callsite.

Do we have an understanding of how many people's kernels are enabling
CONFIG_CMA?

I previously suggested retrying the allocation in
__gup_longterm_locked() but you said "it cannot ensure that we
eventually get the non-CMA page".  Please explain why?

What about manually emptying the pcplists beforehand? 

Or byassing the pcplists for this caller and calling __rmqueue() directly?

> @@ -3381,7 +3388,7 @@ struct page *rmqueue(struct zone *preferred_zone,
>  
>  	do {
>  		page = NULL;
> -		if (alloc_flags & ALLOC_HARDER) {
> +		if (order > 0 && alloc_flags & ALLOC_HARDER) {
>  			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
>  			if (page)
>  				trace_mm_page_alloc_zone_locked(page, order, migratetype);

What does this hunk do?
