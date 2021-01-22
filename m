Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C18A3000A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbhAVKsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:48:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727128AbhAVKpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611312215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOiwNG6fgOv20bcfxuNZKLeDFXi6SHU3aWeO6DKQNDI=;
        b=BRdz02P8rwGXF5NA0gJvafSdWk3XUvHYINtJbgVM4RkodMRSU0709eBFuI6jHZwsWhaHlS
        6JX6hzNLX0h7JzNqzTIF/ARQ5K3qiJGaMuKIfKBD+oLzMth+L9InI4iadMPntSM/3JmccG
        6uawINRbNijmIb5woGU2D1e96TCw0Vo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-0UHyWJOsNFCMDQ649xP5OA-1; Fri, 22 Jan 2021 05:43:31 -0500
X-MC-Unique: 0UHyWJOsNFCMDQ649xP5OA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EE6880BCB4;
        Fri, 22 Jan 2021 10:43:29 +0000 (UTC)
Received: from [10.36.114.142] (ovpn-114-142.ams2.redhat.com [10.36.114.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 845805D9CA;
        Fri, 22 Jan 2021 10:43:26 +0000 (UTC)
Subject: Re: [PATCH V3 1/3] mm/memory_hotplug: Prevalidate the address range
 being added with platform
From:   David Hildenbrand <david@redhat.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
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
 <897c31ba-d3bd-b694-8c87-82e784a60c51@arm.com>
 <5e133a5e-41bb-9d6b-f76e-a96d3efe0f5e@redhat.com>
Organization: Red Hat GmbH
Message-ID: <417b574c-309e-6d5d-36e4-9b16d82c54a6@redhat.com>
Date:   Fri, 22 Jan 2021 11:43:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <5e133a5e-41bb-9d6b-f76e-a96d3efe0f5e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.21 11:42, David Hildenbrand wrote:
> On 22.01.21 11:41, Anshuman Khandual wrote:
>>
>> On 1/22/21 2:48 PM, David Hildenbrand wrote:
>>>
>>>> +/*
>>>> + * Platforms should define arch_get_mappable_range() that provides
>>>> + * maximum possible addressable physical memory range for which the
>>>> + * linear mapping could be created. The platform returned address
>>>> + * range must adhere to these following semantics.
>>>> + *
>>>> + * - range.start <= range.end
>>>> + * - Range includes both end points [range.start..range.end]
>>>> + *
>>>> + * There is also a fallback definition provided here, allowing the
>>>> + * entire possible physical address range in case any platform does
>>>> + * not define arch_get_mappable_range().
>>>> + */
>>>> +struct range __weak arch_get_mappable_range(void)
>>>> +{
>>>> +	struct range memhp_range = {
>>>> +		.start = 0UL,
>>>> +		.end = -1ULL,
>>>> +	};
>>>> +	return memhp_range;
>>>> +}
>>>> +
>>>> +struct range memhp_get_pluggable_range(bool need_mapping)
>>>> +{
>>>> +	const u64 max_phys = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;
>>>
>>> Sorry, thought about that line a bit more, and I think this is just
>>> wrong (took me longer to realize as it should). The old code used this
>>> calculation to print the limit only (in a wrong way), let's recap:
>>>
>>> Assume MAX_PHYSMEM_BITS=32
>>>
>>> 	max_phys = (1ULL << (32 + 1)) - 1 = 0x1ffffffffull;
>>>
>>> Ehm, these are 33 bit.
>>>
>>> OTOH, old code checked for
>>>
>>> 	if (max_addr >> MAX_PHYSMEM_BITS) {
>>>
>>> Which makes sense, because
>>>
>>> 	0x1ffffffffull >> 32 = 1
>>>
>>> results in "true", meaning it's to big, while
>>>
>>> 	0xffffffffull >> 32 = 0
>>>
>>> correctly results in "false", meaning the address is fine.
>>>
>>>
>>>
>>> So, this should just be
>>>
>>> const u64 max_phys = 1ULL << MAX_PHYSMEM_BITS;
>>>
>>> (similarly as calculated in virito-mem code, or in kernel/resource.c)
>>
>> Should this be 1ULL << MAX_PHYSMEM_BITS - 1 instead ? Currently there are
> 
> Yes, obviously, sorry, forgot the -1.
> 

const u64 max_phys = (1ULL << MAX_PHYSMEM_BITS) - 1;

to be precise.

-- 
Thanks,

David / dhildenb

