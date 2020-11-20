Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7472BA5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgKTJUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:20:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbgKTJU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:20:27 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E803922264;
        Fri, 20 Nov 2020 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605864026;
        bh=2u/5mhCZv1xdPFL6xL5rON8rEuNwDZ5NL6N7lPUewns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNqG64/n8KmjuhcLmgLYf48IecH4L16ozQdP/cgWyMIffoCtf5iL0LH+I73HgmXNg
         AqlemRpN+JQttIotgWDRxHQTUti6HwOpzRC+nLmEOqs0zr05ylBp/WNzt+TmLSEls+
         z1Ti3DfpbibbsXvK+UXsqXlDwyD6HKA58gHvntmM=
Date:   Fri, 20 Nov 2020 10:20:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Min Guo <min.guo@mediatek.com>
Cc:     Bin Liu <b-liu@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: musb: remove unused variable 'devctl'
Message-ID: <X7eKetkCN+Z3meyB@kroah.com>
References: <20201117082125.7619-1-min.guo@mediatek.com>
 <X7UKJtWtE0UZgqAQ@kroah.com>
 <1605854930.3995.8.camel@mhfsdcap03>
 <X7doKlP1k824LGGN@kroah.com>
 <1605858126.3995.14.camel@mhfsdcap03>
 <X7eAEaTN/fM3fkkp@kroah.com>
 <1605862935.3995.20.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605862935.3995.20.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 05:02:15PM +0800, Min Guo wrote:
> On Fri, 2020-11-20 at 09:36 +0100, Greg Kroah-Hartman wrote:
> > On Fri, Nov 20, 2020 at 03:42:06PM +0800, Min Guo wrote:
> > > On Fri, 2020-11-20 at 07:54 +0100, Greg Kroah-Hartman wrote:
> > > > On Fri, Nov 20, 2020 at 02:48:50PM +0800, Min Guo wrote:
> > > > > Hi greg k-h:
> > > > > On Wed, 2020-11-18 at 12:48 +0100, Greg Kroah-Hartman wrote:
> > > > > > On Tue, Nov 17, 2020 at 04:21:25PM +0800, min.guo@mediatek.com wrote:
> > > > > > > From: Min Guo <min.guo@mediatek.com>
> > > > > > > 
> > > > > > > Remove unused 'devctl' variable to fix compile warnings:
> > > > > > > 
> > > > > > >     drivers/usb/musb/musbhsdma.c: In function 'dma_controller_irq':
> > > > > > >     drivers/usb/musb/musbhsdma.c:324:8: warning: variable 'devctl' set
> > > > > > >     but not used [-Wunused-but-set-variable]
> > > > > > > 
> > > > > > > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > > > > > > ---
> > > > > > >  drivers/usb/musb/musbhsdma.c | 4 ----
> > > > > > >  1 file changed, 4 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> > > > > > > index 0aacfc8be5a1..7acd1635850d 100644
> > > > > > > --- a/drivers/usb/musb/musbhsdma.c
> > > > > > > +++ b/drivers/usb/musb/musbhsdma.c
> > > > > > > @@ -321,8 +321,6 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
> > > > > > >  				musb_channel->channel.status =
> > > > > > >  					MUSB_DMA_STATUS_BUS_ABORT;
> > > > > > >  			} else {
> > > > > > > -				u8 devctl;
> > > > > > > -
> > > > > > >  				addr = musb_read_hsdma_addr(mbase,
> > > > > > >  						bchannel);
> > > > > > >  				channel->actual_len = addr
> > > > > > > @@ -336,8 +334,6 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
> > > > > > >  						< musb_channel->len) ?
> > > > > > >  					"=> reconfig 0" : "=> complete");
> > > > > > >  
> > > > > > > -				devctl = musb_readb(mbase, MUSB_DEVCTL);
> > > > > > 
> > > > > > Are you sure that the hardware does not require this read to complete
> > > > > > the command?  Lots of hardware is that way, so be very careful about
> > > > > > this.  Did you test it?
> > > > > 
> > > > > I have tested this patch on Mediatek's platform, and not sure if it
> > > > > will affect other vendors' platforms.
> > > > > 
> > > > > Dear Bin:
> > > > > 
> > > > > Does this patch will affect other vendors' platforms?
> > > > 
> > > > The hardware specs will answer this question, what do they say about
> > > > this read?
> > > 
> > > Sorry, I didn't seen the comment on the hardware specs indicate that
> > > devctl register needs to read once to take effect.
> > 
> > Perhaps you might want to add a comment here so that people will not
> > keep making this same mistake when they run auto-checkers on the
> > codebase?
> 
> Sorry for confused you, I searched the hardware specs, but did not find
> the special description of the register devctl indicating that it needs
> to be read out before the hardware can work.

If this is a PCI device, that is implied as that is how all PCI devices
work, right?

What is the problem that is fixed by removing this read?

thanks,

greg k-h
