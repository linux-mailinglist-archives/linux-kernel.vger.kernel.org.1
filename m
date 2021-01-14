Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2AB2F68A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbhANSBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:01:03 -0500
Received: from netrider.rowland.org ([192.131.102.5]:59093 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727708AbhANSBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:01:03 -0500
Received: (qmail 13388 invoked by uid 1000); 14 Jan 2021 13:00:21 -0500
Date:   Thu, 14 Jan 2021 13:00:21 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Peter Chen <hzpeterchen@gmail.com>
Cc:     Daewoong Kim <daewoong00.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        allen.lkml@gmail.com, gustavoars@kernel.org,
        a.darwish@linutronix.de, romain.perier@gmail.com,
        dvyukov@google.com, andreyknvl@google.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/1] usb: xhci: setup packets don't need DMA mapping
Message-ID: <20210114180021.GA1935@rowland.harvard.edu>
References: <1610593147-12511-1-git-send-email-daewoong00.kim@lge.com>
 <20210114050402.GA18650@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114050402.GA18650@b29397-desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 01:04:02PM +0800, Peter Chen wrote:
> On 21-01-14 11:59:07, Daewoong Kim wrote:
> > DMA mapping of urb->setup_packet is not necessary for xHCI host
> > controllers. The xHCI specification says that Setup Stage TRB includes
> > whole Setup Data; therefore, urb->setup_dma will not be used in the xhci
> > HCD code.
> > 
> 
> How about bypass map/unmap operation for xHCI control transfer directly?
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 91ab81c3fc79..0a0ab14b7638 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1374,7 +1374,8 @@ static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>  
>  	xhci = hcd_to_xhci(hcd);
>  
> -	if (xhci_urb_suitable_for_idt(urb))
> +	if (xhci_urb_suitable_for_idt(urb) ||
> +		(usb_endpoint_xfer_control(&urb->ep->desc)))
>  		return 0;

Would this affect the map/unmap operations for the DATA packets in a 
control transfer, along with the SETUP packet?

Alan Stern
