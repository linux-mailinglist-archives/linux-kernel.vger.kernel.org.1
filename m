Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531232D018B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 09:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgLFIKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 03:10:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgLFIKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:10:20 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B683COB102184;
        Sun, 6 Dec 2020 03:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vitoci2zo1wSg3sfYsF2vvW+dRYnBFamayLat12NmEU=;
 b=VqBOKCOFzJbSzotf3O+wicxOclPRm65+Fwe55Dnik5rmDVsKj2L6YyHoHoSjfO8miebj
 xSTUYifmjKDPZx+6Z4/GoCYiTNzs2iS6qTMk7SMGYkayG+zAY9QzjfL/6nMmNZsLiOkO
 n5gJcExdmdme6WmqZnkD0+oc4EUpsyGdXvMjDUseT+QNdhI7G4tWa24IPd7iQ2481tOD
 cYp2zsXpZIkfFfqe+Enl47qwx3KZn9f38W/uD21beNPTH6ejaxwBgbA7NDGyoUjfnADD
 bqr8Xn6j7ZWIORoq1uR95nezmQ8a+sXWIOGRWfadFfPrYx+pvYJhe5N2NIxpZNQt2BX6 cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 358st51k6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Dec 2020 03:09:32 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B689VUP141206;
        Sun, 6 Dec 2020 03:09:31 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 358st51k5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Dec 2020 03:09:31 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B6835kW003508;
        Sun, 6 Dec 2020 08:09:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3581u80y29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Dec 2020 08:09:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B689Rjc66322856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Dec 2020 08:09:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F41CE42042;
        Sun,  6 Dec 2020 08:09:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C46884203F;
        Sun,  6 Dec 2020 08:09:25 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.50.18])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  6 Dec 2020 08:09:25 +0000 (GMT)
Date:   Sun, 6 Dec 2020 10:09:23 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201206080923.GX123287@linux.ibm.com>
References: <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
 <3bb709a7-6100-aa5c-4125-7ed80c6d9643@redhat.com>
 <20201126174601.GT123287@linux.ibm.com>
 <20201129123257.GY123287@linux.ibm.com>
 <X8bjgw5LPAZrSrwp@redhat.com>
 <20201202173923.GM123287@linux.ibm.com>
 <X8iERlMGfNCLxab5@redhat.com>
 <20201203105107.GR123287@linux.ibm.com>
 <X8khAMOK1y4yRijc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8khAMOK1y4yRijc@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-06_04:2020-12-04,2020-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=5 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012060050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 12:31:44PM -0500, Andrea Arcangeli wrote:
> On Thu, Dec 03, 2020 at 12:51:07PM +0200, Mike Rapoport wrote:
> > On Thu, Dec 03, 2020 at 01:23:02AM -0500, Andrea Arcangeli wrote:
> > > 5) pfn 0 is the classical case where pfn 0 is in a reserved zone in
> > >    memblock.reserve that doesn't overlap any memblock.memory zone.
> > 
> > And, IMHO, this is the fundamental BUG.
> 
> We have a dozen arches that change all the time,

We have ~20 arches that work just fine and only x86 runs into troubles
from time to time ;-)

> new efi/e820 stuff, always new bios configs, the memblock code must
> cope and be able to cope with the caller being wrong or changing
> behavior if the e820 map changes behaviour.

> Trying to work around memblock core deficiencies in the caller is what
> 124049decbb121ec32742c94fb5d9d6bed8f24d8 already did, and it doesn't
> work and it's not even clean thing to do.

It's not exactly memblock core deficiencies, it's rather the whole path
from memory detection to the point where we have memmap and page
allocator functional.

I agree that the initialization of memmap and page allocator should be
improved. And 73a6e474cb376921a311786652782155eac2fdf0 was a part of
large series that largely reduced the complexity of
free_area_init() and friends. Particularly this commit removed a couple
of cycles from memmap init.

And when you touch such a sensitive and fragile area mistakes can
happen. So 73a6e474cb376921a311786652782155eac2fdf0 missed a corner
case, but I don't understand why you are so annoyed by "memblock
core"...

> In fact here there's really nothing to blame the caller for (i.e. the
> e820 init code), unless you declare that there must be always overlap
> (which I understood would break stuff for regions that must not have a
> direct mapping).
> 
> The caller here is correct and it can be summarized as below:
> 
>     if (e820 map type != system_ram)
>        memblock_reserve(range)
>     else
>        memblock_add(range)

I don't agree that memblock_add(range) should be in else. PFN 0 is
*memory* so why don't we treat it as such?

I have a preliminary patch that actually does this and updates x86 parts
of x86 memory initialization to keep it backward compatible.

> Then:
> 
>    zone_boundaries = [ 16M, 4G, 0 ]
>    free_area_init(zone_boundaries)
> 
> It's not the caller fault if the e820 map in the bios starts with:
> 
> pfn 0-1 reserved
> pfn 1-N system RAM
 
So in your example, is pfn 0 a part of memory or not? It there a
physical memory at address 0?

I don't think that because BIOS uses this memory it stops being memory.

> This is better fixed in a way that must not require any change in the
> caller...

The generic code needs to be more robust, but I'm not sure that the
complexity around holes initialization vs. relatively simple update to
the caller is the best way to solve it.

