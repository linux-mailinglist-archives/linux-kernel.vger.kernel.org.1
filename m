Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31B528011B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbgJAORN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgJAORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:17:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CCAC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 07:17:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so5957253wrn.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sl1bAhx7C9a4MYgOdjHVAIRELO6dtKoJoTULLqIN/Wk=;
        b=y/ZQT2oTP990NGhLz0VE6mjD9demWCTb6hdXe/1KXtNeTq3UKilVkGveT6XoMd7Co+
         Lq7VLj73rXe7Xi7C5iOBrHt0b5FyRHzHELdqVFyL3AFr8htaN2aYkKoFvX1P4pTxG/b2
         ETrmYNh+p+sQNyUgaoWw1ql7xHVYwEMCS6Qso5qpTqM8E7W+Ly2kUqigIKLybbjc9y9m
         ZeT0Gm3AlLQblWSXkwgGqw+J+RNhSf74jLbrS9xsvgkc4uzJ7TThdKYF7tvBy86d926Z
         5YfoLfI9MK8XAaj9YdbIy3uedWyeFqFd2fmh2eQF+Ltvm6H9pqul7mYMTmJQAsopGULi
         O3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sl1bAhx7C9a4MYgOdjHVAIRELO6dtKoJoTULLqIN/Wk=;
        b=bdXMfgCD3xF7YgXU6t0eab/LQFfImaBVE8FEd0iTbbBBpe90hih4xO3/HKZzWJiBoz
         bUI0/MVnNmBBEXr4ceqJQWwSQhFTJMuedRJwJIAk9eR89ztwEhlLunhVbKY3UCp8WKyI
         8pXiePkPpzKxQmwyQKboRzPAfOJZNshQZ4DgvoLlLi+/vmSFY2A9CH0ExohLTPqzdyxd
         rb8qb5rtIjoqM5lDY+UMnTMZygjV3j/5Z9MvGwPjR33kDCzSLC1UHvT9TazcTmGV33hS
         j6ha1dtkIm+t3cMxNKEDz+7ehBSl500ISbwWmytq1O3a/nUY7b5pzt8P5nhJ/nkxB+7A
         kTJA==
X-Gm-Message-State: AOAM533kZ6t/+0uS01VsdPVkevwF7FVtJtnxdaa7p4+1vgqYk3XuDBmk
        1WSrIAY8wAZgptRAQOEc9CNU7UyD0yjMIg==
X-Google-Smtp-Source: ABdhPJwl3Qt3yXjApNCsYKWImfYfzWd1X048vsHexXEeQPoYe8fsopjjZ5dzuW0nZ38MjD7rW9cqAA==
X-Received: by 2002:adf:fe42:: with SMTP id m2mr9135525wrs.367.1601561831064;
        Thu, 01 Oct 2020 07:17:11 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id u2sm10529568wre.7.2020.10.01.07.17.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 07:17:10 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvmem: qfprom: Don't touch certain fuses
To:     Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20200929205807.2360405-1-evgreen@chromium.org>
 <20200929135741.3.I1bb1b0e94be3b792804e08831d6a55481e162d63@changeid>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8f467220-3ac8-c8fc-33fe-8d86904571fe@linaro.org>
Date:   Thu, 1 Oct 2020 15:17:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200929135741.3.I1bb1b0e94be3b792804e08831d6a55481e162d63@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On 29/09/2020 21:58, Evan Green wrote:
> Some fuse ranges are protected by the XPU such that the AP cannot
> access them. Attempting to do so causes an SError. Use the newly
> introduced per-soc compatible string to attach the set of regions
> we should not access. Then tiptoe around those regions.
> 

This is a generic feature that can be used by any nvmem provider, can 
you move this logic to nvmem core instead of having it in qfprom!


thanks,
srini

> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
>   drivers/nvmem/qfprom.c | 55 +++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index 5e9e60e2e591d..feea39ae52164 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
> @@ -12,6 +12,7 @@
>   #include <linux/mod_devicetable.h>
>   #include <linux/nvmem-provider.h>
>   #include <linux/platform_device.h>
> +#include <linux/property.h>
>   #include <linux/regulator/consumer.h>
>   
>   /* Blow timer clock frequency in Mhz */
> @@ -51,6 +52,17 @@ struct qfprom_soc_data {
>   	u32 qfprom_blow_set_freq;
>   };
>   
> +/**
> + * struct qfprom_keepout_region - registers to avoid touching.
> + *
> + * @start: The first byte offset to avoid.
> + * @end: One after the last byte offset to avoid.
> + */
> +struct qfprom_keepout_region {
> +	u32 start;
> +	u32 end;
> +};
> +
>   /**
>    * struct qfprom_priv - structure holding qfprom attributes
>    *
> @@ -63,6 +75,7 @@ struct qfprom_soc_data {
>    * @secclk:       Clock supply.
>    * @vcc:          Regulator supply.
>    * @soc_data:     Data that for things that varies from SoC to SoC.
> + * @keepout:      Fuse regions not to access, as they may cause SErrors.
>    */
>   struct qfprom_priv {
>   	void __iomem *qfpraw;
> @@ -73,6 +86,7 @@ struct qfprom_priv {
>   	struct clk *secclk;
>   	struct regulator *vcc;
>   	const struct qfprom_soc_data *soc_data;
> +	const struct qfprom_keepout_region *keepout;
>   };
>   
>   /**
> @@ -88,6 +102,12 @@ struct qfprom_touched_values {
>   	u32 timer_val;
>   };
>   
> +const struct qfprom_keepout_region sc7180_qfprom[] = {
> +	{.start = 0x128, .end = 0x148},
> +	{.start = 0x220, .end = 0x228},
> +	{} /* Sentinal where start == end. */
> +};
> +
>   /**
>    * qfprom_disable_fuse_blowing() - Undo enabling of fuse blowing.
>    * @priv: Our driver data.
> @@ -171,6 +191,23 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
>   	return ret;
>   }
>   
> +static int qfprom_check_reg(struct qfprom_priv *priv, unsigned int reg)
> +{
> +	const struct qfprom_keepout_region *keepout = priv->keepout;
> +
> +	if (!keepout)
> +		return 1;
> +
> +	while (keepout->start != keepout->end) {
> +		if ((reg >= keepout->start) && (reg < keepout->end))
> +			return 0;
> +
> +		keepout++;
> +	}
> +
> +	return 1;
> +}
> +
>   /**
>    * qfprom_efuse_reg_write() - Write to fuses.
>    * @context: Our driver data.
> @@ -228,8 +265,10 @@ static int qfprom_reg_write(void *context, unsigned int reg, void *_val,
>   		goto exit_enabled_fuse_blowing;
>   	}
>   
> -	for (i = 0; i < words; i++)
> -		writel(value[i], priv->qfpraw + reg + (i * 4));
> +	for (i = 0; i < words; i++) {
> +		if (qfprom_check_reg(priv, reg + (i * 4)))
> +			writel(value[i], priv->qfpraw + reg + (i * 4));
> +	}
>   
>   	ret = readl_relaxed_poll_timeout(
>   		priv->qfpconf + QFPROM_BLOW_STATUS_OFFSET,
> @@ -257,8 +296,14 @@ static int qfprom_reg_read(void *context,
>   	if (read_raw_data && priv->qfpraw)
>   		base = priv->qfpraw;
>   
> -	while (words--)
> -		*val++ = readb(base + reg + i++);
> +	while (words--) {
> +		if (qfprom_check_reg(priv, reg + i))
> +			*val++ = readb(base + reg + i);
> +		else
> +			*val++ = 0;
> +
> +		i++;
> +	}
>   
>   	return 0;
>   }
> @@ -299,6 +344,7 @@ static int qfprom_probe(struct platform_device *pdev)
>   	econfig.priv = priv;
>   
>   	priv->dev = dev;
> +	priv->keepout = device_get_match_data(dev);
>   
>   	/*
>   	 * If more than one region is provided then the OS has the ability
> @@ -354,6 +400,7 @@ static int qfprom_probe(struct platform_device *pdev)
>   
>   static const struct of_device_id qfprom_of_match[] = {
>   	{ .compatible = "qcom,qfprom",},
> +	{ .compatible = "qcom,sc7180-qfprom", .data = &sc7180_qfprom},
>   	{/* sentinel */},
>   };
>   MODULE_DEVICE_TABLE(of, qfprom_of_match);
> 
