Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08502301D49
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 16:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbhAXPol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 10:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbhAXPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 10:44:32 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FDAC061756;
        Sun, 24 Jan 2021 07:43:52 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 36so10292996otp.2;
        Sun, 24 Jan 2021 07:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4PVvv8WDdiwpkbAgHq2xQulkc2fQ/jZIWJlkAhfKQ8Y=;
        b=VGu5gqbiJ02DjNbpkwtPu/DX9JxL4wg9kLZN9XYhvBz/cYj2NBILp+nd2kAcCxEPKP
         +Tf6DzIyx12Mm2LoTJT0bDURcS84mcAurzVC0fUttTivRzTkeeCjfkRQfHjekksfbaXE
         kf75uqiirGoe9BVn85UJrFMzZUb2rcey6p1XBtHeaxViZ3x+9XVVdieQ0it0zUXrlrE5
         5gWDJF88w28nvlWVBImS3zvfaDfe8wvM5KLfMEicw9ffh0L+GKdSNYo4axpXf/dRLAoV
         QAcnBZWothQDzGz2VfdMDoqjXKBIKWt9dz/pk39BgBrgBLivmK+qg5bPC8CkuYYpas2H
         ucfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4PVvv8WDdiwpkbAgHq2xQulkc2fQ/jZIWJlkAhfKQ8Y=;
        b=e9m1fK7by0tP6FMMZ0Vszf1pFw1fGhBQKi+Xyz2vSpFGScNbRRkr3+aK7K6oCqauIg
         XII8aQpzSfhIhse4rU6TcztljNV+q2DxkjQTU92WKOnYl7bbKm3Y9unhOEDGlYV/cSEC
         jEeSK16PL557QqwUKaqSRVgj1W4U3DFBG/CM97XblGi+Wnzbu/jL9HRkalerdUbwkF9F
         n+jFNin1dxrpjVNXlkLYnCI67fn2VzHvBmXV6e0Nn5tumCvwwqm2ONEvpZ0wngZLr5lb
         yQJB+JClgy5BfdUo1ZLAc1Gg+hQ1/+9bT28nJ1LStc2gngNUD/ipoK4k9yKDgENwcNPL
         mPfg==
X-Gm-Message-State: AOAM530H2wAP4xO2HxAkK8foKf8ggT4ht5u2l42q4TrkX9JP7EqqDugg
        WwiiUroLalRoOWXivDJfyl4=
X-Google-Smtp-Source: ABdhPJztC8e2ChZQ7t9SzHZh9/6xwNURbaIXG5kMY2cq/ABbnqLOksPoG/EZhr0cVsQkVtlaptgEpw==
X-Received: by 2002:a05:6830:2094:: with SMTP id y20mr2594500otq.259.1611503031425;
        Sun, 24 Jan 2021 07:43:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t16sm2950309otq.17.2021.01.24.07.43.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jan 2021 07:43:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 24 Jan 2021 07:43:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     angkery <angkery@163.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: Re: [PATCH v3 2/2] usb: typec: tcpci_maxim: add terminating newlines
 to logging
Message-ID: <20210124154349.GC131753@roeck-us.net>
References: <20210124143947.1688-1-angkery@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124143947.1688-1-angkery@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 10:39:47PM +0800, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> Add terminating '\n' to the formats where missed.
> 
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v3:Modify it again and submit it separately from patch 1.
> 
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index 7f54f51a..5d7463c 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -158,7 +158,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
>  	 */
>  	ret = regmap_raw_read(chip->data.regmap, TCPC_RX_BYTE_CNT, rx_buf, 2);
>  	if (ret < 0) {
> -		dev_err(chip->dev, "TCPC_RX_BYTE_CNT read failed ret:%d", ret);
> +		dev_err(chip->dev, "TCPC_RX_BYTE_CNT read failed ret:%d\n", ret);
>  		return;
>  	}
>  
> @@ -167,13 +167,13 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
>  
>  	if (count == 0 || frame_type != TCPC_RX_BUF_FRAME_TYPE_SOP) {
>  		max_tcpci_write16(chip, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
> -		dev_err(chip->dev, "%s", count ==  0 ? "error: count is 0" :
> +		dev_err(chip->dev, "%s\n", count ==  0 ? "error: count is 0" :
>  			"error frame_type is not SOP");
>  		return;
>  	}
>  
>  	if (count > sizeof(struct pd_message) || count + 1 > TCPC_RECEIVE_BUFFER_LEN) {
> -		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d", count);
> +		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d\n", count);
>  		return;
>  	}
>  
> @@ -184,7 +184,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
>  	count += 1;
>  	ret = regmap_raw_read(chip->data.regmap, TCPC_RX_BYTE_CNT, rx_buf, count);
>  	if (ret < 0) {
> -		dev_err(chip->dev, "Error: TCPC_RX_BYTE_CNT read failed: %d", ret);
> +		dev_err(chip->dev, "Error: TCPC_RX_BYTE_CNT read failed: %d\n", ret);
>  		return;
>  	}
>  
> @@ -317,7 +317,7 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
>  			return ret;
>  
>  		if (reg_status & TCPC_SINK_FAST_ROLE_SWAP) {
> -			dev_info(chip->dev, "FRS Signal");
> +			dev_info(chip->dev, "FRS Signal\n");
>  			tcpm_sink_frs(chip->port);
>  		}
>  	}
> @@ -460,7 +460,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
>  	max_tcpci_init_regs(chip);
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
>  	if (IS_ERR(chip->tcpci)) {
> -		dev_err(&client->dev, "TCPCI port registration failed");
> +		dev_err(&client->dev, "TCPCI port registration failed\n");
>  		return PTR_ERR(chip->tcpci);
>  	}
>  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
> -- 
> 1.9.1
> 
