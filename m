Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A482EEDAB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 08:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbhAHHCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 02:02:52 -0500
Received: from foss.arm.com ([217.140.110.172]:45944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbhAHHCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 02:02:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB6DE31B;
        Thu,  7 Jan 2021 23:02:05 -0800 (PST)
Received: from [10.163.88.165] (unknown [10.163.88.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BB0D3F719;
        Thu,  7 Jan 2021 23:02:03 -0800 (PST)
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3ae8c16d-50c4-c6cc-62b8-922cfc308c95@arm.com>
Date:   Fri, 8 Jan 2021 12:32:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d0e627fd-390f-5915-c218-e2137aef3eb4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/21 6:00 PM, David Hildenbrand wrote:
> On 06.01.21 07:11, Anshuman Khandual wrote:
>> Hi Sudershan,
>>
>> This patch (and the cover letter) does not copy LAKML even though the
>> entire change here is arm64 specific. Please do copy all applicable
>> mailing lists for a given patch.
>>
>> On 1/6/21 6:58 AM, Sudarshan Rajagopalan wrote:
>>> Currently on arm64, memory section size is hard-coded to 1GB.
>>> Make this configurable if memory-hotplug is enabled, to support
>>> more finer granularity for hotplug-able memory.
>>
>> Section size has always been decided by the platform. It cannot be a
>> configurable option because the user would not know the constraints
>> for memory representation on the platform and besides it also cannot
>> be trusted.
>>
>>>
>>> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
>>> ---
>>>  arch/arm64/Kconfig                 | 11 +++++++++++
>>>  arch/arm64/include/asm/sparsemem.h |  4 ++++
>>>  2 files changed, 15 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 6d232837cbee..34124eee65da 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -294,6 +294,17 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>>>  config SMP
>>>  	def_bool y
>>>  
>>> +config HOTPLUG_SIZE_BITS
>>> +	int "Memory hotplug block size(29 => 512MB 30 => 1GB)"
> 
> "Memory hotplug block size" and "HOTPLUG_SIZE_BITS" is confusing. It's
> the section size. Please use that terminology.
> 
> (if at all, it would have to be "minimum memory hot(un)plug
> granularity", but even that is somewhat misleading)
> 
> "SECTION_SIZE_BITS"
> 
> But I agree that letting the user configure it is sub-optimal.
> 
>>> +	depends on SPARSEMEM
>>> +	depends on MEMORY_HOTPLUG
>>> +	range 28 30
>>
>> 28 would not work for 64K pages.
> 
> @Anshuman, what's your feeling about changing this to 128 MB for 4k/16k
> base pages (as we have on x86-64 right now) and 512 MB for 64k as
> default for now?

To summarize, the section size bits for each base page size config
should always

a. Avoid (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS

b. Provide minimum possible section size for a given base page config to
   have increased agility during memory hotplug operations and reduced
   vmemmap wastage for sections with holes.

c. Allow 4K base page configs to have PMD based vmemmap mappings

Because CONFIG_FORCE_MAX_ZONEORDER is always defined on arm64 platform,
the following would always avoid the condition (a)

SECTION_SIZE_BITS (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)

			- 22 (11 - 1 + 12) for 4K pages
			- 24 (11 - 1 + 14) for 16K pages without THP
			- 25 (12 - 1 + 14) for 16K pages with THP
			- 26 (11 - 1 + 16) for 64K pages without THP
			- 29 (14 - 1 + 16) for 64K pages with THP

Apart from overriding 4K base page size config to have 27 as section size
bits, should not all other values be okay here ? But then wondering what
benefit 128MB (27 bits) section size for 16K config would have ? OR the
objective here is to match 16K page size config with default x86-64.

> 
> (If we worry about the number of section bits in page->flags, we could
> glue it to vmemmap support where that does not matter)

Could you please elaborate ? Could smaller section size bits numbers like
22 or 24 create problems in page->flags without changing other parameters
like NR_CPUS or NODES_SHIFT ? A quick test with 64K base page without THP
i.e 26 bits in section size, fails to boot.

As you have suggested, probably constant defaults (128MB for 4K/16K, 512MB
for 64K) might be better than depending on the CONFIG_FORCE_MAX_ZONEORDER,
at least for now.
