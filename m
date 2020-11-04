Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358E02A5FA2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgKDIbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:31:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2049 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgKDIbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:31:32 -0500
X-Greylist: delayed 940 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 03:31:32 EST
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CQzvp6CMhz67HRq;
        Wed,  4 Nov 2020 16:14:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 4 Nov 2020 09:15:50 +0100
Received: from [10.210.165.147] (10.210.165.147) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 4 Nov 2020 08:15:49 +0000
Subject: Re: [PATCH v2 3/4] iommu/iova: Flush CPU rcache for when a depot
 fills
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
References: <1603733501-211004-1-git-send-email-john.garry@huawei.com>
 <1603733501-211004-4-git-send-email-john.garry@huawei.com>
 <65b568ef-ff2a-0993-e6f5-b6414b3b19f8@arm.com>
 <d36fc7ec-cefa-0805-8036-3aea1c44fba2@huawei.com>
 <d7611b01-ea16-bbaa-fcd1-d11dc872ce5d@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c409594a-0ae1-d8cd-ddee-226d739eed5b@huawei.com>
Date:   Wed, 4 Nov 2020 08:15:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <d7611b01-ea16-bbaa-fcd1-d11dc872ce5d@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.165.147]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

>> - then cpu3, cpu4, and so on.
>> - We can do this for all CPUs in the system, so total CPU rcache grows 
>> from zero -> #CPUs * 128 * 2. Yet no DMA mapping leaks.
> 
> I get that. That's the initial warm-up phase I alluded to below. In an 
> even simpler example, allocating on CPU A and freeing on CPU B will 
> indeed move IOVAs from the tree into magazines without reuse, but only 
> up to a point. Eventually, CPU B's cache fills up and pushes a magazine 
> into the depot, and at *that* point things reach a steady state, since 
> the next allocation on CPU A will then pull that magazine from the depot 
> and proceed to allocate from there. If allocs and frees stay perfectly 
> balanced, the working set is then 3 magazines. Yes, the depot can fill 
> up if the number of IOVAs that CPU B frees at once before CPU A 
> reallocates them is comparable to the total depot capacity, but it can't 
> reasonably *stay* full unless CPU A stops allocating altogether.
> 
>> Something similar can happen in normal use, where the scheduler 
>> relocates processes all over the CPUs in the system as time goes by, 
>> which causes the total rcache size to continue to grow. And in 
>> addition to this, the global depot continues to grow very slowly as 
>> well. But when it does fill (the global depot, that is), and we start 
>> to free magazines to make space – as is current policy - that's very 
>> slow and causes the performance drop.
> 
> Sure, but how does it then consistently *remain* in that state? And 
> *why* does the depot slowly and steadily grow in the first place if 
> alloc and free are ultimately balanced? 

So some key info I missed sharing was that we only see this issue for 
non-strict mode. For strict mode, the rcache occupancy stays quite 
compact, and does not grow like we see for non-strict mode.

I have some (very large) kernel logs in which all the CPU and depot 
rcache occupancy levels are periodically dumped, and where you can get 
an idea of the trend.

I'm on vacation today, so I can share them tomorrow.

> I can get the depot swinging 
> between full and empty if it's simply too small to bounce magazines 
> between a large number of "CPU A"s and "CPU B"s, but again, that's 
> surely going to show as repeated performance swings between bad at each 
> end and good in the middle, not a steady degradation.

Yeah, so I see the depot max size (32) is adequate in size, such that 
this does not happen.

> 
>>> Now indeed that could happen over the short term if IOVAs are allocated
>>> and freed again in giant batches larger than the total global cache
>>> capacity, but that would show a cyclic behaviour - when activity starts,
>>> everything is first allocated straight from the tree, then when it ends
>>> the caches would get overwhelmed by the large burst of freeing and start
>>> having to release things back to the tree, but eventually that would
>>> stop once everything *is* freed, then when activity begins again the
>>> next round of allocating would inherently clear out all the caches
>>> before going anywhere near the tree. 
>>
>> But there is no clearing. A CPU will keep the IOVA cached 
>> indefinitely, even when there is no active DMA mapping present at all.
> 
> Sure, the percpu caches can buffer IOVAs for an indefinite amount of 
> time depending on how many CPUs are active, but the depot usage is still 
> absolutely representative of the total working set for whichever CPUs 
> *are* active. In this whole discussion I'm basically just considering 
> the percpu caches as pipeline stages for serialising IOVAs into and out 
> of magazines. It's the motion of magazines that's the interesting part.
> 
> If the depot keeps continually filling up, *some* CPUs are freeing 
> enough IOVAs to push out full magazines, and those IOVAs have to come 
> from somewhere, so *some* CPUs are allocating, and those CPUs can't 
> allocate forever without taking magazines back out of the depot (that's 
> the "clearing out" I meant). Something about a steady degradation that 
> never shows any sign of recovery (even periodically) just doesn't seem 
> to add up.
> 
> Anyway, by now I think it would be most interesting to get rid of this 
> bottleneck completely rather than dance around bodging it, and see what 
> happens if we simply let the depot grow to fit the maximum working set, 
> so I did this:
> 
> https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/iova
> 
> Only compile-tested, so probably full of trivial bugs, but I'm curious 
> to see if the slight extra overhead to depot management is noticeable in 
> normal cases.

So allowing the depot size to grow unbounded should solve that immediate 
issue.

However, I'd like to see a move in the opposite direction, that is to 
trim the rcaches at some intervals. Indeed, with an appreciable 
frequency, IOVA rcache allocation requests may not be satisfied due to 
size limit - we see this for our same storage scenario, where some IOVA 
requests are > 200K in size, and must use the tree. So allowing the 
rcaches to grow further just makes handling these requests slower.

Thanks,
John
