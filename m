Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A022E9913
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbhADPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbhADPog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:44:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 244DC21D93;
        Mon,  4 Jan 2021 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609775035;
        bh=oIOdn1cm925hl6iQ2ChQ9l9kj2qYpDJe0fL6Dgbb3Ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1f0eu/os/MNFRHTy/JJPoEHRRRqTjVqd8k5waO/a3d8VyefOZXuXx1qDzc9HA0SCd
         qlRlA1pF2NFiqre0fBL9ZbMDVBncEe0mf+8/TyuHEjtEoQiA8fENwO1E1aAz/GKrzA
         vbjVqZGPeESN0i/yVb61xj/VIal/1mDKTo915Ces=
Date:   Mon, 4 Jan 2021 16:45:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     peter.chen@nxp.com, balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: gadget: configfs: Add a specific configFS reset
 callback
Message-ID: <X/M4EaLuiuHstHeX@kroah.com>
References: <1609283011-21997-1-git-send-email-wcheng@codeaurora.org>
 <1609283011-21997-4-git-send-email-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609283011-21997-4-git-send-email-wcheng@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 03:03:31PM -0800, Wesley Cheng wrote:
> In order for configFS based USB gadgets to set the proper charge current
> for bus reset scenarios, expose a separate reset callback to set the
> current to 100mA based on the USB battery charging specification.
> 
> Reviewed-by: Peter Chen <peter.chen@nxp.com>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  drivers/usb/gadget/configfs.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 56051bb97349..80ca7ff2fb97 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -1481,6 +1481,28 @@ static void configfs_composite_disconnect(struct usb_gadget *gadget)
>  	spin_unlock_irqrestore(&gi->spinlock, flags);
>  }
>  
> +static void configfs_composite_reset(struct usb_gadget *gadget)
> +{
> +	struct usb_composite_dev *cdev;
> +	struct gadget_info *gi;
> +	unsigned long flags;
> +
> +	cdev = get_gadget_data(gadget);
> +	if (!cdev)
> +		return;
> +
> +	gi = container_of(cdev, struct gadget_info, cdev);
> +	spin_lock_irqsave(&gi->spinlock, flags);
> +	cdev = get_gadget_data(gadget);
> +	if (!cdev || gi->unbind) {
> +		spin_unlock_irqrestore(&gi->spinlock, flags);
> +		return;
> +	}
> +
> +	composite_reset(gadget);
> +	spin_unlock_irqrestore(&gi->spinlock, flags);
> +}
> +
>  static void configfs_composite_suspend(struct usb_gadget *gadget)
>  {
>  	struct usb_composite_dev *cdev;
> @@ -1530,7 +1552,7 @@ static const struct usb_gadget_driver configfs_driver_template = {
>  	.unbind         = configfs_composite_unbind,
>  
>  	.setup          = configfs_composite_setup,
> -	.reset          = configfs_composite_disconnect,
> +	.reset          = configfs_composite_reset,
>  	.disconnect     = configfs_composite_disconnect,
>  
>  	.suspend	= configfs_composite_suspend,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

So this changes the existing userspace functionality?  What will break
because of this now unexpected change?

thanks,

greg k-h
