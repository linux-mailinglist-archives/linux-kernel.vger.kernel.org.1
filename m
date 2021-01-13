Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136AE2F4CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbhAMOMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:12:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbhAMOMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:12:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 054AB233F8;
        Wed, 13 Jan 2021 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610547131;
        bh=CYzpYJ/zSgUm4o/5ROL9LQckIZPsZNyRnCVwmm4rHe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0oQ6mQBnbYPPhigkVShQGfwXtq13TNBpPLLdh44s11xhxb7ZKGVuFcDq8kvb9Uaw
         RsWD8a7K/uXlzNLVdPx9900hotGw++TGkBs0FmIgKNxqX7a0ERBgfAGg2A57bjXk6C
         9oyfUJY9J5/ALoxeNqYkFsZvhTWChzf9IfqsFbL39Iv62XGjL/OYV12CJBAKLFsrc5
         agrGuoJ3pAXSAFu5LeZidhcDTwZ2khHtaSsydC0j3Ys0AzGIP8/huHhaBUon1/1esQ
         POawySCuBJbVpvHk4r7WH3MTRYOkctgvwUmJmk8PdC8p3zpUqukiEnDfIITac7Kgwo
         EZUY7Vzorioxw==
Date:   Wed, 13 Jan 2021 19:42:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/7] phy: ti: j721e-wiz: Enable reference clock output in
 cmn_refclk_<p/m>
Message-ID: <20210113141206.GQ2771@vkoul-mobl>
References: <20201224114250.1083-1-kishon@ti.com>
 <20201224114250.1083-7-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224114250.1083-7-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-12-20, 17:12, Kishon Vijay Abraham I wrote:
