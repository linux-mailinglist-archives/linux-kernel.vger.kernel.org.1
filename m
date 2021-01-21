Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671172FE69E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbhAUJoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbhAUJnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:43:16 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8464EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:42:35 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id w1so1644949ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1sxdGZD2/X5bbv5Su2MmfvmNcVhU6OquqVWEeRoJSE=;
        b=SjERRRhg5yIjkuVWky5j9YXJkNAc2YBsj+xwPgjKsFlZIv1APv1lh8d5uK8uINigmq
         tVkFp99+R2orIYEQN48KyjAqhAjyuepvdEz3Drv5qpVTHVAQ5pnNso+nvU/Y9l+DMG2Y
         ZqAfa6XDiOJjD5kWGjTHmpPE41/yOUqcHnzWmwPvKHf/h2f9vtdm1PGuK0kgsC/3f4D2
         Rqa2KYyqPfXM1vn1NP/EGhaCF9vWCYd/3Cd9T8bPbAiVSD6xfVMAPZNnGCWSrPn1QJZS
         GLlgTgJj/yKXs/Bw+YFh9LeknklhvsGArdZKuIM3j8gasuaJZYlQMidstnetIFXF5umF
         mwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=q1sxdGZD2/X5bbv5Su2MmfvmNcVhU6OquqVWEeRoJSE=;
        b=NZo6ul/MQ0pP194J/UeMSnSVAwx+sgXH5IPQBWz0nundAugPzo/cc8MNMg2dfMjzU2
         xq+Md199T6772re4ZHIIunejLXM3tOCPB1mPPEkl9RRBgCOJZmQ6GltdQyVL05+OyECF
         xfo1dYRI0VqfsV2cbe4yrw75+hUB9I0yIlwya2EIkUREHTwFHtYY/aiLBwxkQ548hVDv
         CELsO1IZbO7BKgemCtgnxnhilY8Bo7lev6PzQC1ONNAwZGb536ipJz+TgZcXyrsekuRY
         7gWWkxC+zEp4LGfGFz2wlYsqv49nLoxC7kaqvfz34ezZF5HS/r2j+5MHGlMC15fMIXVk
         aD/w==
X-Gm-Message-State: AOAM530BxO5J9hO6X1jpTw8TpJg7c9f4UNOpj2YWbsL7b8qTvMH+DGlt
        f+AD1Ptt3CKN2/YcCH3IN6A=
X-Google-Smtp-Source: ABdhPJwq2V6qHp7HnDgzHBV5QXdFskHuDe1T8q2q0GUrm56nR3mKk86ZU+aHzhaORjI09+u2xKJlEw==
X-Received: by 2002:a17:906:b055:: with SMTP id bj21mr8952974ejb.355.1611222154240;
        Thu, 21 Jan 2021 01:42:34 -0800 (PST)
Received: from ?IPv6:2a02:8070:b9d:f2fc:7e7a:91ff:fe47:1404? ([2a02:8070:b9d:f2fc:7e7a:91ff:fe47:1404])
        by smtp.googlemail.com with ESMTPSA id f5sm1990735ejz.70.2021.01.21.01.42.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 01:42:33 -0800 (PST)
Message-ID: <1611222152.1561.5.camel@googlemail.com>
Subject: Re: [PATCH] regulator: pf8x00: Add suspend support
From:   Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Adrien Grassein <adrien.grassein@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 21 Jan 2021 10:42:32 +0100
In-Reply-To: <4c2e79d4fa96befdc9a6c59c3ff27b0a34f9fb56.camel@googlemail.com>
References: <4c2e79d4fa96befdc9a6c59c3ff27b0a34f9fb56.camel@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jagan,

 as your new role as Maintainer of this driver, is there a chance to get
your Feedback/Ack/Review/Signed anytime soon?

Thanks
  -- Christoph

