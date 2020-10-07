Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2B0285AA2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgJGIjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727832AbgJGIjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602059951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=K7kkBLB4LmWktBQQQyJlNEIqp22tQV8Q0pHwxVqZhcA=;
        b=hx12AvDZDu1xQLTjxGuxkKCdoFaoVWlPklQekY1mmUlaCTm4FxxXdPW2WjZNbFQmfQO0FE
        jyNgtXc+8MjPPIAwg5yKw970jCALiO7b2g3eeW881jCLgERaIua0StN8CarioRgYU7/Rn3
        zGSdbu2K00nCUvXjqPNoFeOptCJyRns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-jHqr9XOfMkqnFVRZQU1K8A-1; Wed, 07 Oct 2020 04:39:08 -0400
X-MC-Unique: jHqr9XOfMkqnFVRZQU1K8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09CD4803F5D;
        Wed,  7 Oct 2020 08:39:06 +0000 (UTC)
Received: from [10.36.115.15] (ovpn-115-15.ams2.redhat.com [10.36.115.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 915F31002C2B;
        Wed,  7 Oct 2020 08:39:03 +0000 (UTC)
Subject: Re: [PATCH] arm64/mm: Validate hotplug range before creating linear
 mapping
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
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
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63W5Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAjwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <70a76220-9acd-06b6-e074-dc9cbb6668da@redhat.com>
Date:   Wed, 7 Oct 2020 10:39:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <72ea7056-5289-3eb0-eca9-a8444524667e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> We do have __add_pages()->check_hotplug_memory_addressable() where we
>> already check against MAX_PHYSMEM_BITS.
> 
> Initially, I thought about check_hotplug_memory_addressable() but the
> existing check that asserts end of hotplug wrt MAX_PHYSMEM_BITS, is
> generic in nature. AFAIK the linear mapping problem is arm64 specific,
> hence I was not sure whether to add an arch specific callback which
> will give platform an opportunity to weigh in for these ranges.

Also on s390x, the range where you can create an identity mapping depends on
- early kernel setup
- kasan

(I assume it's the same for all archs)

See arch/s390/mm/vmem.c:vmem_add_mapping(), which contains similar
checks (VMEM_MAX_PHYS).

> 
> But hold on, check_hotplug_memory_addressable() only gets called from
> __add_pages() after linear mapping creation in arch_add_memory(). How
> would it help ? We need some thing for add_memory(), its variants and
> also possibly for memremap_pages() when it calls arch_add_memory().
> 

Good point. We chose that place for simplicity when adding it (I was
favoring calling it at two places back then). Now, we might have good
reason to move the checks further up the call chain.

Most probably,

struct range memhp_get_addressable_range(bool need_mapping)
{
	...
}

Would make sense, to deal with memremap_pages() without identity mappings.

We have two options:

1. Generalize the checks, check early in applicable functions. Have a
single way to get applicable ranges, both in callers, and inside the
functions.

2. Keep the checks where they are. Add memhp_get_addressable_range() so
callers can figure limits out. It's less clear what the relation between
the different checks is. And it's likely if things change at one place
that we miss the other place.

>> struct range memhp_get_addressable_range(void)
>> {
>> 	const u64 max_phys = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1;
>> 	struct range range = arch_get_mappable_range();
> 
> What would you suggest as the default fallback range if a platform
> does not define this callback.

Just the largest possible range until we implement them. IIRC, an s390x
version should be easy to add.

> 
>>
>> 	if (range.start > max_phys) {
>> 		range.start = 0;
>> 		range.end = 0;
>> 	}
>> 	range.end = max_t(u64, range.end, max_phys);
> 
> min_t instead ?

Yeah :)

> 
>>
>> 	return range;
>> }
>>
>>
>> That, we can use in check_hotplug_memory_addressable(), and also allow
>> add_memory*() users to make use of it.
> 
> So this check would happen twice during a hotplug ?

Right now it's like calling a function with wrong arguments - you just
don't have a clue what valid arguments are, because non-obvious errors
(besides -ENOMEM, which is a temporary error) pop up deep down the call
chain.

For example, virito-mem would use it to detect during device
initialization the usable device range, and warn the user accordingly.
It currently manually checks for MAX_PHYSMEM_BITS, but that's just ugly.
Failing at random add_memory() calls (permanently!) is not so nice.

In case of DIMMs, we could use it to detect if adding parts of a DIMM
won't work (and warn the user early). We could try to add as much as
possible.

-- 
Thanks,

David / dhildenb

