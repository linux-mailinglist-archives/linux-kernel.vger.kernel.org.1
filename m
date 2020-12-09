Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417522D4062
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgLIKzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:55:24 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42203 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgLIKzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:55:23 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so2460122lfd.9;
        Wed, 09 Dec 2020 02:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KKtaW+EJ/u5lyosZlvWzKSgMz1fByaQ+6p7eGvxRUu4=;
        b=X0lfKpJRN23CioQBBnq9NbrGz5l5td1wI+znBvR/R5pjsTj8HhNe+q/ErxsiavtK/U
         v3re5iKhwmGYL5ludQRiuOx1IteI3CrGG2+ls8xOcRl/WtaYhfUDUBaoC3RK+8goTbSh
         O5lvCQhWEThxWmP1+thy4ytaJeZQw0CZnxUQIlA6erzKSIDPuKkGfJm+ktOvgHbRZuC1
         k4zWMFt1MThjsF+P1lX/Lp8YsNhs4NzO6UPLzGI64jPhvYOpaJLJ4x9OB6Q74R38DxGP
         WAyMBESQO0RMluXRARD/F8T9OknFp56xd7EGynX8DwGA8+lrdzZTF1c0wXTi3T1Uaqe7
         FBxg==
X-Gm-Message-State: AOAM532ORSxuUF6ttKXh+Plht0giBwNoNCkdQWF5wj5yL5r4xeZdtz47
        tb9EMmABnIgRU1LWrgCx4jxE+g/xENah1Q==
X-Google-Smtp-Source: ABdhPJxx4+5KfKBg+UtmANoVo2Cn5fYcoo6mTkFjdu6X2drCggKSRWMjLjMz4Th7vzR6zS9mj6QU/w==
X-Received: by 2002:a19:a57:: with SMTP id 84mr809618lfk.327.1607511281108;
        Wed, 09 Dec 2020 02:54:41 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id n6sm132788lfi.106.2020.12.09.02.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 02:54:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kmx7w-0003WA-C6; Wed, 09 Dec 2020 11:55:21 +0100
Date:   Wed, 9 Dec 2020 11:55:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: serial: simplify the ark3116_write_reg()
Message-ID: <X9CtGBNfVIZV2eT6@localhost>
References: <20201209092917.20681-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209092917.20681-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 05:29:17PM +0800, Zheng Yongjun wrote:
> Simplify the return expression.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/usb/serial/ark3116.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
> index 71a9206ea1e2..0f9fa0e7c50e 100644
> --- a/drivers/usb/serial/ark3116.c
> +++ b/drivers/usb/serial/ark3116.c
> @@ -77,16 +77,11 @@ struct ark3116_private {
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

Since none of the callers bother to check for errors, how about you add
a dev_err() here similar to the one in ark3116_read_reg() instead?

> -
> -	return 0;

Keeping the explicit zero-return on success has the benefit of allowing
the casual developer to know what to expect when using this helper
without having to read the documentation (or implementation) of
usb_control_msg().

> +	return usb_control_msg(serial->dev,
> +			       usb_sndctrlpipe(serial->dev, 0),
> +			       0xfe, 0x40, val, reg,
> +			       NULL, 0, ARK_TIMEOUT);
>  }
>  
>  static int ark3116_read_reg(struct usb_serial *serial,

Johan
