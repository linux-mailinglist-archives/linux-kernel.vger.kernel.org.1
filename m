Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBF42FCF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbhATLjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:39:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46000 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387642AbhATKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611139197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtHg9smHqxIpjluq3oLZYsQNrVvpjsSlKeat5q09TUI=;
        b=fDFixzpszXfmd2nexW83+l+On0o72uJfYOSZx2EMp7v7hzkwkPON7IDsi6N10q2tWT8owp
        xXYKDH2XIs9go+gDpzyL8jcMjdh0iL/LbaW/27IEHXiCaQmSebYNZ3u6D1DxwrBir0quX4
        nzbnZcRg66LLXd3B0HRwbr8CNm2w1Zw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-9yww2jV9OASCNtYxr91j0g-1; Wed, 20 Jan 2021 05:39:55 -0500
X-MC-Unique: 9yww2jV9OASCNtYxr91j0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A2171005D44;
        Wed, 20 Jan 2021 10:39:53 +0000 (UTC)
Received: from [10.36.115.161] (ovpn-115-161.ams2.redhat.com [10.36.115.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A27FA5D9C2;
        Wed, 20 Jan 2021 10:39:50 +0000 (UTC)
Subject: Re: [PATCH V3 3/3] s390/mm: Define arch_get_mappable_range()
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
 <1610975582-12646-4-git-send-email-anshuman.khandual@arm.com>
 <cbdb32af-74af-ceb2-fa68-3912ef20d784@redhat.com>
 <a58eb974-4700-d877-7033-4ad6dfd2476f@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <31c19215-3f25-4d60-29f6-77127c05abbb@redhat.com>
Date:   Wed, 20 Jan 2021 11:39:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <a58eb974-4700-d877-7033-4ad6dfd2476f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.21 09:28, Anshuman Khandual wrote:
> 
> 
> On 1/19/21 5:56 PM, David Hildenbrand wrote:
>> On 18.01.21 14:13, Anshuman Khandual wrote:
>>> This overrides arch_get_mappabble_range() on s390 platform which will be
>>> used with recently added generic framework. It modifies the existing range
>>> check in vmem_add_mapping() using arch_get_mappable_range(). It also adds a
>>> VM_BUG_ON() check that would ensure that memhp_range_allowed() has already
>>> been called on the hotplug path.
>>>
>>> Cc: Heiko Carstens <hca@linux.ibm.com>
>>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: linux-s390@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>  arch/s390/mm/init.c |  1 +
>>>  arch/s390/mm/vmem.c | 15 ++++++++++++++-
>>>  2 files changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>>> index 73a163065b95..97017a4bcc90 100644
>>> --- a/arch/s390/mm/init.c
>>> +++ b/arch/s390/mm/init.c
>>> @@ -297,6 +297,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>  	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>>>  		return -EINVAL;
>>>  
>>> +	VM_BUG_ON(!memhp_range_allowed(start, size, true));
>>>  	rc = vmem_add_mapping(start, size);
>>>  	if (rc)
>>>  		return rc;
>>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>>> index 01f3a5f58e64..afc39ff1cc8d 100644
>>> --- a/arch/s390/mm/vmem.c
>>> +++ b/arch/s390/mm/vmem.c
>>> @@ -4,6 +4,7 @@
>>>   *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
>>>   */
>>>  
>>> +#include <linux/memory_hotplug.h>
>>>  #include <linux/memblock.h>
>>>  #include <linux/pfn.h>
>>>  #include <linux/mm.h>
>>> @@ -532,11 +533,23 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>>>  	mutex_unlock(&vmem_mutex);
>>>  }
>>>  
>>> +struct range arch_get_mappable_range(void)
>>> +{
>>> +	struct range memhp_range;
>>
>> You could do:
>>
>> memhp_range = {
>> 	.start = 0,
>> 	.end =  VMEM_MAX_PHYS - 1,
>> };
>>
>> Similar in the arm64 patch.
> 
> There is a comment block just before this assignment on arm64. Also
> it seems like code style preference and Heiko had originally agreed
> on this particular patch. Could we just leave it unchanged please ?

That's not how review works. But as I said, "You could do".

-- 
Thanks,

David / dhildenb

