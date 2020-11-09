Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAAD2AB641
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgKILNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:13:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2075 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgKILNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:13:06 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CV7bT5CWnz67JSw;
        Mon,  9 Nov 2020 19:11:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 9 Nov 2020 12:13:03 +0100
Received: from [10.210.172.102] (10.210.172.102) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 9 Nov 2020 11:13:02 +0000
Subject: Re: [PATCH v5 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To:     Robin Murphy <robin.murphy@arm.com>, <vjitta@codeaurora.org>,
        <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vinmenon@codeaurora.org>, <kernel-team@android.com>
References: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
 <1601451864-5956-2-git-send-email-vjitta@codeaurora.org>
 <ff318311-77e8-b235-37dd-7b1b5f5d8ed9@arm.com>
 <e1e5b24a-512b-7279-8341-7f4495718ece@huawei.com>
 <5293135b-3a28-4edc-0515-61e595600bba@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0477c95c-03fd-98f6-8bf4-9a567826310f@huawei.com>
Date:   Mon, 9 Nov 2020 11:12:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <5293135b-3a28-4edc-0515-61e595600bba@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.172.102]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2020 15:59, Robin Murphy wrote:
>>>> alloc failure even after retry as global
>>>> rcache is holding the iova's which can cause fragmentation.
>>>> So, free the global iova rcache as well and then go for the
>>>> retry.
>>>
>>
>> If we do clear all the CPU rcaches, it would nice to have something 
>> immediately available to replenish, i.e. use the global rcache, 
>> instead of flushing it, if that is not required...
> 
> If we've reached the point of clearing *any* caches, though, I think any 
> hope of maintaining performance is already long gone. We've walked the 
> rbtree for the entire address space and found that it's still too full 
> to allocate from; we're teetering on the brink of hard failure and this 
> is a last-ditch attempt to claw back as much as possible in the hope 
> that it gives us a usable space. >
> TBH I'm not entirely sure what allocation pattern was expected by the 
> original code such that purging only some of the caches made sense,

I'd say that the assumption is that once the CPU rcaches are flushed, 
then we should have space again. No need to go any further.

> nor 
> what kind of pattern leads to lots of smaller IOVAs being allocated, 
> freed, and never reused to the point of blocking larger allocations, but 
> either way the reasoning does at least seem to hold up in abstract.

Ok, but I'd like to see that hard failure (if you get my meaning). 
Flushing the depot rcache may be papering over some other bug.

Either way, I don't feel to strongly, so if you're happy then I won't 
try to block, so [apart from comment, below]:
Acked-by: John Garry <john.garry@huaqwei.com>

> 
>>> This looks reasonable to me - it's mildly annoying that we end up 
>>> with so many similar-looking functions,
>>
>> Well I did add a function to clear all CPU rcaches here, if you would 
>> like to check:
>>
>> https://lore.kernel.org/linux-iommu/1603733501-211004-2-git-send-email-john.garry@huawei.com/ 
> 
> 
> I was thinking more of the way free_iova_rcaches(), 
> free_cpu_cached_iovas(), and free_global_cached_iovas() all look pretty 
> much the same shape at a glance.
> 
>>> but the necessary differences are right down in the middle of the 
>>> loops so nothing can reasonably be factored out :(
>>>
>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>>
>>>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>>>> ---
>>>>   drivers/iommu/iova.c | 23 +++++++++++++++++++++++
>>>>   1 file changed, 23 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>>> index c3a1a8e..faf9b13 100644
>>>> --- a/drivers/iommu/iova.c
>>>> +++ b/drivers/iommu/iova.c
>>>> @@ -25,6 +25,7 @@ static void init_iova_rcaches(struct iova_domain 
>>>> *iovad);
>>>>   static void free_iova_rcaches(struct iova_domain *iovad);
>>>>   static void fq_destroy_all_entries(struct iova_domain *iovad);
>>>>   static void fq_flush_timeout(struct timer_list *t);
>>>> +static void free_global_cached_iovas(struct iova_domain *iovad);
>>
>> a thought: It would be great if the file could be rearranged at some 
>> point where we don't require so many forward declarations.
>>
>>>>   void
>>>>   init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>>>> @@ -442,6 +443,7 @@ alloc_iova_fast(struct iova_domain *iovad, 
>>>> unsigned long size,
>>>>           flush_rcache = false;
>>>>           for_each_online_cpu(cpu)
>>>>               free_cpu_cached_iovas(cpu, iovad);
>>>> +        free_global_cached_iovas(iovad);
>>>>           goto retry;
>>>>       }
>>>> @@ -1057,5 +1059,26 @@ void free_cpu_cached_iovas(unsigned int cpu, 
>>>> struct iova_domain *iovad)
>>>>       }
>>>>   }
>>>> +/*
>>>> + * free all the IOVA ranges of global cache
>>>> + */
>>>> +static void free_global_cached_iovas(struct iova_domain *iovad)
>>>> +{
>>>> +    struct iova_rcache *rcache;
>>>> +    unsigned long flags;
>>>> +    int i, j;
>>>> +
>>>> +    for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>>>> +        rcache = &iovad->rcaches[i];
>>>> +        spin_lock_irqsave(&rcache->lock, flags);
>>>> +        for (j = 0; j < rcache->depot_size; ++j) {
>>>> +            iova_magazine_free_pfns(rcache->depot[j], iovad);
>>>> +            iova_magazine_free(rcache->depot[j]);
>>>> +            rcache->depot[j] = NULL;
>>
>> I don't think that NULLify is strictly necessary
> 
> True, we don't explicitly clear depot entries in __iova_rcache_get() for 
> normal operation, so there's not much point in doing so here.

Right, so for consistency, I think that it would be nice not to NULLify, 
for consistency.

> 
> Robin.

