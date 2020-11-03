Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BAB2A58A6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbgKCVxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:53:39 -0500
Received: from foss.arm.com ([217.140.110.172]:57550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbgKCVxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:53:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B11A1474;
        Tue,  3 Nov 2020 13:53:33 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AE043F718;
        Tue,  3 Nov 2020 13:53:31 -0800 (PST)
Subject: Re: [PATCH v2 3/4] iommu/iova: Flush CPU rcache for when a depot
 fills
To:     John Garry <john.garry@huawei.com>,
        "joro@8bytes.org" <joro@8bytes.org>
Cc:     "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
References: <1603733501-211004-1-git-send-email-john.garry@huawei.com>
 <1603733501-211004-4-git-send-email-john.garry@huawei.com>
 <65b568ef-ff2a-0993-e6f5-b6414b3b19f8@arm.com>
 <d36fc7ec-cefa-0805-8036-3aea1c44fba2@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d7611b01-ea16-bbaa-fcd1-d11dc872ce5d@arm.com>
Date:   Tue, 3 Nov 2020 21:53:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <d36fc7ec-cefa-0805-8036-3aea1c44fba2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-03 17:56, John Garry wrote:
>>> To summarize, the issue is that as time goes by, the CPU rcache and 
>>> depot
>>> rcache continue to grow. As such, IOVA RB tree access time also 
>>> continues
>>> to grow.
>>
> 
> Hi Robin,
> 
>> I'm struggling to see how this is not simply indicative of a leak
>> originating elsewhere. 
> 
> It sounds like one, but I don't think it is.
> 
>> For the number of magazines to continually grow,
>> it means IOVAs *of a particular size* are being freed faster than they
>> are being allocated, while the only place that ongoing allocations
>> should be coming from is those same magazines!
> 
> But that is not the nature of how the IOVA caching works. The cache size 
> is not defined by how DMA mappings we may have at a given moment in time 
> or maximum which we did have at a point earlier. It just grows to a 
> limit to where all CPU and global depot rcaches fill.
> 
> Here's an artificial example of how the rcache can grow, but I hope can 
> help illustrate:
> - consider a process which wants many DMA mapping active at a given 
> point in time
> - if we tie to cpu0, cpu0 rcache will grow to 128 * 2
> - then tie to cpu1, cpu1 rcache will grow to 128 * 2, so total CPU 
> rcache = 2 * 128 * 2. CPU rcache for cpu0 is not flushed - there is no 
> maintenance for this.
> - then tie to cpu2, cpu2 rcache will grow to 128 * 2, so total CPU 
> rcache = 3 * 128 * 2
> - then cpu3, cpu4, and so on.
> - We can do this for all CPUs in the system, so total CPU rcache grows 
> from zero -> #CPUs * 128 * 2. Yet no DMA mapping leaks.

I get that. That's the initial warm-up phase I alluded to below. In an 
even simpler example, allocating on CPU A and freeing on CPU B will 
indeed move IOVAs from the tree into magazines without reuse, but only 
up to a point. Eventually, CPU B's cache fills up and pushes a magazine 
into the depot, and at *that* point things reach a steady state, since 
the next allocation on CPU A will then pull that magazine from the depot 
and proceed to allocate from there. If allocs and frees stay perfectly 
balanced, the working set is then 3 magazines. Yes, the depot can fill 
up if the number of IOVAs that CPU B frees at once before CPU A 
reallocates them is comparable to the total depot capacity, but it can't 
reasonably *stay* full unless CPU A stops allocating altogether.

> Something similar can happen in normal use, where the scheduler 
> relocates processes all over the CPUs in the system as time goes by, 
> which causes the total rcache size to continue to grow. And in addition 
> to this, the global depot continues to grow very slowly as well. But 
> when it does fill (the global depot, that is), and we start to free 
> magazines to make space – as is current policy - that's very slow and 
> causes the performance drop.

Sure, but how does it then consistently *remain* in that state? And 
*why* does the depot slowly and steadily grow in the first place if 
alloc and free are ultimately balanced? I can get the depot swinging 
between full and empty if it's simply too small to bounce magazines 
between a large number of "CPU A"s and "CPU B"s, but again, that's 
surely going to show as repeated performance swings between bad at each 
end and good in the middle, not a steady degradation.

>> Now indeed that could happen over the short term if IOVAs are allocated
>> and freed again in giant batches larger than the total global cache
>> capacity, but that would show a cyclic behaviour - when activity starts,
>> everything is first allocated straight from the tree, then when it ends
>> the caches would get overwhelmed by the large burst of freeing and start
>> having to release things back to the tree, but eventually that would
>> stop once everything *is* freed, then when activity begins again the
>> next round of allocating would inherently clear out all the caches
>> before going anywhere near the tree. 
> 
> But there is no clearing. A CPU will keep the IOVA cached indefinitely, 
> even when there is no active DMA mapping present at all.

Sure, the percpu caches can buffer IOVAs for an indefinite amount of 
time depending on how many CPUs are active, but the depot usage is still 
absolutely representative of the total working set for whichever CPUs 
*are* active. In this whole discussion I'm basically just considering 
the percpu caches as pipeline stages for serialising IOVAs into and out 
of magazines. It's the motion of magazines that's the interesting part.

If the depot keeps continually filling up, *some* CPUs are freeing 
enough IOVAs to push out full magazines, and those IOVAs have to come 
from somewhere, so *some* CPUs are allocating, and those CPUs can't 
allocate forever without taking magazines back out of the depot (that's 
the "clearing out" I meant). Something about a steady degradation that 
never shows any sign of recovery (even periodically) just doesn't seem 
to add up.

Anyway, by now I think it would be most interesting to get rid of this 
bottleneck completely rather than dance around bodging it, and see what 
happens if we simply let the depot grow to fit the maximum working set, 
so I did this:

https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/iova

Only compile-tested, so probably full of trivial bugs, but I'm curious 
to see if the slight extra overhead to depot management is noticeable in 
normal cases.

Robin.

>> To me the "steady decline"
>> behaviour suggests that someone somewhere is making DMA unmap calls with
>> a smaller size than they were mapped with (you tend to notice it quicker
>> the other way round due to all the device errors and random memory
>> corruption) - in many cases that would appear to work out fine from the
>> driver's point of view, but would provoke exactly this behaviour in the
>> IOVA allocator.
>>
> 
> Thanks,
> John
