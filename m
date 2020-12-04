Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1F02CEA9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbgLDJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:16:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35531 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgLDJQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:16:17 -0500
Received: by mail-lf1-f65.google.com with SMTP id a9so6736124lfh.2;
        Fri, 04 Dec 2020 01:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2w+hvHmoycBrYqhlFBPhlUg+uer0Xd0qnW1dlujjKZg=;
        b=NsJzkGIRA00LoB+SDMrXafFq9gg3HU566XU3SOS0mJqzCAuVeOaTzbsMFZQayEtRwQ
         MytpbIJ/nUIKJw5zPQQF2TrJEYC0nULipUkRAL4m6+S28hf3KMlpMJTiZ6XuCkyEt4P0
         NfvgkuIAIn8+IShMJDjKFhF2LIxgf8/sUU+6aeGsTwUfnC5GeB0D1tXsbL2RGc9KAa6w
         vIvin5Dz7WNIDD7yUakMdiq7BQiwl6OZYg378JbvFByUHJ77LdY8eWQD+xEi0oVC3ElU
         Wwy3hxjyd8gZjlQMf65JBU6uhNxMImi0mkY2xjsMSrH2vzTYzBMjkTSAvS1lUknKxf4g
         OMjQ==
X-Gm-Message-State: AOAM532jRQg2MLorpQHYqPP4bQP96/IqHM0mB4IZpeyeceCkwFIiYNHk
        camxZUI3W0G+az+fExhBLI4aVmxSczwTWA==
X-Google-Smtp-Source: ABdhPJxWJyXBi10AP5Y1K8KMe0RN7psz/1ldOU0zysNkCpLIsFp8UZqti4yVZ3ezL9i2vyOegmeJYA==
X-Received: by 2002:a19:ec09:: with SMTP id b9mr3098138lfa.178.1607073334899;
        Fri, 04 Dec 2020 01:15:34 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f18sm1474034lfc.198.2020.12.04.01.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:15:34 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl7CB-0005KA-Or; Fri, 04 Dec 2020 10:16:07 +0100
Date:   Fri, 4 Dec 2020 10:16:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 01/15] usb: serial: ark3116: use usb_control_msg_recv()
 and usb_control_msg_send()
Message-ID: <X8n+V22wFnUEy69N@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-2-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-2-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:16:49PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
> usb_control_msg() with proper error check. Hence use the wrappers
> instead of calling usb_control_msg() directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/ark3116.c | 29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
> index 71a9206ea1e2..51302892c779 100644
> --- a/drivers/usb/serial/ark3116.c
> +++ b/drivers/usb/serial/ark3116.c
> @@ -77,38 +77,17 @@ struct ark3116_private {
>  static int ark3116_write_reg(struct usb_serial *serial,
>  			     unsigned reg, __u8 val)
>  {
> -	int result;
>  	 /* 0xfe 0x40 are magic values taken from original driver */
> -	result = usb_control_msg(serial->dev,
> -				 usb_sndctrlpipe(serial->dev, 0),
> -				 0xfe, 0x40, val, reg,
> -				 NULL, 0, ARK_TIMEOUT);
> -	if (result)
> -		return result;
> -
> -	return 0;
> +	return usb_control_msg_send(serial->dev, 0, 0xfe, 0x40, val, reg, NULL, 0,
> +				    ARK_TIMEOUT, GFP_KERNEL);

For control transfers without a data stage there's no point in using
usb_control_msg_send() as it already returns a negative errno on error
or 0 on success.

>  }
>  
>  static int ark3116_read_reg(struct usb_serial *serial,
>  			    unsigned reg, unsigned char *buf)
>  {
> -	int result;
>  	/* 0xfe 0xc0 are magic values taken from original driver */
> -	result = usb_control_msg(serial->dev,
> -				 usb_rcvctrlpipe(serial->dev, 0),
> -				 0xfe, 0xc0, 0, reg,
> -				 buf, 1, ARK_TIMEOUT);
> -	if (result < 1) {
> -		dev_err(&serial->interface->dev,
> -				"failed to read register %u: %d\n",
> -				reg, result);
> -		if (result >= 0)
> -			result = -EIO;
> -
> -		return result;
> -	}
> -
> -	return 0;
> +	return usb_control_msg_recv(serial->dev, 0, 0xfe, 0xc0, 0, reg, buf, 1,
> +				    ARK_TIMEOUT, GFP_KERNEL);

This driver already use a DMA-able transfer buffer which is allocated
once and then passed to this helper repeatedly. This change would
introduce additional redandant memdup + memcpy for every call and for no
real gain.

You also have an unrelated change here as you simply remove an existing
error message.

Please drop this patch.

Johan
