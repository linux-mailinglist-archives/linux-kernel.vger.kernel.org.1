Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2AF2F4B44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAMM2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:28:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbhAMM2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:28:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45BAB2313E;
        Wed, 13 Jan 2021 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610540878;
        bh=DMT/14eqvz5zf53FuIMip/3tOpUYx9AeGju+aNpk6Tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIeWKwdCzel81a5/+igwlQa7a96S4uuDSVMhO/TwoBeDkIRVbX+C6VT/zl3DHzGuy
         TN7OjM0+Zieesb8xP+RgbKU5rKX0cUd7nzCdBCw4R29wCGdqUIBnkZaVV1OJ6+Cnca
         DxODljnCCEJbvE8Rkq5e8BMdF1IFL/e9Km/FCSDg=
Date:   Wed, 13 Jan 2021 13:29:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Claire Chang <tientzu@chromium.org>, robh+dt@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        joro@8bytes.org, will@kernel.org, frowand.list@gmail.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, grant.likely@arm.com, xypron.glpk@gmx.de,
        treding@nvidia.com, mingo@kernel.org, bauerman@linux.ibm.com,
        peterz@infradead.org, saravanak@google.com,
        rafael.j.wysocki@intel.com, heikki.krogerus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, rdunlap@infradead.org,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, tfiga@chromium.org,
        drinkcat@chromium.org
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
Message-ID: <X/7nkb/YDpKlakRO@kroah.com>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
 <X/VrqxcaAMi65CF0@kroah.com>
 <20210113115126.GB29376@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113115126.GB29376@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 12:51:26PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 06, 2021 at 08:50:03AM +0100, Greg KH wrote:
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -413,6 +413,7 @@ struct dev_links_info {
> > >   * @dma_pools:	Dma pools (if dma'ble device).
> > >   * @dma_mem:	Internal for coherent mem override.
> > >   * @cma_area:	Contiguous memory area for dma allocations
> > > + * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.
> > 
> > Why does this have to be added here?  Shouldn't the platform-specific
> > code handle it instead?
> 
> The whole code added here is pretty generic.  What we need to eventually
> do, though is to add a separate dma_device instead of adding more and more
> bloat to struct device.

I have no objections for that happening!
