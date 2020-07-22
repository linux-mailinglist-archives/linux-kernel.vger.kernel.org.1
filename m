Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F579229A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 16:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbgGVO3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 10:29:48 -0400
Received: from verein.lst.de ([213.95.11.211]:56551 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732576AbgGVO3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:29:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B599868B05; Wed, 22 Jul 2020 16:29:43 +0200 (CEST)
Date:   Wed, 22 Jul 2020 16:29:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        will@kernel.org, ganapatrao.kulkarni@cavium.com,
        catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Message-ID: <20200722142943.GB17658@lst.de>
References: <20200628111251.19108-1-song.bao.hua@hisilicon.com> <20200628111251.19108-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628111251.19108-2-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 11:12:50PM +1200, Barry Song wrote:
>  struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  {
>  	size_t count = size >> PAGE_SHIFT;
>  	struct page *page = NULL;
>  	struct cma *cma = NULL;
> +	int nid = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> +	bool alloc_from_pernuma = false;
> +
> +	if ((count <= 1) && !(dev && dev->cma_area))
> +		return NULL;
>  
>  	if (dev && dev->cma_area)
>  		cma = dev->cma_area;
> -	else if (count > 1)
> +	else if ((nid != NUMA_NO_NODE) && dma_contiguous_pernuma_area[nid]
> +		&& !(gfp & (GFP_DMA | GFP_DMA32))) {
> +		cma = dma_contiguous_pernuma_area[nid];
> +		alloc_from_pernuma = true;
> +	} else {
>  		cma = dma_contiguous_default_area;
> +	}

I find the function rather confusing now.  What about something
like (this relies on the fact that dev should never be NULL in the
DMA API)

struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
{
	size_t cma_align = min_t(size_t, get_order(size), CONFIG_CMA_ALIGNMENT);
 	size_t count = size >> PAGE_SHIFT;

	if (gfpflags_allow_blocking(gfp))
		return NULL;
	gfp &= __GFP_NOWARN;

	if (dev->cma_area)
		return cma_alloc(dev->cma_area, count, cma_align, gfp);
	if (count <= 1)
		return NULL;

	if (IS_ENABLED(CONFIG_PERNODE_CMA) && !(gfp & (GFP_DMA | GFP_DMA32)) {
		int nid = dev_to_node(dev);
 		struct cma *cma = dma_contiguous_pernuma_area[nid];
		struct page *page;

		if (cma) {
			page = cma_alloc(cma, count, cma_align, gfp);
			if (page)
				return page;
		}
	}

	return cma_alloc(dma_contiguous_default_area, count, cma_align, gfp);
}

> +		/*
> +		 * otherwise, page is from either per-numa cma or default cma
> +		 */
> +		int nid = page_to_nid(page);
> +
> +		if (nid != NUMA_NO_NODE) {
> +			if (cma_release(dma_contiguous_pernuma_area[nid], page,
> +						PAGE_ALIGN(size) >> PAGE_SHIFT))
> +				return;
> +		}
> +
> +		if (cma_release(dma_contiguous_default_area, page,

How can page_to_nid ever return NUMA_NO_NODE?
