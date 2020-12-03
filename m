Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF092CD401
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbgLCKwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:52:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43360 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387738AbgLCKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:52:06 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3Ac8G7116551;
        Thu, 3 Dec 2020 05:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jAjrHZ4r+QUfKNZ1cJ8/z6KC1GIcnto2nFG+nshPAP4=;
 b=bB3exphSx7v8XJb2FIkVUypliJrdEc8tQU5QiuYHsZmCjlDyljgGXinAnFDELhwhu7E3
 HyPWa2ff3r1JYAGnG0wS101TWO4eWu+wWpLeIF2DWk8VQID2k9pxrjhxbjWFY/ffohR6
 S9Cu3h8I0Jq7e9qSPDaJGIbxqBHO//OQNifpfRinovd6Pewa50bfc/7Z4VqndlPBy4zK
 D1l1ZWVz4t6mU0sNXMoNKHrfCF6mAH4cWHWxSyrY59TGqFT4I99/kN+ZEZg9DmWnVFYt
 lFtwDhryZHQNdn57BzFKO41+FRKVnt0nX9Z6yCyPJxdnwnGYd6ZxMmEW2VdJOrmUirvz zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 356wbp2fde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 05:51:15 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B3Acsvq118806;
        Thu, 3 Dec 2020 05:51:15 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 356wbp2fcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 05:51:15 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B3Ag5SB011743;
        Thu, 3 Dec 2020 10:51:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 35693xh132-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 10:51:13 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B3ApBDt56951116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Dec 2020 10:51:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2395B42042;
        Thu,  3 Dec 2020 10:51:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D105A42041;
        Thu,  3 Dec 2020 10:51:09 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.50.18])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Dec 2020 10:51:09 +0000 (GMT)
Date:   Thu, 3 Dec 2020 12:51:07 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201203105107.GR123287@linux.ibm.com>
References: <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
 <3bb709a7-6100-aa5c-4125-7ed80c6d9643@redhat.com>
 <20201126174601.GT123287@linux.ibm.com>
 <20201129123257.GY123287@linux.ibm.com>
 <X8bjgw5LPAZrSrwp@redhat.com>
 <20201202173923.GM123287@linux.ibm.com>
 <X8iERlMGfNCLxab5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8iERlMGfNCLxab5@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_06:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 01:23:02AM -0500, Andrea Arcangeli wrote:
> On Wed, Dec 02, 2020 at 07:39:23PM +0200, Mike Rapoport wrote:
> > Hmm, do you have any logs? It worked on my box and with various memory
> > configurations in qemu.
> 
> It crashes in reserve_bootmem_region so no logs at all since the
> serial console isn't active yet.
> 
> > I believe that the proper solution would be to have all the memory
> > reserved by the firmware added to memblock.memory, like all other
> > architectures do, but I'm not sure if we can easily and reliably
> > determine what of E820 reserved types are actually backed by RAM.
> > So this is not feasible as a short term solution.
> > 
> > My patch [1], though, is an immediate improvement and I think it's worth
> > trying to fix off-by-one's that prevent your system from booting.
> > 
> > [1] https://lore.kernel.org/lkml/20201201181502.2340-1-rppt@kernel.org
> 
> Yes that's the patch I applied.
> 
> Relevant points after debugging:
> 
> 1) can you try again with DEBUG_VM=y?

Mea cupla :)

> 2) DEBUG_VM=y already enforces the memset(page, 0xff, sizeof(struct
>    page)) on all struct pages allocated, exactly I was suggesting to
>    do in the previous email. I wonder why we're not doing that even
>    with DEBUG_VM=n, perhaps it's too slow for TiB systems. See
>    page_init_poison().
> 
> 3) given 2), your patch below by deleting "0,0" initialization
>    achieves the debug feature to keep PagePoison forever on all
>    uninitialized pages, imagine PagePoison is really
>    NO_NODEID/NO_ZONEID and doesn't need handling other than a crash.
>   
> -		__init_single_page(pfn_to_page(pfn), pfn, 0, 0);
> 
> 4) because of the feature in 3) I now hit the PagePoison VM_BUG_ON
>    because pfn 0 wasn't initialized when reserve_bootmem_region tries
>    to call __SetPageReserved on a PagePoison page.

So this is the off-by-one a was talking about. My patch removed
initializaion of the hole before the memblock.memory

> 5) pfn 0 is the classical case where pfn 0 is in a reserved zone in
>    memblock.reserve that doesn't overlap any memblock.memory zone.

And, IMHO, this is the fundamental BUG.

There is RAM at address 0, there is a DIMM there, so why on earth this
should not be a part of memblock.memory?

