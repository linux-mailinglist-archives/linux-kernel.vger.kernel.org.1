Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68291292286
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgJSGbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:31:03 -0400
Received: from foss.arm.com ([217.140.110.172]:50214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgJSGbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:31:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51154D6E;
        Sun, 18 Oct 2020 23:31:02 -0700 (PDT)
Received: from [10.163.77.151] (unknown [10.163.77.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 918243F719;
        Sun, 18 Oct 2020 23:30:58 -0700 (PDT)
Subject: Re: arm64: dropping prevent_bootmem_remove_notifier
To:     David Hildenbrand <david@redhat.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Suren Baghdasaryan <surenb@google.com>, pratikp@codeaurora.org,
        Gavin Shan <gshan@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <de8388df2fbc5a6a33aab95831ba7db4@codeaurora.org>
 <630d58e0-cddc-bd39-1f2f-cb933740a133@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <764f2d7b-8e11-c911-a93f-6682d86d20ab@arm.com>
Date:   Mon, 19 Oct 2020 12:00:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <630d58e0-cddc-bd39-1f2f-cb933740a133@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2020 03:05 PM, David Hildenbrand wrote:
> On 17.10.20 01:11, Sudarshan Rajagopalan wrote:
>>
>> Hello Anshuman,
>>
> David here,
> 
> in general, if your driver offlines+removes random memory, it is doing
> something *very* wrong and dangerous. You shouldn't ever be
> offlining+removing memory unless
> a) you own that boot memory after boot. E.g., the ACPI driver owns DIMMs
> after a reboot.
> b) you added that memory via add_memory() and friends.

Right.

> 
> Even trusting that offline memory can be used by your driver is wrong.

Right.

> 
> Just imagine you racing with actual memory hot(un)plug, you'll be in
> *big* trouble. For example,
> 
> 1. You offlined memory and assume you can use it. A DIMM can simply get
> unplugged. you're doomed.
> 2. You offlined+removed memory and assume you can use it. A DIMM can
> simply get unplugged and the whole machine would crash.
> 
> Or imagine your driver running on a system that has virtio-mem, which
> will try to remove/offline+remove memory that was added by virtio-mem/
> is under its control.
> 
> Long story short: don't do it.
> 
> There is *one* instance in Linux where we currently allow it for legacy
> reasons. It is powernv/memtrace code that offlines+removes boot memory.
> But here we are guaranteed to run in an environment (HW) without any
> actual memory hot(un)plug.
> 
> I guess you're going to say "but in our environment we don't have ..." -
> this is not a valid argument to change such generic things upstream /
> introducing such hacks.

Agreed.

> 
>> In the patch that enables memory hot-remove (commit bbd6ec605c0f 
>> ("arm64/mm: Enable memory hot remove")) for arm64, there’s a notifier 
>> put in place that prevents boot memory from being offlined and removed. 
>> Also commit text mentions that boot memory on arm64 cannot be removed. 
>> We wanted to understand more about the reasoning for this. X86 and other 
>> archs doesn’t seem to do this prevention. There’s also comment in the 
>> code that this notifier could be dropped in future if and when boot 
>> memory can be removed.
> 
> The issue is that with *actual* memory hotunplug (for what the whole
> machinery should be used for), that memory/DIMM will be gone. And as you
> cannot fixup the initial memmap, if you were to reboot that machine, you
> would simply crash immediately.

Right.

> 
> On x86, you can have that easily: hotplug DIMMs on bare metal and
> reboot. The DIMMs will be exposed via e820 during boot, so they are
> "early", although if done right (movable_node, movable_core and
> similar), they can get hotunplugged later. Important in environments
> where you want to hotunplug whole nodes. But has HW on x86 will properly
> adjust the initial memmap / e820, there is no such issue as on arm64.

That is the primary problem.

> 
>>
>> The current logic is that only “new” memory blocks which are hot-added 
>> can later be offlined and removed. The memory that system booted up with 
>> cannot be offlined and removed. But there could be many usercases such 
>> as inter-VM memory sharing where a primary VM could offline and 
>> hot-remove a block/section of memory and lend it to secondary VM where 
>> it could hot-add it. And after usecase is done, the reverse happens 
> 
> That use case is using the wrong mechanisms. It shouldn't be
> offlining+removing memory. Read below.
> 
>> where secondary VM hot-removes and gives it back to primary which can 
>> hot-add it back. In such cases, the present logic for arm64 doesn’t 
>> allow this hot-remove in primary to happen.
>>
>> Also, on systems with movable zone that sort of guarantees pages to be 
>> migrated and isolated so that blocks can be offlined, this logic also 
>> defeats the purpose of having a movable zone which system can rely on 
>> memory hot-plugging, which say virt-io mem also relies on for fully 
>> plugged memory blocks.
> 
> The MOVABLE_ZONE is *not* just for better guarantees when trying to
> hotunplug memory. It also increases the number of THP/huge pages. And
> that part works just fine.

Right.

> 
>>
>> So we’re trying to understand the reasoning for such a prevention put in 
>> place for arm64 arch alone.
>>
>> One possible way to solve this is by marking the required sections as 
>> “non-early” by removing the SECTION_IS_EARLY bit in its section_mem_map. 
>> This puts these sections in the context of “memory hotpluggable” which 
>> can be offlined-removed and added-onlined which are part of boot RAM 
>> itself and doesn’t need any extra blocks to be hot added. This way of 
>> marking certain sections as “non-early” could be exported so that module 
>> drivers can set the required number of sections as “memory 
> 
> Oh please no. No driver should be doing that. That's just hacking around
> the root issue: you're not supposed to do that.
> 
>> hotpluggable”. This could have certain checks put in place to see which 
>> sections are allowed, example only movable zone sections can be marked 
>> as “non-early”.
>>
> 
> I assume what your use case wants to achieve is, starting VMs with
> large, contiguous memory backings, not wasting memory for the memmap in
> the hypervisor.
> 
> The "traditional" way of doing that is using the "mem=" boot parameter,
> and starting VMs with memory within the "never exposed to Linux" part.

I suggested something similar. Memory not exposed to Linux via this method
can be hot added or removed later on.

> While that in general works, I consider it an ugly hack. And it doesn't
> really allow the hypervisor the reuse unexposed memory.
> 
> The obvious way for a driver to *allocate* memory (because that's what
> you want to do!) is using alloc_contig_range(). I know, that there are
> no guarantees. So you could be using CMA, ... but then, you still have
> the memmap consuming memory in your hypervisor.
> 
> What you could try instead is
> 
> 1. Using hugetlbfs with huge (2MB) / gigantic (1GB) (on x86) pages for
> backing your guest.
> 2. To free up the memmap, you could then go into the direction proposed
> by Muchun Song [1].
> 
> That's then a clean way for a driver to allocate/use memory without
> abusing memory hot(un)plug infrastructure, minimizing the memmap
> consumption.
> 
> 
> [1]
> https://lkml.kernel.org/r/20200915125947.26204-1-songmuchun@bytedance.com
> 
