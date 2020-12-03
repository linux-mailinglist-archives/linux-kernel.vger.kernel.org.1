Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264682CD1AB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgLCIrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:47:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:55502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgLCIrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:47:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606985178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6uBKNokODkdqTYoyM5NJG9oDc6vJ30ASPH6NJV4BElk=;
        b=NCPr9J6dmvJLej5XeFrH/occ1ElUzlFRCUW20NDSvJNxKqQjgbqb9yW4eWfo3Zk/Cw8rE0
        PkVRO84WXtp0vu0Hh0YoV36FQcaQLFRLODqil7CuWAxnlB34oyFFe8fEEZHuTGqDXnLHlf
        pfr2XeXQHhfmPInT1KBPAy2oq+DIDsU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7E9DAC55;
        Thu,  3 Dec 2020 08:46:18 +0000 (UTC)
Date:   Thu, 3 Dec 2020 09:46:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        osalvador@suse.de, dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
Subject: Re: [PATCH 2/6] mm/gup: don't pin migrated cma pages in movable zone
Message-ID: <20201203084616.GY17338@dhcp22.suse.cz>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202052330.474592-3-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-12-20 00:23:26, Pavel Tatashin wrote:
> In order not to fragment CMA the pinned pages are migrated. However,
> they are migrated to ZONE_MOVABLE, which also should not have pinned pages.
> 
> Remove __GFP_MOVABLE, so pages can be migrated to zones where pinning
> is allowed.

I was wondering why we do have __GFP_MOVABLE at all. Took a shovel
and... 41b4dc14ee807 says:
: We have well defined scope API to exclude CMA region.  Use it rather than
: manipulating gfp_mask manually.  With this change, we can now restore
: __GFP_MOVABLE for gfp_mask like as usual migration target allocation.  It
: would result in that the ZONE_MOVABLE is also searched by page allocator.
: For hugetlb, gfp_mask is redefined since it has a regular allocation mask
: filter for migration target.  __GPF_NOWARN is added to hugetlb gfp_mask
: filter since a new user for gfp_mask filter, gup, want to be silent when
: allocation fails.

This clearly states that the priority was to increase the migration
target success rate rather than bother with the pinning aspect of the
target page. So I believe we have simply ignored/missed the point of the
movable zone guarantees back then and that was a mistake.
 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

I have to admit I am not really sure about the failure path. The code is
just too convoluted to follow. I presume the pin will fail in that case.
Anyway this wouldn't be anything new in this path. Movable zone
exclusion can make the failure slightly more possible in some setups but
fundamentally nothing new there.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index cdb8b9eeb016..3a76c005a3e2 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1610,7 +1610,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>  	long ret = nr_pages;
>  	struct migration_target_control mtc = {
>  		.nid = NUMA_NO_NODE,
> -		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
> +		.gfp_mask = GFP_USER | __GFP_NOWARN,
>  	};
>  
>  check_again:
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
