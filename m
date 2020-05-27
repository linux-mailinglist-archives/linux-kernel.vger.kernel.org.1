Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563CC1E490C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 18:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389093AbgE0QBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 12:01:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:44646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388982AbgE0QBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:01:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3FD0DAFD1;
        Wed, 27 May 2020 16:01:24 +0000 (UTC)
Subject: Re: [PATCH v4 12/19] mm: memcg/slab: use a single set of kmem_caches
 for all accounted allocations
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200526214227.989341-1-guro@fb.com>
 <20200526214227.989341-13-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9a7726c8-ac3c-df5c-7409-16e6be22a923@suse.cz>
Date:   Wed, 27 May 2020 18:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526214227.989341-13-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 11:42 PM, Roman Gushchin wrote:

> @@ -549,17 +503,14 @@ static __always_inline int charge_slab_page(struct page *page,
>  					    gfp_t gfp, int order,
>  					    struct kmem_cache *s)
>  {
> -#ifdef CONFIG_MEMCG_KMEM
>  	if (memcg_kmem_enabled() && !is_root_cache(s)) {
>  		int ret;
>  
>  		ret = memcg_alloc_page_obj_cgroups(page, s, gfp);
>  		if (ret)
>  			return ret;
> -
> -		percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
>  	}
> -#endif
> +
>  	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
>  			    PAGE_SIZE << order);
>  	return 0;
> @@ -568,12 +519,9 @@ static __always_inline int charge_slab_page(struct page *page,
>  static __always_inline void uncharge_slab_page(struct page *page, int order,
>  					       struct kmem_cache *s)
>  {
> -#ifdef CONFIG_MEMCG_KMEM
>  	if (memcg_kmem_enabled() && !is_root_cache(s)) {
>  		memcg_free_page_obj_cgroups(page);
> -		percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
> -	}

This now leaves the { bracket unterminated, breaking compilation.
