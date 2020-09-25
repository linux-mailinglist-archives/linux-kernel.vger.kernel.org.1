Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DD2277ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 06:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgIYEOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 00:14:31 -0400
Received: from verein.lst.de ([213.95.11.211]:54541 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgIYEO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 00:14:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0871E68AFE; Fri, 25 Sep 2020 06:14:26 +0200 (CEST)
Date:   Fri, 25 Sep 2020 06:14:25 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Christoph Hellwig' <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] dma-mapping: better document dma_addr_t and
 DMA_MAPPING_ERROR
Message-ID: <20200925041425.GA9419@lst.de>
References: <20200922134002.1227279-1-hch@lst.de> <20200922134002.1227279-4-hch@lst.de> <f9c37e5ff1cb4a02bff6d2a8d0ea2dcc@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9c37e5ff1cb4a02bff6d2a8d0ea2dcc@AcuMS.aculab.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 01:56:46PM +0000, David Laight wrote:
> > +/*
> > + * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
> > + * be given to a device to use as a DMA source or target.  A CPU cannot
> > + * reference a dma_addr_t directly because there may be translation between its
> > + * physical address space and the bus address space.
> 
> It can't access it 'directly' because it isn't a virtual address....
> 
> > + *
> > + * DMA_MAPPING_ERROR is the magic error code if a mapping failed.  It should not
> > + * be used directly in drivers, but checked for using dma_mapping_error()
> > + * instead.
> > + */
> 
> I think it might be worth adding:
> 
> A dma_addr_t value may be device dependant and differ from the
> 'physical address' of the memory.

This is what I've committed:

 * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
 * be given to a device to use as a DMA source or target.  It is specific to a
 * given device and there may be a translation between the CPU physical address
 * space and the bus address space.
