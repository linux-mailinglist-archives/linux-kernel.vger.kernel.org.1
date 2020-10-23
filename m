Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78ED4297335
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbgJWQHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:07:40 -0400
Received: from foss.arm.com ([217.140.110.172]:55880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbgJWQHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:07:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58AC4113E;
        Fri, 23 Oct 2020 09:07:39 -0700 (PDT)
Received: from [10.57.50.191] (unknown [10.57.50.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBD583F66E;
        Fri, 23 Oct 2020 09:07:37 -0700 (PDT)
Subject: Re: [PATCH 2/4] iommu/mediatek: Add iotlb_sync_range() support
To:     chao hao <Chao.Hao@mediatek.com>
Cc:     Jun Wen <jun.wen@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mingyuan Ma <mingyuan.ma@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
References: <20201019113100.23661-1-chao.hao@mediatek.com>
 <20201019113100.23661-3-chao.hao@mediatek.com>
 <7fbe0305-91e4-949e-7d84-bf91e81d6b27@arm.com>
 <1603432677.2024.3.camel@mbjsdccf07>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <08e68c76-8ecc-8961-f694-8823268c269a@arm.com>
Date:   Fri, 23 Oct 2020 17:07:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <1603432677.2024.3.camel@mbjsdccf07>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-23 06:57, chao hao wrote:
> On Wed, 2020-10-21 at 17:55 +0100, Robin Murphy wrote:
>> On 2020-10-19 12:30, Chao Hao wrote:
>>> MTK_IOMMU driver writes one page entry and does tlb flush at a time
>>> currently. More optimal would be to aggregate the writes and flush
>>> BUS buffer in the end.
>>
>> That's exactly what iommu_iotlb_gather_add_page() is meant to achieve.
>> Rather than jumping straight into hacking up a new API to go round the
>> back of the existing API design, it would be far better to ask the
>> question of why that's not behaving as expected.
> 
> Thanks for you review!
> 
> iommu_iotlb_gather_add_page is put in io_pgtable_tlb_add_page().
> io_pgtable_tlb_add_page() only be called in
> unmapping and mapping flow doesn't have it in linux iommu driver, but
> mtk iommu needs to do tlb sync in mapping
> and unmapping to avoid old data being in the iommu tlb.

Right, as I suspected, if it's primarily about the map path then the 
answer is to use the existing API intended to accommodate that specific 
case; if that API doesn't quite do what you need, then just fix it! It 
doesn't make sense to clutter up the IOMMU core with multiple 
overlapping APIs for TLB invalidation, especially when TLB invalidation 
ultimately isn't all that complicated.

> In addtion, we hope to do tlb sync once when all the pages mapping done.
> iommu_iotlb_gather_add_page maybe do
> tlb sync more than once. because one whole buffer consists of different
> page size(1MB/64K/4K).

So if your hardware doesn't care about the granule size used for 
invalidation matching the underlying mapping, use an implementation of 
iommu_flush_ops::tlb_add_page that doesn't care about the granule size!

> Based on the previous considerations,  don't find more appropriate the
> way of tlb sync for mtk iommu, so we add a new API.

I know I'm probably more familiar with this code than most people, but 
from my perspective, this reads like "my car was dirty, so I had to buy 
a new car" ;)

>>> For 50MB buffer mapping, if mtk_iommu driver use iotlb_sync_range()
>>> instead of tlb_add_range() and tlb_flush_walk/leaf(), it can increase
>>> 50% performance or more(depending on size of every page size) in
>>> comparison to flushing after each page entry update. So we prefer to
>>> use iotlb_sync_range() to replace iotlb_sync(), tlb_add_range() and
>>> tlb_flush_walk/leaf() for MTK platforms.
>>
>> In the case of mapping, it sounds like what you actually want to do is
>> hook up .iotlb_sync_map and generally make IO_PGTABLE_QUIRK_TLBI_ON_MAP
>> cleverer, because the current implementation is as dumb as it could
>> possibly be.
> 
> iotlb_sync_map only has one parameter(iommu_domain), but mtk
> iommu_domain maybe include the whole iova space, if mtk_iommu to do tlb
> sync based on iommu_domain, it is equivalent to do tlb flush all in
> fact.

The first, and so far only, user of this API is the Tegra GART, which 
can only do a "flush all" operation, so the API is currently only as 
complex as it needs to be, which is to say "not very". There are plenty 
of options.

> iommu driver will do tlb sync in every mapping page when mtk iommu sets
> IO_PGTABLE_QUIRK_TLBI_ON_MAP(io_pgtable_tlb_flush_walk),
> as is the commit message mentioned, it will drop mapping performance in
> mtk platform.

And as I said, that quirk is implemented in a really simplistic way, 
which is sure to be functionally correct, but has never been given any 
performance consideration.

>> In fact if we simply passed an address range to
>> .iotlb_sync_map, io-pgtable probably wouldn't need to be involved at all
>> any more.
> 
> I know it is not a good idea probably by adding a new api, but I found
> out that tlb sync only to be done after mapping one page, so if
> mtk_iommu hope to do tlb sync once after all the pages map done, could
> you give me some advices? thanks!

Getting rid of IO_PGTABLE_QUIRK_TLBI_ON_MAP and simply wiring 
.iotlb_sync_map to .flush_iotlb_all is certainly the easiest way to make 
.map quicker, although it will obviously have *some* impact on any other 
live mappings. Given that in principle this should have the least CPU 
overhead, then depending on TLB usage patterns there's a small chance it 
might actually work out as a reasonable tradeoff, so I wouldn't 
necessarily rule it out as a viable option without at least trying some 
tests.

If it's cheap to *issue* invalidation commands, and the expense is in 
waiting for them to actually complete, then you could still fire off an 
invalidate for each page from .map, then wire up the sync (wait) step to 
.iotlb_sync_map, still without needing any core changes.

Otherwise, it would seem reasonable to pass the complete address and 
size of the iommu_map() operation to .iotlb_sync_map, so drivers can 
perform their whole invalidation operation synchronously there.

What I *don't* think makes sense is to try passing a gather structure 
through .map in the same way as for .unmap. That seems a bit too 
invasive for what is still a fairly exceptional case, and half the stuff 
that unmap operations will use the gather data for - freelists and such 
- won't ever be relevant to map operations, so symmetry isn't really an 
argument either.

Robin.

>>> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
>>> ---
>>>    drivers/iommu/mtk_iommu.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index 785b228d39a6..d3400c15ff7b 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -224,6 +224,11 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>>>    	}
>>>    }
>>>    
>>> +static void __mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size)
>>> +{
>>> +	mtk_iommu_tlb_flush_range_sync(iova, size, 0, NULL)
>>> +}
>>> +
>>>    static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
>>>    					    unsigned long iova, size_t granule,
>>>    					    void *cookie)
>>> @@ -536,6 +541,7 @@ static const struct iommu_ops mtk_iommu_ops = {
>>>    	.map		= mtk_iommu_map,
>>>    	.unmap		= mtk_iommu_unmap,
>>>    	.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
>>> +	.iotlb_sync_range = __mtk_iommu_tlb_flush_range_sync,
>>>    	.iotlb_sync	= mtk_iommu_iotlb_sync,
>>>    	.iova_to_phys	= mtk_iommu_iova_to_phys,
>>>    	.probe_device	= mtk_iommu_probe_device,
>>>
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
