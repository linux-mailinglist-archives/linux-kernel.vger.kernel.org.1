Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C042A2F4EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbhAMP2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:28:38 -0500
Received: from foss.arm.com ([217.140.110.172]:37940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbhAMP2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:28:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE5B5142F;
        Wed, 13 Jan 2021 07:27:52 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D92A83F66E;
        Wed, 13 Jan 2021 07:27:39 -0800 (PST)
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Claire Chang <tientzu@chromium.org>, robh+dt@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        joro@8bytes.org, will@kernel.org, frowand.list@gmail.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, hch@lst.de,
        m.szyprowski@samsung.com
Cc:     drinkcat@chromium.org, devicetree@vger.kernel.org,
        heikki.krogerus@linux.intel.com, saravanak@google.com,
        peterz@infradead.org, xypron.glpk@gmx.de,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, bgolaszewski@baylibre.com,
        iommu@lists.linux-foundation.org, grant.likely@arm.com,
        rdunlap@infradead.org, gregkh@linuxfoundation.org,
        xen-devel@lists.xenproject.org, dan.j.williams@intel.com,
        treding@nvidia.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
 <95ae9c1e-c1f1-5736-fe86-12ced1f648f9@gmail.com>
 <7ed51025f051f65f3dfe10a88caeb648821994b1.camel@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4c4989b5-f825-7e04-ca66-038cf6b9d5e9@arm.com>
Date:   Wed, 13 Jan 2021 15:27:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <7ed51025f051f65f3dfe10a88caeb648821994b1.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-13 13:59, Nicolas Saenz Julienne wrote:
> Hi All,
> 
> On Tue, 2021-01-12 at 16:03 -0800, Florian Fainelli wrote:
>> On 1/5/21 7:41 PM, Claire Chang wrote:
>>> Add the initialization function to create restricted DMA pools from
>>> matching reserved-memory nodes in the device tree.
>>>
>>> Signed-off-by: Claire Chang <tientzu@chromium.org>
>>> ---
>>>   include/linux/device.h  |   4 ++
>>>   include/linux/swiotlb.h |   7 +-
>>>   kernel/dma/Kconfig      |   1 +
>>>   kernel/dma/swiotlb.c    | 144 ++++++++++++++++++++++++++++++++++------
>>>   4 files changed, 131 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/include/linux/device.h b/include/linux/device.h
>>> index 89bb8b84173e..ca6f71ec8871 100644
>>> --- a/include/linux/device.h
>>> +++ b/include/linux/device.h
>>> @@ -413,6 +413,7 @@ struct dev_links_info {
>>>    * @dma_pools:	Dma pools (if dma'ble device).
>>>    * @dma_mem:	Internal for coherent mem override.
>>>    * @cma_area:	Contiguous memory area for dma allocations
>>> + * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.
>>>    * @archdata:	For arch-specific additions.
>>>    * @of_node:	Associated device tree node.
>>>    * @fwnode:	Associated device node supplied by platform firmware.
>>> @@ -515,6 +516,9 @@ struct device {
>>>   #ifdef CONFIG_DMA_CMA
>>>   	struct cma *cma_area;		/* contiguous memory area for dma
>>>   					   allocations */
>>> +#endif
>>> +#ifdef CONFIG_SWIOTLB
>>> +	struct io_tlb_mem	*dma_io_tlb_mem;
>>>   #endif
>>>   	/* arch specific additions */
>>>   	struct dev_archdata	archdata;
>>> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
>>> index dd8eb57cbb8f..a1bbd7788885 100644
>>> --- a/include/linux/swiotlb.h
>>> +++ b/include/linux/swiotlb.h
>>> @@ -76,12 +76,13 @@ extern enum swiotlb_force swiotlb_force;
>>>    *
>>>    * @start:	The start address of the swiotlb memory pool. Used to do a quick
>>>    *		range check to see if the memory was in fact allocated by this
>>> - *		API.
>>> + *		API. For restricted DMA pool, this is device tree adjustable.
>>
>> Maybe write it as this is "firmware adjustable" such that when/if ACPI
>> needs something like this, the description does not need updating.

TBH I really don't think this needs calling out at all. Even in the 
regular case, the details of exactly how and where the pool is allocated 
are beyond the scope of this code - architectures already have several 
ways to control that and make their own decisions.

>>
>> [snip]
>>
>>> +static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>>> +				    struct device *dev)
>>> +{
>>> +	struct io_tlb_mem *mem = rmem->priv;
>>> +	int ret;
>>> +
>>> +	if (dev->dma_io_tlb_mem)
>>> +		return -EBUSY;
>>> +
>>> +	if (!mem) {
>>> +		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>>> +		if (!mem)
>>> +			return -ENOMEM;
>>> +
>>> +		if (!memremap(rmem->base, rmem->size, MEMREMAP_WB)) {
>>
>> MEMREMAP_WB sounds appropriate as a default.
> 
> As per the binding 'no-map' has to be disabled here. So AFAIU, this memory will
> be part of the linear mapping. Is this really needed then?

More than that, I'd assume that we *have* to use the linear/direct map 
address rather than anything that has any possibility of being a vmalloc 
remap, otherwise we can no longer safely rely on 
phys_to_dma/dma_to_phys, no?

That said, given that we're not actually using the returned address, I'm 
not entirely sure what the point of this call is anyway. If we can 
assume it's always going to return the linear map address via 
try_ram_remap() then we can equally just go ahead and use the linear map 
address straight away. I don't really see how we could ever hit the 
"is_ram == REGION_MIXED" case in memremap() that would return NULL, if 
we passed the memblock check earlier in __reserved_mem_alloc_size() such 
that this rmem node ever got to be initialised at all.

Robin.

>> Documentation/devicetree/bindings/reserved-memory/ramoops.txt does
>> define an "unbuffered" property which in premise could be applied to the
>> generic reserved memory binding as well and that we may have to be
>> honoring here, if we were to make it more generic. Oh well, this does
>> not need to be addressed right now I guess.
> 
> 
> 
