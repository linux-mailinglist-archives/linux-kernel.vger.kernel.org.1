Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C291D2CEC43
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgLDKbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:31:47 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43047 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgLDKbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:31:46 -0500
Received: by mail-lf1-f66.google.com with SMTP id q13so6969841lfr.10;
        Fri, 04 Dec 2020 02:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p7ZO64XFAqlynf54Tsh5NtxeNVFHw07zw3NM66Di12Y=;
        b=beWjM6Iu8GBzDN7wwobTDm3OrE05XjlUs+qhPQCD6V0/w0Ly9BjJm8/Nga8423WIYU
         2EtX+InEWmP78ESc2WEtxsGS9wvE4nmcUOADijxZT6N/kXIv2fII+IsfOK95hge1ANgI
         S9YOitVoQtdGDKXu+wvGmll88Oea6oMJSKDVKcjA4mLd7hYtMiPwVE5lkaGfB1LLKGGx
         JJXG7kZ3PxeJnzGg8+i6NBVA99OITdfus2nHPipOflbcudTcEP65qP4uxe+2AYdkCjx1
         1l+V2AHKmePi4AhnyOhkY5MhZ/vOIvW8mUAEO9QWuxn9kYMvuVP48ejTWZCjNMnGOl/w
         dm7g==
X-Gm-Message-State: AOAM533WcnqwQzL7GeY2W8QP0Ddrxv98IHbWEselq84adTjmO6Ib/uE8
        qnCjIUY90vsqG768kHJYTjA=
X-Google-Smtp-Source: ABdhPJxZlkAasnp0Gofo2Z64k1d8USZDkxteQ7WmXWfbNOb35uAB6yTX2tqQGa2/HNy76uA6RGIZYw==
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr2972715lfe.412.1607077864198;
        Fri, 04 Dec 2020 02:31:04 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id h11sm1567111ljl.123.2020.12.04.02.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:31:03 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl8NF-0005X3-9A; Fri, 04 Dec 2020 11:31:37 +0100
Date:   Fri, 4 Dec 2020 11:31:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 14/15] usb: serial: keyspan_pda: use
 usb_control_msg_recv() and usb_control_msg_send()
Message-ID: <X8oQCfGmITiKVvfI@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-15-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-15-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:17:02PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
> usb_control_msg() with proper error check. Hence use the wrappers
> instead of calling usb_control_msg() directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/keyspan_pda.c | 172 +++++++++++++------------------
>  1 file changed, 72 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
> index c1333919716b..44e1c4490fa9 100644
> --- a/drivers/usb/serial/keyspan_pda.c
> +++ b/drivers/usb/serial/keyspan_pda.c

There were some changes done to this driver around the same time that
you submitted these so this one needs to be rebased.

> @@ -359,22 +361,11 @@ static int keyspan_pda_get_modem_info(struct usb_serial *serial,
>  				      unsigned char *value)
>  {
>  	int rc;
> -	u8 *data;
> -
> -	data = kmalloc(1, GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> -
> -	rc = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
> -			     3, /* get pins */
> -			     USB_TYPE_VENDOR|USB_RECIP_INTERFACE|USB_DIR_IN,
> -			     0, 0, data, 1, 2000);
> -	if (rc == 1)
> -		*value = *data;
> -	else if (rc >= 0)
> -		rc = -EIO;
> -
> -	kfree(data);
> +	rc = usb_control_msg_recv(serial->dev, 0,
> +				  3, /* get pins */
> +				  USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
> +				  USB_DIR_IN, 0, 0, value, 1, 2000,
> +				  GFP_KERNEL);
>  	return rc;
>  }

Please only change the requests with a data stage like this one, but
avoid breaking the request argument over multiple lines.

Johan
