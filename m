Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9B2ADB57
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgKJQLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgKJQLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:11:20 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75538C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 08:11:20 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n15so13011327otl.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UuzecMPiWHXkf94K0SIlRxDoM0PbVpqc+F+ydaNq/ww=;
        b=V/IP+86djm7AQ4cdhH6j+nw8qb2AxzIswx12wldOeH+EdWxBXeYLMYuDhceLbsLC2p
         LwKWDEFfkgdzH5vV4ebm71uiWgfVBT3fKSWejtNIYJN7zSheF+5JvuN09lqZL6b7KqZA
         QMopFW4CB48jS3tXyZkofbBOBZyiDGZ0XdK2K7bFjEOfa89VteobpLbDcWyb9ymp/OaW
         rnrMiX054pMKSTcBLRipHXx8aNbSLS64loJ3nZZsfSYIjTPEc02Fyxq5gNmrnAqoaoRv
         4QO+VCd9Ws1u+gSzFNffDvMiW6xoDujMHhDmpveEnc4+cGC6We+6+Mh0DkD1AegdHXHI
         Ktvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UuzecMPiWHXkf94K0SIlRxDoM0PbVpqc+F+ydaNq/ww=;
        b=ZIv13hj4I9bn4Bd7GFuudaAc8Az9idKV3CtdwBGpao6frUKibUNZwbaq0e1MRdEOeJ
         vUECGMch2cZoDThwgQw99565PjKIPdrm3wQISvUnEktqw1DquMTJLobFyAhxkug6Gp/Z
         xEJ81OIFegiKFYjPkfD4WQHVxOPhg/3OapL/y7w0t4roXY0eEUpf3P8bSWhhP9XizHFw
         fc4np3Mok5WFfSnGjU9J+5KPW/2dZLbS0LmKQDF8x7wDePzwOkUjwT1Qqyhn/ULg3Xta
         eVC6c0FB5osWQVOvIFeJjd2Lyo1QJq37WJj/EQbPe8TRe+cTO5FqE4YijOc1jQeEM6ip
         uuYw==
X-Gm-Message-State: AOAM530PC8fG6OjsNAsQ78pmvVV0XfzvYx5iGoRQkTGw5AZARSmfwsd9
        paY091HTY1WZgoQbFUS2rEk=
X-Google-Smtp-Source: ABdhPJxGwwdvtNrQf8wYZcddW0zO+OytP2PlqNt3V6lLbbh+cvahJldCx/aq9+rXlz6XxDfwm1yKGA==
X-Received: by 2002:a05:6830:8f:: with SMTP id a15mr13818229oto.362.1605024679912;
        Tue, 10 Nov 2020 08:11:19 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a21sm1238024otr.36.2020.11.10.08.11.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 08:11:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Nov 2020 08:11:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Brunner <Michael.Brunner@kontron.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mvanyulin@dev.rtsoft.ru" <mvanyulin@dev.rtsoft.ru>
Subject: Re: [PATCH v2] mfd: kempld-core: Check for DMI definition before ACPI
Message-ID: <20201110161118.GE17288@roeck-us.net>
References: <981276386ec1b496b423b7605b7ac912884b7172.camel@kontron.com>
 <bf70506e5aeb87889b298e342f96bae0e2187102.camel@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf70506e5aeb87889b298e342f96bae0e2187102.camel@kontron.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 03:23:21PM +0000, Michael Brunner wrote:
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
> v2: Fixed coding style as suggested by Guenther Roeck
> 

Nit: change logs should be after '---'.

Other than that,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> ---
>  drivers/mfd/kempld-core.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> index 2c9295953c11..ecd26271b9a4 100644
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
> @@ -894,24 +889,11 @@ static int __init kempld_init(void)
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
> +	} else {
>  		dmi_check_system(kempld_dmi_table);
> +	}
>  
> -	return 0;
> +	return platform_driver_register(&kempld_driver);
>  }
>  
>  static void __exit kempld_exit(void)
> -- 
> 2.25.1
> 
