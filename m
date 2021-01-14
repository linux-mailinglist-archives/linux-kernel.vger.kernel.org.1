Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E672F5A27
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 06:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbhANFE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 00:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbhANFEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 00:04:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE3CC061786;
        Wed, 13 Jan 2021 21:04:15 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id my11so3368618pjb.1;
        Wed, 13 Jan 2021 21:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U6mWvLFGrJbf1ZAi2Z/+qx3it4kX5Grq7lBXDPCBTAQ=;
        b=hyflFSU0yOLK6mWfIREyPuITZ+sfE+VdSTjY8CRaUma8mHq3bQXJVhmmGqK5eEspMy
         lgh07yhWGiOfCoEVdAUbvmbdpt2oXgrEC8eIJUYQLE8VECc979Mglfw0OFIqQwAx6QK1
         XxeRB302Vxo11YCCsDGVCUFQL8y53smR0gucjkNBJDAZFqdGyOO9kGEFfTkg9y40+VB+
         gcrJW8qbABkkX8d7SNZRUYlAdKnE57Z/icbfZzPj9RNVB5QpUf9ZLpZHRXgugiueu7fx
         Z7WXQx++o7K9xHDpotfufejXAxiU8eqcz308AJeezxPSXTphighRHkVDS3gpeOmXHDlX
         hgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U6mWvLFGrJbf1ZAi2Z/+qx3it4kX5Grq7lBXDPCBTAQ=;
        b=ruW0Q4aViRdvhiJG2o38WKiCpO+adn8W6k+wc2chxwSoBJjRLh3pamB3+0eYF2z1wb
         ptFUK0HaXE7OUOkKLEMA2M/Dqq6JHZ8/gkJB8I1+w/UPVBmzL2e2oemoPce/FEJK7sfQ
         zzGNm9uHj72FIxkrQPT7dkzpAbhn8TbJO78hFHAcX81XYb4lYSZVYSBgU71XW1vDETCH
         CCumAR23aEDOdCpAs12nztGlfRmJQUwk/BZ568WgS7Ms4BNoC+qbDwGvxQkjQq7nau9A
         dYODx+z7YPM/wJEgXGpe9UigrDhg0hE9Cb/8WHJ1MU2m49oavldBGtk2rv4xmsm/8ACS
         ytgQ==
X-Gm-Message-State: AOAM532uQFosRCdW2Gg5STfyworRd54nRtWzJLnJjISzVLu83V8U9Ovy
        l/atHllLJMTaCoZ1eBHdcWo=
X-Google-Smtp-Source: ABdhPJzWuRO/cEQgD9jc3DfhT5vwwcuYLHjNjq27ZyYgcftQcwMAFHBI6HvR2QzhMSsO5AsHXj6GDg==
X-Received: by 2002:a17:902:6acb:b029:dc:2e9d:7ca with SMTP id i11-20020a1709026acbb02900dc2e9d07camr5881619plt.56.1610600655322;
        Wed, 13 Jan 2021 21:04:15 -0800 (PST)
Received: from b29397-desktop ([194.5.48.251])
        by smtp.gmail.com with ESMTPSA id n1sm3974215pfu.28.2021.01.13.21.04.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jan 2021 21:04:14 -0800 (PST)
Date:   Thu, 14 Jan 2021 13:04:02 +0800
From:   Peter Chen <hzpeterchen@gmail.com>
To:     Daewoong Kim <daewoong00.kim@lge.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        allen.lkml@gmail.com, gustavoars@kernel.org,
        a.darwish@linutronix.de, romain.perier@gmail.com,
        dvyukov@google.com, andreyknvl@google.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/1] usb: xhci: setup packets don't need DMA mapping
Message-ID: <20210114050402.GA18650@b29397-desktop>
References: <1610593147-12511-1-git-send-email-daewoong00.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610593147-12511-1-git-send-email-daewoong00.kim@lge.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-14 11:59:07, Daewoong Kim wrote:
> DMA mapping of urb->setup_packet is not necessary for xHCI host
> controllers. The xHCI specification says that Setup Stage TRB includes
> whole Setup Data; therefore, urb->setup_dma will not be used in the xhci
> HCD code.
> 

How about bypass map/unmap operation for xHCI control transfer directly?

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 91ab81c3fc79..0a0ab14b7638 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1374,7 +1374,8 @@ static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 
 	xhci = hcd_to_xhci(hcd);
 
-	if (xhci_urb_suitable_for_idt(urb))
+	if (xhci_urb_suitable_for_idt(urb) ||
+		(usb_endpoint_xfer_control(&urb->ep->desc)))
 		return 0;
 
 	if (xhci->quirks & XHCI_SG_TRB_CACHE_SIZE_QUIRK) {
@@ -1389,6 +1390,9 @@ static void xhci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
 	struct xhci_hcd *xhci;
 	bool unmap_temp_buf = false;
 
+	if (usb_endpoint_xfer_control(&urb->ep->desc))
+		return;
+
 	xhci = hcd_to_xhci(hcd);
 
 	if (urb->num_sgs && (urb->transfer_flags & URB_DMA_MAP_SINGLE))
> Signed-off-by: Daewoong Kim <daewoong00.kim@lge.com>
> ---
>  drivers/usb/core/hcd.c  | 4 +++-
>  drivers/usb/host/xhci.c | 1 +
>  include/linux/usb.h     | 4 ++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index ad5a0f405a75..b1f9eac93f0d 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1411,7 +1411,9 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>  	if (usb_endpoint_xfer_control(&urb->ep->desc)) {
>  		if (hcd->self.uses_pio_for_control)
>  			return ret;
> -		if (hcd->localmem_pool) {
> +		if (hcd->self.uses_pio_for_setup_pkt) {
> +			;	/* do nothing */
> +		} else if (hcd->localmem_pool) {
>  			ret = hcd_alloc_coherent(
>  					urb->dev->bus, mem_flags,
>  					&urb->setup_dma,
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index e86940571b4c..c263aee82dc0 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -643,6 +643,7 @@ int xhci_run(struct usb_hcd *hcd)
>  	 */
>  
>  	hcd->uses_new_polling = 1;
> +	hcd->self.uses_pio_for_setup_pkt = 1;
>  	if (!usb_hcd_is_primary_hcd(hcd))
>  		return xhci_run_finished(xhci);
>  
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 7d72c4e0713c..76600e8de414 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -430,6 +430,10 @@ struct usb_bus {
>  					 * Does the host controller use PIO
>  					 * for control transfers?
>  					 */
> +	u8 uses_pio_for_setup_pkt;	/*
> +					 * Does the host controller use PIO
> +					 * for setup packets?
> +					 */
>  	u8 otg_port;			/* 0, or number of OTG/HNP port */
>  	unsigned is_b_host:1;		/* true during some HNP roleswitches */
>  	unsigned b_hnp_enable:1;	/* OTG: did A-Host enable HNP? */
> -- 
> 2.17.1
> 

-- 

Thanks,
Peter Chen

