Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B441AEC89
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 14:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDRMmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 08:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbgDRMmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 08:42:09 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7EFC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 05:42:09 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B57C0342; Sat, 18 Apr 2020 14:42:06 +0200 (CEST)
Date:   Sat, 18 Apr 2020 14:42:05 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200418124205.GD6113@8bytes.org>
References: <20200414122506.438134-1-hch@lst.de>
 <20200414122506.438134-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414122506.438134-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, Apr 14, 2020 at 02:25:05PM +0200, Christoph Hellwig wrote:
> +static inline bool dma_map_direct(struct device *dev,
> +		const struct dma_map_ops *ops)
> +{
> +	if (likely(!ops))
> +		return true;
> +	if (!dev->dma_ops_bypass)
> +		return false;
> +
> +	return min_not_zero(*dev->dma_mask, dev->bus_dma_limit) >=
> +			    dma_direct_get_required_mask(dev);

Why is the dma-mask check done here? The dma-direct code handles memory
outside of the devices dma-mask with swiotlb, no?

I also don't quite get what the difference between setting the
dma_ops_bypass flag non-zero and setting ops to NULL is.


	Joerg


