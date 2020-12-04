Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF772CEBEA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbgLDKMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:12:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45376 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387621AbgLDKMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:12:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so5920389ljc.12;
        Fri, 04 Dec 2020 02:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jNdpZlqvqX5QAC5zu+Jn8FchOaK5H7Mm4a1A+uo1p1k=;
        b=rJKyHvEOzMCtlo5cEw4vmjZX3DQZockpRB3IyR7rZvM//sbeHpe2CcN9kEIqtKzaQm
         1lrZsdsxbu8WN2CyI6uYruV9UDhR2i1A+kOJW2rIiS78LAXqzBg37cwyWUNAlGmgDi2n
         Cz3FiZfrgJJiW03rDVU6jUpOo9eSmlz+XKCWi5eKlPvRL+JSBub9sAWucN91Prn56oBw
         CZyMHzkNqksLI+PehB2u1qzzr0ehvvoTjKbR5E/tfMkQHyfvSbwzkGV142c5H3mlbi2c
         cUf0eCs+AdNNs68bdfAB6h5yyZaH/TXPrUPRCmYndVoSEMIBhE/wAPQJcVedAwSBK5up
         XfeA==
X-Gm-Message-State: AOAM531RMY1oPjOmcm5eL41utYgmXS7sh4rQssbaty4GZxOVKPxtguhT
        JrgHS5nakhB3/KKhI99232THlqicGpdo9Q==
X-Google-Smtp-Source: ABdhPJzblxcq4NrwwVYrRtiu2nGfAmr8E7baDGxCAo7kG6rtaIRgH4XttaI1NcptI7i14Z1HXG92Gg==
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr2957726ljp.253.1607076702695;
        Fri, 04 Dec 2020 02:11:42 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id o72sm1514042lfa.278.2020.12.04.02.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:11:41 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl84V-0005TH-SF; Fri, 04 Dec 2020 11:12:15 +0100
Date:   Fri, 4 Dec 2020 11:12:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 10/15] usb: serial: io_ti: use usb_control_msg_recv() and
 usb_control_msg_send()
Message-ID: <X8oLf3cLChRjWqPp@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-11-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-11-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:16:58PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
> usb_control_msg() with proper error check. Hence use the wrappers
> instead of calling usb_control_msg() directly
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/io_ti.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
> index c327d4cf7928..ab2370b80b3c 100644
> --- a/drivers/usb/serial/io_ti.c
> +++ b/drivers/usb/serial/io_ti.c
> @@ -260,16 +260,12 @@ static int ti_vread_sync(struct usb_device *dev, __u8 request,
>  {
>  	int status;
>  
> -	status = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), request,
> -			(USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN),
> -			value, index, data, size, 1000);
> -	if (status < 0)
> +	status = usb_control_msg_recv(dev, 0, request, USB_TYPE_VENDOR |
> +				      USB_RECIP_DEVICE | USB_DIR_IN, value,
> +				      index, data, size, 1000, GFP_KERNEL);
> +	if (status)
>  		return status;
> -	if (status != size) {
> -		dev_dbg(&dev->dev, "%s - wanted to write %d, but only wrote %d\n",
> -			__func__, size, status);
> -		return -ECOMM;
> -	}
> +
>  	return 0;
>  }
>  
> @@ -278,16 +274,12 @@ static int ti_vsend_sync(struct usb_device *dev, u8 request, u16 value,
>  {
>  	int status;
>  
> -	status = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), request,
> -			(USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT),
> -			value, index, data, size, timeout);
> -	if (status < 0)
> +	status = usb_control_msg_send(dev, 0, request, USB_TYPE_VENDOR |
> +				      USB_RECIP_DEVICE | USB_DIR_OUT, value,
> +				      index, data, size, timeout, GFP_KERNEL);
> +	if (status)
>  		return status;
> -	if (status != size) {
> -		dev_dbg(&dev->dev, "%s - wanted to write %d, but only wrote %d\n",
> -			__func__, size, status);
> -		return -ECOMM;
> -	}
> +
>  	return 0;
>  }

These helper are only used with DMA-able buffers so this change
introduces an additional redundant allocation and memcpy for every call
for no real gain.

Please drop this one as well.

Johan
