Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA0A2A4838
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgKCOcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:32:21 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729286AbgKCObY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:31:24 -0500
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id BF3F4A1754057E9ACDF6;
        Tue,  3 Nov 2020 14:31:23 +0000 (GMT)
Received: from [10.47.5.37] (10.47.5.37) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 3 Nov 2020
 14:31:23 +0000
Subject: Re: [PATCH v5 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To:     Robin Murphy <robin.murphy@arm.com>, <vjitta@codeaurora.org>,
        <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vinmenon@codeaurora.org>, <kernel-team@android.com>
References: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
 <1601451864-5956-2-git-send-email-vjitta@codeaurora.org>
 <ff318311-77e8-b235-37dd-7b1b5f5d8ed9@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e1e5b24a-512b-7279-8341-7f4495718ece@huawei.com>
Date:   Tue, 3 Nov 2020 14:31:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <ff318311-77e8-b235-37dd-7b1b5f5d8ed9@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.5.37]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2020 12:35, Robin Murphy wrote:
> On 2020-09-30 08:44, vjitta@codeaurora.org wrote:
>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>>
>> When ever an iova alloc request fails we free the iova
>> ranges present in the percpu iova rcaches and then retry
>> but the global iova rcache is not freed as a result we could
>> still see iova alloc failure even after retry as global
>> rcache is holding the iova's which can cause fragmentation.
>> So, free the global iova rcache as well and then go for the
>> retry.
> 

If we do clear all the CPU rcaches, it would nice to have something 
immediately available to replenish, i.e. use the global rcache, instead 
of flushing it, if that is not required...

> This looks reasonable to me - it's mildly annoying that we end up with 
> so many similar-looking functions,

Well I did add a function to clear all CPU rcaches here, if you would 
like to check:

https://lore.kernel.org/linux-iommu/1603733501-211004-2-git-send-email-john.garry@huawei.com/

> but the necessary differences are 
> right down in the middle of the loops so nothing can reasonably be 
> factored out :(
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>> ---
>>   drivers/iommu/iova.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index c3a1a8e..faf9b13 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -25,6 +25,7 @@ static void init_iova_rcaches(struct iova_domain 
>> *iovad);
>>   static void free_iova_rcaches(struct iova_domain *iovad);
>>   static void fq_destroy_all_entries(struct iova_domain *iovad);
>>   static void fq_flush_timeout(struct timer_list *t);
>> +static void free_global_cached_iovas(struct iova_domain *iovad);

a thought: It would be great if the file could be rearranged at some 
point where we don't require so many forward declarations.

>>   void
>>   init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>> @@ -442,6 +443,7 @@ alloc_iova_fast(struct iova_domain *iovad, 
>> unsigned long size,
>>           flush_rcache = false;
>>           for_each_online_cpu(cpu)
>>               free_cpu_cached_iovas(cpu, iovad);
>> +        free_global_cached_iovas(iovad);
>>           goto retry;
>>       }
>> @@ -1057,5 +1059,26 @@ void free_cpu_cached_iovas(unsigned int cpu, 
>> struct iova_domain *iovad)
>>       }
>>   }
>> +/*
>> + * free all the IOVA ranges of global cache
>> + */
>> +static void free_global_cached_iovas(struct iova_domain *iovad)
>> +{
>> +    struct iova_rcache *rcache;
>> +    unsigned long flags;
>> +    int i, j;
>> +
>> +    for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>> +        rcache = &iovad->rcaches[i];
>> +        spin_lock_irqsave(&rcache->lock, flags);
>> +        for (j = 0; j < rcache->depot_size; ++j) {
>> +            iova_magazine_free_pfns(rcache->depot[j], iovad);
>> +            iova_magazine_free(rcache->depot[j]);
>> +            rcache->depot[j] = NULL;

I don't think that NULLify is strictly necessary

>> +        }
>> +        rcache->depot_size = 0;
>> +        spin_unlock_irqrestore(&rcache->lock, flags);
>> +    }
>> +}
>>   MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
>>   MODULE_LICENSE("GPL");
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> .

