Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75212CD259
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbgLCJRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:17:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:56360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgLCJRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:17:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606987025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJo8+wKiZ3+Hg8cb6ALfgT2xkFoyxjLsrCfxit8Yp2E=;
        b=alp2N0FFF1Bw/AuR9hA68gWaE2No/3WseM0Njj+UjmgU98vy84/JmCpG/+zCbkBEGj8s4Q
        QAiKK8M8RbOrxPyLMJ9/JgkjDZBavCCWmqDdAO2JkkvFOuFmKFPVdvjyXn51YVRnUfXkMW
        ZvUvdj9sG2hcLBMEf5bH5OB9d9hv/Y4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08BC7AC55;
        Thu,  3 Dec 2020 09:17:05 +0000 (UTC)
Date:   Thu, 3 Dec 2020 10:17:03 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        osalvador@suse.de, dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
Subject: Re: [PATCH 5/6] mm: honor PF_MEMALLOC_NOMOVABLE for all allocations
Message-ID: <20201203091703.GA17338@dhcp22.suse.cz>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-6-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202052330.474592-6-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-12-20 00:23:29, Pavel Tatashin wrote:
[...]
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 611799c72da5..7a6d86d0bc5f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3766,20 +3766,25 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
>  	return alloc_flags;
>  }
>  
> -static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
> -					unsigned int alloc_flags)
> +static inline unsigned int cma_alloc_flags(gfp_t gfp_mask,
> +					   unsigned int alloc_flags)
>  {
>  #ifdef CONFIG_CMA
> -	unsigned int pflags = current->flags;
> -
> -	if (!(pflags & PF_MEMALLOC_NOMOVABLE) &&
> -	    gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> +	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
>  		alloc_flags |= ALLOC_CMA;
> -
>  #endif
>  	return alloc_flags;
>  }
>  
> +static inline gfp_t current_gfp_checkmovable(gfp_t gfp_mask)
> +{
> +	unsigned int pflags = current->flags;
> +
> +	if ((pflags & PF_MEMALLOC_NOMOVABLE))
> +		return gfp_mask & ~__GFP_MOVABLE;
> +	return gfp_mask;
> +}
> +

It sucks that we have to control both ALLOC and gfp flags. But wouldn't
it be simpler and more straightforward to keep current_alloc_flags as is
(module PF rename) and hook the gfp mask evaluation into current_gfp_context
and move it up before the first allocation attempt? All scope flags
should be applicable to the hot path as well. It would add few cycles to
there but the question is whether that would be noticeable over just
handling PF_MEMALLOC_NOMOVABLE on its own. The cache line would be
pulled in anyway.

-- 
Michal Hocko
SUSE Labs
