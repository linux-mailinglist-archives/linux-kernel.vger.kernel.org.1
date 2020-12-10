Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF02E2D5765
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLJJk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:40:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728082AbgLJJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607593166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5lCu8Yxj8UgEHmXDxfvCEByGBoDTk5BlmYVugGs6aBw=;
        b=Hf7fJgCt4IPvQdQ+WqQSC4EsG1pqv3MePEAlVnb2ul4kQDCyGIbAgFNWmojzPTAFEyHDuN
        uXr2LSZVxDhrRBBRK0Manesv+g8DB9HmfVMfGUhkyPdihR+m5+hCK5sOwHW2SThsNJhLO9
        rlxDL+dszZ+YkoNToehvJ3h5GeR+weA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-kzBCGuShNgO7son1TmuXKg-1; Thu, 10 Dec 2020 04:39:22 -0500
X-MC-Unique: kzBCGuShNgO7son1TmuXKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBC2510054FF;
        Thu, 10 Dec 2020 09:39:20 +0000 (UTC)
Received: from [10.36.113.177] (ovpn-113-177.ams2.redhat.com [10.36.113.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A6D65D6BA;
        Thu, 10 Dec 2020 09:39:16 +0000 (UTC)
Subject: Re: [PATCH 3/3] s390/mm: Define arch_get_mappable_range()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20201210065845.GA20691@osiris>
 <E026809E-4624-4ACE-B309-0443704C637B@redhat.com>
 <0a2f6eb1-c38b-9cc2-5c45-16f6c8999ce2@arm.com>
 <2a379949-4ecb-e380-560e-78ef91168c87@redhat.com>
 <1ff0df3a-a6bf-7c1c-6e10-02de3477e3ed@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <36cdf123-5b2e-0bd5-0bd7-82a801cf2e43@redhat.com>
Date:   Thu, 10 Dec 2020 10:39:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1ff0df3a-a6bf-7c1c-6e10-02de3477e3ed@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.20 09:58, Anshuman Khandual wrote:
> 
> 
> On 12/10/20 1:32 PM, David Hildenbrand wrote:
>> On 10.12.20 08:40, Anshuman Khandual wrote:
>>>
>>>
>>> On 12/10/20 12:34 PM, David Hildenbrand wrote:
>>>>
>>>>> Am 10.12.2020 um 07:58 schrieb Heiko Carstens <hca@linux.ibm.com>:
>>>>>
>>>>> ﻿On Thu, Dec 10, 2020 at 09:48:11AM +0530, Anshuman Khandual wrote:
>>>>>>>> Alternatively leaving __segment_load() and vmem_add_memory() unchanged
>>>>>>>> will create three range checks i.e two memhp_range_allowed() and the
>>>>>>>> existing VMEM_MAX_PHYS check in vmem_add_mapping() on all the hotplug
>>>>>>>> paths, which is not optimal.
>>>>>>>
>>>>>>> Ah, sorry. I didn't follow this discussion too closely. I just thought
>>>>>>> my point of view would be clear: let's not have two different ways to
>>>>>>> check for the same thing which must be kept in sync.
>>>>>>> Therefore I was wondering why this next version is still doing
>>>>>>> that. Please find a way to solve this.
>>>>>>
>>>>>> The following change is after the current series and should work with
>>>>>> and without memory hotplug enabled. There will be just a single place
>>>>>> i.e vmem_get_max_addr() to update in case the maximum address changes
>>>>>> from VMEM_MAX_PHYS to something else later.
>>>>>
>>>>> Still not. That's way too much code churn for what you want to achieve.
>>>>> If the s390 specific patch would look like below you can add
>>>>>
>>>>> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>>>>>
>>>>> But please make sure that the arch_get_mappable_range() prototype in
>>>>> linux/memory_hotplug.h is always visible and does not depend on
>>>>> CONFIG_MEMORY_HOTPLUG. I'd like to avoid seeing sparse warnings
>>>>> because of this.
>>>>>
>>>>> Thanks.
>>>>>
>>>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>>>>> index 77767850d0d0..e0e78234ae57 100644
>>>>> --- a/arch/s390/mm/init.c
>>>>> +++ b/arch/s390/mm/init.c
>>>>> @@ -291,6 +291,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>>>    if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>>>>>        return -EINVAL;
>>>>>
>>>>> +    VM_BUG_ON(!memhp_range_allowed(start, size, 1));
>>>>>    rc = vmem_add_mapping(start, size);
>>>>>    if (rc)
>>>>>        return rc;
>>>>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>>>>> index b239f2ba93b0..ccd55e2f97f9 100644
>>>>> --- a/arch/s390/mm/vmem.c
>>>>> +++ b/arch/s390/mm/vmem.c
>>>>> @@ -4,6 +4,7 @@
>>>>>  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
>>>>>  */
>>>>>
>>>>> +#include <linux/memory_hotplug.h>
>>>>> #include <linux/memblock.h>
>>>>> #include <linux/pfn.h>
>>>>> #include <linux/mm.h>
>>>>> @@ -532,11 +533,23 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>>>>>    mutex_unlock(&vmem_mutex);
>>>>> }
>>>>>
>>>>> +struct range arch_get_mappable_range(void)
>>>>> +{
>>>>> +    struct range range;
>>>>> +
>>>>> +    range.start = 0;
>>>>> +    range.end = VMEM_MAX_PHYS;
>>>>> +    return range;
>>>>> +}
>>>>> +
>>>>> int vmem_add_mapping(unsigned long start, unsigned long size)
>>>>> {
>>>>> +    struct range range;
>>>>>    int ret;
>>>>>
>>>>> -    if (start + size > VMEM_MAX_PHYS ||
>>>>> +    range = arch_get_mappable_range();
>>>>> +    if (start < range.start ||
>>>>> +        start + size > range.end ||
>>>>>        start + size < start)
>>>>>        return -ERANGE;
>>>>>
>>>>>
>>>>
>>>> Right, what I had in mind as reply to v1. Not sure if we really need new checks in common code. Having a new memhp_get_pluggable_range() would be sufficient for my use case (virtio-mem).
>>> Didn't quite understand "Not sure if we really need new checks in common code".
>>> Could you please be more specific. New checks as in pagemap_range() ? Because
>>> other places it is either replacing erstwhile check_hotplug_memory_addressable()
>>> or just moving existing checks from platform arch_add_memory() to the beginning
>>> of various hotplug paths.
>>
>> The main concern I have with current code is that it makes it impossible
>> for some driver to detect which ranges it could actually later hotplug.
>> You cannot warn about a strange setup before you actually run into the
>> issues while trying to add memory. Like returning "-EINVAL" from a
>> function but not exposing which values are actually valid.
>>
>> If we have memhp_get_pluggable_range(), we have such a mechanism and
>>
>> 1. Trying to add out-of-range memory will fail (although deep down in
>> arch code, but at least it fails).
>>
>> 2. There is a way for drivers to find out which values are actually
>> valid before triggering 1.
> 
> Right, that is an important use case from a driver perspective as it
> helps validate the range being attempted for hotplug, before failing.
> But then memhp_range_allowed() also uses the same mechanism i.e
> memhp_get_pluggable_range() to unify
> 
> 1. Generic check_hotplug_memory_addressable()
> 2. Platform checks in arch_add_memory()
> 
> This unified function can be called just at the beginning of memory
> hotplug so that both (1) and (2) can be dropped all together. This
> is just a logical extension which does improve the memory hotplug
> implementation (in itself) by failing earlier and while at it, also
> unifying generic and platform specific range constraints. Both the
> use cases are orthogonal IMHO.

As longs as it simplifies the code sure. But at least in the s390x case,
we cannot get rid of the internal checks.

-- 
Thanks,

David / dhildenb

