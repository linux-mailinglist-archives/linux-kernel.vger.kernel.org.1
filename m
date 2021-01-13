Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64C32F4B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbhAMMpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:45:01 -0500
Received: from verein.lst.de ([213.95.11.211]:60054 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbhAMMpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:45:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5DAEB68AFE; Wed, 13 Jan 2021 13:44:16 +0100 (CET)
Date:   Wed, 13 Jan 2021 13:44:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Claire Chang <tientzu@chromium.org>
Cc:     robh+dt@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, joro@8bytes.org, will@kernel.org,
        frowand.list@gmail.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, grant.likely@arm.com, xypron.glpk@gmx.de,
        treding@nvidia.com, mingo@kernel.org, bauerman@linux.ibm.com,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        saravanak@google.com, rafael.j.wysocki@intel.com,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rdunlap@infradead.org, dan.j.williams@intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        tfiga@chromium.org, drinkcat@chromium.org
Subject: Re: [RFC PATCH v3 3/6] swiotlb: Use restricted DMA pool if
 available
Message-ID: <20210113124416.GB1383@lst.de>
References: <20210106034124.30560-1-tientzu@chromium.org> <20210106034124.30560-4-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106034124.30560-4-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_SWIOTLB
> +	if (unlikely(swiotlb_force == SWIOTLB_FORCE) || dev->dma_io_tlb_mem)
>  		return swiotlb_map(dev, phys, size, dir, attrs);
> +#endif

Please provide a wrapper for the dev->dma_io_tlb_mem check that
always returns false if the per-device swiotlb support is not enabled.

> index 7fb2ac087d23..1f05af09e61a 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -222,7 +222,6 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  		mem->orig_addr[i] = INVALID_PHYS_ADDR;
>  	}
>  	mem->index = 0;
> -	no_iotlb_memory = false;

How does this fit in here?

