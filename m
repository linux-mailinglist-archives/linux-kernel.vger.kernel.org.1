Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CBE277445
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgIXOrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgIXOrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:47:11 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02502C0613CE;
        Thu, 24 Sep 2020 07:47:11 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n61so3354208ota.10;
        Thu, 24 Sep 2020 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K1ZZ0pT/WIW6zRbkjcCA32PZ6NuKc6zLQ2bXMQ8ym4U=;
        b=CvKyj2Wv6mHnggy+SJ7FJ5OSbuEnq7ou8OsQNyH5HIB5jDk6XbTzJa5tUlsRFSTYux
         EQpyAsiKIHGP7RlNJqYGfNXF9g8sMuhTbXqrFX/NNdyDzA+sZqOgXPr9KuMF690B9m9v
         2byJyxZUgglw6e4SpRWS1D8XxW0yW3xEGYX4ZJCzqud/r8l6IfLdsB4WpAJT/JBI5pP/
         uy4jDIyMnfXfmOJO6KsJQ909s+3eO8ri0bifpktad+Xok5dfYLkygtJBEmT0TARt5unU
         tLb4C2teGO727k7/GPS7+UsRORx05Shw9v308GvLvOo/28rfPzBK8y5ukM9OgjTxhamE
         WMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K1ZZ0pT/WIW6zRbkjcCA32PZ6NuKc6zLQ2bXMQ8ym4U=;
        b=qD8SlWa76jky0D7qA7dj2IQifE79RyjAE77d0JPLhuN79W+AXxlKzBD4ksrZt6S2Ba
         OfyACUhvy0q37o4FEYYWQ1Vmc55mq+EF6pIRvN/p/btAm3PSScnKYAqCSShKAjPVjVKw
         lO6iw4VlI+pliTZPCF9B8r7uV729RLZGxwzKL07dP5mETffEAGJ6SI71vSN0+AwA1td/
         28LAfSt0CeCDEu7CO3L0xW7BPPqsL1Upq8dK2bRBKDFCHqNFNJ2NiYfZguprxaPuxmMK
         Gn7lVMswchcLx11bYkpVcEiRbnZYhphdo1fPOYGOEPI78QjQLqAXeq2gxii0AiTT4Plu
         HX8Q==
X-Gm-Message-State: AOAM531uBHEu/MPV2V81M9MfDsZcKNWQB8zHNQCz+RHeulQhS6c64wkW
        WEWeK511SFgLLir3jBw42vc+I1PLFW8=
X-Google-Smtp-Source: ABdhPJz/uE8+tpT+Jr0O8gYcOa/jXMLcC7MBHeMjH9d7Efh4hjJOKY+pJbzBxdpUe7dL21ChOoG8Zg==
X-Received: by 2002:a05:6830:2104:: with SMTP id i4mr14567otc.266.1600958830385;
        Thu, 24 Sep 2020 07:47:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g21sm921049oos.36.2020.09.24.07.47.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 07:47:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 24 Sep 2020 07:47:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (adm9240) Use loops to avoid duplicated code
Message-ID: <20200924144708.GA191738@roeck-us.net>
References: <20200924085102.15219-1-chris.packham@alliedtelesis.co.nz>
 <20200924085102.15219-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924085102.15219-2-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Thu, Sep 24, 2020 at 08:51:00PM +1200, Chris Packham wrote:
> Use loops for reading temp_max and initialising FAN_MIN/TEMP_MAX rather
> than duplicating code.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Series applied (and module tested).

Thanks a lot for the clean submission.

Guenter

> ---
>  drivers/hwmon/adm9240.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
> index 496d47490e10..f95dde1b9c7f 100644
> --- a/drivers/hwmon/adm9240.c
> +++ b/drivers/hwmon/adm9240.c
> @@ -223,10 +223,10 @@ static struct adm9240_data *adm9240_update_device(struct device *dev)
>  			data->fan_min[i] = i2c_smbus_read_byte_data(client,
>  					ADM9240_REG_FAN_MIN(i));
>  		}
> -		data->temp_max[0] = i2c_smbus_read_byte_data(client,
> -				ADM9240_REG_TEMP_MAX(0));
> -		data->temp_max[1] = i2c_smbus_read_byte_data(client,
> -				ADM9240_REG_TEMP_MAX(1));
> +		for (i = 0; i < 2; i++) {
> +			data->temp_max[i] = i2c_smbus_read_byte_data(client,
> +					ADM9240_REG_TEMP_MAX(i));
> +		}
>  
>  		/* read fan divs and 5-bit VID */
>  		i = i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
> @@ -687,14 +687,14 @@ static void adm9240_init_client(struct i2c_client *client)
>  			i2c_smbus_write_byte_data(client,
>  					ADM9240_REG_IN_MAX(i), 255);
>  		}
> -		i2c_smbus_write_byte_data(client,
> -				ADM9240_REG_FAN_MIN(0), 255);
> -		i2c_smbus_write_byte_data(client,
> -				ADM9240_REG_FAN_MIN(1), 255);
> -		i2c_smbus_write_byte_data(client,
> -				ADM9240_REG_TEMP_MAX(0), 127);
> -		i2c_smbus_write_byte_data(client,
> -				ADM9240_REG_TEMP_MAX(1), 127);
> +		for (i = 0; i < 2; i++) {
> +			i2c_smbus_write_byte_data(client,
> +					ADM9240_REG_FAN_MIN(i), 255);
> +		}
> +		for (i = 0; i < 2; i++) {
> +			i2c_smbus_write_byte_data(client,
> +					ADM9240_REG_TEMP_MAX(i), 127);
> +		}
>  
>  		/* start measurement cycle */
>  		i2c_smbus_write_byte_data(client, ADM9240_REG_CONFIG, 1);
