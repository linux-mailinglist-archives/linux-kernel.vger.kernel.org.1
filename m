Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B707021EC66
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 11:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGNJNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 05:13:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:56228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgGNJNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:13:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1BAC0AAC7;
        Tue, 14 Jul 2020 09:13:17 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: hide nr_nodes in the internal of
 for_each_node_mask_to_[alloc|free]
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200714073404.84863-1-richard.weiyang@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <cd1651a0-35c6-7535-5782-ce7e31cc26e8@suse.cz>
Date:   Tue, 14 Jul 2020 11:13:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714073404.84863-1-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 9:34 AM, Wei Yang wrote:
> The second parameter of for_each_node_mask_to_[alloc|free] is a loop
> variant, which is not used outside of loop iteration.
> 
> Let's hide this.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 57ece74e3aae..9c3d15fb317e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1196,17 +1196,19 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>  	return nid;
>  }
>  
> -#define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)		\
> -	for (nr_nodes = nodes_weight(*mask);				\
> -		nr_nodes > 0 &&						\
> +#define for_each_node_mask_to_alloc(hs, node, mask)			\
> +	int __nr_nodes;							\
> +	for (__nr_nodes = nodes_weight(*mask);				\

The problem with this is that if I use the macro twice in the same block, this
will redefine __nr_nodes and fail to compile, no?
In that case it's better to avoid setting up this trap, IMHO.

> +		__nr_nodes > 0 &&					\
>  		((node = hstate_next_node_to_alloc(hs, mask)) || 1);	\
> -		nr_nodes--)
> +		__nr_nodes--)
>  
> -#define for_each_node_mask_to_free(hs, nr_nodes, node, mask)		\
> -	for (nr_nodes = nodes_weight(*mask);				\
> -		nr_nodes > 0 &&						\
> +#define for_each_node_mask_to_free(hs, node, mask)			\
> +	int __nr_nodes;							\
> +	for (__nr_nodes = nodes_weight(*mask);				\
> +		__nr_nodes > 0 &&					\
>  		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
> -		nr_nodes--)
> +		__nr_nodes--)
>  
>  #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>  static void destroy_compound_gigantic_page(struct page *page,
> @@ -1403,7 +1405,7 @@ static void __free_huge_page(struct page *page)
>  	 * reservation.  If the page was associated with a subpool, there
>  	 * would have been a page reserved in the subpool before allocation
>  	 * via hugepage_subpool_get_pages().  Since we are 'restoring' the
> -	 * reservtion, do not call hugepage_subpool_put_pages() as this will
> +	 * reservation, do not call hugepage_subpool_put_pages() as this will
>  	 * remove the reserved page from the subpool.
>  	 */
>  	if (!restore_reserve) {
> @@ -1760,10 +1762,10 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  				nodemask_t *node_alloc_noretry)
>  {
>  	struct page *page;
> -	int nr_nodes, node;
> +	int node;
>  	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>  
> -	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
> +	for_each_node_mask_to_alloc(h, node, nodes_allowed) {
>  		page = alloc_fresh_huge_page(h, gfp_mask, node, nodes_allowed,
>  						node_alloc_noretry);
>  		if (page)
> @@ -1787,10 +1789,10 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  							 bool acct_surplus)
>  {
> -	int nr_nodes, node;
> +	int node;
>  	int ret = 0;
>  
> -	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
> +	for_each_node_mask_to_free(h, node, nodes_allowed) {
>  		/*
>  		 * If we're returning unused surplus pages, only examine
>  		 * nodes with surplus pages.
> @@ -2481,9 +2483,9 @@ int alloc_bootmem_huge_page(struct hstate *h)
>  int __alloc_bootmem_huge_page(struct hstate *h)
>  {
>  	struct huge_bootmem_page *m;
> -	int nr_nodes, node;
> +	int node;
>  
> -	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
> +	for_each_node_mask_to_alloc(h, node, &node_states[N_MEMORY]) {
>  		void *addr;
>  
>  		addr = memblock_alloc_try_nid_raw(
> @@ -2662,17 +2664,17 @@ static inline void try_to_free_low(struct hstate *h, unsigned long count,
>  static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>  				int delta)
>  {
> -	int nr_nodes, node;
> +	int node;
>  
>  	VM_BUG_ON(delta != -1 && delta != 1);
>  
>  	if (delta < 0) {
> -		for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
> +		for_each_node_mask_to_alloc(h, node, nodes_allowed) {
>  			if (h->surplus_huge_pages_node[node])
>  				goto found;
>  		}
>  	} else {
> -		for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
> +		for_each_node_mask_to_free(h, node, nodes_allowed) {
>  			if (h->surplus_huge_pages_node[node] <
>  					h->nr_huge_pages_node[node])
>  				goto found;
> 

