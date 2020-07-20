Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B959E227126
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgGTVl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 17:41:56 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:34428 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgGTVjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:39:16 -0400
Date:   Mon, 20 Jul 2020 17:39:13 -0400
From:   Rich Felker <dalias@libc.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jia He <justin.he@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v3 3/6] sh/mm: use default dummy
 memory_add_physaddr_to_nid()
Message-ID: <20200720213913.GM14669@brightrain.aerifal.cx>
References: <20200709020629.91671-1-justin.he@arm.com>
 <20200709020629.91671-4-justin.he@arm.com>
 <f1a172b2-80c2-1ec7-483f-f3fba761ccb0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1a172b2-80c2-1ec7-483f-f3fba761ccb0@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 11:10:36AM +0200, David Hildenbrand wrote:
> On 09.07.20 04:06, Jia He wrote:
> > After making default memory_add_physaddr_to_nid in mm/memory_hotplug,
> > there is no use to define a similar one in arch specific directory.
> > 
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  arch/sh/mm/init.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> > index a70ba0fdd0b3..f75932ba87a6 100644
> > --- a/arch/sh/mm/init.c
> > +++ b/arch/sh/mm/init.c
> > @@ -430,15 +430,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >  	return ret;
> >  }
> >  
> > -#ifdef CONFIG_NUMA
> > -int memory_add_physaddr_to_nid(u64 addr)
> > -{
> > -	/* Node 0 for now.. */
> > -	return 0;
> > -}
> > -EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > -#endif
> > -
> >  void arch_remove_memory(int nid, u64 start, u64 size,
> >  			struct vmem_altmap *altmap)
> >  {
> > 
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by: Rich Felker <dalias@libc.org>

