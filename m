Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2898E2D2743
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgLHJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:15:54 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59228 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgLHJPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:15:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UHyM8HH_1607418907;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UHyM8HH_1607418907)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Dec 2020 17:15:08 +0800
Subject: Re: [PATCH 11/11] mm: enlarge the "int nr_pages" parameter of
 update_lru_size()
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201207220949.830352-1-yuzhao@google.com>
 <20201207220949.830352-12-yuzhao@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <9b558a41-489f-c92f-4246-08472c45c678@linux.alibaba.com>
Date:   Tue, 8 Dec 2020 17:15:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201207220949.830352-12-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

在 2020/12/8 上午6:09, Yu Zhao 写道:
> update_lru_sizes() defines an unsigned long argument and passes it as
> nr_pages to update_lru_size(). Though this isn't causing any overflows
> I'm aware of, it's a bad idea to go through the demotion given that we
> have recently stumbled on a related type promotion problem fixed by
> commit 2da9f6305f30 ("mm/vmscan: fix NR_ISOLATED_FILE corruption on 64-bit")
> 
> Note that the underlying counters are already in long. This is another
> reason we shouldn't have the demotion.
> 
> This patch enlarges all relevant parameters on the path to the final
> underlying counters:
> 	update_lru_size(int -> long)
> 		if memcg:
> 			__mod_lruvec_state(int -> long)
> 				if smp:
> 					__mod_node_page_state(long)
> 				else:
> 					__mod_node_page_state(int -> long)
> 			__mod_memcg_lruvec_state(int -> long)
> 				__mod_memcg_state(int -> long)
> 		else:
> 			__mod_lruvec_state(int -> long)
> 				if smp:
> 					__mod_node_page_state(long)
> 				else:
> 					__mod_node_page_state(int -> long)
> 
> 		__mod_zone_page_state(long)
> 
> 		if memcg:
> 			mem_cgroup_update_lru_size(int -> long)
> 
> Note that __mod_node_page_state() for the smp case and
> __mod_zone_page_state() already use long. So this change also fixes
> the inconsistency.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/memcontrol.h | 10 +++++-----
>  include/linux/mm_inline.h  |  2 +-
>  include/linux/vmstat.h     |  6 +++---
>  mm/memcontrol.c            | 10 +++++-----
>  4 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 3febf64d1b80..1454201abb8d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -810,7 +810,7 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
>  int mem_cgroup_select_victim_node(struct mem_cgroup *memcg);
>  
>  void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
> -		int zid, int nr_pages);
> +		int zid, long nr_pages);
>  
>  static inline
>  unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
> @@ -896,7 +896,7 @@ static inline unsigned long memcg_page_state_local(struct mem_cgroup *memcg,
>  	return x;
>  }
>  
> -void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
> +void __mod_memcg_state(struct mem_cgroup *memcg, int idx, long val);
>  
>  /* idx can be of type enum memcg_stat_item or node_stat_item */
>  static inline void mod_memcg_state(struct mem_cgroup *memcg,
> @@ -948,7 +948,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  }
>  
>  void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> -			      int val);
> +			      long val);
>  void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
>  
>  static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
> @@ -1346,7 +1346,7 @@ static inline unsigned long memcg_page_state_local(struct mem_cgroup *memcg,
>  
>  static inline void __mod_memcg_state(struct mem_cgroup *memcg,
>  				     int idx,
> -				     int nr)
> +				     long nr)
>  {
>  }
>  
> @@ -1369,7 +1369,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  }
>  
>  static inline void __mod_memcg_lruvec_state(struct lruvec *lruvec,
> -					    enum node_stat_item idx, int val)
> +					    enum node_stat_item idx, long val)
>  {
>  }
>  
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 355ea1ee32bd..18e85071b44a 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -26,7 +26,7 @@ static inline int page_is_file_lru(struct page *page)
>  
>  static __always_inline void update_lru_size(struct lruvec *lruvec,
>  				enum lru_list lru, enum zone_type zid,
> -				int nr_pages)
> +				long nr_pages)
>  {
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 773135fc6e19..230922179ba0 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -310,7 +310,7 @@ static inline void __mod_zone_page_state(struct zone *zone,
>  }
>  
>  static inline void __mod_node_page_state(struct pglist_data *pgdat,
> -			enum node_stat_item item, int delta)
> +			enum node_stat_item item, long delta)
>  {
>  	if (vmstat_item_in_bytes(item)) {
>  		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
> @@ -453,7 +453,7 @@ static inline const char *vm_event_name(enum vm_event_item item)
>  #ifdef CONFIG_MEMCG
>  
>  void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> -			int val);
> +			long val);
>  
>  static inline void mod_lruvec_state(struct lruvec *lruvec,
>  				    enum node_stat_item idx, int val)
> @@ -481,7 +481,7 @@ static inline void mod_lruvec_page_state(struct page *page,
>  #else
>  
>  static inline void __mod_lruvec_state(struct lruvec *lruvec,
> -				      enum node_stat_item idx, int val)
> +				      enum node_stat_item idx, long val)
>  {
>  	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index de17f02d27ad..c3fe5880c42d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -758,7 +758,7 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>   * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
>   * @val: delta to add to the counter, can be negative
>   */
> -void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
> +void __mod_memcg_state(struct mem_cgroup *memcg, int idx, long val)
>  {
>  	long x, threshold = MEMCG_CHARGE_BATCH;
>  
> @@ -796,7 +796,7 @@ parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
>  }
>  
>  void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> -			      int val)
> +			      long val)
>  {
>  	struct mem_cgroup_per_node *pn;
>  	struct mem_cgroup *memcg;
> @@ -837,7 +837,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>   * change of state at this level: per-node, per-cgroup, per-lruvec.
>   */
>  void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> -			int val)
> +			long val)
>  {
>  	/* Update node */
>  	__mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
> @@ -1407,7 +1407,7 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
>   * so as to allow it to check that lru_size 0 is consistent with list_empty).
>   */
>  void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
> -				int zid, int nr_pages)
> +				int zid, long nr_pages)
>  {
>  	struct mem_cgroup_per_node *mz;
>  	unsigned long *lru_size;
> @@ -1424,7 +1424,7 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
>  
>  	size = *lru_size;
>  	if (WARN_ONCE(size < 0,
> -		"%s(%p, %d, %d): lru_size %ld\n",
> +		"%s(%p, %d, %ld): lru_size %ld\n",
>  		__func__, lruvec, lru, nr_pages, size)) {
>  		VM_BUG_ON(1);
>  		*lru_size = 0;
> 
