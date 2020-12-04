Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE55D2CEC29
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgLDK1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:27:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35511 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbgLDK1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:27:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id r18so6035629ljc.2;
        Fri, 04 Dec 2020 02:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4KvxB+d+5ywy9A6/0ZnwzTyeIWoINes9xRZQbwOh07Y=;
        b=gLz4x2MrHm3bDUcXoZvZCts58bB8byRMVDWDCl1ek4+7JtcNP+Rwq1YWqao4EkATgC
         FoIpqqYAq3rrRX4o2xGA28RnrLc+PQO917JqiXCzPCWBfCzpWvz3YJv5Wkirll8rEdxB
         FpzFwRYN+NN52mqOtVuhxb/A1g5amj/Yo4ByRyICUl4dhs2zEuoWP0SBnKsnQM/2fIw0
         5e/1wi6dSQudeWK42n0n5z0nbnotkTjCpiUhv81qR1XTuwBNi2D6FD1qhlO6QgtinBll
         S67ilDWrn4XoONHkOZbt/S4tOmtLAse58eVJCDixg5gVyl0Oe0Uq2VyZLAQL5+VM9Ba1
         2RPA==
X-Gm-Message-State: AOAM533wxdbUhb622luoY4nW2R8dUJe3jrlRSX+5G2dvu2HRHI+QtFMp
        XOenPIuPe0U6rJgxMSDBvHg=
X-Google-Smtp-Source: ABdhPJyNIHYkmXLpt3Qd8nNLlH/+1UYSHSQIu240NgH1te5ESuM9AmYrvldHOyXkbrogbJGn5dfjdQ==
X-Received: by 2002:a2e:330d:: with SMTP id d13mr3161448ljc.463.1607077618515;
        Fri, 04 Dec 2020 02:26:58 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f24sm1568176ljc.54.2020.12.04.02.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:26:57 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl8JH-0005WC-Jk; Fri, 04 Dec 2020 11:27:31 +0100
Date:   Fri, 4 Dec 2020 11:27:31 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 12/15] usb: serial: ipw: use usb_control_msg_send()
Message-ID: <X8oPEybfSt/pOrqY@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-13-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-13-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:17:00PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_send() nicely wraps usb_control_msg() with proper
> error check. Hence use the wrapper instead of calling usb_control_msg()
> directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/ipw.c | 107 +++++++++++++--------------------------
>  1 file changed, 36 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/usb/serial/ipw.c b/drivers/usb/serial/ipw.c
> index d04c7cc5c1c2..3c3895b4dff8 100644
> --- a/drivers/usb/serial/ipw.c
> +++ b/drivers/usb/serial/ipw.c
> @@ -134,26 +134,16 @@ static int ipw_open(struct tty_struct *tty, struct usb_serial_port *port)
>  	struct usb_device *udev = port->serial->dev;
>  	struct device *dev = &port->dev;
>  	u8 buf_flow_static[16] = IPW_BYTES_FLOWINIT;
> -	u8 *buf_flow_init;
>  	int result;
>  
> -	buf_flow_init = kmemdup(buf_flow_static, 16, GFP_KERNEL);
> -	if (!buf_flow_init)
> -		return -ENOMEM;
> -
>  	/* --1: Tell the modem to initialize (we think) From sniffs this is
>  	 *	always the first thing that gets sent to the modem during
>  	 *	opening of the device */
>  	dev_dbg(dev, "%s: Sending SIO_INIT (we guess)\n", __func__);
> -	result = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> -			 IPW_SIO_INIT,
> -			 USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
> -			 0,
> -			 0, /* index */
> -			 NULL,
> -			 0,
> -			 100000);
> -	if (result < 0)
> +	result = usb_control_msg_send(udev, 0, IPW_SIO_INIT, USB_TYPE_VENDOR |
> +				      USB_RECIP_INTERFACE | USB_DIR_OUT, 0,
> +				      0,  NULL, 0, 100000, GFP_KERNEL);

Try to keep the existing indentation style and also avoid breaking the
request argument (USB_TYPE_VENDOR | ...) over multiple lines.

> +	if (result)
>  		dev_err(dev, "Init of modem failed (error = %d)\n", result);
>  
>  	/* reset the bulk pipes */
> @@ -166,31 +156,22 @@ static int ipw_open(struct tty_struct *tty, struct usb_serial_port *port)
>  
>  	/*--3: Tell the modem to open the floodgates on the rx bulk channel */
>  	dev_dbg(dev, "%s:asking modem for RxRead (RXBULK_ON)\n", __func__);
> -	result = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> -			 IPW_SIO_RXCTL,
> -			 USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
> -			 IPW_RXBULK_ON,
> -			 0, /* index */
> -			 NULL,
> -			 0,
> -			 100000);
> -	if (result < 0)
> +	result = usb_control_msg_send(udev, 0, IPW_SIO_RXCTL, USB_TYPE_VENDOR |
> +				      USB_RECIP_INTERFACE | USB_DIR_OUT,
> +				      IPW_RXBULK_ON, 0, NULL, 0, 100000,
> +				      GFP_KERNEL);
> +	if (result)
>  		dev_err(dev, "Enabling bulk RxRead failed (error = %d)\n", result);
>  
>  	/*--4: setup the initial flowcontrol */
> -	dev_dbg(dev, "%s:setting init flowcontrol (%s)\n", __func__, buf_flow_init);
> -	result = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> -			 IPW_SIO_HANDFLOW,
> -			 USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
> -			 0,
> -			 0,
> -			 buf_flow_init,
> -			 0x10,
> -			 200000);
> -	if (result < 0)
> +	dev_dbg(dev, "%s:setting init flowcontrol (%s)\n", __func__, buf_flow_static);
> +	result = usb_control_msg_send(udev, 0, IPW_SIO_HANDFLOW,
> +				      USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
> +				      USB_DIR_OUT, 0, 0, &buf_flow_static, 0x10,
> +				      200000, GFP_KERNEL);
> +	if (result)
>  		dev_err(dev, "initial flowcontrol failed (error = %d)\n", result);

Note that sending a short control message is always an error so there's
nothing wrong with the current errors checks.

In fact, since all but this control request lacks a data stage, I'd just
leave this one as is as well.

Johan
