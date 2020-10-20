Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C2628E24D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgJNOhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:37:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgJNOhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:37:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602686234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AyzNZ53ijqN7hh+gYgyYCLmitSjDLQdRAaqzXJ/z9/8=;
        b=Pr7WI1NH/HirkcO9sEj9mlPtdhYNb46DvaKtDtCwtwdhUL8j67ec8FafsLAxQ2MZg8mGsQ
        sgomlN3L+LIbK+PTddYMn3pwX2IjIAFeXltw1F0q6P3HS82Sn4EwNTKh59yy8ywvR/p2dU
        Kq1yZqR3emR2UDqf1fUSM0z5Vr4MGl0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49C9CACE6;
        Wed, 14 Oct 2020 14:37:14 +0000 (UTC)
Date:   Wed, 14 Oct 2020 16:37:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com
Subject: Re: [PATCH v5 1/4] mm: memcontrol: use helpers to read page's memcg
 data
Message-ID: <20201014143713.GE4440@dhcp22.suse.cz>
References: <20201002172559.4000748-1-guro@fb.com>
 <20201002172559.4000748-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002172559.4000748-2-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for being late.

On Fri 02-10-20 10:25:56, Roman Gushchin wrote:
> Currently there are many open-coded reads of the page->mem_cgroup
> pointer, as well as a couple of read helpers, which are barely used.
> 
> It creates an obstacle on a way to reuse some bits of the pointer
> for storing additional bits of information. In fact, we already do
> this for slab pages, where the last bit indicates that a pointer has
> an attached vector of objcg pointers instead of a regular memcg
> pointer.
> 
> This commits uses 2 existing helpers and introduces a new helper to
> converts all read sides to calls of these helpers:
>   struct mem_cgroup *page_memcg(struct page *page);
>   struct mem_cgroup *page_memcg_rcu(struct page *page);
>   struct mem_cgroup *page_memcg_check(struct page *page);
> 
> page_memcg_check() is intended to be used in cases when the page
> can be a slab page and have a memcg pointer pointing at objcg vector.
> It does check the lowest bit, and if set, returns NULL.
> page_memcg() contains a VM_BUG_ON_PAGE() check for the page not
> being a slab page.
> 
> To make sure nobody uses a direct access, struct page's
> mem_cgroup/obj_cgroups is converted to unsigned long memcg_data.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/buffer.c                      |   2 +-
>  fs/iomap/buffered-io.c           |   2 +-
>  include/linux/memcontrol.h       | 114 ++++++++++++++++++++++++++---
>  include/linux/mm.h               |  22 ------
>  include/linux/mm_types.h         |   5 +-
>  include/trace/events/writeback.h |   2 +-
>  kernel/fork.c                    |   7 +-
>  mm/debug.c                       |   4 +-
>  mm/huge_memory.c                 |   4 +-
>  mm/memcontrol.c                  | 121 ++++++++++++++-----------------
>  mm/page_alloc.c                  |   4 +-
>  mm/page_io.c                     |   6 +-
>  mm/slab.h                        |   9 +--
>  mm/workingset.c                  |   2 +-
>  14 files changed, 184 insertions(+), 120 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index bf4d8037f91b..64564ac7dcc5 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -657,7 +657,7 @@ int __set_page_dirty_buffers(struct page *page)
>  		} while (bh != head);
>  	}
>  	/*
> -	 * Lock out page->mem_cgroup migration to keep PageDirty
> +	 * Lock out page's memcg migration to keep PageDirty
>  	 * synchronized with per-memcg dirty page counters.
>  	 */
>  	lock_page_memcg(page);
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8180061b9e16..f96094a32851 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -650,7 +650,7 @@ iomap_set_page_dirty(struct page *page)
>  		return !TestSetPageDirty(page);
>  
>  	/*
> -	 * Lock out page->mem_cgroup migration to keep PageDirty
> +	 * Lock out page's memcg migration to keep PageDirty
>  	 * synchronized with per-memcg dirty page counters.
>  	 */
>  	lock_page_memcg(page);
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e391e3c56de5..f95c1433461c 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -343,6 +343,79 @@ struct mem_cgroup {
>  
>  extern struct mem_cgroup *root_mem_cgroup;
>  
> +/*
> + * page_memcg - get the memory cgroup associated with a page
> + * @page: a pointer to the page struct
> + *
> + * Returns a pointer to the memory cgroup associated with the page,
> + * or NULL. This function assumes that the page is known to have a
> + * proper memory cgroup pointer. It's not safe to call this function
> + * against some type of pages, e.g. slab pages or ex-slab pages.
> + *
> + * Any of the following ensures page and memcg binding stability:
> + * - the page lock
> + * - LRU isolation
> + * - lock_page_memcg()
> + * - exclusive reference
> + */
> +static inline struct mem_cgroup *page_memcg(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	return (struct mem_cgroup *)page->memcg_data;
> +}
> +
> +/*
> + * page_memcg_rcu - locklessly get the memory cgroup associated with a page
> + * @page: a pointer to the page struct
> + *
> + * Returns a pointer to the memory cgroup associated with the page,
> + * or NULL. This function assumes that the page is known to have a
> + * proper memory cgroup pointer. It's not safe to call this function
> + * against some type of pages, e.g. slab pages or ex-slab pages.
> + */
> +static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +
> +	return (struct mem_cgroup *)READ_ONCE(page->memcg_data);
> +}
> +
> +/*
> + * page_memcg_check - get the memory cgroup associated with a page
> + * @page: a pointer to the page struct
> + *
> + * Returns a pointer to the memory cgroup associated with the page,
> + * or NULL. This function unlike page_memcg() can take any  page
> + * as an argument. It has to be used in cases when it's not known if a page
> + * has an associated memory cgroup pointer or an object cgroups vector.
> + *
> + * Any of the following ensures page and memcg binding stability:
> + * - the page lock
> + * - LRU isolation
> + * - lock_page_memcg()
> + * - exclusive reference
> + */
> +static inline struct mem_cgroup *page_memcg_check(struct page *page)
> +{
> +	/*
> +	 * Because page->memcg_data might be changed asynchronously
> +	 * for slab pages, READ_ONCE() should be used here.
> +	 */
> +	unsigned long memcg_data = READ_ONCE(page->memcg_data);
> +
> +	/*
> +	 * The lowest bit set means that memcg isn't a valid
> +	 * memcg pointer, but a obj_cgroups pointer.
> +	 * In this case the page is shared and doesn't belong
> +	 * to any specific memory cgroup.
> +	 */
> +	if (memcg_data & 0x1UL)
> +		return NULL;
> +
> +	return (struct mem_cgroup *)memcg_data;
> +}
> +
>  static __always_inline bool memcg_stat_item_in_bytes(int idx)
>  {
>  	if (idx == MEMCG_PERCPU_B)
> @@ -743,15 +816,19 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
>  static inline void __mod_memcg_page_state(struct page *page,
>  					  int idx, int val)
>  {
> -	if (page->mem_cgroup)
> -		__mod_memcg_state(page->mem_cgroup, idx, val);
> +	struct mem_cgroup *memcg = page_memcg(page);
> +
> +	if (memcg)
> +		__mod_memcg_state(memcg, idx, val);
>  }
>  
>  static inline void mod_memcg_page_state(struct page *page,
>  					int idx, int val)
>  {
> -	if (page->mem_cgroup)
> -		mod_memcg_state(page->mem_cgroup, idx, val);
> +	struct mem_cgroup *memcg = page_memcg(page);
> +
> +	if (memcg)
> +		mod_memcg_state(memcg, idx, val);
>  }
>  
>  static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
> @@ -834,16 +911,17 @@ static inline void __mod_lruvec_page_state(struct page *page,
>  					   enum node_stat_item idx, int val)
>  {
>  	struct page *head = compound_head(page); /* rmap on tail pages */
> +	struct mem_cgroup *memcg = page_memcg(head);
>  	pg_data_t *pgdat = page_pgdat(page);
>  	struct lruvec *lruvec;
>  
>  	/* Untracked pages have no memcg, no lruvec. Update only the node */
> -	if (!head->mem_cgroup) {
> +	if (!memcg) {
>  		__mod_node_page_state(pgdat, idx, val);
>  		return;
>  	}
>  
> -	lruvec = mem_cgroup_lruvec(head->mem_cgroup, pgdat);
> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  	__mod_lruvec_state(lruvec, idx, val);
>  }
>  
> @@ -878,8 +956,10 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
>  static inline void count_memcg_page_event(struct page *page,
>  					  enum vm_event_item idx)
>  {
> -	if (page->mem_cgroup)
> -		count_memcg_events(page->mem_cgroup, idx, 1);
> +	struct mem_cgroup *memcg = page_memcg(page);
> +
> +	if (memcg)
> +		count_memcg_events(memcg, idx, 1);
>  }
>  
>  static inline void count_memcg_event_mm(struct mm_struct *mm,
> @@ -941,6 +1021,22 @@ void mem_cgroup_split_huge_fixup(struct page *head);
>  
>  struct mem_cgroup;
>  
> +static inline struct mem_cgroup *page_memcg(struct page *page)
> +{
> +	return NULL;
> +}
> +
> +static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
> +{
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +	return NULL;
> +}
> +
> +static inline struct mem_cgroup *page_memcg_check(struct page *page)
> +{
> +	return NULL;
> +}
> +
>  static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
>  {
>  	return true;
> @@ -1430,7 +1526,7 @@ static inline void mem_cgroup_track_foreign_dirty(struct page *page,
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	if (unlikely(&page->mem_cgroup->css != wb->memcg_css))
> +	if (unlikely(&page_memcg(page)->css != wb->memcg_css))
>  		mem_cgroup_track_foreign_dirty_slowpath(page, wb);
>  }
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27c64d0d7520..6707801b014d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1484,28 +1484,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
>  #endif
>  }
>  
> -#ifdef CONFIG_MEMCG
> -static inline struct mem_cgroup *page_memcg(struct page *page)
> -{
> -	return page->mem_cgroup;
> -}
> -static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
> -{
> -	WARN_ON_ONCE(!rcu_read_lock_held());
> -	return READ_ONCE(page->mem_cgroup);
> -}
> -#else
> -static inline struct mem_cgroup *page_memcg(struct page *page)
> -{
> -	return NULL;
> -}
> -static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
> -{
> -	WARN_ON_ONCE(!rcu_read_lock_held());
> -	return NULL;
> -}
> -#endif
> -
>  /*
>   * Some inline functions in vmstat.h depend on page_zone()
>   */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5a9238f6caad..80f5d755c037 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -199,10 +199,7 @@ struct page {
>  	atomic_t _refcount;
>  
>  #ifdef CONFIG_MEMCG
> -	union {
> -		struct mem_cgroup *mem_cgroup;
> -		struct obj_cgroup **obj_cgroups;
> -	};
> +	unsigned long memcg_data;
>  #endif
>  
>  	/*
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index e7cbccc7c14c..39a40dfb578a 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -257,7 +257,7 @@ TRACE_EVENT(track_foreign_dirty,
>  		__entry->ino		= inode ? inode->i_ino : 0;
>  		__entry->memcg_id	= wb->memcg_css->id;
>  		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
> -		__entry->page_cgroup_ino = cgroup_ino(page->mem_cgroup->css.cgroup);
> +		__entry->page_cgroup_ino = cgroup_ino(page_memcg(page)->css.cgroup);
>  	),
>  
>  	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%lu page_cgroup_ino=%lu",
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9be04e54de7f..74e5776f2cea 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -403,9 +403,10 @@ static int memcg_charge_kernel_stack(struct task_struct *tsk)
>  
>  		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
>  			/*
> -			 * If memcg_kmem_charge_page() fails, page->mem_cgroup
> -			 * pointer is NULL, and memcg_kmem_uncharge_page() in
> -			 * free_thread_stack() will ignore this page.
> +			 * If memcg_kmem_charge_page() fails, page's
> +			 * memory cgroup pointer is NULL, and
> +			 * memcg_kmem_uncharge_page() in free_thread_stack()
> +			 * will ignore this page.
>  			 */
>  			ret = memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL,
>  						     0);
> diff --git a/mm/debug.c b/mm/debug.c
> index ccca576b2899..8a40b3fefbeb 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -182,8 +182,8 @@ void __dump_page(struct page *page, const char *reason)
>  		pr_warn("page dumped because: %s\n", reason);
>  
>  #ifdef CONFIG_MEMCG
> -	if (!page_poisoned && page->mem_cgroup)
> -		pr_warn("page->mem_cgroup:%px\n", page->mem_cgroup);
> +	if (!page_poisoned && page->memcg_data)
> +		pr_warn("pages's memcg:%lx\n", page->memcg_data);
>  #endif
>  }
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index cba3812a5c3e..999f8a4dcb56 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -470,7 +470,7 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>  #ifdef CONFIG_MEMCG
>  static inline struct deferred_split *get_deferred_split_queue(struct page *page)
>  {
> -	struct mem_cgroup *memcg = compound_head(page)->mem_cgroup;
> +	struct mem_cgroup *memcg = page_memcg(compound_head(page));
>  	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
>  
>  	if (memcg)
> @@ -2766,7 +2766,7 @@ void deferred_split_huge_page(struct page *page)
>  {
>  	struct deferred_split *ds_queue = get_deferred_split_queue(page);
>  #ifdef CONFIG_MEMCG
> -	struct mem_cgroup *memcg = compound_head(page)->mem_cgroup;
> +	struct mem_cgroup *memcg = page_memcg(compound_head(page));
>  #endif
>  	unsigned long flags;
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 888cbc48311f..c2e6c75ed988 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -533,7 +533,7 @@ struct cgroup_subsys_state *mem_cgroup_css_from_page(struct page *page)
>  {
>  	struct mem_cgroup *memcg;
>  
> -	memcg = page->mem_cgroup;
> +	memcg = page_memcg(page);
>  
>  	if (!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		memcg = root_mem_cgroup;
> @@ -560,16 +560,7 @@ ino_t page_cgroup_ino(struct page *page)
>  	unsigned long ino = 0;
>  
>  	rcu_read_lock();
> -	memcg = page->mem_cgroup;
> -
> -	/*
> -	 * The lowest bit set means that memcg isn't a valid
> -	 * memcg pointer, but a obj_cgroups pointer.
> -	 * In this case the page is shared and doesn't belong
> -	 * to any specific memory cgroup.
> -	 */
> -	if ((unsigned long) memcg & 0x1UL)
> -		memcg = NULL;
> +	memcg = page_memcg_check(page);
>  
>  	while (memcg && !(memcg->css.flags & CSS_ONLINE))
>  		memcg = parent_mem_cgroup(memcg);
> @@ -1050,7 +1041,7 @@ EXPORT_SYMBOL(get_mem_cgroup_from_mm);
>   */
>  struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
>  {
> -	struct mem_cgroup *memcg = page->mem_cgroup;
> +	struct mem_cgroup *memcg = page_memcg(page);
>  
>  	if (mem_cgroup_disabled())
>  		return NULL;
> @@ -1349,7 +1340,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>  		goto out;
>  	}
>  
> -	memcg = page->mem_cgroup;
> +	memcg = page_memcg(page);
>  	/*
>  	 * Swapcache readahead pages are added to the LRU - and
>  	 * possibly migrated - before they are charged.
> @@ -2109,7 +2100,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
>  }
>  
>  /**
> - * lock_page_memcg - lock a page->mem_cgroup binding
> + * lock_page_memcg - lock a page and memcg binding
>   * @page: the page
>   *
>   * This function protects unlocked LRU pages from being moved to
> @@ -2141,7 +2132,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
>  	if (mem_cgroup_disabled())
>  		return NULL;
>  again:
> -	memcg = head->mem_cgroup;
> +	memcg = page_memcg(head);
>  	if (unlikely(!memcg))
>  		return NULL;
>  
> @@ -2149,7 +2140,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
>  		return memcg;
>  
>  	spin_lock_irqsave(&memcg->move_lock, flags);
> -	if (memcg != head->mem_cgroup) {
> +	if (memcg != page_memcg(head)) {
>  		spin_unlock_irqrestore(&memcg->move_lock, flags);
>  		goto again;
>  	}
> @@ -2187,14 +2178,14 @@ void __unlock_page_memcg(struct mem_cgroup *memcg)
>  }
>  
>  /**
> - * unlock_page_memcg - unlock a page->mem_cgroup binding
> + * unlock_page_memcg - unlock a page and memcg binding
>   * @page: the page
>   */
>  void unlock_page_memcg(struct page *page)
>  {
>  	struct page *head = compound_head(page);
>  
> -	__unlock_page_memcg(head->mem_cgroup);
> +	__unlock_page_memcg(page_memcg(head));
>  }
>  EXPORT_SYMBOL(unlock_page_memcg);
>  
> @@ -2884,7 +2875,7 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>  
>  static void commit_charge(struct page *page, struct mem_cgroup *memcg)
>  {
> -	VM_BUG_ON_PAGE(page->mem_cgroup, page);
> +	VM_BUG_ON_PAGE(page_memcg(page), page);
>  	/*
>  	 * Any of the following ensures page->mem_cgroup stability:
>  	 *
> @@ -2893,7 +2884,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
>  	 * - lock_page_memcg()
>  	 * - exclusive reference
>  	 */
> -	page->mem_cgroup = memcg;
> +	page->memcg_data = (unsigned long)memcg;
>  }
>  
>  #ifdef CONFIG_MEMCG_KMEM
> @@ -2908,8 +2899,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>  	if (!vec)
>  		return -ENOMEM;
>  
> -	if (cmpxchg(&page->obj_cgroups, NULL,
> -		    (struct obj_cgroup **) ((unsigned long)vec | 0x1UL)))
> +	if (cmpxchg(&page->memcg_data, 0, (unsigned long)vec | 0x1UL))
>  		kfree(vec);
>  	else
>  		kmemleak_not_leak(vec);
> @@ -2920,6 +2910,12 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>  /*
>   * Returns a pointer to the memory cgroup to which the kernel object is charged.
>   *
> + * A passed kernel object can be a slab object or a generic kernel page, so
> + * different mechanisms for getting the memory cgroup pointer should be used.
> + * In certain cases (e.g. kernel stacks or large kmallocs with SLUB) the caller
> + * can not know for sure how the kernel object is implemented.
> + * mem_cgroup_from_obj() can be safely used in such cases.
> + *
>   * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
>   * cgroup_mutex, etc.
>   */
> @@ -2932,17 +2928,6 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  
>  	page = virt_to_head_page(p);
>  
> -	/*
> -	 * If page->mem_cgroup is set, it's either a simple mem_cgroup pointer
> -	 * or a pointer to obj_cgroup vector. In the latter case the lowest
> -	 * bit of the pointer is set.
> -	 * The page->mem_cgroup pointer can be asynchronously changed
> -	 * from NULL to (obj_cgroup_vec | 0x1UL), but can't be changed
> -	 * from a valid memcg pointer to objcg vector or back.
> -	 */
> -	if (!page->mem_cgroup)
> -		return NULL;
> -
>  	/*
>  	 * Slab objects are accounted individually, not per-page.
>  	 * Memcg membership data for each individual object is saved in
> @@ -2960,8 +2945,14 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  		return NULL;
>  	}
>  
> -	/* All other pages use page->mem_cgroup */
> -	return page->mem_cgroup;
> +	/*
> +	 * page_memcg_check() is used here, because page_has_obj_cgroups()
> +	 * check above could fail because the object cgroups vector wasn't set
> +	 * at that moment, but it can be set concurrently.
> +	 * page_memcg_check(page) will guarantee that a proper memory
> +	 * cgroup pointer or NULL will be returned.
> +	 */
> +	return page_memcg_check(page);
>  }
>  
>  __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> @@ -3099,7 +3090,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>  	if (memcg && !mem_cgroup_is_root(memcg)) {
>  		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
>  		if (!ret) {
> -			page->mem_cgroup = memcg;
> +			page->memcg_data = (unsigned long)memcg;
>  			__SetPageKmemcg(page);
>  			return 0;
>  		}
> @@ -3115,7 +3106,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>   */
>  void __memcg_kmem_uncharge_page(struct page *page, int order)
>  {
> -	struct mem_cgroup *memcg = page->mem_cgroup;
> +	struct mem_cgroup *memcg = page_memcg(page);
>  	unsigned int nr_pages = 1 << order;
>  
>  	if (!memcg)
> @@ -3123,7 +3114,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>  
>  	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
>  	__memcg_kmem_uncharge(memcg, nr_pages);
> -	page->mem_cgroup = NULL;
> +	page->memcg_data = 0;
>  	css_put(&memcg->css);
>  
>  	/* slab pages do not have PageKmemcg flag set */
> @@ -3274,7 +3265,7 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>   */
>  void mem_cgroup_split_huge_fixup(struct page *head)
>  {
> -	struct mem_cgroup *memcg = head->mem_cgroup;
> +	struct mem_cgroup *memcg = page_memcg(head);
>  	int i;
>  
>  	if (mem_cgroup_disabled())
> @@ -3282,7 +3273,7 @@ void mem_cgroup_split_huge_fixup(struct page *head)
>  
>  	for (i = 1; i < HPAGE_PMD_NR; i++) {
>  		css_get(&memcg->css);
> -		head[i].mem_cgroup = memcg;
> +		head[i].memcg_data = (unsigned long)memcg;
>  	}
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> @@ -4658,7 +4649,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>  void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
>  					     struct bdi_writeback *wb)
>  {
> -	struct mem_cgroup *memcg = page->mem_cgroup;
> +	struct mem_cgroup *memcg = page_memcg(page);
>  	struct memcg_cgwb_frn *frn;
>  	u64 now = get_jiffies_64();
>  	u64 oldest_at = now;
> @@ -5627,14 +5618,14 @@ static int mem_cgroup_move_account(struct page *page,
>  
>  	/*
>  	 * Prevent mem_cgroup_migrate() from looking at
> -	 * page->mem_cgroup of its source page while we change it.
> +	 * page's memory cgroup of its source page while we change it.
>  	 */
>  	ret = -EBUSY;
>  	if (!trylock_page(page))
>  		goto out;
>  
>  	ret = -EINVAL;
> -	if (page->mem_cgroup != from)
> +	if (page_memcg(page) != from)
>  		goto out_unlock;
>  
>  	pgdat = page_pgdat(page);
> @@ -5689,13 +5680,13 @@ static int mem_cgroup_move_account(struct page *page,
>  	/*
>  	 * All state has been migrated, let's switch to the new memcg.
>  	 *
> -	 * It is safe to change page->mem_cgroup here because the page
> +	 * It is safe to change page's memcg here because the page
>  	 * is referenced, charged, isolated, and locked: we can't race
>  	 * with (un)charging, migration, LRU putback, or anything else
> -	 * that would rely on a stable page->mem_cgroup.
> +	 * that would rely on a stable page's memory cgroup.
>  	 *
>  	 * Note that lock_page_memcg is a memcg lock, not a page lock,
> -	 * to save space. As soon as we switch page->mem_cgroup to a
> +	 * to save space. As soon as we switch page's memory cgroup to a
>  	 * new memcg that isn't locked, the above state can change
>  	 * concurrently again. Make sure we're truly done with it.
>  	 */
> @@ -5704,7 +5695,7 @@ static int mem_cgroup_move_account(struct page *page,
>  	css_get(&to->css);
>  	css_put(&from->css);
>  
> -	page->mem_cgroup = to;
> +	page->memcg_data = (unsigned long)to;
>  
>  	__unlock_page_memcg(from);
>  
> @@ -5770,7 +5761,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
>  		 * mem_cgroup_move_account() checks the page is valid or
>  		 * not under LRU exclusion.
>  		 */
> -		if (page->mem_cgroup == mc.from) {
> +		if (page_memcg(page) == mc.from) {
>  			ret = MC_TARGET_PAGE;
>  			if (is_device_private_page(page))
>  				ret = MC_TARGET_DEVICE;
> @@ -5814,7 +5805,7 @@ static enum mc_target_type get_mctgt_type_thp(struct vm_area_struct *vma,
>  	VM_BUG_ON_PAGE(!page || !PageHead(page), page);
>  	if (!(mc.flags & MOVE_ANON))
>  		return ret;
> -	if (page->mem_cgroup == mc.from) {
> +	if (page_memcg(page) == mc.from) {
>  		ret = MC_TARGET_PAGE;
>  		if (target) {
>  			get_page(page);
> @@ -6760,12 +6751,12 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
>  		/*
>  		 * Every swap fault against a single page tries to charge the
>  		 * page, bail as early as possible.  shmem_unuse() encounters
> -		 * already charged pages, too.  page->mem_cgroup is protected
> -		 * by the page lock, which serializes swap cache removal, which
> -		 * in turn serializes uncharging.
> +		 * already charged pages, too.  page and memcg binding is
> +		 * protected by the page lock, which serializes swap cache
> +		 * removal, which in turn serializes uncharging.
>  		 */
>  		VM_BUG_ON_PAGE(!PageLocked(page), page);
> -		if (compound_head(page)->mem_cgroup)
> +		if (page_memcg(compound_head(page)))
>  			goto out;
>  
>  		id = lookup_swap_cgroup_id(ent);
> @@ -6849,21 +6840,21 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  
> -	if (!page->mem_cgroup)
> +	if (!page_memcg(page))
>  		return;
>  
>  	/*
>  	 * Nobody should be changing or seriously looking at
> -	 * page->mem_cgroup at this point, we have fully
> +	 * page_memcg(page) at this point, we have fully
>  	 * exclusive access to the page.
>  	 */
>  
> -	if (ug->memcg != page->mem_cgroup) {
> +	if (ug->memcg != page_memcg(page)) {
>  		if (ug->memcg) {
>  			uncharge_batch(ug);
>  			uncharge_gather_clear(ug);
>  		}
> -		ug->memcg = page->mem_cgroup;
> +		ug->memcg = page_memcg(page);
>  
>  		/* pairs with css_put in uncharge_batch */
>  		css_get(&ug->memcg->css);
> @@ -6880,7 +6871,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  	}
>  
>  	ug->dummy_page = page;
> -	page->mem_cgroup = NULL;
> +	page->memcg_data = 0;
>  	css_put(&ug->memcg->css);
>  }
>  
> @@ -6923,7 +6914,7 @@ void mem_cgroup_uncharge(struct page *page)
>  		return;
>  
>  	/* Don't touch page->lru of any random page, pre-check: */
> -	if (!page->mem_cgroup)
> +	if (!page_memcg(page))
>  		return;
>  
>  	uncharge_gather_clear(&ug);
> @@ -6973,11 +6964,11 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>  		return;
>  
>  	/* Page cache replacement: new page already charged? */
> -	if (newpage->mem_cgroup)
> +	if (page_memcg(newpage))
>  		return;
>  
>  	/* Swapcache readahead pages can get replaced before being charged */
> -	memcg = oldpage->mem_cgroup;
> +	memcg = page_memcg(oldpage);
>  	if (!memcg)
>  		return;
>  
> @@ -7172,7 +7163,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return;
>  
> -	memcg = page->mem_cgroup;
> +	memcg = page_memcg(page);
>  
>  	/* Readahead page, never charged */
>  	if (!memcg)
> @@ -7193,7 +7184,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	VM_BUG_ON_PAGE(oldid, page);
>  	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
>  
> -	page->mem_cgroup = NULL;
> +	page->memcg_data = 0;
>  
>  	if (!mem_cgroup_is_root(memcg))
>  		page_counter_uncharge(&memcg->memory, nr_entries);
> @@ -7236,7 +7227,7 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return 0;
>  
> -	memcg = page->mem_cgroup;
> +	memcg = page_memcg(page);
>  
>  	/* Readahead page, never charged */
>  	if (!memcg)
> @@ -7317,7 +7308,7 @@ bool mem_cgroup_swap_full(struct page *page)
>  	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return false;
>  
> -	memcg = page->mem_cgroup;
> +	memcg = page_memcg(page);
>  	if (!memcg)
>  		return false;
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eb0962976a0e..e9f0fe4a143e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1057,7 +1057,7 @@ static inline bool page_expected_state(struct page *page,
>  	if (unlikely((unsigned long)page->mapping |
>  			page_ref_count(page) |
>  #ifdef CONFIG_MEMCG
> -			(unsigned long)page->mem_cgroup |
> +			(unsigned long)page_memcg(page) |
>  #endif
>  			(page->flags & check_flags)))
>  		return false;
> @@ -1082,7 +1082,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>  			bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
>  	}
>  #ifdef CONFIG_MEMCG
> -	if (unlikely(page->mem_cgroup))
> +	if (unlikely(page_memcg(page)))
>  		bad_reason = "page still charged to cgroup";
>  #endif
>  	return bad_reason;
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 433df1263349..9bca17ecc4df 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -291,12 +291,14 @@ static inline void count_swpout_vm_event(struct page *page)
>  static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
>  {
>  	struct cgroup_subsys_state *css;
> +	struct mem_cgroup *memcg;
>  
> -	if (!page->mem_cgroup)
> +	memcg = page_memcg(page);
> +	if (!memcg)
>  		return;
>  
>  	rcu_read_lock();
> -	css = cgroup_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
> +	css = cgroup_e_css(memcg->css.cgroup, &io_cgrp_subsys);
>  	bio_associate_blkg_from_css(bio, css);
>  	rcu_read_unlock();
>  }
> diff --git a/mm/slab.h b/mm/slab.h
> index 4a24e1702923..5ac89260f329 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -242,18 +242,17 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
>  static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
>  {
>  	/*
> -	 * page->mem_cgroup and page->obj_cgroups are sharing the same
> +	 * Page's memory cgroup and obj_cgroups vector are sharing the same
>  	 * space. To distinguish between them in case we don't know for sure
>  	 * that the page is a slab page (e.g. page_cgroup_ino()), let's
>  	 * always set the lowest bit of obj_cgroups.
>  	 */
> -	return (struct obj_cgroup **)
> -		((unsigned long)page->obj_cgroups & ~0x1UL);
> +	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
>  }
>  
>  static inline bool page_has_obj_cgroups(struct page *page)
>  {
> -	return ((unsigned long)page->obj_cgroups & 0x1UL);
> +	return page->memcg_data & 0x1UL;
>  }
>  
>  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
> @@ -262,7 +261,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>  static inline void memcg_free_page_obj_cgroups(struct page *page)
>  {
>  	kfree(page_obj_cgroups(page));
> -	page->obj_cgroups = NULL;
> +	page->memcg_data = 0;
>  }
>  
>  static inline size_t obj_full_size(struct kmem_cache *s)
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 8ed8e6296d8c..ef563f94a0e3 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -257,7 +257,7 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
>  	struct lruvec *lruvec;
>  	int memcgid;
>  
> -	/* Page is fully exclusive and pins page->mem_cgroup */
> +	/* Page is fully exclusive and pins page's memory cgroup pointer */
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  	VM_BUG_ON_PAGE(page_count(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
