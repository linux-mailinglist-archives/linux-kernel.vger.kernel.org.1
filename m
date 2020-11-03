Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DFE2A3FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgKCJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:23:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:53964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgKCJXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:23:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604395391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZirvJkFfS5KQWBeS+X1b4eLDAWA7Tfi5Tdja1+LJ1c4=;
        b=JdWuxErStXUT8gLHd/RYGe/UBTRaPIXthJXEuFtepLvLSQ1VotX1EG/2Owx3j8Y24w5/t/
        mIduwBLlsf5JbdLIDvrBPVYncvRWBg+VOvNKLklGO62yrCnm2GdY5OnINFD29N+q8W+f5r
        q9u0w4UH1TKMoxQPoDRB0OzTBbOb2ow=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC1D8AC97;
        Tue,  3 Nov 2020 09:23:10 +0000 (UTC)
Date:   Tue, 3 Nov 2020 10:23:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 4/4] powernv/memtrace: don't abuse memory hot(un)plug
 infrastructure for memory allocations
Message-ID: <20201103092309.GD21990@dhcp22.suse.cz>
References: <20201029162718.29910-1-david@redhat.com>
 <20201029162718.29910-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029162718.29910-5-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29-10-20 17:27:18, David Hildenbrand wrote:
> Let's use alloc_contig_pages() for allocating memory and remove the
> linear mapping manually via arch_remove_linear_mapping(). Mark all pages
> PG_offline, such that they will definitely not get touched - e.g.,
> when hibernating. When freeing memory, try to revert what we did.
> 
> The original idea was discussed in:
>  https://lkml.kernel.org/r/48340e96-7e6b-736f-9e23-d3111b915b6e@redhat.com
> 
> This is similar to CONFIG_DEBUG_PAGEALLOC handling on other
> architectures, whereby only single pages are unmapped from the linear
> mapping. Let's mimic what memory hot(un)plug would do with the linear
> mapping.
> 
> We now need MEMORY_HOTPLUG and CONTIG_ALLOC as dependencies.
> 
> Simple test under QEMU TCG (10GB RAM, single NUMA node):
> 
> sh-5.0# mount -t debugfs none /sys/kernel/debug/
> sh-5.0# cat /sys/devices/system/memory/block_size_bytes
> 40000000
> sh-5.0# echo 0x40000000 > /sys/kernel/debug/powerpc/memtrace/enable
> [   71.052836][  T356] memtrace: Allocated trace memory on node 0 at 0x0000000080000000
> sh-5.0# echo 0x80000000 > /sys/kernel/debug/powerpc/memtrace/enable
> [   75.424302][  T356] radix-mmu: Mapped 0x0000000080000000-0x00000000c0000000 with 64.0 KiB pages
> [   75.430549][  T356] memtrace: Freed trace memory back on node 0
> [   75.604520][  T356] memtrace: Allocated trace memory on node 0 at 0x0000000080000000
> sh-5.0# echo 0x100000000 > /sys/kernel/debug/powerpc/memtrace/enable
> [   80.418835][  T356] radix-mmu: Mapped 0x0000000080000000-0x0000000100000000 with 64.0 KiB pages
> [   80.430493][  T356] memtrace: Freed trace memory back on node 0
> [   80.433882][  T356] memtrace: Failed to allocate trace memory on node 0
> sh-5.0# echo 0x40000000 > /sys/kernel/debug/powerpc/memtrace/enable
> [   91.920158][  T356] memtrace: Allocated trace memory on node 0 at 0x0000000080000000
> 
> Note 1: We currently won't be allocating from ZONE_MOVABLE - because our
> 	pages are not movable. However, as we don't run with any memory
> 	hot(un)plug mechanism around, we could make an exception to
> 	increase the chance of allocations succeeding.
> 
> Note 2: PG_reserved isn't sufficient. E.g., kernel_page_present() used
> 	along PG_reserved in hibernation code will always return "true"
> 	on powerpc, resulting in the pages getting touched. It's too
> 	generic - e.g., indicates boot allocations.
> 
> Note 3: For now, we keep using memory_block_size_bytes() as minimum
> 	granularity. I'm not able to come up with a better guess (most
> 	probably, doing it on a section basis could be possible).
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Rashmica Gupta <rashmica.g@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Thanks! This looks like a move into the right direction. I cannot really
judge implementation details because I am not familiar with the code.
I have only one tiny concern:
[...]
> -/* called with device_hotplug_lock held */
> -static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
> +static u64 memtrace_alloc_node(u32 nid, u64 size)
>  {
> -	const unsigned long start = PFN_PHYS(start_pfn);
> -	const unsigned long size = PFN_PHYS(nr_pages);
> +	const unsigned long nr_pages = PHYS_PFN(size);
> +	unsigned long pfn, start_pfn;
> +	struct page *page;
>  
> -	if (walk_memory_blocks(start, size, NULL, check_memblock_online))
> -		return false;
> -
> -	walk_memory_blocks(start, size, (void *)MEM_GOING_OFFLINE,
> -			   change_memblock_state);
> -
> -	if (offline_pages(start_pfn, nr_pages)) {
> -		walk_memory_blocks(start, size, (void *)MEM_ONLINE,
> -				   change_memblock_state);
> -		return false;
> -	}
> +	/*
> +	 * Trace memory needs to be aligned to the size, which is guaranteed
> +	 * by alloc_contig_pages().
> +	 */
> +	page = alloc_contig_pages(nr_pages, __GFP_THISNODE | __GFP_NOWARN,
> +				  nid, NULL);

__GFP_THISNODE without other modifiers looks suspicious. I suspect you
want to enfore node locality and exclude movable zones by this. While
this works it is an antipattern. I would rather use GFP_KERNEL |
__GFP_THISNODE | __GFP_NOWARN to be more in line with other gfp usage.

If for no other reasons we want to be able to work inside a normal
compaction context (comparing to effectively GFP_NOIO which the above
implies). Also this looks like a sleepable context.
-- 
Michal Hocko
SUSE Labs
