Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F2290A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410729AbgJPQ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:58:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:49366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410160AbgJPQ6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:58:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E463EAE37;
        Fri, 16 Oct 2020 16:58:33 +0000 (UTC)
Subject: Re: [PATCH] mm/slub: make add_full() condition more explicit
To:     wuyun.wu@huawei.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     liu.xiang6@zte.com.cn,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200811020240.1231-1-wuyun.wu@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3ef24214-38c7-1238-8296-88caf7f48ab6@suse.cz>
Date:   Fri, 16 Oct 2020 18:58:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20200811020240.1231-1-wuyun.wu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/20 4:02 AM, wuyun.wu@huawei.com wrote:
> From: Abel Wu <wuyun.wu@huawei.com>
> 
> The commit below is incomplete, as it didn't handle the add_full() part.
> commit a4d3f8916c65 ("slub: remove useless kmem_cache_debug() before remove_full()")
> 
> This patch checks for SLAB_STORE_USER instead of kmem_cache_debug(),
> since that should be the only context in which we need the list_lock for
> add_full().
> 
> Signed-off-by: Abel Wu <wuyun.wu@huawei.com>
> ---
>   mm/slub.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f226d66408ee..df93a5a0e9a4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2182,7 +2182,8 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
>   		}
>   	} else {
>   		m = M_FULL;
> -		if (kmem_cache_debug(s) && !lock) {
> +#ifdef CONFIG_SLUB_DEBUG
> +		if ((s->flags & SLAB_STORE_USER) && !lock) {
>   			lock = 1;
>   			/*
>   			 * This also ensures that the scanning of full
> @@ -2191,6 +2192,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
>   			 */
>   			spin_lock(&n->list_lock);
>   		}
> +#endif
>   	}
>   
>   	if (l != m) {
> 

Hm I missed this, otherwise I would have suggested the following

-----8<-----
 From 0b43c7e20c81241f4b74cdb366795fc0b94a25c9 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 16 Oct 2020 18:46:06 +0200
Subject: [PATCH] mm, slub: use kmem_cache_debug_flags() in deactivate_slab()

Commit 9cf7a1118365 ("mm/slub: make add_full() condition more explicit")
replaced an unnecessarily generic kmem_cache_debug(s) check with an explicit
check of SLAB_STORE_USER and #ifdef CONFIG_SLUB_DEBUG.

We can achieve the same specific check with the recently added
kmem_cache_debug_flags() which removes the #ifdef and restores the
no-branch-overhead benefit of static key check when slub debugging is not
enabled.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
  mm/slub.c | 4 +---
  1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 61d0d2968413..28d78238f31e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2245,8 +2245,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
  		}
  	} else {
  		m = M_FULL;
-#ifdef CONFIG_SLUB_DEBUG
-		if ((s->flags & SLAB_STORE_USER) && !lock) {
+		if (kmem_cache_debug_flags(s, SLAB_STORE_USER) && !lock) {
  			lock = 1;
  			/*
  			 * This also ensures that the scanning of full
@@ -2255,7 +2254,6 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
  			 */
  			spin_lock(&n->list_lock);
  		}
-#endif
  	}

  	if (l != m) {
-- 
2.28.0

