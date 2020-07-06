Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC6F2155C8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 12:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgGFKrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 06:47:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2429 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728514AbgGFKrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:47:11 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 6BF1FF7319A1771C71D1;
        Mon,  6 Jul 2020 11:47:09 +0100 (IST)
Received: from localhost (10.52.123.111) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 6 Jul 2020
 11:47:08 +0100
Date:   Mon, 6 Jul 2020 11:46:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jia He <justin.he@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH 1/3] arm64/numa: set numa_off to false when numa node is
 fake
Message-ID: <20200706114605.000050ac@Huawei.com>
In-Reply-To: <20200706112921.00006f7f@Huawei.com>
References: <20200706011947.184166-1-justin.he@arm.com>
        <20200706011947.184166-2-justin.he@arm.com>
        <20200706112921.00006f7f@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.111]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 11:29:21 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 6 Jul 2020 09:19:45 +0800
> Jia He <justin.he@arm.com> wrote:
> 
> Hi,
> 
> > Previously, numa_off is set to true unconditionally in dummy_numa_init(),
> > even if there is a fake numa node.
> > 
> > But acpi will translate node id to NUMA_NO_NODE(-1) in acpi_map_pxm_to_node()
> > because it regards numa_off as turning off the numa node.  
> 
> That is correct.  It is operating exactly as it should, if SRAT hasn't been parsed
> and you are on ACPI platform there are no nodes.  They cannot be created at
> some later date.  The dummy code doesn't change this. It just does enough to carry
> on operating with no specified nodes.
> 
> > 
> > Without this patch, pmem can't be probed as a RAM device on arm64 if SRAT table
> > isn't present.
> > 
> > $ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -a 64K
> > kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with invalid node: -1
> > kmem: probe of dax0.0 failed with error -22
> > 
> > This fixes it by setting numa_off to false.  
> 
> Without the SRAT protection patch [1] you may well run into problems
> because someone somewhere will have _PXM in a DSDT but will
> have a non existent SRAT.   We had this happen on an AMD platform when we
> tried to introduce working _PXM support for PCI. [2]
> 
> So whilst this seems superficially safe, I'd definitely be crossing your fingers.
> Note, at that time I proposed putting the numa_off = false into the x86 code
> path precisely to cut out that possibility (was rejected at the time, at least
> partly because the clarifications to the ACPI spec were not pubilc.)
> 
> The patch in [1] should sort things out however by ensuring we only create
> new domains where we should actually be doing so. However, in your case
> it will return NUMA_NO_NODE anyway so this isn't the right way to fix things.
> 
> [1] https://patchwork.kernel.org/patch/11632063/
> [2] https://patchwork.kernel.org/patch/10597777/

Thinking a bit more on this...

I'd like to understand more on what your use case is.

Do you have an NFIT that is setting the proximity domain for the
non-volatile memory in SPA structures?  If so the ACPI spec (6.3 makes this
clear) requires those match with domains described in SRAT.
If SRAT isn't there, then we can't expect sensible results from using these
values from NFIT.
If SRAT is there and numa=off is set then we should probably also rule out
parsing NFIT, or make all nfit handling fine with NO_NUMA_NODE, preferably
with explicit checks to ensure we don't try to use the Proximity Node values
as they have no meaning with numa=off. I note that the core NFIT parsing
is fine with the value not being supplied in the first place.

https://elixir.bootlin.com/linux/latest/source/drivers/acpi/nfit/core.c#L2947

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  arch/arm64/mm/numa.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > index aafcee3e3f7e..7689986020d9 100644
> > --- a/arch/arm64/mm/numa.c
> > +++ b/arch/arm64/mm/numa.c
> > @@ -440,7 +440,8 @@ static int __init dummy_numa_init(void)
> >  		return ret;
> >  	}
> >  
> > -	numa_off = true;
> > +	/* force numa_off to be false since we have a fake numa node here */
> > +	numa_off = false;
> >  	return 0;
> >  }
> >    
> 