On Sun, 2021-01-17 at 21:49 +0100, Christoph Fritz wrote:
> This patch adds suspend/resume support so that it is possible to
> configure the LDOs and BUCKs as on or off during suspend phase as
> well as to configure suspend specific voltages.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  drivers/regulator/pf8x00-regulator.c | 75 ++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
> index 1e5582d73405..02892e04acce 100644
> --- a/drivers/regulator/pf8x00-regulator.c
> +++ b/drivers/regulator/pf8x00-regulator.c
> @@ -125,8 +125,12 @@ enum pf8x00_devid {
>  #define PF8X00_DEVICE_FAM_MASK		GENMASK(7, 4)
>  #define PF8X00_DEVICE_ID_MASK		GENMASK(3, 0)
>  
> -struct pf8x00_regulator {
> +struct pf8x00_regulator_data {
>  	struct regulator_desc desc;
> +	unsigned int suspend_enable_reg;
> +	unsigned int suspend_enable_mask;
> +	unsigned int suspend_voltage_reg;
> +	unsigned int suspend_voltage_cache;
>  };
>  
>  struct pf8x00_chip {
> @@ -276,6 +280,53 @@ static int pf8x00_of_parse_cb(struct device_node *np,
>  	return 0;
>  }
>  
> +static int pf8x00_suspend_enable(struct regulator_dev *rdev)
> +{
> +	struct pf8x00_regulator_data *regl = rdev_get_drvdata(rdev);
> +	struct regmap *rmap = rdev_get_regmap(rdev);
> +
> +	return regmap_update_bits(rmap, regl->suspend_enable_reg,
> +				  regl->suspend_enable_mask,
> +				  regl->suspend_enable_mask);
> +}
> +
> +static int pf8x00_suspend_disable(struct regulator_dev *rdev)
> +{
> +	struct pf8x00_regulator_data *regl = rdev_get_drvdata(rdev);
> +	struct regmap *rmap = rdev_get_regmap(rdev);
> +
> +	return regmap_update_bits(rmap, regl->suspend_enable_reg,
> +				  regl->suspend_enable_mask, 0);
> +}
> +
> +static int pf8x00_set_suspend_voltage(struct regulator_dev *rdev, int uV)
> +{
> +	struct pf8x00_regulator_data *regl = rdev_get_drvdata(rdev);
> +	int ret;
> +
> +	if (regl->suspend_voltage_cache == uV)
> +		return 0;
> +
> +	ret = regulator_map_voltage_iterate(rdev, uV, uV);
> +	if (ret < 0) {
> +		dev_err(rdev_get_dev(rdev), "failed to map %i uV\n", uV);
> +		return ret;
> +	}
> +
> +	dev_dbg(rdev_get_dev(rdev), "uV: %i, reg: 0x%x, msk: 0x%x, val: 0x%x\n",
> +		uV, regl->suspend_voltage_reg, regl->desc.vsel_mask, ret);
> +	ret = regmap_update_bits(rdev->regmap, regl->suspend_voltage_reg,
> +				 regl->desc.vsel_mask, ret);
> +	if (ret < 0) {
> +		dev_err(rdev_get_dev(rdev), "failed to set %i uV\n", uV);
> +		return ret;
> +	}
> +
> +	regl->suspend_voltage_cache = uV;
> +
> +	return 0;
> +}
> +
>  static const struct regulator_ops pf8x00_ldo_ops = {
>  	.enable = regulator_enable_regmap,
>  	.disable = regulator_disable_regmap,
> @@ -283,6 +334,9 @@ static const struct regulator_ops pf8x00_ldo_ops = {
>  	.list_voltage = regulator_list_voltage_table,
>  	.set_voltage_sel = regulator_set_voltage_sel_regmap,
>  	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +	.set_suspend_enable = pf8x00_suspend_enable,
> +	.set_suspend_disable = pf8x00_suspend_disable,
> +	.set_suspend_voltage = pf8x00_set_suspend_voltage,
>  };
>  
> 
> @@ -295,6 +349,9 @@ static const struct regulator_ops pf8x00_buck1_6_ops = {
>  	.get_voltage_sel = regulator_get_voltage_sel_regmap,
>  	.get_current_limit = regulator_get_current_limit_regmap,
>  	.set_current_limit = regulator_set_current_limit_regmap,
> +	.set_suspend_enable = pf8x00_suspend_enable,
> +	.set_suspend_disable = pf8x00_suspend_disable,
> +	.set_suspend_voltage = pf8x00_set_suspend_voltage,
>  };
>  
>  static const struct regulator_ops pf8x00_buck7_ops = {
> @@ -306,6 +363,8 @@ static const struct regulator_ops pf8x00_buck7_ops = {
>  	.get_voltage_sel = regulator_get_voltage_sel_regmap,
>  	.get_current_limit = regulator_get_current_limit_regmap,
>  	.set_current_limit = regulator_set_current_limit_regmap,
> +	.set_suspend_enable = pf8x00_suspend_enable,
> +	.set_suspend_disable = pf8x00_suspend_disable,
>  };
>  
>  static const struct regulator_ops pf8x00_vsnvs_ops = {
> @@ -337,6 +396,9 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
>  			.disable_val = 0x0,			\
>  			.enable_mask = 2,			\
>  		},						\
> +		.suspend_enable_reg = (base) + LDO_CONFIG2,	\
> +		.suspend_enable_mask = 1,			\
> +		.suspend_voltage_reg = (base) + LDO_STBY_VOLT,	\
>  	}
>  
>  #define PF8X00BUCK(_id, _name, base, voltages)			\
> @@ -367,6 +429,9 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
>  			.enable_mask = 0x3,			\
>  			.enable_time = 500,			\
>  		},						\
> +		.suspend_enable_reg = (base) + SW_MODE1,	\
> +		.suspend_enable_mask = 0xc,			\
> +		.suspend_voltage_reg = (base) + SW_STBY_VOLT,	\
>  	}
>  
>  #define PF8X00BUCK7(_name, base, voltages)			\
> @@ -415,7 +480,7 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
>  		},						\
>  	}
>  
> -static struct pf8x00_regulator pf8x00_regulators_data[PF8X00_MAX_REGULATORS] = {
> +static struct pf8x00_regulator_data pf8x00_regs_data[PF8X00_MAX_REGULATORS] = {
>  	PF8X00LDO(1, "ldo1", PF8X00_LDO_BASE(PF8X00_LDO1), pf8x00_ldo_voltages),
>  	PF8X00LDO(2, "ldo2", PF8X00_LDO_BASE(PF8X00_LDO2), pf8x00_ldo_voltages),
>  	PF8X00LDO(3, "ldo3", PF8X00_LDO_BASE(PF8X00_LDO3), pf8x00_ldo_voltages),
> @@ -500,12 +565,12 @@ static int pf8x00_i2c_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> -	for (id = 0; id < ARRAY_SIZE(pf8x00_regulators_data); id++) {
> -		struct pf8x00_regulator *data = &pf8x00_regulators_data[id];
> +	for (id = 0; id < ARRAY_SIZE(pf8x00_regs_data); id++) {
> +		struct pf8x00_regulator_data *data = &pf8x00_regs_data[id];
>  		struct regulator_dev *rdev;
>  
>  		config.dev = chip->dev;
> -		config.driver_data = chip;
> +		config.driver_data = data;
>  		config.regmap = chip->regmap;
>  
>  		rdev = devm_regulator_register(&client->dev, &data->desc, &config);



