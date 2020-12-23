Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F69F2E1B50
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgLWLB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:01:27 -0500
Received: from foss.arm.com ([217.140.110.172]:48702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbgLWLB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:01:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C09CE101E;
        Wed, 23 Dec 2020 03:00:40 -0800 (PST)
Received: from [10.57.34.90] (unknown [10.57.34.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3889E3F6CF;
        Wed, 23 Dec 2020 03:00:38 -0800 (PST)
Subject: Re: [PATCH v3 6/7] iommu/mediatek: Gather iova in iommu_unmap to
 achieve tlb sync once
To:     Tomasz Figa <tfiga@chromium.org>, Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        youlin.pei@mediatek.com, anan.sun@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chao.hao@mediatek.com,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-7-yong.wu@mediatek.com> <X+MGKBYKdmPNz7VL@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1de76b46-d9c1-4011-c087-1df236f442c3@arm.com>
Date:   Wed, 23 Dec 2020 11:00:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X+MGKBYKdmPNz7VL@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-23 08:56, Tomasz Figa wrote:
> On Wed, Dec 16, 2020 at 06:36:06PM +0800, Yong Wu wrote:
>> In current iommu_unmap, this code is:
>>
>> 	iommu_iotlb_gather_init(&iotlb_gather);
>> 	ret = __iommu_unmap(domain, iova, size, &iotlb_gather);
>> 	iommu_iotlb_sync(domain, &iotlb_gather);
>>
>> We could gather the whole iova range in __iommu_unmap, and then do tlb
>> synchronization in the iommu_iotlb_sync.
>>
>> This patch implement this, Gather the range in mtk_iommu_unmap.
>> then iommu_iotlb_sync call tlb synchronization for the gathered iova range.
>> we don't call iommu_iotlb_gather_add_page since our tlb synchronization
>> could be regardless of granule size.
>>
>> In this way, gather->start is impossible ULONG_MAX, remove the checking.
>>
>> This patch aims to do tlb synchronization *once* in the iommu_unmap.
>>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>> ---
>>   drivers/iommu/mtk_iommu.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index db7d43adb06b..89cec51405cd 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -506,7 +506,12 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
>>   			      struct iommu_iotlb_gather *gather)
>>   {
>>   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>> +	unsigned long long end = iova + size;
>>   
>> +	if (gather->start > iova)
>> +		gather->start = iova;
>> +	if (gather->end < end)
>> +		gather->end = end;
> 
> I don't know how common the case is, but what happens if
> gather->start...gather->end is a disjoint range from iova...end? E.g.
> 
>   | gather      | ..XXX... | iova |
>   |             |          |      |
>   gather->start |          iova   |
>                 gather->end       end
> 
> We would also end up invalidating the TLB for the XXX area, which could
> affect the performance.

Take a closer look at iommu_unmap() - the gather data is scoped to each 
individual call, so that can't possibly happen.

> Also, why is the existing code in __arm_v7s_unmap() not enough? It seems
> to call io_pgtable_tlb_add_page() already, so it should be batching the
> flushes.

Because if we leave io-pgtable in charge of maintenance it will also 
inject additional invalidations and syncs for the sake of strictly 
correct walk cache maintenance. Apparently we can get away without that 
on this hardware, so the fundamental purpose of this series is to 
sidestep it.

It's proven to be cleaner overall to devolve this kind of "non-standard" 
TLB maintenance back to drivers rather than try to cram yet more 
special-case complexity into io-pgtable itself. I'm planning to clean up 
the remains of the TLBI_ON_MAP quirk entirely after this.

Robin.

>>   	return dom->iop->unmap(dom->iop, iova, size, gather);
>>   }
>>   
>> @@ -523,9 +528,6 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>>   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>>   	size_t length = gather->end - gather->start;
>>   
>> -	if (gather->start == ULONG_MAX)
>> -		return;
>> -
>>   	mtk_iommu_tlb_flush_range_sync(gather->start, length, gather->pgsize,
>>   				       dom->data);
>>   }
>> -- 
>> 2.18.0
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
