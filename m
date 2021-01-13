Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41D72F4CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbhAMOE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbhAMOE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:04:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85EEE23382;
        Wed, 13 Jan 2021 14:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610546656;
        bh=+1kxR8vH18rqeWixw2gVBw9HQWeNytBO0/nYFFbzJ/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FfitW0nLrDbZU4DRMhAsrcPUK84kHTo99ipxUT+qTjxn8ukPBJ7l+0+rqT21iuo1G
         40ukcqtzPgTVMVHaZNDqAWFEEU2bAZaHzJejOYPhwZ8EQIkQzjBYQo20DSFRjVKne9
         35oaelCEtSmvuTGT9rXPC/Qg412RKbvSpOpDwLIOuuykpe9G3OKuVY7ZnTPMypDaw8
         OB9JJP2UjVVQlLpUeE8jcVq+rnqwcZMnruhsFG2YA+T9INRTsBJKIe2nKCo6iXvFWd
         /FaAVD8RjOU0QIda46vHsN/fxHGtEePEDIiCrnoIsrmQQPU19U8cnKfc5lhXiuhGtV
         AP/pMNoXO+5TA==
Date:   Wed, 13 Jan 2021 19:34:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/7] phy: ti: j721e-wiz: Configure full rate divider for
 AM64
Message-ID: <20210113140412.GP2771@vkoul-mobl>
References: <20201224114250.1083-1-kishon@ti.com>
 <20201224114250.1083-6-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224114250.1083-6-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-12-20, 17:12, Kishon Vijay Abraham I wrote:
> The frequency of the txmclk between PCIe and SERDES has
> changed to 250MHz from 500MHz. Configure full rate divider
> for AM64 accordingly.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/ti/phy-j721e-wiz.c | 43 +++++++++++++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> index 2a03191eac64..08acfab1ebe6 100644
> --- a/drivers/phy/ti/phy-j721e-wiz.c
> +++ b/drivers/phy/ti/phy-j721e-wiz.c
> @@ -101,6 +101,13 @@ static const struct reg_field p_standard_mode[WIZ_MAX_LANES] = {
>  	REG_FIELD(WIZ_LANECTL(3), 24, 25),
>  };
>  
> +static const struct reg_field p0_fullrt_div[WIZ_MAX_LANES] = {
> +	REG_FIELD(WIZ_LANECTL(0), 22, 23),
> +	REG_FIELD(WIZ_LANECTL(1), 22, 23),
> +	REG_FIELD(WIZ_LANECTL(2), 22, 23),
> +	REG_FIELD(WIZ_LANECTL(3), 22, 23),
> +};
> +
>  static const struct reg_field typec_ln10_swap =
>  					REG_FIELD(WIZ_SERDES_TYPEC, 30, 30);
>  
> @@ -193,6 +200,7 @@ static struct wiz_clk_div_sel clk_div_sel[] = {
>  enum wiz_type {
>  	J721E_WIZ_16G,
>  	J721E_WIZ_10G,
> +	AM64_WIZ_10G,
>  };
>  
>  #define WIZ_TYPEC_DIR_DEBOUNCE_MIN	100	/* ms */
> @@ -210,6 +218,7 @@ struct wiz {
>  	struct regmap_field	*p_align[WIZ_MAX_LANES];
>  	struct regmap_field	*p_raw_auto_start[WIZ_MAX_LANES];
>  	struct regmap_field	*p_standard_mode[WIZ_MAX_LANES];
> +	struct regmap_field	*p0_fullrt_div[WIZ_MAX_LANES];
>  	struct regmap_field	*pma_cmn_refclk_int_mode;
>  	struct regmap_field	*pma_cmn_refclk_mode;
>  	struct regmap_field	*pma_cmn_refclk_dig_div;
> @@ -380,7 +389,7 @@ static int wiz_regfield_init(struct wiz *wiz)
>  	}
>  
>  	clk_mux_sel = &wiz->clk_mux_sel[REFCLK_DIG];
> -	if (wiz->type == J721E_WIZ_10G)
> +	if (wiz->type == J721E_WIZ_10G || wiz->type == AM64_WIZ_10G)
>  		clk_mux_sel->field =
>  			devm_regmap_field_alloc(dev, regmap,
>  						refclk_dig_sel_10g);
> @@ -424,6 +433,14 @@ static int wiz_regfield_init(struct wiz *wiz)
>  				i);
>  			return PTR_ERR(wiz->p_standard_mode[i]);
>  		}
> +
> +		wiz->p0_fullrt_div[i] =
> +			devm_regmap_field_alloc(dev, regmap, p0_fullrt_div[i]);
> +		if (IS_ERR(wiz->p0_fullrt_div[i])) {
> +			dev_err(dev, "P%d_FULLRT_DIV reg field init failed\n",
> +				i);

single line?

> +			return PTR_ERR(wiz->p0_fullrt_div[i]);
> +		}
>  	}
>  
>  	wiz->typec_ln10_swap = devm_regmap_field_alloc(dev, regmap,
> @@ -719,6 +736,19 @@ static int wiz_phy_reset_assert(struct reset_controller_dev *rcdev,
>  	return ret;
>  }
>  
> +static int wiz_phy_fullrt_div(struct wiz *wiz, int lane)
> +{
> +	int ret = 0;

drop the variable..

> +
> +	if (wiz->type != AM64_WIZ_10G)
> +		return 0;
> +
> +	if (wiz->lane_phy_type[lane] == PHY_TYPE_PCIE)
> +		ret = regmap_field_write(wiz->p0_fullrt_div[lane], 0x1);

return regmap_
> +
> +	return ret;

return 0

> +}
> +
>  static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
>  				  unsigned long id)
>  {
> @@ -742,6 +772,10 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
>  		return ret;
>  	}
>  
> +	ret = wiz_phy_fullrt_div(wiz, id - 1);
> +	if (ret)
> +		return ret;
> +
>  	if (wiz->lane_phy_type[id - 1] == PHY_TYPE_DP)
>  		ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE);
>  	else
> @@ -769,6 +803,9 @@ static const struct of_device_id wiz_id_table[] = {
>  	{
>  		.compatible = "ti,j721e-wiz-10g", .data = (void *)J721E_WIZ_10G
>  	},
> +	{
> +		.compatible = "ti,am64-wiz-10g", .data = (void *)AM64_WIZ_10G
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, wiz_id_table);
> @@ -904,14 +941,14 @@ static int wiz_probe(struct platform_device *pdev)
>  	wiz->dev = dev;
>  	wiz->regmap = regmap;
>  	wiz->num_lanes = num_lanes;
> -	if (wiz->type == J721E_WIZ_10G)
> +	if (wiz->type == J721E_WIZ_10G || wiz->type == AM64_WIZ_10G)
>  		wiz->clk_mux_sel = clk_mux_sel_10g;
>  	else
>  		wiz->clk_mux_sel = clk_mux_sel_16g;
>  
>  	wiz->clk_div_sel = clk_div_sel;
>  
> -	if (wiz->type == J721E_WIZ_10G)
> +	if (wiz->type == J721E_WIZ_10G || wiz->type == AM64_WIZ_10G)
>  		wiz->clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_10G;
>  	else
>  		wiz->clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_16G;
> -- 
> 2.17.1

-- 
~Vinod
