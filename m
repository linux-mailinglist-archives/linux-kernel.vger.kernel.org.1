Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5D62C41EC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgKYONp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:13:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727939AbgKYONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:13:44 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APE3v3g149653;
        Wed, 25 Nov 2020 09:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=PF0dD3+Bv3J7qmyUvvNB0Kp5F+jdvDQqY1bTIgXfIG8=;
 b=cq483OgpXtx5liYsKTnCR5nLnJR7Ljb9E5tniDVowF9dEQYDoTCq400xrkGeguawZl7m
 Fb3Z5Qp72YrNg3wkKY8YUvsXAthlLkqRYYV5v43g8AvdS/awoUjHEMhU8Kp7QQT/aLvS
 UL1HEjAuVtkduIjJfP41YPija+bNlb7DgJPLDUknhc/aBeho3iaJTxz91eIyo43bcTOQ
 S4yohOotjetCqA+VtVKAxbZy6iSRQ2jvKSfPPl07fnCINL7GGfsop6U5jgGx4TX+GBfD
 S0BQXfDPG4iM18viRVKMkz7LwH7Q3WSvPqR/3RWQ33/YFPcoyGkO4VRQVa6dss2DmCMz Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 351rh48rjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 09:13:33 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0APE4Lhh152566;
        Wed, 25 Nov 2020 09:13:33 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 351rh48rgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 09:13:32 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0APEDVUM013830;
        Wed, 25 Nov 2020 14:13:31 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34xt5hcrt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 14:13:30 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0APEDSIO8258250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 14:13:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBB19AE063;
        Wed, 25 Nov 2020 14:13:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2F2AAE083;
        Wed, 25 Nov 2020 14:13:27 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.183.229])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Nov 2020 14:13:27 +0000 (GMT)
Date:   Wed, 25 Nov 2020 16:13:25 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201125141325.GK123287@linux.ibm.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
 <X73s8fxDKPRD6wET@redhat.com>
 <1c4c405b-52e0-cf6b-1f82-91a0a1e3dd53@suse.cz>
 <cd9f0b9f-c4f6-b80c-03cd-12697324bfca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd9f0b9f-c4f6-b80c-03cd-12697324bfca@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_08:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=84 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 02:32:02PM +0100, David Hildenbrand wrote:
> On 25.11.20 13:08, Vlastimil Babka wrote:
> > On 11/25/20 6:34 AM, Andrea Arcangeli wrote:
> >> Hello,
> >>
> >> On Mon, Nov 23, 2020 at 02:01:16PM +0100, Vlastimil Babka wrote:
> >>> On 11/21/20 8:45 PM, Andrea Arcangeli wrote:
> >>>> A corollary issue was fixed in
> >>>> 39639000-39814fff : Unknown E820 type
> >>>>
> >>>> pfn 0x7a200 -> 0x7a200000 min_pfn hit non-RAM:
> >>>>
> >>>> 7a17b000-7a216fff : Unknown E820 type
> >>>
> >>> It would be nice to also provide a /proc/zoneinfo and how exactly the 
> >>> "zone_spans_pfn" was violated. I assume we end up below zone's 
> >>> start_pfn, but is it true?
> >>
> >> Agreed, I was about to grab that info along with all page struct
> >> around the pfn 0x7a200 and phys address 0x7a216fff.
> >>
> >> # grep -A1 E820 /proc/iomem
> >> 7a17b000-7a216fff : Unknown E820 type
> >> 7a217000-7bffffff : System RAM
> >>
> >> DMA      zone_start_pfn 1            zone_end_pfn() 4096         contiguous 1
> >> DMA32    zone_start_pfn 4096         zone_end_pfn() 1048576      contiguous 0
> >> Normal   zone_start_pfn 1048576      zone_end_pfn() 4715392      contiguous 1
> >> Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0
> > 
> > So the above means that around the "Unknown E820 type" we have:
> > 
> > pfn 499712 - start of pageblock in ZONE_DMA32
> > pfn 500091 - start of the "Unknown E820 type" range
> > pfn 500224 - start of another pageblock
> > pfn 500246 - end of "Unknown E820 type"
> > 
> > So this is indeed not a zone boundary issue, but basically a hole not 
> > aligned to pageblock boundary and really unexpected.
> > We have CONFIG_HOLES_IN_ZONE (that x86 doesn't set) for architectures 
> > that do this, and even that config only affects pfn_valid_within(). But 
> > here pfn_valid() is true, but the zone/node linkage is unexpected.
> > 
> >> However the real bug seems that reserved pages have a zero zone_id in
> >> the page->flags when it should have the real zone id/nid. The patch I
> >> sent earlier to validate highest would only be needed to deal with
> >> pfn_valid.
> >>
> >> Something must have changed more recently than v5.1 that caused the
> >> zoneid of reserved pages to be wrong, a possible candidate for the
> >> real would be this change below:
> >>
> >> +               __init_single_page(pfn_to_page(pfn), pfn, 0, 0);
> >>
> >> Even if it may not be it, at the light of how the reserved page
> >> zoneid/nid initialized went wrong, the above line like it's too flakey
> >> to stay.
> >>
> >> It'd be preferable if the pfn_valid fails and the
> >> pfn_to_section_nr(pfn) returns an invalid section for the intermediate
> >> step. Even better memset 0xff over the whole page struct until the
> >> second stage comes around.
> >>
> >> Whenever pfn_valid is true, it's better that the zoneid/nid is correct
> >> all times, otherwise if the second stage fails we end up in a bug with
> >> weird side effects.
> > 
> > Yeah I guess it would be simpler if zoneid/nid was correct for 
> > pfn_valid() pfns within a zone's range, even if they are reserved due 
> > not not being really usable memory.
> > 
> > I don't think we want to introduce CONFIG_HOLES_IN_ZONE to x86. If the 
> > chosen solution is to make this to a real hole, the hole should be 
> > extended to MAX_ORDER_NR_PAGES aligned boundaries.
> 
> As we don't punch out pages of the memmap on x86-64, pfn_valid() keeps
> working as expected. There is a memmap that can be accessed and that was
> initialized.

I suspect that memmap for the reserved pages is not properly initialized
after recent changes in free_area_init(). They are cleared at
init_unavailable_mem() to have zone=0 and node=0, but they seem to be
never re-initialized with proper zone and node links which was not the
case before commit 73a6e474cb37 ("mm: memmap_init: iterate over memblock
regions rather that check each PFN").

Back then, memmap_init_zone() looped from zone_start_pfn till
zone_end_pfn and struct page for reserved pages with pfns inside the
zone would be initialized.

Now the loop is for interesection of [zone_start_pfn, zone_end_pfn] with
memblock.memory and for x86 reserved ranges are not in memblock.memory,
so the memmap for them remains semi-initialized.

> It's really just a matter of how to handle memory holes in
> this scenario.
> 
> a) Try initializing them to the covering node/zone (I gave one example
>    that might be tricky with hotplug)
> b) Mark such pages (either special node/zone or pagetype) and make pfn
>    walkers ignore these holes. For now, this can only be done via the
>    reserved flag.
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
