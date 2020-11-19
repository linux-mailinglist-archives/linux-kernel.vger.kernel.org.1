Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AED2B92F3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgKSM4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgKSM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:56:11 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889B0C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 04:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sWbrc4VvF/o948WHuvCmfd0y3g9QMiU9AieEM9zFY14=; b=Tn6FvpBrFUTga/6Eh9JSuaROM5
        z4rbME/IGJZPoxtm5TQ4bhIx518j2Pnbjp4UI0yFU3py6SOI7/qFtqv/hR97icQqDcyNR0Nd1dw3A
        c9ElpP4PJPYTnwMKhheneq3tlpjO+kqkq2RFsmFM/wLXKEoeXKHIFBTYbOUZWvI7m6loy+2R2+oDd
        3+CS3gjoqyuvyHhvBvi37wBV41Bd367YHnTXys/XMoh2z6/zyBLAKwe9nkmf4ouEMnD5HQsglssy0
        HucI9NXU8dQcA3AROQRBDmSPTmi4W8gosQGSDOy8l9RsV359Fu1us6WmeXPKFNlx0bokqeKl5oiTK
        lbLC40wA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfjTl-00029L-GU; Thu, 19 Nov 2020 12:56:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E51E3060AE;
        Thu, 19 Nov 2020 13:55:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B2FB2009C627; Thu, 19 Nov 2020 13:55:57 +0100 (CET)
Date:   Thu, 19 Nov 2020 13:55:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hannes@cmpxchg.org
Subject: Re: [RFC PATCH] mm: bail out from psi memstall when cond_resched
Message-ID: <20201119125557.GM3121392@hirez.programming.kicks-ass.net>
References: <1605669776-24242-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605669776-24242-1-git-send-email-zhaoyang.huang@unisoc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:22:56AM +0800, Zhaoyang Huang wrote:
> Memory reclaiming will run as several seconds in memory constraint system, which
> will be deemed as heavy memstall. Have the memory reclaim be more presiced by
> bailing out when cond_resched

How is this supposed to work on PREEMPT=y where cond_resched() is a NOP
and you can get preempted at any random point?

(leaving the rest for Johannes)
 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/vmscan.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a815f73..a083c85 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -316,6 +316,15 @@ static inline bool memcg_congested(struct pglist_data *pgdat,
>  }
>  #endif
>  
> +static inline void psi_cond_resched(void)
> +{
> +	unsigned long *flags;
> +
> +	if (current->flags & PF_MEMSTALL)
> +		psi_memstall_leave(&flags);
> +	cond_resched();
> +	psi_memstall_enter(&flags);
> +}
>  /*
>   * This misses isolated pages which are not accounted for to save counters.
>   * As the data only determines if reclaim or compaction continues, it is
> @@ -557,7 +566,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		total_scan -= shrinkctl->nr_scanned;
>  		scanned += shrinkctl->nr_scanned;
>  
> -		cond_resched();
> +		psi_cond_resched();
>  	}
>  
>  	if (next_deferred >= scanned)
> @@ -714,7 +723,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  
>  	up_read(&shrinker_rwsem);
>  out:
> -	cond_resched();
> +	psi_cond_resched();
>  	return freed;
>  }
>  
> @@ -1109,7 +1118,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  	unsigned nr_reclaimed = 0;
>  
>  	memset(stat, 0, sizeof(*stat));
> -	cond_resched();
> +	psi_cond_resched();
>  
>  	while (!list_empty(page_list)) {
>  		struct address_space *mapping;
> @@ -1118,7 +1127,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  		enum page_references references = PAGEREF_RECLAIM_CLEAN;
>  		bool dirty, writeback;
>  
> -		cond_resched();
> +		psi_cond_resched();
>  
>  		page = lru_to_page(page_list);
>  		list_del(&page->lru);
> @@ -2084,7 +2093,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  	spin_unlock_irq(&pgdat->lru_lock);
>  
>  	while (!list_empty(&l_hold)) {
> -		cond_resched();
> +		psi_cond_resched();
>  		page = lru_to_page(&l_hold);
>  		list_del(&page->lru);
>  
> @@ -2500,7 +2509,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
>  			}
>  		}
>  
> -		cond_resched();
> +		psi_cond_resched();
>  
>  		if (nr_reclaimed < nr_to_reclaim || scan_adjusted)
>  			continue;
> @@ -4149,7 +4158,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>  		.reclaim_idx = gfp_zone(gfp_mask),
>  	};
>  
> -	cond_resched();
> +	psi_cond_resched();
>  	fs_reclaim_acquire(sc.gfp_mask);
>  	/*
>  	 * We need to be able to allocate from the reserves for RECLAIM_UNMAP
> -- 
> 1.9.1
> 
