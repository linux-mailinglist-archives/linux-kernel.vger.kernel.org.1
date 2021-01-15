Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48E42F71A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 05:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbhAOElB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 23:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbhAOElA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 23:41:00 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6B2C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:40:19 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id l207so8398265oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WvxX8eMBKQeiOYu3rBDxAoazeGoPgEH+0ctDwdLMVo0=;
        b=W2HgaemMy4iB1sZmL7hLe9+by+EyQ1kr1/vQL3BGusbPuIIJ2iOYmza+iCfiyeM0PN
         pgf3sams192fZsdXo/DiVBJjsvd6Y04x64qMcm4A5FurpHj+vuMAEhgdyaYgUTywuSEq
         qyAvZN9KtI2OeeRIueDYuo7XJBaRf6XSBSOJSgFOtfCRy3GBxbkqb+byDIND53Zyn5wI
         vuQfUnHVkCnnyQAQhMWVA8N22IR971nj/WjhxirsSOU394SZACZ4PgSH30KTsdmximye
         xy8VKkVBfsDoEZVWjGNDV2+KivufmzY+XCzQK+R1A5eoipU+Su+DhNRNofwbEcFNJAi0
         SCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WvxX8eMBKQeiOYu3rBDxAoazeGoPgEH+0ctDwdLMVo0=;
        b=VzGrvKHKnmbPOL+ptOlaOYaMOmDQNr+opvpzI8vDyVD1lJJhjN6gV6ADj6PpFLT89T
         kgbUdILE8Gkf95xy/Urnd91GpWBSsSjXjGyUdNjfAbcPzyp3ou3WGUWVmIgAeaM/01BT
         5DHw2rjZgsOpAjR2HDlmLSyVreiEHbPl8g5nsd6X0PeHeBINA609Kz1/4RgFKf3+467D
         mGyHO36SI8BKydsNcQIpCLp75Yx9+WXCAF/0dKe+Pp9Bb83OOS88xkGxrf/+NdLWV4qS
         CeZzOWleP2Qg79v1Lb11uIHAXmUHfuXaiIx8A4GZcLyIoz/Qge4lLkYMJa7+Kp0GZKPX
         i51Q==
X-Gm-Message-State: AOAM532cdGof0s5gDyJLc08t4g8ugiBg47BkiaFxe+Vu4wYgIjZQqcBj
        4z2AXQS0CM45a+I38fj2i8xxmP6zRC/80g==
X-Google-Smtp-Source: ABdhPJwjB9VsEmpjfnUvly0rRpkB9ZsEiqGnVoDB20LOGXKbkVbwxBmIp48WVJyz/GAsnZ0CwxPhTQ==
X-Received: by 2002:aca:b03:: with SMTP id 3mr4657072oil.157.1610685619237;
        Thu, 14 Jan 2021 20:40:19 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z38sm1547056ooi.34.2021.01.14.20.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 20:40:18 -0800 (PST)
Date:   Thu, 14 Jan 2021 22:40:16 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        sumit.semwal@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org
Subject: Re: [PATCH v2 1/7] regulator: qcom-labibb: Implement voltage
 selector ops
Message-ID: <YAEcsNmsPsi11kkM@builder.lan>
References: <20210113194214.522238-1-angelogioacchino.delregno@somainline.org>
 <20210113194214.522238-2-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113194214.522238-2-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 Jan 13:42 CST 2021, AngeloGioacchino Del Regno wrote:

> Implement {get,set}_voltage_sel, list_voltage, map_voltage with
> the useful regulator regmap helpers in order to be able to manage
> the voltage of LAB (positive) and IBB (negative) regulators.
> 
> In particular, the supported ranges are the following:
> - LAB (pos):  4600mV to  6100mV with 100mV stepping,
> - IBB (neg): -7700mV to -1400mV with 100mV stepping.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/regulator/qcom-labibb-regulator.c | 28 +++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/regulator/qcom-labibb-regulator.c b/drivers/regulator/qcom-labibb-regulator.c
> index 8ccf572394a2..9f51c96f16fb 100644
> --- a/drivers/regulator/qcom-labibb-regulator.c
> +++ b/drivers/regulator/qcom-labibb-regulator.c
> @@ -19,6 +19,12 @@
>  #define PMI8998_IBB_REG_BASE		0xdc00
>  
>  #define REG_LABIBB_STATUS1		0x08
> +
> +#define REG_LABIBB_VOLTAGE		0x41
> + #define LABIBB_VOLTAGE_OVERRIDE_EN	BIT(7)
> + #define LAB_VOLTAGE_SET_MASK		GENMASK(3, 0)
> + #define IBB_VOLTAGE_SET_MASK		GENMASK(5, 0)
> +
>  #define REG_LABIBB_ENABLE_CTL		0x46
>  #define LABIBB_STATUS1_VREG_OK_BIT	BIT(7)
>  #define LABIBB_CONTROL_ENABLE		BIT(7)
> @@ -51,6 +57,10 @@ static const struct regulator_ops qcom_labibb_ops = {
>  	.enable			= regulator_enable_regmap,
>  	.disable		= regulator_disable_regmap,
>  	.is_enabled		= regulator_is_enabled_regmap,
> +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> +	.list_voltage		= regulator_list_voltage_linear_range,
> +	.map_voltage		= regulator_map_voltage_linear_range,
>  };
>  
>  static const struct regulator_desc pmi8998_lab_desc = {
> @@ -59,9 +69,18 @@ static const struct regulator_desc pmi8998_lab_desc = {
>  	.enable_val		= LABIBB_CONTROL_ENABLE,
>  	.enable_time		= LAB_ENABLE_TIME,
>  	.poll_enabled_time	= LABIBB_POLL_ENABLED_TIME,
> +	.vsel_reg		= (PMI8998_LAB_REG_BASE + REG_LABIBB_VOLTAGE),
> +	.vsel_mask		= LAB_VOLTAGE_SET_MASK,
> +	.apply_reg		= (PMI8998_LAB_REG_BASE + REG_LABIBB_VOLTAGE),
> +	.apply_bit		= LABIBB_VOLTAGE_OVERRIDE_EN,
>  	.off_on_delay		= LABIBB_OFF_ON_DELAY,
>  	.owner			= THIS_MODULE,
>  	.type			= REGULATOR_VOLTAGE,
> +	.linear_ranges		= (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(4600000, 0, 15, 100000),
> +	},
> +	.n_linear_ranges	= 1,
> +	.n_voltages		= 16,
>  	.ops			= &qcom_labibb_ops,
>  };
>  
> @@ -71,9 +90,18 @@ static const struct regulator_desc pmi8998_ibb_desc = {
>  	.enable_val		= LABIBB_CONTROL_ENABLE,
>  	.enable_time		= IBB_ENABLE_TIME,
>  	.poll_enabled_time	= LABIBB_POLL_ENABLED_TIME,
> +	.vsel_reg		= (PMI8998_IBB_REG_BASE + REG_LABIBB_VOLTAGE),
> +	.vsel_mask		= IBB_VOLTAGE_SET_MASK,
> +	.apply_reg		= (PMI8998_IBB_REG_BASE + REG_LABIBB_VOLTAGE),
> +	.apply_bit		= LABIBB_VOLTAGE_OVERRIDE_EN,
>  	.off_on_delay		= LABIBB_OFF_ON_DELAY,
>  	.owner			= THIS_MODULE,
>  	.type			= REGULATOR_VOLTAGE,
> +	.linear_ranges		= (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(1400000, 0, 63, 100000),
> +	},
> +	.n_linear_ranges	= 1,
> +	.n_voltages		= 64,
>  	.ops			= &qcom_labibb_ops,
>  };
>  
> -- 
> 2.29.2
> 
