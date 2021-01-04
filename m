Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7962E9841
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbhADPQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:16:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727247AbhADPQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609773329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1tURH2mNefqhnNnUnQjY6v+e24ug8ico6rEnMWo4hE=;
        b=L6rO9977OxpG0y/yNHKoJwGFdCmVymyOqUKHTYEJFCuVoxCjhTInQKLvKgASxuEKRWvxbW
        HxmQIPDpy5O4PIM2RuoAGu+3GJeP7vuo5HfQgd/VwJ9oMxcbsjXaVLFPviMdO3h5yLVah+
        IKLkMeG+UuOJm9pPQQIRFH3bkE5HYO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-fK8VwcpgMeGnbf-CnhPu4Q-1; Mon, 04 Jan 2021 10:15:27 -0500
X-MC-Unique: fK8VwcpgMeGnbf-CnhPu4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E45B107ACE3;
        Mon,  4 Jan 2021 15:15:25 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49DBF61F20;
        Mon,  4 Jan 2021 15:15:24 +0000 (UTC)
Subject: Re: uninitialized pmem struct pages
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <20210104142624.GI13207@dhcp22.suse.cz>
 <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
 <20210104151005.GK13207@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <26db2c3e-10c7-c6e3-23f7-21eb5101b31a@redhat.com>
Date:   Mon, 4 Jan 2021 16:15:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210104151005.GK13207@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.21 16:10, Michal Hocko wrote:
> On Mon 04-01-21 15:51:35, David Hildenbrand wrote:
>> On 04.01.21 15:26, Michal Hocko wrote:
>>> On Mon 04-01-21 11:45:39, David Hildenbrand wrote:
> [....]
>>>> One instance where this is still an issue is
>>>> mm/memory-failure.c:memory_failure() and
>>>> mm/memory-failure.c:soft_offline_page(). I thought for a while about
>>>> "fixing" these, but to me it felt like fixing pfn_to_online_page() is
>>>> actually the right approach.
>>>>
>>>> But worse, before ZONE_DEVICE hot-add
>>>> 1. The whole section memmap does already exist (early sections always
>>>> have a full memmap for the whole section)
>>>> 2. The whole section memmap is initialized (although eventually with
>>>> dummy node/zone 0/0 for memory holes until that part is fixed) and might
>>>> be accessed by pfn walkers.
>>>>
>>>> So when hotadding ZONE_DEVICE we are modifying already existing and
>>>> visible memmaps. Bad.
>>>
>>> Could you elaborate please?
>>
>> Simplistic example: Assume you have a VM with 64MB on x86-64.
>>
>> We need exactly one memory section (-> one memory block device). We
>> allocate the memmap for a full section - an "early section". So we have
>> a memmap for 128MB, while 64MB are actually in use, the other 64MB is
>> initialized (like a memory hole). pfn_to_online_page() would return a
>> valid struct page for the whole section memmap.
>>
>> The remaining 64MB can later be used for hot-adding ZONE_DEVICE memory,
>> essentially re-initializing that part of the already-existing memmap.
>>
>> See pfn_valid():
>>
>> /*
>>  * Traditionally early sections always returned pfn_valid() for
>>  * the entire section-sized span.
>>  */
>> return early_section(ms) || pfn_section_valid(ms, pfn);
>>
>>
>> Depending on the memory layout of the system, a pfn walker might just be
>> about to stumble over this range getting re-initialized.
> 
> Right. But as long as pfn walkers are not synchronized with the memory
> hotplug this is a general problem with any struct page. Whether it
> belongs to pmem or a regular memory, no?

Yes, however in this case even the memory hotplug lock does not help.
But yes, related issues.

> 
>>>> 2. Deferred init of ZONE_DEVICE ranges
>>>>
>>>> memmap_init_zone_device() runs after the ZONE_DEVICE zone was resized
>>>> and outside the memhp lock. I did not follow if the use of
>>>> get_dev_pagemap() actually makes sure that memmap_init_zone_device() in
>>>> pagemap_range() actually completed. I don't think it does.
>>>
>>> So a pfn walker can see an unitialized struct page for a while, right?
>>>
>>> The problem that I have encountered is that some zone device pages are
>>> not initialized at all. That sounds like a different from those 2 above.
>>> I am having hard time to track what kind of pages those are and why we
>>> cannot initialized their zone/node and make them reserved at least.
>>
>> And you are sure that these are in fact ZONE_DEVICE pages? Not memory
>> holes e.g., tackled by
> 
> Well, the physical address matches the pmem range so I believe this is
> the case.
> 
> [...]
>> However, I do remember a discussion regarding "reserved altmap space"
>> ZONE_DEVICE ranges, and whether to initialize them or leave them
>> uninitialized. See comment in
>>
>> commit 77e080e7680e1e615587352f70c87b9e98126d03
>> Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Date:   Fri Oct 18 20:19:39 2019 -0700
>>
>>     mm/memunmap: don't access uninitialized memmap in memunmap_pages()
> 
> yes, the reserved altmap space sounds like it might be it.

[...]

> Would it be possible to iterate over the reserved space and initialize
> Node/zones at least?

Right, I was confused by the terminology. We actually initialize the
pages used for memory mapping in
move_pfn_range_to_zone()->memmap_init_zone(). But we seem to exclude the
"reserved space" - I think for good reason.

I think the issue is that this "reserved space" might actually get
overridden by something else later, as it won't be used as a memmap, but
just to store "anything".

Do the physical addresses you see fall into the same section as boot
memory? Or what's around these addresses?


-- 
Thanks,

David / dhildenb

