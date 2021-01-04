Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728852E9394
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhADKrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:47:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbhADKrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609757146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTWr7FlryOVZvFuRy3ML/CODrw+VGhZh66IS/oD4StY=;
        b=ZmLEnEOJ4uREn7JqbqS3L5Z6tqsxEnncWtvz9yhwkItcD3bLwDlpc1j3kxQnoMd7TW6P4V
        AStwTYtFc5KBGI2H2huh8S/GD2lVvkvTwBB+kUaBcP+mhIwb6O38nR2jraInpYdtm9SDZo
        a0EokSNZbXp9+ITiJnRyukhL7Y1+s+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-IqBM44xvM-mywuR436G8nw-1; Mon, 04 Jan 2021 05:45:42 -0500
X-MC-Unique: IqBM44xvM-mywuR436G8nw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D2F0107ACE4;
        Mon,  4 Jan 2021 10:45:41 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA27960CCE;
        Mon,  4 Jan 2021 10:45:39 +0000 (UTC)
Subject: Re: uninitialized pmem struct pages
To:     Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20210104100323.GC13207@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
Date:   Mon, 4 Jan 2021 11:45:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210104100323.GC13207@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.21 11:03, Michal Hocko wrote:
> Hi,
> back in March [1] you have recommended 53cdc1cb29e8
> ("drivers/base/memory.c: indicate all memory blocks as removable") to be
> backported to stable trees and that has led to a more general discussion
> about the current state of pfn walkers wrt. uninitialized pmem struct
> pages. We haven't concluded any specific solution for that except for a
> general sentiment that pfn_to_online_page should be able to catch those.
> I might have missed any follow ups on that but I do not think we have
> landed on any actual solution in the end. Have I just missed any followups?

Thanks for raising this issue. It's still on my list of "broken and
non-trivial to fix" things.

So, as far as I recall, we still have the following two issues remaining:

1. pfn_to_online_page() false positives

The semantics of pfn_to_online_page() were broken with sub-section
hot-add in corner cases.

If we have ZONE_DEVICE hot-added memory that overlaps in a section with
boot memory, this memory section will contain parts ZONE_DEVICE memory
and parts !ZONE_DEVICE memory. This can happen in sub-section
granularity (2MB IIRC). pfn_to_online_page() will succeed on ZONE_DEVICE
memory parts as the whole section is marked as online. Bad.

One instance where this is still an issue is
mm/memory-failure.c:memory_failure() and
mm/memory-failure.c:soft_offline_page(). I thought for a while about
"fixing" these, but to me it felt like fixing pfn_to_online_page() is
actually the right approach.

But worse, before ZONE_DEVICE hot-add
1. The whole section memmap does already exist (early sections always
have a full memmap for the whole section)
2. The whole section memmap is initialized (although eventually with
dummy node/zone 0/0 for memory holes until that part is fixed) and might
be accessed by pfn walkers.

So when hotadding ZONE_DEVICE we are modifying already existing and
visible memmaps. Bad.


2. Deferred init of ZONE_DEVICE ranges

memmap_init_zone_device() runs after the ZONE_DEVICE zone was resized
and outside the memhp lock. I did not follow if the use of
get_dev_pagemap() actually makes sure that memmap_init_zone_device() in
pagemap_range() actually completed. I don't think it does.

> 
> Is anybody working on that?
> 

I believe Dan mentioned somewhere that he wants to see a real instance
of this producing a BUG before actually moving forward with a fix. I
might be wrong.


We might tackle 1. by:

a) [worked-around] doing get_dev_pagemap() before pfn_to_online_page() -
just plain ugly.

b) [worked-around] using a sub-section online-map and extending
pfn_to_online_page(). IMHO ugly to fix this corner case.

c) [worked-around] extending pfn_to_online_page() by zone checks. IMHO racy.

d) fixed by not allowing ZONE_DEVICE and !ZONE_DEVICE within a single
section. In the worst case, don't add partially present sections that
have big holes in the beginning/end. Like, if there is a 128MB section
with 126MB of memory followed by a 2MB hole, don't add that memory to
Linux with CONFIG_ZONE_DEVICE. Might turn some memory unusable, but
well, it would be the price to pay for simplicity. Being able to hotadd
PMEM is more important than using each and every last MB of memory.

e) decrease the section size and drop sub-section hotadd support. As
sub-section hotadd is 2MB and MAX_ORDER - 1 corresponds 4MB, this is
mostly impossible. Worse on aarch64 with 64k base pages - 1024MB
sections and MAX_ORDER - 1 corresponds 512MB. I think this is not feasible.


We might tackle 2. by making sure that get_dev_pagemap() only succeeds
after memmap_init_zone_device() finished. As I said, not sure if that is
already done.


> Also is there any reference explaining what those struct pages are and
> why we cannot initialize them? I am sorry if this has been explained to
> me but I really cannot find that in my notes anywhere. Most pmem pages
> should be initialized via memmap_init_zone_device, right?

Long story short, IMHO we have to

a) fix pfn_to_online_page() to only succeed for !ZONE_DEVICE memory.
b) fix get_dev_pagemap() to only succeed if memmap_init_zone_device()
completed. (again, unless this already works as desired)

Dealing with races (memory_offlining() racing with pfn_to_online_page())
is another story and stuff for the future. Another level of complexity :)


> I am asking mostly because we are starting to see these issues in
> production and while the only visible problem so far is a crash when
> reading sysfs (removable file) I am worried we are just lucky no other
> pfn walker stumble over this.

Which exact issue are you seeing? The one tackled by "[PATCH v1]
drivers/base/memory.c: indicate all memory blocks as removable" ?


-- 
Thanks,

David / dhildenb

