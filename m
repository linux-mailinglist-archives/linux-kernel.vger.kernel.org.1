Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771F42F9CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbhARKMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:12:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2362 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389189AbhARJo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:44:57 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DK5pw2p2mz67bl2;
        Mon, 18 Jan 2021 17:20:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 18 Jan 2021 10:25:31 +0100
Received: from [10.47.11.164] (10.47.11.164) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 18 Jan
 2021 09:25:30 +0000
Subject: Re: [PATCH v4 2/3] iommu/iova: Avoid double-negatives in magazine
 helpers
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <joro@8bytes.org>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <iommu@lists.linux-foundation.org>, <robin.murphy@arm.com>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-3-git-send-email-john.garry@huawei.com>
 <YAHRKCkcHAEUdRNT@larix.localdomain>
From:   John Garry <john.garry@huawei.com>
Message-ID: <69c30e85-4a72-a0e1-1e56-4ffbd0df5aba@huawei.com>
Date:   Mon, 18 Jan 2021 09:24:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YAHRKCkcHAEUdRNT@larix.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.164]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2021 17:30, Jean-Philippe Brucker wrote:
> On Thu, Dec 10, 2020 at 02:23:08AM +0800, John Garry wrote:
>> A similar crash to the following could be observed if initial CPU rcache
>> magazine allocations fail in init_iova_rcaches():
> 

thanks for having a look

> Any idea why that's happening?  This fix seems ok but if we're expecting
> allocation failures for the loaded magazine then we could easily get it
> for cpu_rcaches too, and get a similar abort at runtime.

It's not specifically that we expect them (allocation failures for the 
loaded magazine), rather we should make safe against it.

So could you be more specific in your concern for the cpu_rcache 
failure? cpu_rcache magazine assignment comes from this logic.

Anyway, logic like "if not full" or "if not empty" is poor as the 
outcome for NULL is ambiguous (maybe there's a better word) and the code 
is not safe against it, and so I replace with "if space" or "if have an 
IOVA", respectively.

Thanks,
John

> 
> Thanks,
> Jean
> 
>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>> Mem abort info:
>>
>>    free_iova_fast+0xfc/0x280
>>    iommu_dma_free_iova+0x64/0x70
>>    __iommu_dma_unmap+0x9c/0xf8
>>    iommu_dma_unmap_sg+0xa8/0xc8
>>    dma_unmap_sg_attrs+0x28/0x50
>>    cq_thread_v3_hw+0x2dc/0x528
>>    irq_thread_fn+0x2c/0xa0
>>    irq_thread+0x130/0x1e0
>>    kthread+0x154/0x158
>>    ret_from_fork+0x10/0x34
>>
>> The issue is that expression !iova_magazine_full(NULL) evaluates true; this
>> falls over in __iova_rcache_insert() when we attempt to cache a mag and
>> cpu_rcache->loaded == NULL:
>>
>> if (!iova_magazine_full(cpu_rcache->loaded)) {
>> 	can_insert = true;
>> ...
>>
>> if (can_insert)
>> 	iova_magazine_push(cpu_rcache->loaded, iova_pfn);
>>
>> As above, can_insert is evaluated true, which it shouldn't be, and we try
>> to insert pfns in a NULL mag, which is not safe.
>>
>> To avoid this, stop using double-negatives, like !iova_magazine_full() and
>> !iova_magazine_empty(), and use positive tests, like
>> iova_magazine_has_space() and iova_magazine_has_pfns(), respectively; these
>> can safely deal with cpu_rcache->{loaded, prev} = NULL.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
>> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
>> ---
>>   drivers/iommu/iova.c | 29 +++++++++++++++++------------
>>   1 file changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index cf1aacda2fe4..732ee687e0e2 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -767,14 +767,18 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>>   	mag->size = 0;
>>   }
>>   
>> -static bool iova_magazine_full(struct iova_magazine *mag)
>> +static bool iova_magazine_has_space(struct iova_magazine *mag)
>>   {
>> -	return (mag && mag->size == IOVA_MAG_SIZE);
>> +	if (!mag)
>> +		return false;
>> +	return mag->size < IOVA_MAG_SIZE;
>>   }
>>   
>> -static bool iova_magazine_empty(struct iova_magazine *mag)
>> +static bool iova_magazine_has_pfns(struct iova_magazine *mag)
>>   {
>> -	return (!mag || mag->size == 0);
>> +	if (!mag)
>> +		return false;
>> +	return mag->size;
>>   }
>>   
>>   static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>> @@ -783,7 +787,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>>   	int i;
>>   	unsigned long pfn;
>>   
>> -	BUG_ON(iova_magazine_empty(mag));
>> +	BUG_ON(!iova_magazine_has_pfns(mag));
>>   
>>   	/* Only fall back to the rbtree if we have no suitable pfns at all */
>>   	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
>> @@ -799,7 +803,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>>   
>>   static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>>   {
>> -	BUG_ON(iova_magazine_full(mag));
>> +	BUG_ON(!iova_magazine_has_space(mag));
>>   
>>   	mag->pfns[mag->size++] = pfn;
>>   }
>> @@ -845,9 +849,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>   	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
>>   	spin_lock_irqsave(&cpu_rcache->lock, flags);
>>   
>> -	if (!iova_magazine_full(cpu_rcache->loaded)) {
>> +	if (iova_magazine_has_space(cpu_rcache->loaded)) {
>>   		can_insert = true;
>> -	} else if (!iova_magazine_full(cpu_rcache->prev)) {
>> +	} else if (iova_magazine_has_space(cpu_rcache->prev)) {
>>   		swap(cpu_rcache->prev, cpu_rcache->loaded);
>>   		can_insert = true;
>>   	} else {
>> @@ -856,8 +860,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>   		if (new_mag) {
>>   			spin_lock(&rcache->lock);
>>   			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
>> -				rcache->depot[rcache->depot_size++] =
>> -						cpu_rcache->loaded;
>> +				if (cpu_rcache->loaded)
>> +					rcache->depot[rcache->depot_size++] =
>> +							cpu_rcache->loaded;
>>   			} else {
>>   				mag_to_free = cpu_rcache->loaded;
>>   			}
>> @@ -908,9 +913,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
>>   	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
>>   	spin_lock_irqsave(&cpu_rcache->lock, flags);
>>   
>> -	if (!iova_magazine_empty(cpu_rcache->loaded)) {
>> +	if (iova_magazine_has_pfns(cpu_rcache->loaded)) {
>>   		has_pfn = true;
>> -	} else if (!iova_magazine_empty(cpu_rcache->prev)) {
>> +	} else if (iova_magazine_has_pfns(cpu_rcache->prev)) {
>>   		swap(cpu_rcache->prev, cpu_rcache->loaded);
>>   		has_pfn = true;
>>   	} else {
>> -- 
>> 2.26.2
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> .
> 

