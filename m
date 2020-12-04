Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FCA2CEC2B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgLDK2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:28:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33088 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgLDK2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:28:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id t22so6044470ljk.0;
        Fri, 04 Dec 2020 02:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PMQ7u80c2VYDiQqBDklziVDIGD3Rre753uPc1a1D44s=;
        b=lK0hwd3OytS3xorrOKRSPrc0EJZrqQCqPEL+baeOUg9wGI0TZ/N56ionJZxytTAWPK
         Kr32x6j28I1yPDfJBMtoGVXKK22K3kNv2aeyXfAmtg/LUKcH9PfqGn3ILSbxxkco7prF
         actuRlsO++6H+e0OpAsdjhXNJ7rI/7/lDk9FNsc9sbBQDVsFey0StOOfLJlG0pA1smpm
         i7a1kTICQQJg29IF0WtkqhS7ClNXRrcrggDoAE0KcvJn0w4rkyRAXDftwpcEqfB4+2bl
         3kZeVIqKetLGmEfwfSfDXclypOnYRG3CxgN36Zu9jBjtENtB407FyuMQidmn7EWVThtA
         C5hQ==
X-Gm-Message-State: AOAM532IEXJaBJkmNEhJD8+pWEEMs9zxKXMkRUUz9FJxJnW4FuTCem81
        /fr9uYDoJ8iwUeQtq7H9vuw=
X-Google-Smtp-Source: ABdhPJxpsPWDqJtU0JgHWhhn2H2mShfTxc3V/9p2u9VkBOuuOSwq9LyWVwsNakGu1sS/PmOu6zbB+Q==
X-Received: by 2002:a2e:b8d0:: with SMTP id s16mr3020770ljp.423.1607077687709;
        Fri, 04 Dec 2020 02:28:07 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id c5sm1518163lfg.84.2020.12.04.02.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:28:06 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl8KO-0005WV-Qi; Fri, 04 Dec 2020 11:28:40 +0100
Date:   Fri, 4 Dec 2020 11:28:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 13/15] usb: serial: iuu_phoenix: use
 usb_control_msg_send()
Message-ID: <X8oPWJZRbaY8yMOo@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-14-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-14-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:17:01PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_send() nicely wraps usb_control_msg() with proper
> error check. Hence use the wrapper instead of calling usb_control_msg()
> directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/iuu_phoenix.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
> index b4ba79123d9d..dfbcdcec94e7 100644
> --- a/drivers/usb/serial/iuu_phoenix.c
> +++ b/drivers/usb/serial/iuu_phoenix.c
> @@ -968,9 +968,8 @@ static int iuu_open(struct tty_struct *tty, struct usb_serial_port *port)
>  	priv->poll = 0;
>  
>  #define SOUP(a, b, c, d)  do { \
> -	result = usb_control_msg(port->serial->dev,	\
> -				usb_sndctrlpipe(port->serial->dev, 0),	\
> -				b, a, c, d, NULL, 0, 1000); \
> +	result = usb_control_msg_send(port->serial->dev, 0, b, a, c, d, NULL,\
> +				      0, 1000, GFP_KERNEL);		     \

No need to for this either even if the result was used for anything else
but logging (since there's no data stage).

>  	dev_dbg(dev, "0x%x:0x%x:0x%x:0x%x  %d\n", a, b, c, d, result); } while (0)
>  
>  	/*  This is not UART related but IUU USB driver related or something */

Please drop.

Johan
