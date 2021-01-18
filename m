Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD02FAC77
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394518AbhARVUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:20:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:36858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389693AbhARKMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:12:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F36ACAB7A;
        Mon, 18 Jan 2021 10:11:50 +0000 (UTC)
Date:   Mon, 18 Jan 2021 11:11:48 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [PATCH 2/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <20210118101148.GB4988@linux>
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217130758.11565-3-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 02:07:55PM +0100, Oscar Salvador wrote:
> Physical memory hotadd has to allocate a memmap (struct page array) for
> the newly added memory section. Currently, alloc_pages_node() is used
> for those allocations.
> 
> This has some disadvantages:
>  a) an existing memory is consumed for that purpose
>     (eg: ~2MB per 128MB memory section on x86_64)
>  b) if the whole node is movable then we have off-node struct pages
>     which has performance drawbacks.
>  c) It might be there are no PMD_ALIGNED chunks so memmap array gets
>     populated with base pages.
> 
> This can be improved when CONFIG_SPARSEMEM_VMEMMAP is enabled.
> 
> Vmemap page tables can map arbitrary memory.
> That means that we can simply use the beginning of each memory section and
> map struct pages there.
> struct pages which back the allocated space then just need to be treated
> carefully.
> 
> Implementation wise we will reuse vmem_altmap infrastructure to override
> the default allocator used by __populate_section_memmap.
> Part of the implementation also relies on memory_block structure gaining
> a new field which specifies the number of vmemmap_pages at the beginning.
> This comes in handy as in {online,offline}_pages, all the isolation and
> migration is being done on (buddy_start_pfn, end_pfn] range,
> being buddy_start_pfn = start_pfn + nr_vmemmap_pages.
> 
> In this way, we have:
> 
> (start_pfn, buddy_start_pfn - 1] = Initialized and PageReserved
> (buddy_start_pfn, end_pfn]       = Initialized and sent to buddy
> 
> Hot-remove:
> 
>  We need to be careful when removing memory, as adding and
>  removing memory needs to be done with the same granularity.
>  To check that this assumption is not violated, we check the
>  memory range we want to remove and if a) any memory block has
>  vmemmap pages and b) the range spans more than a single memory
>  block, we scream out loud and refuse to proceed.
> 
>  If all is good and the range was using memmap on memory (aka vmemmap pages),
>  we construct an altmap structure so free_hugepage_table does the right
>  thing and calls vmem_altmap_free instead of free_pagetable.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Let us refloat this one before it sinks deeper :-)


-- 
Oscar Salvador
SUSE L3
