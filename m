Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F372CEAF5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgLDJeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:34:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38137 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgLDJeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:34:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id j10so5830448lja.5;
        Fri, 04 Dec 2020 01:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SAJ9D9uj5Zq76FuUuV8xz2nCj2G+XGK+GvqkMWkny8s=;
        b=JdbsbYQSbt2Zh6h2Xd35lJmSnOCJUrMXdLViljA85SO5XyGhUBnE8S14iPNDSrqA9R
         n1fTCHKPdlUVEjfAl7tUjALZiUrxc1AHD6iW19h91AX6MHOECxfD5cJKIcVj24VENFc3
         D1yxx2fctfZiX7Vk7sE0TQV5c55pyDYVjMAn9ot1VknFKhmqSdtVpIbDV65pii3LaRIS
         5vUZf1E/yE1544I5NGxkD9qipx64VvmRZJsLVgP4dZA23GhOJYTqfk3WvE8adbR+f6W8
         tMtYhQv5hFNUYJdY8yvN9JoGixqRXCnYV71+f3nJhc+sjMeVkTE0P3oWqDIZGcsZyrRY
         zmcQ==
X-Gm-Message-State: AOAM531zGsgHHKel74/CqRcShVqJ1+MAJ3CCGIIUsAyRYSXwnaAmSYgR
        XU7ShQoP1VF0fR+JzU9S278=
X-Google-Smtp-Source: ABdhPJxSZ2ozkEJDjJJ/GIC4/dLfUlCpm5phPYEi7LxsaHDGv1ydP+J0ohhUW6ao5MAeYHGvqbOb7w==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr3110571ljg.291.1607074414057;
        Fri, 04 Dec 2020 01:33:34 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v7sm1501987lfd.235.2020.12.04.01.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:33:33 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl7Ta-0005N3-Bi; Fri, 04 Dec 2020 10:34:07 +0100
Date:   Fri, 4 Dec 2020 10:34:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 04/15] usb: serial: cp210x: use usb_control_msg_recv()
 and usb_control_msg_send()
Message-ID: <X8oCjmT1czYZfL3k@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-5-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-5-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:16:52PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
> usb_control_msg() with proper error check. Hence use the wrappers
> instead of calling usb_control_msg() directly.

This too is a good example of when the new helpers can be used, but
please mention the transfer buffers here are that is the primary reason.

> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/cp210x.c | 148 ++++++++++--------------------------
>  1 file changed, 42 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index d0c05aa8a0d6..29436ab392e8 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -555,31 +555,15 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
>  {
>  	struct usb_serial *serial = port->serial;
>  	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
> -	void *dmabuf;
>  	int result;
>  
> -	dmabuf = kmalloc(bufsize, GFP_KERNEL);
> -	if (!dmabuf) {
> -		/*
> -		 * FIXME Some callers don't bother to check for error,
> -		 * at least give them consistent junk until they are fixed
> -		 */
> -		memset(buf, 0, bufsize);
> -		return -ENOMEM;
> -	}
> -
> -	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
> -			req, REQTYPE_INTERFACE_TO_HOST, 0,
> -			port_priv->bInterfaceNumber, dmabuf, bufsize,
> -			USB_CTRL_SET_TIMEOUT);
> -	if (result == bufsize) {
> -		memcpy(buf, dmabuf, bufsize);
> -		result = 0;
> -	} else {
> +	result = usb_control_msg_recv(serial->dev, 0, req,
> +				      REQTYPE_INTERFACE_TO_HOST, 0,
> +				      port_priv->bInterfaceNumber, buf, bufsize,
> +				      USB_CTRL_SET_TIMEOUT, GFP_KERNEL);

Please keep the existing indentation style. That way you don't need to
change the middle-two argument lines just to align the arguments.

> +	if (result) {
>  		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
> -				req, bufsize, result);
> -		if (result >= 0)
> -			result = -EIO;
> +			req, bufsize, result);

Nit: This is an unrelated indentation change.

>  
>  		/*
>  		 * FIXME Some callers don't bother to check for error,
> @@ -588,8 +572,6 @@ static int cp210x_read_reg_block(struct usb_serial_port *port, u8 req,
>  		memset(buf, 0, bufsize);
>  	}
>  
> -	kfree(dmabuf);
> -
>  	return result;
>  }
>  
> @@ -648,29 +630,16 @@ static int cp210x_read_u8_reg(struct usb_serial_port *port, u8 req, u8 *val)
>  static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
>  				    void *buf, int bufsize)
>  {
> -	void *dmabuf;
>  	int result;
>  
> -	dmabuf = kmalloc(bufsize, GFP_KERNEL);
> -	if (!dmabuf)
> -		return -ENOMEM;
> -
> -	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
> -				 CP210X_VENDOR_SPECIFIC, type, val,
> -				 cp210x_interface_num(serial), dmabuf, bufsize,
> -				 USB_CTRL_GET_TIMEOUT);
> -	if (result == bufsize) {
> -		memcpy(buf, dmabuf, bufsize);
> -		result = 0;
> -	} else {
> +	result = usb_control_msg_recv(serial->dev, 0, CP210X_VENDOR_SPECIFIC,
> +				      type, val, cp210x_interface_num(serial),
> +				      buf, bufsize, USB_CTRL_GET_TIMEOUT,
> +				      GFP_KERNEL);
> +	if (result)
>  		dev_err(&serial->interface->dev,
>  			"failed to get vendor val 0x%04x size %d: %d\n", val,
>  			bufsize, result);
> -		if (result >= 0)
> -			result = -EIO;
> -	}

Nit: Please keep the brackets around multiline single statements since
it improves readability.

Similar comments apply to the rest of the patch.

Johan
