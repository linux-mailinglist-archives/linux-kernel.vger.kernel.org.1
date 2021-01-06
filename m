Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A842EBAAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAFHut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbhAFHus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:50:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7129D2070C;
        Wed,  6 Jan 2021 07:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609919407;
        bh=Piu5gusr/UGLicaCqANy6GNdwM1M9LXLgq30KLvh2D4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STtQBirTvMJHJfy3BDpBJr1nF4y3j9P09tA52QukFa2+zVDJOvZxlpH0YuQb1dKaI
         tkZ/1YHajtxpOZBb2tYYK9x5sW39V1FMN5v9MY2fd4frFWPosjKHysaj5P3pqOj5H4
         cLt1ndn2T4gOT+l7NViKlEBYi94u2sh/OTHke2vk=
Date:   Wed, 6 Jan 2021 08:50:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     robh+dt@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, joro@8bytes.org, will@kernel.org,
        frowand.list@gmail.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
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
Message-ID: <X/VrqxcaAMi65CF0@kroah.com>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106034124.30560-3-tientzu@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 11:41:20AM +0800, Claire Chang wrote:
> Add the initialization function to create restricted DMA pools from
> matching reserved-memory nodes in the device tree.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  include/linux/device.h  |   4 ++
>  include/linux/swiotlb.h |   7 +-
>  kernel/dma/Kconfig      |   1 +
>  kernel/dma/swiotlb.c    | 144 ++++++++++++++++++++++++++++++++++------
>  4 files changed, 131 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 89bb8b84173e..ca6f71ec8871 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -413,6 +413,7 @@ struct dev_links_info {
>   * @dma_pools:	Dma pools (if dma'ble device).
>   * @dma_mem:	Internal for coherent mem override.
>   * @cma_area:	Contiguous memory area for dma allocations
> + * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.

Why does this have to be added here?  Shouldn't the platform-specific
code handle it instead?

thanks,

greg k-h
