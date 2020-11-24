Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50B82C25D7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbgKXMjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:39:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:38610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732586AbgKXMjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:39:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAE93AE6D;
        Tue, 24 Nov 2020 12:39:33 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction: make defer_compaction and
 compaction_deferred static
To:     Hui Su <sh_def@163.com>, akpm@linux-foundation.org,
        nigupta@nvidia.com, bhe@redhat.com, mateusznosek0@gmail.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201123170801.GA9625@rlk>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b4066545-2339-d4ba-ca3f-d22735f8a35b@suse.cz>
Date:   Tue, 24 Nov 2020 13:39:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201123170801.GA9625@rlk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/20 6:08 PM, Hui Su wrote:
> defer_compaction() and  compaction_deferred() and
> compaction_restarting() in mm/compaction.c won't
> be used in other files, so make them static, and
> remove the declaration in the header file.
> 
> Take the chance to fix a typo.
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   include/linux/compaction.h | 12 ------------
>   mm/compaction.c            |  8 ++++----
>   2 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index 1de5a1151ee7..ed4070ed41ef 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -98,11 +98,8 @@ extern void reset_isolation_suitable(pg_data_t *pgdat);
>   extern enum compact_result compaction_suitable(struct zone *zone, int order,
>   		unsigned int alloc_flags, int highest_zoneidx);
>   
> -extern void defer_compaction(struct zone *zone, int order);
> -extern bool compaction_deferred(struct zone *zone, int order);
>   extern void compaction_defer_reset(struct zone *zone, int order,
>   				bool alloc_success);
> -extern bool compaction_restarting(struct zone *zone, int order);
>   
>   /* Compaction has made some progress and retrying makes sense */
>   static inline bool compaction_made_progress(enum compact_result result)
> @@ -194,15 +191,6 @@ static inline enum compact_result compaction_suitable(struct zone *zone, int ord
>   	return COMPACT_SKIPPED;
>   }
>   
> -static inline void defer_compaction(struct zone *zone, int order)
> -{
> -}
> -
> -static inline bool compaction_deferred(struct zone *zone, int order)
> -{
> -	return true;
> -}
> -
>   static inline bool compaction_made_progress(enum compact_result result)
>   {
>   	return false;
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 13cb7a961b31..60135a820b55 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -157,7 +157,7 @@ EXPORT_SYMBOL(__ClearPageMovable);
>    * allocation success. 1 << compact_defer_shift, compactions are skipped up
>    * to a limit of 1 << COMPACT_MAX_DEFER_SHIFT
>    */
> -void defer_compaction(struct zone *zone, int order)
> +static void defer_compaction(struct zone *zone, int order)
>   {
>   	zone->compact_considered = 0;
>   	zone->compact_defer_shift++;
> @@ -172,7 +172,7 @@ void defer_compaction(struct zone *zone, int order)
>   }
>   
>   /* Returns true if compaction should be skipped this time */
> -bool compaction_deferred(struct zone *zone, int order)
> +static bool compaction_deferred(struct zone *zone, int order)
>   {
>   	unsigned long defer_limit = 1UL << zone->compact_defer_shift;
>   
> @@ -209,7 +209,7 @@ void compaction_defer_reset(struct zone *zone, int order,
>   }
>   
>   /* Returns true if restarting compaction after many failures */
> -bool compaction_restarting(struct zone *zone, int order)
> +static bool compaction_restarting(struct zone *zone, int order)
>   {
>   	if (order < zone->compact_order_failed)
>   		return false;
> @@ -237,7 +237,7 @@ static void reset_cached_positions(struct zone *zone)
>   }
>   
>   /*
> - * Compound pages of >= pageblock_order should consistenly be skipped until
> + * Compound pages of >= pageblock_order should consistently be skipped until
>    * released. It is always pointless to compact pages of such order (if they are
>    * migratable), and the pageblocks they occupy cannot contain any free pages.
>    */
> 

