Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D386C2FBB85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389801AbhASPoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:44:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58882 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731777AbhASPnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:43:52 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JFYQgD167515;
        Tue, 19 Jan 2021 15:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=V0kYueDXaWXyJ8p6jGIvd/ZZmVFBk9tzIl0RIlBMXz4=;
 b=Fe6L9aNGbGre4ZHPT0wFFQAHGk3Fr8PkkMllbhyFC0kFac8Cll/wUUX6/HICCZV5A4gi
 /HNuqke/RUTpZ2i+gAQlP8oukzDOUpZGt4Ftm4hXPZFGWmvYKHdXf/frkRaie6Pf++ch
 3mcqtWeZd9GrgagTDL0m97P4ZAeGDYVFYGr3koIZkzfuql/Ly5YW9zEMCp9oEylduJ3Z
 reEnQbXjKVwIAe0WDFjfFfMEGC97t5T9qC0C2wMPUpC7jKAatmYvNm3AmtcZQjWRvZjB
 kN0zc9orkwofQioSOEkNvPRMJDJuRP/q0/wGHHsgmIyCoQVy0/tXmsrbty4U7dIbBYAg 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 363nnahuch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 15:42:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JFZi2F083638;
        Tue, 19 Jan 2021 15:42:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3661equj83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 15:42:58 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10JFgunt013377;
        Tue, 19 Jan 2021 15:42:56 GMT
Received: from [10.65.183.184] (/10.65.183.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jan 2021 07:42:56 -0800
Subject: Re: [PATCH V3] mm/compaction: correct deferral logic for proactive
 compaction
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        ngupta@nitingupta.dev, vinmenon@codeaurora.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1610989938-31374-1-git-send-email-charante@codeaurora.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <5343d1b9-a9b1-9967-1f88-5d37ec93274c@oracle.com>
Date:   Tue, 19 Jan 2021 08:42:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1610989938-31374-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/21 10:12 AM, Charan Teja Reddy wrote:
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
> ---
> 
> Changes in V3: Addressed suggestions from Vlastimil
> 
> Changes in V2: https://lore.kernel.org/patchwork/patch/1366862/
> 
> Changes in V1: https://lore.kernel.org/patchwork/patch/1364646/
> 
>   mm/compaction.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e5acb97..ccddb3a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1925,20 +1925,28 @@ static bool kswapd_is_running(pg_data_t *pgdat)
>   
>   /*
>    * A zone's fragmentation score is the external fragmentation wrt to the
> - * COMPACTION_HPAGE_ORDER scaled by the zone's size. It returns a value
> - * in the range [0, 100].
> + * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
> + */
> +static unsigned int fragmentation_score_zone(struct zone *zone)
> +{
> +	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
> +}
> +
> +/*
> + * A weighted zone's fragmentation score is the external fragmentation
> + * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
> + * returns a value in the range [0, 100].
>    *
>    * The scaling factor ensures that proactive compaction focuses on larger
>    * zones like ZONE_NORMAL, rather than smaller, specialized zones like
>    * ZONE_DMA32. For smaller zones, the score value remains close to zero,
>    * and thus never exceeds the high threshold for proactive compaction.
>    */
> -static unsigned int fragmentation_score_zone(struct zone *zone)
> +static unsigned int fragmentation_score_zone_weighted(struct zone *zone)
>   {
>   	unsigned long score;
>   
> -	score = zone->present_pages *
> -			extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
> +	score = zone->present_pages * fragmentation_score_zone(zone);
>   	return div64_ul(score, zone->zone_pgdat->node_present_pages + 1);
>   }
>   
> @@ -1958,7 +1966,7 @@ static unsigned int fragmentation_score_node(pg_data_t *pgdat)
>   		struct zone *zone;
>   
>   		zone = &pgdat->node_zones[zoneid];
> -		score += fragmentation_score_zone(zone);
> +		score += fragmentation_score_zone_weighted(zone);
>   	}
>   
>   	return score;
> 

Looks good.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>

