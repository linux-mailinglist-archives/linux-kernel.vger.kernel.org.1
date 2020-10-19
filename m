Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17047292652
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgJSLYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:24:14 -0400
Received: from foss.arm.com ([217.140.110.172]:55486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgJSLYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:24:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42EE830E;
        Mon, 19 Oct 2020 04:24:12 -0700 (PDT)
Received: from [10.163.77.151] (unknown [10.163.77.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A7DF3F719;
        Mon, 19 Oct 2020 04:24:08 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: Validate hotplug range before creating linear
 mapping
To:     David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
References: <1600332402-30123-1-git-send-email-anshuman.khandual@arm.com>
 <7c39c046-b950-ea4c-fa4d-e0a5d6171147@redhat.com>
 <72ea7056-5289-3eb0-eca9-a8444524667e@arm.com>
 <70a76220-9acd-06b6-e074-dc9cbb6668da@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <40104165-aa6f-201c-4aa2-e3918978dc6e@arm.com>
Date:   Mon, 19 Oct 2020 16:53:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <70a76220-9acd-06b6-e074-dc9cbb6668da@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/2020 02:09 PM, David Hildenbrand wrote:
>>> We do have __add_pages()->check_hotplug_memory_addressable() where we
>>> already check against MAX_PHYSMEM_BITS.
>>
>> Initially, I thought about check_hotplug_memory_addressable() but the
>> existing check that asserts end of hotplug wrt MAX_PHYSMEM_BITS, is
>> generic in nature. AFAIK the linear mapping problem is arm64 specific,
>> hence I was not sure whether to add an arch specific callback which
>> will give platform an opportunity to weigh in for these ranges.
> 
> Also on s390x, the range where you can create an identity mapping depends on
> - early kernel setup
> - kasan
> 
> (I assume it's the same for all archs)
> 
> See arch/s390/mm/vmem.c:vmem_add_mapping(), which contains similar
> checks (VMEM_MAX_PHYS).

Once there is a high level function, all these platform specific
checks should go in their arch_get_mappable_range() instead.

> 
>>
>> But hold on, check_hotplug_memory_addressable() only gets called from
>> __add_pages() after linear mapping creation in arch_add_memory(). How
>> would it help ? We need some thing for add_memory(), its variants and
>> also possibly for memremap_pages() when it calls arch_add_memory().
>>
> 
> Good point. We chose that place for simplicity when adding it (I was
> favoring calling it at two places back then). Now, we might have good
> reason to move the checks further up the call chain.

check_hotplug_memory_addressable() check in add_pages() does not add
much as linear mapping creation must have been completed by then. I
guess moving this check inside the single high level function should
be better.

But checking against MAX_PHYSMEM_BITS might no longer be required, as
the range would have been validated against applicable memhp_range.   

> 
> Most probably,
> 
> struct range memhp_get_addressable_range(bool need_mapping)
> {
> 	...
> }

Something like this...

+struct memhp_range {
+       u64 start;
+       u64 end;
+};
+
+#ifndef arch_get_addressable_range
+static inline struct memhp_range arch_get_mappable_range(bool need_mapping)
+{
+       struct memhp_range range = {
+               .start = 0UL,
+               .end = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1,
+       };
+       return range;
+}
+#endif
+
+static inline struct memhp_range memhp_get_mappable_range(bool need_mapping)
+{
+       const u64 max_phys = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1;
+       struct memhp_range range = arch_get_mappable_range(need_mapping);
+
+       if (range.start > max_phys) {
+               range.start = 0;
+               range.end = 0;
+       }
+       range.end = min_t(u64, range.end, max_phys);
+       return range;
+}
+
+static inline bool memhp_range_allowed(u64 start, u64 end, bool need_mapping)
+{
+       struct memhp_range range = memhp_get_mappable_range(need_mapping);
+
+       return (start <= end) && (start >= range.start) && (end <= range.end);
+}

> 
> Would make sense, to deal with memremap_pages() without identity mappings.
> 
> We have two options:
> 
> 1. Generalize the checks, check early in applicable functions. Have a
> single way to get applicable ranges, both in callers, and inside the
> functions.
Inside the functions, check_hotplug_memory_addressable() in add_pages() ?
We could just drop that. Single generalized check with an arch callback
makes more sense IMHO.

> 
> 2. Keep the checks where they are. Add memhp_get_addressable_range() so
> callers can figure limits out. It's less clear what the relation between
> the different checks is. And it's likely if things change at one place
> that we miss the other place.

Right, does not sound like a good idea :)

> 
>>> struct range memhp_get_addressable_range(void)
>>> {
>>> 	const u64 max_phys = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1;
>>> 	struct range range = arch_get_mappable_range();
>>
>> What would you suggest as the default fallback range if a platform
>> does not define this callback.
> 
> Just the largest possible range until we implement them. IIRC, an s390x
> version should be easy to add.

[0UL...(1ull << (MAX_PHYSMEM_BITS + 1)) - 1] is the largest possible
hotplug range.

> 
>>
>>>
>>> 	if (range.start > max_phys) {
>>> 		range.start = 0;
>>> 		range.end = 0;
>>> 	}
>>> 	range.end = max_t(u64, range.end, max_phys);
>>
>> min_t instead ?
> 
> Yeah :)
> 
>>
>>>
>>> 	return range;
>>> }
>>>
>>>
>>> That, we can use in check_hotplug_memory_addressable(), and also allow
>>> add_memory*() users to make use of it.
>>
>> So this check would happen twice during a hotplug ?
> 
> Right now it's like calling a function with wrong arguments - you just
> don't have a clue what valid arguments are, because non-obvious errors
> (besides -ENOMEM, which is a temporary error) pop up deep down the call
> chain.
> 
> For example, virito-mem would use it to detect during device
> initialization the usable device range, and warn the user accordingly.
> It currently manually checks for MAX_PHYSMEM_BITS, but that's just ugly.
> Failing at random add_memory() calls (permanently!) is not so nice.
> 
> In case of DIMMs, we could use it to detect if adding parts of a DIMM
> won't work (and warn the user early). We could try to add as much as
> possible.

Agreed.

Planning to add memhp_range_allowed() check in add_memory(), __add_memory(),
add_memory_driver_managed() and memremap_pages(). This check might just get
called twice depending on the hotplug path. Wondering if this needs to be
added any where else ?
