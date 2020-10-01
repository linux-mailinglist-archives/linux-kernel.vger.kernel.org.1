Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6418128050F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbgJARX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:23:25 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78DA72085B;
        Thu,  1 Oct 2020 17:23:23 +0000 (UTC)
Date:   Thu, 1 Oct 2020 18:23:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     devicetree@vger.kernel.org, will@kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        linux-rpi-kernel@lists.infradead.org, robin.murphy@arm.com,
        hch@lst.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
Message-ID: <20201001172320.GQ21544@gaia>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de>
 <20201001171500.GN21544@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001171500.GN21544@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 06:15:01PM +0100, Catalin Marinas wrote:
> Hi Nicolas,
> 
> Thanks for putting this together.
> 
> On Thu, Oct 01, 2020 at 06:17:37PM +0200, Nicolas Saenz Julienne wrote:
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 4602e467ca8b..cd0d115ef329 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/serial_core.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/random.h>
> > +#include <linux/dma-direct.h>	/* for zone_dma_bits */
> >  
> >  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> >  #include <asm/page.h>
> > @@ -1198,6 +1199,14 @@ void __init early_init_dt_scan_nodes(void)
> >  	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> >  }
> >  
> > +void __init early_init_dt_update_zone_dma_bits(void)
> > +{
> > +	unsigned long dt_root = of_get_flat_dt_root();
> > +
> > +	if (of_flat_dt_is_compatible(dt_root, "brcm,bcm2711"))
> > +		zone_dma_bits = 30;
> > +}
> 
> I think we could keep this entirely in the arm64 setup_machine_fdt() and
> not pollute the core code with RPi4-specific code.

Actually, even better, could we not move the check to
arm64_memblock_init() when we initialise zone_dma_bits?

-- 
Catalin
