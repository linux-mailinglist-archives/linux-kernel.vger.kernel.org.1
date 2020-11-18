Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CFF2B7D05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgKRLsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKRLsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:48:08 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93132207D3;
        Wed, 18 Nov 2020 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605700088;
        bh=AVFwWiK5o8kOcZQ0tm/tH6XBw33UzNsFN4Icb/uq+iI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qlNSUV1GI7YrFNh8EvH0WS+CG5srE8T79RrRbC336+2OtWUtbUGFSomChewe3OABA
         JXfk/TM2l/aJ+E5UmxOH0hRfQ1k54IpLKgXQAkGRypJPP3A8+155BeFrfFfvNiD3wW
         vkdKWSYavRv5/EkvJW7QobaE1ZMukQhE1ti6iAj0=
Date:   Wed, 18 Nov 2020 12:48:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     min.guo@mediatek.com
Cc:     Bin Liu <b-liu@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: musb: remove unused variable 'devctl'
Message-ID: <X7UKJtWtE0UZgqAQ@kroah.com>
References: <20201117082125.7619-1-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117082125.7619-1-min.guo@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:21:25PM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> Remove unused 'devctl' variable to fix compile warnings:
> 
>     drivers/usb/musb/musbhsdma.c: In function 'dma_controller_irq':
>     drivers/usb/musb/musbhsdma.c:324:8: warning: variable 'devctl' set
>     but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
>  drivers/usb/musb/musbhsdma.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> index 0aacfc8be5a1..7acd1635850d 100644
> --- a/drivers/usb/musb/musbhsdma.c
> +++ b/drivers/usb/musb/musbhsdma.c
> @@ -321,8 +321,6 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
>  				musb_channel->channel.status =
>  					MUSB_DMA_STATUS_BUS_ABORT;
>  			} else {
> -				u8 devctl;
> -
>  				addr = musb_read_hsdma_addr(mbase,
>  						bchannel);
>  				channel->actual_len = addr
> @@ -336,8 +334,6 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
>  						< musb_channel->len) ?
>  					"=> reconfig 0" : "=> complete");
>  
> -				devctl = musb_readb(mbase, MUSB_DEVCTL);

Are you sure that the hardware does not require this read to complete
the command?  Lots of hardware is that way, so be very careful about
this.  Did you test it?

thanks,

greg k-h
