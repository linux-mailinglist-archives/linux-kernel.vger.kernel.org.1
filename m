Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949212ECD1E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbhAGJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbhAGJt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:49:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 776362333D;
        Thu,  7 Jan 2021 09:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610012958;
        bh=CC5w2dVB0msolsQQjxn98j0tPU3c4rpDBCwIt5Z8nGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zgRdSM4C0FhR0XlV7OGhk8xmHZLEuspAvfBgdKQTOl3x/cOcdTqfFGSsxSullwvpe
         K9Ucl39JlHoaNsdFX7iQeL6URdt4oP94QNyHRYBfWWSh87FafgDaUNHqFzkBDfg+p7
         9lQtl8xfayzyCTiSD2ldbd6TYlQLJolYHBjX0zU4=
Date:   Thu, 7 Jan 2021 10:50:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Albert Wang <albertccwang@google.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "usb: gadget: Quieten gadget config message"
Message-ID: <X/bZbluYJ0syB/Do@kroah.com>
References: <20210107090604.299270-1-albertccwang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107090604.299270-1-albertccwang@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 09:06:04AM +0000, Albert Wang wrote:
> This reverts commit 1cbfb8c4f62d667f6b8b3948949737edb92992cc.
> 
> The log of USB enumeration result is a useful log and only occupies
> one line especially when USB3 enumeration failed and then downgrade
> to USB2.
> 
> Signed-off-by: Albert Wang <albertccwang@google.com>
> ---
>  drivers/usb/gadget/composite.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index c6d455f2bb92..5b0d6103a63d 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -840,9 +840,9 @@ static int set_config(struct usb_composite_dev *cdev,
>  		result = 0;
>  	}
>  
> -	DBG(cdev, "%s config #%d: %s\n",
> -	    usb_speed_string(gadget->speed),
> -	    number, c ? c->label : "unconfigured");
> +	INFO(cdev, "%s config #%d: %s\n",
> +	     usb_speed_string(gadget->speed),
> +	     number, c ? c->label : "unconfigured");

When everything is working properly, the kernel should be quiet.  If you
have to see this message, you can turn it on at runtime, as Felipe
pointed out, to enable it for your system.  But it's not a good default
thing to have.

What do you need to see this message for?  What tool relies on it?  Who
reads it?

thanks,

greg k-h
