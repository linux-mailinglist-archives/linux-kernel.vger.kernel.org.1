Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA62F20FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390879AbhAKUkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:40:25 -0500
Received: from foss.arm.com ([217.140.110.172]:36038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730464AbhAKUkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:40:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1B9A101E;
        Mon, 11 Jan 2021 12:39:38 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADDC73F66E;
        Mon, 11 Jan 2021 12:39:37 -0800 (PST)
Subject: Re: [PATCH] dma: mark unmapped DMA scatter/gather invalid
To:     Marc Orr <marcorr@google.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        Jianxiong Gao <jxgao@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210111154335.23388-1-marcorr@google.com>
 <dc6db6b4-88f1-4762-bd3b-edf3dd410366@arm.com>
 <CAA03e5HLN_iPzXRTJ_Dvx5h8KP-Qi+=6u+9mHnaoB9oBMMWs7Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bbf6f07c-369b-e470-78ff-815cfb4dbf92@arm.com>
Date:   Mon, 11 Jan 2021 20:39:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAA03e5HLN_iPzXRTJ_Dvx5h8KP-Qi+=6u+9mHnaoB9oBMMWs7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-11 18:03, Marc Orr wrote:
>> On 2021-01-11 15:43, Marc Orr wrote:
> 
> minus stable@vger.kernel.org, per gregkh@'s email.
> 
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 0a4881e59aa7..3d9b17fe5771 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -374,9 +374,11 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>>>        struct scatterlist *sg;
>>>        int i;
>>>
>>> -     for_each_sg(sgl, sg, nents, i)
>>> +     for_each_sg(sgl, sg, nents, i) {
>>>                dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
>>>                             attrs);
>>> +             sg->dma_address = DMA_MAPPING_ERROR;
>>
>> There are more DMA API backends than just dma-direct, so while this
>> might help paper over bugs when SWIOTLB is in use, it's not going to
>> have any effect when those same bugs are hit under other circumstances.
>> Once again, the moral of the story is that effort is better spent just
>> fixing the bugs ;)
> 
> Thanks for the quick feedback. What is the correct fix? I understand
> the first half. The NVMe driver should be updated to not call unmap on
> an address that has already been unmapped within the DMA direct code.
> Where I'm less certain is how to communicate to the NVMe driver that
> the mapping failed. In particular, the NVMe code explicitly checks if
> the first DMA address in the scatter/gather list is set to
> DMA_MAPPING_ERROR. Thus, don't we need to update the DMA direct code
> to propagate DMA_MAPPING_ERROR back up to the driver, via the
> scatter/gather struct?

Erm, you check the return value of dma_map_sg(). If it's zero, the 
request failed; if it's nonzero, that's how many DMA segments you now 
have to process. See Documentation/core-api/dma-api.rst.

The only guarantee offered about the state of the scatterlist itself is 
that if it is successfully mapped, then the dma_address and dma_length 
fields are valid for that many segments, and if that is fewer than the 
total number of physical segments then the next one after the final DMA 
segment will have a dma_length of 0. In particular there are no 
guarantees at all about the state if the mapping was unsuccessful.

If a driver is failing to keep track of the success/failure status and 
later down the line trying to guess what to do with a list that may or 
may not have been mapped, then frankly that driver should be redesigned 
because that is a terrible anti-pattern. At the very very least it 
should explicitly encode its own "known bad" state upon failure that it 
can then reliably recognise later.

Robin.

> I skimmed arch/arm/mm/dma-mapping.c, just now. I can see that this
> code sets the address within the scatter/gather struct to
> DMA_MAPPING_ERROR before trying to map an IO address and write it into
> the struct. Is this a good example to follow?
> 
> Thanks,
> Marc
> 
