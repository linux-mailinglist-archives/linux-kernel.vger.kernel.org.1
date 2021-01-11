Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4359B2F172C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbhAKOCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:02:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730396AbhAKOB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:01:59 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10BDuv9m101656;
        Mon, 11 Jan 2021 09:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=EvnsPRi4M8d1yLh5T8kdmJRIke6AsT9aBAd5yDK4lLY=;
 b=MCxvk/JU0bG7ryZ6gB6DvAfx7FGc4yrwx2vIGWFFVyjiZK2g6zNoyBR3yhj2xP/eWoaz
 ROkpOiTXczlWvOhY2MMX9yq5SkPtP86AW+vuXAXotWsOtrwMOxJceTufwpp2PWUqLaOh
 3v7gxugA1XgrnXDJkQrGjOQpmc9+FSCmJLF04ini9DuE6VszEmYiCRZRQscK3YJ8FuV2
 kloI5zwrSG11i84yiAnQarnbcD4IHeeIixdTdKBycrdT5BCa47vZMYszTWSbtrS+pQK0
 cTPGI5EnaKIDejfw+dpsaQ3dA4+hTbkAKWpkK3UQERMcks5OaezOGW1M7cMQblBYG0n6 lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 360r0s85v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 09:00:59 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10BDxOD8119637;
        Mon, 11 Jan 2021 09:00:59 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 360r0s85sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 09:00:59 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10BDw9sT015477;
        Mon, 11 Jan 2021 14:00:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 35y448abdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 14:00:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10BE0siQ40829282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 14:00:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DE444C058;
        Mon, 11 Jan 2021 14:00:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8BFA4C059;
        Mon, 11 Jan 2021 14:00:51 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.176.60])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Jan 2021 14:00:51 +0000 (GMT)
Date:   Mon, 11 Jan 2021 16:00:49 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
Message-ID: <20210111140049.GG832698@linux.ibm.com>
References: <1608621144-4001-1-git-send-email-anshuman.khandual@arm.com>
 <1608621144-4001-2-git-send-email-anshuman.khandual@arm.com>
 <4b282848-d2d7-6156-4726-ce974b2dff41@redhat.com>
 <75d0da03-204a-c2b2-aba9-f70d2f5b6e40@arm.com>
 <3616e9f5-b825-6575-45ce-bfc1b1408c89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3616e9f5-b825-6575-45ce-bfc1b1408c89@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-11_26:2021-01-11,2021-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101110081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:31:02AM +0100, David Hildenbrand wrote:
> On 04.01.21 07:18, Anshuman Khandual wrote:

...

> >> Actually, I think we want to check for partial present sections.
> >>
> >> Maybe we can rather switch to generic pfn_valid() and tweak it to
> >> something like
> >>
> >> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >> index fb3bf696c05e..7b1fcce5bd5a 100644
> >> --- a/include/linux/mmzone.h
> >> +++ b/include/linux/mmzone.h
> >> @@ -1382,9 +1382,13 @@ static inline int pfn_valid(unsigned long pfn)
> >>                 return 0;
> >>         /*
> >>          * Traditionally early sections always returned pfn_valid() for
> >> -        * the entire section-sized span.
> >> +        * the entire section-sized span. Some archs might have holes in
> >> +        * early sections, so double check with memblock if configured.
> >>          */
> >> -       return early_section(ms) || pfn_section_valid(ms, pfn);
> >> +       if (early_section(ms))
> >> +               return IS_ENABLED(CONFIG_EARLY_SECTION_MEMMAP_HOLES) ?
> >> +                      memblock_is_map_memory(pfn << PAGE_SHIFT) : 1;
> >> +       return pfn_section_valid(ms, pfn);
> >>  }
> >>  #endif
> > 
> > Could not find CONFIG_EARLY_SECTION_MEMMAP_HOLES. Are you suggesting to
> > create this config which could track platform scenarios where all early
> > sections might not have mmap coverage such as arm64 ?
> 
> Yes, a new config that states what's actually happening.

Just to clarify, there are several architectures that may free parts of
memmap with FLATMEM/SPARSEMEM and this functionality is gated by
CONFIG_HAVE_ARCH_PFN_VALID.

So if arm64 is to use a generic version, this should be also taken into
account.

> >> Which users are remaining that require us to add/remove memblocks when
> >> hot(un)plugging memory
> >>
> >>  $ git grep KEEP_MEM | grep memory_hotplug
> >> mm/memory_hotplug.c:    if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
> >> mm/memory_hotplug.c:    if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
> >> mm/memory_hotplug.c:    if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> > 
> > Did not follow, do we want to drop ARCH_KEEP_MEMBLOCK ? Without it arm64
> > will not be able to track MEMBLOCK_NOMAP memory at runtime.
> 
> I'd only like the hot(un)plug parts gone for now, if possible: I don't
> see the need for that handling really that cannot be handled easier, as
> in the proposed pfn_valid() changes.
> 
> I understand that current handling of memory holes in early sections and
> memory marked as MEMBLOCK_NOMAP requires ARCH_KEEP_MEMBLOCK for now.
 
This is mostly about the holes in the memory map. I believe it does not
matter if that memory is NOMAP or not, the holes in the memmap are punched
for anything in memblock.memory.

It seems to me that for arm64's pfn_valid() we can safely replace
memblock_is_map_memory() with memblock_is_memory(), not that it would
change much.

> >> I think one user we would have to handle is
> >> arch/arm64/mm/mmap.c:valid_phys_addr_range(). AFAIS, powerpc at least
> >> does not rely on memblock_is_map_memory.
> > 
> > memblock_is_map_memory() is currently used only on arm/arm64 platforms.
> > Apart from the above example in valid_phys_addr_range(), there are some
> > other memblock_is_map_memory() call sites as well. But then, we are not
> > trying to completely drop memblock_is_map_memory() or are we ?
> 
> No, just change the semantics: only relevant for early sections. Imagine
> freezing MEMBLOCK state after boot.
> 
> Only early sections can have memory holes and might be marked
> MEMBLOCK_NOMAP. For hotplugged memory, we don't have to call
> memblock_is_map_memory().
>
> -- 
> Thanks,
> 
> David / dhildenb

-- 
Sincerely yours,
Mike.
