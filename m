Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BDB2A086C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgJ3OuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:50:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:59516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgJ3OuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:50:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52D8FAF55;
        Fri, 30 Oct 2020 14:50:05 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during page
 isolation.
To:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
References: <20201029200435.3386066-1-zi.yan@sent.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <16bdfad8-05f9-6ecf-0db6-c2dcf8e60309@suse.cz>
Date:   Fri, 30 Oct 2020 15:50:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201029200435.3386066-1-zi.yan@sent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/20 9:04 PM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> In isolate_migratepages_block, when cc->alloc_contig is true, we are
> able to isolate compound pages, nr_migratepages and nr_isolated did not
> count compound pages correctly, causing us to isolate more pages than we
> thought. Use thp_nr_pages to count pages. Otherwise, we might be trapped
> in too_many_isolated while loop, since the actual isolated pages can go
> up to COMPACT_CLUSTER_MAX*512=16384, where COMPACT_CLUSTER_MAX is 32,
> since we stop isolation after cc->nr_migratepages reaches to
> COMPACT_CLUSTER_MAX.

I wonder if a better fix would be to adjust the too_many_isolated() check so 
that if we have non-zero cc->nr_migratepages, we bail out from further isolation 
and migrate what we have immediately, instead of looping.

Because I can also imagine a hypothetical situation where multiple threads in 
parallel cause too_many_isolated() to be true, and will all loop there forever. 
The proposed fix should prevent such situation as well, AFAICT.

> In addition, after we fix the issue above, cc->nr_migratepages could
> never be equal to COMPACT_CLUSTER_MAX if compound pages are isolated,
> thus page isolation could not stop as we intended. Change the isolation
> stop condition to >=.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/compaction.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index ee1f8439369e..0683a4999581 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1012,8 +1012,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   
>   isolate_success:
>   		list_add(&page->lru, &cc->migratepages);
> -		cc->nr_migratepages++;
> -		nr_isolated++;
> +		cc->nr_migratepages += thp_nr_pages(page);
> +		nr_isolated += thp_nr_pages(page);
>   
>   		/*
>   		 * Avoid isolating too much unless this block is being
> @@ -1021,7 +1021,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   		 * or a lock is contended. For contention, isolate quickly to
>   		 * potentially remove one source of contention.
>   		 */
> -		if (cc->nr_migratepages == COMPACT_CLUSTER_MAX &&
> +		if (cc->nr_migratepages >= COMPACT_CLUSTER_MAX &&
>   		    !cc->rescan && !cc->contended) {
>   			++low_pfn;
>   			break;
> @@ -1132,7 +1132,7 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
>   		if (!pfn)
>   			break;
>   
> -		if (cc->nr_migratepages == COMPACT_CLUSTER_MAX)
> +		if (cc->nr_migratepages >= COMPACT_CLUSTER_MAX)
>   			break;
>   	}
>   
> 

