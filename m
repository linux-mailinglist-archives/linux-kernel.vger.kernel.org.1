Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7C22C4933
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgKYUlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 15:41:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729111AbgKYUls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606336907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CRTYprAwnP1Pf7kS4WliF9f7U9/vzjMIzF4x+KPal4=;
        b=C+kbxwGX/ZwtY2zG90+XC+6P1VmAkpwsQGDhxiXEX/ysEXWrYFnmo/lz8wy1TfsI3ZgqF+
        wsdARKFWwxXjw7PDFNIhLs5Pkjj81M+FmqzpmnX+IM8Sy5gqBxReelkRH3yvuTy6+eA3KY
        niMyOBzSrzB7gPOLCSHrlJx/yBS277k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-xXKBOtb3P22oePjW5IIrIw-1; Wed, 25 Nov 2020 15:41:43 -0500
X-MC-Unique: xXKBOtb3P22oePjW5IIrIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F904185E489;
        Wed, 25 Nov 2020 20:41:41 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 600AE5D9C6;
        Wed, 25 Nov 2020 20:41:37 +0000 (UTC)
Date:   Wed, 25 Nov 2020 15:41:36 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X77BgHiTR3R7biho@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 08:27:21PM +0100, David Hildenbrand wrote:
> On 25.11.20 19:28, Andrea Arcangeli wrote:
> > On Wed, Nov 25, 2020 at 07:45:30AM +0100, David Hildenbrand wrote:
> >> Before that change, the memmap of memory holes were only zeroed
> >> out. So the zones/nid was 0, however, pages were not reserved and
> >> had a refcount of zero - resulting in other issues.
> > 
> > So maybe that "0,0" zoneid/nid was not actually the thing that
> > introduced the regression? Note: I didn't bisect anything yet, it was
> > just a guess.
> 
> I guess 0/0 is the issue, but that existed before when we had a simple
> memmset(0). The root issue should be what Mike said:

Yes, the second stage must have stopped running somehow.

Is there anything we can do to induce a deterministically reproducible
kernel crashing behavior if the second stage doesn't run?

Why did we start doing a more graceful initialization in the first
stage, instead of making a less graceful by setting it to 0xff instead
of 0x00?

> 73a6e474cb37 ("mm: memmap_init: iterate over memblock regions rather
> that check each PFN")

So if that's not intentional, are you suggesting nodeid/nid was a bug
if it was set to 0,0 for a non-RAM valid pfn?

> "correct" is problematic. If you have an actual memory hole, there is
> not always a right answer - unless I am missing something important.
> 
> 
> Assume you have a layout like this
> 
> [  zone X ] [ hole ] [ zone Y ]
> 
> If either X and or Y starts within a memory section, you have a valid
> memmap for X - but what would be the right node/zone?
> 
> 
> Assume you have a layout like this
> 
> [ zone X ]
> 
> whereby X ends inside a memory section. The you hotplug memory. Assume
> it goes to X
> 
> [ zone X ][ hole in X ][ zone X]
> 
> or it goes to y
> 
> [ zone X ][ hole ][ zone Y ]
> 
> This can easily be reproduced by starting a VM in qemu with a memory
> size not aligned to 128 MB (e.g., -M 4000) and hotplugging memory.

I don't get what the problem is sorry.

You have a pfn, if pfn_valid() is true, pfn_to_page returns a page
deterministically.

It's up to the kernel to decide which page structure blongs to any pfn
in the pfn_to_page function.

Now if the pfn_to_page(pfn) function returns a page whose nid/zone_id
in page->flags points to a node->zone whose zone_start_pfn -
end_zone_pfn range doesn't contain "pfn" that is a bug in
page_alloc.c.

I don't see how is it not possible to deterministically enforce the
above never happens. Only then it would be true that there's not
always a right answer.

zone can overlap, but it can't be that you do pfn_to_page of a
pfn_valid and you obtain a page whose zone doesn't contain that
pfn. Which is what is currently crashing compaction.

I don't see how this is an unsolvable problem and why we should accept
to live with a bogus page->flags for reserved pages.

> We can't. The general rule is (as I was once told by Michal IIRC) that

The fact we can't kernel crash reliably when somebody uses the wrong
0,0 uninitialized value by not adding an explicit PageReserved check,
is my primary concern in keeping those nodeid/nid uninitialized, but
non-kernel-crashing, since it already created this unreproducible bug.

> I'm not rooting for "keep this at 0/0" - I'm saying that I think there
> are corner cases where it might not be that easy.

I'm not saying it's easy. What I don't see is how you don't always
have the right answer and why it would be an unsolvable problem.

It is certainly problematic and difficult to solve in the mem_map
iniitalization logic, but to me having pfn_valid() &&
page_zone(pfn_to_page(pfn)) randomly returning the DMA zone on first
node also looks problematic and difficult to handle across all VM
code, so overall it looks preferable to keep the complexity of the
mem_map initialization self contained and not spilling over the rest
of the VM.

> Yes, but there is a "Some of these" :)
> 
> Boot a VM with "-M 4000" and observe the memmap in the last section -
> they won't get initialized a second time.

Is the beyond the end of the zone yet another case? I guess that's
less likely to give us problems because it's beyond the end of the
zone. Would pfn_valid return true for those pfn? If pfn_valid is not
true it's not really a concern but the again I'd rather prefer if
those struct pages beyond the end of the zone were kernel crashing set
to 0xff.

In other words I just don't see why we should ever prefer to leave
some pages at a graceful and erroneous nid 0 nodeid 0 that wouldn't
easily induce a crash if used.

> AFAIK, the mem_map array might have multiple NIDs - and it's set when
> initializing the zones.

Well because there's no mem_map array with SPARSEMEM, but it's not
conceptually too different than if there was one. Even with flatmem
there could be multiple page struct for each pfn, the disambiguation
has to be handled by pfn_to_page regardless of SPARSEMEM or not.

The point is that if zone_page(pfn_to_page(pfn)) points to DMA zone of
first node, and the pfn isn't part of the DMA of first node that looks
a bug and it can be enforced it doesn't happen.

> Well, "reserved" is not a good indication "what" something actually is.
> 
> I documented that a while ago in include/linux/page-flags.h
> 
> "PG_reserved is set for special pages. The "struct page" of such a page
>  should in general not be touched (e.g. set dirty) except by its owner.
>  Pages marked as PG_reserved include:."
> 
> I suggest looking at that.
> 
> AFAIR, we have been setting *most* memmap in memory holes/non-ram
> reserved for a long time - long before I added the __init_single_page -
> see init_reserved_page() for example.

Sure, non-RAM with valid page struct always has been marked
PG_reserved. I wasn't suggesting that it shouldn't be PG_reserved.

I was pointing out that RAM can also be marked PG_reserved later by
the kernel, long after boot, as you mentioned for all other cases of
PG_reserved, the most notable are drivers doing PG_reserved after
allocating RAM either vmalloc or GART swapping RAM around at other
alias physical address.

That is all born as RAM at boot, it gets page->flags done right, with
the right zoneid, and it becomes PG_reserved later.

So I was suggesting physical ranges "pfn" of non-RAM (be those holes
withtin zones, or in between zones doesn't matter) with a pfn_valid
returning true and a pfn_to_page pointing deterministically to one and
only one struct page, should have such struct page initialized exactly
the same as if it was RAM.

Either that or we can define a new NO_ZONE NO_ID id and crash in
page_zonenum or page_to_nid if it is ever called on such a page
struct.

Thanks,
Andrea

