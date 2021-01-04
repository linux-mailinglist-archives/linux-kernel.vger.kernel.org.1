Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0C2E9367
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbhADKdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:33:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbhADKdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:33:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 089C121D93;
        Mon,  4 Jan 2021 10:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609756352;
        bh=GDEaV/Y9fARhY1SDAGX9Q9b+10jDYcb+/zk9F00tQww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rk+dK/AltgRhhJAS8L3GOMP7UcUiUCRdO7M6Ajuzj+UX6HaJBWkXzybESvPqblhrh
         H0NgVVL5UqaolzGCk612D6eWVahm/NYrwm8XLsa+NP8TNT750gUaNnDVCTz2KPHj60
         vjQcguaKqD16dxKNcReab5qQnjNtzkSWOYgZ6RMnao7wfqUZ1/x6d3LKbRWUBH6prU
         kYJ/hMuf7UhjqkJl2IZm6G3/KH25q06rXu58LcvilLwuL1T/IoEqetI1TN2Ee20VoJ
         cUyHf8WdMmrqkje3uyyLvXvayP7f4IHvOveVbp65aK4HpWyrkPo/4PwQLeEERsmO4g
         BZTh8UG1eIkzw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kwNA4-0001Q8-3i; Mon, 04 Jan 2021 11:32:28 +0100
Date:   Mon, 4 Jan 2021 11:32:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add LongSung M5710 module support
Message-ID: <X/LuvBdeLVKyZkvO@hovoldconsulting.com>
References: <20201227031716.1343300-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201227031716.1343300-1-daniel@0x0f.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 12:17:16PM +0900, Daniel Palmer wrote:
> Add a vendor id for LongSung and a product id for the M5710 module.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  drivers/usb/serial/option.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 2c21e34235bb..2666e061c38d 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -560,6 +560,9 @@ static void option_instat_callback(struct urb *urb);
>  #define WETELECOM_PRODUCT_6802			0x6802
>  #define WETELECOM_PRODUCT_WMD300		0x6803
>  
> +/* LongSung */
> +#define LONGSUNG_VENDOR_ID			0x2df3
> +#define LONGSUNG_PRODUCT_M5710			0x9d03

I'm trying to move away from adding such defines for new devices as they
do not really add any value so I dropped them from the patch.
  
>  /* Device flags */
>  
> @@ -2060,6 +2063,8 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
> +	/* LongSung devices */
> +	{ USB_DEVICE(LONGSUNG_VENDOR_ID, LONGSUNG_PRODUCT_M5710) },		/* LongSung M5710 */
>  	{ } /* Terminating entry */
>  };
>  MODULE_DEVICE_TABLE(usb, option_ids);

Also, would you mind posting the "lsusb -v" output for this device for
reference? Do you know what each interface is used for?

I've applied this one locally, but I'll await your reply before pushing
it out.

Johan
