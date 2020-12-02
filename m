Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8099D2CC3FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgLBRk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:40:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728585AbgLBRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:40:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2HXEO9077312;
        Wed, 2 Dec 2020 12:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=kNpV886y/44gEnyUQ9hjZixG4MKvwQNJQidOK9zGcZw=;
 b=l9ZjxZnvgN9qM+IP5IataK6p71X0VvaCXImpJpvW/EQ5GFu8TylNACs7u/AKPDkZzGkN
 lngdjXa1JUctoj9TEDAH73aDR/mpFqzcW9XKJnb2KMN5iuNTHROcvaaAW3hcXwi2asJA
 Y9GrCqn3zGRccX9jB49vwUohzzCfIPar3Blbr5BszeE9xfSXsMofnRnYQ2rxgdw29oAC
 H8NeQUYCyJnd+gKMxR/GKfq/brXQgpi5kXSWE6oua5gMDeslO6/TE71noSkWLE8/h5+j
 8oq71yG1Jx4am+M9+tHVWm36y76UwNnysjHNyp76QPrHkElWOoXlvqwGqgTI/lJJ53/1 KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355sr5yga5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 12:39:32 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B2HXtdE079052;
        Wed, 2 Dec 2020 12:39:32 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355sr5yg97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 12:39:32 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2HcZ3A024666;
        Wed, 2 Dec 2020 17:39:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 35693xgatg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 17:39:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2HdRTT6619868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 17:39:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DEFFA4040;
        Wed,  2 Dec 2020 17:39:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 214B4A404D;
        Wed,  2 Dec 2020 17:39:26 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.50.18])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Dec 2020 17:39:25 +0000 (GMT)
Date:   Wed, 2 Dec 2020 19:39:23 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201202173923.GM123287@linux.ibm.com>
References: <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
 <3bb709a7-6100-aa5c-4125-7ed80c6d9643@redhat.com>
 <20201126174601.GT123287@linux.ibm.com>
 <20201129123257.GY123287@linux.ibm.com>
 <X8bjgw5LPAZrSrwp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8bjgw5LPAZrSrwp@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_10:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

On Tue, Dec 01, 2020 at 07:44:51PM -0500, Andrea Arcangeli wrote:
> Hello Mike,
> 
> On Sun, Nov 29, 2020 at 02:32:57PM +0200, Mike Rapoport wrote:
> > Hello Andrea,
> > 
> > On Thu, Nov 26, 2020 at 07:46:05PM +0200, Mike Rapoport wrote:
> > > On Thu, Nov 26, 2020 at 11:05:14AM +0100, David Hildenbrand wrote:
> > > 
> > > Let's try to merge init_unavailable_memory() into memmap_init().
> > > Than it'll be able to set zone/nid for those nasty pfns that BIOS
> > > decided to keep to itself, like in Andrea's case and will also take care
> > > of struct pages that do not really have a frame in DRAM, but are there
> > > because of arbitrary section size.
> > 
> > Did you have a chance to check if this solves your issue?
> > If yes, I'll resend this as a formal patch.
> 
> I tested the patch you sent, but it doesn't seem to boot. Reverting it
> booted.

Hmm, do you have any logs? It worked on my box and with various memory
configurations in qemu.

> Also I noticed leaving pages uninitialized already happened before and
> was fixed in 124049decbb121ec32742c94fb5d9d6bed8f24d8 where literally
> all holes were registered in memblock_reserve() by hand to workaround
> this very same defect in memblock callee we're fixing again.
>
> Then it was lifted in 9fd61bc95130d4971568b89c9548b5e0a4e18e0e since
> the memblock was supposed to be able to initialize all pages.

I still that think both 124049decbb1 ("x86/e820: put !E820_TYPE_RAM
regions into memblock.reserved") and 9fd61bc95130 ("Revert "x86/e820:
put !E820_TYPE_RAM regions into memblock.reserved") are band aids and
they do not address the root cause but rather try to workaround it.

The problem is that we have no proper way to initialize struct pages
corresponding to holes. The holes can appear in case when the memory is
not a multiple of SECTION_SIZE and, at least on x86, in case BIOS
reserves pages and they are not E820_TYPE_RAM.

The first case is not much of a problem, as I doubt there are still
systems that have not MAX_ORDER aligned memory banks, so the "trailing"
pages in semi-empty section will never be used by the page allocator.

The BIOS case, however is more problematic as it creates holes inside
MAX_ORDER aligned pageblocks.

Pushing the pages in such holes in and out of memblock.reserved won't
really help because they are not in memblock.memory while most
calculations during initialization of page allocator and memory map use
memblock.memory and iterate over it.

As these holes do not seem to appear on zone/node boundaries, we do not
see reports about wrong zone/node sizing because of the holes.

I believe that the proper solution would be to have all the memory
reserved by the firmware added to memblock.memory, like all other
architectures do, but I'm not sure if we can easily and reliably
determine what of E820 reserved types are actually backed by RAM.
So this is not feasible as a short term solution.

My patch [1], though, is an immediate improvement and I think it's worth
trying to fix off-by-one's that prevent your system from booting.

[1] https://lore.kernel.org/lkml/20201201181502.2340-1-rppt@kernel.org

> Since this seems the second time this happens, I'd suggest to change
> the graceful pfn, 0,0 initialization to memset(page, 0xff,
> sizeof(struct page)) too like we mentioned earlier and then have at
> least a DEBUG_SOMETHING=y to search for struct pages with all 1 in
> page->flags to ensure the boot stage worked right so perhaps there's a
> graceful notification at boot before a VM_BUG_ON triggers later. The
> page struct validation could be done based on DEBUG_VM=y too since it
> won't cause any runtime cost post boot.
>
> Thanks,
> Andrea
> 

-- 
Sincerely yours,
Mike.
