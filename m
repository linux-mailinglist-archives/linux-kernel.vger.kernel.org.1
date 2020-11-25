Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B582C38BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 06:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgKYFex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 00:34:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgKYFew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 00:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606282490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNqLq5IgMWxaEWp8OZVqcpNyoWNMeYbZubfDbWjaeAE=;
        b=SGaaVSxhn6FQ2qiURYr/Q6tE9y+SI/qV1TmDo+SyQE/quBDnSpoKWWHyXgtYrYweVHaFW2
        JXrWfovRNifjO1mdyA9FeASY8oV1WODNUd3sGG+8VzIjp1rSRKm7ab+W+xNZCGY2z/sAk9
        lBTbxIJVN0+8UkAlqoa/2bVC3GumiyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-PcmZFbNHPPi7CxE0Pj9NPQ-1; Wed, 25 Nov 2020 00:34:48 -0500
X-MC-Unique: PcmZFbNHPPi7CxE0Pj9NPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63D4E180E46E;
        Wed, 25 Nov 2020 05:34:46 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEDC060BE5;
        Wed, 25 Nov 2020 05:34:41 +0000 (UTC)
Date:   Wed, 25 Nov 2020 00:34:41 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X73s8fxDKPRD6wET@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Nov 23, 2020 at 02:01:16PM +0100, Vlastimil Babka wrote:
> On 11/21/20 8:45 PM, Andrea Arcangeli wrote:
> > A corollary issue was fixed in
> > 39639000-39814fff : Unknown E820 type
> > 
> > pfn 0x7a200 -> 0x7a200000 min_pfn hit non-RAM:
> > 
> > 7a17b000-7a216fff : Unknown E820 type
> 
> It would be nice to also provide a /proc/zoneinfo and how exactly the 
> "zone_spans_pfn" was violated. I assume we end up below zone's 
> start_pfn, but is it true?

Agreed, I was about to grab that info along with all page struct
around the pfn 0x7a200 and phys address 0x7a216fff.

# grep -A1 E820 /proc/iomem
7a17b000-7a216fff : Unknown E820 type
7a217000-7bffffff : System RAM

DMA      zone_start_pfn 1            zone_end_pfn() 4096         contiguous 1     
DMA32    zone_start_pfn 4096         zone_end_pfn() 1048576      contiguous 0     
Normal   zone_start_pfn 1048576      zone_end_pfn() 4715392      contiguous 1     
Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     

500222 0x7a1fe000 0x1fff000000001000 reserved True
500223 0x7a1ff000 0x1fff000000001000 reserved True

# I suspect "highest pfn" was somewhere in the RAM range
# 0x7a217000-0x7a400000 and the pageblock_start_pfn(pfn)
# made highest point to pfn 0x7a200 physaddr 0x7a200000
# below, which is reserved indeed since it's non-RAM
# first number is pfn hex(500224) == 0x7a200

pfn    physaddr   page->flags
500224 0x7a200000 0x1fff000000001000 reserved True
500225 0x7a201000 0x1fff000000001000 reserved True
*snip*
500245 0x7a215000 0x1fff000000001000 reserved True
500246 0x7a216000 0x1fff000000001000 reserved True
500247 0x7a217000 0x3fff000000000000 reserved False
500248 0x7a218000 0x3fff000000000000 reserved False

All RAM pages non-reserved are starting at 0x7a217000 as expected.

The non-RAM page_zonenum(pfn_to_page(0x7a200)) points to ZONE_DMA and 
page_zone(page) below was the DMA zone despite the pfn of 0x7a200 is
in DMA32.

	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);

So the patch I sent earlier should prevent the above BUG_ON by not
setting highest to 0x7a200 when pfn is in the phys RAM range
0x7a217000-0x7a400000, because pageblock_pfn_to_page will notice that
the zone is the wrong one.

	if (page_zone(start_page) != zone)
		return NULL;

However the real bug seems that reserved pages have a zero zone_id in
the page->flags when it should have the real zone id/nid. The patch I
sent earlier to validate highest would only be needed to deal with
pfn_valid.

Something must have changed more recently than v5.1 that caused the
zoneid of reserved pages to be wrong, a possible candidate for the
real would be this change below:

+               __init_single_page(pfn_to_page(pfn), pfn, 0, 0);

Even if it may not be it, at the light of how the reserved page
zoneid/nid initialized went wrong, the above line like it's too flakey
to stay.

It'd be preferable if the pfn_valid fails and the
pfn_to_section_nr(pfn) returns an invalid section for the intermediate
step. Even better memset 0xff over the whole page struct until the
second stage comes around.

Whenever pfn_valid is true, it's better that the zoneid/nid is correct
all times, otherwise if the second stage fails we end up in a bug with
weird side effects.

Maybe it's not the above that left a zero zoneid though, I haven't
tried to bisect it yet to look how the page->flags looked like on a
older kernel that didn't seem to reproduce this crash, I'm just
guessing.

Thanks,
Andrea

