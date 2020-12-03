Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7C42CD510
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgLCMCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:02:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729035AbgLCMCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606996867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xa3xb2moiuKougPYQgCIxOSC16hacVe+/4oGyGlf0T4=;
        b=PXTf6g9Le6h0mo4hVCC9KuUMZyUhwbHD7N2Gb0Atck03f0I18h4oelYJqx0QdzDMgY7wiS
        lRjGNbMmGGjRbZjnpNlQYke5sr3sWWq88WLV5DTUepD3MjrDjwUJqj61QhPtP78moA+7V8
        tmrUFpUw4HJi/uIkTaVPT+ftmFUwGLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-NokD7zRZPviXIiyVeOgD6Q-1; Thu, 03 Dec 2020 07:01:06 -0500
X-MC-Unique: NokD7zRZPviXIiyVeOgD6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08447A0C04;
        Thu,  3 Dec 2020 12:01:04 +0000 (UTC)
Received: from [10.36.113.250] (ovpn-113-250.ams2.redhat.com [10.36.113.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58E7B27C40;
        Thu,  3 Dec 2020 12:01:02 +0000 (UTC)
Subject: Re: [RFC V2 3/3] s390/mm: Define arch_get_mappable_range()
To:     Heiko Carstens <hca@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <1606706992-26656-4-git-send-email-anshuman.khandual@arm.com>
 <20201202203233.GB11274@osiris>
 <24905c32-f6c1-97a0-000f-f822b9870ea5@arm.com> <20201203115133.GB9994@osiris>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4d6c9ec4-f1be-46b9-5d67-5c53f5afedc5@redhat.com>
Date:   Thu, 3 Dec 2020 13:01:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203115133.GB9994@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.12.20 12:51, Heiko Carstens wrote:
> On Thu, Dec 03, 2020 at 06:03:00AM +0530, Anshuman Khandual wrote:
>>>> diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
>>>> index 5060956b8e7d..cc055a78f7b6 100644
>>>> --- a/arch/s390/mm/extmem.c
>>>> +++ b/arch/s390/mm/extmem.c
>>>> @@ -337,6 +337,11 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
>>>>  		goto out_free_resource;
>>>>  	}
>>>>  
>>>> +	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
>>>> +		rc = -ERANGE;
>>>> +		goto out_resource;
>>>> +	}
>>>> +
>>>>  	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
>>>>  	if (rc)
>>>>  		goto out_resource;
>>>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>>>> index b239f2ba93b0..06dddcc0ce06 100644
>>>> --- a/arch/s390/mm/vmem.c
>>>> +++ b/arch/s390/mm/vmem.c
>>>> @@ -532,14 +532,19 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>>>>  	mutex_unlock(&vmem_mutex);
>>>>  }
>>>>  
>>>> +struct range arch_get_mappable_range(void)
>>>> +{
>>>> +	struct range memhp_range;
>>>> +
>>>> +	memhp_range.start = 0;
>>>> +	memhp_range.end =  VMEM_MAX_PHYS;
>>>> +	return memhp_range;
>>>> +}
>>>> +
>>>>  int vmem_add_mapping(unsigned long start, unsigned long size)
>>>>  {
>>>>  	int ret;
>>>>  
>>>> -	if (start + size > VMEM_MAX_PHYS ||
>>>> -	    start + size < start)
>>>> -		return -ERANGE;
>>>> -
>>>
>>> I really fail to see how this could be considered an improvement for
>>> s390. Especially I do not like that the (central) range check is now
>>> moved to the caller (__segment_load). Which would mean potential
>>> additional future callers would have to duplicate that code as well.
>>
>> The physical range check is being moved to the generic hotplug code
>> via arch_get_mappable_range() instead, making the existing check in
>> vmem_add_mapping() redundant. Dropping the check there necessitates
>> adding back a similar check in __segment_load(). Otherwise there
>> will be a loss of functionality in terms of range check.
>>
>> May be we could just keep this existing check in vmem_add_mapping()
>> as well in order avoid this movement but then it would be redundant
>> check in every hotplug path.
>>
>> So I guess the choice is to either have redundant range checks in
>> all hotplug paths or future internal callers of vmem_add_mapping()
>> take care of the range check.
> 
> The problem I have with this current approach from an architecture
> perspective: we end up having two completely different methods which
> are doing the same and must be kept in sync. This might be obvious
> looking at this patch, but I'm sure this will go out-of-sync (aka
> broken) sooner or later.

Exactly, there should be one function only that was the whole idea of
arch_get_mappable_range().

> 
> Therefore I would really like to see a single method to do the range
> checking. Maybe you could add a callback into architecture code, so
> that such an architecture specific function could also be used
> elsewhere. Dunno.
> 

I think we can just switch to using "memhp_range_allowed()" here then
after implementing arch_get_mappable_range().

Doesn't hurt to double check in vmem_add_mapping() - especially to keep
extmem working without changes. At least for callers of memory hotplug
it's then clear which values actually won't fail deep down in arch code.

-- 
Thanks,

David / dhildenb

