Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444DA2779AA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIXTqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgIXTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:46:42 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418F5C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:46:42 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b2so74390qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h1B6AjflFqLgN/RIntPXmsPv+ID5FkespJErWNJm324=;
        b=I+lgnmAzilo4jjY+1hs53HybW/NfUYzSYLnOY9uOVkDDxEntGCuFD+CzE5NC6T6i9F
         Hk/K2dLaXCnNEpIeb9VynLlBFsGcykGVDhY/QO2dHEVw7YlLuLTF90tMr1krUUWAoLJm
         vRiAnTAQeiCDplq6rj9D5+Idpq5eBsltxnxAPmII72cE0NO8jRpeXTUM945sHIrALGuv
         AFD2bD5eLY9VaxKk9Hs7b+rWHdNRSo+1aRi8bXOfp6BRgi+RkcIDrGnLgZUiW54MQcvl
         LSpwvjZM4W+AKd0VcBpbgwNNp3cJApAyRVI0lZlbSLogmdpty2OD4tfatQV1qsrDlyVA
         0XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1B6AjflFqLgN/RIntPXmsPv+ID5FkespJErWNJm324=;
        b=DbXSc5PQ5IPI7VjFzkVIsR7PhURE/cIWEIvPhi9n3sU2hYfJ43wT27vYlM2/wHjXBm
         CTRjh1P7456HZEqoeJcWWn2FP6cDmWKp3hTbfDXRf5ODizFPFtq6XBR4r8OF0xR6gHNv
         zrwVYphQV/OgSZvTK/GF24UfrfMJ8vkOVzynaZjwxSPM4mQa/F0ErzDwa32JRYTUX4Db
         brvyayb/RmDO6swjameOWPjIrdonO5e3V1linM+rUpPpxldweD8349pgz2oYz3iCmOkS
         s5JbYSG115S0YrOVuxziyhu8d/SwcVmqbOivTRy2wxqYHAsZdRM3Nhoha1Vlr0+0hUX9
         iKig==
X-Gm-Message-State: AOAM531YO8Dw76JSB7Ubu34kqxATzl5+v8QXQtWpSbfDhkcCaNnRuppm
        f2ys0UaBE5XwJIQkvNYNLFTUn8tMLKxL9w==
X-Google-Smtp-Source: ABdhPJxTxNPFnN8170Hyac0ArMNYRme+5tETBKsD/fBxW3wyWIFB/CrqXF0hbbVPp45XpwYl/MpKbg==
X-Received: by 2002:ac8:50c:: with SMTP id u12mr778768qtg.320.1600976801284;
        Thu, 24 Sep 2020 12:46:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4d7a])
        by smtp.gmail.com with ESMTPSA id i187sm322129qke.43.2020.09.24.12.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 12:46:40 -0700 (PDT)
Date:   Thu, 24 Sep 2020 15:45:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v1 1/4] mm: memcontrol: use helpers to access page's
 memcg data
Message-ID: <20200924194508.GA329853@cmpxchg.org>
References: <20200922203700.2879671-1-guro@fb.com>
 <20200922203700.2879671-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922203700.2879671-2-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 01:36:57PM -0700, Roman Gushchin wrote:
> Currently there are many open-coded reads and writes of the
> page->mem_cgroup pointer, as well as a couple of read helpers,
> which are barely used.
> 
> It creates an obstacle on a way to reuse some bits of the pointer
> for storing additional bits of information. In fact, we already do
> this for slab pages, where the last bit indicates that a pointer has
> an attached vector of objcg pointers instead of a regular memcg
> pointer.
> 
> This commits introduces 4 new helper functions and converts all
> raw accesses to page->mem_cgroup to calls of these helpers:
>   struct mem_cgroup *page_mem_cgroup(struct page *page);
>   struct mem_cgroup *page_mem_cgroup_check(struct page *page);
>   void set_page_mem_cgroup(struct page *page, struct mem_cgroup *memcg);
>   void clear_page_mem_cgroup(struct page *page);

Sounds reasonable to me!

