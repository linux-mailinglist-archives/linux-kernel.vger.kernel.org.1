Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2C92DB5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgLOViz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730910AbgLOVio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:38:44 -0500
Date:   Tue, 15 Dec 2020 23:36:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608068192;
        bh=WXJEAsSSv2rb8O0YZZ7a0XhkvqleMfeSyUDQxxsIO10=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzpPp3+mtdRO7vqF5bb36AKDWDPObTF5K8X337ScZa6uU9AOakWcs5rvi8qdoDp4D
         tFSb3bTotgN9ZWbtfPkTJoRvBizmlaGFLw8AOz9oT8pxG1y4jQ9s7NzFiOFa7wpYfB
         J3/DzTUeuHzHVa7xYf20EQyBnBQtEpgLikh3K6M06Uub5MCWMnWDCSjCMHjpS5HpHY
         Gh95QWNoZfSJQmGbG/7aXakMr1v6Wkr0YixupIWwJsIneR6KSfuMmP9kr/ePQjy3d8
         l0n7F9JyvUA8PK22d97LUyL3jgM/mvdsrQ9t6RRVUYDssuyNUPzx1XKj5J2/5EUqrk
         HkcKv8B6eBmMA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: cma: allocate cma areas bottom-up
Message-ID: <20201215213623.GB247200@kernel.org>
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
> up with DMA32. In this case the compaction will help to free cma
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

Why wouldn't you use memblock_set_bottom_up() around the allocations in
CMA, e.g.

	bool bottom_up = memblock_bottom_up();

	if (!bottom_up)
		memblock_set_bottom_up(true);

	/* allocate memory */

	memblock_set_bottom_up(bottom_up);

>   *
>   * Find @size free area aligned to @align in the specified range and node.
>   *
> @@ -289,7 +290,8 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,

-- 
Sincerely yours,
Mike.
