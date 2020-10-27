Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD94829A5E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508436AbgJ0Hy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:54:57 -0400
Received: from verein.lst.de ([213.95.11.211]:37655 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508410AbgJ0Hy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:54:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2FBB867373; Tue, 27 Oct 2020 08:54:53 +0100 (CET)
Date:   Tue, 27 Oct 2020 08:54:52 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
Message-ID: <20201027075452.GA22487@lst.de>
References: <74b66725883f065eb7d156f866678abb5be934bd.1603714996.git.robin.murphy@arm.com> <75cad228694b4f1587265a887069b241@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75cad228694b4f1587265a887069b241@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 08:07:43PM +0000, Song Bao Hua (Barry Song) wrote:
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index c99de4a21458..964b74c9b7e3 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -125,7 +125,8 @@ if  DMA_CMA
> > 
> >  config DMA_PERNUMA_CMA
> >  	bool "Enable separate DMA Contiguous Memory Area for each NUMA
> > Node"
> > -	default NUMA && ARM64
> > +	depends on NUMA
> > +	default ARM64
> 
> On the other hand, at this moment, only ARM64 is calling the init code
> to get per_numa cma. Do we need to
> depends on NUMA && ARM64 ?
> so that this is not enabled by non-arm64?

I actually hate having arch symbols in common code.  A new
ARCH_HAS_DMA_PERNUMA_CMA, only selected by arm64 for now would be more
clean I think.
