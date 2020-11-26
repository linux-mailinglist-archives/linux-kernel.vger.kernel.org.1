Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642112C5157
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbgKZJgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:36:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730787AbgKZJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:36:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQ9VcSk046886;
        Thu, 26 Nov 2020 04:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=BHOW0tulpmQeXyFvwbUO41NDo+7nvJxRlbNmyPuLc/o=;
 b=pqvQlBc0VjV9vZp6DbXGQRkCFCj3NkrfY5tsQlNLjR4JiBR3vg6IuFw2repZ/cvq5O4b
 pTUNyZhhncz0e4a3OZL5H3oNwD39KQ19fQvIiaFCK0ibpzdHRcr8LPDB8FzsDx81Wxbg
 GzQ5SNWkDmwYI3aoirbExL9K+ellWzcsIBJiBmdydypXQxRdqWSAvYaVMwtBOBWHDr7a
 E/LpU0WmfS0MQ17JvbbxB5rULKIplVJXyZVLsufI45rPAKoknSAui205xZ+0f98iIW3N
 X1SBffFlWFcpiHBrjTw6d5C7Wve2GY82XAPWbIzISouY+VuHgwJk5LVkXWeqdMlBwflN MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3526npd9je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 04:36:10 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AQ9WjTB050156;
        Thu, 26 Nov 2020 04:36:09 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3526npd9hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 04:36:09 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQ9S2ln026666;
        Thu, 26 Nov 2020 09:36:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3518j8hh1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 09:36:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQ9a5AR48038218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 09:36:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DF3E11C05B;
        Thu, 26 Nov 2020 09:36:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95CA111C050;
        Thu, 26 Nov 2020 09:36:04 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.183.229])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Nov 2020 09:36:04 +0000 (GMT)
Date:   Thu, 26 Nov 2020 11:36:02 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201126093602.GQ123287@linux.ibm.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X77OyM8utmWcq1Di@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_03:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 04:38:16PM -0500, Andrea Arcangeli wrote:
> On Wed, Nov 25, 2020 at 11:04:14PM +0200, Mike Rapoport wrote:
> > I think the very root cause is how e820__memblock_setup() registers
> > memory with memblock:
> > 
> > 		if (entry->type == E820_TYPE_SOFT_RESERVED)
> > 			memblock_reserve(entry->addr, entry->size);
> > 
> > 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> > 			continue;
> > 
> > 		memblock_add(entry->addr, entry->size);
> > 
> > From that point the system has inconsistent view of RAM in both
> > memblock.memory and memblock.reserved and, which is then translated to
> > memmap etc.
> > 
> > Unfortunately, simply adding all RAM to memblock is not possible as
> > there are systems that for them "the addresses listed in the reserved
> > range must never be accessed, or (as we discovered) even be reachable by
> > an active page table entry" [1].
> > 
> > [1] https://lore.kernel.org/lkml/20200528151510.GA6154@raspberrypi/
> 
> It looks like what's missing is a blockmem_reserve which I don't think
> would interfere at all with the issue above since it won't create
> direct mapping and it'll simply invoke the second stage that wasn't
> invoked here.
> 
> I guess this would have a better chance to have the second
> initialization stage run in reserve_bootmem_region and it would likely
> solve the problem without breaking E820_TYPE_RESERVED which is known
> by the kernel:
> 
> > 		if (entry->type == E820_TYPE_SOFT_RESERVED)
> > 			memblock_reserve(entry->addr, entry->size);
> > 
> 
> +		if (entry->type == 20)
> +			memblock_reserve(entry->addr, entry->size);
> 
> > 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> > 			continue;
> > 
> 
> This is however just to show the problem, I didn't check what type 20
> is.

I think it's inveneted by your BIOS vendor :)

> To me it doesn't look the root cause though, the root cause is that if
> you don't call memblock_reserve the page->flags remains uninitialized.

I didn't mean that root cause is that we don't call memblock_reserve().
I meant that the root cause is inconsitency in memory representation.

On most architectures, memblock.memory represents the entire RAM in the
system and memblock.reserved represents memory regions that were
reserved either by the firmware or by the kernel during early boot.

On x86 the memory that firmware reserved for its use is never considered
memory and some of the reserved memory types are never registered with
memblock at all.

As memblock data is used to initialize the memory map, we end up with
some page structs not being properly initialized.

> I think the page_alloc.c need to be more robust and detect at least if
> if holes within zones (but ideally all pfn_valid of all struct pages
> in system even if beyond the end of the zone) aren't being initialized
> in the second stage without relying on the arch code to remember to
> call memblock_reserve.

I agree that page_alloc.c needs to be more robust, but it anyway needs
to rely on some data supplied by arch to know where valid memory is.
With SPARSMEM, pfn_valid() only says where memmap exists, it's not
necessary there is an actual page frame behind a valid pfn.

> In fact it's not clear why memblock_reserve even exists, that
> information can be calculated reliably by page_alloc in function of
> memblock.memory alone by walking all nodes and all zones. It doesn't
> even seem to help in destroying the direct mapping,
> reserve_bootmem_region just initializes the struct pages so it doesn't
> need a special memeblock_reserved to find those ranges.

memblock_reserve() is there to allow architectures to mark memory
regions as busy so this memory won't be used by buddy as free pages. It
could be memory that firmware reported as reserved, memory occupied by
the kernel image and initrd, or the early memory allocations kernel does
before page allocator is up.

> In fact it's scary that codes then does stuff like this trusting the
> memblock_reserve is nearly complete information (which obviously isn't
> given type 20 doesn't get queued and I got that type 20 in all my systems):
> 
> 	for_each_reserved_mem_region(i, &start, &end) {
> 		if (addr >= start && addr_end <= end)
> 			return true;
> 	}
> 
> That code in irq-gic-v3-its.c should stop using
> for_each_reserved_mem_region and start doing
> pfn_valid(addr>>PAGE_SHIFT) if
> PageReserved(pfn_to_page(addr>>PAGE_SHIFT)) instead.

I think that for coldpluged CPUs this code runs before memmap us set up,
so pfn_valid() or PageReserved() are not yet available then.

> At best memory.reserved should be calculated automatically by the
> page_alloc.c based on the zone_start_pfn/zone_end_pfn and not passed
> by the e820 caller, instead of adding the memory_reserve call for type
> 20 we should delete the memory_reserve function.
 
memory.reserved cannot be calculated automatically. It represents all
the memory allocations made before page allocator is up. And as
memblock_reserve() is the most basic to allocate memory early at boot we
cannot really delete it ;-)

As for e820 and type 20, unless it is in memblock, page_alloc.c has no
way to properly initialize memmap for it. It can continue to guess, like
it does with init_unavailable_memory().

> Thanks,
> Andrea
> 

-- 
Sincerely yours,
Mike.
