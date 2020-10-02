Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18FB2811B6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbgJBLzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgJBLzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:55:46 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12001206B7;
        Fri,  2 Oct 2020 11:55:43 +0000 (UTC)
Date:   Fri, 2 Oct 2020 12:55:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        will@kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-rpi-kernel@lists.infradead.org, robin.murphy@arm.com,
        hch@lst.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
Message-ID: <20201002115541.GC7034@gaia>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de>
 <20201001171500.GN21544@gaia>
 <20201001172320.GQ21544@gaia>
 <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 07:31:19PM +0200, Nicolas Saenz Julienne wrote:
> On Thu, 2020-10-01 at 18:23 +0100, Catalin Marinas wrote:
> > On Thu, Oct 01, 2020 at 06:15:01PM +0100, Catalin Marinas wrote:
> > > On Thu, Oct 01, 2020 at 06:17:37PM +0200, Nicolas Saenz Julienne wrote:
> > > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > > index 4602e467ca8b..cd0d115ef329 100644
> > > > --- a/drivers/of/fdt.c
> > > > +++ b/drivers/of/fdt.c
> > > > @@ -25,6 +25,7 @@
> > > >  #include <linux/serial_core.h>
> > > >  #include <linux/sysfs.h>
> > > >  #include <linux/random.h>
> > > > +#include <linux/dma-direct.h>	/* for zone_dma_bits */
> > > >  
> > > >  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> > > >  #include <asm/page.h>
> > > > @@ -1198,6 +1199,14 @@ void __init early_init_dt_scan_nodes(void)
> > > >  	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> > > >  }
> > > >  
> > > > +void __init early_init_dt_update_zone_dma_bits(void)
> > > > +{
> > > > +	unsigned long dt_root = of_get_flat_dt_root();
> > > > +
> > > > +	if (of_flat_dt_is_compatible(dt_root, "brcm,bcm2711"))
> > > > +		zone_dma_bits = 30;
> > > > +}
> > > 
> > > I think we could keep this entirely in the arm64 setup_machine_fdt() and
> > > not pollute the core code with RPi4-specific code.
> > 
> > Actually, even better, could we not move the check to
> > arm64_memblock_init() when we initialise zone_dma_bits?
> 
> I did it this way as I vaguely remembered Rob saying he wanted to centralise
> all early boot fdt code in one place. But I'll be happy to move it there.

I can see Rob replied and I'm fine if that's his preference. However,
what I don't particularly like is that in the arm64 code, if
zone_dma_bits == 24, we set it to 32 assuming that it wasn't touched by
the early_init_dt_update_zone_dma_bits(). What if at some point we'll
get a platform that actually needs 24 here (I truly hope not, but just
the principle of relying on magic values)?

So rather than guessing, I'd prefer if the arch code can override
ZONE_DMA_BITS_DEFAULT. Then, in arm64, we'll just set it to 32 and no
need to explicitly touch the zone_dma_bits variable.

-- 
Catalin
