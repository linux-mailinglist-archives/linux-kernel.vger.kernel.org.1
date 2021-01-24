Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24563301D47
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbhAXPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 10:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbhAXPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 10:44:20 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95408C061574;
        Sun, 24 Jan 2021 07:43:40 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 63so10302841oty.0;
        Sun, 24 Jan 2021 07:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OqwvTJLGtu4pJpQ/5EdykNUW6RSfQ1alfn8/LK/4nB8=;
        b=WP9QhpLdTwUXVEqqc1dhfhU91+loHYSl6PoX1B/brVPFjQK7TgJsVcYNV15LD0FvRt
         RJulQpioAZUbVZSXFEoqcBf3KHalFdl1GDH1nVYn5lhZvrKAp2GAokhgFgKK6v3PXzOU
         xHhN26+EssGrbRaatjD0kvAX53olWc7cczwvxQXBArFPZan3eH0jSJgsXdZ9CffDclrP
         ZKXXWJYXSsKv1u4RfigDKfBzrBuzFWNNRNAYw2QLA0F9XdRO/nY0IDU+gRj0hEB9aj/G
         oNYvhNFozcPfdlIAOQMN2luSuXNJ29XyoZjUEqRqymhWrieLk6hmsWJekc044m+7EEW/
         jXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OqwvTJLGtu4pJpQ/5EdykNUW6RSfQ1alfn8/LK/4nB8=;
        b=KKtxDlG0Yg5HbFk5/7/ay82eK9uhVT51t3HIN2DkB+Dhtq+vo7U/K6ap4Fdf98NqWv
         EqNymlYb2Ce3IX9BvQ1NA6huybXTTsYiqGUV2RIXxRtZB6fWzKNwXNeINoKYpSdOkTKX
         Hj/ogOFhiDDoqRdyTYyP3tEwYUpbjI2wGPreblBsKm0MF7+9kE7sGHZcwf0hZ1HePCs5
         oxdck1LjE8/ZfHLv2klcyJzitNysOHg6KEZdEPMbHfGTymNcdT+Zo39YKI0hcH89IpVq
         pQ9Jkg4KUCHUKvMI4sDP88s05L8VszWAa/VzfywJXZmSijC9Po64J2IPO1DhOmo+sY2g
         waxg==
X-Gm-Message-State: AOAM530braYw5sQV4O6+1Vhrul4TOENQ4SO0sLG7N/wh4UTlz1uhOPO1
        9GwxKiRwJs2QT1f1VIe42Z8=
X-Google-Smtp-Source: ABdhPJyCyZ2Ku/WNOwAhTL/IevsEKD5XapdgFZoajoJm7btAi7Gcg55vQrFBpGsPXSFWmNJ6JC6oBw==
X-Received: by 2002:a05:6830:1f02:: with SMTP id u2mr9895300otg.124.1611503020098;
        Sun, 24 Jan 2021 07:43:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m10sm910815otp.19.2021.01.24.07.43.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jan 2021 07:43:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 24 Jan 2021 07:43:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     angkery <angkery@163.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: Re: [PATCH v3 1/2] usb: typec: tcpci_maxim: remove redundant
 assignment
Message-ID: <20210124154338.GB131753@roeck-us.net>
References: <20210124143853.1630-1-angkery@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124143853.1630-1-angkery@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 10:38:53PM +0800, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> PTR_ERR(chip->tcpci) has been used as a return value,
> it is not necessary to assign it to ret, so remove it.
> 
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v3:remove the newline modification.
> 
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index 3192663..7f54f51a 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -461,7 +461,6 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
>  	if (IS_ERR(chip->tcpci)) {
>  		dev_err(&client->dev, "TCPCI port registration failed");
> -		ret = PTR_ERR(chip->tcpci);
>  		return PTR_ERR(chip->tcpci);
>  	}
>  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
> -- 
> 1.9.1
> 
