Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71472929E1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgJSO7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729544AbgJSO7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603119539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6S2TV9dAHYTgZdlK1+oGRF6Req84/iEOIZPYDAw9Ys8=;
        b=KJljXpEs+C3u8IlOOauPVRFh1MXS9JR9HmUjmNGq6fkDz3leq4SVDYhchOcviCDEwI4nMP
        Sq81eIX/A7sSVqsPL+YVBs4UvKOqRDWmdFhclmbPTkDxYgrnJPrMVAWiuCzXP5TpljLHKk
        yY9B5/vGx9TToje+0l6Ev9k46IS1BWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-CTQUwtjQM2OMNQua7o8xKg-1; Mon, 19 Oct 2020 10:58:57 -0400
X-MC-Unique: CTQUwtjQM2OMNQua7o8xKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB66687507C;
        Mon, 19 Oct 2020 14:58:55 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35BA65B4AD;
        Mon, 19 Oct 2020 14:58:50 +0000 (UTC)
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
 <70a76220-9acd-06b6-e074-dc9cbb6668da@redhat.com>
 <40104165-aa6f-201c-4aa2-e3918978dc6e@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <34ab00af-ebdc-6b83-4ff6-1e7bb9f7c3a3@redhat.com>
Date:   Mon, 19 Oct 2020 16:58:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <40104165-aa6f-201c-4aa2-e3918978dc6e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Most probably,
>>
>> struct range memhp_get_addressable_range(bool need_mapping)
>> {
>> 	...
>> }
> 
> Something like this...
> 
> +struct memhp_range {
> +       u64 start;
> +       u64 end;
> +};

We do have struct range already in include/linux/range.h

> +
> +#ifndef arch_get_addressable_range
> +static inline struct memhp_range arch_get_mappable_range(bool need_mapping)
> +{
> +       struct memhp_range range = {
> +               .start = 0UL,
> +               .end = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1,

Or just set to -1ULL if it's only used in memhp_get_mappable_range(), to
keep things simple ().

> +       };
> +       return range;
> +}
> +#endif
> +
> +static inline struct memhp_range memhp_get_mappable_range(bool need_mapping)

due to "need_mapping" the function might better be called

memhp_get_pluggable_range()

or similar

> +{
> +       const u64 max_phys = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1;
> +       struct memhp_range range = arch_get_mappable_range(need_mapping);
> +
> +       if (range.start > max_phys) {
> +               range.start = 0;
> +               range.end = 0;
> +       }
> +       range.end = min_t(u64, range.end, max_phys);
> +       return range;
> +}
> +
> +static inline bool memhp_range_allowed(u64 start, u64 end, bool need_mapping)
> +{
> +       struct memhp_range range = memhp_get_mappable_range(need_mapping);
> +
> +       return (start <= end) && (start >= range.start) && (end <= range.end);

Keep in mind that in memory hotplug code, "end" is usually exclusive,
and "end" in "struct range" is inclusive (see range_len(), or how you
calculate max_phys.

So depending on the semantics, you might have to fixup your comparisons.

return start < end && start >= range.start && end <= range.end - 1;


[...]

>> Right now it's like calling a function with wrong arguments - you just
>> don't have a clue what valid arguments are, because non-obvious errors
>> (besides -ENOMEM, which is a temporary error) pop up deep down the call
>> chain.
>>
>> For example, virito-mem would use it to detect during device
>> initialization the usable device range, and warn the user accordingly.
>> It currently manually checks for MAX_PHYSMEM_BITS, but that's just ugly.
>> Failing at random add_memory() calls (permanently!) is not so nice.
>>
>> In case of DIMMs, we could use it to detect if adding parts of a DIMM
>> won't work (and warn the user early). We could try to add as much as
>> possible.
> 
> Agreed.
> 
> Planning to add memhp_range_allowed() check in add_memory(), __add_memory(),
> add_memory_driver_managed() and memremap_pages(). This check might just get
> called twice depending on the hotplug path. Wondering if this needs to be
> added any where else ?

So

add_memory() needs to
- add sections via arch_add_memory()
- create a mapping via arch_add_memory()->add_pages()

memremap_pages() via arch_add_memory() needs to
- add sections via arch_add_memory()
- create a mapping via arch_add_memory()->add_pages()

memremap_pages() via add_pages() needs to
- add sections

I'll reuse the functions from virtio-mem code once in place (exposing
memhp_get_pluggable_range()).


I do agree that having the callers of arch_add_memory() / add_pages()
validate stuff isn't completely nice. I already raised that I would much
rather want to see !arch wrappers for these arch functions that could
validate stuff. But then we would have to do a bigger cleanup to get
naming right.

1. Rename functions for handling system ram like

s/add_memory/add_sysram/
s/remove_memory/remove_sysram/
...

2. Have a new add_memory() that validates + calls arch_add_memory()

3. s/add_pages/arch_add_pages/

4. Have a new add_pages() that validates + calls arch_add_pages()

...


Long story short, handling it in the 2 (!) callers might be easier for now.

-- 
Thanks,

David / dhildenb

