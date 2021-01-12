Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565D62F26C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 04:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbhALDoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 22:44:19 -0500
Received: from foss.arm.com ([217.140.110.172]:39592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbhALDoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 22:44:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFC95101E;
        Mon, 11 Jan 2021 19:43:32 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5A053F66E;
        Mon, 11 Jan 2021 19:43:28 -0800 (PST)
Subject: Re: [PATCH V2 1/3] mm/hotplug: Prevalidate the address range being
 added with platform
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
 <1608218912-28932-2-git-send-email-anshuman.khandual@arm.com>
 <10e733fa-4568-d38f-9b95-2ccc5dc627b8@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c23e9740-0779-d6b7-2ff7-f6f9f9085f0d@arm.com>
Date:   Tue, 12 Jan 2021 09:13:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <10e733fa-4568-d38f-9b95-2ccc5dc627b8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/21 4:21 PM, David Hildenbrand wrote:
> On 17.12.20 16:28, Anshuman Khandual wrote:
>> This introduces memhp_range_allowed() which can be called in various memory
>> hotplug paths to prevalidate the address range which is being added, with
>> the platform. Then memhp_range_allowed() calls memhp_get_pluggable_range()
>> which provides applicable address range depending on whether linear mapping
>> is required or not. For ranges that require linear mapping, it calls a new
>> arch callback arch_get_mappable_range() which the platform can override. So
>> the new callback, in turn provides the platform an opportunity to configure
>> acceptable memory hotplug address ranges in case there are constraints.
>>
>> This mechanism will help prevent platform specific errors deep down during
>> hotplug calls. This drops now redundant check_hotplug_memory_addressable()
>> check in __add_pages() but instead adds a VM_BUG_ON() check which would
>> ensure that the range has been validated with memhp_range_allowed() earlier
>> in the call chain. Besides memhp_get_pluggable_range() also can be used by
>> potential memory hotplug callers to avail the allowed physical range which
>> would go through on a given platform.
>>
>> This does not really add any new range check in generic memory hotplug but
>> instead compensates for lost checks in arch_add_memory() where applicable
>> and check_hotplug_memory_addressable(), with unified memhp_range_allowed().
>>
> 
> Subject s/mm\/hotplug/mm\/memory_hotplug/

Sure, will do.

> 
> Everywhere in this patch: Use "true/false" for boolean values.

Sure, will change.

> 
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  include/linux/memory_hotplug.h | 10 +++++
>>  mm/memory_hotplug.c            | 79 +++++++++++++++++++++++++---------
>>  mm/memremap.c                  |  6 +++
>>  3 files changed, 75 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>> index 551093b74596..8d72354758c8 100644
>> --- a/include/linux/memory_hotplug.h
>> +++ b/include/linux/memory_hotplug.h
>> @@ -70,6 +70,9 @@ typedef int __bitwise mhp_t;
>>   */
>>  #define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
>>  
>> +bool memhp_range_allowed(u64 start, u64 size, bool need_mapping);
>> +struct range memhp_get_pluggable_range(bool need_mapping);
> 
> AFAIKs, all memhp_get_pluggable_range() users pass "1".

Right.

> 
> What about the "add_pages()-only" path?

I had dropped memhp_range_allowed() changes for add_pages() in pagemap_range()
because you had mentioned not to add any new checks in the generic code. Will
add it back if that is preferred.
