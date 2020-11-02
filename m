Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9E72A2B9C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgKBNeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:34:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:42744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgKBNeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:34:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E695AEDA;
        Mon,  2 Nov 2020 13:34:15 +0000 (UTC)
Subject: Re: [PATCH v2] mm/list_lru: optimize condition of exiting the loop
To:     Hui Su <sh_def@163.com>, akpm@linux-foundation.org,
        gustavo@embeddedor.com, songmuchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20201028141646.GA75933@rlk>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f9da5b26-17b8-2d55-c725-215be4410368@suse.cz>
Date:   Mon, 2 Nov 2020 14:34:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201028141646.GA75933@rlk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 3:16 PM, Hui Su wrote:
> In list_lru_walk(), nr_to_walk type is 'unsigned long',
> so nr_to_walk won't be '< 0'.
> 
> In list_lru_walk_node(), nr_to_walk type is 'unsigned long',
> so *nr_to_walk won't be '< 0' too.
> 
> We can use '!nr_to_walk' instead of 'nr_to_walk <= 0', which
> is more precise.

Yes, imho comparisons that make no sense are only misleading for the readers. 
Compilers can probably find out easier, so maybe there's no code generation 
change, but for making it less misleading:

> Signed-off-by: Hui Su <sh_def@163.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   include/linux/list_lru.h | 2 +-
>   mm/list_lru.c            | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index 9dcaa3e582c9..b7bc4a2636b9 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -214,7 +214,7 @@ list_lru_walk(struct list_lru *lru, list_lru_walk_cb isolate,
>   	for_each_node_state(nid, N_NORMAL_MEMORY) {
>   		isolated += list_lru_walk_node(lru, nid, isolate,
>   					       cb_arg, &nr_to_walk);
> -		if (nr_to_walk <= 0)
> +		if (!nr_to_walk)
>   			break;
>   	}
>   	return isolated;
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 5aa6e44bc2ae..35be4de9fd77 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -294,7 +294,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
>   
>   	isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
>   				      nr_to_walk);
> -	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
> +	if (*nr_to_walk && list_lru_memcg_aware(lru)) {
>   		for_each_memcg_cache_index(memcg_idx) {
>   			struct list_lru_node *nlru = &lru->node[nid];
>   
> @@ -304,7 +304,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
>   							nr_to_walk);
>   			spin_unlock(&nlru->lock);
>   
> -			if (*nr_to_walk <= 0)
> +			if (!*nr_to_walk)
>   				break;
>   		}
>   	}
> 

