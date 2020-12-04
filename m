Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBBF2CEC13
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbgLDKVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:21:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42204 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:21:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id f18so5961818ljg.9;
        Fri, 04 Dec 2020 02:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a0BVq/8+rbtsg3qPMhtrFzNWCEofj0oNI2sqBIVwRfo=;
        b=jRjJt938rjudDKzMoliFQaKpd6AtCjr0r4Y+4h/oVmLFjto66FB0Cr4R5ftKUqkafN
         DFVnEO6/XakL3lLi6w/6GxETzBvOl7O4XEjmyMVgUT0WO4wEt4Z0LwRvPP/OoB7sBJsc
         4KOnQjaoaKxAddquRPkEg+1eriKtaIlIz0qpiiPyTNifiQoOUawRTprnp6aQsvW8VdLL
         wBOjcZYpVWTb04LMRP6ehXurh6V+MXd9Ynu19cwCQlls1cthJnHMVzfj8UOkDxuZMStt
         9YaNOsmy4tW05CmVmwctBzFkyHxn9AlHO1QcNZRjkuQ7yTnPC7iH136e1P3GKsi7RF3E
         kMqA==
X-Gm-Message-State: AOAM532hdXr9cKC1z/ZrO5NGEInWO/9SyPey7SHi/zbx5smlB3FqVIeq
        4DE6sSJffWn/VsmgwB1OeawC/JC1AesRlw==
X-Google-Smtp-Source: ABdhPJxPAH6U1wJrzpl6j1KpYHCehaPNd9PCr78xefaXFZ4888tZ9LAe9Rz7q49UWF+1a72SXa472A==
X-Received: by 2002:a2e:6c07:: with SMTP id h7mr2966516ljc.464.1607077233625;
        Fri, 04 Dec 2020 02:20:33 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id l26sm1564594ljb.92.2020.12.04.02.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:20:32 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl8D4-0005V1-19; Fri, 04 Dec 2020 11:21:06 +0100
Date:   Fri, 4 Dec 2020 11:21:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 11/15] usb: serial: ipaq: use usb_control_msg_send()
Message-ID: <X8oNktd8Q0U+PlWO@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-12-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-12-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:16:59PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_send() nicely wraps usb_control_msg() with proper
> error check. Hence use the wrapper instead of calling usb_control_msg()
> directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/ipaq.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
> index f81746c3c26c..99505a76035d 100644
> --- a/drivers/usb/serial/ipaq.c
> +++ b/drivers/usb/serial/ipaq.c
> @@ -530,15 +530,14 @@ static int ipaq_open(struct tty_struct *tty,
>  	 */
>  	while (retries) {
>  		retries--;
> -		result = usb_control_msg(serial->dev,
> -				usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
> -				0x1, 0, NULL, 0, 100);
> -		if (!result)
> +		result = usb_control_msg_send(serial->dev, 0, 0x22, 0x21, 0x1,
> +					      0, NULL, 0, 100, GFP_KERNEL);
> +		if (result == 0)
>  			break;

There's not point in using the new helper since there's no data stage
and usb_control_msg already returns negative errno or 0.

>  		msleep(1000);
>  	}
> -	if (!retries && result) {
> +	if (result) {
>  		dev_err(&port->dev, "%s - failed doing control urb, error %d\n",
>  							__func__, result);
>  		return result;

This looks like just an unrelated simplification of the logic; there was
never any need to check !retries here. You can send that as a clean up
patch of its own if you want.

Johan
