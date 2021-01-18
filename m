Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031B42F972C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbhARBJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:09:44 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:34331 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730186AbhARBIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:08:04 -0500
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 18 Jan 2021 10:07:18 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: daewoong00.kim@lge.com
Received: from unknown (HELO marvel.156.147.1.1) (10.178.35.47)
        by 156.147.1.125 with ESMTP; 18 Jan 2021 10:07:18 +0900
X-Original-SENDERIP: 10.178.35.47
X-Original-MAILFROM: daewoong00.kim@lge.com
From:   Daewoong Kim <daewoong00.kim@lge.com>
To:     hzpeterchen@gmail.com
Cc:     b-liu@ti.com, allen.lkml@gmail.com, gustavoars@kernel.org,
        a.darwish@linutronix.de, romain.perier@gmail.com,
        dvyukov@google.com, andreyknvl@google.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, neidhard.kim@lge.com,
        raxis.lim@lge.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: xhci: setup packets don't need DMA mapping
Date:   Mon, 18 Jan 2021 10:07:17 +0900
Message-Id: <1610932037-28243-1-git-send-email-daewoong00.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20210115003251.GA3443@b29397-desktop>
References: <20210115003251.GA3443@b29397-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chen, thanks for your comments.

On Fri, 15 Jan 2021 08:32:51 +0800, Peter Chen wrote:
> On 21-01-14 13:00:21, Alan Stern wrote:
> > On Thu, Jan 14, 2021 at 01:04:02PM +0800, Peter Chen wrote:
> > > On 21-01-14 11:59:07, Daewoong Kim wrote:
> > > > DMA mapping of urb->setup_packet is not necessary for xHCI host
> > > > controllers. The xHCI specification says that Setup Stage TRB includes
> > > > whole Setup Data; therefore, urb->setup_dma will not be used in the xhci
> > > > HCD code.
> > > > 
> > > 
> > > How about bypass map/unmap operation for xHCI control transfer directly?
> > > 
> > > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > > index 91ab81c3fc79..0a0ab14b7638 100644
> > > --- a/drivers/usb/host/xhci.c
> > > +++ b/drivers/usb/host/xhci.c
> > > @@ -1374,7 +1374,8 @@ static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> > > 
> > >  	xhci = hcd_to_xhci(hcd);
> > > 
> > > -	if (xhci_urb_suitable_for_idt(urb))
> > > +	if (xhci_urb_suitable_for_idt(urb) ||
> > > +		(usb_endpoint_xfer_control(&urb->ep->desc)))
> > >  		return 0;
> > 
> > Would this affect the map/unmap operations for the DATA packets in a 
> > control transfer, along with the SETUP packet?
> > 
> 
> Oh, you are right, Alan. We do need map/unmap operation for DATA
> packet in control transfer.

Is it possible to bypass map/unmap operations for MUSB devices' control transfer directly?
If possible, the uses_pio_for_control field in struct usb_bus could be removed.

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index ad5a0f405a75..54061764ffda 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1409,8 +1409,6 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 	 */
 
 	if (usb_endpoint_xfer_control(&urb->ep->desc)) {
-		if (hcd->self.uses_pio_for_control)
-			return ret;
 		if (hcd->localmem_pool) {
 			ret = hcd_alloc_coherent(
 					urb->dev->bus, mem_flags,
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 30c5e7de0761..6eaff08cd1e4 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2624,6 +2624,8 @@ static int musb_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 	struct musb	*musb = hcd_to_musb(hcd);
 	int ret;
 
+	if (usb_endpoint_xfer_control(&urb->ep->desc))
+		return 0;
 	/*
 	 * The DMA engine in RTL1.8 and above cannot handle
 	 * DMA addresses that are not aligned to a 4 byte boundary.
@@ -2700,7 +2702,6 @@ int musb_host_alloc(struct musb *musb)
 		return -EINVAL;
 
 	*musb->hcd->hcd_priv = (unsigned long) musb;
-	musb->hcd->self.uses_pio_for_control = 1;
 	musb->hcd->uses_new_polling = 1;
 	musb->hcd->has_tt = 1;
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7d72c4e0713c..f4b7d529f2eb 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -426,10 +426,6 @@ struct usb_bus {
 	struct device *sysdev;		/* as seen from firmware or bus */
 	int busnum;			/* Bus number (in order of reg) */
 	const char *bus_name;		/* stable id (PCI slot_name etc) */
-	u8 uses_pio_for_control;	/*
-					 * Does the host controller use PIO
-					 * for control transfers?
-					 */
 	u8 otg_port;			/* 0, or number of OTG/HNP port */
 	unsigned is_b_host:1;		/* true during some HNP roleswitches */
 	unsigned b_hnp_enable:1;	/* OTG: did A-Host enable HNP? */
--

With Best Regards,
Daewoong Kim
