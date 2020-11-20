Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9102BAFD1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgKTQPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:15:21 -0500
Received: from netrider.rowland.org ([192.131.102.5]:40399 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728623AbgKTQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:15:20 -0500
Received: (qmail 619842 invoked by uid 1000); 20 Nov 2020 11:15:19 -0500
Date:   Fri, 20 Nov 2020 11:15:19 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Min Guo <min.guo@mediatek.com>, Bin Liu <b-liu@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: musb: remove unused variable 'devctl'
Message-ID: <20201120161519.GA619708@rowland.harvard.edu>
References: <20201117082125.7619-1-min.guo@mediatek.com>
 <X7UKJtWtE0UZgqAQ@kroah.com>
 <1605854930.3995.8.camel@mhfsdcap03>
 <X7doKlP1k824LGGN@kroah.com>
 <1605858126.3995.14.camel@mhfsdcap03>
 <X7eAEaTN/fM3fkkp@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7eAEaTN/fM3fkkp@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 09:36:33AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 20, 2020 at 03:42:06PM +0800, Min Guo wrote:
> > On Fri, 2020-11-20 at 07:54 +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Nov 20, 2020 at 02:48:50PM +0800, Min Guo wrote:
> > > > Hi greg k-h:
> > > > On Wed, 2020-11-18 at 12:48 +0100, Greg Kroah-Hartman wrote:
> > > > > On Tue, Nov 17, 2020 at 04:21:25PM +0800, min.guo@mediatek.com wrote:
> > > > > > From: Min Guo <min.guo@mediatek.com>
> > > > > > 
> > > > > > Remove unused 'devctl' variable to fix compile warnings:
> > > > > > 
> > > > > >     drivers/usb/musb/musbhsdma.c: In function 'dma_controller_irq':
> > > > > >     drivers/usb/musb/musbhsdma.c:324:8: warning: variable 'devctl' set
> > > > > >     but not used [-Wunused-but-set-variable]
> > > > > > 
> > > > > > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > > > > > ---
> > > > > >  drivers/usb/musb/musbhsdma.c | 4 ----
> > > > > >  1 file changed, 4 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> > > > > > index 0aacfc8be5a1..7acd1635850d 100644
> > > > > > --- a/drivers/usb/musb/musbhsdma.c
> > > > > > +++ b/drivers/usb/musb/musbhsdma.c
> > > > > > @@ -321,8 +321,6 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
> > > > > >  				musb_channel->channel.status =
> > > > > >  					MUSB_DMA_STATUS_BUS_ABORT;
> > > > > >  			} else {
> > > > > > -				u8 devctl;
> > > > > > -
> > > > > >  				addr = musb_read_hsdma_addr(mbase,
> > > > > >  						bchannel);
> > > > > >  				channel->actual_len = addr
> > > > > > @@ -336,8 +334,6 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
> > > > > >  						< musb_channel->len) ?
> > > > > >  					"=> reconfig 0" : "=> complete");
> > > > > >  
> > > > > > -				devctl = musb_readb(mbase, MUSB_DEVCTL);
> > > > > 
> > > > > Are you sure that the hardware does not require this read to complete
> > > > > the command?  Lots of hardware is that way, so be very careful about
> > > > > this.  Did you test it?
> > > > 
> > > > I have tested this patch on Mediatek's platform, and not sure if it
> > > > will affect other vendors' platforms.
> > > > 
> > > > Dear Bin:
> > > > 
> > > > Does this patch will affect other vendors' platforms?
> > > 
> > > The hardware specs will answer this question, what do they say about
> > > this read?
> > 
> > Sorry, I didn't seen the comment on the hardware specs indicate that
> > devctl register needs to read once to take effect.
> 
> Perhaps you might want to add a comment here so that people will not
> keep making this same mistake when they run auto-checkers on the
> codebase?

A better change would be

-			devctl = musb_readb(mbase, MUSB_DEVCTL);
+			(void) musb_readb(mbase, MUSB_DEVCTL);

and eliminate the unused variable.  Then there wouldn't be any compiler 
warning.

Alan Stern
