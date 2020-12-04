Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0439D2CEB0D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbgLDJiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:38:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45485 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387584AbgLDJiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:38:03 -0500
Received: by mail-lf1-f65.google.com with SMTP id z21so6759338lfe.12;
        Fri, 04 Dec 2020 01:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rCis0KUuTW9MGXUF26gw5+ReaZfnt50i53XCblKc1Wc=;
        b=U5jxWijhIx5rCV0EoGvv+g98pop9GOElmKxE3ExecRKyZuQTigy89Fhn/PL9mZ0baU
         3LNYqcdE3JbvthoFAX0Rj5nc2s92CyZC8QrK/Gm38P2lS7tx+C08g6T3ZBCWHUPFHqT6
         wJ1Gno1T9vbX1P0WmQhu+VwPEj/DQcUXPdie5E/YoeJAO+5JZfX7I8XgQwrcMvWZONKN
         nSSS0kIemxsrc6tRAnoBZzRwl0WeP1Gd06yPTvaNeug372hTQeqCJ0mfiARFOBN+1KS+
         GWsQZDUEMcC/e+SZVc1XmRLVPIRrA/k8vBjlopW+/fChgERbx2V7Gze+xBhog+d0TGuV
         m+DA==
X-Gm-Message-State: AOAM531DHcZ/JRSyFVdTNyciPPTXD9GnZVZNqKzPzmOvjJYQvS+LYytd
        Mn9z45etmI//SVM1Pt5+Jwk=
X-Google-Smtp-Source: ABdhPJylHu3wEWK+g+aeq+PFtsJgpSrucwZEYGSqo2cpTcXTOSxrbVnYcNp1CRlFhYPcZT6/WnGu3Q==
X-Received: by 2002:ac2:50d2:: with SMTP id h18mr2723674lfm.169.1607074633924;
        Fri, 04 Dec 2020 01:37:13 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id m28sm1491799lfo.10.2020.12.04.01.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:37:13 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl7X8-0005Ni-UI; Fri, 04 Dec 2020 10:37:47 +0100
Date:   Fri, 4 Dec 2020 10:37:46 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 05/15] usb: serial: cypress_m8: use
 usb_control_msg_recv() and usb_control_msg_send()
Message-ID: <X8oDaiqW2K+t69JI@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-6-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-6-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:16:53PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
> usb_control_msg() with proper error check. Hence use the wrappers
> instead of calling usb_control_msg() directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/cypress_m8.c | 38 +++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
> index cc028601c388..4d66cab8eece 100644
> --- a/drivers/usb/serial/cypress_m8.c
> +++ b/drivers/usb/serial/cypress_m8.c
> @@ -341,20 +341,21 @@ static int cypress_serial_control(struct tty_struct *tty,
>  			feature_buffer[4]);
>  
>  		do {
> -			retval = usb_control_msg(port->serial->dev,
> -					usb_sndctrlpipe(port->serial->dev, 0),
> -					HID_REQ_SET_REPORT,
> -					USB_DIR_OUT | USB_RECIP_INTERFACE | USB_TYPE_CLASS,
> -					0x0300, 0, feature_buffer,
> -					feature_len, 500);
> +			retval = usb_control_msg_send(port->serial->dev, 0,
> +						      HID_REQ_SET_REPORT,
> +						      USB_DIR_OUT |
> +						      USB_RECIP_INTERFACE |
> +						      USB_TYPE_CLASS, 0x0300,
> +						      0, feature_buffer,
> +						      feature_len, 500,
> +						      GFP_KERNEL);
>  
>  			if (tries++ >= 3)
>  				break;
>  
> -		} while (retval != feature_len &&
> -			 retval != -ENODEV);
> +		} while (retval != -ENODEV);

Here you actually break the logic; after this change the driver will
always retry as the test for success is removed.

>  
> -		if (retval != feature_len) {
> +		if (retval) {
>  			dev_err(dev, "%s - failed sending serial line settings - %d\n",
>  				__func__, retval);
>  			cypress_set_dead(port);
> @@ -379,19 +380,20 @@ static int cypress_serial_control(struct tty_struct *tty,
>  		}
>  		dev_dbg(dev, "%s - retrieving serial line settings\n", __func__);
>  		do {
> -			retval = usb_control_msg(port->serial->dev,
> -					usb_rcvctrlpipe(port->serial->dev, 0),
> -					HID_REQ_GET_REPORT,
> -					USB_DIR_IN | USB_RECIP_INTERFACE | USB_TYPE_CLASS,
> -					0x0300, 0, feature_buffer,
> -					feature_len, 500);
> +			retval = usb_control_msg_recv(port->serial->dev, 0,
> +						      HID_REQ_GET_REPORT,
> +						      USB_DIR_IN |
> +						      USB_RECIP_INTERFACE |
> +						      USB_TYPE_CLASS, 0x0300,
> +						      0, feature_buffer,
> +						      feature_len, 500,
> +						      GFP_KERNEL);
>  
>  			if (tries++ >= 3)
>  				break;
> -		} while (retval != feature_len
> -						&& retval != -ENODEV);
> +		} while (retval != -ENODEV);

Same here.

>  
> -		if (retval != feature_len) {
> +		if (retval) {
>  			dev_err(dev, "%s - failed to retrieve serial line settings - %d\n",
>  				__func__, retval);
>  			cypress_set_dead(port);

As the driver is already using a DMA-able buffer and is reusing it for
every retry as well, this change is now introducing redundant memdup +
memcpy for each call.

I suggest just dropping this one.

Johan
