Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA52B76A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 07:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgKRG6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 01:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgKRG6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 01:58:45 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A24424654;
        Wed, 18 Nov 2020 06:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605682725;
        bh=JEXidrPb3WDPpJaEzmw1ttSq10d4MBZ43iMbE5Qt4MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7rfoP64Hh8gVgpqqh2RU601bedtyMQFnJMEpJXzhq83bFzsQjypaXQVerCJlGRGH
         iDLjXiNaPoY+SjgKYNOwPx8Nnf41vV1e7JihUD2YrzSN2O2Or5r2ZOxJYZ1QuSUQ5X
         YIzByOKV7Cj2ySDFJrx7w6bfiwjJ/x+YSx7e1NHA=
Date:   Wed, 18 Nov 2020 07:59:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     penghao <penghao@uniontech.com>
Cc:     johan@kernel.org, jonathan@jdcox.net, tomasz@meresinski.eu,
        hdegoede@redhat.com, dlaz@chromium.org,
        kai.heng.feng@canonical.com, richard.o.dodd@gmail.com,
        kerneldev@karsmulder.nl, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Changes since v1  - Change subject form "ALSA" to "USB:"
 - Adjust to approoriate line
Message-ID: <X7TGU+JHUL4eTbG6@kroah.com>
References: <20201118065132.24772-1-penghao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118065132.24772-1-penghao@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 02:51:32PM +0800, penghao wrote:
> USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk for
> Lenovo A630Z TIO built-in usb-audio card

Your subject line does not work, please put that information below the
--- line.

Also, we need a "real" name for the From: and signed-off-by line please.

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
> Signed-off-by: penghao <penghao@uniontech.com>
> ---
>  drivers/usb/core/quirks.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 7c1198f80c23..8d18e89f9eb0 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -410,7 +410,11 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	{ USB_DEVICE(0x1532, 0x0116), .driver_info =
>  			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
>  
> -	/* BUILDWIN Photo Frame */
> +/* Lenovo - ThinkCenter A630Z TI024Gen3 usb-audio card */
> +{ USB_DEVICE(0x17ef, 0x0xa012), .driver_info =
> +USB_QUIRK_DISCONNECT_SUSPEND },
> +
> +    /* BUILDWIN Photo Frame */

Your patch seems to have messed up spaces and tabs here, please fix that
up in your editor and always run scripts/checkpatch.pl on your patch
before resending it.

thanks,

greg k-h
