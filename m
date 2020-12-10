Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1F82D5ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbgLJPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:00:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729816AbgLJPA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:00:29 -0500
Date:   Thu, 10 Dec 2020 16:01:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607612389;
        bh=PIj9FhhUvvSZu0xzJxHT6c/gR8kNiKhw5BAjOPiDy8c=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+urhOw5zVITPob6166OQJDTbM4feF7LQoaKdyvkUWUWZQNxyqYQoal6EfsM1Y3Vk
         g9c7dlsKnjViwFRVSOcz/v2eMBjKQK+CeRDrZRBOPrM69254Ttwc3xnnQBpMJ6qfrX
         eElBMZ4Lbu2D6X5hPC77z/EHK3wboN659P5hKjU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     min.guo@mediatek.com, Bin Liu <b-liu@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] usb: musb: remove unused variable 'devctl'
Message-ID: <X9I4L3E9EJlcPMEu@kroah.com>
References: <20201124084955.30270-1-min.guo@mediatek.com>
 <c2f3f643-8514-5c4a-dd52-7abc8a6dc501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2f3f643-8514-5c4a-dd52-7abc8a6dc501@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:13:42PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 24.11.2020 11:49, min.guo@mediatek.com wrote:
> 
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > Remove unused 'devctl' variable to fix compile warnings:
> > 
> >      drivers/usb/musb/musbhsdma.c: In function 'dma_controller_irq':
> >      drivers/usb/musb/musbhsdma.c:324:8: warning: variable 'devctl' set
> >      but not used [-Wunused-but-set-variable]
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> > changes in v3
> > suggested by Greg Kroah-Hartman:
> > Add a comment.
> > 
> > changes in v2
> > suggested by Alan Stern:
> > Add void before musb_read to indicate that the register MUSB_DEVCTL
> > was intended to be read and discarded.
> > ---
> >   drivers/usb/musb/musbhsdma.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> > index 0aacfc8be5a1..2a345b4ad015 100644
> > --- a/drivers/usb/musb/musbhsdma.c
> > +++ b/drivers/usb/musb/musbhsdma.c
> [...]
> > @@ -336,7 +334,11 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
> >   						< musb_channel->len) ?
> >   					"=> reconfig 0" : "=> complete");
> > -				devctl = musb_readb(mbase, MUSB_DEVCTL);
> > +				/*
> > +				 * Some hardware may need to read the
> > +				 * MUSB_DEVCTL register once to take effect.
> > +				 */
> > +				(void)musb_readb(mbase, MUSB_DEVCTL);
> 
>    Hm, forcibly reading DevCtl in the DMA driver... sounds quite
> nonsensically. Lemme take a look...

What happened to your look?

thanks,

greg k-h
