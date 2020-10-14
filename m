Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD0528E261
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgJNOkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:40:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:52350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbgJNOkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:40:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602686409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=21+AmlKAqoD3h285kf5Hfc/y3SBsnMVewZg1V7YqvFA=;
        b=GKYRpWFNM+NS3l2VmYe1k2QYM7gKBX+1BgnyOfUgIbqejr/En6JncYKm8N6Hf5TQfdK2Ry
        Wm8Rb2HbO9p3E1vyRM1b4ZEsVRFPgP1TV7bTJvCc9se3v/vNVKsxSridsOgUTUCUwZLwsP
        TKHMQaHHkbj4XOh8YPkYQqKOgmRZVKs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C872BACE6;
        Wed, 14 Oct 2020 14:40:09 +0000 (UTC)
Date:   Wed, 14 Oct 2020 16:40:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com
Subject: Re: [PATCH v5 4/4] mm: convert page kmemcg type to a page memcg flag
Message-ID: <20201014144009.GG4440@dhcp22.suse.cz>
References: <20201002172559.4000748-1-guro@fb.com>
 <20201002172559.4000748-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002172559.4000748-5-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-10-20 10:25:59, Roman Gushchin wrote:
> PageKmemcg flag is currently defined as a page type (like buddy,
> offline, table and guard). Semantically it means that the page
> was accounted as a kernel memory by the page allocator and has
> to be uncharged on the release.
> 
> As a side effect of defining the flag as a page type, the accounted
> page can't be mapped to userspace (look at page_has_type() and
> comments above). In particular, this blocks the accounting of
> vmalloc-backed memory used by some bpf maps, because these maps
> do map the memory to userspace.
> 
> One option is to fix it by complicating the access to page->mapcount,
> which provides some free bits for page->page_type.
> 
> But it's way better to move this flag into page->memcg_data flags.
> Indeed, the flag makes no sense without enabled memory cgroups
> and memory cgroup pointer set in particular.

Completely agreed. Also this concept is already used for anon/ksm
which set flags on the same pointer as the object. Having that
outsourced to elsewhere is really harder to follow.

