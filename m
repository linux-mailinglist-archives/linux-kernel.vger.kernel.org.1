Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D192C1E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgKXGto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:49:44 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10245 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXGtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:49:43 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbcad070000>; Mon, 23 Nov 2020 22:49:43 -0800
Received: from [10.2.51.94] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 06:49:35 +0000
Subject: Re: Pinning ZONE_MOVABLE pages
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "David Hildenbrand" <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "Tyler Hicks" <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <sthemmin@microsoft.com>
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <89be454b-4464-0c50-c910-917373f29ba5@nvidia.com>
Date:   Mon, 23 Nov 2020 22:49:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606200583; bh=+E7P+/MVvdxye/PKfE7rKDuvOl7P/QbV6+/0lHewOps=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=EqpuXuLrMAZQJhZ58grdtyOXe2xPWi8HtCe3slxg3EkeTSDGvGK6zwWbEL0aXzyp8
         8x1U0aJ/t8D40tjCBYM5vp0CuxiJpldjW9zZsU7WUllFUIYsS/SY4azpt9qjBy4Mrk
         XxCU5jSK7tHu1/O173JwwKNOZ8THOaJhfCRUVh3pG3wUFMfwbLKVR4mnAOxTbDObWn
         DcC/wk5rAuoaPC7Whsc2KVqokOQRxTxRmfakN8dlg9PdXWfqjn9cO1xDMCiCrOVu6N
         bkRUafXXDLqv/5z0ypTJZ6yKfNwRrzwVd4KPz0kjf25MXUBBeojkgHvjaAVyYZzXM2
         ILCPG4PQhTK+w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 12:27 PM, Pavel Tatashin wrote:
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


I like where the discussion so far (in the other threads) has taken
this. And the current plan also implies, I think, that you can probably
avoid any new flags at all: just check that both FOLL_LONGTERM and
FOLL_PIN are set, and if they are, then make your attempt to migrate
away from ZONE_MOVABLE.



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

I'm pleased that the gup_flags have pretty much been plumbed through all the
main places that they were missing, so there shouldn't be too much required
at this point.

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
> 
> 2. Add an internal move_pages_zone() similar to move_pages() syscall
> but instead of migrating to a different NUMA node, migrate pages from
> ZONE_MOVABLE to another zone.
> Call move_pages_zone() on demand prior to pinning pages from
> vfio_pin_map_dma() for instance.
> 
> 3. Perhaps, it also makes sense to add madvise() flag, to allocate
> pages from non-movable zone. When a user application knows that it
> will do DMA mapping, and pin pages for a long time, the memory that it
> allocates should never be migrated or hot-removed, so make sure that
> it comes from the appropriate place.
> The benefit of adding madvise() flag is that we won't have to deal
> with slow page migration during pin time, but the disadvantage is that
> we would need to change the user interface.
> 
> Before I start working on the above approaches, I would like to get an
> opinion from the community on an appropriate path forward for this
> problem. If what I described sounds reasonable, or if there are other
> ideas on how to address the problem that I am seeing.
> 

I'm also in favor with avoiding (3) for now and maybe forever, depending on
how it goes. Good luck... :)


thanks,
-- 
John Hubbard
NVIDIA
