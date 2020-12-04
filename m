Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0FC2CEB56
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbgLDJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:49:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42699 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:49:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id f18so5859701ljg.9;
        Fri, 04 Dec 2020 01:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yfKg58xkwXSx71ApTWNauMGgiUBJzBDMz0afZorcj6g=;
        b=NzQ1Vih3j2okoDyPa6c6XQFM0tYy/Mfh6KDkGNRoU4p9Ktf+G+1oK3SzhgWSEBlI/f
         b78qdR77OXD1MDUrvPt+rWFvjxaG5d3xIX1LllPR5EA8gVD/gIAgKJ8RbOI8T4Xls80E
         nX9h7hsZiORAcGePGxebLOaS28Bda+0me/RNIsVyd2YC8ikCwu4l+sMJfuxfMJPTkdRX
         XSJHdv2b3qsU5PbkWh2/Sqk2q1Pj4EwGKKHDgHWFiXzH73etiwAMCdJ9+Ug1uE/Uo4X5
         oEO+xxtflR/4xomdbHqkPNW32rbTbIkMmiGC8vcF4yKYpMKxGNW6ZNfYql0Ha2dOLu5h
         qVog==
X-Gm-Message-State: AOAM531Za6PjPT6iete1AjMvoVc1APqAFIta7tHnjxGEq4rQCbSaMrbd
        Hg3c7NHcjkbXc6DJX/P6FCe4g+0qf5KZ4Q==
X-Google-Smtp-Source: ABdhPJxr10bCWAeW8yV/PU74dvNZ4dJz19Ik47TU1YQU5WuqIYQbLqZVR7Otpqa43hR1seN9Oz1bOA==
X-Received: by 2002:a2e:9f4b:: with SMTP id v11mr2917769ljk.96.1607075351218;
        Fri, 04 Dec 2020 01:49:11 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id t6sm1482833lfc.231.2020.12.04.01.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:49:10 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl7ih-0005PO-Hu; Fri, 04 Dec 2020 10:49:44 +0100
Date:   Fri, 4 Dec 2020 10:49:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 06/15] usb: serial: f81232: use usb_control_msg_recv()
 and usb_control_msg_send()
Message-ID: <X8oGN9G+i9rQM9eX@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-7-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-7-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:16:54PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
> usb_control_msg() with proper error check. Hence use the wrappers
> instead of calling usb_control_msg() directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 88 ++++++++-----------------------------
>  1 file changed, 18 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 0c7eacc630e0..78107feef8a8 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -139,71 +139,36 @@ static int calc_baud_divisor(speed_t baudrate, speed_t clockrate)
>  static int f81232_get_register(struct usb_serial_port *port, u16 reg, u8 *val)
>  {
>  	int status;
> -	u8 *tmp;
>  	struct usb_device *dev = port->serial->dev;
>  
> -	tmp = kmalloc(sizeof(*val), GFP_KERNEL);
> -	if (!tmp)
> -		return -ENOMEM;
> -
> -	status = usb_control_msg(dev,
> -				usb_rcvctrlpipe(dev, 0),
> -				F81232_REGISTER_REQUEST,
> -				F81232_GET_REGISTER,
> -				reg,
> -				0,
> -				tmp,
> -				sizeof(*val),
> -				USB_CTRL_GET_TIMEOUT);
> -	if (status != sizeof(*val)) {
> +	status = usb_control_msg_recv(dev, 0, F81232_REGISTER_REQUEST,
> +				      F81232_GET_REGISTER, reg, 0, val,
> +				      sizeof(*val), USB_CTRL_GET_TIMEOUT,
> +				      GFP_KERNEL);

This driver use tabs for indentation consistently so please stick to
that style. That should also amount to a smaller patch (and less noise
in the logs, e.g. for git blame).

> +	if (status) {
>  		dev_err(&port->dev, "%s failed status: %d\n", __func__, status);
>  
> -		if (status < 0)
> -			status = usb_translate_errors(status);
> -		else
> -			status = -EIO;
> -	} else {
> -		status = 0;
> -		*val = *tmp;
> +		status = usb_translate_errors(status);
>  	}
>  
> -	kfree(tmp);
>  	return status;
>  }

> @@ -866,32 +831,16 @@ static int f81534a_ctrl_set_register(struct usb_interface *intf, u16 reg,
>  	struct usb_device *dev = interface_to_usbdev(intf);
>  	int retry = F81534A_ACCESS_REG_RETRY;
>  	int status;
> -	u8 *tmp;
> -
> -	tmp = kmemdup(val, size, GFP_KERNEL);
> -	if (!tmp)
> -		return -ENOMEM;
>  
>  	while (retry--) {
> -		status = usb_control_msg(dev,
> -					usb_sndctrlpipe(dev, 0),
> -					F81232_REGISTER_REQUEST,
> -					F81232_SET_REGISTER,
> -					reg,
> -					0,
> -					tmp,
> -					size,
> -					USB_CTRL_SET_TIMEOUT);
> -		if (status < 0) {
> +		status = usb_control_msg_send(dev, 0, F81232_REGISTER_REQUEST,
> +					      F81232_SET_REGISTER, reg, 0, val,
> +					      size, USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
> +		if (status) {
> +			/* Retry on error or short transfers */
>  			status = usb_translate_errors(status);
>  			if (status == -EIO)
>  				continue;

So this now depends on the new helper returning an errno on short
transfers which gets mapped to -EIO by usb_translate_errors(). This
works currently (and with my suggested change to use -EREMOTEIO) but
could possibly lead to subtle regressions later.

I don't think we need to worry about it, but just wanted to highlight
the kind of impact these changes can have.

Note that this change also replaces a single memdup with a memdup+memcpy
for each iteration. But as this helper is used rarely (e.g. probe,
resume and disconnect), and hopefully the retries are exceptions, the
overhead could be acceptable.

> -		} else if (status != size) {
> -			/* Retry on short transfers */
> -			status = -EIO;
> -			continue;
> -		} else {
> -			status = 0;
>  		}
>  
>  		break;
> @@ -902,7 +851,6 @@ static int f81534a_ctrl_set_register(struct usb_interface *intf, u16 reg,
>  				reg, status);
>  	}
>  
> -	kfree(tmp);
>  	return status;
>  }

Johan
