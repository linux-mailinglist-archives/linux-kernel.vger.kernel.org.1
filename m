Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0652ECC8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbhAGJRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:17:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbhAGJRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610010970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EyXxSZnbI/39F3EKm+Bk6hYXCEFQp/AEY1gb35NcT1E=;
        b=EQEjpA87JK0RMO7sAbcAtIXItX3xhqIS0aBZUFJ3WTiPv7SuamwsVklYcOfhz2HFbS22s/
        hbLFUnn8RX0anXXL43881T5RNoL9ERXHsRak3ROSfaVTvwt0UR9RkVHf8XzYfmpMIGMDWI
        84OkDeo8+T+1RB7xy+6jdrz+DFm/UJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-Uoiry2tDMjm1fnFMD71wmg-1; Thu, 07 Jan 2021 04:16:09 -0500
X-MC-Unique: Uoiry2tDMjm1fnFMD71wmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69268107ACF5;
        Thu,  7 Jan 2021 09:16:01 +0000 (UTC)
Received: from [10.36.114.161] (ovpn-114-161.ams2.redhat.com [10.36.114.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDD5A10013BD;
        Thu,  7 Jan 2021 09:15:59 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <75bb1429-d133-d303-a67a-be16c654ada8@redhat.com>
Date:   Thu, 7 Jan 2021 10:15:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iN4t2P_rQS23E7Bb-eLUAt389Y5t4X-yoRQrxvsN3DWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>>> Well, I would love to have no surprises either. So far there was not
>>> actual argument why the pmem reserved space cannot be fully initialized.
>>
>> Yes, I'm still hoping Dan can clarify that.
> 
> Complexity and effective utility (once pfn_to_online_page() is fixed)
> are the roadblocks in my mind. The altmap is there to allow for PMEM
> capacity to be used as memmap space, so there would need to be code to
> break that circular dependency and allocate a memmap for the metadata
> space from DRAM and the rest of the memmap space for the data capacity
> from pmem itself. That memmap-for-pmem-metadata will still represent
> offline pages. So once pfn_to_online_page() is fixed, what pfn-walker
> is going to be doing pfn_to_page() on PMEM metadata? Secondly, there

Assume I do

pgmap = get_dev_pagemap(pfn, NULL);
if (pgmap)
	return pfn_to_page(pfn);
return NULL;

on a random pfn because I want to inspect ZONE_DEVICE PFNs.

IIUC, the memmap I get might usually be initialized, except we're
hitting a PFN in the reserved altmap space. Correct?

Do we expect this handling to not be valid - i.e., initialization to be
of no utility? (to make it fly we would have to explicitly check for
PFNs in the altmap reserved space, which wouldn't be too problematic)

> is a PMEM namespace mode called "raw" that eschews DAX and 'struct
> page' for pmem and just behaves like a memory-backed block device. The
> end result is still that pfn walkers need to discover if a PMEM pfn
> has a page, so I don't see what "sometimes there's an
> memmap-for-pmem-metadata" buys us?

Right, but that's as easy as doing a pfn_valid() first.


Let me try to express what I (and I think Michal) mean:

In pagemap_range(), we

1. move_pfn_range_to_zone()->memmap_init_zone(): initialize the memmap
of the PMEM device used as memmap itself ("self host", confusing). We
skip initializing the memmap for the the reserved altmap space.

2. memmap_init_zone_device(): initialize the memmap of everything
outside of the altmap space.

IIUC, the memmap of the reserved altmap space remains uninitialized.
What speaks against just initializing that part in e.g., 2. or similarly
after 1.?


I'm planning on documenting the result of this discussion in the code,
so people don't have to scratch their head whenever stumbling over the
altmap reserved space.

> 
>>
>>> On the other hand making sure that pfn_to_online_page sounds like the
>>> right thing to do. And having an explicit check for zone device there in
>>> a slow path makes sense to me.
>>
>> As I said, I'd favor to simplify and just get rid of the special case,
>> instead of coming up with increasingly complex ways to deal with it.
>> pfn_to_online_page() used to be simple, essentially checking a single
>> flag was sufficient in most setups.
> 
> I think the logic to throw away System RAM that might collide with
> PMEM and soft-reserved memory within a section is on the order of the
> same code complexity as the patch proposed here, no? Certainly the
> throw-away concept itself is easier to grasp, but I don't think that
> would be reflected in the code patch to achieve it... willing to be
> proved wrong with a patch.

Well, at least it sounds easier to go over memblock holes and
align-up/down some relevant PFNs to section boundaries, ending up with
no affect to runtime performance later (e.g., pfn_to_online_page()). But
I agree that most probably the devil is in the detail - e.g., handling
different kind of holes (different flavors of "reserved") and syncing up
other data structures (e.g., resource tree).

I don't have time to look into that right now, but might look into it in
the future. For now I'm fine with this approach, assuming we don't
discover other corner cases that turn it even more complex. I'm happy
that we finally talk about it and fix it!


-- 
Thanks,

David / dhildenb

