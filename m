Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D7B2DF43E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 07:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgLTGth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 01:49:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgLTGth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 01:49:37 -0500
Date:   Sun, 20 Dec 2020 08:48:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608446936;
        bh=sQOerph9MQe7AswiBUH8eKohhH26K3GuSudyYv4NLGo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCtSL4yhSW+77vw+65MLs+58vT5STuDSfQ1orn3Pp2Himzk4nPAxXjalyB4YNGo+r
         i183bMc7NOmgTVOuoHx8P8/0/1ydyOwvp3NawuzdOdo77bCrceiQGaCZXj+tfS8Xu/
         Ly35u71KGnqA9V8jnttIbVhRqzp1kWdzqzfwRLYkQlNWmFCICeduOY2/CuQL+F9CFv
         7rgy0UZ7wrH0jemOCkiqeaDOjAnuW3HWACVG9zIdL7bIJy4GmwcgJBY/ivBj8ZaRVv
         hHa+sn/Ixmzz/VLZmygYxmJAPTbFHS4lJrxDzEdqiEKVQ/tbbIMQjusNNwa4ihgE+V
         rbqQYmUud0Brw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] mm: cma: allocate cma areas bottom-up
Message-ID: <20201220064848.GA392325@kernel.org>
References: <20201217201214.3414100-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217201214.3414100-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 12:12:13PM -0800, Roman Gushchin wrote:
> Currently cma areas without a fixed base are allocated close to the
> end of the node. This placement is sub-optimal because of compaction:
> it brings pages into the cma area. In particular, it can bring in hot
> executable pages, even if there is a plenty of free memory on the
> machine. This results in cma allocation failures.
> 
> Instead let's place cma areas close to the beginning of a node.
> In this case the compaction will help to free cma areas, resulting
> in better cma allocation success rates.
> 
> If there is enough memory let's try to allocate bottom-up starting
> with 4GB to exclude any possible interference with DMA32. On smaller
> machines or in a case of a failure, stick with the old behavior.
> 
> 16GB vm, 2GB cma area:
> With this patch:
> [    0.000000] Command line: root=/dev/vda3 rootflags=subvol=/root systemd.unified_cgroup_hierarchy=1 enforcing=0 console=ttyS0,115200 hugetlb_cma=2G
> [    0.002928] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
> [    0.002930] cma: Reserved 2048 MiB at 0x0000000100000000
> [    0.002931] hugetlb_cma: reserved 2048 MiB on node 0
> 
> Without this patch:
> [    0.000000] Command line: root=/dev/vda3 rootflags=subvol=/root systemd.unified_cgroup_hierarchy=1 enforcing=0 console=ttyS0,115200 hugetlb_cma=2G
> [    0.002930] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
> [    0.002933] cma: Reserved 2048 MiB at 0x00000003c0000000
> [    0.002934] hugetlb_cma: reserved 2048 MiB on node 0
> 
> v2:
>   - switched to memblock_set_bottom_up(true), by Mike
>   - start with 4GB, by Mike
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

With one nit below 

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/cma.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 7f415d7cda9f..21fd40c092f0 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -337,6 +337,22 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
>  			limit = highmem_start;
>  		}
>  
> +		/*
> +		 * If there is enough memory, try a bottom-up allocation first.
> +		 * It will place the new cma area close to the start of the node
> +		 * and guarantee that the compaction is moving pages out of the
> +		 * cma area and not into it.
> +		 * Avoid using first 4GB to not interfere with constrained zones
> +		 * like DMA/DMA32.
> +		 */
> +		if (!memblock_bottom_up() &&
> +		    memblock_end >= SZ_4G + size) {

This seems short enough to fit a single line

> +			memblock_set_bottom_up(true);
> +			addr = memblock_alloc_range_nid(size, alignment, SZ_4G,
> +							limit, nid, true);
> +			memblock_set_bottom_up(false);
> +		}
> +
>  		if (!addr) {
>  			addr = memblock_alloc_range_nid(size, alignment, base,
>  					limit, nid, true);
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
