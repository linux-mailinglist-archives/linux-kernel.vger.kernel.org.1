Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E8A203AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 17:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgFVPa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 11:30:59 -0400
Received: from foss.arm.com ([217.140.110.172]:44858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbgFVPa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:30:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA49C31B;
        Mon, 22 Jun 2020 08:30:48 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4B6A3F6CF;
        Mon, 22 Jun 2020 08:30:46 -0700 (PDT)
Subject: Re: kernel BUG at mm/huge_memory.c:2613!
To:     Joerg Roedel <joro@8bytes.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Will Deacon <will@kernel.org>
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
 <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
 <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
 <20200619024026.GB21081@redhat.com> <20200622124646.GI3701@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e31308f7-4e3c-b6bc-7201-3861b062d257@arm.com>
Date:   Mon, 22 Jun 2020 16:30:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622124646.GI3701@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22 13:46, Joerg Roedel wrote:
> + Robin
> 
> Robin, any idea on this?

After a bit of archaeology, this dates back to the original review:

https://lore.kernel.org/linux-arm-kernel/54C285D4.3070802@arm.com/
https://lore.kernel.org/linux-arm-kernel/54DA2666.9030003@arm.com/

In summary: originally this inherited from other arch code that did 
simply strip __GFP_COMP; that was deemed questionable because of the 
nonsensical comment about CONFIG_HUGETLBFS that was stuck to it; the 
current code is like it is because in 5 and a half years nobody said 
that it's wrong :)

If there actually *are* good reasons for stripping __GFP_COMP, then I've 
certainly no objection to doing so.

Robin.

> On Thu, Jun 18, 2020 at 10:40:26PM -0400, Andrea Arcangeli wrote:
>> Hello,
>>
>> On Thu, Jun 18, 2020 at 06:14:49PM -0700, Roman Gushchin wrote:
>>> I agree. The whole
>>>
>>> 	page = alloc_pages_node(nid, alloc_flags, order);
>>> 	if (!page)
>>> 		continue;
>>> 	if (!order)
>>> 		break;
>>> 	if (!PageCompound(page)) {
>>> 		split_page(page, order);
>>> 		break;
>>> 	} else if (!split_huge_page(page)) {
>>> 		break;
>>> 	}
>>>
>>> looks very suspicious to me.
>>> My wild guess is that gfp flags changed somewhere above, so we hit
>>> the branch which was never hit before.
>>
>> Right to be suspicious about the above: split_huge_page on a regular
>> page allocated by a driver was never meant to work.
>>
>> The PageLocked BUG_ON is just a symptom of a bigger issue, basically
>> split_huge_page it may survive, but it'll stay compound and in turn it
>> must be freed as compound.
>>
>> The respective free method doesn't even contemplate freeing compound
>> pages, the only way the free method can survive, is by removing
>> __GFP_COMP forcefully in the allocation that was perhaps set here
>> (there are that many __GFP_COMP in that directory):
>>
>> static void snd_malloc_dev_pages(struct snd_dma_buffer *dmab, size_t size)
>> {
>> 	gfp_t gfp_flags;
>>
>> 	gfp_flags = GFP_KERNEL
>> 		| __GFP_COMP	/* compound page lets parts be mapped */
>>
>> And I'm not sure what the comment means here, compound or non compound
>> doesn't make a difference when you map it, it's not a THP, the
>> mappings must be handled manually so nothing should check PG_compound
>> anyway in the mapping code.
>>
>> Something like this may improve things, it's an untested quick hack,
>> but this assumes it's always a bug to setup a compound page for these
>> DMA allocations and given the API it's probably a correct
>> assumption.. Compound is slower, unless you need it, you can avoid it
>> and then split_page will give contiguous memory page granular. Ideally
>> the code shouldn't call split_page at all and it should free it all at
>> once by keeping track of the order and by returning the order to the
>> caller, something the API can't do right now as it returns a plain
>> array that can only represent individual small pages.
>>
>> Once this is resolved, you may want to check your config, iommu passthrough
>> sounds more optimal for a soundcard.
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index f68a62c3c32b..3dfbc010fa83 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -499,6 +499,10 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>>   
>>   	/* IOMMU can map any pages, so himem can also be used here */
>>   	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>> +	if (unlikely(gfp & __GFP_COMP)) {
>> +		WARN();
>> +		gfp &= ~__GFP_COMP;
>> +	}
>>   
>>   	while (count) {
>>   		struct page *page = NULL;
>> @@ -522,13 +526,8 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>>   				continue;
>>   			if (!order)
>>   				break;
>> -			if (!PageCompound(page)) {
>> -				split_page(page, order);
>> -				break;
>> -			} else if (!split_huge_page(page)) {
>> -				break;
>> -			}
>> -			__free_pages(page, order);
>> +			split_page(page, order);
>> +			break;
>>   		}
>>   		if (!page) {
>>   			__iommu_dma_free_pages(pages, i);
>> diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
>> index 6850d13aa98c..378f5a36ec5f 100644
>> --- a/sound/core/memalloc.c
>> +++ b/sound/core/memalloc.c
>> @@ -28,7 +28,6 @@ static void snd_malloc_dev_pages(struct snd_dma_buffer *dmab, size_t size)
>>   	gfp_t gfp_flags;
>>   
>>   	gfp_flags = GFP_KERNEL
>> -		| __GFP_COMP	/* compound page lets parts be mapped */
>>   		| __GFP_NORETRY /* don't trigger OOM-killer */
>>   		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
>>   	dmab->area = dma_alloc_coherent(dmab->dev.dev, size, &dmab->addr,
