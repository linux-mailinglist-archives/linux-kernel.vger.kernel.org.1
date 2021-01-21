Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C902FE785
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbhAUK0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:26:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729104AbhAUKYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:24:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EF6F23356;
        Thu, 21 Jan 2021 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611224629;
        bh=Vk+g6s1/mECeUrJ4TEUTgxd3IC/yHrCw9bhT4vdIydE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y//oif6RNho7eiB/JWL7uxdyTnNwfe6Ifi9MR5XodbwLLMrMhEK5H8/qaRkrWyHAG
         aXW67zyO4Od3bbGPy3z4r1/nVh6zgS/QoZpqwQz6W4sZIXZFXLSejsr/5GzQaI52I8
         sG+cYCkR0tZSYQcvQxrZxUuadGMHC5SrZMR0Lk03tjXa+CxlcfTlxCF3c8hH8P/EFg
         lDNWSqqnb2RHiA0GDEbKwIlxGSVQaxhk4y6gUmt0Fpgah2WaioaLmqQylm420hB/Db
         TnZiYnM1wugBTgtg28bpB4MpHMXMO6pIslQnZTDf1AdNBDQsmXEm9xfp6yGG3UPQv5
         9E272uahxLWLQ==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l2X88-0004VM-4w; Thu, 21 Jan 2021 11:23:56 +0100
Date:   Thu, 21 Jan 2021 11:23:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org, angelo.dureghello@timesys.com
Subject: Re: [PATCH v5 3/3] usb: cdc-acm: Ignore Exar XR21V141X when serial
 driver is built
Message-ID: <YAlWPF0vn/zFRsQu@hovoldconsulting.com>
References: <20201122170822.21715-1-mani@kernel.org>
 <20201122170822.21715-4-mani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122170822.21715-4-mani@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 10:38:22PM +0530, Manivannan Sadhasivam wrote:
> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> The RTS/CTS line discipline for this device doesn't follow
> the standard. So, in order to properly support TX, a separate
> driver is needed.

This took a bit of effort to understand, but I think I know what you're
referring to now. In ACM mode the device has RTS/CTS flow control
enabled, which means TX will be disabled in case CTS isn't wired up
correctly.

It as nothing to do with line disciplines though.

> Ensure that cdc_acm will ignore it during probe time, if the
> Kernel is built with support for it.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>

> ---
>  drivers/usb/class/cdc-acm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 30ef946a8e1a..719829e6b6db 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -1890,6 +1890,12 @@ static const struct usb_device_id acm_ids[] = {
>  	},
>  #endif
>  
> +#if IS_ENABLED(CONFIG_USB_SERIAL_XR)
> +	{ USB_DEVICE(0x04e2, 0x1410),   /* Ignore XR21V141X USB to Serial converter */
> +	.driver_info = IGNORE_DEVICE,
> +	},
> +#endif
> +
>  	/*Samsung phone in firmware update mode */
>  	{ USB_DEVICE(0x04e8, 0x685d),
>  	.driver_info = IGNORE_DEVICE,

I've rewritten the commit message and applied this one now.

Johan
