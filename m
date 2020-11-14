Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263BB2B2E68
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 17:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgKNQVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 11:21:14 -0500
Received: from verein.lst.de ([213.95.11.211]:50538 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgKNQVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 11:21:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5B36B67373; Sat, 14 Nov 2020 17:21:10 +0100 (CET)
Date:   Sat, 14 Nov 2020 17:21:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, hch@lst.de,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 2/5] dma-direct: add dma_direct_bypass() to
 force direct ops
Message-ID: <20201114162109.GA24411@lst.de>
References: <20201114151717.5369-1-jonathan@marek.ca> <20201114151717.5369-3-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114151717.5369-3-jonathan@marek.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 10:17:10AM -0500, Jonathan Marek wrote:
> Add a function to force direct ops and disable swiotlb for a deivce.

s/deivce/device/

> +#if IS_ENABLED(CONFIG_DMA_OPS_BYPASS) && !IS_ENABLED(CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED)

overly long line.

> +#if IS_ENABLED(CONFIG_DMA_OPS_BYPASS) && !IS_ENABLED(CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED)

Again.

> +int dma_direct_bypass(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret)
> +		return ret;
> +
> +	dev->bus_dma_limit = DMA_BIT_MASK(64);
> +	dev->dma_ops_bypass = true;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dma_direct_bypass);

But more importantly ARCH_HAS_FORCE_DMA_UNENCRYPTED is just a compile
time flag.  With this you disable the functionality for all the usual
x86, s390 and powerpc configs, while only a tiny number of systems
for bounce buffering.  But I think you can just trivialy check
force_dma_unencrypted instead.  We do not need an extra Kconfig symbol
symbol for this trivial helper.

Also the helper is misnamed and misplaced.  The semantics have nothing
to do with dma-direct, the fact that is uses the ops bypass is an
implementation detail.   It really fits into the iommu code, as it
allows the driver to use the IOMMU API for IOVA management, while using
the DMA API for cache management.  So it should be named to reflect
that, and also grow a kerneldoc comment explaining how it will be used.
