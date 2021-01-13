Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD82F4AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbhAMLwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:52:10 -0500
Received: from verein.lst.de ([213.95.11.211]:59778 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbhAMLwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:52:09 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EFCD968AFE; Wed, 13 Jan 2021 12:51:26 +0100 (CET)
Date:   Wed, 13 Jan 2021 12:51:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Claire Chang <tientzu@chromium.org>, robh+dt@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        joro@8bytes.org, will@kernel.org, frowand.list@gmail.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        grant.likely@arm.com, xypron.glpk@gmx.de, treding@nvidia.com,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
        saravanak@google.com, rafael.j.wysocki@intel.com,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rdunlap@infradead.org, dan.j.williams@intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        tfiga@chromium.org, drinkcat@chromium.org
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
Message-ID: <20210113115126.GB29376@lst.de>
References: <20210106034124.30560-1-tientzu@chromium.org> <20210106034124.30560-3-tientzu@chromium.org> <X/VrqxcaAMi65CF0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/VrqxcaAMi65CF0@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 08:50:03AM +0100, Greg KH wrote:
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -413,6 +413,7 @@ struct dev_links_info {
> >   * @dma_pools:	Dma pools (if dma'ble device).
> >   * @dma_mem:	Internal for coherent mem override.
> >   * @cma_area:	Contiguous memory area for dma allocations
> > + * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.
> 
> Why does this have to be added here?  Shouldn't the platform-specific
> code handle it instead?

The whole code added here is pretty generic.  What we need to eventually
do, though is to add a separate dma_device instead of adding more and more
bloat to struct device.
