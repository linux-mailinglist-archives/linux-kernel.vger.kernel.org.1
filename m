Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C82F71C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 05:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbhAOExp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 23:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbhAOExn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 23:53:43 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C12C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:53:03 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id c18so1665179oto.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kw9AhzRyZK2nl5NYrpMkQfnyJ0KegvY7i2qry966wKA=;
        b=Viahv/oGVWlwJJ5kbQq0t5rJEEGrhnea8t5w0ctvsI1E3sUmLehcwc5TW9ZTonYLWY
         yIGGrJ3ljxhclwGJHPca5Hiv+qxLJKC4BCzM17R9GMunbQNvUIpK9m0qJkFTVBRNKVKh
         b81wM/P1kor4egLFm1vM9BOWLddPW6F8BOQ2X3+oQm6a8yF0/LbMnofxfAg8or+ChraM
         mBz+49lStKhomKj6BO0zSKHc6k7H/8QjGoGP/pdKzZiIQNKwurizeh5gofqdMi5ex2B/
         I3BvP5UBeCCdBfWK+l72b0IJ365GQ27T6FXfdBr0fAOVUEqCefqLII0yh9EuKciqzDO5
         XzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kw9AhzRyZK2nl5NYrpMkQfnyJ0KegvY7i2qry966wKA=;
        b=hSf+2C5wpl5iXiIA+xBHO3dABRVyIhdDMvjXc6o875L5aX50jFpII/FpZthxzPegX5
         pkpzKrAlWF4G+4XUQiy1vzo+SgXZpNn4WRmYjEEpmFOBV1+Ji+irTovffWNE0/7ZkIz5
         RXkDoGGx4b6JG7R6YSc+llI7c6PX8hmiMgalLaLixB7zvMrXNhsYFzPNVuLr80gcIW2D
         1V7cMxFN15IDDuZ8qzkd1hOUnfYPjUtATOWEIg7WS9S5g8s0y/eLecWyx+Tn1UOh25xo
         DM5KMTHE5BqIz5q7SH7DaoPskmWuy+VvR4V7hq55QUbYAlBI9O6CcBGp26PTocQM+CFs
         EE1w==
X-Gm-Message-State: AOAM532GPd2M5ZaYp0fR6Adwab7V/AUxrg25/1MUDgD2F3swJZZ0gO0q
        +8fxlqnCgNIdkKlNxIA8leWGkg==
X-Google-Smtp-Source: ABdhPJzRna1Zhp4kzclLUnXVi5k8JOAXkkAdTc61rLcJOZQuWFJycLxzDD/9XP/saEKa0KbDH4unsg==
X-Received: by 2002:a9d:62d7:: with SMTP id z23mr7224875otk.353.1610686382852;
        Thu, 14 Jan 2021 20:53:02 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f67sm1548807otb.60.2021.01.14.20.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 20:53:02 -0800 (PST)
Date:   Thu, 14 Jan 2021 22:53:00 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        sumit.semwal@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org
Subject: Re: [PATCH v2 3/7] regulator: qcom-labibb: Implement pull-down,
 softstart, active discharge
Message-ID: <YAEfrIR/HZmQLeQM@builder.lan>
References: <20210113194214.522238-1-angelogioacchino.delregno@somainline.org>
 <20210113194214.522238-4-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113194214.522238-4-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 Jan 13:42 CST 2021, AngeloGioacchino Del Regno wrote:

