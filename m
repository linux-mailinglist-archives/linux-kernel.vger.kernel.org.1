Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AAC230644
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 11:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgG1JNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 05:13:39 -0400
Received: from verein.lst.de ([213.95.11.211]:47388 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbgG1JNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:13:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE5F668B05; Tue, 28 Jul 2020 11:13:35 +0200 (CEST)
Date:   Tue, 28 Jul 2020 11:13:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
Message-ID: <20200728091335.GA23744@lst.de>
References: <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de> <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com> <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de> <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com> <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de> <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com> <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de> <CAMi1Hd3O2HHBsnt=sac7FdcW0-3=4S3g_F9f__2h5gTsudfirA@mail.gmail.com> <20200724134114.GA3152@lst.de> <a9b811a84ac21c13693e6ffefd2914b911542e18.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b811a84ac21c13693e6ffefd2914b911542e18.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:56:56PM +0200, Nicolas Saenz Julienne wrote:
> Hi Christoph,
> thanks for having a look at this!
> 
> On Fri, 2020-07-24 at 15:41 +0200, Christoph Hellwig wrote:
> > Yes, the iommu is an interesting case, and the current code is
> > wrong for that.
> 
> Care to expand on this? I do get that checking dma_coherent_ok() on memory
> that'll later on be mapped into an iommu is kind of silly, although I think
> harmless in Amir's specific case, since devices have wide enough dma-ranges. Is
> there more to it?

I think the problem is that it can lead to not finding suitable memory.

> 
> > Can you try the patch below?  It contains a modified version of Nicolas'
> > patch to try CMA again for the expansion and a new (for now hackish) way to
> > not apply the addressability check for dma-iommu allocations.
> > 
> > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > index 6bc74a2d51273e..ec5e525d2b9309 100644
> > --- a/kernel/dma/pool.c
> > +++ b/kernel/dma/pool.c
> > @@ -3,7 +3,9 @@
> >   * Copyright (C) 2012 ARM Ltd.
> >   * Copyright (C) 2020 Google LLC
> >   */
> > +#include <linux/cma.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/dma-contiguous.h>
> >  #include <linux/dma-direct.h>
> >  #include <linux/dma-noncoherent.h>
> >  #include <linux/init.h>
> > @@ -55,6 +57,31 @@ static void dma_atomic_pool_size_add(gfp_t gfp, size_t
> > size)
> >  		pool_size_kernel += size;
> >  }
> >  
> > +static bool cma_in_zone(gfp_t gfp)
> > +{
> > +	phys_addr_t end;
> > +	unsigned long size;
> > +	struct cma *cma;
> > +
> > +	cma = dev_get_cma_area(NULL);
> > +	if (!cma)
> > +		return false;
> > +
> > +	size = cma_get_size(cma);
> > +	if (!size)
> > +		return false;
> > +	end = cma_get_base(cma) - memblock_start_of_DRAM() + size - 1;
> > +
> > +	/* CMA can't cross zone boundaries, see cma_activate_area() */
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA) &&
> > +	    end <= DMA_BIT_MASK(zone_dma_bits))
> > +		return true;
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32) &&
> > +	    end <= DMA_BIT_MASK(32))
> > +		return true;
> > +	return true;
> 
> IIUC this will always return true given a CMA is present. Which reverts to the
> previous behaviour (previous as in breaking some rpi4 setups), isn't it?

Was that really what broke the PI?  I'll try to get the split out series
today, which might have a few more tweaks, and then we'll need to test it
both on these rpi4 setups and Amits phone.