> cmn_refclk_<p/m> lines in Torrent SERDES is used for connecting external
> reference clock. cmn_refclk_<p/m> can also be configured to output the
> reference clock. In order to drive the refclk out from the SERDES
> (Cadence Torrent), PHY_EN_REFCLK should be set in SERDES_RST of WIZ.
> Model PHY_EN_REFCLK as a clock, so that platforms like AM642 EVM can
> enable it.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/ti/phy-j721e-wiz.c | 115 +++++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
> 
> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> index 08acfab1ebe6..d60a9a01a8b2 100644
> --- a/drivers/phy/ti/phy-j721e-wiz.c
> +++ b/drivers/phy/ti/phy-j721e-wiz.c
> @@ -54,6 +54,7 @@ enum wiz_refclk_div_sel {
>  
>  static const struct reg_field por_en = REG_FIELD(WIZ_SERDES_CTRL, 31, 31);
>  static const struct reg_field phy_reset_n = REG_FIELD(WIZ_SERDES_RST, 31, 31);
> +static const struct reg_field phy_en_refclk = REG_FIELD(WIZ_SERDES_RST, 30, 30);
>  static const struct reg_field pll1_refclk_mux_sel =
>  					REG_FIELD(WIZ_SERDES_RST, 29, 29);
>  static const struct reg_field pll0_refclk_mux_sel =
> @@ -141,6 +142,15 @@ struct wiz_clk_div_sel {
>  	const char		*node_name;
>  };
>  
> +struct wiz_phy_en_refclk {
> +	struct clk_hw		hw;
> +	struct regmap_field	*phy_en_refclk;
> +	struct clk_init_data	clk_data;
> +};
> +
> +#define to_wiz_phy_en_refclk(_hw)	\
> +			container_of(_hw, struct wiz_phy_en_refclk, hw)
> +
>  static struct wiz_clk_mux_sel clk_mux_sel_16g[] = {
>  	{
>  		/*
> @@ -214,6 +224,7 @@ struct wiz {
>  	unsigned int		clk_div_sel_num;
>  	struct regmap_field	*por_en;
>  	struct regmap_field	*phy_reset_n;
> +	struct regmap_field	*phy_en_refclk;
>  	struct regmap_field	*p_enable[WIZ_MAX_LANES];
>  	struct regmap_field	*p_align[WIZ_MAX_LANES];
>  	struct regmap_field	*p_raw_auto_start[WIZ_MAX_LANES];
> @@ -450,9 +461,96 @@ static int wiz_regfield_init(struct wiz *wiz)
>  		return PTR_ERR(wiz->typec_ln10_swap);
>  	}
>  
> +	wiz->phy_en_refclk = devm_regmap_field_alloc(dev, regmap,
> +						     phy_en_refclk);
> +	if (IS_ERR(wiz->phy_en_refclk)) {
> +		dev_err(dev, "PHY_EN_REFCLK reg field init failed\n");
> +		return PTR_ERR(wiz->phy_en_refclk);
> +	}
> +
>  	return 0;
>  }
>  
> +static int wiz_phy_en_refclk_enable(struct clk_hw *hw)
> +{
> +	struct wiz_phy_en_refclk *wiz_phy_en_refclk = to_wiz_phy_en_refclk(hw);
> +	struct regmap_field *phy_en_refclk = wiz_phy_en_refclk->phy_en_refclk;
> +
> +	regmap_field_write(phy_en_refclk, 1);
> +
> +	return 0;
> +}
> +
> +static void wiz_phy_en_refclk_disable(struct clk_hw *hw)
> +{
> +	struct wiz_phy_en_refclk *wiz_phy_en_refclk = to_wiz_phy_en_refclk(hw);
> +	struct regmap_field *phy_en_refclk = wiz_phy_en_refclk->phy_en_refclk;
> +
> +	regmap_field_write(phy_en_refclk, 0);
> +}
> +
> +static int wiz_phy_en_refclk_is_enabled(struct clk_hw *hw)
> +{
> +	struct wiz_phy_en_refclk *wiz_phy_en_refclk = to_wiz_phy_en_refclk(hw);
> +	struct regmap_field *phy_en_refclk = wiz_phy_en_refclk->phy_en_refclk;

get_phy_wiz_regmap() macro for this repeated patter..?

> +	int val;
> +
> +	regmap_field_read(phy_en_refclk, &val);
> +
> +	return !!val;
> +}
> +
> +static const struct clk_ops wiz_phy_en_refclk_ops = {
> +	.enable = wiz_phy_en_refclk_enable,
> +	.disable = wiz_phy_en_refclk_disable,
> +	.is_enabled = wiz_phy_en_refclk_is_enabled,
> +};
> +
> +static int wiz_phy_en_refclk_register(struct wiz *wiz, struct device_node *node,
> +				      struct regmap_field *phy_en_refclk)
> +{
> +	struct wiz_phy_en_refclk *wiz_phy_en_refclk;
> +	struct device *dev = wiz->dev;
> +	struct clk_init_data *init;
> +	unsigned int num_parents;
> +	const char *parent_name;
> +	char clk_name[100];
> +	struct clk *clk;
> +	int ret;
> +
> +	wiz_phy_en_refclk = devm_kzalloc(dev, sizeof(*wiz_phy_en_refclk),
> +					 GFP_KERNEL);

single line :)

> +	if (!wiz_phy_en_refclk)
> +		return -ENOMEM;
> +
> +	num_parents = of_clk_get_parent_count(node);
> +	parent_name = of_clk_get_parent_name(node, 0);
> +
> +	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
> +		 node->name);

here too and few other places

> +
> +	init = &wiz_phy_en_refclk->clk_data;
> +
> +	init->ops = &wiz_phy_en_refclk_ops;
> +	init->flags = 0;
> +	init->parent_names = parent_name ? &parent_name : NULL;
> +	init->num_parents = num_parents ? 1 : 0;
> +	init->name = clk_name;
> +
> +	wiz_phy_en_refclk->phy_en_refclk = phy_en_refclk;
> +	wiz_phy_en_refclk->hw.init = init;
> +
> +	clk = devm_clk_register(dev, &wiz_phy_en_refclk->hw);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +	if (ret)
> +		dev_err(dev, "Fail to add clock provider: %s\n", clk_name);
> +
> +	return ret;
> +}
> +
>  static u8 wiz_clk_mux_get_parent(struct clk_hw *hw)
>  {
>  	struct wiz_clk_mux *mux = to_wiz_clk_mux(hw);
> @@ -713,6 +811,20 @@ static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
>  		of_node_put(clk_node);
>  	}
>  
> +	clk_node = of_get_child_by_name(node, "phy-en-refclk");
> +	if (clk_node) {
> +		ret = wiz_phy_en_refclk_register(wiz, clk_node,
> +						 wiz->phy_en_refclk);
> +		if (ret) {
> +			dev_err(dev, "Failed to register %s clock\n",
> +				node_name);
> +			of_node_put(clk_node);
> +			goto err;
> +		}
> +
> +		of_node_put(clk_node);
> +	}
> +
>  	return 0;
>  err:
>  	wiz_clock_cleanup(wiz, node);
> @@ -828,6 +940,9 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
>  		      of_node_name_eq(subnode, "link")))
>  			continue;
>  
> +		if (!(of_node_name_eq(subnode, "link")))
> +			continue;
> +
>  		ret = of_property_read_u32(subnode, "reg", &reg);
>  		if (ret) {
>  			dev_err(dev,
> -- 
> 2.17.1

-- 
~Vinod
