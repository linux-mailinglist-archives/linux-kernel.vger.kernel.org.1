Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C8C29E023
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404276AbgJ2BIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:08:52 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43361 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2404369AbgJ2BHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:07:49 -0400
Received: (qmail 1303612 invoked by uid 1000); 28 Oct 2020 21:07:48 -0400
Date:   Wed, 28 Oct 2020 21:07:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, jackp@codeaurora.org
Subject: Re: [PATCH 1/2] usb: dwc3: gadget: Allow runtime suspend if UDC
 unbinded
Message-ID: <20201029010748.GA1303156@rowland.harvard.edu>
References: <20201028234311.6464-1-wcheng@codeaurora.org>
 <20201028234311.6464-2-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028234311.6464-2-wcheng@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 04:43:10PM -0700, Wesley Cheng wrote:
> The DWC3 runtime suspend routine checks for the USB connected parameter to
> determine if the controller can enter into a low power state.  The
> connected state is only set to false after receiving a disconnect event.
> However, in the case of a device initiated disconnect (i.e. UDC unbind),
> the controller is halted and a disconnect event is never generated.  Set
> the connected flag to false if issuing a device initiated disconnect to
> allow the controller to be suspended.
> 
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  drivers/usb/dwc3/gadget.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 5d879b7606d5..6364429b2122 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1995,6 +1995,11 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  	unsigned long		flags;
>  	int			ret;
>  
> +	if (pm_runtime_suspended(dwc->dev)) {
> +		pm_request_resume(dwc->dev);
> +		return 0;
> +	}

Isn't this racy?  What happens if the controller was active but a 
runtime suspend occurs right here?

Alan Stern

> +
>  	is_on = !!is_on;
>  
>  	/*
> @@ -2050,6 +2055,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
>  						dwc->ev_buf->length;
>  		}
> +		dwc->connected = false;
>  	}
>  
>  	ret = dwc3_gadget_run_stop(dwc, is_on, false);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