>    The memblock_start_of_DRAM moves the start of the DMA zone above
>    the pfn 0, so then pfn 0 already ends up in the no zone land David
>    mentioned where it's not trivial to decide to give it a zoneid if
>    it's not even spanned in the zone.
> 
>    Not just the zoneid, there's not even a nid.
> 
>    So we have a pfn with no zoneid, and no nid, and not part of the
>    zone ranges, not part of the nid ranges not part of the
>    memory.memblock.

We have a pfn that should have been in memblock.memory, in ZONE_DMA and
in the first node with memory. If it was not trimmed from there 

>    We can't really skip the initialization of the the pfn 0, it has to
>    get the zoneid 0 treatment or if pfn 1 ends up in compaction code,
>    we'd crash again. (although we'd crash with a nice PagePoison(page)
>    == true behavior)

Agree. Struct page for pfn should get the same zoneid and nodeid as pfn 1.

For me the below fixup worked (both with and without DEBUG_VM=y).

From 84a1c2531374706f3592a638523278aa29aaa448 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Thu, 3 Dec 2020 11:40:17 +0200
Subject: [PATCH] fixup for "mm: refactor initialization of stuct page for holes"

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/page_alloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ce2bdaabdf96..86fde4424e87 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6227,7 +6227,8 @@ void __init __weak memmap_init(unsigned long size, int nid,
 			       unsigned long zone,
 			       unsigned long range_start_pfn)
 {
-	unsigned long start_pfn, end_pfn, next_pfn = 0;
+	static unsigned long hole_start_pfn;
+	unsigned long start_pfn, end_pfn;
 	unsigned long range_end_pfn = range_start_pfn + size;
 	u64 pgcnt = 0;
 	int i;
@@ -6235,7 +6236,6 @@ void __init __weak memmap_init(unsigned long size, int nid,
 	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
 		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
-		next_pfn = clamp(next_pfn, range_start_pfn, range_end_pfn);
 
 		if (end_pfn > start_pfn) {
 			size = end_pfn - start_pfn;
@@ -6243,10 +6243,10 @@ void __init __weak memmap_init(unsigned long size, int nid,
 					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 		}
 
-		if (next_pfn < start_pfn)
-			pgcnt += init_unavailable_range(next_pfn, start_pfn,
-							zone, nid);
-		next_pfn = end_pfn;
+		if (hole_start_pfn < start_pfn)
+			pgcnt += init_unavailable_range(hole_start_pfn,
+							start_pfn, zone, nid);
+		hole_start_pfn = end_pfn;
 	}
 
 	/*
@@ -6256,8 +6256,8 @@ void __init __weak memmap_init(unsigned long size, int nid,
 	 * considered initialized. Make sure that memmap has a well defined
 	 * state.
 	 */
-	if (next_pfn < range_end_pfn)
-		pgcnt += init_unavailable_range(next_pfn, range_end_pfn,
+	if (hole_start_pfn < range_end_pfn)
+		pgcnt += init_unavailable_range(hole_start_pfn, range_end_pfn,
 						zone, nid);
 
 	if (pgcnt)
-- 
2.28.0

...

> From 89469f063c192ae70aea0bd6e1e2a7e99894e5b6 Mon Sep 17 00:00:00 2001
> From: Andrea Arcangeli <aarcange@redhat.com>
> Date: Wed, 2 Dec 2020 23:23:26 -0500
> Subject: [PATCH 1/1] mm: initialize struct pages in reserved regions outside
>  of the zone ranges
> 
> pfn 0 wasn't initialized and the PagePoison remained set when
> reserve_bootmem_region() called __SetPageReserved, inducing a silent
> boot failure with DEBUG_VM (and correctly so, because the crash
> signaled the nodeid/nid of pfn 0 would be again wrong).
> 
> Without this change, the pfn 0 part of a memblock.reserved range,
> isn't in any zone spanned range, nor in any nid spanned range, when we
> initialize the memblock.memory holes pfn 0 won't be included because
> it has no nid and no zoneid.
> 
> There's no enforcement that all memblock.reserved ranges must overlap
> memblock.memory ranges, so the memblock.reserved ranges also require
> an explicit initialization and the zones and nid ranges need to be
> extended to include all memblock.reserved ranges with struct pages, or
> they'll be left uninitialized with PagePoison as it happened to pfn 0.
 
I rather think that we should enforce the overlap between
memblock.reserved and memblock.memory. If there are regions that cannot
be mapped, we have other ways to deal with that (e.g. MEMBLOCK_NOMAP)
instead of dropping these ranges from memblock.memory.

> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  include/linux/memblock.h | 17 +++++++++---
>  mm/debug.c               |  3 ++-
>  mm/memblock.c            |  4 +--
>  mm/page_alloc.c          | 57 ++++++++++++++++++++++++++++++++--------
>  4 files changed, 63 insertions(+), 18 deletions(-)
> 

-- 
Sincerely yours,
Mike.