> > There is RAM at address 0, there is a DIMM there, so why on earth this
> > should not be a part of memblock.memory?
> 
> How can you blame the caller if you explicitly didn't required that
> .reserved ranges must always overlap .memory ranges? In fact it was
> explained as a feature to avoid the direct mapping.
> 
> Declaring that there must be always overlap would be one way to cope
> with this issue, but even then memblock must detect a wrong caller,
> workaround it by doing a memblock_add call inside the
> memblock_reserved and by printing a warning to improve the caller. It
> shouldn't crash at boot with console off if the overlap is not there.

If memblock would have done this and would had an implicit
memblock_add() for the reserved areas we would hit the same issue with
regions that any access to them crashes the system.

> In my view the caller here is not to blame, all these issues are
> because memblock needs improvement and must cope with any caller.

The caller, which is low level architecture code, has the best knowledge
of the memory layout. It's the caller who translates that memory
layout to the generic abstraction. If that translation lacks details,
the generic code is limited in its ability to workaround those missing
details.

In the case of e820 it seems that the existing abstraction of 'memory'
and 'reserved' is not sufficient and we need more details to describe
the physical memory. For instance 'memory', 'used by BIOS', 'reserved by
kernel'.

Still, this requires consensus between arch and mm about what is what.

> > >    The memblock_start_of_DRAM moves the start of the DMA zone above
> > >    the pfn 0, so then pfn 0 already ends up in the no zone land David
> > >    mentioned where it's not trivial to decide to give it a zoneid if
> > >    it's not even spanned in the zone.
> > > 
> > >    Not just the zoneid, there's not even a nid.
> > > 
> > >    So we have a pfn with no zoneid, and no nid, and not part of the
> > >    zone ranges, not part of the nid ranges not part of the
> > >    memory.memblock.
> > 
> > We have a pfn that should have been in memblock.memory, in ZONE_DMA and
> > in the first node with memory. If it was not trimmed from there 
> 
> My incremental patch already solves how to extend the zones spans and
> the nid spans by taking memblock.reserved into account, not just
> memblock.memory, but still without actually messing with the direct
> mapping, otherwise I would have called memblock_add instead of walking
> memblock.reserved when detecting the nid and zoneid ranges.

I've commented on the patch at other thread.

> > 
> > >    We can't really skip the initialization of the the pfn 0, it has to
> > >    get the zoneid 0 treatment or if pfn 1 ends up in compaction code,
> > >    we'd crash again. (although we'd crash with a nice PagePoison(page)
> > >    == true behavior)
> > 
> > Agree. Struct page for pfn should get the same zoneid and nodeid as pfn 1.
> 
> How are you sure there's no a zone ID 0 that starts at pfn 0 and ends
> at pfn 1 and the zone dma starts at pfn 1? In such case the pfn 0
> would have a zoneid different from pfn 1.
>
> I'm not exactly sure why we should initialize a pfn 0 with a zoneid of
> a zone whose pfn 0 is not part of, that looks wrong.
> 
> I'm not exactly sure why you don't fix the zone->zone_start_pfn and
> the respective nid node_start_pfn to start from pfn 0 instead, just
> like I did in my patch.

I think the correct fix for this is to have pfn 0 in memblock.memory,
Meanwhile, having this patch on top of "mm: refactor initialization of
stuct page for holes in memory layout" is the least of all evils, see
also comments below.

> > From 84a1c2531374706f3592a638523278aa29aaa448 Mon Sep 17 00:00:00 2001
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > Date: Thu, 3 Dec 2020 11:40:17 +0200
> > Subject: [PATCH] fixup for "mm: refactor initialization of stuct page for holes"
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  mm/page_alloc.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index ce2bdaabdf96..86fde4424e87 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6227,7 +6227,8 @@ void __init __weak memmap_init(unsigned long size, int nid,
> >  			       unsigned long zone,
> >  			       unsigned long range_start_pfn)
> >  						zone, nid);

...
 
> 1) this looks very specific for pfn 0

Nope, this fix takes care of pfns "before start of RAM" in general.
To the best of my knowledge, this only happens to be pfn 0 on x86.

> 2) it's not optimal to call init_unavailable_range(0,) the first time
>    at every zone initialization, that's a pretty inefficient loop for
>    large RAM systems.

This is not called every time because hole_start_pfn is static.

> 3) you give pfn 0 a zoneid despite it's not part of the zone, that
>    looks wrong from a zoneid initialization point of view.
>
> The bug here is that the DMA zone starts in pfn 1 which doesn't make
> any technical sense since the start of the pageblock would then be
> beyond the start_zone_pfn.

Right, the bug is that DMA zone starts in pfn 1 because pfn 0 is not in
.memory and thus bypasses all the zone and node sizing calculations.

As architectures only specify max_zone_pfns when they call
free_area_init() I believe it is safe to presume that every pfn that is
smaller than max_zone_pfns[0] belongs to zone 0.

And this fix alone with interleaving of init_unavailable_mem() inside
memmap_init() does exactly that. For pages magically appearing at the
range [0, memblock_start_of_DRAM()] I set zone link in struct page to
zone[0].

> Thanks,
> Andrea
> 

-- 
Sincerely yours,
Mike.
