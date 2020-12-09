Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7D12D4144
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgLILk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:40:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2232 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbgLILk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:40:56 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CrZlC2ygLz67Nq7;
        Wed,  9 Dec 2020 19:36:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 12:40:14 +0100
Received: from [10.210.171.175] (10.210.171.175) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 11:40:13 +0000
Subject: Re: [RESEND PATCH v3 2/4] iommu/iova: Avoid double-negatives in
 magazine helpers
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <1605608734-84416-3-git-send-email-john.garry@huawei.com>
 <7eb70f4b-b050-24ca-f1fa-d8f3c9ddce65@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7dfee7b0-0d51-b342-5318-09470c56f0d9@huawei.com>
Date:   Wed, 9 Dec 2020 11:39:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <7eb70f4b-b050-24ca-f1fa-d8f3c9ddce65@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.175]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2020 09:03, Leizhen (ThunderTown) wrote:
> 
> 
> On 2020/11/17 18:25, John Garry wrote:
>> A similar crash to the following could be observed if initial CPU rcache
>> magazine allocations fail in init_iova_rcaches():
>>
>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>> Mem abort info:
>>     ESR = 0x96000004
>>     EC = 0x25: DABT (current EL), IL = 32 bits
>>     SET = 0, FnV = 0
>>     EA = 0, S1PTW = 0
>> Data abort info:
>>     ISV = 0, ISS = 0x00000004
>>     CM = 0, WnR = 0
>> [0000000000000000] user address but active_mm is swapper
>> Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 11 PID: 696 Comm: irq/40-hisi_sas Not tainted 5.9.0-rc7-dirty #109
>> Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 - V1.16.01 03/15/2019
>> Call trace:
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
>> Code: f9400060 f102001f 54000981 d4210000 (f9400043)
>>
>>   ---[ end trace 4afcbdfc61b60467 ]---
>>
>> The issue is that expression !iova_magazine_full(NULL) evaluates true; this
>> falls over in in __iova_rcache_insert() when we attempt to cache a mag
>> and cpu_rcache->loaded == NULL:
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

Thanks for checking here...

>> ---
>>   drivers/iommu/iova.c | 29 +++++++++++++++++------------
>>   1 file changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 81b7399dd5e8..1f3f0f8b12e0 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -827,14 +827,18 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
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
>> @@ -843,7 +847,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>>   	int i;
>>   	unsigned long pfn;
>>   
>> -	BUG_ON(iova_magazine_empty(mag));
>> +	BUG_ON(!iova_magazine_has_pfns(mag));
>>   
>>   	/* Only fall back to the rbtree if we have no suitable pfns at all */
>>   	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
>> @@ -859,7 +863,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>>   
>>   static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>>   {
>> -	BUG_ON(iova_magazine_full(mag));
>> +	BUG_ON(!iova_magazine_has_space(mag));
>>   
>>   	mag->pfns[mag->size++] = pfn;
>>   }
>> @@ -905,9 +909,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>   	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
>>   	spin_lock_irqsave(&cpu_rcache->lock, flags);
>>   
>> -	if (!iova_magazine_full(cpu_rcache->loaded)) {

*

>> +	if (iova_magazine_has_space(cpu_rcache->loaded)) {
>>   		can_insert = true;
>> -	} else if (!iova_magazine_full(cpu_rcache->prev)) {
>> +	} else if (iova_magazine_has_space(cpu_rcache->prev)) {
>>   		swap(cpu_rcache->prev, cpu_rcache->loaded);
>>   		can_insert = true;
>>   	} else {
>> @@ -916,8 +920,9 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>   		if (new_mag) {
>>   			spin_lock(&rcache->lock);
>>   			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
>> -				rcache->depot[rcache->depot_size++] =
>> -						cpu_rcache->loaded;
>> +				if (cpu_rcache->loaded)
> 
> Looks like it just needs to change this place. Compiler ensures that mag->size
> will not be accessed when mag is NULL.

Not sure about that. We would get a crash prior to touching this codepath:

So if cpu_rcache->loaded == NULL at entry, then 
!iova_magazine_full(cpu_rcache->loaded (==NULL) ) evaluates true, * 
above, so can_insert is set true, and we then attempt 
iova_magazine_push(cpu_rcache->loaded (==NULL), iova_pfn), which is not 
safe.

ok?

Cheers,
John

> 
> static bool iova_magazine_full(struct iova_magazine *mag)
> {
>          return (mag && mag->size == IOVA_MAG_SIZE);
> }
> 
> static bool iova_magazine_empty(struct iova_magazine *mag)
> {
>          return (!mag || mag->size == 0);
> }
> 




> 
>> +					rcache->depot[rcache->depot_size++] =
>> +							cpu_rcache->loaded;
>>   			} else {
>>   				mag_to_free = cpu_rcache->loaded;
>>   			}
>> @@ -968,9 +973,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
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
>>
> 

