Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCEF3043C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392854AbhAZQZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:25:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:40192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391033AbhAZQZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:25:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE0D9ACF5;
        Tue, 26 Jan 2021 16:24:57 +0000 (UTC)
Subject: Re: [PATCH] mm/workingset.c: avoid unnecessary max_nodes estimation
 in count_shadow_nodes()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210123073825.46709-1-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8dea8eff-3100-4f57-5d61-e532803d256f@suse.cz>
Date:   Tue, 26 Jan 2021 17:24:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210123073825.46709-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/21 8:38 AM, Miaohe Lin wrote:
> If list_lru_shrink_count is 0, we always return SHRINK_EMPTY regardless of
> the value of max_nodes. So we can return early if nodes == 0 to save some
> cpu cycles of approximating a reasonable limit for the nodes.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/workingset.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 10e96de945b3..7db8f3dad13c 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -461,6 +461,8 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
>  	unsigned long pages;
>  
>  	nodes = list_lru_shrink_count(&shadow_nodes, sc);
> +	if (!nodes)
> +		return SHRINK_EMPTY;
>  
>  	/*
>  	 * Approximate a reasonable limit for the nodes
> @@ -503,9 +505,6 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
>  
>  	max_nodes = pages >> (XA_CHUNK_SHIFT - 3);
>  
> -	if (!nodes)
> -		return SHRINK_EMPTY;
> -
>  	if (nodes <= max_nodes)
>  		return 0;
>  	return nodes - max_nodes;
> 

