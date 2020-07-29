Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BAA231C22
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgG2Jco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 05:32:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgG2Jcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:32:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06T93bf6067805;
        Wed, 29 Jul 2020 05:32:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jy8vkapt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 05:32:12 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06T93iK8068431;
        Wed, 29 Jul 2020 05:32:06 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jy8vkajg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 05:32:05 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06T9TuNs015244;
        Wed, 29 Jul 2020 09:31:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 32gcpx4vje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 09:31:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06T9Vu8657933988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 09:31:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EADC52050;
        Wed, 29 Jul 2020 09:31:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.204.160])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 01EE75204F;
        Wed, 29 Jul 2020 09:31:52 +0000 (GMT)
Date:   Wed, 29 Jul 2020 12:31:50 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Justin He <Justin.He@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Capper <Steve.Capper@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem
 alignment
Message-ID: <20200729093150.GC3672596@linux.ibm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
 <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
 <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_03:2020-07-29,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 mlxlogscore=891
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007290061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

On Wed, Jul 29, 2020 at 08:27:58AM +0000, Justin He wrote:
> Hi David
> > >
> > > Without this series, if qemu creates a 4G bytes nvdimm device, we can
> > only
> > > use 2G bytes for dax pmem(kmem) in the worst case.
> > > e.g.
> > > 240000000-33fdfffff : Persistent Memory
> > > We can only use the memblock between [240000000, 2ffffffff] due to the
> > hard
> > > limitation. It wastes too much memory space.
> > >
> > > Decreasing the SECTION_SIZE_BITS on arm64 might be an alternative, but
> > there
> > > are too many concerns from other constraints, e.g. PAGE_SIZE, hugetlb,
> > > SPARSEMEM_VMEMMAP, page bits in struct page ...
> > >
> > > Beside decreasing the SECTION_SIZE_BITS, we can also relax the kmem
> > alignment
> > > with memory_block_size_bytes().
> > >
> > > Tested on arm64 guest and x86 guest, qemu creates a 4G pmem device. dax
> > pmem
> > > can be used as ram with smaller gap. Also the kmem hotplug add/remove
> > are both
> > > tested on arm64/x86 guest.
> > >
> > 
> > Hi,
> > 
> > I am not convinced this use case is worth such hacks (that’s what it is)
> > for now. On real machines pmem is big - your example (losing 50% is
> > extreme).
> > 
> > I would much rather want to see the section size on arm64 reduced. I
> > remember there were patches and that at least with a base page size of 4k
> > it can be reduced drastically (64k base pages are more problematic due to
> > the ridiculous THP size of 512M). But could be a section size of 512 is
> > possible on all configs right now.
> 
> Yes, I once investigated how to reduce section size on arm64 thoughtfully:
> There are many constraints for reducing SECTION_SIZE_BITS
> 1. Given page->flags bits is limited, SECTION_SIZE_BITS can't be reduced too
>    much.
> 2. Once CONFIG_SPARSEMEM_VMEMMAP is enabled, section id will not be counted
>    into page->flags.
> 3. MAX_ORDER depends on SECTION_SIZE_BITS 
>  - 3.1 mmzone.h
> #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
> #error Allocator MAX_ORDER exceeds SECTION_SIZE
> #endif
>  - 3.2 hugepage_init()
> MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER >= MAX_ORDER);
> 
> Hence when ARM64_4K_PAGES && CONFIG_SPARSEMEM_VMEMMAP are enabled,
> SECTION_SIZE_BITS can be reduced to 27.
> But when ARM64_64K_PAGES, given 3.2, MAX_ORDER > 29-16 = 13.
> Given 3.1 SECTION_SIZE_BITS >= MAX_ORDER+15 > 28. So SECTION_SIZE_BITS can not
> be reduced to 27.
> 
> In one word, if we considered to reduce SECTION_SIZE_BITS on arm64, the Kconfig
> might be very complicated,e.g. we still need to consider the case for
> ARM64_16K_PAGES.

It is not necessary to pollute Kconfig with that.
arch/arm64/include/asm/sparesemem.h can have something like

#ifdef CONFIG_ARM64_64K_PAGES
#define SPARSE_SECTION_SIZE 29
#elif defined(CONFIG_ARM16K_PAGES)
#define SPARSE_SECTION_SIZE 28
#elif defined(CONFIG_ARM4K_PAGES)
#define SPARSE_SECTION_SIZE 27
#else
#error
#endif
 
There is still large gap with ARM64_64K_PAGES, though.

As for SPARSEMEM without VMEMMAP, are there actual benefits to use it?

> > 
> > In the long term we might want to rework the memory block device model
> > (eventually supporting old/new as discussed with Michal some time ago
> > using a kernel parameter), dropping the fixed sizes
> 
> Has this been posted to Linux mm maillist? Sorry, searched and didn't find it.
> 
> 
> --
> Cheers,
> Justin (Jia He)
> 
> 
> 
> > - allowing sizes / addresses aligned with subsection size
> > - drastically reducing the number of devices for boot memory to only a
> > hand full (e.g., one per resource / DIMM we can actually unplug again.
> > 
> > Long story short, I don’t like this hack.
> > 
> > 
> > > This patch series (mainly patch6/6) is based on the fixing patch, ~v5.8-
> > rc5 [2].
> > >
> > > [1] https://lkml.org/lkml/2019/6/19/67
> > > [2] https://lkml.org/lkml/2020/7/8/1546
> > > Jia He (6):
> > >  mm/memory_hotplug: remove redundant memory block size alignment check
> > >  resource: export find_next_iomem_res() helper
> > >  mm/memory_hotplug: allow pmem kmem not to align with memory_block_size
> > >  mm/page_alloc: adjust the start,end in dax pmem kmem case
> > >  device-dax: relax the memblock size alignment for kmem_start
> > >  arm64: fall back to vmemmap_populate_basepages if not aligned  with
> > >    PMD_SIZE
> > >
> > > arch/arm64/mm/mmu.c    |  4 ++++
> > > drivers/base/memory.c  | 24 ++++++++++++++++--------
> > > drivers/dax/kmem.c     | 22 +++++++++++++---------
> > > include/linux/ioport.h |  3 +++
> > > kernel/resource.c      |  3 ++-
> > > mm/memory_hotplug.c    | 39 ++++++++++++++++++++++++++++++++++++++-
> > > mm/page_alloc.c        | 14 ++++++++++++++
> > > 7 files changed, 90 insertions(+), 19 deletions(-)
> > >
> > > --
> > > 2.17.1
> > >
> 

-- 
Sincerely yours,
Mike.
