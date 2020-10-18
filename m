Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB5D29176C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 14:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgJRMsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 08:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgJRMsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 08:48:52 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C7D3207FF;
        Sun, 18 Oct 2020 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603025330;
        bh=RpoHDjN72kLqkdSx0OOl2n8U6czI8kgVZ/OPcq2R9gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tiJ6g17ZDLEF8XaN22RiogJJq1ZAS3ZC6aWudJqPLlZnGShq3YpLQeQBhRTXgxpYm
         LvSTds8zpWtrPtDa4F3SF6gQPymu9JDO4ieu83mJOzEgnbUdTvSfB3AC7p+sQaFVYJ
         eVtwIAsrNHaGh711+bZc64wVukmEeHJWPeKj0cGQ=
Date:   Sun, 18 Oct 2020 14:49:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     septs <job@septs.email>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, septs <kernel@septs.pw>
Subject: Re: [PATCH 1/1] usb: serial: option: add Quectel EC200T module
 support
Message-ID: <20201018124937.GA3133964@kroah.com>
References: <20201018105111.8727-1-kernel@septs.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018105111.8727-1-kernel@septs.pw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 06:51:11PM +0800, septs wrote:
> Add usb product id of the Quectel EC200T module.
> ---
>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 2a3bfd6f8..7e879233b 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -250,6 +250,7 @@ static void option_instat_callback(struct urb *urb);
>  #define QUECTEL_PRODUCT_EP06			0x0306
>  #define QUECTEL_PRODUCT_EM12			0x0512
>  #define QUECTEL_PRODUCT_RM500Q			0x0800
> +#define QUECTEL_PRODUCT_EC200T			0x6026
>  
>  #define CMOTECH_VENDOR_ID			0x16d8
>  #define CMOTECH_PRODUCT_6001			0x6001
> @@ -1117,6 +1118,7 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x10),
>  	  .driver_info = ZLP },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
>  
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.


- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
