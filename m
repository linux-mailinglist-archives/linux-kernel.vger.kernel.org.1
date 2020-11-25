Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3046E2C3B65
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgKYIwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:52:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgKYIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:52:10 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AP8Ww3b121629;
        Wed, 25 Nov 2020 03:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=bIACh/j+GhlP0sBA2dftWi7Yj0hkyMLwDOpOtW5GpYY=;
 b=qDITTvUbff0KMpCmv1LamKx/5hy7TDuCPeAiEuwPBb0qt2u4J/Pk3IFq2faA6yPjZySw
 RfLXSmveq5RwMcnf3vyn1/is9SVQPXfSFUsuDFGtgPD2wynapaMPfaXmFoJytrpIYDrI
 T7Bfl544R4+RMkr+ExkfeQK1E+qmoTY+lN/m3cLiKHfIPjhMjo0KbuKVUOX2CRuDXpx/
 bqpghkedpQXzDuCJfhYpz0ucPPNNx9DlbWmGlXbN3KSa9sdu4ZMZe1xNCyJp01JrRpmL
 kgsXVYn94eb09EoflSBpe7u/AHMdQOgDK7HNVIYkabY7QnGlW312hUXDh/xE3SA0fupI KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 351ddb2r2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 03:52:01 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AP8XdCf126680;
        Wed, 25 Nov 2020 03:52:00 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 351ddb2r1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 03:52:00 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AP8mRjI005258;
        Wed, 25 Nov 2020 08:51:58 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34xt5hcg1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 08:51:58 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AP8puV060621230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 08:51:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E69E0A4057;
        Wed, 25 Nov 2020 08:51:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5788A4065;
        Wed, 25 Nov 2020 08:51:53 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.183.229])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Nov 2020 08:51:53 +0000 (GMT)
Date:   Wed, 25 Nov 2020 10:51:51 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201125085151.GH123287@linux.ibm.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_04:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=1 lowpriorityscore=0 impostorscore=0
 clxscore=1011 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 07:45:30AM +0100, David Hildenbrand wrote:
> 
> > Am 25.11.2020 um 06:34 schrieb Andrea Arcangeli <aarcange@redhat.com>:
> > 
> > ﻿Hello,
> > 
> >> On Mon, Nov 23, 2020 at 02:01:16PM +0100, Vlastimil Babka wrote:
> >>> On 11/21/20 8:45 PM, Andrea Arcangeli wrote:
> >>> A corollary issue was fixed in
> >>> 39639000-39814fff : Unknown E820 type
> >>> 
> >>> pfn 0x7a200 -> 0x7a200000 min_pfn hit non-RAM:
> >>> 
> >>> 7a17b000-7a216fff : Unknown E820 type
> >> 
> >> It would be nice to also provide a /proc/zoneinfo and how exactly the 
> >> "zone_spans_pfn" was violated. I assume we end up below zone's 
> >> start_pfn, but is it true?
> > 
> > Agreed, I was about to grab that info along with all page struct
> > around the pfn 0x7a200 and phys address 0x7a216fff.
> > 
> > # grep -A1 E820 /proc/iomem
> > 7a17b000-7a216fff : Unknown E820 type
> > 7a217000-7bffffff : System RAM
> > 
> > DMA      zone_start_pfn 1            zone_end_pfn() 4096         contiguous 1     
> > DMA32    zone_start_pfn 4096         zone_end_pfn() 1048576      contiguous 0     
> > Normal   zone_start_pfn 1048576      zone_end_pfn() 4715392      contiguous 1     
> > Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     
> > 
> > 500222 0x7a1fe000 0x1fff000000001000 reserved True
> > 500223 0x7a1ff000 0x1fff000000001000 reserved True
> > 
> > # I suspect "highest pfn" was somewhere in the RAM range
> > # 0x7a217000-0x7a400000 and the pageblock_start_pfn(pfn)
> > # made highest point to pfn 0x7a200 physaddr 0x7a200000
> > # below, which is reserved indeed since it's non-RAM
> > # first number is pfn hex(500224) == 0x7a200
> > 
> > pfn    physaddr   page->flags
> > 500224 0x7a200000 0x1fff000000001000 reserved True
> > 500225 0x7a201000 0x1fff000000001000 reserved True
> > *snip*
> > 500245 0x7a215000 0x1fff000000001000 reserved True
> > 500246 0x7a216000 0x1fff000000001000 reserved True
> > 500247 0x7a217000 0x3fff000000000000 reserved False
> > 500248 0x7a218000 0x3fff000000000000 reserved False
> > 
> > All RAM pages non-reserved are starting at 0x7a217000 as expected.
> > 
> > The non-RAM page_zonenum(pfn_to_page(0x7a200)) points to ZONE_DMA and 
> > page_zone(page) below was the DMA zone despite the pfn of 0x7a200 is
> > in DMA32.
> > 
> >    VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
> > 
> > So the patch I sent earlier should prevent the above BUG_ON by not
> > setting highest to 0x7a200 when pfn is in the phys RAM range
> > 0x7a217000-0x7a400000, because pageblock_pfn_to_page will notice that
> > the zone is the wrong one.
> > 
> >    if (page_zone(start_page) != zone)
> >        return NULL;
> > 
> > However the real bug seems that reserved pages have a zero zone_id in
> > the page->flags when it should have the real zone id/nid. The patch I
> > sent earlier to validate highest would only be needed to deal with
> > pfn_valid.
> > 
> > Something must have changed more recently than v5.1 that caused the
> > zoneid of reserved pages to be wrong, a possible candidate for the
> > real would be this change below:
> > 
> > +               __init_single_page(pfn_to_page(pfn), pfn, 0, 0);
> > 
> 
> Before that change, the memmap of memory holes were only zeroed out.
> So the zones/nid was 0, however, pages were not reserved and had a
> refcount of zero - resulting in other issues.
> 
> Most pfn walkers shouldn‘t mess with reserved pages and simply skip
> them. That would be the right fix here.

