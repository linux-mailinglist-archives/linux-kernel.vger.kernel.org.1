Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1FF2F4BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAMMte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:49:34 -0500
Received: from verein.lst.de ([213.95.11.211]:60093 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbhAMMtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:49:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D787F68AFE; Wed, 13 Jan 2021 13:48:47 +0100 (CET)
Date:   Wed, 13 Jan 2021 13:48:47 +0100
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
Subject: Re: [RFC PATCH v3 4/6] swiotlb: Add restricted DMA alloc/free
 support.
Message-ID: <20210113124847.GC1383@lst.de>
References: <20210106034124.30560-1-tientzu@chromium.org> <20210106034124.30560-5-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106034124.30560-5-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_SWIOTLB
> +	if (unlikely(dev->dma_io_tlb_mem))
> +		return swiotlb_alloc(dev, size, dma_handle, attrs);
> +#endif

Another place where the dma_io_tlb_mem is useful to avoid the ifdef.

> -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
> -		size_t mapping_size, size_t alloc_size,
> -		enum dma_data_direction dir, unsigned long attrs)
> +static int swiotlb_tbl_find_free_region(struct device *hwdev,
> +					dma_addr_t tbl_dma_addr,
> +					size_t alloc_size,
> +					unsigned long attrs)

> +static void swiotlb_tbl_release_region(struct device *hwdev, int index,
> +				       size_t size)

This refactoring should be another prep patch.


> +void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		    unsigned long attrs)

I'd rather have the names convey there are for the per-device bounce
buffer in some form.

> +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;

While we're at it I wonder if the io_tlb is something we could change
while we're at it.  Maybe replace io_tlb_mem with struct swiotlb
and rename the field in struct device to dev_swiotlb?

> +	int index;
> +	void *vaddr;
> +	phys_addr_t tlb_addr;
> +
> +	size = PAGE_ALIGN(size);
> +	index = swiotlb_tbl_find_free_region(dev, mem->start, size, attrs);
> +	if (index < 0)
> +		return NULL;
> +
> +	tlb_addr = mem->start + (index << IO_TLB_SHIFT);
> +	*dma_handle = phys_to_dma_unencrypted(dev, tlb_addr);
> +
> +	if (!dev_is_dma_coherent(dev)) {
> +		unsigned long pfn = PFN_DOWN(tlb_addr);
> +
> +		/* remove any dirty cache lines on the kernel alias */
> +		arch_dma_prep_coherent(pfn_to_page(pfn), size);

Can we hook in somewhat lower level in the dma-direct code so that all
the remapping in dma-direct can be reused instead of duplicated?  That
also becomes important if we want to use non-remapping uncached support,
e.g. on mips or x86, or the direct changing of the attributes that Will
planned to look into for arm64.
