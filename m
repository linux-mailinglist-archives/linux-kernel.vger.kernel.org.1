Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2BA2B7B12
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgKRKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:19:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:41638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKRKTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:19:22 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C7022210;
        Wed, 18 Nov 2020 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605694761;
        bh=x4wkNRe9jFo0ZxW1Vm46053m/YQ6R5tZA6HofhoEH3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2oI8NKP1oMB2PUbxVUQofBmZ4cGXj6Fpfvq/DlN6jtCS/d7UaOGsx2Nmrn/xcS0i9
         lW/DDqLpy+P/wisQMW3BXDNs1woYqsnLi418xZjbp7kkgBDB51tGrxfgPA5ukIoHJG
         AAaHAUStLsWocHg8c53tgVXXPEhlj4tgJ1jFUdvw=
Date:   Wed, 18 Nov 2020 11:20:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     penghao <penghao@uniontech.com>
Cc:     johan@kernel.org, jonathan@jdcox.net, tomasz@meresinski.eu,
        hdegoede@redhat.com, dlaz@chromium.org,
        kai.heng.feng@canonical.com, richard.o.dodd@gmail.com,
        kerneldev@karsmulder.nl, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk for
 Lenovo A630Z TIO built-in usb-audio card
Message-ID: <X7T1V7deGBLk49Ul@kroah.com>
References: <20201118095343.3401-1-penghao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118095343.3401-1-penghao@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 05:53:43PM +0800, penghao wrote:
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
> Changes since v3
>  - Fixed spelling error on appropriate
> 
> Changes since v2
>  - Add Changes commit format
> 
> Changes since v1
>  - Change subject form "ALSA" to "USB:"
>  - Adjust to appropriate line
> 
> Signed-off-by: penghao <penghao@uniontech.com>
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

You are still leaving this blank line being added to the file, please do
not do that.