> Soft start is required to avoid inrush current during LAB ramp-up and
> IBB ramp-down, protecting connected hardware to which we supply voltage.
> 
> Since soft start is configurable on both LAB and IBB regulators, it
> was necessary to add two DT properties, respectively "qcom,soft-start-us"
> to control LAB ramp-up and "qcom,discharge-resistor-kohms" to control
> the discharge resistor for IBB ramp-down, which obviously brought the
> need of implementing a of_parse callback for both regulators.
> 
> Finally, also implement pull-down mode in order to avoid unpredictable
> behavior when the regulators are disabled (random voltage spikes etc).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/regulator/qcom-labibb-regulator.c | 94 +++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/drivers/regulator/qcom-labibb-regulator.c b/drivers/regulator/qcom-labibb-regulator.c
> index d364f54ad294..38ab1eba1c59 100644
> --- a/drivers/regulator/qcom-labibb-regulator.c
> +++ b/drivers/regulator/qcom-labibb-regulator.c
> @@ -29,12 +29,23 @@
>  #define LABIBB_STATUS1_VREG_OK_BIT	BIT(7)
>  #define LABIBB_CONTROL_ENABLE		BIT(7)
>  
> +#define REG_LABIBB_PD_CTL		0x47
> + #define LAB_PD_CTL_MASK		GENMASK(1, 0)
> + #define IBB_PD_CTL_MASK		(BIT(0) | BIT(7))
> + #define LAB_PD_CTL_STRONG_PULL		BIT(0)
> + #define IBB_PD_CTL_HALF_STRENGTH	BIT(0)
> + #define IBB_PD_CTL_EN			BIT(7)
> +
>  #define REG_LABIBB_CURRENT_LIMIT	0x4b
>   #define LAB_CURRENT_LIMIT_MASK		GENMASK(2, 0)
>   #define IBB_CURRENT_LIMIT_MASK		GENMASK(4, 0)
>   #define LAB_CURRENT_LIMIT_OVERRIDE_EN	BIT(3)
>   #define LABIBB_CURRENT_LIMIT_EN	BIT(7)
>  
> +#define REG_IBB_PWRUP_PWRDN_CTL_1	0x58
> + #define IBB_CTL_1_DISCHARGE_EN		BIT(2)
> +
> +#define REG_LABIBB_SOFT_START_CTL	0x5f
>  #define REG_LABIBB_SEC_ACCESS		0xd0
>   #define LABIBB_SEC_UNLOCK_CODE		0xa5
>  
> @@ -60,6 +71,8 @@ struct labibb_regulator {
>  	struct labibb_current_limits	uA_limits;
>  	u16				base;
>  	u8				type;
> +	u8				dischg_sel;
> +	u8				soft_start_sel;
>  };
>  
>  struct labibb_regulator_data {
> @@ -120,6 +133,70 @@ static int qcom_labibb_get_current_limit(struct regulator_dev *rdev)
>  	return (cur_step * lim->uA_step) + lim->uA_min;
>  }
>  
> +static int qcom_labibb_set_soft_start(struct regulator_dev *rdev)
> +{
> +	struct labibb_regulator *vreg = rdev_get_drvdata(rdev);
> +	u32 val = 0;
> +
> +	if (vreg->type == QCOM_IBB_TYPE)
> +		val = vreg->dischg_sel;
> +	else
> +		val = vreg->soft_start_sel;
> +
> +	return regmap_write(rdev->regmap, rdev->desc->soft_start_reg, val);
> +}
> +
> +static int qcom_labibb_get_table_sel(const int *table, int sz, u32 value)
> +{
> +	int i;
> +
> +	for (i = 0; i < sz; i++)
> +		if (table[i] == value)
> +			return i;
> +	return -EINVAL;
> +}
> +
> +/* IBB discharge resistor values in KOhms */
> +static const int dischg_resistor_values[] = { 300, 64, 32, 16 };
> +
> +/* Soft start time in microseconds */
> +static const int soft_start_values[] = { 200, 400, 600, 800 };
> +
> +static int qcom_labibb_of_parse_cb(struct device_node *np,
> +				   const struct regulator_desc *desc,
> +				   struct regulator_config *config)
> +{
> +	struct labibb_regulator *vreg = config->driver_data;
> +	u32 dischg_kohms, soft_start_time;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "qcom,discharge-resistor-kohms",
> +				       &dischg_kohms);
> +	if (ret)
> +		dischg_kohms = 300;

Nit, if you just initialize dischg_kohms to 300 during definition you
can rely on of_property_read_u32() not updating the value on failure...

That said, I think this patch looks good.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
