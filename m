Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696E32B7A75
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgKRJeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgKRJeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:34:08 -0500
Received: from localhost (unknown [89.205.136.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BF44206A5;
        Wed, 18 Nov 2020 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605692047;
        bh=xHmOu+PXd8Yg2++cDjRs3tWJjNJ/Wm+c5da2xYMxdv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5Xu/nc+1gTElZR99zO1qryYKsARkh6Sq6eKMHHI2DLJHahzlYvGjyKzPsihREwD3
         FSMFSRqJ/njjog0qpWHi5CLehxq8c5v/4VcWuLOKyS1328ht5srOyG+Y2773JdztJ7
         b4UBMRZAdAhptDgDcZlQKTsm4+3hC6JxM8U5YH7o=
Date:   Wed, 18 Nov 2020 10:34:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     penghao <penghao@uniontech.com>
Cc:     johan@kernel.org, jonathan@jdcox.net, tomasz@meresinski.eu,
        hdegoede@redhat.com, dlaz@chromium.org,
        kai.heng.feng@canonical.com, richard.o.dodd@gmail.com,
        kerneldev@karsmulder.nl, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk for
 Lenovo A630Z TIO built-in usb-audio card
Message-ID: <X7TqjDO/JMJ2VJ/e@kroah.com>
References: <20201118092656.944-1-penghao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118092656.944-1-penghao@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 05:26:56PM +0800, penghao wrote:
> Add a USB_QUIRK_DISCONNECT_SUSPEND quirk for the Lenovo TIO built-in
> usb-audio. when A630Z going into S3,the system immediately wakeup 7-8
> seconds later by usb-audio disconnect interrupt to avoids the issue.
> 
> Seeking a better fix, we've tried a lot of things, including:
>  - Check that the device's power/wakeup is disabled
>  - Check that remote wakeup is off at the USB level
>  - All the quirks in drivers/usb/core/quirks.c
>    e.g. USB_QUIRK_RESET_RESUME,
>         USB_QUIRK_RESET,
>         USB_QUIRK_IGNORE_REMOTE_WAKEUP,
>         USB_QUIRK_NO_LPM.
> 
> but none of that makes any difference.
> 
> There are no errors in the logs showing any suspend/resume-related issues.
> When the system wakes up due to the modem, log-wise it appears to be a
> normal resume.
> 
> Introduce a quirk to disable the port during suspend when the modem is
> detected.
> 
> Changes approoriate to appropriate
> 
> Changes since v2
>  - Add Changes commit format
> 
> Changes since v1
>  - Change subject form "ALSA" to "USB:"
>  - Adjust to appropriate line

You don't have a "version" in the subject line, what one is this?


> 
> Signed-off-by: penghao <penghao@uniontech.com>

Is that the name/characters you sign legal documents with?  If so,
great, but I have to ask.

> ---
>  drivers/usb/core/quirks.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 7c1198f80c23..25f655c2cd28 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -410,6 +410,10 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	{ USB_DEVICE(0x1532, 0x0116), .driver_info =
>  			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
>  
> +	/* Lenovo ThinkCenter A630Z TI024Gen3 usb-audio */
> +	{ USB_DEVICE(0x17ef, 0xa012), .driver_info =
> +			USB_QUIRK_DISCONNECT_SUSPEND },
> +
>  	/* BUILDWIN Photo Frame */
>  	{ USB_DEVICE(0x1908, 0x1315), .driver_info =
>  			USB_QUIRK_HONOR_BNUMINTERFACES },
> @@ -430,6 +434,7 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	  USB_QUIRK_DELAY_CTRL_MSG },
>  
>  	/* Corsair Strafe RGB */
> +

Why are you adding this blank line for no reason?

Please fix.

thanks,

greg k-h
