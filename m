Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA39217F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 08:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgGHGT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 02:19:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725298AbgGHGT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:19:58 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0686Ce0o118031;
        Wed, 8 Jul 2020 02:19:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3258nxg53j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 02:19:43 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0686DxQb125567;
        Wed, 8 Jul 2020 02:19:42 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3258nxg52v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 02:19:42 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0686GvI5004232;
        Wed, 8 Jul 2020 06:19:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 322h1h44n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 06:19:40 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0686Jchh63307830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 06:19:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0689CAE045;
        Wed,  8 Jul 2020 06:19:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76559AE053;
        Wed,  8 Jul 2020 06:19:36 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Jul 2020 06:19:36 +0000 (GMT)
Date:   Wed, 8 Jul 2020 09:19:34 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Justin He <Justin.He@arm.com>, Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200708061934.GD386073@linux.ibm.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz>
 <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
 <20200708053239.GC386073@linux.ibm.com>
 <CAPcyv4i2gnrugO5n715WsDoj+gxV9Mjt-49zNnv+ROMLYy79LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i2gnrugO5n715WsDoj+gxV9Mjt-49zNnv+ROMLYy79LQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_01:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=1
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 impostorscore=0 cotscore=-2147483648
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:48:19PM -0700, Dan Williams wrote:
> On Tue, Jul 7, 2020 at 10:33 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Tue, Jul 07, 2020 at 08:56:36PM -0700, Dan Williams wrote:
> > > On Tue, Jul 7, 2020 at 7:20 PM Justin He <Justin.He@arm.com> wrote:
> > > >
> > > > Hi Michal and David
> > > >
> > > > > -----Original Message-----
> > > > > From: Michal Hocko <mhocko@kernel.org>
> > > > > Sent: Tuesday, July 7, 2020 7:55 PM
> > > > > To: Justin He <Justin.He@arm.com>
> > > > > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
> > > > > <will@kernel.org>; Dan Williams <dan.j.williams@intel.com>; Vishal Verma
> > > > > <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Andrew
> > > > > Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>;
> > > > > Baoquan He <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>; linux-
> > > > > arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > > > > mm@kvack.org; linux-nvdimm@lists.01.org; Kaly Xin <Kaly.Xin@arm.com>
> > > > > Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid
> > > > > as EXPORT_SYMBOL_GPL
> > > > >
> > > > > On Tue 07-07-20 13:59:15, Jia He wrote:
> > > > > > This exports memory_add_physaddr_to_nid() for module driver to use.
> > > > > >
> > > > > > memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> > > > > > NUMA_NO_NID is detected.
> > > > > >
> > > > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > > > Signed-off-by: Jia He <justin.he@arm.com>
> > > > > > ---
> > > > > >  arch/arm64/mm/numa.c | 5 +++--
> > > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > > > > > index aafcee3e3f7e..7eeb31740248 100644
> > > > > > --- a/arch/arm64/mm/numa.c
> > > > > > +++ b/arch/arm64/mm/numa.c
> > > > > > @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> > > > > >
> > > > > >  /*
> > > > > >   * We hope that we will be hotplugging memory on nodes we already know
> > > > > about,
> > > > > > - * such that acpi_get_node() succeeds and we never fall back to this...
> > > > > > + * such that acpi_get_node() succeeds. But when SRAT is not present,
> > > > > the node
> > > > > > + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback
> > > > > option.
> > > > > >   */
> > > > > >  int memory_add_physaddr_to_nid(u64 addr)
> > > > > >  {
> > > > > > -   pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n",
> > > > > addr);
> > > > > >     return 0;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > > > >
> > > > > Does it make sense to export a noop function? Wouldn't make more sense
> > > > > to simply make it static inline somewhere in a header? I haven't checked
> > > > > whether there is an easy way to do that sanely bu this just hit my eyes.
> > > >
> > > > Okay, I can make a change in memory_hotplug.h, sth like:
> > > > --- a/include/linux/memory_hotplug.h
> > > > +++ b/include/linux/memory_hotplug.h
> > > > @@ -149,13 +149,13 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
> > > >               struct mhp_params *params);
> > > >  #endif /* ARCH_HAS_ADD_PAGES */
> > > >
> > > > -#ifdef CONFIG_NUMA
> > > > -extern int memory_add_physaddr_to_nid(u64 start);
> > > > -#else
> > > > +#if !defined(CONFIG_NUMA) || !defined(memory_add_physaddr_to_nid)
> > > >  static inline int memory_add_physaddr_to_nid(u64 start)
> > > >  {
> > > >         return 0;
> > > >  }
> > > > +#else
> > > > +extern int memory_add_physaddr_to_nid(u64 start);
> > > >  #endif
> > > >
> > > > And then check the memory_add_physaddr_to_nid() helper on all arches,
> > > > if it is noop(return 0), I can simply remove it.
> > > > if it is not noop, after the helper,
> > > > #define memory_add_physaddr_to_nid
> > > >
> > > > What do you think of this proposal?
> > >
> > > Especially for architectures that use memblock info for numa info
> > > (which seems to be everyone except x86) why not implement a generic
> > > memory_add_physaddr_to_nid() that does:
> >
> > That would be only arm64.
> >
> 
> Darn, I saw ARCH_KEEP_MEMBLOCK and had delusions of grandeur that it
> could solve my numa api woes. At least for x86 the problem is already
> solved with reserved numa_meminfo, but now I'm trying to write generic
> drivers that use those apis and finding these gaps on other archs.

I'm not sure if x86's numa_meminfo is a part of the solution or a part
of the problem ;-)
Anyway, this all indeed messy and there is a lot to improve there.

-- 
Sincerely yours,
Mike.
