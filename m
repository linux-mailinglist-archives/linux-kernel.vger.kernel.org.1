Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F40B2CDD0A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbgLCSEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:04:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:45374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729046AbgLCSEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:04:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CE2DAC2E;
        Thu,  3 Dec 2020 18:03:51 +0000 (UTC)
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1606995362-16413-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix a race on nr_swap_pages
Message-ID: <4c9b5a0c-9971-9960-b6a2-4e2966fb145b@suse.cz>
Date:   Thu, 3 Dec 2020 19:03:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1606995362-16413-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/20 12:36 PM, Zhaoyang Huang wrote:
> The scenario on which "Free swap -4kB" happens in my system, which is caused by
>  get_swap_page_of_type or get_swap_pages racing with show_mem. Remove the race
>  here.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/swapfile.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index cf63b5f..13201b6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -974,6 +974,8 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  	/* Only single cluster request supported */
>  	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
>  
> +	spin_lock(&swap_avail_lock);
> +
>  	avail_pgs = atomic_long_read(&nr_swap_pages) / size;
>  	if (avail_pgs <= 0)
>  		goto noswap;

This goto will leave with the spin lock locked, so that's a bug.

> @@ -986,8 +988,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  
>  	atomic_long_sub(n_goal * size, &nr_swap_pages);
>  
> -	spin_lock(&swap_avail_lock);
> -

Is the problem that while we adjust n_goal with a min3(..., avail_pgs), somebody
else can decrease nr_swap_pages in the meanwhile and then we underflow? If yes,
the spin lock won't eliminate all such cases it seems, as e.g.
get_swap_page_of_type isn't done under the same lock, AFAIK.

>  start_over:
>  	node = numa_node_id();
>  	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
> @@ -1061,14 +1061,13 @@ swp_entry_t get_swap_page_of_type(int type)
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

This hunk looks safer, unless I miss something. Did you check if it's enough to
prevent the negative values on your systems?

>  	}
>  	spin_unlock(&si->lock);
>  fail:
> 

