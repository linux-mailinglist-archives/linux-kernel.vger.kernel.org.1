Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53CD2C824F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgK3Kf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbgK3Kf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:35:56 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB9FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 02:35:10 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id l23so173849pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 02:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JhpB/t5kCjjYRTw+xINHPebhKoCjmMuMSHZrMIpoK54=;
        b=ZurS9jYa+SkfPr8aONBeaAoWbwdGYcdP319Zi7pFHcGkGWQD6suhIhZiM6hdXlNYJX
         NLWoXceltubUgVj5mFTsaGcWP+mqyNizBlqC3MjekPidqQ16FKtKMupb5yuJhRnsJcCc
         HgqlZGwdWIfHqbGt8E0uja48kJ+L7QIVOuj5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JhpB/t5kCjjYRTw+xINHPebhKoCjmMuMSHZrMIpoK54=;
        b=qD3jkfgOlacBenGHHkTQWfuCApOQwKXzQm1Lq8or0XMwcUqb/em7BUw9UMdBxFM7Th
         5vRe3ANLSFt+815Z2nmMp5hU/pJlJ8fAnxPd3Fd3gNjNsDkgH5m/1mIpkDrWkqYW3CbF
         FvqNzFls0Pag/Pz2WuoVZy51BHIyMCs2qFUiH/U8WNXO4CoxhzkCnNfzxRFpcm2+nFFN
         wsEQ43gD/jJ8KOyWKqfU8Usg3SiJMwhZO2G197v718qog0+xv3S/W3F8TxrfWn37V4bv
         kkQX6xDr/OZUMT6G1DpA54+LDraBD9fAW0c5N2WbVHC2iF4jZjYk94yFERRE3EhMgMRH
         5wkA==
X-Gm-Message-State: AOAM532OkTaWvowVNcKGflgZymKr4GRuY7Pq6o4k3p9F//Iiss02pRW1
        hZUtJ7DqKd6r0yrHzUQc2GmAqQ==
X-Google-Smtp-Source: ABdhPJyV9225G6GhzTbG4x8q6OQiHe5mbw2XjxdHxilInipa53F7zqsr/KwXrSFQ1pK695aHz1Bf/Q==
X-Received: by 2002:a17:90a:3d0c:: with SMTP id h12mr26010674pjc.177.1606732510116;
        Mon, 30 Nov 2020 02:35:10 -0800 (PST)
Received: from chromium.org ([2401:fa00:1:b:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id m18sm21844330pjl.41.2020.11.30.02.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 02:35:09 -0800 (PST)
Date:   Mon, 30 Nov 2020 18:35:05 +0800
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Crystal Guo <crystal.guo@mediatek.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, yong.liang@mediatek.com,
        stanley.chu@mediatek.com, srv_heupstream@mediatek.com,
        seiya.wang@mediatek.com, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        yingjoe.chen@mediatek.com, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v6,2/3] reset-controller: ti: introduce a new reset handler
Message-ID: <20201130103505.GA3019533@chromium.org>
References: <20200930022159.5559-1-crystal.guo@mediatek.com>
 <20200930022159.5559-3-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930022159.5559-3-crystal.guo@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 10:21:58AM +0800, Crystal Guo wrote:
> Introduce ti_syscon_reset() to integrate assert and deassert together.
> If some modules need do serialized assert and deassert operations
> to reset itself, reset_control_reset can be called for convenience.
> 
> Such as reset-qcom-aoss.c, it integrates assert and deassert together
> by 'reset' method. MTK Socs also need this method to perform reset.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

> ---
>  drivers/reset/reset-ti-syscon.c | 40 ++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
> index a2635c21db7f..5d1f8306cd4f 100644
> --- a/drivers/reset/reset-ti-syscon.c
> +++ b/drivers/reset/reset-ti-syscon.c
> @@ -15,15 +15,22 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
>  
>  #include <dt-bindings/reset/ti-syscon.h>
>  
> +struct mediatek_reset_data {
> +	unsigned char *reset_bits;
> +	unsigned int reset_duration_us;
> +};
> +
>  /**
>   * struct ti_syscon_reset_control - reset control structure
>   * @assert_offset: reset assert control register offset from syscon base
> @@ -56,6 +63,7 @@ struct ti_syscon_reset_data {
>  	struct regmap *regmap;
>  	struct ti_syscon_reset_control *controls;
>  	unsigned int nr_controls;
> +	const struct mediatek_reset_data *reset_data;
>  };
>  
>  #define to_ti_syscon_reset_data(rcdev)	\
> @@ -158,9 +166,29 @@ static int ti_syscon_reset_status(struct reset_controller_dev *rcdev,
>  		!(control->flags & STATUS_SET);
>  }
>  
> +static int ti_syscon_reset(struct reset_controller_dev *rcdev,
> +				  unsigned long id)
> +{
> +	struct ti_syscon_reset_data *data = to_ti_syscon_reset_data(rcdev);
> +	int ret;
> +
> +	if (data->reset_data) {
> +		ret = ti_syscon_reset_assert(rcdev, id);
> +		if (ret)
> +			return ret;
> +		usleep_range(data->reset_data->reset_duration_us,
> +			data->reset_data->reset_duration_us * 2);
> +

There are many users using assert() and deassert() seperately
without any delay between them.

If there's a timing requirement between assertion and deassertion,
shouldn't there be a same amount of delay in assert?

> +		return ti_syscon_reset_deassert(rcdev, id);
> +	} else {
> +		return -ENOTSUPP;
> +	}
> +}
> +
>  static const struct reset_control_ops ti_syscon_reset_ops = {
>  	.assert		= ti_syscon_reset_assert,
>  	.deassert	= ti_syscon_reset_deassert,
> +	.reset		= ti_syscon_reset,
>  	.status		= ti_syscon_reset_status,
>  };
>  
> @@ -182,7 +210,11 @@ static int ti_syscon_reset_probe(struct platform_device *pdev)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> -	list = of_get_property(np, "ti,reset-bits", &size);
> +	data->reset_data = of_device_get_match_data(&pdev->dev);
> +	if (data->reset_data)
> +		list = of_get_property(np, data->reset_data->reset_bits, &size);
> +	else
> +		list = of_get_property(np, "ti,reset-bits", &size);
>  	if (!list || (size / sizeof(*list)) % 7 != 0) {
>  		dev_err(dev, "invalid DT reset description\n");
>  		return -EINVAL;
> @@ -217,8 +249,14 @@ static int ti_syscon_reset_probe(struct platform_device *pdev)
>  	return devm_reset_controller_register(dev, &data->rcdev);
>  }
>  
> +static const struct mediatek_reset_data mtk_reset_data = {
> +	.reset_bits = "mediatek,reset-bits",
> +	.reset_duration_us = 10,
> +};
> +
>  static const struct of_device_id ti_syscon_reset_of_match[] = {
>  	{ .compatible = "ti,syscon-reset", },
> +	{ .compatible = "mediatek,syscon-reset", .data = &mtk_reset_data},
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, ti_syscon_reset_of_match);