> page_mem_cgroup_check() is intended to be used in cases when the page
> can be a slab page and have a memcg pointer pointing at objcg vector.
> It does check the lowest bit, and if set, returns NULL.
> page_mem_cgroup() contains a VM_BUG_ON_PAGE() check for the page not
> being a slab page. So do set_page_mem_cgroup() and clear_page_mem_cgroup().
> 
> To make sure nobody uses a direct access, struct page's
> mem_cgroup/obj_cgroups is converted to unsigned long memcg_data.
> Only new helpers and a couple of slab-accounting related functions
> access this field directly.
> 
> page_memcg() and page_memcg_rcu() helpers defined in mm.h are removed.
> New page_mem_cgroup() is a direct analog of page_memcg(), while
> page_memcg_rcu() has a single call site in a small rcu-read-lock
> section, so it's just not worth it to have a separate helper. So
> it's replaced with page_mem_cgroup() too.

page_memcg_rcu() does READ_ONCE(). We need to keep that for lockless
accesses.

> @@ -343,6 +343,72 @@ struct mem_cgroup {
>  
>  extern struct mem_cgroup *root_mem_cgroup;
>  
> +/*
> + * page_mem_cgroup - get the memory cgroup associated with a page
> + * @page: a pointer to the page struct
> + *
> + * Returns a pointer to the memory cgroup associated with the page,
> + * or NULL. This function assumes that the page is known to have a
> + * proper memory cgroup pointer. It's not safe to call this function
> + * against some type of pages, e.g. slab pages or ex-slab pages.
> + */
> +static inline struct mem_cgroup *page_mem_cgroup(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	return (struct mem_cgroup *)page->memcg_data;
> +}

This would also be a good place to mention what's required for the
function to be called safely, or in a way that produces a stable
result - i.e. the list of conditions in commit_charge().

> + * page_mem_cgroup_check - get the memory cgroup associated with a page
> + * @page: a pointer to the page struct
> + *
> + * Returns a pointer to the memory cgroup associated with the page,
> + * or NULL. This function unlike page_mem_cgroup() can take any  page
> + * as an argument. It has to be used in cases when it's not known if a page
> + * has an associated memory cgroup pointer or an object cgroups vector.
> + */
> +static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page)
> +{
> +	unsigned long memcg_data = page->memcg_data;
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

Here as well.

> +
> +/*
> + * set_page_mem_cgroup - associate a page with a memory cgroup
> + * @page: a pointer to the page struct
> + * @memcg: a pointer to the memory cgroup
> + *
> + * Associates a page with a memory cgroup.
> + */
> +static inline void set_page_mem_cgroup(struct page *page,
> +				       struct mem_cgroup *memcg)
> +{
> +	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	page->memcg_data = (unsigned long)memcg;
> +}
> +
> +/*
> + * clear_page_mem_cgroup - clear an association of a page with a memory cgroup
> + * @page: a pointer to the page struct
> + *
> + * Clears an association of a page with a memory cgroup.
> + */
> +static inline void clear_page_mem_cgroup(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	page->memcg_data = 0;
> +}
> +
>  static __always_inline bool memcg_stat_item_in_bytes(int idx)
>  {
>  	if (idx == MEMCG_PERCPU_B)
> @@ -743,15 +809,15 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
>  static inline void __mod_memcg_page_state(struct page *page,
>  					  int idx, int val)
>  {
> -	if (page->mem_cgroup)
> -		__mod_memcg_state(page->mem_cgroup, idx, val);
> +	if (page_mem_cgroup(page))
> +		__mod_memcg_state(page_mem_cgroup(page), idx, val);
>  }
>  
>  static inline void mod_memcg_page_state(struct page *page,
>  					int idx, int val)
>  {
> -	if (page->mem_cgroup)
> -		mod_memcg_state(page->mem_cgroup, idx, val);
> +	if (page_mem_cgroup(page))
> +		mod_memcg_state(page_mem_cgroup(page), idx, val);
>  }
>  
>  static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
> @@ -838,12 +904,12 @@ static inline void __mod_lruvec_page_state(struct page *page,
>  	struct lruvec *lruvec;
>  
>  	/* Untracked pages have no memcg, no lruvec. Update only the node */
> -	if (!head->mem_cgroup) {
> +	if (!page_mem_cgroup(head)) {
>  		__mod_node_page_state(pgdat, idx, val);
>  		return;
>  	}
>  
> -	lruvec = mem_cgroup_lruvec(head->mem_cgroup, pgdat);
> +	lruvec = mem_cgroup_lruvec(page_mem_cgroup(head), pgdat);
>  	__mod_lruvec_state(lruvec, idx, val);

The repetition of the function call is a bit jarring, especially in
configs with VM_BUG_ON() enabled (some distros use it for their beta
release kernels, so it's not just kernel developer test machines that
pay this cost). Can you please use a local variable when the function
needs the memcg more than once?

> @@ -878,8 +944,8 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
>  static inline void count_memcg_page_event(struct page *page,
>  					  enum vm_event_item idx)
>  {
> -	if (page->mem_cgroup)
> -		count_memcg_events(page->mem_cgroup, idx, 1);
> +	if (page_mem_cgroup(page))
> +		count_memcg_events(page_mem_cgroup(page), idx, 1);
>  }
>  
>  static inline void count_memcg_event_mm(struct mm_struct *mm,
> @@ -941,6 +1007,25 @@ void mem_cgroup_split_huge_fixup(struct page *head);
>  
>  struct mem_cgroup;
>  
> +static inline struct mem_cgroup *page_mem_cgroup(struct page *page)
> +{
> +	return NULL;
> +}
> +
> +static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page)
> +{
> +	return NULL;
> +}
> +
> +static inline void set_page_mem_cgroup(struct page *page,
> +				       struct mem_cgroup *memcg)
> +{
> +}
> +
> +static inline void clear_page_mem_cgroup(struct page *page)
> +{
> +}
> +
>  static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
>  {
>  	return true;
> @@ -1430,7 +1515,7 @@ static inline void mem_cgroup_track_foreign_dirty(struct page *page,
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	if (unlikely(&page->mem_cgroup->css != wb->memcg_css))
> +	if (unlikely(&page_mem_cgroup(page)->css != wb->memcg_css))
>  		mem_cgroup_track_foreign_dirty_slowpath(page, wb);
>  }
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 17e712207d74..5e24ff2ffec9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1476,28 +1476,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
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

You essentially renamed these existing helpers, but I don't think
that's justified. Especially with the proliferation of callsites, the
original names are nicer. I'd prefer we keep them.

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
> +	memcg = page_mem_cgroup_check(page);

This should actually have been using READ_ONCE() all along. Otherwise
the compiler can issue multiple loads to page->mem_cgroup here and you
can end up with a pointer with the lowest bit set leaking out.

> @@ -2928,17 +2918,6 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
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
> @@ -2956,8 +2935,14 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  		return NULL;
>  	}
>  
> -	/* All other pages use page->mem_cgroup */
> -	return page->mem_cgroup;
> +	/*
> +	 * page_mem_cgroup_check() is used here, because page_has_obj_cgroups()
> +	 * check above could fail because the object cgroups vector wasn't set
> +	 * at that moment, but it can be set concurrently.
> +	 * page_mem_cgroup_check(page) will guarantee tat a proper memory
> +	 * cgroup pointer or NULL will be returned.
> +	 */
> +	return page_mem_cgroup_check(page);

The code right now doesn't look quite safe. As per above, without the
READ_ONCE the compiler might issue multiple loads and we may get a
pointer with the low bit set.

Maybe slightly off-topic, but what are "all other pages" in general?
I don't see any callsites that ask for ownership on objects whose
backing pages may belong to a single memcg. That wouldn't seem to make
too much sense. Unless I'm missing something, this function should
probably tighten up its scope a bit and only work on stuff that is
actually following the obj_cgroup protocol.

I.e. either do the obj_cgroup lookup, or return root_mem_cgroup like
the other mem_cgroup_from_* functions.
