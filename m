Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1C2C479D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbgKYS3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:29:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730551AbgKYS3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606328947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TK6omj8k55sNzfRs6ZHxXktAYlxZMiJY19mBBF6Fdnk=;
        b=d3kQEdw36qwdGNmr3he8SGfIFKIZLIF5q2jQtnTYfPytx9kEpEjD2a3gB4GDf5RjnBOFgD
        Qc43UzMVrFv7JPnxwH3d5TIDIGxgyEBkeQXazVbTdy1lkY8Ge1ffOgj17kYGTVLNTYB5mi
        26fCGjdWzaZaj/wgFARqM3JRP9jfpbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-x4v_KOb9NxmIw3EZXV_DZw-1; Wed, 25 Nov 2020 13:29:03 -0500
X-MC-Unique: x4v_KOb9NxmIw3EZXV_DZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50EEF185E488;
        Wed, 25 Nov 2020 18:29:02 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 010505C1C2;
        Wed, 25 Nov 2020 18:28:59 +0000 (UTC)
Date:   Wed, 25 Nov 2020 13:28:58 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X76iatgBErQH5El4@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 07:45:30AM +0100, David Hildenbrand wrote:
> Before that change, the memmap of memory holes were only zeroed
> out. So the zones/nid was 0, however, pages were not reserved and
> had a refcount of zero - resulting in other issues.

So maybe that "0,0" zoneid/nid was not actually the thing that
introduced the regression? Note: I didn't bisect anything yet, it was
just a guess.

In fact, I need first thing to boot with an old v5.3 kernel and to
dump the page->flags around the "Unknown E820 type" region to be 100%
certain that the older kernels had a correct page->flags for reserved
pages. I will clear this up before the end of the day.

> Most pfn walkers shouldn‘t mess with reserved pages and simply skip
> them. That would be the right fix here.

What would then be the advantage of keeping wrong page->flags in
reserved pages compared to actually set it correct?

How do you plan to enforce that every VM bit will call PageReserved
(as it should be introduced in pageblock_pfn_to_page in that case) if
it's not possible to disambiguate a real DMA zone and nid 0 from the
uninitialized value? How can we patch page_nodenum to enforce it won't
read an uninitialized value because a PageReserved check was missing
in the caller?

I don't see this easily enforceable by code review, it'd be pretty
flakey to leave a 0,0 wrong value in there with no way to verify if a
PageResered check in the caller was missing.

> > It'd be preferable if the pfn_valid fails and the
> > pfn_to_section_nr(pfn) returns an invalid section for the intermediate
> > step. Even better memset 0xff over the whole page struct until the
> > second stage comes around.
> 
> I recently discussed with Baoquan to
> 1. Using a new pagetype to mark memory holes
> 2. Using special nid/zid to mark memory holes
> 
> Setting the memmap to 0xff would be even more dangerous - pfn_zone() might simply BUG_ON.

What would need to call pfn_zone in between first and second stage?

If something calls pfn_zone in between first and second stage isn't it
a feature if it crashes the kernel at boot?

Note: I suggested 0xff kernel crashing "until the second stage comes
around" during meminit at boot, not permanently.

		/*
		 * Use a fake node/zone (0) for now. Some of these pages
		 * (in memblock.reserved but not in memblock.memory) will
		 * get re-initialized via reserve_bootmem_region() later.
		 */

Specifically I relied on the comment "get re-initialized via
reserve_bootmem_region() later".

I assumed the second stage overwrites the 0,0 to the real zoneid/nid
value, which is clearly not happening, hence it'd be preferable to get
a crash at boot reliably.

Now I have CONFIG_DEFERRED_STRUCT_PAGE_INIT=n so the second stage
calling init_reserved_page(start_pfn) won't do much with
CONFIG_DEFERRED_STRUCT_PAGE_INIT=n but I already tried to enable
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y yesterday and it didn't help, the
page->flags were still wrong for reserved pages in the "Unknown E820
type" region.

> > Whenever pfn_valid is true, it's better that the zoneid/nid is correct
> > all times, otherwise if the second stage fails we end up in a bug with
> > weird side effects.
> 
> Memory holes with a valid memmap might not have a zone/nid. For now, skipping reserved pages should be good enough, no?

zoneid is always a pure abstract concept, not just the RAM-holes but
the RAM itself doesn't have a zoneid at all.

Nid is hardware defined for RAM, but for reserved RAM holes it becomes
a pure software construct as the zoneid.

So while it's right that they have no zone/nid in the hardware, they
still have a very well defined zoneid/nid in the software implementation.

The page struct belongs to one and only one mem_map array, that has a
specific nodeid and nid. So it can be always initialized right even
for non-RAM.

Only if the pfn is !pfn_valid, then it has no page struct and then
there's no zone/nid association, but in that case there's no reason to
even worry about it since nobody can possibly get a wrong value out of
the page struct because there's no page struct in the case.

Last but not the least, RAM pages can be marked reserved and assigned
to hardware and so it'd be really messy if real reserved RAM pages
given to hw, behaved different than non-RAM that accidentally got a
struct page because of section alignment issues.

Thanks,
Andrea

