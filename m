Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4FC2CEC4E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgLDKho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:37:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36932 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLDKhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:37:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id s30so7003178lfc.4;
        Fri, 04 Dec 2020 02:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dnb2g8Upo0FOr6S0AYAIulpRk5vFPv7InqWLqIi5s84=;
        b=PruY8lz00BPv1JTHifgS0MnHjzCBmy/r2oIvAluLNlp8zWNpzm+GitH9RIKludls6o
         ANQdsPDV+TN4oKeqP9WTD5XCUVjbdzfRPUTauDfQfLPZJ2C9scZG1ruDNkFdjMpWrCOu
         f5Hqm25nkQcmINrGdQ92Jgn+tLEnsoov7hTYYiabK1Q44QycS7absg8arnjFIu8QuKcS
         IKMSPGuJr8DzcDWhKEv176/lmb/mv1DcIWF4shI3SXrRTGAruWwsSliujASrVapEKX2O
         rQH5AoBUHHHLT5kVCYDfQ6jGuklcF6dEefr889ndsIdszC6VtwYcgw4xkCD4dUZzKSLs
         9/XQ==
X-Gm-Message-State: AOAM531J16+osAZXhSLSXxkMZ82oloPSlIODJ3GDcul9XsrOLtrDRNft
        lTU5ZUkYEmHhTRVGiocz7C0=
X-Google-Smtp-Source: ABdhPJyKpnuk/F7WOaI0Az5g7xR+VlkpKJieo8R7MQrmtuwfHLh7EGRuWYrxZ9eszx366qpVngQJnQ==
X-Received: by 2002:ac2:4d94:: with SMTP id g20mr2829254lfe.512.1607078221220;
        Fri, 04 Dec 2020 02:37:01 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id p15sm1539338lfk.111.2020.12.04.02.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:37:00 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl8Sz-0005Xp-MK; Fri, 04 Dec 2020 11:37:34 +0100
Date:   Fri, 4 Dec 2020 11:37:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 15/15] usb: serial: kl5kusb105: use
 usb_control_msg_recv() and usb_control_msg_send()
Message-ID: <X8oRbaWuSoZSRAT8@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-16-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-16-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:17:03PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
> usb_control_msg() with proper error check. Hence use the wrappers
> instead of calling usb_control_msg() directly
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/kl5kusb105.c | 94 +++++++++++++++------------------
>  1 file changed, 44 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
> index 5ee48b0650c4..75cfd1c907f3 100644
> --- a/drivers/usb/serial/kl5kusb105.c
> +++ b/drivers/usb/serial/kl5kusb105.c
> @@ -124,16 +124,17 @@ static int klsi_105_chg_port_settings(struct usb_serial_port *port,
>  {
>  	int rc;
>  
> -	rc = usb_control_msg(port->serial->dev,
> -			usb_sndctrlpipe(port->serial->dev, 0),
> -			KL5KUSB105A_SIO_SET_DATA,
> -			USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_INTERFACE,
> -			0, /* value */
> -			0, /* index */
> -			settings,
> -			sizeof(struct klsi_105_port_settings),
> -			KLSI_TIMEOUT);
> -	if (rc < 0)
> +	rc = usb_control_msg_send(port->serial->dev, 0,
> +				  KL5KUSB105A_SIO_SET_DATA,
> +				  USB_TYPE_VENDOR | USB_DIR_OUT |
> +				  USB_RECIP_INTERFACE,
> +				  0, /* value */
> +				  0, /* index */
> +				  settings,
> +				  sizeof(struct klsi_105_port_settings),
> +				  KLSI_TIMEOUT,
> +				  GFP_KERNEL);
> +	if (rc)
>  		dev_err(&port->dev,
>  			"Change port settings failed (error = %d)\n", rc);

The callers of this function already allocates a transfer-buffer which
you should now remove to avoid introducing an additional memdup() per
call.

Note that there was a related bug in open() which failed to release it's
transfer buffer on successful open. I CCed you on the fix which we
should get merged and backported before converting to using the new
helper.

> @@ -283,16 +276,17 @@ static int  klsi_105_open(struct tty_struct *tty, struct usb_serial_port *port)
>  		goto err_free_cfg;
>  	}
>  
> -	rc = usb_control_msg(port->serial->dev,
> -			     usb_sndctrlpipe(port->serial->dev, 0),
> -			     KL5KUSB105A_SIO_CONFIGURE,
> -			     USB_TYPE_VENDOR|USB_DIR_OUT|USB_RECIP_INTERFACE,
> -			     KL5KUSB105A_SIO_CONFIGURE_READ_ON,
> -			     0, /* index */
> -			     NULL,
> -			     0,
> -			     KLSI_TIMEOUT);
> -	if (rc < 0) {
> +	rc  = usb_control_msg_send(port->serial->dev, 0,
> +				   KL5KUSB105A_SIO_CONFIGURE,
> +				   USB_TYPE_VENDOR | USB_DIR_OUT |
> +				   USB_RECIP_INTERFACE,
> +				   KL5KUSB105A_SIO_CONFIGURE_READ_ON,
> +				   0, /* index */
> +				   NULL,
> +				   0,
> +				   KLSI_TIMEOUT,
> +				   GFP_KERNEL);
> +	if (rc) {

And again there's no need to change the control transfers without a data
stage.

Johan
