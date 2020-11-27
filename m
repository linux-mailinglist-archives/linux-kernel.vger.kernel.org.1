Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055902C6148
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgK0JBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:01:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgK0JBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606467677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zcL80gC957ZXpCuzn/NTC84w2oGL6gfOZNF40t+NUkI=;
        b=d22VxrujLmSEeFNrpbKZfiCCEWsoM1ZJ/+w1yZ50I92jT4QzZV7me3wOEvloC+GIJHo+9A
        2KlKrYtfTojFR+2oFSNL+MHtnecVsIPz1Gpol2KsyRBOYHPhQbu5266tvu9p2Z6EfjKtMU
        U1oJU8B9U8iL9U3uctWPSPS4XMJ9B7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-TcUDHkY-O9uVveqd3xc41A-1; Fri, 27 Nov 2020 04:01:15 -0500
X-MC-Unique: TcUDHkY-O9uVveqd3xc41A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56EF157203;
        Fri, 27 Nov 2020 09:01:14 +0000 (UTC)
Received: from [10.36.114.118] (ovpn-114-118.ams2.redhat.com [10.36.114.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 365235D9CC;
        Fri, 27 Nov 2020 09:01:13 +0000 (UTC)
Subject: Re: [RFC 1/3] mm/hotplug: Pre-validate the address range with
 platform
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
 <1606098529-7907-2-git-send-email-anshuman.khandual@arm.com>
 <13392308-45a8-f85d-b25e-4a728e1e0730@redhat.com>
 <0c13a221-570a-0d64-fce9-d28e52cbdd6c@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8886f78e-28cf-ded0-1629-d4206205be96@redhat.com>
Date:   Fri, 27 Nov 2020 10:01:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <0c13a221-570a-0d64-fce9-d28e52cbdd6c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> "arch_get_mappable_range(void)" (or similar) ?
> 
> The current name seems bit better (I guess). Because we are asking for
> max addressable range with or without the linear mapping.
> 
>>
>> AFAIKs, both implementations (arm64/s390x) simply do the exact same
>> thing as memhp_get_pluggable_range() for !need_mapping.
> 
> That is for now. Even the range without requiring linear mapping might not
> be the same (like now) for every platform as some might have constraints.
> So asking the platform ranges with or without linear mapping seems to be
> better and could accommodate special cases going forward. Anyways, there
> is an always an "all allowing" fallback option nonetheless.

Let's keep it simple as long as we don't have a real scenario where this
would apply.

[...]

> 
>>
>>> +		return true;
>>> +
>>> +	WARN(1, "Hotplug memory [%#llx-%#llx] exceeds maximum addressable range [%#llx-%#llx]\n",
>>> +		start, end, memhp_range.start, memhp_range.end);
>>
>> pr_warn() (or even pr_warn_once())
>>
>> while we're at it. No reason to eventually crash a system :)
> 
> Didn't quite get it. How could this crash the system ?

With panic_on_warn, which some distributions started to enable.

[...]

>>>  		/*
>>>  		 * Validate altmap is within bounds of the total request
>>> @@ -1109,6 +1089,9 @@ int __ref __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
>>>  	struct resource *res;
>>>  	int ret;
>>>  
>>> +	if (!memhp_range_allowed(start, size, 1))
>>> +		return -ERANGE;
>>
>> We used to return -E2BIG, no? Maybe better keep that.
> 
> ERANGE seems to be better as the range can overrun on either side.

Did you check all callers that they can handle it? Should mention that
in the patch description then.

> 
>>
>>> +
>>>  	res = register_memory_resource(start, size, "System RAM");
>>>  	if (IS_ERR(res))
>>>  		return PTR_ERR(res);
>>> @@ -1123,6 +1106,9 @@ int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
>>>  {
>>>  	int rc;
>>>  
>>> +	if (!memhp_range_allowed(start, size, 1))
>>> +		return -ERANGE;
>>> +
>>>  	lock_device_hotplug();
>>>  	rc = __add_memory(nid, start, size, mhp_flags);
>>>  	unlock_device_hotplug();
>>> @@ -1163,6 +1149,9 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
>>>  	    resource_name[strlen(resource_name) - 1] != ')')
>>>  		return -EINVAL;
>>>  
>>> +	if (!memhp_range_allowed(start, size, 0))
>>> +		return -ERANGE;
>>> +
>>>  	lock_device_hotplug();
>>
>> For all 3 cases, doing a single check in register_memory_resource() is
>> sufficient.
> 
> Will replace with a single check in register_memory_resource(). But does
> add_memory_driver_managed() always require linear mapping ? The proposed
> check here did not ask for linear mapping in add_memory_driver_managed().

Yes, in that regard, it behaves just like add_memory().



-- 
Thanks,

David / dhildenb

