Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0234E2BAD89
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgKTPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgKTPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:08:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37513C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:08:12 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1kg819-0001Zt-2O; Fri, 20 Nov 2020 16:08:07 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1kg816-0007Zf-3D; Fri, 20 Nov 2020 16:08:04 +0100
Date:   Fri, 20 Nov 2020 16:08:04 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Thinh.Nguyen@synopsys.com
Subject: Re: [PATCH] usb: dwc3: gadget: Restart DWC3 gadget when enabling
 pullup
Message-ID: <20201120150804.GJ23024@pengutronix.de>
References: <20201120001321.773-1-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120001321.773-1-wcheng@codeaurora.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:05:45 up 274 days, 22:36, 90 users,  load average: 0.34, 0.28,
 0.21
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 16:13:21 -0800, Wesley Cheng wrote:
> usb_gadget_deactivate/usb_gadget_activate does not execute the UDC start
> operation, which may leave EP0 disabled and event IRQs disabled when
> re-activating the function. Move the enabling/disabling of USB EP0 and
> device event IRQs to be performed in the pullup routine.
> 
> Fixes: ae7e86108b12 ("usb: dwc3: Stop active transfers before halting the
> controller")
> 
> Reported-by: Michael Tretter <m.tretter@pengutronix.de>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>

Tested-by: Michael Tretter <m.tretter@pengutronix.de>

> ---
>  drivers/usb/dwc3/gadget.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 5d879b7606d5..922c8b76e534 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1988,6 +1988,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
>  
>  static void dwc3_gadget_disable_irq(struct dwc3 *dwc);
>  static void __dwc3_gadget_stop(struct dwc3 *dwc);
> +static int __dwc3_gadget_start(struct dwc3 *dwc);
>  
>  static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  {
> @@ -2050,6 +2051,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
>  						dwc->ev_buf->length;
>  		}
> +	} else {
> +		__dwc3_gadget_start(dwc);
>  	}
>  
>  	ret = dwc3_gadget_run_stop(dwc, is_on, false);
> @@ -2224,10 +2227,6 @@ static int dwc3_gadget_start(struct usb_gadget *g,
>  	}
>  
>  	dwc->gadget_driver	= driver;
> -
> -	if (pm_runtime_active(dwc->dev))
> -		__dwc3_gadget_start(dwc);
> -
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>  
>  	return 0;
> @@ -2253,13 +2252,6 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
>  	unsigned long		flags;
>  
>  	spin_lock_irqsave(&dwc->lock, flags);
> -
> -	if (pm_runtime_suspended(dwc->dev))
> -		goto out;
> -
> -	__dwc3_gadget_stop(dwc);
> -
> -out:
>  	dwc->gadget_driver	= NULL;
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> 
