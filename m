Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC862FA07E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391950AbhARMyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:54:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:40818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404060AbhARMht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:37:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7CBBCACBA;
        Mon, 18 Jan 2021 12:37:06 +0000 (UTC)
Subject: Re: [PATCH V2] mm/compaction: correct deferral logic for proactive
 compaction
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, mhocko@suse.com, khalid.aziz@oracle.com,
        ngupta@nitingupta.dev, vinmenon@codeaurora.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1610972408-20986-1-git-send-email-charante@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <777bf9c5-82db-041b-55ee-6868ab78ef70@suse.cz>
Date:   Mon, 18 Jan 2021 13:37:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1610972408-20986-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/21 1:20 PM, Charan Teja Reddy wrote:
> should_proactive_compact_node() returns true when sum of the
> weighted fragmentation score of all the zones in the node is greater
> than the wmark_high of compaction, which then triggers the proactive
> compaction that operates on the individual zones of the node. But
> proactive compaction runs on the zone only when its weighted
> fragmentation score is greater than wmark_low(=wmark_high - 10).
> 
> This means that the sum of the weighted fragmentation scores of all the
> zones can exceed the wmark_high but individual weighted fragmentation
> zone scores can still be less than wmark_low which makes the unnecessary
> trigger of the proactive compaction only to return doing nothing.
> 
> Issue with the return of proactive compaction with out even trying is
> its deferral. It is simply deferred for 1 << COMPACT_MAX_DEFER_SHIFT if
> the scores across the proactive compaction is same, thinking that
> compaction didn't make any progress but in reality it didn't even try.
> With the delay between successive retries for proactive compaction is
> 500msec, it can result into the deferral for ~30sec with out even trying
> the proactive compaction.
> 
> Test scenario is that: compaction_proactiveness=50 thus the wmark_low =
> 50 and wmark_high = 60. System have 2 zones(Normal and Movable) with
> sizes 5GB and 6GB respectively. After opening some apps on the android,
> the weighted fragmentation scores of these zones are 47 and 49
> respectively. Since the sum of these fragmentation scores are above the
> wmark_high which triggers the proactive compaction and there since the
> individual zones weighted fragmentation scores are below wmark_low, it
> returns without trying the proactive compaction. As a result the
> weighted fragmentation scores of the zones are still 47 and 49 which
> makes the existing logic to defer the compaction thinking that
> noprogress is made across the compaction.
> 
> Fix this by checking just zone fragmentation score, not the weighted, in
> __compact_finished() and use the zones weighted fragmentation score in
> fragmentation_score_node(). In the test case above, If the weighted
> average of is above wmark_high, then individual score (not adjusted) of
> atleast one zone has to be above wmark_high. Thus it avoids the
> unnecessary trigger and deferrals of the proactive compaction.
> 
> Fix-suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

But I would move fragmentation_score_zone() above
fragmentation_score_zone_weighted(), so fragmentation_score_zone_weighted() can
call fragmentation_score_zone() instead of having two places with
extfrag_for_order(...).

Thanks.

> ---
> 
> Changes in V2: Addressed comments from vlastimil
> 
> Changes in V1: https://lore.kernel.org/patchwork/patch/1364646/
> 
>  mm/compaction.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e5acb97..1b98427 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1924,16 +1924,16 @@ static bool kswapd_is_running(pg_data_t *pgdat)
>  }
>  
>  /*
> - * A zone's fragmentation score is the external fragmentation wrt to the
> - * COMPACTION_HPAGE_ORDER scaled by the zone's size. It returns a value
> - * in the range [0, 100].
> + * A weighted zone's fragmentation score is the external fragmentation
> + * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
> + * returns a value in the range [0, 100].
>   *
>   * The scaling factor ensures that proactive compaction focuses on larger
>   * zones like ZONE_NORMAL, rather than smaller, specialized zones like
>   * ZONE_DMA32. For smaller zones, the score value remains close to zero,
>   * and thus never exceeds the high threshold for proactive compaction.
>   */
> -static unsigned int fragmentation_score_zone(struct zone *zone)
> +static unsigned int fragmentation_score_zone_weighted(struct zone *zone)
>  {
>  	unsigned long score;
>  
> @@ -1943,6 +1943,15 @@ static unsigned int fragmentation_score_zone(struct zone *zone)
>  }
>  
>  /*
> + * A zone's fragmentation score is the external fragmentation wrt to the
> + * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
> + */
> +static unsigned int fragmentation_score_zone(struct zone *zone)
> +{
> +	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
> +}
> +
> +/*
>   * The per-node proactive (background) compaction process is started by its
>   * corresponding kcompactd thread when the node's fragmentation score
>   * exceeds the high threshold. The compaction process remains active till
> @@ -1958,7 +1967,7 @@ static unsigned int fragmentation_score_node(pg_data_t *pgdat)
>  		struct zone *zone;
>  
>  		zone = &pgdat->node_zones[zoneid];
> -		score += fragmentation_score_zone(zone);
> +		score += fragmentation_score_zone_weighted(zone);
>  	}
>  
>  	return score;
> 

