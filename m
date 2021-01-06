Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EFE2EBD1F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 12:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbhAFLYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 06:24:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbhAFLYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 06:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609932184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=usdz30vfvmLeBQ3gUZ4ei47Vuh3vKt72mif3hNqCSdM=;
        b=HoQj7jDl3jGFaZJA+npOEryC7rfQRG9guac5y3AQ2OuvrqVpL+rcUl9HLdbNtaZK87w8sk
        j3FpECNjjfxYArVoCCZ6qh9Q6pqp0jHIGW3RAinox4ROYAQTFGbmqtLwc2hoBq+Udc9Y3Z
        TR45MgPxxFrPso96z9e1E/iyCbNCeSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-9c0jFVblNaSSeEaoDE7DiA-1; Wed, 06 Jan 2021 06:23:00 -0500
X-MC-Unique: 9c0jFVblNaSSeEaoDE7DiA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75382801AC0;
        Wed,  6 Jan 2021 11:22:59 +0000 (UTC)
Received: from [10.36.112.46] (ovpn-112-46.ams2.redhat.com [10.36.112.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D834960BE2;
        Wed,  6 Jan 2021 11:22:57 +0000 (UTC)
Subject: Re: [PATCH] mm: Teach pfn_to_online_page() about ZONE_DEVICE section
 collisions
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
 <785b9095-eca4-8100-33ea-6ae84e02a92e@redhat.com>
 <20210106104255.GK13207@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7d7c5dc4-7784-5dcc-fc00-4fe99f0a4a90@redhat.com>
Date:   Wed, 6 Jan 2021 12:22:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210106104255.GK13207@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.01.21 11:42, Michal Hocko wrote:
> On Wed 06-01-21 10:56:19, David Hildenbrand wrote:
> [...]
>> Note that this is not sufficient in the general case. I already
>> mentioned that we effectively override an already initialized memmap.
>>
>> ---
>>
>> [        SECTION             ]
>> Before:
>> [ ZONE_NORMAL ][    Hole     ]
>>
>> The hole has some node/zone (currently 0/0, discussions ongoing on how
>> to optimize that to e.g., ZONE_NORMAL in this example) and is
>> PG_reserved - looks like an ordinary memory hole.
>>
>> After memremap:
>> [ ZONE_NORMAL ][ ZONE_DEVICE ]
>>
>> The already initialized memmap was converted to ZONE_DEVICE. Your
>> slowpath will work.
>>
>> After memunmap (no poisioning):
>> [ ZONE_NORMAL ][ ZONE_DEVICE ]
>>
>> The slow path is no longer working. pfn_to_online_page() might return
>> something that is ZONE_DEVICE.
>>
>> After memunmap (poisioning):
>> [ ZONE_NORMAL ][ POISONED    ]
>>
>> The slow path is no longer working. pfn_to_online_page() might return
>> something that will BUG_ON via page_to_nid() etc.
>>
>> ---
>>
>> Reason is that pfn_to_online_page() does no care about sub-sections. And
>> for now, it didn't had to. If there was an online section, it either was
>>
>> a) Completely present. The whole memmap is initialized to sane values.
>> b) Partially present. The whole memmap is initialized to sane values.
>>
>> memremap/memunmap messes with case b)
> 
> I do not see we ever clear the newly added flag and my understanding is
> that the subsection removed would lead to get_dev_pagemap returning a
> NULL. Which would obviously need to be checked for pfn_to_online_page.
> Or do I miss anything and the above is not the case and we could still
> get false positives?

See my example above ("After memunmap").

We're still in the slow pathg. pfn_to_online_page() will return a struct
page as get_dev_pagemap() is now  NULL.

Yet page_zone(page) will either
- BUG_ON (memmap was poisoned)
- return ZONE_DEVICE zone (memmap not poisoned when memunmapping)

As I said, can be tackled by checking for pfn_section_valid() at least
on the slow path. Ideally also on the fast path.

> 
>> Well have to further tweak pfn_to_online_page(). You'll have to also
>> check pfn_section_valid() *at least* on the slow path. Less-hacky would
>> be checking it also in the "somehwat-faster" path - that would cover
>> silently overriding a memmap that's visible via pfn_to_online_page().
>> Might slow down things a bit.
>>
>>
>> Not completely opposed to this, but I would certainly still prefer just
>> avoiding this corner case completely instead of patching around it. Thanks!
> 
> Well, I would love to have no surprises either. So far there was not
> actual argument why the pmem reserved space cannot be fully initialized.

Yes, I'm still hoping Dan can clarify that.

> On the other hand making sure that pfn_to_online_page sounds like the
> right thing to do. And having an explicit check for zone device there in
> a slow path makes sense to me.

As I said, I'd favor to simplify and just get rid of the special case,
instead of coming up with increasingly complex ways to deal with it.
pfn_to_online_page() used to be simple, essentially checking a single
flag was sufficient in most setups.

-- 
Thanks,

David / dhildenb

