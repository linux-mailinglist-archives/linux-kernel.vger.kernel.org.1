Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A592CEACD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgLDJYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:24:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43279 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbgLDJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:24:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id q13so6735398lfr.10;
        Fri, 04 Dec 2020 01:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sKKiM0BRn5/pdbr70PL9ZPEPCJsdCcavt38dAiUxSQA=;
        b=BomUOV7kF8NxNarp66YwrOM/sIQpHSE4jMHkZc02/e4QLyuzb6fo3IbAQHyUi5w6m2
         p3JRxdYYR3ln1on2DOBijVIL7MaFrKIpnXtIletHDEL2eTOay9z0fZ/I+QKpBIwm4P/c
         2U3pwcXca43fW4Rbb/m7dCfuVDua5ZNlwsbyqYB2K9fh6c7clorNl4XPo99zTFeyzZ9u
         GK0b2pbx3h8ZCeTAQfzAp2vllbL9LdiVhVSD5fp+7s/6kPe40n+b6l/7UEjJ6Kk6++Qy
         uJDyp6FJaZt65ZwwmXnHnXqmJxaBa1Jm9mbdM5q0cND5Xfj8+hi/uiZXjOIqtDQdZU0X
         GZSA==
X-Gm-Message-State: AOAM5315Y9+DxiOrC+2N+0L9bzXmYaCsbsLxPI3NTblDAf6+ZBae6lyG
        uEN20S15GTzzw4pVG/CK6KJmDAJ+O1YYvA==
X-Google-Smtp-Source: ABdhPJwaonjDxHe2/7wGMsZBBV/dILmNjWutydsh7per1UQR/cnVx3utsnM0EF8LGzJuvLt1zBUNQQ==
X-Received: by 2002:ac2:5985:: with SMTP id w5mr3061729lfn.386.1607073833035;
        Fri, 04 Dec 2020 01:23:53 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f1sm1495042lfm.184.2020.12.04.01.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:23:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl7KD-0005Lt-5H; Fri, 04 Dec 2020 10:24:25 +0100
Date:   Fri, 4 Dec 2020 10:24:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 03/15] usb: serial: ch314: use usb_control_msg_recv() and
 usb_control_msg_send()
Message-ID: <X8oASVHmeoCmM5RM@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-4-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-4-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:16:51PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
> usb_control_msg() with proper error check. Hence use the wrappers
> instead of calling usb_control_msg() directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/ch341.c | 45 ++++++++++++--------------------------
>  1 file changed, 14 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
> index a2e2f56c88cd..58c5d3ce4f75 100644
> --- a/drivers/usb/serial/ch341.c
> +++ b/drivers/usb/serial/ch341.c
> @@ -111,10 +111,10 @@ static int ch341_control_out(struct usb_device *dev, u8 request,
>  	dev_dbg(&dev->dev, "%s - (%02x,%04x,%04x)\n", __func__,
>  		request, value, index);
>  
> -	r = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), request,
> -			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
> -			    value, index, NULL, 0, DEFAULT_TIMEOUT);
> -	if (r < 0)
> +	r = usb_control_msg_send(dev, 0, request, USB_TYPE_VENDOR |
> +				 USB_RECIP_DEVICE | USB_DIR_OUT, value, index,
> +				 NULL, 0, DEFAULT_TIMEOUT, GFP_KERNEL);
> +	if (r)
>  		dev_err(&dev->dev, "failed to send control message: %d\n", r);
>  
>  	return r;
> @@ -129,23 +129,14 @@ static int ch341_control_in(struct usb_device *dev,
>  	dev_dbg(&dev->dev, "%s - (%02x,%04x,%04x,%u)\n", __func__,
>  		request, value, index, bufsize);
>  
> -	r = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), request,
> -			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
> -			    value, index, buf, bufsize, DEFAULT_TIMEOUT);
> -	if (r < (int)bufsize) {
> -		if (r >= 0) {
> -			dev_err(&dev->dev,
> -				"short control message received (%d < %u)\n",
> -				r, bufsize);
> -			r = -EIO;
> -		}
> -
> +	r = usb_control_msg_recv(dev, 0, request, USB_TYPE_VENDOR |
> +				 USB_RECIP_DEVICE | USB_DIR_IN, value, index,
> +				 buf, bufsize, DEFAULT_TIMEOUT, GFP_KERNEL);
> +	if (r)
>  		dev_err(&dev->dev, "failed to receive control message: %d\n",
>  			r);
> -		return r;
> -	}
>  
> -	return 0;
> +	return r;
>  }

The callers of these functions are allocating temporary transfers buffer
for each request so this is a case where the new helpers may be of worth
if you fix up the callers as well (otherwise, you're adding redundant
memdup + memcpy for each call here).

>  
>  #define CH341_CLKRATE		48000000
> @@ -343,22 +334,18 @@ static int ch341_detect_quirks(struct usb_serial_port *port)
>  	struct usb_device *udev = port->serial->dev;
>  	const unsigned int size = 2;
>  	unsigned long quirks = 0;
> -	char *buffer;
> +	u8 buffer[2];
>  	int r;
>  
> -	buffer = kmalloc(size, GFP_KERNEL);
> -	if (!buffer)
> -		return -ENOMEM;
> -
>  	/*
>  	 * A subset of CH34x devices does not support all features. The
>  	 * prescaler is limited and there is no support for sending a RS232
>  	 * break condition. A read failure when trying to set up the latter is
>  	 * used to detect these devices.
>  	 */
> -	r = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0), CH341_REQ_READ_REG,
> -			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
> -			    CH341_REG_BREAK, 0, buffer, size, DEFAULT_TIMEOUT);
> +	r = usb_control_msg_recv(udev, 0, CH341_REQ_READ_REG, USB_TYPE_VENDOR |
> +				 USB_RECIP_DEVICE | USB_DIR_IN, CH341_REG_BREAK,
> +				 0, &buffer, size, DEFAULT_TIMEOUT, GFP_KERNEL);
>  	if (r == -EPIPE) {
>  		dev_info(&port->dev, "break control not supported, using simulated break\n");
>  		quirks = CH341_QUIRK_LIMITED_PRESCALER | CH341_QUIRK_SIMULATE_BREAK;
> @@ -366,17 +353,13 @@ static int ch341_detect_quirks(struct usb_serial_port *port)
>  		goto out;
>  	}
>  
> -	if (r != size) {
> -		if (r >= 0)
> -			r = -EIO;
> +	if (r) {
>  		dev_err(&port->dev, "failed to read break control: %d\n", r);
>  		goto out;
>  	}
>  
>  	r = 0;
>  out:
> -	kfree(buffer);
> -
>  	if (quirks) {
>  		dev_dbg(&port->dev, "enabling quirk flags: 0x%02lx\n", quirks);
>  		priv->quirks |= quirks;

This is a good example of when to use the helpers. But it seems you
should remove the "r = 0" and "out" label as well, right?

Johan
