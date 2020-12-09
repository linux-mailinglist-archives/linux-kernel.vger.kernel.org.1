Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C362D4107
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgLILYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:24:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2230 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbgLILYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:24:04 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CrZMj2kzKz67Nq4;
        Wed,  9 Dec 2020 19:20:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 12:23:20 +0100
Received: from [10.210.171.175] (10.210.171.175) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 11:23:19 +0000
Subject: Re: [RESEND PATCH v3 3/4] iommu/iova: Flush CPU rcache for when a
 depot fills
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <xiyou.wangcong@gmail.com>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <1605608734-84416-4-git-send-email-john.garry@huawei.com>
 <76e057e3-9db8-21fc-3a8a-b9e924a95cf4@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <851ba6cf-8f4c-74dc-3666-ee6d547999d3@huawei.com>
Date:   Wed, 9 Dec 2020 11:22:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <76e057e3-9db8-21fc-3a8a-b9e924a95cf4@huawei.com>
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

On 09/12/2020 09:13, Leizhen (ThunderTown) wrote:
> 
> 
> On 2020/11/17 18:25, John Garry wrote:
>> Leizhen reported some time ago that IOVA performance may degrade over time
>> [0], but unfortunately his solution to fix this problem was not given
>> attention.
>>
>> To summarize, the issue is that as time goes by, the CPU rcache and depot
>> rcache continue to grow. As such, IOVA RB tree access time also continues
>> to grow.
>>
>> At a certain point, a depot may become full, and also some CPU rcaches may
>> also be full when inserting another IOVA is attempted. For this scenario,
>> currently the "loaded" CPU rcache is freed and a new one is created. This
>> freeing means that many IOVAs in the RB tree need to be freed, which
>> makes IO throughput performance fall off a cliff in some storage scenarios:
>>
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6314MB/0KB/0KB /s] [1616K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [5669MB/0KB/0KB /s] [1451K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6031MB/0KB/0KB /s] [1544K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6673MB/0KB/0KB /s] [1708K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6705MB/0KB/0KB /s] [1717K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6031MB/0KB/0KB /s] [1544K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6761MB/0KB/0KB /s] [1731K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6705MB/0KB/0KB /s] [1717K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6685MB/0KB/0KB /s] [1711K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6178MB/0KB/0KB /s] [1582K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6731MB/0KB/0KB /s] [1723K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2387MB/0KB/0KB /s] [611K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2689MB/0KB/0KB /s] [688K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2278MB/0KB/0KB /s] [583K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1288MB/0KB/0KB /s] [330K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1632MB/0KB/0KB /s] [418K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1765MB/0KB/0KB /s] [452K/0/0 iops]
>>
>> And continue in this fashion, without recovering. Note that in this
>> example it was required to wait 16 hours for this to occur. Also note that
>> IO throughput also becomes gradually becomes more unstable leading up to
>> this point.
>>
>> This problem is only seen for non-strict mode. For strict mode, the rcaches
>> stay quite compact.
>>
>> As a solution to this issue, judge that the IOVA caches have grown too big
>> when cached magazines need to be free, and just flush all the CPUs rcaches
>> instead.
>>
>> The depot rcaches, however, are not flushed, as they can be used to
>> immediately replenish active CPUs.
>>
>> In future, some IOVA compaction could be implemented to solve the
>> instabilty issue, which I figure could be quite complex to implement.
>>
>> [0] https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/
>>
>> Analyzed-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>

Thanks for having a look

>> ---
>>   drivers/iommu/iova.c | 16 ++++++----------
>>   1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 1f3f0f8b12e0..386005055aca 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -901,7 +901,6 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>   				 struct iova_rcache *rcache,
>>   				 unsigned long iova_pfn)
>>   {
>> -	struct iova_magazine *mag_to_free = NULL;
>>   	struct iova_cpu_rcache *cpu_rcache;
>>   	bool can_insert = false;
>>   	unsigned long flags;
>> @@ -923,13 +922,12 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>   				if (cpu_rcache->loaded)
>>   					rcache->depot[rcache->depot_size++] =
>>   							cpu_rcache->loaded;
>> -			} else {
>> -				mag_to_free = cpu_rcache->loaded;
>> +				can_insert = true;
>> +				cpu_rcache->loaded = new_mag;
>>   			}
>>   			spin_unlock(&rcache->lock);
>> -
>> -			cpu_rcache->loaded = new_mag;
>> -			can_insert = true;
>> +			if (!can_insert)
>> +				iova_magazine_free(new_mag);
>>   		}
>>   	}
>>   
>> @@ -938,10 +936,8 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>   
>>   	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>>   
>> -	if (mag_to_free) {
>> -		iova_magazine_free_pfns(mag_to_free, iovad);
>> -		iova_magazine_free(mag_to_free);
> mag_to_free has been stripped out, that's why lock protection is not required here.
> 
>> -	}
>> +	if (!can_insert)
>> +		free_all_cpu_cached_iovas(iovad);
> Lock protection required.

But we have the per-CPU rcache locking again in free_cpu_cached_iovas() 
(which is called per-CPU from free_all_cpu_cached_iovas()).

ok? Or some other lock you mean?

Cheers,
John

> 
>>   
>>   	return can_insert;
>>   }
>>
> 
> .
> 

