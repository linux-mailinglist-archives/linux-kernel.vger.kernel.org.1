Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360D42EF0E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbhAHKyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbhAHKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:54:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FD4C0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 02:53:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 3so8022569wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 02:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0sOKwV6y9i8b8WtnAre8jVkNh7YYBYOd3Gvu8cJtt2E=;
        b=t11D13Trxold4yZt5TS8kyA0zjHh0IiH92ETz2hLB4HfJM+Aj5wd0mq4k6eqFStzl0
         99m6wjH+ptL4xEbm6hnfBJJmRVzV3+J3is6+FcjFbZjfyasnH1nlU0eJtBQGBhzutIhN
         U41rL4btiFG3Rgv9KKXU7XrlKCC9QWQSuKldYteK6ZRHcQgBe9kCjYbl1AnKai57BVrW
         yirLukHWb2T3o1ylRcm2dPQE3cK/LbaOvKhHQ1p1h44qOP3ERx7jB4Uj/fbeizDGHvPA
         IyjZ3sUQeB74wxVqFtjL7CnqPoVG9BswaYp+1CQlNZnALQG5zChxfGSrYbPuUWXr+tz7
         afDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0sOKwV6y9i8b8WtnAre8jVkNh7YYBYOd3Gvu8cJtt2E=;
        b=scqUbQ03TONo1qWIhtMvxZPrn7PqAXIPhjI/xLoL0E+SLYwafK+ZX2CCEO6hl/VUkQ
         QUh1iFeFUmGNgEYDSwIKTeAa7fKbC/AXa0ZnVD6RJ/jg8szaT1iDcXNhGR0KnjqOHWiO
         34rhpp8Mw1eq2FyZfQxEYaj0V2GFf52CejU2O8Fnl7nzVXgdDaBuU4rYO1KPSB+pMUAY
         D2pdE/JdsFMrfPaYhPdGSvlteyMETP4CTSeNBjx+5RBvVsS1Lln2v2UrvdPDLTOZOyVX
         n9/HhZbZVp+U+/pL3nnVGzRYX7Tk9/QijnwPMWx6qJ3lAZeFXIhwk1X5Pd46BbDSWxrR
         uxpg==
X-Gm-Message-State: AOAM5318kVcMXEaQGQhy7vMmGoJu1EEyl5tMFVB8ZElWh8kdaq9TxjdE
        DNVRQ5i7FebktLjdIUzaSPYrqkH0xmBcExS3
X-Google-Smtp-Source: ABdhPJwXlzSBXuX2DDpIKzT9O5tK331ns3aUAom2WkdzouUpEsCiHIspqm61d0v2uKTDKhTmXXnVdA==
X-Received: by 2002:a1c:46c5:: with SMTP id t188mr2553598wma.3.1610103237472;
        Fri, 08 Jan 2021 02:53:57 -0800 (PST)
Received: from dell ([91.110.221.156])
        by smtp.gmail.com with ESMTPSA id p9sm11671633wmm.17.2021.01.08.02.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 02:53:56 -0800 (PST)
Date:   Fri, 8 Jan 2021 10:53:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] mfd: convert comma to semicolon
Message-ID: <20210108105355.GE1592923@dell>
References: <20210108092058.18576-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210108092058.18576-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jan 2021, Zheng Yongjun wrote:

You're still not using the correct subject format.

It should be:

 "mfd: <driver>: Description starting with an uppercase char"

Code looks fine.

> Replace a comma between expression statements by a semicolon.
> 
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
