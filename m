Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5590A2EC196
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbhAFQ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:57:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:41424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbhAFQ5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:57:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609952193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qiheZRBSRWkEQcLVqG0V1bcsRtJR6iOQZay+ZlhjKEE=;
        b=LZBfBMvJmZ/yHxVwMtszS1+EUlv4d13yCNd5iuDm00YQ+1mWh3zAwm4esKeBYgEeMoXuuo
        aMUh7vqmxG4k/b8iS5kR2ycMeTU5aM2IRvywtErIbcQiZSb8ywRaDdz6JbV8+Nnsh0nWeY
        jOxiBC0iEGr5bvqW6h/FBkpKO2B4anw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75553ACAF;
        Wed,  6 Jan 2021 16:56:33 +0000 (UTC)
Date:   Wed, 6 Jan 2021 17:56:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mm: hugetlb: fix a race between freeing and
 dissolving the page
Message-ID: <20210106165632.GT13207@dhcp22.suse.cz>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106084739.63318-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-01-21 16:47:36, Muchun Song wrote:
> There is a race condition between __free_huge_page()
> and dissolve_free_huge_page().
> 
> CPU0:                         CPU1:
> 
> // page_count(page) == 1
> put_page(page)
>   __free_huge_page(page)
>                               dissolve_free_huge_page(page)
>                                 spin_lock(&hugetlb_lock)
>                                 // PageHuge(page) && !page_count(page)
>                                 update_and_free_page(page)
>                                 // page is freed to the buddy
>                                 spin_unlock(&hugetlb_lock)
>     spin_lock(&hugetlb_lock)
>     clear_page_huge_active(page)
>     enqueue_huge_page(page)
>     // It is wrong, the page is already freed
>     spin_unlock(&hugetlb_lock)
> 
> The race windows is between put_page() and spin_lock() which
> is in the __free_huge_page().

The race window reall is between put_page and dissolve_free_huge_page.
And the result is that the put_page path would clobber an unrelated page
(either free or already reused page) which is quite serious.
Fortunatelly pages are dissolved very rarely. I believe that user would
require to be privileged to hit this by intention.

> We should make sure that the page is already on the free list
> when it is dissolved.

Another option would be to check for PageHuge in __free_huge_page. Have
you considered that rather than add yet another state? The scope of the
spinlock would have to be extended. If that sounds more tricky then can
we check the page->lru in the dissolve path? If the page is still
PageHuge and reference count 0 then there shouldn't be many options
where it can be queued, right?

> Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4741d60f8955..8ff138c17129 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -79,6 +79,21 @@ DEFINE_SPINLOCK(hugetlb_lock);
>  static int num_fault_mutexes;
>  struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
>  
> +static inline bool PageHugeFreed(struct page *head)
> +{
> +	return (unsigned long)head[3].mapping == -1U;
> +}
> +
> +static inline void SetPageHugeFreed(struct page *head)
> +{
> +	head[3].mapping = (void *)-1U;
> +}
> +
> +static inline void ClearPageHugeFreed(struct page *head)
> +{
> +	head[3].mapping = NULL;
> +}
> +
>  /* Forward declaration */
>  static int hugetlb_acct_memory(struct hstate *h, long delta);
>  
> @@ -1028,6 +1043,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>  	list_move(&page->lru, &h->hugepage_freelists[nid]);
>  	h->free_huge_pages++;
>  	h->free_huge_pages_node[nid]++;
> +	SetPageHugeFreed(page);
>  }
>  
>  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> @@ -1044,6 +1060,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>  
>  		list_move(&page->lru, &h->hugepage_activelist);
>  		set_page_refcounted(page);
> +		ClearPageHugeFreed(page);
>  		h->free_huge_pages--;
>  		h->free_huge_pages_node[nid]--;
>  		return page;
> @@ -1291,6 +1308,17 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>  						unsigned int order) { }
>  #endif
>  
> +/*
> + * Because we reuse the mapping field of some tail page structs, we should
> + * reset those mapping to initial value before @head is freed to the buddy
> + * allocator. The invalid value will be checked in the free_tail_pages_check().
> + */
> +static inline void reset_tail_page_mapping(struct hstate *h, struct page *head)
> +{
> +	if (!hstate_is_gigantic(h))
> +		head[3].mapping = TAIL_MAPPING;
> +}
> +
>  static void update_and_free_page(struct hstate *h, struct page *page)
>  {
>  	int i;
> @@ -1298,6 +1326,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		return;
>  
> +	reset_tail_page_mapping(h, page);
>  	h->nr_huge_pages--;
>  	h->nr_huge_pages_node[page_to_nid(page)]--;
>  	for (i = 0; i < pages_per_huge_page(h); i++) {
> @@ -1504,6 +1533,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  	spin_lock(&hugetlb_lock);
>  	h->nr_huge_pages++;
>  	h->nr_huge_pages_node[nid]++;
> +	ClearPageHugeFreed(page);
>  	spin_unlock(&hugetlb_lock);
>  }
>  
> @@ -1770,6 +1800,14 @@ int dissolve_free_huge_page(struct page *page)
>  		int nid = page_to_nid(head);
>  		if (h->free_huge_pages - h->resv_huge_pages == 0)
>  			goto out;
> +
> +		/*
> +		 * We should make sure that the page is already on the free list
> +		 * when it is dissolved.
> +		 */
> +		if (unlikely(!PageHugeFreed(head)))
> +			goto out;
> +
>  		/*
>  		 * Move PageHWPoison flag from head page to the raw error page,
>  		 * which makes any subpages rather than the error page reusable.
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
