Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08EB2C79F6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgK2QQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:16:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgK2QQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:16:54 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A618F2080C;
        Sun, 29 Nov 2020 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606666567;
        bh=iuhl6jqcqemEjueLeX9RtQtS5Hlomxs0uN0YI18a/qU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xNrqMzkok3fomfue06G87svG+7XNZu+9H5o29JzHXDZ4ONw6uwPp7MukHSivZZdwx
         mu/rttiqKzrft1tu5KwQuh86tv/e7R7hQ8ybf/nLWUnEXr4No3mII6GXw+jVyJ5LMQ
         yfw8ENRAoAxyAkIcYP830FlYNzNg2vJvs1+P9RO0=
Date:   Sun, 29 Nov 2020 17:16:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] usb: misc: cytherm: update to use
 usb_control_msg_recv()
Message-ID: <X8PJQzUZymkClmbE@kroah.com>
References: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
 <20201129160612.1908074-4-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201129160612.1908074-4-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 29, 2020 at 09:36:00PM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, the instance of usb_control_msg() has been replaced with
> usb_control_msg_recv().
> 
> The return value checking enforced by callers of the updated function have
> also been appropriately updated.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/cytherm.c | 42 +++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/usb/misc/cytherm.c b/drivers/usb/misc/cytherm.c
> index 3e3802aaefa3..75fa4d806a77 100644
> --- a/drivers/usb/misc/cytherm.c
> +++ b/drivers/usb/misc/cytherm.c
> @@ -51,12 +51,12 @@ static int vendor_command(struct usb_device *dev, unsigned char request,
>  			  unsigned char value, unsigned char index,
>  			  void *buf, int size)
>  {
> -	return usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
> -			       request, 
> -			       USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
> -			       value, 
> -			       index, buf, size,
> -			       USB_CTRL_GET_TIMEOUT);
> +	return usb_control_msg_recv(dev, 0,
> +				    request,
> +				    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
> +				    value,
> +				    index, buf, size,
> +				    USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
>  }
>  
>  
> @@ -95,14 +95,14 @@ static ssize_t brightness_store(struct device *dev, struct device_attribute *att
>  	/* Set brightness */
>  	retval = vendor_command(cytherm->udev, WRITE_RAM, BRIGHTNESS, 
>  				cytherm->brightness, buffer, 8);
> -	if (retval)
> -		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
> +	if (!retval)
> +		dev_dbg(&cytherm->udev->dev, "brightness set correctly\n");
>  	/* Inform µC that we have changed the brightness setting */
>  	retval = vendor_command(cytherm->udev, WRITE_RAM, BRIGHTNESS_SEM,
>  				0x01, buffer, 8);
> -	if (retval)
> -		dev_dbg(&cytherm->udev->dev, "retval = %d\n", retval);
> -   
> +	if (!retval)
> +		dev_dbg(&cytherm->udev->dev, "µC informed of change in brightness setting\n");
> +
>  	kfree(buffer);
>     
>  	return count;

There's no more need to dynamically allocate the buffer variable here
now, right?  It can be on the stack as the change you made above allows
that to work properly, no need to allocate the buffer twice in a row
(once here and once in the USB core).

That would make these functions less complex, always a good thing.

You should check this on the other patches in this series as well.

thanks,

greg k-h
