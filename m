Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488CF2723FE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgIUMgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgIUMgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:36:15 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E9C920756;
        Mon, 21 Sep 2020 12:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600691775;
        bh=Yya++rqCti24akWHP5axLMUN5TZbS4IFNEp/tocKAvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6yeCXDRVctlhXo6pPpw7E0pCB/M1cUG4tGqFwRdbeDXZb/cHhKi87ymEGyWUukCK
         VfDC5eostEg9pH3MNGcC7XVlttKONRSZjNdCtYySmDpwsvl23TQDVJ0KWx/yOqm7MY
         x0WCq/TTX1Bp7kxGLIsq8BM61keT7omGy88PRGpc=
Date:   Mon, 21 Sep 2020 15:36:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     mateusznosek0@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC PATCH] mm/page_alloc.c: clean code by merging two functions
Message-ID: <20200921123607.GT2142832@kernel.org>
References: <20200916110118.6537-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916110118.6537-1-mateusznosek0@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(added Mel)

On Wed, Sep 16, 2020 at 01:01:18PM +0200, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> The 'finalise_ac' function is just 'epilogue' for 'prepare_alloc_pages'.
> Therefore there is no need to keep them both so 'finalise_ac' content can
> be merged into 'prepare_alloc_pages' code. It would make
> '__alloc_pages_nodemask' cleaner when it comes to readability.

These functions were split from alloc_pages_nodemask() by commit
9cd7555875bb ("mm, page_alloc: split alloc_pages_nodemask()"), so at the
very least I'd add Mel to 'cc. 

> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
> ---
>  mm/page_alloc.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b9bd75cacf02..a094e297c88f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4824,12 +4824,6 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>  
>  	*alloc_flags = current_alloc_flags(gfp_mask, *alloc_flags);
>  
> -	return true;
> -}
> -
> -/* Determine whether to spread dirty pages and what the first usable zone */
> -static inline void finalise_ac(gfp_t gfp_mask, struct alloc_context *ac)
> -{
>  	/* Dirty zone balancing only done in the fast path */
>  	ac->spread_dirty_pages = (gfp_mask & __GFP_WRITE);
>  
> @@ -4840,6 +4834,8 @@ static inline void finalise_ac(gfp_t gfp_mask, struct alloc_context *ac)
>  	 */
>  	ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
>  					ac->highest_zoneidx, ac->nodemask);
> +
> +	return true;
>  }
>  
>  /*
> @@ -4868,8 +4864,6 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
>  		return NULL;
>  
> -	finalise_ac(gfp_mask, &ac);
> -
>  	/*
>  	 * Forbid the first pass from falling back to types that fragment
>  	 * memory until all local zones are considered.
> -- 
> 2.20.1
> 
> 

-- 
Sincerely yours,
Mike.
