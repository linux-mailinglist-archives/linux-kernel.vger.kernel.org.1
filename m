Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F629D5A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgJ1WHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:07:32 -0400
Received: from verein.lst.de ([213.95.11.211]:45195 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730063AbgJ1WH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:07:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D0A568BEB; Wed, 28 Oct 2020 18:22:01 +0100 (CET)
Date:   Wed, 28 Oct 2020 18:22:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v3 1/2] dma: Allow mixing bypass and mapped DMA
 operation
Message-ID: <20201028172201.GB10015@lst.de>
References: <20201028070030.60643-1-aik@ozlabs.ru> <20201028070030.60643-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028070030.60643-2-aik@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 06:00:29PM +1100, Alexey Kardashevskiy wrote:
> At the moment we allow bypassing DMA ops only when we can do this for
> the entire RAM. However there are configs with mixed type memory
> where we could still allow bypassing IOMMU in most cases;
> POWERPC with persistent memory is one example.
> 
> This adds an arch hook to determine where bypass can still work and
> we invoke direct DMA API. The following patch checks the bus limit
> on POWERPC to allow or disallow direct mapping.
> 
> This adds a CONFIG_ARCH_HAS_DMA_SET_MASK config option to make arch_xxxx
> hooks no-op by default.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  kernel/dma/mapping.c | 24 ++++++++++++++++++++----
>  kernel/dma/Kconfig   |  4 ++++
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 51bb8fa8eb89..a0bc9eb876ed 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -137,6 +137,18 @@ static inline bool dma_map_direct(struct device *dev,
>  	return dma_go_direct(dev, *dev->dma_mask, ops);
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_DMA_MAP_DIRECT
> +bool arch_dma_map_page_direct(struct device *dev, phys_addr_t addr);
> +bool arch_dma_unmap_page_direct(struct device *dev, dma_addr_t dma_handle);
> +bool arch_dma_map_sg_direct(struct device *dev, struct scatterlist *sg, int nents);
> +bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg, int nents);
> +#else
> +#define arch_dma_map_page_direct(d, a) (0)
> +#define arch_dma_unmap_page_direct(d, a) (0)
> +#define arch_dma_map_sg_direct(d, s, n) (0)
> +#define arch_dma_unmap_sg_direct(d, s, n) (0)
> +#endif

A bunch of overly long lines here.  Except for that this looks ok to me.
If you want me to queue up the series I can just fix it up.
