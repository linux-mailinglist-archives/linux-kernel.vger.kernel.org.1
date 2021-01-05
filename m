Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF7E2EA3E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbhAED0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:26:20 -0500
Received: from foss.arm.com ([217.140.110.172]:48756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbhAED0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:26:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B2751FB;
        Mon,  4 Jan 2021 19:25:33 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 863513F66E;
        Mon,  4 Jan 2021 19:25:29 -0800 (PST)
Subject: Re: [RFC 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        James Morse <james.morse@arm.com>,
        Dan Williams <dan.j.williams@intel.com>, will@kernel.org,
        ardb@kernel.org
References: <1608621144-4001-1-git-send-email-anshuman.khandual@arm.com>
 <1608621144-4001-2-git-send-email-anshuman.khandual@arm.com>
 <20210104153633.00003288@Huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <72ad70de-a282-7136-ddea-4157e835c8aa@arm.com>
Date:   Tue, 5 Jan 2021 08:55:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104153633.00003288@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/21 9:06 PM, Jonathan Cameron wrote:
> On Tue, 22 Dec 2020 12:42:23 +0530
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> pfn_valid() validates a pfn but basically it checks for a valid struct page
>> backing for that pfn. It should always return positive for memory ranges
>> backed with struct page mapping. But currently pfn_valid() fails for all
>> ZONE_DEVICE based memory types even though they have struct page mapping.
>>
>> pfn_valid() asserts that there is a memblock entry for a given pfn without
>> MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
>> that they do not have memblock entries. Hence memblock_is_map_memory() will
>> invariably fail via memblock_search() for a ZONE_DEVICE based address. This
>> eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
>> to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
>> into the system via memremap_pages() called from a driver, their respective
>> memory sections will not have SECTION_IS_EARLY set.
>>
>> Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
>> regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
>> for firmware reserved memory regions. memblock_is_map_memory() can just be
>> skipped as its always going to be positive and that will be an optimization
>> for the normal hotplug memory. Like ZONE_DEVIE based memory, all hotplugged
> 
> typo: ZONE_DEVIE
> 
>> normal memory too will not have SECTION_IS_EARLY set for their sections.
>>
>> Skipping memblock_is_map_memory() for all non early memory sections would
>> fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
>> performance for normal hotplug memory as well.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Fixes: 73b20c84d42d ("arm64: mm: implement pte_devmap support")
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/mm/init.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 75addb36354a..ee23bda00c28 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -225,6 +225,18 @@ int pfn_valid(unsigned long pfn)
>>  
>>  	if (!valid_section(__pfn_to_section(pfn)))
>>  		return 0;
>> +
>> +	/*
>> +	 * ZONE_DEVICE memory does not have the memblock entries.
>> +	 * memblock_is_map_memory() check for ZONE_DEVICE based
>> +	 * addresses will always fail. Even the normal hotplugged
>> +	 * memory will never have MEMBLOCK_NOMAP flag set in their
>> +	 * memblock entries. Skip memblock search for all non early
>> +	 * memory sections covering all of hotplug memory including
>> +	 * both normal and ZONE_DEVIE based.
> 
> Here as well + the cover letter title.

My bad, will fix all the three instances.
