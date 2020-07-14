Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8427821E98C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 09:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgGNHIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 03:08:01 -0400
Received: from verein.lst.de ([213.95.11.211]:52993 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgGNHIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:08:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DFC6868CFC; Tue, 14 Jul 2020 09:07:57 +0200 (CEST)
Date:   Tue, 14 Jul 2020 09:07:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200714070757.GA776@lst.de>
References: <20200708152449.316476-1-hch@lst.de> <20200708152449.316476-5-hch@lst.de> <9bff7460-e6fa-f765-dcb4-cc96eb86d92c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bff7460-e6fa-f765-dcb4-cc96eb86d92c@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 02:59:39PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 09/07/2020 01:24, Christoph Hellwig wrote:
> > Several IOMMU drivers have a bypass mode where they can use a direct
> > mapping if the devices DMA mask is large enough.  Add generic support
> > to the core dma-mapping code to do that to switch those drivers to
> > a common solution.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  include/linux/device.h |  8 +++++
> >  kernel/dma/Kconfig     |  8 +++++
> >  kernel/dma/mapping.c   | 74 +++++++++++++++++++++++++++++-------------
> >  3 files changed, 68 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 4c4af98321ebd6..1f71acf37f78d7 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -523,6 +523,11 @@ struct dev_links_info {
> >   *		  sync_state() callback.
> >   * @dma_coherent: this particular device is dma coherent, even if the
> >   *		architecture supports non-coherent devices.
> > + * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
> > + *		streaming DMA operations (->map_* / ->unmap_* / ->sync_*),
> > + *		and optionall (if the coherent mask is large enough) also
> 
> 
> s/optionall/optional/g
> 
> Otherwise the series looks good and works well on powernv and pseries.
> Thanks,

Can you give a formal ACK?
