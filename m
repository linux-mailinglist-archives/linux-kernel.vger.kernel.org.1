Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154F52F7447
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbhAOI1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbhAOI1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:27:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D65C061575
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 00:26:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l12so3129288wry.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 00:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LWcsB7Fy+yLTPLzIuQGrx+rRBoG4EfEXYypjOgcwSG4=;
        b=A9brmp1RHdPYYqauAqHLOvzc609yHcplYI0KDekOQf57yQS1AYg6IcCTjjx37s7yhn
         4bokj6IbdppHMLXShUGjbdernahCDiqWZFoajQuIAQws7Pb46ZK71/y8LfWrz00GmKm5
         s5mkzmP1faLp+NkQqeWyvefoqjBptosSAlBBgH6U1tefuPLPZ/ybaDKyTVrqAyGOONW9
         EBitCHmfuQr1GNrY3HhSvzH4CFYWsqF+CANDnAhPSIFwP6u4c/aQOYBM60JHcpp1YXeP
         LY+yF9AC2rik3UcYQEMfujKbNWQ7jAVK2zANBJdzxo/22fybZNaVlBugPna7hFF7wSCF
         dcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LWcsB7Fy+yLTPLzIuQGrx+rRBoG4EfEXYypjOgcwSG4=;
        b=ZY2nKhQAtrL5eEeDrOIn/ejrf68iE8SvFcCCmKUBsy70oLADUdgC0qa+nEIUKJ6cTv
         0Aka/Q+EqAIGr0vtxoGvpoGoimCuVOj8APYS8v8wrsl+EkFcuKeQgBJCtKjyXWpl+yM0
         LclOZEafr0Zxa9tk1kkukAOgy9b9jE1C9D0JG0ci58aSWKcVHjtbcZ25Xyk0p8LHG2qU
         ZG0+cJX3138fLD85qCmSvPHSOyEwZXzXyLMKQUlZjWavYx1YeTxVOFEfFSRk4j5E+ouZ
         QofOy/G/odEw4EQMONFHBZRP/+dWHD6AwUzpgO6YRYBwXJClMayHkdcPS4Tymayxu9BV
         v6hA==
X-Gm-Message-State: AOAM533J+kzTcz0KWXfHKW5r44rgw587FsTIS6/7T2vbN2UFbcgV5WaR
        ZMeuwHmyRxw9mz4rK1Xfb8fmDw==
X-Google-Smtp-Source: ABdhPJxjBEp6qgWH6zS+0HivGqRPWNTwGa1FZd6o8KKHiKZ2i+SAsGoEkDQcHTz8bZOWovrg5RDfHQ==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr12293731wrq.189.1610699199310;
        Fri, 15 Jan 2021 00:26:39 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id c10sm15318909wrb.92.2021.01.15.00.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 00:26:38 -0800 (PST)
Date:   Fri, 15 Jan 2021 08:26:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: Re: [PATCH 11/15] regulator: rohm-regulator: SNVS dvs and linear
 voltage support
Message-ID: <20210115082636.GF3975472@dell>
References: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
 <f0af653b3d3d56bd1852468502518a54b31b1f10.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0af653b3d3d56bd1852468502518a54b31b1f10.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jan 2021, Matti Vaittinen wrote:

> The helper for obtaining HW-state based DVS voltage levels currently only
> works for regulators using linear-ranges. Extend support to regulators with
> simple linear mappings and add also proper error path if pickable-ranges
> regulators call this.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/regulator/rohm-regulator.c | 23 +++++++++++++++++++++--
>  include/linux/mfd/rohm-generic.h   |  6 +++++-
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-regulator.c
> index 399002383b28..9248bd63afa9 100644
> --- a/drivers/regulator/rohm-regulator.c
> +++ b/drivers/regulator/rohm-regulator.c
> @@ -22,13 +22,26 @@ static int set_dvs_level(const struct regulator_desc *desc,
>  			return ret;
>  		return 0;
>  	}
> -
> +	/* If voltage is set to 0 => disable */
>  	if (uv == 0) {
>  		if (omask)
>  			return regmap_update_bits(regmap, oreg, omask, 0);
>  	}
> +	/* Some setups don't allow setting own voltage but do allow enabling */
> +	if (!mask) {
> +		if (omask)
> +			return regmap_update_bits(regmap, oreg, omask, omask);
> +
> +		return -EINVAL;
> +	}
>  	for (i = 0; i < desc->n_voltages; i++) {
> -		ret = regulator_desc_list_voltage_linear_range(desc, i);
> +		/* NOTE to next hacker - Does not support pickable ranges */
> +		if (desc->linear_range_selectors)
> +			return -EINVAL;
> +		if (desc->n_linear_ranges)
> +			ret = regulator_desc_list_voltage_linear_range(desc, i);
> +		else
> +			ret = regulator_desc_list_voltage_linear(desc, i);
>  		if (ret < 0)
>  			continue;
>  		if (ret == uv) {
> @@ -79,6 +92,12 @@ int rohm_regulator_set_dvs_levels(const struct rohm_dvs_config *dvs,
>  				mask = dvs->lpsr_mask;
>  				omask = dvs->lpsr_on_mask;
>  				break;
> +			case ROHM_DVS_LEVEL_SNVS:
> +				prop = "rohm,dvs-snvs-voltage";
> +				reg = dvs->snvs_reg;
> +				mask = dvs->snvs_mask;
> +				omask = dvs->snvs_on_mask;
> +				break;
>  			default:
>  				return -EINVAL;
>  			}
> diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
> index e99e569d3cc1..2f5fbfd0c6b3 100644
> --- a/include/linux/mfd/rohm-generic.h
> +++ b/include/linux/mfd/rohm-generic.h
> @@ -27,7 +27,8 @@ enum {
>  	ROHM_DVS_LEVEL_IDLE,
>  	ROHM_DVS_LEVEL_SUSPEND,
>  	ROHM_DVS_LEVEL_LPSR,
> -	ROHM_DVS_LEVEL_MAX = ROHM_DVS_LEVEL_LPSR,
> +	ROHM_DVS_LEVEL_SNVS,
> +	ROHM_DVS_LEVEL_MAX = ROHM_DVS_LEVEL_SNVS,
>  };

Does this actually work?

The code that consumes it looks like:

    for (i = 0; i < ROHM_DVS_LEVEL_MAX && !ret; i++)

So it will loop through like:

0 (ROHM_DVS_LEVEL_IDLE)
1 (ROHM_DVS_LEVEL_SUSPEND)
2 (ROHM_DVS_LEVEL_LPSR)
3 (ROHM_DVS_LEVEL_SNVS)

Then break, since 'i' will be (== 4) not (< 4).

So the following will never be used:

4 (ROHM_DVS_LEVEL_MAX = ROHM_DVS_LEVEL_SNVS)

Unless I'm missing something, I think MAX should be the last entry.

>  /**
> @@ -66,6 +67,9 @@ struct rohm_dvs_config {
>  	unsigned int lpsr_reg;
>  	unsigned int lpsr_mask;
>  	unsigned int lpsr_on_mask;
> +	unsigned int snvs_reg;
> +	unsigned int snvs_mask;
> +	unsigned int snvs_on_mask;
>  };
>  
>  #if IS_ENABLED(CONFIG_REGULATOR_ROHM)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
