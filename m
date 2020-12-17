Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87C32DD171
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 13:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgLQMU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 07:20:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbgLQMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 07:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608207540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=viLhS8xW7gKOS2yg0+t5Te6Nn9vhuVMrCXMXWpSifM4=;
        b=VPfkImcz2XxsKtwVzHdGIpo09qsHm7UMS6E+b54V134RE7xlGYgFRX6tFTma7TxzjmNkaU
        SXvtxBaAF/ZfY135TvAgKLSkigPztleH3AMbt9+uswgca0lVfor7IbiJM8UYXPkdu0+uRL
        ejWkFe7gyzOktwA2ETtmuqhTNLSzU5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-41ZBC6aaN6G_Q16Yn2BX7g-1; Thu, 17 Dec 2020 07:18:56 -0500
X-MC-Unique: 41ZBC6aaN6G_Q16Yn2BX7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DB6E59;
        Thu, 17 Dec 2020 12:18:54 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E8F060C15;
        Thu, 17 Dec 2020 12:18:51 +0000 (UTC)
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
 <401e72a7-7865-455a-4c7f-79278e3f0af0@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <62e44a97-0402-2a2b-5364-9b2744814011@redhat.com>
Date:   Thu, 17 Dec 2020 13:18:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <401e72a7-7865-455a-4c7f-79278e3f0af0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.20 12:45, Anshuman Khandual wrote:
> 
> 
> On 12/10/20 12:34 PM, David Hildenbrand wrote:
>>
>>> Am 10.12.2020 um 07:58 schrieb Heiko Carstens <hca@linux.ibm.com>:
>>>
>>> ﻿On Thu, Dec 10, 2020 at 09:48:11AM +0530, Anshuman Khandual wrote:
>>>>>> Alternatively leaving __segment_load() and vmem_add_memory() unchanged
>>>>>> will create three range checks i.e two memhp_range_allowed() and the
>>>>>> existing VMEM_MAX_PHYS check in vmem_add_mapping() on all the hotplug
>>>>>> paths, which is not optimal.
>>>>>
>>>>> Ah, sorry. I didn't follow this discussion too closely. I just thought
>>>>> my point of view would be clear: let's not have two different ways to
>>>>> check for the same thing which must be kept in sync.
>>>>> Therefore I was wondering why this next version is still doing
>>>>> that. Please find a way to solve this.
>>>>
>>>> The following change is after the current series and should work with
>>>> and without memory hotplug enabled. There will be just a single place
>>>> i.e vmem_get_max_addr() to update in case the maximum address changes
>>>> from VMEM_MAX_PHYS to something else later.
>>>
>>> Still not. That's way too much code churn for what you want to achieve.
>>> If the s390 specific patch would look like below you can add
>>>
>>> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>>>
>>> But please make sure that the arch_get_mappable_range() prototype in
>>> linux/memory_hotplug.h is always visible and does not depend on
>>> CONFIG_MEMORY_HOTPLUG. I'd like to avoid seeing sparse warnings
>>> because of this.
>>>
>>> Thanks.
>>>
>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>>> index 77767850d0d0..e0e78234ae57 100644
>>> --- a/arch/s390/mm/init.c
>>> +++ b/arch/s390/mm/init.c
>>> @@ -291,6 +291,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>    if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>>>        return -EINVAL;
>>>
>>> +    VM_BUG_ON(!memhp_range_allowed(start, size, 1));
>>>    rc = vmem_add_mapping(start, size);
>>>    if (rc)
>>>        return rc;
>>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>>> index b239f2ba93b0..ccd55e2f97f9 100644
>>> --- a/arch/s390/mm/vmem.c
>>> +++ b/arch/s390/mm/vmem.c
>>> @@ -4,6 +4,7 @@
>>>  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
>>>  */
>>>
>>> +#include <linux/memory_hotplug.h>
>>> #include <linux/memblock.h>
>>> #include <linux/pfn.h>
>>> #include <linux/mm.h>
>>> @@ -532,11 +533,23 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>>>    mutex_unlock(&vmem_mutex);
>>> }
>>>
>>> +struct range arch_get_mappable_range(void)
>>> +{
>>> +    struct range range;
>>> +
>>> +    range.start = 0;
>>> +    range.end = VMEM_MAX_PHYS;
>>> +    return range;
>>> +}
>>> +
>>> int vmem_add_mapping(unsigned long start, unsigned long size)
>>> {
>>> +    struct range range;
>>>    int ret;
>>>
>>> -    if (start + size > VMEM_MAX_PHYS ||
>>> +    range = arch_get_mappable_range();
>>> +    if (start < range.start ||
>>> +        start + size > range.end ||
>>>        start + size < start)
>>>        return -ERANGE;
>>>
>>>
>>
>> Right, what I had in mind as reply to v1. Not sure if we really need new checks in common code. Having a new memhp_get_pluggable_range() would be sufficient for my use case (virtio-mem).
> 
> Hello David,
> 
> Quick question. Currently memhp_get_pluggable_range() is a mm/memory_hotplug.c
> internal static inline function. Only memhp_range_allowed() is available via
> the header include/linux/memory_hotplug.h But For memhp_get_pluggable_range()
> to be visible to the drivers, it needs to get included in the header and also
> be exported via EXPORT_SYMBOL_GPL() in mm/memory_hotplug.c OR just move the
> entire definition as static inline into the header itself. Wondering which way
> would be better ?

As it's most likely not on any hot path, exporting the symbol might be
the cleanest approach.

> 
> - Anshuman
> 


-- 
Thanks,

David / dhildenb

