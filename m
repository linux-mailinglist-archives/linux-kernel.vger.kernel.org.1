Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9352C6ECD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 05:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgK1Ecq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 23:32:46 -0500
Received: from foss.arm.com ([217.140.110.172]:59302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731889AbgK1EWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 23:22:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65013D6E;
        Fri, 27 Nov 2020 20:21:47 -0800 (PST)
Received: from [10.163.85.48] (unknown [10.163.85.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B5113F23F;
        Fri, 27 Nov 2020 20:21:45 -0800 (PST)
Subject: Re: [RFC 1/3] mm/hotplug: Pre-validate the address range with
 platform
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
 <1606098529-7907-2-git-send-email-anshuman.khandual@arm.com>
 <13392308-45a8-f85d-b25e-4a728e1e0730@redhat.com>
 <0c13a221-570a-0d64-fce9-d28e52cbdd6c@arm.com>
 <8886f78e-28cf-ded0-1629-d4206205be96@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1d0224a2-1edb-6a43-bf2d-0a6f3ef4746e@arm.com>
Date:   Sat, 28 Nov 2020 09:51:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8886f78e-28cf-ded0-1629-d4206205be96@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/20 2:31 PM, David Hildenbrand wrote:
>>>
>>> "arch_get_mappable_range(void)" (or similar) ?
>>
>> The current name seems bit better (I guess). Because we are asking for
>> max addressable range with or without the linear mapping.
>>
>>>
>>> AFAIKs, both implementations (arm64/s390x) simply do the exact same
>>> thing as memhp_get_pluggable_range() for !need_mapping.
>>
>> That is for now. Even the range without requiring linear mapping might not
>> be the same (like now) for every platform as some might have constraints.
>> So asking the platform ranges with or without linear mapping seems to be
>> better and could accommodate special cases going forward. Anyways, there
>> is an always an "all allowing" fallback option nonetheless.
> 
> Let's keep it simple as long as we don't have a real scenario where this
> would apply.

Sure, will have the arch callback only when the range needs linear mapping.
Otherwise, memhp_get_pluggable_range() can just fallback on [0...max_phys]
for non linear mapping requests.

> 
> [...]
> 
>>
>>>
>>>> +		return true;
>>>> +
>>>> +	WARN(1, "Hotplug memory [%#llx-%#llx] exceeds maximum addressable range [%#llx-%#llx]\n",
>>>> +		start, end, memhp_range.start, memhp_range.end);
>>>
>>> pr_warn() (or even pr_warn_once())
>>>
>>> while we're at it. No reason to eventually crash a system :)
>>
>> Didn't quite get it. How could this crash the system ?
> 
> With panic_on_warn, which some distributions started to enable.

Okay, got it.

> 
> [...]
> 
>>>>  		/*
>>>>  		 * Validate altmap is within bounds of the total request
>>>> @@ -1109,6 +1089,9 @@ int __ref __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
>>>>  	struct resource *res;
>>>>  	int ret;
>>>>  
>>>> +	if (!memhp_range_allowed(start, size, 1))
>>>> +		return -ERANGE;
>>>
>>> We used to return -E2BIG, no? Maybe better keep that.
>>
>> ERANGE seems to be better as the range can overrun on either side.
> 
> Did you check all callers that they can handle it? Should mention that
> in the patch description then.

Hmm, okay then. Lets keep -E2BIG to be less disruptive for the callers.

> 
>>
>>>
>>>> +
>>>>  	res = register_memory_resource(start, size, "System RAM");
>>>>  	if (IS_ERR(res))
>>>>  		return PTR_ERR(res);
>>>> @@ -1123,6 +1106,9 @@ int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
>>>>  {
>>>>  	int rc;
>>>>  
>>>> +	if (!memhp_range_allowed(start, size, 1))
>>>> +		return -ERANGE;
>>>> +
>>>>  	lock_device_hotplug();
>>>>  	rc = __add_memory(nid, start, size, mhp_flags);
>>>>  	unlock_device_hotplug();
>>>> @@ -1163,6 +1149,9 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
>>>>  	    resource_name[strlen(resource_name) - 1] != ')')
>>>>  		return -EINVAL;
>>>>  
>>>> +	if (!memhp_range_allowed(start, size, 0))
>>>> +		return -ERANGE;
>>>> +
>>>>  	lock_device_hotplug();
>>>
>>> For all 3 cases, doing a single check in register_memory_resource() is
>>> sufficient.
>>
>> Will replace with a single check in register_memory_resource(). But does
>> add_memory_driver_managed() always require linear mapping ? The proposed
>> check here did not ask for linear mapping in add_memory_driver_managed().
> 
> Yes, in that regard, it behaves just like add_memory().

Sure.
