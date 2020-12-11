Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3319F2D8154
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406661AbgLKVy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:54:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38974 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392950AbgLKVye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:54:34 -0500
Received: from [IPv6:2a00:5f00:102:0:58fa:14ff:fe5e:9be7] (unknown [IPv6:2a00:5f00:102:0:58fa:14ff:fe5e:9be7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EB78F1F46195;
        Fri, 11 Dec 2020 21:53:48 +0000 (GMT)
Subject: Re: kernelci/staging-next bisection: sleep.login on
 rk3288-rock2-square #2286-staging
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernelci-results-staging@groups.io,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
References: <5fd3e5d9.1c69fb81.f9e69.5028@mx.google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <127999c4-7d56-0c36-7f88-8e1a5c934cae@collabora.com>
Date:   Fri, 11 Dec 2020 21:53:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <5fd3e5d9.1c69fb81.f9e69.5028@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Please see the bisection report below about a boot failure on
rk3288 with next-20201210.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

There's nothing in the serial console log, probably because it's
crashing too early during boot.  This was confirmed on two rk3288
platforms on kernelci.org: rk3288-veyron-jaq and
rk3288-rock2-square.  There's no clear sign about other platforms
being impacted.

If this looks like something you want to investigate but you
don't have a platform at hand to reproduce it, please let us know
if you would like the test to be re-run on kernelci.org with some
debug config turned on, or if you have a fix to try.

Thanks,
Guillaume

On 11/12/2020 21:34, staging.kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> kernelci/staging-next bisection: sleep.login on rk3288-rock2-square #2286-staging
> 
> Summary:
>   Start:      7f507faf2d85 staging-next-20201211.0

This is really next-20201210...  The revision shown here is just
an artifact of staging.kernelci.org which creates its own tags.

>   Plain log:  https://storage.staging.kernelci.org/kernelci/staging-next/staging-next-20201211.0/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square.txt
>   HTML log:   https://storage.staging.kernelci.org/kernelci/staging-next/staging-next-20201211.0/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square.html
>   Result:     950c37691925 mm: memblock: enforce overlap of memory.memblock and memory.reserved
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       kernelci
>   URL:        https://github.com/kernelci/linux.git
>   Branch:     staging-next
>   Target:     rk3288-rock2-square
>   CPU arch:   arm
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     multi_v7_defconfig
>   Test case:  sleep.login
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 950c3769192512118a87432dd42e71c5241dbd10
> Author: Mike Rapoport <rppt@linux.ibm.com>
> Date:   Thu Dec 10 15:40:51 2020 +1100
> 
>     mm: memblock: enforce overlap of memory.memblock and memory.reserved
>     
>     Patch series "mm: fix initialization of struct page for holes in  memory layout", v2.
>     
>     Commit 73a6e474cb37 ("mm: memmap_init: iterate over memblock regions
>     rather that check each PFN") exposed several issues with the memory map
>     initialization and these patches fix those issues.
>     
>     Initially there were crashes during compaction that Qian Cai reported back
>     in April [1].  It seemed back then that the probelm was fixed, but a few
>     weeks ago Andrea Arcangeli hit the same bug [2] and after a long
>     discussion between us [3] I think these patches are the proper fix.
>     
>     [1] https://lore.kernel.org/lkml/8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw
>     [2] https://lore.kernel.org/lkml/20201121194506.13464-1-aarcange@redhat.com
>     [3] https://lore.kernel.org/mm-commits/20201206005401.qKuAVgOXr%akpm@linux-foundation.org
>     
>     This patch (of 2):
>     
>     memblock does not require that the reserved memory ranges will be a subset
>     of memblock.memory.
>     
>     As a result there may be reserved pages that are not in the range of any
>     zone or node because zone and node boundaries are detected based on
>     memblock.memory and pages that only present in memblock.reserved are not
>     taken into account during zone/node size detection.
>     
>     Make sure that all ranges in memblock.reserved are added to
>     memblock.memory before calculating node and zone boundaries.
>     
>     Link: https://lkml.kernel.org/r/20201209214304.6812-1-rppt@kernel.org
>     Link: https://lkml.kernel.org/r/20201209214304.6812-2-rppt@kernel.org
>     Fixes: 73a6e474cb37 ("mm: memmap_init: iterate over memblock regions rather that check each PFN")
>     Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>     Reported-by: Andrea Arcangeli <aarcange@redhat.com>
>     Cc: Baoquan He <bhe@redhat.com>
>     Cc: David Hildenbrand <david@redhat.com>
>     Cc: Mel Gorman <mgorman@suse.de>
>     Cc: Michal Hocko <mhocko@kernel.org>
>     Cc: Qian Cai <cai@lca.pw>
>     Cc: Vlastimil Babka <vbabka@suse.cz>
>     Cc: <stable@vger.kernel.org>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index ef131255cedc..e64dae2dd1ce 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -120,6 +120,7 @@ int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
>  unsigned long memblock_free_all(void);
>  void reset_node_managed_pages(pg_data_t *pgdat);
>  void reset_all_zones_managed_pages(void);
> +void memblock_enforce_memory_reserved_overlap(void);
>  
>  /* Low level functions */
>  void __next_mem_range(u64 *idx, int nid, enum memblock_flags flags,
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 049df4163a97..18432bc166f6 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1857,6 +1857,30 @@ void __init_memblock memblock_trim_memory(phys_addr_t align)
>  	}
>  }
>  
> +/**
> + * memblock_enforce_memory_reserved_overlap - make sure every range in
> + * @memblock.reserved is covered by @memblock.memory
> + *
> + * The data in @memblock.memory is used to detect zone and node boundaries
> + * during initialization of the memory map and the page allocator. Make
> + * sure that every memory range present in @memblock.reserved is also added
> + * to @memblock.memory even if the architecture specific memory
> + * initialization failed to do so
> + */
> +void __init memblock_enforce_memory_reserved_overlap(void)
> +{
> +	phys_addr_t start, end;
> +	int nid;
> +	u64 i;
> +
> +	__for_each_mem_range(i, &memblock.reserved, &memblock.memory,
> +			     NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, &nid) {
> +		pr_warn("memblock: reserved range [%pa-%pa] is not in memory\n",
> +			&start, &end);
> +		memblock_add_node(start, (end - start), nid);
> +	}
> +}
> +
>  void __init_memblock memblock_set_current_limit(phys_addr_t limit)
>  {
>  	memblock.current_limit = limit;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7c8ead3da355..f117460d6223 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7507,6 +7507,13 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>  	memset(arch_zone_highest_possible_pfn, 0,
>  				sizeof(arch_zone_highest_possible_pfn));
>  
> +	/*
> +	 * Some architectures (e.g. x86) have reserved pages outside of
> +	 * memblock.memory. Make sure these pages are taken into account
> +	 * when detecting zone and node boundaries
> +	 */
> +	memblock_enforce_memory_reserved_overlap();
> +
>  	start_pfn = find_min_pfn_with_active_regions();
>  	descending = arch_has_descending_max_zone_pfns();
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [69fe24d1d80feac4289778582cf0a15256d59baf] firmware: xilinx: Mark pm_api_features_map with static keyword
> git bisect good 69fe24d1d80feac4289778582cf0a15256d59baf
> # bad: [7f507faf2d8592f0f4455728dd08986ec6cc7b0e] staging-next-20201211.0
> git bisect bad 7f507faf2d8592f0f4455728dd08986ec6cc7b0e
> # good: [4baeae4883ba51406bb4f06c886d61440628adb7] Merge remote-tracking branch 'crypto/master'
> git bisect good 4baeae4883ba51406bb4f06c886d61440628adb7
> # good: [593b02d9998c2ae111b2afd9205b5be094b1a69e] Merge remote-tracking branch 'spi/for-next'
> git bisect good 593b02d9998c2ae111b2afd9205b5be094b1a69e
> # good: [69f315daea3d7943175d7570576fd21bef3965c2] Merge remote-tracking branch 'staging/staging-next'
> git bisect good 69f315daea3d7943175d7570576fd21bef3965c2
> # good: [fce046ce7d0944b02fcd190b26d995ab2dd3c5fd] Merge remote-tracking branch 'userns/for-next'
> git bisect good fce046ce7d0944b02fcd190b26d995ab2dd3c5fd
> # bad: [df3f2557282cba0311b47d886032650cf45e449f] rapidio: remove unused rio_get_asm() and rio_get_device()
> git bisect bad df3f2557282cba0311b47d886032650cf45e449f
> # good: [176232b371b0ab0e970e80879f851fe529be8ef0] mm/page_alloc: clear all pages in post_alloc_hook() with init_on_alloc=1
> git bisect good 176232b371b0ab0e970e80879f851fe529be8ef0
> # bad: [e1a24938fc628aa51933262a0a4af3bd3085e4df] zram: break the strict dependency from lzo
> git bisect bad e1a24938fc628aa51933262a0a4af3bd3085e4df
> # bad: [23b1d94b7bd7db1903686c4f2364b942181db887] mm: make pagecache tagged lookups return only head pages
> git bisect bad 23b1d94b7bd7db1903686c4f2364b942181db887
> # good: [d9f9370b97e3b7b84e92870d12fa17b9a346bc44] mm/vmscan.c: remove the filename in the top of file comment
> git bisect good d9f9370b97e3b7b84e92870d12fa17b9a346bc44
> # bad: [0c675604b0b47efb3281ffa66ede56036bb674b7] mm-fix-initialization-of-struct-page-for-holes-in-memory-layout-checkpatch-fixes
> git bisect bad 0c675604b0b47efb3281ffa66ede56036bb674b7
> # good: [d6c1578855ee5805c673638648e5ded4364a2649] z3fold: remove preempt disabled sections for RT
> git bisect good d6c1578855ee5805c673638648e5ded4364a2649
> # good: [d9387865b7499bbd03e905c7170efba840ba6505] mm/compaction: make defer_compaction and compaction_deferred static
> git bisect good d9387865b7499bbd03e905c7170efba840ba6505
> # bad: [bdc54c457d8b2b5883b7223c52b5b451538a70a3] mm: fix initialization of struct page for holes in memory layout
> git bisect bad bdc54c457d8b2b5883b7223c52b5b451538a70a3
> # bad: [950c3769192512118a87432dd42e71c5241dbd10] mm: memblock: enforce overlap of memory.memblock and memory.reserved
> git bisect bad 950c3769192512118a87432dd42e71c5241dbd10
> # first bad commit: [950c3769192512118a87432dd42e71c5241dbd10] mm: memblock: enforce overlap of memory.memblock and memory.reserved
> -------------------------------------------------------------------------------
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#3027): https://groups.io/g/kernelci-results-staging/message/3027
> Mute This Topic: https://groups.io/mt/78889638/924702
> Mute #2286-staging:https://groups.io/g/kernelci-results-staging/mutehashtag/2286-staging
> Group Owner: kernelci-results-staging+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results-staging/leave/8133414/1062240773/xyzzy [guillaume.tucker@collabora.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

