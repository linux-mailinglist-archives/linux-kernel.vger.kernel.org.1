Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5392F2B93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389194AbhALJpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:45:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729295AbhALJpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610444648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zY/M/u2m2VqNpyWF8thtipjO76Oug+h2dUySxrNjOdk=;
        b=P9A8IoJIbbZpc7YXMAhT1SRMzwQvBckWlHwv0z/01Ca1pCefHY41XDmyphRIC1GhRbFnaI
        zxVyha1/YauEQA3A0EKuIE7/I7p2UViqXz+MCSfCYMDbQoYIvGLYoO01ns9tbEjcb3eTdP
        AMkgK8h/q+NX6sHkyMIQavvMIqFHuN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-nf4rcX7zNN6LhEz-fh6XtQ-1; Tue, 12 Jan 2021 04:44:04 -0500
X-MC-Unique: nf4rcX7zNN6LhEz-fh6XtQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 317A4100C600;
        Tue, 12 Jan 2021 09:44:03 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D69C910023B7;
        Tue, 12 Jan 2021 09:44:01 +0000 (UTC)
Subject: Re: [PATCH] mm: Teach pfn_to_online_page() about ZONE_DEVICE section
 collisions
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
 <785b9095-eca4-8100-33ea-6ae84e02a92e@redhat.com>
 <20210106104255.GK13207@dhcp22.suse.cz>
 <7d7c5dc4-7784-5dcc-fc00-4fe99f0a4a90@redhat.com>
 <CAPcyv4iN4t2P_rQS23E7Bb-eLUAt389Y5t4X-yoRQrxvsN3DWQ@mail.gmail.com>
 <75bb1429-d133-d303-a67a-be16c654ada8@redhat.com>
 <CAPcyv4gXaUswZS_a4-oiQZWVZ4QDJrKps4XGs=xxLE0Ls=PSmg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b12d3dab-b2a0-e274-7eba-e16971067883@redhat.com>
Date:   Tue, 12 Jan 2021 10:44:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gXaUswZS_a4-oiQZWVZ4QDJrKps4XGs=xxLE0Ls=PSmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.21 10:18, Dan Williams wrote:
> On Thu, Jan 7, 2021 at 1:16 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> [...]
>>
>>>>> Well, I would love to have no surprises either. So far there was not
>>>>> actual argument why the pmem reserved space cannot be fully initialized.
>>>>
>>>> Yes, I'm still hoping Dan can clarify that.
>>>
>>> Complexity and effective utility (once pfn_to_online_page() is fixed)
>>> are the roadblocks in my mind. The altmap is there to allow for PMEM
>>> capacity to be used as memmap space, so there would need to be code to
>>> break that circular dependency and allocate a memmap for the metadata
>>> space from DRAM and the rest of the memmap space for the data capacity
>>> from pmem itself. That memmap-for-pmem-metadata will still represent
>>> offline pages. So once pfn_to_online_page() is fixed, what pfn-walker
>>> is going to be doing pfn_to_page() on PMEM metadata? Secondly, there
>>
>> Assume I do
>>
>> pgmap = get_dev_pagemap(pfn, NULL);
>> if (pgmap)
>>         return pfn_to_page(pfn);
>> return NULL;
>>
>> on a random pfn because I want to inspect ZONE_DEVICE PFNs.
> 
> I keep getting hung up on the motivation to do random pfn inspection?
> 
> The problems we have found to date have required different solutions.
> The KVM bug didn't use get_dev_pagemap() to inspect the pfn because it
> could rely on the fact that the page already had an elevated reference
> count. The get_user_pages() path only looks up ZONE_DEVICE pfns when
> it see {pte,pmd,pud}_devmap set in the page table entry. pfn walkers
> have been a problem, but with pfn_to_online_page() fixed what is the
> remaining motivation to inspect ZONE_DEVICE pfns?

1) Let's assume we want to implement zone shrinking
(remove_pfn_range_from_zone()->shrink_zone_span()) for ZONE_DEVICE at
some point.

A simple approach would be going via get_dev_pagemap(pfn,
NULL)->pfn_to_page(pfn), checking for the zone.

If that's not possible, then extending dev_pagemap (e.g., indicating the
nid) might also work (unless there is another way to get the nid).


2) Let's take a look at mm/memory-failure.c:memory_failure_dev_pagemap()

IIUC, we might end up doing pfn_to_page(pfn) on a pfn in the reserved
altmap space, so one with an uninitialized memmap.

E.g., in dax_lock_page() we access page->mapping, which might just be
garbage. dax_mapping() will de-reference garbage.

Most probably I am missing something here.



Question is: what are the expectations regarding the memmap if
get_dev_pagemap() succeeded.

I'm fine documenting that "get_dev_pagemap() does not guarantee that the
"struct page" returned by pfn_to_page() was initialized and can safely
be used. E.g., it might be a pfn in the reserved altmap space, for which
the memmap is never initialized. Accessing it might be dangerous.".

Then, there has to be a check at relevant places (e.g.,
memory_failure_dev_pagemap()), checking somehow if the memmap content
can actually be used.

-- 
Thanks,

David / dhildenb

