Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77FE2C0E66
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389328AbgKWPEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:04:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:40654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729244AbgKWPEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:04:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F119DAF0D;
        Mon, 23 Nov 2020 15:04:10 +0000 (UTC)
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com,
        John Hubbard <jhubbard@nvidia.com>
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Pinning ZONE_MOVABLE pages
Message-ID: <d668b0f2-2644-0f5e-a8c1-a6b8f515e9ab@suse.cz>
Date:   Mon, 23 Nov 2020 16:04:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC John Hubbard

On 11/20/20 9:27 PM, Pavel Tatashin wrote:
> Recently, I encountered a hang that is happening during memory hot
> remove operation. It turns out that the hang is caused by pinned user
> pages in ZONE_MOVABLE.
> 
> Kernel expects that all pages in ZONE_MOVABLE can be migrated, but
> this is not the case if a user applications such as through dpdk
> libraries pinned them via vfio dma map. Kernel keeps trying to
> hot-remove them, but refcnt never gets to zero, so we are looping
> until the hardware watchdog kicks in.
> 
> We cannot do dma unmaps before hot-remove, because hot-remove is a
> slow operation, and we have thousands for network flows handled by
> dpdk that we just cannot suspend for the duration of hot-remove
> operation.
> 
> The solution is for dpdk to allocate pages from a zone below
> ZONE_MOVAVLE, i.e. ZONE_NORMAL/ZONE_HIGHMEM, but this is not possible.
> There is no user interface that we have that allows applications to
> select what zone the memory should come from.
> 
> I've spoken with Stephen Hemminger, and he said that DPDK is moving in
> the direction of using transparent huge pages instead of HugeTLBs,
> which means that we need to allow at least anonymous, and anonymous
> transparent huge pages to come from non-movable zones on demand.
> 
> Here is what I am proposing:
> 1. Add a new flag that is passed through pin_user_pages_* down to
> fault handlers, and allow the fault handler to allocate from a
> non-movable zone.
> 
> Sample function stacks through which this info needs to be passed is this:
> 
> pin_user_pages_remote(gup_flags)
>   __get_user_pages_remote(gup_flags)
>    __gup_longterm_locked(gup_flags)
>     __get_user_pages_locked(gup_flags)
>      __get_user_pages(gup_flags)
>       faultin_page(gup_flags)
>        Convert gup_flags into fault_flags
>        handle_mm_fault(fault_flags)
> 
>  From handle_mm_fault(), the stack diverges into various faults,
> examples include:
> 
> Transparent Huge Page
> handle_mm_fault(fault_flags)
> __handle_mm_fault(fault_flags)
> Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mask
> create_huge_pmd(vmf);
> do_huge_pmd_anonymous_page(vmf);
> mm_get_huge_zero_page(vma->vm_mm); -> flag is lost, so flag from
> vmf.gfp_mask should be passed as well.
> 
> There are several other similar paths in a transparent huge page, also
> there is a named path where allocation is based on filesystems, and
> the flag should be honored there as well, but it does not have to be
> added at the same time.
> 
> Regular Pages
> handle_mm_fault(fault_flags)
> __handle_mm_fault(fault_flags)
> Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mask
> handle_pte_fault(vmf)
> do_anonymous_page(vmf);
> page = alloc_zeroed_user_highpage_movable(vma, vmf->address); ->
> replace change this call according to gfp_mask.
> 
> The above only take care of the case if user application faults on the
> page during pinning time, but there are also cases where pages already
> exist.

Makes sense, as this means no userspace change.

> 2. Add an internal move_pages_zone() similar to move_pages() syscall
> but instead of migrating to a different NUMA node, migrate pages from
> ZONE_MOVABLE to another zone.
> Call move_pages_zone() on demand prior to pinning pages from
> vfio_pin_map_dma() for instance.

As others already said, migrating away before the longterm pin should be 
the solution. IIRC it was one of the goals of long term pinning api 
proposed long time ago by Peter Ziljstra I think? The implementation 
that was merged relatively recently doesn't do that (yet?) for all 
movable pages, just CMA, but it could.

> 3. Perhaps, it also makes sense to add madvise() flag, to allocate
> pages from non-movable zone. When a user application knows that it
> will do DMA mapping, and pin pages for a long time, the memory that it
> allocates should never be migrated or hot-removed, so make sure that
> it comes from the appropriate place.
> The benefit of adding madvise() flag is that we won't have to deal
> with slow page migration during pin time, but the disadvantage is that
> we would need to change the user interface.

It's best if we avoid involving userspace until it's shown that's it's 
insufficient.

> Before I start working on the above approaches, I would like to get an
> opinion from the community on an appropriate path forward for this
> problem. If what I described sounds reasonable, or if there are other
> ideas on how to address the problem that I am seeing.
> 
> Thank you,
> Pasha
> 

