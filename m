Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216362AD8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgKJOjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:39:43 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC7EC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:39:43 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id o25so13701673oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eLp5zWsUOzRRgANrPE/hI6DSzBMZU08Xxw4sHUFamWc=;
        b=Foc2DBT0hniseTxCDkFbMZsZjsnDB/SnsZyudbPW2rb9iRvg8Or6UeorGjPUdUsOO6
         yq0JtfkVkik5H/M9aAZZUJt+hIdgJcGsKNyAsnIC+GIzMv3KUuLSVSjkyRs6TJx1MVWW
         tI+U9m2ZPvKpLcEGRH5sH65IcOi5SXJpTURDvzfuG5U+TP8xESP0g7uCwRfr7N4xsfJy
         PweWifCVh0HKv4/9C8790xAEwOhz4oDeQVeXf2LRSrmBhaSRnmRrkdCfIgeBr1Jis+Cz
         N+3j0D6BT3E+jCs7NyXJvoSV0C7sJrdjR/q2nNp/0NAfe+Dggf1aniweYK74pkQIBLPi
         X0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eLp5zWsUOzRRgANrPE/hI6DSzBMZU08Xxw4sHUFamWc=;
        b=QDAuzXXXkNfKjhziYMei6wVJiGpgwm4QR6KRCGjms5nJG2G1W/k0ldVgqzc0p4bse2
         thG7ZtUz+2aRzcP0I2/hjVtu3btUG9qW8OipBUXZ8aElqajfOc5igoRcM6FRfIfeVguF
         Om0XP0rw2aCWSQKuICPhEGQ+rEw49ZWlMUdPZI7K2ao07ZZonYjOvzb/m5ojqCdB9U85
         SQM7bQtaCMklY1ALK5GX6ICH+5may0Qj4TGGyiy5/FclTW+BEnxXbd6QGDVmTBoI6jbT
         Egw3jdepVryNlOgOwSPZRm9t055BPDDqWEWw/19lKkEzCqYuP46D3TyZN9yS9D58+SMM
         O/0Q==
X-Gm-Message-State: AOAM533CMuR0CghtI+UiXeu12tMW/gYgiD0FWHFdX5hIz7sV6Gdh1++v
        bb0bSYecD0yfaC7O/fm5pVc=
X-Google-Smtp-Source: ABdhPJzgfN73xf6MvhmvQ7zMPrk8uElsTEvVWKSf5zCWFq9dfWIQkBWdKAgTr0adBsNGltNPuYfm1Q==
X-Received: by 2002:aca:3542:: with SMTP id c63mr2873240oia.61.1605019182762;
        Tue, 10 Nov 2020 06:39:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x83sm3153450oig.39.2020.11.10.06.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 06:39:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] mfd: kempld-core: Check for DMI definition before ACPI
To:     Michael Brunner <Michael.Brunner@kontron.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mvanyulin@dev.rtsoft.ru" <mvanyulin@dev.rtsoft.ru>
References: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <28a160ac-df8c-0fcb-8814-03125d753be3@roeck-us.net>
Date:   Tue, 10 Nov 2020 06:39:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 11:46 PM, Michael Brunner wrote:
> Change the detection order to priorize DMI table entries over available
> ACPI entries.
> 
> This makes it more easy for product developers to patch product specific
> handling into the driver.
> Furthermore it allows to simplify the implementation a bit and
> especially to remove the need to force synchronous probing.
> 
> Based on the following commit introduced with v5.10-rc1:
> commit e8299c7313af ("mfd: Add ACPI support to Kontron PLD driver")
> 
> Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> ---
>  drivers/mfd/kempld-core.c | 23 ++---------------------
>  1 file changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> index 2c9295953c11..aa7f386646a1 100644
> --- a/drivers/mfd/kempld-core.c
> +++ b/drivers/mfd/kempld-core.c
> @@ -125,7 +125,6 @@ static const struct kempld_platform_data kempld_platform_data_generic = {
>  };
>  
>  static struct platform_device *kempld_pdev;
> -static bool kempld_acpi_mode;
>  
>  static int kempld_create_platform_device(const struct dmi_system_id *id)
>  {
> @@ -501,8 +500,6 @@ static int kempld_probe(struct platform_device *pdev)
>  		ret = kempld_get_acpi_data(pdev);
>  		if (ret)
>  			return ret;
> -
> -		kempld_acpi_mode = true;
>  	} else if (kempld_pdev != pdev) {
>  		/*
>  		 * The platform device we are probing is not the one we
> @@ -565,7 +562,6 @@ static struct platform_driver kempld_driver = {
>  	.driver		= {
>  		.name	= "kempld",
>  		.acpi_match_table = ACPI_PTR(kempld_acpi_table),
> -		.probe_type = PROBE_FORCE_SYNCHRONOUS,
>  	},
>  	.probe		= kempld_probe,
>  	.remove		= kempld_remove,
> @@ -884,7 +880,6 @@ MODULE_DEVICE_TABLE(dmi, kempld_dmi_table);
>  static int __init kempld_init(void)
>  {
>  	const struct dmi_system_id *id;
> -	int ret;
>  
>  	if (force_device_id[0]) {
>  		for (id = kempld_dmi_table;
> @@ -894,24 +889,10 @@ static int __init kempld_init(void)
>  					break;
>  		if (id->matches[0].slot == DMI_NONE)
>  			return -ENODEV;
> -	}
> -
> -	ret = platform_driver_register(&kempld_driver);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * With synchronous probing the device should already be probed now.
> -	 * If no device id is forced and also no ACPI definition for the
> -	 * device was found, scan DMI table as fallback.
> -	 *
> -	 * If drivers_autoprobing is disabled and the device is found here,
> -	 * only that device can be bound manually later.
> -	 */
> -	if (!kempld_pdev && !kempld_acpi_mode)
> +	} else

	} else {
>  		dmi_check_system(kempld_dmi_table);
	}

Guenter

>  
> -	return 0;
> +	return platform_driver_register(&kempld_driver);
>  }
>  
>  static void __exit kempld_exit(void)
> 

