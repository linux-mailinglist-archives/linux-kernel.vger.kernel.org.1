Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA312DC2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgLPPHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:07:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgLPPHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:07:54 -0500
Date:   Wed, 16 Dec 2020 17:07:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608131233;
        bh=xliTWa2J49wFjY49UWNrhjPXBrUiiEG9NfEz4AwIe5A=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=dY695OXjtQakH1R2AadJyZb0whKFmoUWanuiJkxK0TsX/EpQwPVd4bf0FJTVO5puY
         6FpnRT38beeqQ6w5QMBNsAGQ0BLyPnX4+o3iHOL8jnNmZHlae8O3YaiXwVZ9t/g28P
         Jn0Q2bADh4sNt+0W6RKIV/e7T2z6Mxi/xBAYKN68pLg2Maf/Pr7dQQIYlmYDwlD4UZ
         kPHSgqr3qQK2vMvH04gQkQGXyjy/1l5+uUg45LPYkBR/8YGdybUj+arVK866yAjTy1
         J1rGyCYm4gwuP9wuw8TUkcyC24qVTjBcBgbNui7jfXHx1D1BNhs4PkfC2kCmFlFaX8
         VzKQ14rq0v/yA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: cma: allocate cma areas bottom-up
Message-ID: <20201216150704.GC247200@kernel.org>
References: <20201215193615.1867115-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215193615.1867115-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Tue, Dec 15, 2020 at 11:36:15AM -0800, Roman Gushchin wrote:
> Currently cma areas without a fixed base address are allocated
> close to the end of the node. This placement is sub-optimal because
> of how the compaction works: it effectively moves pages into
> the cma area. In particular, it often brings in hot executable pages,
> even if there is a plenty of free memory on the machine.
> This results in more cma allocation failures.
> 
> Instead let's place cma areas close to the beginning of a node.
> Cma first tries to start with highmem_start, so we shouldn't mess
> up with DMA32.

Sorry, I've missed this previously, but cma actually requires that
allocation will be below high_memory, so simply forcing memblock to
bottom_up mode will mess with DMA32. 

> In this case the compaction will help to free cma
> areas, resulting in better cma allocation success rates.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/memblock.h |  5 +++--
>  mm/cma.c                 |  4 ++--
>  mm/memblock.c            | 26 +++++++++++++++-----------
>  3 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 9c5cc95c7cee..698188066450 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -384,8 +384,9 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>  phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
>  				      phys_addr_t start, phys_addr_t end);
>  phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
> -				      phys_addr_t align, phys_addr_t start,
> -				      phys_addr_t end, int nid, bool exact_nid);
> +				     phys_addr_t align, phys_addr_t start,
> +				     phys_addr_t end, int nid, bool exact_nid,
> +				     bool bottom_up);
>  phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
>  
>  static inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
> diff --git a/mm/cma.c b/mm/cma.c
> index 20c4f6f40037..1b42be6d059b 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -332,13 +332,13 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
>  		 */
>  		if (base < highmem_start && limit > highmem_start) {
>  			addr = memblock_alloc_range_nid(size, alignment,
> -					highmem_start, limit, nid, true);
> +					highmem_start, limit, nid, true, true);
>  			limit = highmem_start;
>  		}
>  
>  		if (!addr) {
>  			addr = memblock_alloc_range_nid(size, alignment, base,
> -					limit, nid, true);
> +					limit, nid, true, true);
>  			if (!addr) {
>  				ret = -ENOMEM;
>  				goto err;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b8b7be0561c4..c334b401fe16 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -272,6 +272,7 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
>   *       %MEMBLOCK_ALLOC_ACCESSIBLE
>   * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
>   * @flags: pick from blocks based on memory attributes
> + * @bottom_up: force bottom-up allocation
>   *
>   * Find @size free area aligned to @align in the specified range and node.
>   *
> @@ -289,7 +290,8 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
>  static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
>  					phys_addr_t align, phys_addr_t start,
>  					phys_addr_t end, int nid,
> -					enum memblock_flags flags)
> +					enum memblock_flags flags,
> +					bool bottom_up)
>  {
>  	phys_addr_t kernel_end, ret;
>  
> @@ -305,9 +307,10 @@ static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
>  
>  	/*
>  	 * try bottom-up allocation only when bottom-up mode
> -	 * is set and @end is above the kernel image.
> +	 * is set and @end is above the kernel image or
> +	 * the bottom-up mode is enforced.
>  	 */
> -	if (memblock_bottom_up() && end > kernel_end) {
> +	if ((memblock_bottom_up() && end > kernel_end) || bottom_up) {
>  		phys_addr_t bottom_up_start;
>  
>  		/* make sure we will allocate above the kernel */
> @@ -359,7 +362,7 @@ phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
>  
>  again:
>  	ret = memblock_find_in_range_node(size, align, start, end,
> -					    NUMA_NO_NODE, flags);
> +					  NUMA_NO_NODE, flags, false);
>  
>  	if (!ret && (flags & MEMBLOCK_MIRROR)) {
>  		pr_warn("Could not allocate %pap bytes of mirrored memory\n",
> @@ -1331,6 +1334,7 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>   * @end: the upper bound of the memory region to allocate (phys address)
>   * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
>   * @exact_nid: control the allocation fall back to other nodes
> + * @bottom_up: force bottom-up allocation
>   *
>   * The allocation is performed from memory region limited by
>   * memblock.current_limit if @end == %MEMBLOCK_ALLOC_ACCESSIBLE.
> @@ -1351,7 +1355,7 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>  phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  					phys_addr_t align, phys_addr_t start,
>  					phys_addr_t end, int nid,
> -					bool exact_nid)
> +					bool exact_nid, bool bottom_up)
>  {
>  	enum memblock_flags flags = choose_memblock_flags();
>  	phys_addr_t found;
> @@ -1367,14 +1371,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  
>  again:
>  	found = memblock_find_in_range_node(size, align, start, end, nid,
> -					    flags);
> +					    flags, bottom_up);
>  	if (found && !memblock_reserve(found, size))
>  		goto done;
>  
>  	if (nid != NUMA_NO_NODE && !exact_nid) {
>  		found = memblock_find_in_range_node(size, align, start,
>  						    end, NUMA_NO_NODE,
> -						    flags);
> +						    flags, bottom_up);
>  		if (found && !memblock_reserve(found, size))
>  			goto done;
>  	}
> @@ -1423,7 +1427,7 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
>  		     __func__, (u64)size, (u64)align, &start, &end,
>  		     (void *)_RET_IP_);
>  	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE,
> -					false);
> +					false, false);
>  }
>  
>  /**
> @@ -1442,7 +1446,7 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
>  phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid)
>  {
>  	return memblock_alloc_range_nid(size, align, 0,
> -					MEMBLOCK_ALLOC_ACCESSIBLE, nid, false);
> +					MEMBLOCK_ALLOC_ACCESSIBLE, nid, false, false);
>  }
>  
>  /**
> @@ -1484,12 +1488,12 @@ static void * __init memblock_alloc_internal(
>  		max_addr = memblock.current_limit;
>  
>  	alloc = memblock_alloc_range_nid(size, align, min_addr, max_addr, nid,
> -					exact_nid);
> +					exact_nid, false);
>  
>  	/* retry allocation without lower limit */
>  	if (!alloc && min_addr)
>  		alloc = memblock_alloc_range_nid(size, align, 0, max_addr, nid,
> -						exact_nid);
> +						exact_nid, false);
>  
>  	if (!alloc)
>  		return NULL;
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
