Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31441E1145
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 17:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391003AbgEYPHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 11:07:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:50720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgEYPHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:07:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4F542B187;
        Mon, 25 May 2020 15:07:25 +0000 (UTC)
Subject: Re: [PATCH v3 08/19] mm: memcg/slab: save obj_cgroup for non-root
 slab objects
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-9-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3e02b3c6-2bf5-bddb-d855-83a1a1a54034@suse.cz>
Date:   Mon, 25 May 2020 17:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-9-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:46 PM, Roman Gushchin wrote:
> Store the obj_cgroup pointer in the corresponding place of
> page->obj_cgroups for each allocated non-root slab object.
> Make sure that each allocated object holds a reference to obj_cgroup.
> 
> Objcg pointer is obtained from the memcg->objcg dereferencing
> in memcg_kmem_get_cache() and passed from pre_alloc_hook to
> post_alloc_hook. Then in case of successful allocation(s) it's
> getting stored in the page->obj_cgroups vector.
> 
> The objcg obtaining part look a bit bulky now, but it will be simplified
> by next commits in the series.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> diff --git a/mm/slab.h b/mm/slab.h
> index 44def57f050e..525e09e05743 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
...
> @@ -636,8 +684,8 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
>  					 s->flags, flags);
>  	}
>  
> -	if (memcg_kmem_enabled())
> -		memcg_kmem_put_cache(s);
> +	if (!is_root_cache(s))
> +		memcg_slab_post_alloc_hook(s, objcg, size, p);
>  }
>  
>  #ifndef CONFIG_SLOB

Keep also the memcg_kmem_enabled() static key check, like elsewhere?

