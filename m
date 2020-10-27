Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B5829C7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829050AbgJ0SqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:46:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:35698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1829009AbgJ0Sp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:45:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6937ABA2;
        Tue, 27 Oct 2020 18:45:54 +0000 (UTC)
Subject: Re: [PATCH] mm/list_lru: optimize condition of exiting the loop
To:     Hui Su <sh_def@163.com>, akpm@linux-foundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201027170420.GA61326@rlk>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ae359cb8-5bf9-c2e5-ddd0-812df81de0fb@suse.cz>
Date:   Tue, 27 Oct 2020 19:45:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201027170420.GA61326@rlk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 6:04 PM, Hui Su wrote:
> In list_lru_walk(), nr_to_walk type is 'unsigned long',
> so nr_to_walk won't be '< 0'.
> 
> In list_lru_walk_node(), nr_to_walk type is 'unsigned long',
> so *nr_to_walk won't be '< 0' too.
> 
> We can use '!nr_to_walk' instead of 'nr_to_walk <= 0', which
> is more precise.
> 
> Signed-off-by: Hui Su <sh_def@163.com>

OK. Why not this too?

--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -294,7 +294,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,

         isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
                                       nr_to_walk);
-       if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
+       if (*nr_to_walk && list_lru_memcg_aware(lru)) {
                 for_each_memcg_cache_index(memcg_idx) {
                         struct list_lru_node *nlru = &lru->node[nid];


> ---
>   include/linux/list_lru.h | 2 +-
>   mm/list_lru.c            | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
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
> index 5aa6e44bc2ae..39b8d467159d 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
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

