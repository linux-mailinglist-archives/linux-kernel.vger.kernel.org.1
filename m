Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA84721080D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 11:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgGAJ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 05:27:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41868 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728812AbgGAJ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593595663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=2nsia7hoWJXpo2twiK/t+26Uc4uSozlsBwnZUcpoESQ=;
        b=R6ajc9hrEiKjX674he0RITkMENmvKbmOY97umWqv+C6vb8+q0PY/GP3MP0EKFCQS1oN11e
        XNhbSJ7ph8JzUoXsoNJ3iTDiMUkSAWS24NrDVOG4MD4vKVa3djbhZbN1QUinhMO88c7u5h
        rlAGCOwM0GgOpU528kc1rub/6zaUgDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-fAZK4nTsPFW4gTPbDDDFQQ-1; Wed, 01 Jul 2020 05:27:40 -0400
X-MC-Unique: fAZK4nTsPFW4gTPbDDDFQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89ECA107ACF4;
        Wed,  1 Jul 2020 09:27:39 +0000 (UTC)
Received: from [10.36.112.52] (ovpn-112-52.ams2.redhat.com [10.36.112.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C22D7C1EE;
        Wed,  1 Jul 2020 09:27:38 +0000 (UTC)
Subject: Re: [PATCH] mm/sparse: only sub-section aligned range would be
 populated
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     dan.j.williams@intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200630021436.43281-1-richard.weiyang@linux.alibaba.com>
 <f1e6036c-1966-56dd-0acf-e795671c5ec4@redhat.com>
 <20200701023258.GA51545@L-31X9LVDL-1304.local>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <ed889007-0363-b719-c4bc-9591f87b046c@redhat.com>
Date:   Wed, 1 Jul 2020 11:27:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701023258.GA51545@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.07.20 04:32, Wei Yang wrote:
> On Tue, Jun 30, 2020 at 02:52:35PM +0200, David Hildenbrand wrote:
>> On 30.06.20 04:14, Wei Yang wrote:
>>> There are two code path which invoke __populate_section_memmap()
>>>
>>>   * sparse_init_nid()
>>>   * sparse_add_section()
>>>
>>> For both case, we are sure the memory range is sub-section aligned.
>>>
>>>   * we pass PAGES_PER_SECTION to sparse_init_nid()
>>>   * we check range by check_pfn_span() before calling
>>>     sparse_add_section()
>>>
>>> Also, the counterpart of __populate_section_memmap(), we don't do such
>>> calculation and check since the range is checked by check_pfn_span() in
>>> __remove_pages().
>>>
>>> Clear the calculation and check to keep it simple and comply with its
>>> counterpart.
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>> ---
>>>  mm/sparse-vmemmap.c | 16 ++--------------
>>>  1 file changed, 2 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>> index 0db7738d76e9..24b01ebae111 100644
>>> --- a/mm/sparse-vmemmap.c
>>> +++ b/mm/sparse-vmemmap.c
>>> @@ -247,20 +247,8 @@ int __meminit vmemmap_populate_basepages(unsigned long start,
>>>  struct page * __meminit __populate_section_memmap(unsigned long pfn,
>>>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>>>  {
>>> -	unsigned long start;
>>> -	unsigned long end;
>>> -
>>> -	/*
>>> -	 * The minimum granularity of memmap extensions is
>>> -	 * PAGES_PER_SUBSECTION as allocations are tracked in the
>>> -	 * 'subsection_map' bitmap of the section.
>>> -	 */
>>> -	end = ALIGN(pfn + nr_pages, PAGES_PER_SUBSECTION);
>>> -	pfn &= PAGE_SUBSECTION_MASK;
>>> -	nr_pages = end - pfn;
>>> -
>>> -	start = (unsigned long) pfn_to_page(pfn);
>>> -	end = start + nr_pages * sizeof(struct page);
>>> +	unsigned long start = (unsigned long) pfn_to_page(pfn);
>>> +	unsigned long end = start + nr_pages * sizeof(struct page);
>>>  
>>>  	if (vmemmap_populate(start, end, nid, altmap))
>>>  		return NULL;
>>>
>>
>> Can we add a WARN_ON_ONCE to catch mis-use in the future?
>>
>> if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
>>                 !IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION))
>> 	return NULL;
> 
> How about to add this into both population and depopulation?

We don't have a similar wrapper for vmemmap_free().

-- 
Thanks,

David / dhildenb