> This commit replaces PageKmemcg() and __SetPageKmemcg() with
> PageMemcgKmem() and an open-coded OR operation setting the memcg
> pointer with the MEMCG_DATA_KMEM bit. __ClearPageKmemcg() can be
> simple deleted, as the whole memcg_data is zeroed at once.
> 
> As a bonus, on !CONFIG_MEMCG build the PageMemcgKmem() check will
> be compiled out.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  cover.txt                  |  4 ++--
>  include/linux/memcontrol.h | 37 +++++++++++++++++++++++++++++++++----
>  include/linux/page-flags.h | 11 ++---------
>  mm/memcontrol.c            | 16 +++++-----------
>  mm/page_alloc.c            |  4 ++--
>  5 files changed, 44 insertions(+), 28 deletions(-)
> 
> diff --git a/cover.txt b/cover.txt
> index 32460cd3316e..cf23753cad15 100644
> --- a/cover.txt
> +++ b/cover.txt
> @@ -15,10 +15,10 @@ their memory can't be accounted because of this implementation detail.
>  
>  This patchset removes this limitation by moving the PageKmemcg flag
>  into one of the free bits of the page->mem_cgroup pointer. Also it
> -formalizes all accesses to the page->mem_cgroup and page->obj_cgroups
> +formalizes accesses to the page->mem_cgroup and page->obj_cgroups
>  using new helpers, adds several checks and removes a couple of obsolete
>  functions. As the result the code became more robust with fewer
> -open-coded bits tricks.
> +open-coded bit tricks.
>  
>  v5:
>    - added ~MEMCG_DATA_FLAGS_MASK to page_memcg_rcu(), by Michal
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 99a4841d658b..7c9d43476166 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -346,8 +346,10 @@ extern struct mem_cgroup *root_mem_cgroup;
>  enum page_memcg_data_flags {
>  	/* page->memcg_data is a pointer to an objcgs vector */
>  	MEMCG_DATA_OBJCGS = (1UL << 0),
> +	/* page has been accounted as a non-slab kernel page */
> +	MEMCG_DATA_KMEM = (1UL << 1),
>  	/* the next bit after the last actual flag */
> -	__NR_MEMCG_DATA_FLAGS  = (1UL << 1),
> +	__NR_MEMCG_DATA_FLAGS  = (1UL << 2),
>  };
>  
>  #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
> @@ -369,8 +371,12 @@ enum page_memcg_data_flags {
>   */
>  static inline struct mem_cgroup *page_memcg(struct page *page)
>  {
> +	unsigned long memcg_data = page->memcg_data;
> +
>  	VM_BUG_ON_PAGE(PageSlab(page), page);
> -	return (struct mem_cgroup *)page->memcg_data;
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> +
> +	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
>  /*
> @@ -387,7 +393,8 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
>  	VM_BUG_ON_PAGE(PageSlab(page), page);
>  	WARN_ON_ONCE(!rcu_read_lock_held());
>  
> -	return (struct mem_cgroup *)READ_ONCE(page->memcg_data);
> +	return (struct mem_cgroup *)(READ_ONCE(page->memcg_data) &
> +				     ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
>  /*
> @@ -416,7 +423,21 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
>  	if (memcg_data & MEMCG_DATA_OBJCGS)
>  		return NULL;
>  
> -	return (struct mem_cgroup *)memcg_data;
> +	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> +}
> +
> +/*
> + * PageMemcgKmem - check if the page has MemcgKmem flag set
> + * @page: a pointer to the page struct
> + *
> + * Checks if the page has MemcgKmem flag set. The caller must ensure that
> + * the page has an associated memory cgroup. It's not safe to call this function
> + * against some types of pages, e.g. slab pages.
> + */
> +static inline bool PageMemcgKmem(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(page->memcg_data & MEMCG_DATA_OBJCGS, page);
> +	return page->memcg_data & MEMCG_DATA_KMEM;
>  }
>  
>  #ifdef CONFIG_MEMCG_KMEM
> @@ -435,6 +456,7 @@ static inline struct obj_cgroup **page_objcgs(struct page *page)
>  	unsigned long memcg_data = READ_ONCE(page->memcg_data);
>  
>  	VM_BUG_ON_PAGE(memcg_data && !(memcg_data & MEMCG_DATA_OBJCGS), page);
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
>  
>  	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
> @@ -454,6 +476,8 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
>  	if (!memcg_data || !(memcg_data & MEMCG_DATA_OBJCGS))
>  		return NULL;
>  
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
> +
>  	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
> @@ -1109,6 +1133,11 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
>  	return NULL;
>  }
>  
> +static inline bool PageMemcgKmem(struct page *page)
> +{
> +	return false;
> +}
> +
>  static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
>  {
>  	return true;
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4f6ba9379112..fc0e1bd48e73 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -715,9 +715,8 @@ PAGEFLAG_FALSE(DoubleMap)
>  #define PAGE_MAPCOUNT_RESERVE	-128
>  #define PG_buddy	0x00000080
>  #define PG_offline	0x00000100
> -#define PG_kmemcg	0x00000200
> -#define PG_table	0x00000400
> -#define PG_guard	0x00000800
> +#define PG_table	0x00000200
> +#define PG_guard	0x00000400
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> @@ -768,12 +767,6 @@ PAGE_TYPE_OPS(Buddy, buddy)
>   */
>  PAGE_TYPE_OPS(Offline, offline)
>  
> -/*
> - * If kmemcg is enabled, the buddy allocator will set PageKmemcg() on
> - * pages allocated with __GFP_ACCOUNT. It gets cleared on page free.
> - */
> -PAGE_TYPE_OPS(Kmemcg, kmemcg)
> -
>  /*
>   * Marks pages in use as page tables.
>   */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a8eb20283dcd..e3fc240101ff 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3090,8 +3090,8 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>  	if (memcg && !mem_cgroup_is_root(memcg)) {
>  		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
>  		if (!ret) {
> -			page->memcg_data = (unsigned long)memcg;
> -			__SetPageKmemcg(page);
> +			page->memcg_data = (unsigned long)memcg |
> +				MEMCG_DATA_KMEM;
>  			return 0;
>  		}
>  		css_put(&memcg->css);
> @@ -3116,10 +3116,6 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>  	__memcg_kmem_uncharge(memcg, nr_pages);
>  	page->memcg_data = 0;
>  	css_put(&memcg->css);
> -
> -	/* slab pages do not have PageKmemcg flag set */
> -	if (PageKmemcg(page))
> -		__ClearPageKmemcg(page);
>  }
>  
>  static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> @@ -6863,12 +6859,10 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  	nr_pages = compound_nr(page);
>  	ug->nr_pages += nr_pages;
>  
> -	if (!PageKmemcg(page)) {
> -		ug->pgpgout++;
> -	} else {
> +	if (PageMemcgKmem(page))
>  		ug->nr_kmem += nr_pages;
> -		__ClearPageKmemcg(page);
> -	}
> +	else
> +		ug->pgpgout++;
>  
>  	ug->dummy_page = page;
>  	page->memcg_data = 0;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e9f0fe4a143e..5ebd50183d93 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1179,7 +1179,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  		 * Do not let hwpoison pages hit pcplists/buddy
>  		 * Untie memcg state and reset page's owner
>  		 */
> -		if (memcg_kmem_enabled() && PageKmemcg(page))
> +		if (memcg_kmem_enabled() && PageMemcgKmem(page))
>  			__memcg_kmem_uncharge_page(page, order);
>  		reset_page_owner(page, order);
>  		return false;
> @@ -1209,7 +1209,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  	}
>  	if (PageMappingFlags(page))
>  		page->mapping = NULL;
> -	if (memcg_kmem_enabled() && PageKmemcg(page))
> +	if (memcg_kmem_enabled() && PageMemcgKmem(page))
>  		__memcg_kmem_uncharge_page(page, order);
>  	if (check_free)
>  		bad += check_free_page(page);
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
