Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057F62FFF47
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 10:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbhAVJdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 04:33:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727319AbhAVJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611306491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZwUYf9xT+MJixbOCKQ4HvzTm+Igo1sOFFZAbd0tACA=;
        b=KFS3Ltxumh6EwOEyIAX+UKruWtP1so98+F28Zw4g7BFjm3apBKSCYGTK6NEPA3njqoiPYx
        hgRdckUX7lKooW/nfRQE2YgsDrwFrDQ+DzxVKFIXSvYMLQwFZRP5GEbdby+VqmruZW6Z1r
        Zsft0miBzRnAuJRH+30S8jd7CFRC4JU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-_Fh2C1fwP36C846eFQQRTA-1; Fri, 22 Jan 2021 04:08:09 -0500
X-MC-Unique: _Fh2C1fwP36C846eFQQRTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8C331005513;
        Fri, 22 Jan 2021 09:08:07 +0000 (UTC)
Received: from [10.36.114.142] (ovpn-114-142.ams2.redhat.com [10.36.114.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCFAA722C2;
        Fri, 22 Jan 2021 09:08:06 +0000 (UTC)
Subject: Re: [PATCH] mm: fix prototype warning from kernel test robot
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rppt@kernel.org
References: <20210122070359.24010-1-bhe@redhat.com>
 <3fd62f11-bf44-3ede-aed1-10d9d4849f00@redhat.com>
 <20210122084659.GA29905@MiWiFi-R3L-srv>
 <91244046-f5a0-8e67-4c92-fe9de118e472@redhat.com>
 <20210122085836.GA31398@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1f05a1ee-fcfa-4abb-74f3-d47b64378a4a@redhat.com>
Date:   Fri, 22 Jan 2021 10:08:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210122085836.GA31398@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.21 09:58, Baoquan He wrote:
> On 01/22/21 at 09:55am, David Hildenbrand wrote:
>> On 22.01.21 09:46, Baoquan He wrote:
>>> On 01/22/21 at 09:40am, David Hildenbrand wrote:
>>>> On 22.01.21 08:03, Baoquan He wrote:
>>>>> Kernel test robot calling make with 'W=1' triggering warning like below
>>>>> below for memmap_init_zone() function.
>>>>>
>>>>> mm/page_alloc.c:6259:23: warning: no previous prototype for 'memmap_init_zone' [-Wmissing-prototypes]
>>>>>  6259 | void __meminit __weak memmap_init_zone(unsigned long size, int nid,
>>>>>       |                       ^~~~~~~~~~~~~~~~
>>>>>
>>>>> Fix it by adding the function declaration in include/linux/mm.h.
>>>>> Since memmap_init_zone() has a generic version with '__weak',
>>>>> the declaratoin in ia64 header file can be simply removed.
>>>>>
>>>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> ---
>>>>>  arch/ia64/include/asm/pgtable.h | 5 -----
>>>>>  include/linux/mm.h              | 1 +
>>>>>  2 files changed, 1 insertion(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
>>>>> index 2c81394a2430..9b4efe89e62d 100644
>>>>> --- a/arch/ia64/include/asm/pgtable.h
>>>>> +++ b/arch/ia64/include/asm/pgtable.h
>>>>> @@ -517,11 +517,6 @@ extern struct page *zero_page_memmap_ptr;
>>>>>  	__changed;							\
>>>>>  })
>>>>>  #endif
>>>>> -
>>>>> -#  ifdef CONFIG_VIRTUAL_MEM_MAP
>>>>> -  /* arch mem_map init routine is needed due to holes in a virtual mem_map */
>>>>> -    extern void memmap_init_zone(struct zone *zone);
>>>>> -#  endif /* CONFIG_VIRTUAL_MEM_MAP */
>>>>>  # endif /* !__ASSEMBLY__ */
>>>>>  
>>>>>  /*
>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>> index 56bb239f9150..073049bd0b29 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -2401,6 +2401,7 @@ extern void set_dma_reserve(unsigned long new_dma_reserve);
>>>>>  extern void memmap_init_range(unsigned long, int, unsigned long,
>>>>>  		unsigned long, unsigned long, enum meminit_context,
>>>>>  		struct vmem_altmap *, int migratetype);
>>>>> +extern void memmap_init_zone(struct zone *zone);
>>>>>  extern void setup_per_zone_wmarks(void);
>>>>>  extern int __meminit init_per_zone_wmark_min(void);
>>>>>  extern void mem_init(void);
>>>>>
>>>>
>>>> This patch is on top of your other series, no?
>>>>
>>>> In -next, we have
>>>>
>>>> extern void memmap_init_zone(unsigned long, int, unsigned long, ...
>>>>
>>>> In that file, so something is wrong.
>>>
>>> Right, this one is based on the memmap_init_xx clean up patchset. I
>>> mentioned this the the sub-thread of kernel test robot reporting issues.
>>>
>>
>> I think it would make things easier to move that fix to the front and
>> resend the whole (5 patches) series.
> 
> OK, it's fine to me, will resend a series adding this one in. I also
> need polish log of this patch. Thanks for looking into this.
> 

I'll review ASAP once you resend :)

-- 
Thanks,

David / dhildenb

