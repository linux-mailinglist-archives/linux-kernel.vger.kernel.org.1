Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475282BB0A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgKTQcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgKTQcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:32:04 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA3E12225B;
        Fri, 20 Nov 2020 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605889922;
        bh=4e9p67MzQBx/2VQpNribhatdRMaigeDtqxXm/8AKqR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xa49XbAWsuSktkGsEF/O+5TkED2jrydKOnnO8NZwrRFQYTV+8rlCRmD6EfqM/gQGc
         esaQEGLAO/jm4Yl4Q3NxsRRis2CyLCP5RDZb3TjKYKqVwkuoimDpsdmWvCl+0x0mZt
         qWJ8xIclX8eNO8DYj7F3KoUtuEHXj3JltUtzPDbQ=
Date:   Fri, 20 Nov 2020 17:32:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Min Guo <min.guo@mediatek.com>, Bin Liu <b-liu@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: musb: remove unused variable 'devctl'
Message-ID: <X7fvrK4F2378+9Rl@kroah.com>
References: <20201117082125.7619-1-min.guo@mediatek.com>
 <X7UKJtWtE0UZgqAQ@kroah.com>
 <1605854930.3995.8.camel@mhfsdcap03>
 <X7doKlP1k824LGGN@kroah.com>
 <1605858126.3995.14.camel@mhfsdcap03>
 <X7eAEaTN/fM3fkkp@kroah.com>
 <20201120161519.GA619708@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120161519.GA619708@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 11:15:19AM -0500, Alan Stern wrote:
> On Fri, Nov 20, 2020 at 09:36:33AM +0100, Greg Kroah-Hartman wrote:
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
> A better change would be
> 
> -			devctl = musb_readb(mbase, MUSB_DEVCTL);
> +			(void) musb_readb(mbase, MUSB_DEVCTL);
> 
> and eliminate the unused variable.  Then there wouldn't be any compiler 
> warning.

No need for the (void), the compiler shouldn't warn about that, right?