My guest would be that it is me and Baoquan:
73a6e474cb37 ("mm: memmap_init: iterate over memblock regions rather that check each PFN")

Until then reserved pages were traversed in memmap_init_zone() and after
the change they are not because on x86 reserved memory is not considered
memory for some reason.

Can you please check if this untested patch helps:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eaa227a479e4..be3c85a6714e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6191,7 +6191,9 @@ void __meminit __weak memmap_init(unsigned long size, int nid,
 {
 	unsigned long start_pfn, end_pfn;
 	unsigned long range_end_pfn = range_start_pfn + size;
+	phys_addr_t start, end;
 	int i;
+	u64 j;
 
 	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
@@ -6203,6 +6205,19 @@ void __meminit __weak memmap_init(unsigned long size, int nid,
 					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 		}
 	}
+
+	__for_each_mem_range(j, &memblock.reserved, NULL, nid,	MEMBLOCK_NONE,
+			     &start, &end, NULL) {
+		start_pfn = clamp(PHYS_PFN(start), range_start_pfn,
+				  range_end_pfn);
+		end_pfn = clamp(PHYS_PFN(end), range_start_pfn, range_end_pfn);
+
+		if (end_pfn > start_pfn) {
+			size = end_pfn - start_pfn;
+			memmap_init_zone(size, nid, zone, start_pfn,
+					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
+		}
+	}
 }
 
 static int zone_batchsize(struct zone *zone)

> > Even if it may not be it, at the light of how the reserved page
> > zoneid/nid initialized went wrong, the above line like it's too flakey
> > to stay.
> > 
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
> 
> > 
> > Whenever pfn_valid is true, it's better that the zoneid/nid is correct
> > all times, otherwise if the second stage fails we end up in a bug with
> > weird side effects.
> 
> Memory holes with a valid memmap might not have a zone/nid. For now, skipping reserved pages should be good enough, no?
> 
> > 
> > Maybe it's not the above that left a zero zoneid though, I haven't
> > tried to bisect it yet to look how the page->flags looked like on a
> > older kernel that didn't seem to reproduce this crash, I'm just
> > guessing.
> > 
> > Thanks,
> > Andrea
> 

-- 
Sincerely yours,
Mike.
