Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83447300088
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbhAVKnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:43:11 -0500
Received: from foss.arm.com ([217.140.110.172]:40724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbhAVKlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:41:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C5D411D4;
        Fri, 22 Jan 2021 02:41:05 -0800 (PST)
Received: from [10.163.90.127] (unknown [10.163.90.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81AA93F719;
        Fri, 22 Jan 2021 02:41:01 -0800 (PST)
Subject: Re: [PATCH V3 1/3] mm/memory_hotplug: Prevalidate the address range
 being added with platform
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com
Cc:     Oscar Salvador <osalvador@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-2-git-send-email-anshuman.khandual@arm.com>
 <9916f217-ec29-33ff-a260-7a26792d23a1@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <897c31ba-d3bd-b694-8c87-82e784a60c51@arm.com>
Date:   Fri, 22 Jan 2021 16:11:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9916f217-ec29-33ff-a260-7a26792d23a1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/22/21 2:48 PM, David Hildenbrand wrote:
> 
>> +/*
>> + * Platforms should define arch_get_mappable_range() that provides
>> + * maximum possible addressable physical memory range for which the
>> + * linear mapping could be created. The platform returned address
>> + * range must adhere to these following semantics.
>> + *
>> + * - range.start <= range.end
>> + * - Range includes both end points [range.start..range.end]
>> + *
>> + * There is also a fallback definition provided here, allowing the
>> + * entire possible physical address range in case any platform does
>> + * not define arch_get_mappable_range().
>> + */
>> +struct range __weak arch_get_mappable_range(void)
>> +{
>> +	struct range memhp_range = {
>> +		.start = 0UL,
>> +		.end = -1ULL,
>> +	};
>> +	return memhp_range;
>> +}
>> +
>> +struct range memhp_get_pluggable_range(bool need_mapping)
>> +{
>> +	const u64 max_phys = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;
> 
> Sorry, thought about that line a bit more, and I think this is just
> wrong (took me longer to realize as it should). The old code used this
> calculation to print the limit only (in a wrong way), let's recap:
> 
> Assume MAX_PHYSMEM_BITS=32
> 
> 	max_phys = (1ULL << (32 + 1)) - 1 = 0x1ffffffffull;
> 
> Ehm, these are 33 bit.
> 
> OTOH, old code checked for
> 
> 	if (max_addr >> MAX_PHYSMEM_BITS) {
> 
> Which makes sense, because
> 
> 	0x1ffffffffull >> 32 = 1
> 
> results in "true", meaning it's to big, while
> 
> 	0xffffffffull >> 32 = 0
> 
> correctly results in "false", meaning the address is fine.
> 
> 
> 
> So, this should just be
> 
> const u64 max_phys = 1ULL << MAX_PHYSMEM_BITS;
> 
> (similarly as calculated in virito-mem code, or in kernel/resource.c)

Should this be 1ULL << MAX_PHYSMEM_BITS - 1 instead ? Currently there are
three usage for this variable in the function.

- if (mhp_range.start > max_phys)
- mhp_range.end = min_t(u64, mhp_range.end, max_phys)
- mhp_range.end = max_phys

mhp_range.end being always inclusive on the higher end and could be maximum
(1ULL << MAX_PHYSMEM_BITS - 1) which is 0xFFFFFFFF instead of 0x100000000
when (1ULL << MAX_PHYSMEM_BITS) is followed for a 32 bit system. This seems
consistent with the default fallback (range.end = -1ULL) defined above.

> 
> 
>> +	struct range memhp_range;
>> +
>> +	if (need_mapping) {
>> +		memhp_range = arch_get_mappable_range();
>> +		if (memhp_range.start > max_phys) {
>> +			memhp_range.start = 0;
>> +			memhp_range.end = 0;
>> +		}
>> +		memhp_range.end = min_t(u64, memhp_range.end, max_phys);
>> +	} else {
>> +		memhp_range.start = 0;
>> +		memhp_range.end = max_phys;
>> +	}
>> +	return memhp_range;
>> +}
>> +EXPORT_SYMBOL_GPL(memhp_get_pluggable_range);
> 
> 
