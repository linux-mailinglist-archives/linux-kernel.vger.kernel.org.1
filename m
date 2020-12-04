Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F72CEB7E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgLDJ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:56:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36668 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgLDJ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:56:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id a1so4576182ljq.3;
        Fri, 04 Dec 2020 01:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KR7bvZk9IL0aVDrbxk4V05QNkr638YolAIwhooQDGYw=;
        b=SLz70pkvYSPiw8T9+rXImQMdadAiemzeNeM6PtS1s3au+XWjIhvU4xDxttxoURP9Bh
         WGrBtDn2g5hgwGH14X74hGo4AehWSWQh/soaqyVpfDd1X0gedIcAbjnldAlSiq1nAD6+
         R33QXL49+xouYo4DleuVJh5UTk4uHwSBl/vZ5ZqXJwdKPQIPDF9Jl97JtHSi9XHwC6pX
         D9mAiXLClsvjnwYS/VQytJ6Ar31IkQk6VX0UmaAsCMf51E7kpMOnZtMLSboCtc+dUcSs
         6kSrtBlSzt705efFBn+FxkJbIEhmQGTd2tWb8n0igaQ9GkQe7cmqfpxFd+Gg5Dn8kNQq
         PB3g==
X-Gm-Message-State: AOAM532bC4scZZixv45U9chJsUAbRclY4tAvKheZvcOPtI9hasfHfzE9
        gDKTRkkDrZUjY5zaQaFLC+o=
X-Google-Smtp-Source: ABdhPJwYmkZIAkj2nS8w7vSQfiok7d0nOZTQfC3LwYpXyrsx61HYASrW0XIagI6VSqfdyyUVNwyf4Q==
X-Received: by 2002:a05:651c:1195:: with SMTP id w21mr3043489ljo.427.1607075724025;
        Fri, 04 Dec 2020 01:55:24 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f21sm1545449ljk.0.2020.12.04.01.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:55:23 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl7oi-0005Qc-D0; Fri, 04 Dec 2020 10:55:57 +0100
Date:   Fri, 4 Dec 2020 10:55:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 07/15] usb: serial: f81534: use usb_control_msg_recv()
 and usb_control_msg_send()
Message-ID: <X8oHrKbjAg3nnJ1n@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-8-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-8-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:16:55PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
> usb_control_msg() with proper error check. Hence use the wrappers
> instead of calling usb_control_msg() directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/f81534.c | 63 +++++++++++--------------------------
>  1 file changed, 18 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
> index 5661fd03e545..23eb17a2c052 100644
> --- a/drivers/usb/serial/f81534.c
> +++ b/drivers/usb/serial/f81534.c
> @@ -217,38 +217,26 @@ static int f81534_set_register(struct usb_serial *serial, u16 reg, u8 data)
>  	struct usb_device *dev = serial->dev;
>  	size_t count = F81534_USB_MAX_RETRY;
>  	int status;
> -	u8 *tmp;
> -
> -	tmp = kmalloc(sizeof(u8), GFP_KERNEL);
> -	if (!tmp)
> -		return -ENOMEM;
> -
> -	*tmp = data;
>  
>  	/*
>  	 * Our device maybe not reply when heavily loading, We'll retry for
>  	 * F81534_USB_MAX_RETRY times.
>  	 */
>  	while (count--) {
> -		status = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
> -					 F81534_SET_GET_REGISTER,
> -					 USB_TYPE_VENDOR | USB_DIR_OUT,
> -					 reg, 0, tmp, sizeof(u8),
> -					 F81534_USB_TIMEOUT);
> -		if (status > 0) {
> -			status = 0;
> -			break;
> -		} else if (status == 0) {
> -			status = -EIO;
> +		status = usb_control_msg_send(dev, 0, F81534_SET_GET_REGISTER,
> +					      USB_TYPE_VENDOR | USB_DIR_OUT,
> +					      reg, 0, &data, sizeof(u8),
> +					      F81534_USB_TIMEOUT, GFP_KERNEL);
> +		if (status) {
> +			/* Try again */
> +			continue;
>  		}
>  	}

Here too this change breaks the logic and the control transfer is now
repeated also after successful transfer (ten times!).

This change would also introduce an additional malloc + memcpy for every
retry.

As this is a function that is used often and the comment suggest that
having to retry isn't that rare, I suggest dropping this patch as well.

Johan
