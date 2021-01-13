Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535672F4AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbhAMLvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:51:17 -0500
Received: from verein.lst.de ([213.95.11.211]:59750 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbhAMLvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:51:16 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA26B68AFE; Wed, 13 Jan 2021 12:50:31 +0100 (CET)
Date:   Wed, 13 Jan 2021 12:50:31 +0100
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
Subject: Re: [RFC PATCH v3 1/6] swiotlb: Add io_tlb_mem struct
Message-ID: <20210113115031.GA29376@lst.de>
References: <20210106034124.30560-1-tientzu@chromium.org> <20210106034124.30560-2-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106034124.30560-2-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 11:41:19AM +0800, Claire Chang wrote:
> Added a new struct, io_tlb_mem, as the IO TLB memory pool descriptor and
> moved relevant global variables into that struct.
> This will be useful later to allow for restricted DMA pool.

I like where this is going, but a few comments.

Mostly I'd love to be able to entirely hide io_tlb_default_mem
and struct io_tlb_mem inside of swiotlb.c.

> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -55,8 +55,8 @@ void __init svm_swiotlb_init(void)
>  	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, false))
>  		return;
>  
> -	if (io_tlb_start)
> -		memblock_free_early(io_tlb_start,
> +	if (io_tlb_default_mem.start)
> +		memblock_free_early(io_tlb_default_mem.start,
>  				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));

I think this should switch to use the local vstart variable in
prep patch.

>  	panic("SVM: Cannot allocate SWIOTLB buffer");
>  }
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 2b385c1b4a99..4d17dff7ffd2 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -192,8 +192,8 @@ int __ref xen_swiotlb_init(int verbose, bool early)
>  	/*
>  	 * IO TLB memory already allocated. Just use it.
>  	 */
> -	if (io_tlb_start != 0) {
> -		xen_io_tlb_start = phys_to_virt(io_tlb_start);
> +	if (io_tlb_default_mem.start != 0) {
> +		xen_io_tlb_start = phys_to_virt(io_tlb_default_mem.start);
>  		goto end;

xen_io_tlb_start is interesting. It is used only in two functions:

 1) is_xen_swiotlb_buffer, where I think we should be able to just use
    is_swiotlb_buffer instead of open coding it with the extra
    phys_to_virt/virt_to_phys cycle.
 2) xen_swiotlb_init, where except for the assignment it only is used
    locally for the case not touched above and could this be replaced
    with a local variable.

Konrad, does this make sense to you?

>  static inline bool is_swiotlb_buffer(phys_addr_t paddr)
>  {
> -	return paddr >= io_tlb_start && paddr < io_tlb_end;
> +	struct io_tlb_mem *mem = &io_tlb_default_mem;
> +
> +	return paddr >= mem->start && paddr < mem->end;

We'd then have to move this out of line as well.
