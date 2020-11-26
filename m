Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58442C565B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390859AbgKZNpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:45:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:34196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390196AbgKZNpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:45:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4956AC6A;
        Thu, 26 Nov 2020 13:45:34 +0000 (UTC)
Subject: Re: [PATCH 6/7] mm,hwpoison: Disable pcplists before grabbing a
 refcount
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-7-osalvador@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5512967d-a96a-c94e-7442-e5e71baa7b19@suse.cz>
Date:   Thu, 26 Nov 2020 14:45:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119105716.5962-7-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 11:57 AM, Oscar Salvador wrote:
> Currently, we have a sort of retry mechanism to make sure pages in
> pcp-lists are spilled to the buddy system, so we can handle those.
> 
> We can save us this extra checks with the new disable-pcplist mechanism
> that is available with [1].
> 
> zone_pcplist_disable makes sure to 1) disable pcplists, so any page
> that is freed up from that point onwards will end up in the buddy
> system and 2) drain pcplists, so those pages that already in pcplists
> are spilled to buddy.
> 
> With that, we can make a common entry point for grabbing a refcount
> from both soft_offline and memory_failure paths that is guarded by
> zone_pcplist_disable/zone_pcplist_enable.
> 
> [1] https://patchwork.kernel.org/project/linux-mm/cover/20201111092812.11329-1-vbabka@suse.cz/
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Note as you say the series should go after [1] above, which means after 
mm-page_alloc-disable-pcplists-during-memory-offline.patch in mmots, but 
currently it's ordered before, where zone_pcp_disable() etc doesn't yet exist. 
Found out as I review using checked out this commit from -next.

> ---
>   mm/memory-failure.c | 120 +++++++++++++++++++++-----------------------
>   1 file changed, 58 insertions(+), 62 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 4abf5d5ffc96..512613e9a1bd 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -985,26 +985,67 @@ static int __get_hwpoison_page(struct page *page)
>   	return 0;
>   }
>   
> -static int get_hwpoison_page(struct page *p)
> +/*
> + * Safely get reference count of an arbitrary page.
> + *
> + * Returns 0 for a free page, 1 for an in-use page,
> + * -EIO for a page-type we cannot handle and -EBUSY if we raced with an
> + * allocation.
> + * We only incremented refcount in case the page was already in-use and it
> + * is a known type we can handle.
> + */
> +static int get_any_page(struct page *p)
>   {
> -	int ret;
> -	bool drained = false;
> +	int ret = 0, pass = 0;
>   
> -retry:
> -	ret = __get_hwpoison_page(p);
> -	if (!ret && !is_free_buddy_page(p) && !page_count(p) && !drained) {
> -		/*
> -		 * The page might be in a pcplist, so try to drain those
> -		 * and see if we are lucky.
> -		 */
> -		drain_all_pages(page_zone(p));
> -		drained = true;
> -		goto retry;
> +try_again:
> +	if (!__get_hwpoison_page(p)) {
> +		if (page_count(p)) {
> +			/* We raced with an allocation, retry. */
> +			if (pass++ < 3)
> +				goto try_again;
> +			ret = -EBUSY;
> +		} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
> +			/* We raced with put_page, retry. */
> +			if (pass++ < 3)
> +				goto try_again;
> +			ret = -EIO;
> +		}
> +	} else {
> +		if (PageHuge(p) || PageLRU(p) || __PageMovable(p)) {
> +			ret = 1;
> +		} else {
> +			/*
> +			 * A page we cannot handle. Check whether we can turn
> +			 * it into something we can handle.
> +			 */
> +			if (pass++ < 3) {
> +				put_page(p);
> +				shake_page(p, 1);
> +				goto try_again;
> +			}
> +			put_page(p);
> +			ret = -EIO;
> +		}
>   	}
>   
>   	return ret;
>   }
>   
> +static int get_hwpoison_page(struct page *p, enum mf_flags ctxt)
> +{
> +	int ret;
> +
> +	zone_pcp_disable(page_zone(p));
> +	if (ctxt == MF_SOFT_OFFLINE)
> +		ret = get_any_page(p);
> +	else
> +		ret = __get_hwpoison_page(p);
> +	zone_pcp_enable(page_zone(p));
> +
> +	return ret;
> +}
> +
>   /*
>    * Do all that is necessary to remove user space mappings. Unmap
>    * the pages and send SIGBUS to the processes if the data was dirty.
> @@ -1185,7 +1226,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>   
>   	num_poisoned_pages_inc();
>   
> -	if (!get_hwpoison_page(p)) {
> +	if (!get_hwpoison_page(p, 0)) {
>   		/*
>   		 * Check "filter hit" and "race with other subpage."
>   		 */
> @@ -1387,7 +1428,7 @@ int memory_failure(unsigned long pfn, int flags)
>   	 * In fact it's dangerous to directly bump up page count from 0,
>   	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
>   	 */
> -	if (!get_hwpoison_page(p)) {
> +	if (!get_hwpoison_page(p, 0)) {
>   		if (is_free_buddy_page(p)) {
>   			if (take_page_off_buddy(p)) {
>   				page_ref_inc(p);
> @@ -1674,7 +1715,7 @@ int unpoison_memory(unsigned long pfn)
>   		return 0;
>   	}
>   
> -	if (!get_hwpoison_page(p)) {
> +	if (!get_hwpoison_page(p, 0)) {
>   		if (TestClearPageHWPoison(p))
>   			num_poisoned_pages_dec();
>   		unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
> @@ -1705,51 +1746,6 @@ int unpoison_memory(unsigned long pfn)
>   }
>   EXPORT_SYMBOL(unpoison_memory);
>   
> -/*
> - * Safely get reference count of an arbitrary page.
> - * Returns 0 for a free page, 1 for an in-use page, -EIO for a page-type we
> - * cannot handle and -EBUSY if we raced with an allocation.
> - * We only incremented refcount in case the page was already in-use and it is
> - * a known type we can handle.
> - */
> -static int get_any_page(struct page *p)
> -{
> -	int ret = 0, pass = 0;
> -
> -try_again:
> -	if (!get_hwpoison_page(p)) {
> -		if (page_count(p)) {
> -			/* We raced with an allocation, retry. */
> -			if (pass++ < 3)
> -				goto try_again;
> -			ret = -EBUSY;
> -		} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
> -			/* We raced with put_page, retry. */
> -			if (pass++ < 3)
> -				goto try_again;
> -			ret = -EIO;
> -		}
> -	} else {
> -		if (PageHuge(p) || PageLRU(p) || __PageMovable(p)) {
> -			ret = 1;
> -		} else {
> -			/*
> -			 * A page we cannot handle. Check whether we can turn
> -			 * it into something we can handle.
> -			 */
> -			if (pass++ < 3) {
> -				put_page(p);
> -				shake_page(p, 1);
> -				goto try_again;
> -			}
> -			put_page(p);
> -			ret = -EIO;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
>   static bool isolate_page(struct page *page, struct list_head *pagelist)
>   {
>   	bool isolated = false;
> @@ -1920,7 +1916,7 @@ int soft_offline_page(unsigned long pfn)
>   
>   retry:
>   	get_online_mems();
> -	ret = get_any_page(page);
> +	ret = get_hwpoison_page(page, MF_SOFT_OFFLINE);
>   	put_online_mems();
>   
>   	if (ret > 0) {
> 

