Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003082F2A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389028AbhALI6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:58:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbhALI6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:58:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70AC62220F;
        Tue, 12 Jan 2021 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610441844;
        bh=5tRdddFOBQhc/BLqX1deVT71d1tPhTHmXOX1cizkxbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLVL1JFZ03tcpsnuXRFI4xY/SE6dSaBtgn9sPLysmBvaZmRF1SCvFnoeKFpkCHRYH
         ch0Kk5c38IRElXG1DYKH8MhxE/3Nhce1Sk8TQDzxSDpSpS5ibUTtGJADUonpX9wpKN
         mXnJJ3fMcfTA5i34zsuYOyp73/bFALySZrrkItF49gbH4SYelzspkMm/SuPYbZ4p59
         sy0gglCZz1viu+RYZ7qDArlomQJcxzST+mSGyaqlv+40ELZ3qwz1ADR+fvGqW2qBkg
         rk1lKfMBDHboSSZO3h9GQQ9PQcq4Qmuz7+xrxVbAmZDBUC2xAlzxd6GYTjsC6+WrHa
         p0ayWS3Hyl50Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kzFUZ-0002xG-3t; Tue, 12 Jan 2021 09:57:31 +0100
Date:   Tue, 12 Jan 2021 09:57:31 +0100
From:   Johan Hovold <johan@kernel.org>
To:     trix@redhat.com
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] USB: serial: mos7720: improve handling of a kmalloc
 failure in read_mos_reg()
Message-ID: <X/1ke4/PaRQRGJTg@hovoldconsulting.com>
References: <20210111220904.1035957-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111220904.1035957-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 02:09:04PM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this problem
> 
> mos7720.c:352:2: warning: Undefined or garbage value returned to caller
>         return d;
>         ^~~~~~~~
> 
> In the parport_mos7715_read_data()'s call to read_mos_reg(), 'd' is
> only set after the alloc block.
> 
> 	buf = kmalloc(1, GFP_KERNEL);
> 	if (!buf)
> 		return -ENOMEM;
> 
> Although the problem is reported in parport_most7715_read_data(),
> none of the callee's of read_mos_reg() check the return status.
> 
> So move the clearing of data to before the malloc.
> 
> Fixes: 0d130367abf5 ("USB: serial: mos7720: fix control-message error handling")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/usb/serial/mos7720.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
> index 41ee2984a0df..23e8162c768b 100644
> --- a/drivers/usb/serial/mos7720.c
> +++ b/drivers/usb/serial/mos7720.c
> @@ -214,6 +214,7 @@ static int read_mos_reg(struct usb_serial *serial, unsigned int serial_portnum,
>  	u8 *buf;
>  	int status;
>  
> +	*data = 0;
>  	buf = kmalloc(1, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;

I added a clearing of the buffer to this error path instead to avoid the
redundant assignment for every call due to something which will
basically never happen.

> @@ -227,7 +228,6 @@ static int read_mos_reg(struct usb_serial *serial, unsigned int serial_portnum,
>  			"mos7720: usb_control_msg() failed: %d\n", status);
>  		if (status >= 0)
>  			status = -EIO;
> -		*data = 0;
>  	}
>  
>  	kfree(buf);

Johan
