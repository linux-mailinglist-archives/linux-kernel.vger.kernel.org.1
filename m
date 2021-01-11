Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E302F100C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbhAKK0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:26:41 -0500
Received: from foss.arm.com ([217.140.110.172]:52732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbhAKK0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:26:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A86DF101E;
        Mon, 11 Jan 2021 02:25:54 -0800 (PST)
Received: from [10.163.88.153] (unknown [10.163.88.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 119DA3F70D;
        Mon, 11 Jan 2021 02:25:52 -0800 (PST)
Subject: Re: [PATCH 1/1] arm64: make section size configurable for memory
 hotplug
To:     David Hildenbrand <david@redhat.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1609895500.git.sudaraja@codeaurora.org>
 <66f79b0c06602c22df4da8ff4a5c2b97c9275250.1609895500.git.sudaraja@codeaurora.org>
 <055b0aca-af60-12ad-cd68-e15440ade64b@arm.com>
 <d0e627fd-390f-5915-c218-e2137aef3eb4@redhat.com>
 <3ae8c16d-50c4-c6cc-62b8-922cfc308c95@arm.com>
 <7939710a-5d03-de2b-73b2-bca472de431a@redhat.com>
 <5138b97e-41f7-11c3-9a28-7fb2e2f5c387@arm.com>
 <6764cfe0-00ad-20b5-7fc8-2c7d4170751f@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <72a04d85-439d-d224-230e-08450720e709@arm.com>
Date:   Mon, 11 Jan 2021 15:56:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6764cfe0-00ad-20b5-7fc8-2c7d4170751f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/21 3:43 PM, David Hildenbrand wrote:
> On 11.01.21 05:17, Anshuman Khandual wrote:
>>
>>
>> On 1/8/21 9:00 PM, David Hildenbrand wrote:
>>>> To summarize, the section size bits for each base page size config
>>>> should always
>>>>
>>>> a. Avoid (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
>>>
>>> Pageblocks must also always fall completely into a section.
>>>
>>>>
>>>> b. Provide minimum possible section size for a given base page config to
>>>>    have increased agility during memory hotplug operations and reduced
>>>>    vmemmap wastage for sections with holes.
>>>
>>> OTOH, making the section size too small (e.g., 16MB) creates way to many
>>> memory block devices in /sys/devices/system/memory/, and might consume
>>> too many page->flags bits in the !vmemmap case.
>>>
>>> For bigger setups, we might, similar to x86-64 (e.g., >= 64 GiB),
>>> determine the memory_block_size_bytes() at runtime (spanning multiple
>>> sections then), once it becomes relevant.
>>>
>>>>
>>>> c. Allow 4K base page configs to have PMD based vmemmap mappings
>>>
>>> Agreed.
>>>
>>>>
>>>> Because CONFIG_FORCE_MAX_ZONEORDER is always defined on arm64 platform,
>>>> the following would always avoid the condition (a)
>>>>
>>>> SECTION_SIZE_BITS (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
>>>>
>>>> 			- 22 (11 - 1 + 12) for 4K pages
>>>> 			- 24 (11 - 1 + 14) for 16K pages without THP
>>>> 			- 25 (12 - 1 + 14) for 16K pages with THP
>>>> 			- 26 (11 - 1 + 16) for 64K pages without THP
>>>> 			- 29 (14 - 1 + 16) for 64K pages with THP
>>>>
>>>> Apart from overriding 4K base page size config to have 27 as section size
>>>> bits, should not all other values be okay here ? But then wondering what
>>>> benefit 128MB (27 bits) section size for 16K config would have ? OR the
>>>> objective here is to match 16K page size config with default x86-64.
>>>
>>> We don't want to have sections that are too small. We don't want to have
>>> sections that are too big :)
>>>
>>> Not sure if we really want to allow setting e.g., a section size of 4
>>> MB. That's just going to hurt. IMHO, something in the range of 64..256
>>> MB is quite a good choice, where possible.
>>>
>>>>
>>>>>
>>>>> (If we worry about the number of section bits in page->flags, we could
>>>>> glue it to vmemmap support where that does not matter)
>>>>
>>>> Could you please elaborate ? Could smaller section size bits numbers like
>>>> 22 or 24 create problems in page->flags without changing other parameters
>>>> like NR_CPUS or NODES_SHIFT ? A quick test with 64K base page without THP
>>>
>>> Yes, in the !vmemmap case, we have to store the section_nr in there.
>>> IIRC, it's less of an issue with section sizes like 128 MB.
>>>
>>>> i.e 26 bits in section size, fails to boot.
>>>
>>> 26 bits would mean 64 MB, no? Not sure if that's possible even without
>>> THP (MAX_ORDER - 1, pageblock_order ...) on 64k pages. I'd assume 512 MB
>>> is the lowest we can go. I'd assume this would crash :)
>>>
>>>>
>>>> As you have suggested, probably constant defaults (128MB for 4K/16K, 512MB
>>>> for 64K) might be better than depending on the CONFIG_FORCE_MAX_ZONEORDER,
>>>> at least for now.
>>>
>>> That's also what I would prefer, keeping it simple.
>>
>> Okay sure, will send a RFC to begin with.
>>
> 
> Note that there is
> 
> https://lkml.kernel.org/r/15cf9a2359197fee0168f820c5c904650d07939e.1610146597.git.sudaraja@codeaurora.org
> 
> (Sudarshan missed to cc linux-mm)
> 

Right, some how missed that. Anyways, ended up spending some time testing
the change for various configs.
