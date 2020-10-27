Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CDA29C319
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1821391AbgJ0RnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1821381AbgJ0RnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:43:10 -0400
Received: from sstabellini-ThinkPad-T480s (c-24-130-65-46.hsd1.ca.comcast.net [24.130.65.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2B912054F;
        Tue, 27 Oct 2020 17:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603820590;
        bh=7PAIrARo+U5BjdgOi0yQlsQrBkmZ+IVZWY4TopAO5S0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=MMM+0N60ODKjqcP7/UwhGGndw5EYDfe/PwXyJI+6tNbzrhUuGH+SoWyHcSgzjOqNz
         fovF3qvrYsGblmTK/PtbuY+/wlQATssJpiclYPtzUGafdoOhjwqfgsoQBeFL/zjs2R
         wQhW8o38W5vMUl+wL+KE9PxS4CW7FEyLrSSwW2SI=
Date:   Tue, 27 Oct 2020 10:43:09 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, hch@lst.de
Subject: Re: [PATCH] fix swiotlb panic on Xen
In-Reply-To: <20201027133701.GB6077@char.us.oracle.com>
Message-ID: <alpine.DEB.2.21.2010271041490.12247@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2010261653320.12247@sstabellini-ThinkPad-T480s> <20201027133701.GB6077@char.us.oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020, Konrad Rzeszutek Wilk wrote:
> On Mon, Oct 26, 2020 at 05:02:14PM -0700, Stefano Stabellini wrote:
> > From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > 
> > kernel/dma/swiotlb.c:swiotlb_init gets called first and tries to
> > allocate a buffer for the swiotlb. It does so by calling
> > 
> >   memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
> > 
> > If the allocation must fail, no_iotlb_memory is set.
> > 
> > 
> > Later during initialization swiotlb-xen comes in
> > (drivers/xen/swiotlb-xen.c:xen_swiotlb_init) and given that io_tlb_start
> > is != 0, it thinks the memory is ready to use when actually it is not.
> > 
> > When the swiotlb is actually needed, swiotlb_tbl_map_single gets called
> > and since no_iotlb_memory is set the kernel panics.
> > 
> > Instead, if swiotlb-xen.c:xen_swiotlb_init knew the swiotlb hadn't been
> > initialized, it would do the initialization itself, which might still
> > succeed.
> > 
> > 
> > Fix the panic by setting io_tlb_start to 0 on swiotlb initialization
> > failure, and also by setting no_iotlb_memory to false on swiotlb
> > initialization success.
> 
> Should this have a Fixes: flag?

That would be

Fixes: ac2cbab21f31 ("x86: Don't panic if can not alloc buffer for swiotlb")



> > Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > 
> > 
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index c19379fabd20..9924214df60a 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -231,6 +231,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> >  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
> >  	}
> >  	io_tlb_index = 0;
> > +	no_iotlb_memory = false;
> >  
> >  	if (verbose)
> >  		swiotlb_print_info();
> > @@ -262,9 +263,11 @@ swiotlb_init(int verbose)
> >  	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
> >  		return;
> >  
> > -	if (io_tlb_start)
> > +	if (io_tlb_start) {
> >  		memblock_free_early(io_tlb_start,
> >  				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
> > +		io_tlb_start = 0;
> > +	}
> >  	pr_warn("Cannot allocate buffer");
> >  	no_iotlb_memory = true;
> >  }
> > @@ -362,6 +365,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
> >  		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
> >  	}
> >  	io_tlb_index = 0;
> > +	no_iotlb_memory = false;
> >  
> >  	swiotlb_print_info();
> >  
> 
