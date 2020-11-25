Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730D52C414D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgKYNlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgKYNlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606311676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2CSJkwJ01yCXtKhyXjj7mNDHOXO25ExUWkF5Tdyq0h0=;
        b=YUS1+g3J6CBkOjacVm3mzgNp075DjHVs1ejVQfF8CswRugj+kVdYUzQO9X/RY7Fok72qKU
        0/+mNxwdGytuWm8iSLjtT6KLj3PlZ4BREHPghmagcoGGGxl4PTYJzE9TSewjA+cNjHYWb1
        Cn8v+UinJcl3xvsfQARMMKUPVvkP6es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-06i0NvPvMl2IWapNuFFuAw-1; Wed, 25 Nov 2020 08:41:14 -0500
X-MC-Unique: 06i0NvPvMl2IWapNuFFuAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42D049A234;
        Wed, 25 Nov 2020 13:41:13 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65D6C60854;
        Wed, 25 Nov 2020 13:41:11 +0000 (UTC)
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
To:     Mel Gorman <mgorman@suse.de>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <20201125103933.GM3306@suse.de>
 <5f01bde6-fe31-9b0e-f288-06b82598a8b3@redhat.com>
 <20201125133346.GN3306@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <cef8f30b-8b11-77df-4a12-e35715332778@redhat.com>
Date:   Wed, 25 Nov 2020 14:41:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125133346.GN3306@suse.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.20 14:33, Mel Gorman wrote:
> On Wed, Nov 25, 2020 at 12:04:15PM +0100, David Hildenbrand wrote:
>> On 25.11.20 11:39, Mel Gorman wrote:
>>> On Wed, Nov 25, 2020 at 07:45:30AM +0100, David Hildenbrand wrote:
>>>>> Something must have changed more recently than v5.1 that caused the
>>>>> zoneid of reserved pages to be wrong, a possible candidate for the
>>>>> real would be this change below:
>>>>>
>>>>> +               __init_single_page(pfn_to_page(pfn), pfn, 0, 0);
>>>>>
>>>>
>>>> Before that change, the memmap of memory holes were only zeroed out. So the zones/nid was 0, however, pages were not reserved and had a refcount of zero - resulting in other issues.
>>>>
>>>> Most pfn walkers shouldn???t mess with reserved pages and simply skip them. That would be the right fix here.
>>>>
>>>
>>> Ordinarily yes, pfn walkers should not care about reserved pages but it's
>>> still surprising that the node/zone linkages would be wrong for memory
>>> holes. If they are in the middle of a zone, it means that a hole with
>>> valid struct pages could be mistaken for overlapping nodes (if the hole
>>> was in node 1 for example) or overlapping zones which is just broken.
>>
>> I agree within zones - but AFAIU, the issue is reserved memory between
>> zones, right?
>>
> 
> It can also occur in the middle of the zone.
> 
>> Assume your end of memory falls within a section - what would be the
>> right node/zone for such a memory hole at the end of the section?
> 
> Assuming a hole is not MAX_ORDER-aligned but there is real memory within
> the page block, then the node/zone for the struct pages backing the hole
> should match the real memorys node and zone.
> 
> As it stands, with the uninitialised node/zone, certain checks like
> page_is_buddy(): page_zone_id(page) != page_zone_id(buddy) may only
> work by co-incidence. page_is_buddy() happens to work anyway because
> PageBuddy(buddy) would never be true for a PageReserved page.
> 
>> With
>> memory hotplug after such a hole, we can easily have multiple
>> nodes/zones spanning such a hole, unknown before hotplug.
>>
> 
> When hotplugged, the same logic would apply. Where the hole is not aligned,
> the struct page linkages should match the "real" memory".
> 
>>> It would partially paper over the issue that setting the pageblock type
>>> based on a reserved page. I agree that compaction should not be returning
>>> pfns that are outside of the zone range because that is buggy in itself
>>> but valid struct pages should have valid information. I don't think we
>>> want to paper over that with unnecessary PageReserved checks.
>>
>> Agreed as long as we can handle that issue using range checks.
>>
> 
> I think it'll be ok as long as the struct pages within a 1<<(MAX_ORDER-1)
> range have proper linkages.

Agreed.


-- 
Thanks,

David / dhildenb

