Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9702CEBCF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbgLDKEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:04:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39417 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgLDKEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:04:04 -0500
Received: by mail-lf1-f66.google.com with SMTP id j205so6874838lfj.6;
        Fri, 04 Dec 2020 02:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xMrdek2B9lwcQxC9EmxKMrAzrWC0Z4gLKFIOEp3HsgI=;
        b=J8XOl03YdNVXloa9XFwXlhZM7CoG1UiertFXQzD7N4YdC9TL6JYAd1zTi63fhm8JbI
         HqesdLcX9m36FE6o5lW0vOW+o+8QGet9NU/DkcRUHoCa58QtIRxJtTLEb4jqtYsolLUY
         WvoDsFRRX4L5VZ+2+q/Db42P+r5vM3q5ULR/hG27+YE/xZ1XfLFmtRx2x8ZOCYRP3uEa
         b4uD8IOXPYnP/vksS0FUYZJehvgyOVKteagwlpskV4as9qD8rJtd71yobAu38t8+wwsN
         WJ5Foyeq+kCt6Ug2/mACAnSQ/daKQ92S1J/r/U+ieYkIOUF8+XxPAl+/tCDRaUSo1vfG
         vxpg==
X-Gm-Message-State: AOAM532cnmghgmKfQo1v3UVHe9PTWcSnU4m2oAUPaAg50UfJoNfpTxWZ
        0p1F2GHcDs3fMpdxX8nam5E=
X-Google-Smtp-Source: ABdhPJwaAMR55VgpO0A8krOrHeXKRU655Zt25tnxro5IbmPsH541TkHzZbRwTkvMtwU+U2E2eTqUyw==
X-Received: by 2002:a19:8c13:: with SMTP id o19mr2878240lfd.573.1607076202331;
        Fri, 04 Dec 2020 02:03:22 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id s23sm1495539ljs.75.2020.12.04.02.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:03:21 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl7wQ-0005Rs-L1; Fri, 04 Dec 2020 11:03:55 +0100
Date:   Fri, 4 Dec 2020 11:03:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 08/15] usb: serial: ftdi_sio: use usb_control_msg_recv()
 and usb_control_msg_send()
Message-ID: <X8oJimVHyGxGodZd@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-9-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-9-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:16:56PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
> usb_control_msg() with proper error check. Hence use the wrappers
> instead of calling usb_control_msg() directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/ftdi_sio.c | 182 +++++++++++++++-------------------
>  1 file changed, 78 insertions(+), 104 deletions(-)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index e0f4c3d9649c..37e9e75b90d0 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -1245,13 +1245,12 @@ static int update_mctrl(struct usb_serial_port *port, unsigned int set,
>  		value |= FTDI_SIO_SET_DTR_HIGH;
>  	if (set & TIOCM_RTS)
>  		value |= FTDI_SIO_SET_RTS_HIGH;
> -	rv = usb_control_msg(port->serial->dev,
> -			       usb_sndctrlpipe(port->serial->dev, 0),
> -			       FTDI_SIO_SET_MODEM_CTRL_REQUEST,
> -			       FTDI_SIO_SET_MODEM_CTRL_REQUEST_TYPE,
> -			       value, priv->interface,
> -			       NULL, 0, WDR_TIMEOUT);
> -	if (rv < 0) {
> +	rv = usb_control_msg_send(port->serial->dev, 0,
> +				  FTDI_SIO_SET_MODEM_CTRL_REQUEST,
> +				  FTDI_SIO_SET_MODEM_CTRL_REQUEST_TYPE,
> +				  value, priv->interface,
> +				  NULL, 0, WDR_TIMEOUT, GFP_KERNEL);
> +	if (rv) {
>  		dev_dbg(dev, "%s Error from MODEM_CTRL urb: DTR %s, RTS %s\n",
>  			__func__,
>  			(set & TIOCM_DTR) ? "HIGH" : (clear & TIOCM_DTR) ? "LOW" : "unchanged",

As I mentioned earlier there's no point in using these helper for
control transfers without a data stage so please drop those conversions
and only update _read_latency_timer() ftdi_read_cbus_pins().

> @@ -2311,6 +2285,7 @@ static int ftdi_NDI_device_setup(struct usb_serial *serial)
>  {
>  	struct usb_device *udev = serial->dev;
>  	int latency = ndi_latency_timer;
> +	int ret;
>  
>  	if (latency == 0)
>  		latency = 1;
> @@ -2320,12 +2295,12 @@ static int ftdi_NDI_device_setup(struct usb_serial *serial)
>  	dev_dbg(&udev->dev, "%s setting NDI device latency to %d\n", __func__, latency);
>  	dev_info(&udev->dev, "NDI device with a latency value of %d\n", latency);
>  
> -	/* FIXME: errors are not returned */
> -	usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> -				FTDI_SIO_SET_LATENCY_TIMER_REQUEST,
> -				FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE,
> -				latency, 0, NULL, 0, WDR_TIMEOUT);
> -	return 0;
> +	ret = usb_control_msg_send(udev, 0,
> +				   FTDI_SIO_SET_LATENCY_TIMER_REQUEST,
> +				   FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE,
> +				   latency, 0, NULL, 0, WDR_TIMEOUT,
> +				   GFP_KERNEL);
> +	return ret;

Also note that returning ret here is an unrelated change which could
potentially break probing in case there are devices which do not support
this request (and would need to be done in a separate patch if at all).

Johan
