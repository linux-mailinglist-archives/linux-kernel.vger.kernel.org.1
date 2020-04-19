Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879501AF891
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 10:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgDSIBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 04:01:01 -0400
Received: from verein.lst.de ([213.95.11.211]:35682 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDSIBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 04:01:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7C63E68BEB; Sun, 19 Apr 2020 10:00:58 +0200 (CEST)
Date:   Sun, 19 Apr 2020 10:00:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200419080058.GB12222@lst.de>
References: <20200414122506.438134-1-hch@lst.de> <20200414122506.438134-4-hch@lst.de> <20200418124205.GD6113@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418124205.GD6113@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 02:42:05PM +0200, Joerg Roedel wrote:
> Hi Christoph,
> 
> On Tue, Apr 14, 2020 at 02:25:05PM +0200, Christoph Hellwig wrote:
> > +static inline bool dma_map_direct(struct device *dev,
> > +		const struct dma_map_ops *ops)
> > +{
> > +	if (likely(!ops))
> > +		return true;
> > +	if (!dev->dma_ops_bypass)
> > +		return false;
> > +
> > +	return min_not_zero(*dev->dma_mask, dev->bus_dma_limit) >=
> > +			    dma_direct_get_required_mask(dev);
> 
> Why is the dma-mask check done here? The dma-direct code handles memory
> outside of the devices dma-mask with swiotlb, no?
> 
> I also don't quite get what the difference between setting the
> dma_ops_bypass flag non-zero and setting ops to NULL is.

The difference is that NULL ops mean imply the direct mapping is always
used, dma_ops_bypass means a direct mapping is used if no bounce buffering
using swiotlb is needed, which should also answer your first question.
The idea is to consolidate code in the core to use an opportunistic
direct mapping instead of the dynamic iommu mapping.  I though the cover
letter and commit log explained this well enough, but maybe I need to
do a better job.
