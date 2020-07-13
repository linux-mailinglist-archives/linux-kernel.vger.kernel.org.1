Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BB3218C92
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 18:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgGHQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 12:10:15 -0400
Received: from verein.lst.de ([213.95.11.211]:36073 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730282AbgGHQKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:10:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3407068B05; Wed,  8 Jul 2020 18:10:11 +0200 (CEST)
Date:   Wed, 8 Jul 2020 18:10:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
Message-ID: <20200708161010.GA30184@lst.de>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de> <20200708153509.GA26743@lst.de> <e81db35628a22a0d1635699d1e87bacde706ad25.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81db35628a22a0d1635699d1e87bacde706ad25.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 06:00:35PM +0200, Nicolas Saenz Julienne wrote:
> On Wed, 2020-07-08 at 17:35 +0200, Christoph Hellwig wrote:
> > On Tue, Jul 07, 2020 at 02:28:04PM +0200, Nicolas Saenz Julienne wrote:
> > > When allocating atomic DMA memory for a device, the dma-pool core
> > > queries __dma_direct_optimal_gfp_mask() to check which atomic pool to
> > > use. It turns out the GFP flag returned is only an optimistic guess.
> > > The pool selected might sometimes live in a zone higher than the
> > > device's view of memory.
> > > 
> > > As there isn't a way to grantee a mapping between a device's DMA
> > > constraints and correct GFP flags this unifies both DMA atomic pools.
> > > The resulting pool is allocated in the lower DMA zone available, if any,
> > > so as for devices to always get accessible memory while having the
> > > flexibility of using dma_pool_kernel for the non constrained ones.
> > > 
> > > Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp
> > > mask")
> > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > 
> > Hmm, this is not what I expected from the previous thread.  I thought
> > we'd just use one dma pool based on runtime available of the zones..
> 
> I may be misunderstanding you, but isn't that going back to how things used to
> be before pulling in David Rientjes' work? The benefit of having a GFP_KERNEL
> pool is that non-address-constrained devices can get their atomic memory there,
> instead of consuming somewhat scarcer low memory.

Yes, I think we are misunderstanding each other.  I don't want to remove
any pool, just make better runtime decisions when to use them.
