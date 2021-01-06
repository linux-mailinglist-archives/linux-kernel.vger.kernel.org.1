Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2132EBF3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbhAFNyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAFNyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:54:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B23C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 05:53:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i9so2522855wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 05:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GpbiIc4VkefaGPlZ4iWb+ldyLiXG08SELRho20fN5SE=;
        b=O12dcw+h6yNM4Fe+gnxzc4MZAANXns5YH9eZNpOuuYySWV6FYZUdKlkQyeeGucxeav
         0elAIFOT4kf48Z6EZhsvsDT2v01Qpmbvw1O3x0etVUnShR4BHk++FSTJJS+weiMq8Naw
         C4qZIF6388yTYDYG3ZzhNfapGrN+XoW6phZewlMeGYYkGyBfBLHKBgvBMmliU66KYLxI
         GXYyYgAQ2Bb0OgBOXsnQf4KOn5wUWmnumccNBQaHsJOoEnm8co9qkGlbKvhOzdvtvQ0c
         v+J/dZhpdWhTs1B7+Jl6PgRyiwAvxVcb1+pTfxOyVpyPCHNfzS5kHiBVI+rsClMpTQup
         v5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GpbiIc4VkefaGPlZ4iWb+ldyLiXG08SELRho20fN5SE=;
        b=IzyaHha3yCAukzEONfVIRudTVENjO4CMbOgcRgHampN7tabc4ya8tyKwzn60fAeRS5
         9Qfhe82NjoMmD7pyrurFckRzAWOwdDRp8Nb7h77oijO6M5o1NC1vEmk9xI4pO1ayP4Fk
         w/legV2Mtxv15IwQir8ZhnpT+g2zjz0eI2bIFBQPMItIi6hES0KOT/H3ZPDtStbwthOI
         3gnIhu9iObAsv6Y1qzKI1u9XbJE2tZhRD6RFSmAa/WbZHlp2xlYfa/a2yAnzNLsAaTHG
         MRYgiCftSG0NWZjLHhuN2fvP/1pmvQrRpzMBh3yb6VNxNlk1WEOExW3LXLS4kh2fpwFO
         JfTg==
X-Gm-Message-State: AOAM533LwwO5nDo73tbnW45bISU8iZ60ErW7X3fyX6/zUF/5Ub8/Aj9B
        NZzHcltF5UGTk8Pv2dJK5ehJMxhGZGC47gva
X-Google-Smtp-Source: ABdhPJztdgDB1AqZO7w+5AGpsAn8J8t17HMUYMqinESoo3rK5YpofXwXNnooUcYk0rxk621B5DKYpg==
X-Received: by 2002:adf:92c2:: with SMTP id 60mr4493890wrn.266.1609941209458;
        Wed, 06 Jan 2021 05:53:29 -0800 (PST)
Received: from dell ([91.110.221.182])
        by smtp.gmail.com with ESMTPSA id 189sm3206302wma.22.2021.01.06.05.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:53:28 -0800 (PST)
Date:   Wed, 6 Jan 2021 13:53:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd: use resource_size
Message-ID: <20210106135327.GD1592923@dell>
References: <20210106131653.32441-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210106131653.32441-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix your subject line to match the others in the subsystem.

`git log --oneline -- drivers/<subsystem>` is your friend.

On Wed, 06 Jan 2021, Zheng Yongjun wrote:

> Use resource_size rather than a verbose computation on
> the end and start fields.

Not sure I can see how this matches to the diff below?

Please could you provide more detail?

> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/mfd/88pm860x-core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
> index c9bae71f643a..a9e0855b4c66 100644
> --- a/drivers/mfd/88pm860x-core.c
> +++ b/drivers/mfd/88pm860x-core.c
> @@ -916,7 +916,7 @@ static void device_power_init(struct pm860x_chip *chip,
>  	power_devs[0].platform_data = pdata->power;
>  	power_devs[0].pdata_size = sizeof(struct pm860x_power_pdata);
>  	power_devs[0].num_resources = ARRAY_SIZE(battery_resources);
> -	power_devs[0].resources = &battery_resources[0],
> +	power_devs[0].resources = &battery_resources[0];
>  	ret = mfd_add_devices(chip->dev, 0, &power_devs[0], 1,
>  			      &battery_resources[0], chip->irq_base, NULL);
>  	if (ret < 0)
> @@ -925,7 +925,7 @@ static void device_power_init(struct pm860x_chip *chip,
>  	power_devs[1].platform_data = pdata->power;
>  	power_devs[1].pdata_size = sizeof(struct pm860x_power_pdata);
>  	power_devs[1].num_resources = ARRAY_SIZE(charger_resources);
> -	power_devs[1].resources = &charger_resources[0],
> +	power_devs[1].resources = &charger_resources[0];
>  	ret = mfd_add_devices(chip->dev, 0, &power_devs[1], 1,
>  			      &charger_resources[0], chip->irq_base, NULL);
>  	if (ret < 0)
> @@ -942,7 +942,7 @@ static void device_power_init(struct pm860x_chip *chip,
>  		pdata->chg_desc->charger_regulators =
>  			&chg_desc_regulator_data[0];
>  		pdata->chg_desc->num_charger_regulators	=
> -			ARRAY_SIZE(chg_desc_regulator_data),
> +			ARRAY_SIZE(chg_desc_regulator_data);
>  		power_devs[3].platform_data = pdata->chg_desc;
>  		power_devs[3].pdata_size = sizeof(*pdata->chg_desc);
>  		ret = mfd_add_devices(chip->dev, 0, &power_devs[3], 1,
> @@ -958,7 +958,7 @@ static void device_onkey_init(struct pm860x_chip *chip,
>  	int ret;
>  
>  	onkey_devs[0].num_resources = ARRAY_SIZE(onkey_resources);
> -	onkey_devs[0].resources = &onkey_resources[0],
> +	onkey_devs[0].resources = &onkey_resources[0];
>  	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
>  			      ARRAY_SIZE(onkey_devs), &onkey_resources[0],
>  			      chip->irq_base, NULL);
> @@ -972,7 +972,7 @@ static void device_codec_init(struct pm860x_chip *chip,
>  	int ret;
>  
>  	codec_devs[0].num_resources = ARRAY_SIZE(codec_resources);
> -	codec_devs[0].resources = &codec_resources[0],
> +	codec_devs[0].resources = &codec_resources[0];
>  	ret = mfd_add_devices(chip->dev, 0, &codec_devs[0],
>  			      ARRAY_SIZE(codec_devs), &codec_resources[0], 0,
>  			      NULL);

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
