Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C02C2CF1C4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgLDQUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:20:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:40784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgLDQUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:20:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E23D3ACC4;
        Fri,  4 Dec 2020 16:19:35 +0000 (UTC)
Subject: Re: [PATCH v2] mm: fix a race on nr_swap_pages
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1607050340-4535-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <56407d04-2178-8a0e-ae1b-a1a4b9d7912a@suse.cz>
Date:   Fri, 4 Dec 2020 17:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1607050340-4535-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/20 3:52 AM, Zhaoyang Huang wrote:
> The scenario on which "Free swap = -4kB" happens in my system, which is caused
> by several get_swap_pages racing with each other and show_swap_cache_info
> happens simutaniously. No need to add a lock on get_swap_page_of_type as we
> remove "Presub/PosAdd" here.
> 
> ProcessA			ProcessB			ProcessC
> ngoals = 1			ngoals = 1
> avail = nr_swap_pages(1)	avail = nr_swap_pages(1)
> nr_swap_pages(1) -= ngoals
> 				nr_swap_pages(0) -= ngoals
> 								nr_swap_pages = -1
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Better now.
Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> change of v2: fix bug of unpaired of spin_lock
> ---
> ---
>  mm/swapfile.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index cf63b5f..1212f17 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -974,9 +974,13 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  	/* Only single cluster request supported */
>  	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
>  
> +	spin_lock(&swap_avail_lock);
> +
>  	avail_pgs = atomic_long_read(&nr_swap_pages) / size;
> -	if (avail_pgs <= 0)
> +	if (avail_pgs <= 0) {
> +		spin_unlock(&swap_avail_lock);
>  		goto noswap;
> +	}
>  
>  	if (n_goal > SWAP_BATCH)
>  		n_goal = SWAP_BATCH;
> @@ -986,8 +990,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  
>  	atomic_long_sub(n_goal * size, &nr_swap_pages);
>  
> -	spin_lock(&swap_avail_lock);
> -
>  start_over:
>  	node = numa_node_id();
>  	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
> @@ -1061,14 +1063,13 @@ swp_entry_t get_swap_page_of_type(int type)
>  
>  	spin_lock(&si->lock);
>  	if (si->flags & SWP_WRITEOK) {
> -		atomic_long_dec(&nr_swap_pages);
>  		/* This is called for allocating swap entry, not cache */
>  		offset = scan_swap_map(si, 1);
>  		if (offset) {
> +			atomic_long_dec(&nr_swap_pages);
>  			spin_unlock(&si->lock);
>  			return swp_entry(type, offset);
>  		}
> -		atomic_long_inc(&nr_swap_pages);
>  	}
>  	spin_unlock(&si->lock);
>  fail:
> 

