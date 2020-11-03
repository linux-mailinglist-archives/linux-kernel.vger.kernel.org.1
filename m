Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C212A4A83
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgKCP75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:59:57 -0500
Received: from foss.arm.com ([217.140.110.172]:51192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgKCP75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:59:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E6B139F;
        Tue,  3 Nov 2020 07:59:56 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A57E23F66E;
        Tue,  3 Nov 2020 07:59:55 -0800 (PST)
Subject: Re: [PATCH v5 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To:     John Garry <john.garry@huawei.com>, vjitta@codeaurora.org,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com
References: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
 <1601451864-5956-2-git-send-email-vjitta@codeaurora.org>
 <ff318311-77e8-b235-37dd-7b1b5f5d8ed9@arm.com>
 <e1e5b24a-512b-7279-8341-7f4495718ece@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5293135b-3a28-4edc-0515-61e595600bba@arm.com>
Date:   Tue, 3 Nov 2020 15:59:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e1e5b24a-512b-7279-8341-7f4495718ece@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-03 14:31, John Garry wrote:
> On 03/11/2020 12:35, Robin Murphy wrote:
>> On 2020-09-30 08:44, vjitta@codeaurora.org wrote:
>>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>>>
>>> When ever an iova alloc request fails we free the iova
>>> ranges present in the percpu iova rcaches and then retry
>>> but the global iova rcache is not freed as a result we could
>>> still see iova alloc failure even after retry as global
>>> rcache is holding the iova's which can cause fragmentation.
>>> So, free the global iova rcache as well and then go for the
>>> retry.
>>
> 
> If we do clear all the CPU rcaches, it would nice to have something 
> immediately available to replenish, i.e. use the global rcache, instead 
> of flushing it, if that is not required...

If we've reached the point of clearing *any* caches, though, I think any 
hope of maintaining performance is already long gone. We've walked the 
rbtree for the entire address space and found that it's still too full 
to allocate from; we're teetering on the brink of hard failure and this 
is a last-ditch attempt to claw back as much as possible in the hope 
that it gives us a usable space.

TBH I'm not entirely sure what allocation pattern was expected by the 
original code such that purging only some of the caches made sense, nor 
what kind of pattern leads to lots of smaller IOVAs being allocated, 
freed, and never reused to the point of blocking larger allocations, but 
either way the reasoning does at least seem to hold up in abstract.

>> This looks reasonable to me - it's mildly annoying that we end up with 
>> so many similar-looking functions,
> 
> Well I did add a function to clear all CPU rcaches here, if you would 
> like to check:
> 
> https://lore.kernel.org/linux-iommu/1603733501-211004-2-git-send-email-john.garry@huawei.com/ 

I was thinking more of the way free_iova_rcaches(), 
free_cpu_cached_iovas(), and free_global_cached_iovas() all look pretty 
much the same shape at a glance.

>> but the necessary differences are right down in the middle of the 
>> loops so nothing can reasonably be factored out :(
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>
>>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>>> ---
>>>   drivers/iommu/iova.c | 23 +++++++++++++++++++++++
>>>   1 file changed, 23 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index c3a1a8e..faf9b13 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -25,6 +25,7 @@ static void init_iova_rcaches(struct iova_domain 
>>> *iovad);
>>>   static void free_iova_rcaches(struct iova_domain *iovad);
>>>   static void fq_destroy_all_entries(struct iova_domain *iovad);
>>>   static void fq_flush_timeout(struct timer_list *t);
>>> +static void free_global_cached_iovas(struct iova_domain *iovad);
> 
> a thought: It would be great if the file could be rearranged at some 
> point where we don't require so many forward declarations.
> 
>>>   void
>>>   init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>>> @@ -442,6 +443,7 @@ alloc_iova_fast(struct iova_domain *iovad, 
>>> unsigned long size,
>>>           flush_rcache = false;
>>>           for_each_online_cpu(cpu)
>>>               free_cpu_cached_iovas(cpu, iovad);
>>> +        free_global_cached_iovas(iovad);
>>>           goto retry;
>>>       }
>>> @@ -1057,5 +1059,26 @@ void free_cpu_cached_iovas(unsigned int cpu, 
>>> struct iova_domain *iovad)
>>>       }
>>>   }
>>> +/*
>>> + * free all the IOVA ranges of global cache
>>> + */
>>> +static void free_global_cached_iovas(struct iova_domain *iovad)
>>> +{
>>> +    struct iova_rcache *rcache;
>>> +    unsigned long flags;
>>> +    int i, j;
>>> +
>>> +    for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>>> +        rcache = &iovad->rcaches[i];
>>> +        spin_lock_irqsave(&rcache->lock, flags);
>>> +        for (j = 0; j < rcache->depot_size; ++j) {
>>> +            iova_magazine_free_pfns(rcache->depot[j], iovad);
>>> +            iova_magazine_free(rcache->depot[j]);
>>> +            rcache->depot[j] = NULL;
> 
> I don't think that NULLify is strictly necessary

True, we don't explicitly clear depot entries in __iova_rcache_get() for 
normal operation, so there's not much point in doing so here.

Robin.

>>> +        }
>>> +        rcache->depot_size = 0;
>>> +        spin_unlock_irqrestore(&rcache->lock, flags);
>>> +    }
>>> +}
>>>   MODULE_AUTHOR("Anil S Keshavamurthy 
>>> <anil.s.keshavamurthy@intel.com>");
>>>   MODULE_LICENSE("GPL");
>>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>> .
> 
