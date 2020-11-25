Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757CB2C4382
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgKYPid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:38:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:58618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731403AbgKYPiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:38:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5C3FAC22;
        Wed, 25 Nov 2020 15:38:18 +0000 (UTC)
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
Message-ID: <b92a1a50-b7cd-0b33-de2e-52d74c91925c@suse.cz>
Date:   Wed, 25 Nov 2020 16:38:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 9:27 AM, Alex Shi wrote:
> The current relock logical will change lru_lock when found a new
> lruvec, so if 2 memcgs are reading file or alloc page at same time,
> they could hold the lru_lock alternately, and wait for each other for
> fairness attribute of ticket spin lock.
> 
> This patch will sort that all lru_locks and only hold them once in
> above scenario. That could reduce fairness waiting for lock reget.
> Than, vm-scalability/case-lru-file-readtwice could get ~5% performance
> gain on my 2P*20core*HT machine.

Hm, once you sort the pages like this, it's a shame not to splice them 
instead of more list_del() + list_add() iterations. update_lru_size() 
could be also called once?

> Suggested-by: Konstantin Khlebnikov <koct9i@gmail.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   mm/swap.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 490553f3f9ef..c787b38bf9c0 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1009,24 +1009,65 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>   	trace_mm_lru_insertion(page, lru);
>   }
>   
> +struct lruvecs {
> +	struct list_head lists[PAGEVEC_SIZE];
> +	struct lruvec *vecs[PAGEVEC_SIZE];
> +};
> +
> +/* Sort pvec pages on their lruvec */
> +int sort_page_lruvec(struct lruvecs *lruvecs, struct pagevec *pvec)
> +{
> +	int i, j, nr_lruvec;
> +	struct page *page;
> +	struct lruvec *lruvec = NULL;
> +
> +	lruvecs->vecs[0] = NULL;
> +	for (i = nr_lruvec = 0; i < pagevec_count(pvec); i++) {
> +		page = pvec->pages[i];
> +		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +
> +		/* Try to find a same lruvec */
> +		for (j = 0; j <= nr_lruvec; j++)
> +			if (lruvec == lruvecs->vecs[j])
> +				break;
> +
> +		/* A new lruvec */
> +		if (j > nr_lruvec) {
> +			INIT_LIST_HEAD(&lruvecs->lists[nr_lruvec]);
> +			lruvecs->vecs[nr_lruvec] = lruvec;
> +			j = nr_lruvec++;
> +			lruvecs->vecs[nr_lruvec] = 0;
> +		}
> +
> +		list_add_tail(&page->lru, &lruvecs->lists[j]);
> +	}
> +
> +	return nr_lruvec;
> +}
> +
>   /*
>    * Add the passed pages to the LRU, then drop the caller's refcount
>    * on them.  Reinitialises the caller's pagevec.
>    */
>   void __pagevec_lru_add(struct pagevec *pvec)
>   {
> -	int i;
> -	struct lruvec *lruvec = NULL;
> +	int i, nr_lruvec;
>   	unsigned long flags = 0;
> +	struct page *page;
> +	struct lruvecs lruvecs;
>   
> -	for (i = 0; i < pagevec_count(pvec); i++) {
> -		struct page *page = pvec->pages[i];
> +	nr_lruvec = sort_page_lruvec(&lruvecs, pvec);
>   
> -		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
> -		__pagevec_lru_add_fn(page, lruvec);
> +	for (i = 0; i < nr_lruvec; i++) {
> +		spin_lock_irqsave(&lruvecs.vecs[i]->lru_lock, flags);
> +		while (!list_empty(&lruvecs.lists[i])) {
> +			page = lru_to_page(&lruvecs.lists[i]);
> +			list_del(&page->lru);
> +			__pagevec_lru_add_fn(page, lruvecs.vecs[i]);
> +		}
> +		spin_unlock_irqrestore(&lruvecs.vecs[i]->lru_lock, flags);
>   	}
> -	if (lruvec)
> -		unlock_page_lruvec_irqrestore(lruvec, flags);
> +
>   	release_pages(pvec->pages, pvec->nr);
>   	pagevec_reinit(pvec);
>   }
> 

