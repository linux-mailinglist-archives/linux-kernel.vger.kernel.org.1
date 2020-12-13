Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA12D8ED9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 17:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgLMQoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 11:44:38 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:58828 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgLMQoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 11:44:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 8E853FB03;
        Sun, 13 Dec 2020 17:43:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id frSO9gf1gJwA; Sun, 13 Dec 2020 17:43:51 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id DCC0543FDC; Sun, 13 Dec 2020 17:43:50 +0100 (CET)
Date:   Sun, 13 Dec 2020 17:43:50 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Subject: Re: [PATCH v3 5/5] phy: freescale: phy-fsl-imx8-mipi-dphy: Add
 i.MX8qxp LVDS PHY mode support
Message-ID: <20201213164350.GA28272@bogon.m.sigxcpu.org>
References: <1607651182-12307-1-git-send-email-victor.liu@nxp.com>
 <1607651182-12307-6-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1607651182-12307-6-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Dec 11, 2020 at 09:46:22AM +0800, Liu Ying wrote:
> i.MX8qxp SoC embeds a Mixel MIPI DPHY + LVDS PHY combo which supports
> either a MIPI DSI display or a LVDS display.  The PHY mode is controlled
> by SCU firmware and the driver would call a SCU firmware function to
> configure the PHY mode.  The single LVDS PHY has 4 data lanes to support
> a LVDS display.  Also, with a master LVDS PHY and a slave LVDS PHY, they
> may work together to support a LVDS display with 8 data lanes(usually, dual
> LVDS link display).  Note that this patch supports the LVDS PHY mode only
> for the i.MX8qxp Mixel combo PHY, i.e., the MIPI DPHY mode is yet to be
> supported, so for now error would be returned from ->set_mode() if MIPI
> DPHY mode is passed over to it for the combo PHY.
> 
> Cc: Guido Günther <agx@sigxcpu.org>
> Cc: Robert Chiras <robert.chiras@nxp.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> Guido, I also print invalid PHY mode from mixel_dphy_configure().
> 
> v2->v3:
> * Improve readability of mixel_dphy_set_mode(). (Guido)
> 
> v1->v2:
> * Print invalid PHY mode in dmesg. (Guido)
> 
>  drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 269 ++++++++++++++++++++++++-
>  1 file changed, 258 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> index a95572b..af1ecda 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> @@ -4,17 +4,31 @@
>   * Copyright 2019 Purism SPC
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
> +#include <linux/firmware/imx/ipc.h>
> +#include <linux/firmware/imx/svc/misc.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <dt-bindings/firmware/imx/rsrc.h>
> +
> +/* Control and Status Registers(CSR) */
> +#define PHY_CTRL			0x00
> +#define  CCM_MASK			GENMASK(7, 5)
> +#define  CCM(n)				FIELD_PREP(CCM_MASK, (n))
> +#define  CA_MASK			GENMASK(4, 2)
> +#define  CA(n)				FIELD_PREP(CA_MASK, (n))
> +#define  RFB				BIT(1)
> +#define  LVDS_EN			BIT(0)
>  
>  /* DPHY registers */
>  #define DPHY_PD_DPHY			0x00
> @@ -55,8 +69,15 @@
>  #define PWR_ON	0
>  #define PWR_OFF	1
>  
> +#define MIN_VCO_FREQ 640000000
> +#define MAX_VCO_FREQ 1500000000
> +
> +#define MIN_LVDS_REFCLK_FREQ 24000000
> +#define MAX_LVDS_REFCLK_FREQ 150000000
> +
>  enum mixel_dphy_devtype {
>  	MIXEL_IMX8MQ,
> +	MIXEL_IMX8QXP,
>  };
>  
>  struct mixel_dphy_devdata {
> @@ -65,6 +86,7 @@ struct mixel_dphy_devdata {
>  	u8 reg_rxlprp;
>  	u8 reg_rxcdrp;
>  	u8 reg_rxhs_settle;
> +	bool is_combo;	/* MIPI DPHY and LVDS PHY combo */
>  };
>  
>  static const struct mixel_dphy_devdata mixel_dphy_devdata[] = {
> @@ -74,6 +96,10 @@ static const struct mixel_dphy_devdata mixel_dphy_devdata[] = {
>  		.reg_rxlprp = 0x40,
>  		.reg_rxcdrp = 0x44,
>  		.reg_rxhs_settle = 0x48,
> +		.is_combo = false,
> +	},
> +	[MIXEL_IMX8QXP] = {
> +		.is_combo = true,
>  	},
>  };
>  
> @@ -95,8 +121,12 @@ struct mixel_dphy_cfg {
>  struct mixel_dphy_priv {
>  	struct mixel_dphy_cfg cfg;
>  	struct regmap *regmap;
> +	struct regmap *lvds_regmap;
>  	struct clk *phy_ref_clk;
>  	const struct mixel_dphy_devdata *devdata;
> +	struct imx_sc_ipc *ipc_handle;
> +	bool is_slave;
> +	int id;
>  };
>  
>  static const struct regmap_config mixel_dphy_regmap_config = {
> @@ -317,7 +347,8 @@ static int mixel_dphy_set_pll_params(struct phy *phy)
>  	return 0;
>  }
>  
> -static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> +static int
> +mixel_dphy_configure_mipi_dphy(struct phy *phy, union phy_configure_opts *opts)
>  {
>  	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
>  	struct mixel_dphy_cfg cfg = { 0 };
> @@ -345,15 +376,121 @@ static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
>  	return 0;
>  }
>  
> +static int
> +mixel_dphy_configure_lvds_phy(struct phy *phy, union phy_configure_opts *opts)
> +{
> +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> +	struct phy_configure_opts_lvds *lvds_opts = &opts->lvds;
> +	unsigned long data_rate;
> +	unsigned long fvco;
> +	u32 rsc;
> +	u32 co;
> +	int ret;
> +
> +	priv->is_slave = lvds_opts->is_slave;
> +
> +	/* LVDS interface pins */
> +	regmap_write(priv->lvds_regmap, PHY_CTRL, CCM(0x5) | CA(0x4) | RFB);
> +
> +	/* enable MODE8 only for slave LVDS PHY */
> +	rsc = priv->id ? IMX_SC_R_MIPI_1 : IMX_SC_R_MIPI_0;
> +	ret = imx_sc_misc_set_control(priv->ipc_handle, rsc, IMX_SC_C_DUAL_MODE,
> +				      lvds_opts->is_slave);
> +	if (ret) {
> +		dev_err(&phy->dev, "Failed to configure MODE8: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Choose an appropriate divider ratio to meet the requirement of
> +	 * PLL VCO frequency range.
> +	 *
> +	 *  -----  640MHz ~ 1500MHz   ------------      ---------------
> +	 * | VCO | ----------------> | CO divider | -> | LVDS data rate|
> +	 *  -----       FVCO          ------------      ---------------
> +	 *                            1/2/4/8 div     7 * differential_clk_rate
> +	 */
> +	data_rate = 7 * lvds_opts->differential_clk_rate;
> +	for (co = 1; co <= 8; co *= 2) {
> +		fvco = data_rate * co;
> +
> +		if (fvco >= MIN_VCO_FREQ)
> +			break;
> +	}
> +
> +	if (fvco < MIN_VCO_FREQ || fvco > MAX_VCO_FREQ) {
> +		dev_err(&phy->dev, "VCO frequency %lu is out of range\n", fvco);
> +		return -ERANGE;
> +	}
> +
> +	/*
> +	 * CO is configurable, while CN and CM are not,
> +	 * as fixed ratios 1 and 7 are applied respectively.
> +	 */
> +	phy_write(phy, __ffs(co), DPHY_CO);
> +
> +	/* set reference clock rate */
> +	clk_set_rate(priv->phy_ref_clk, lvds_opts->differential_clk_rate);
> +
> +	return ret;
> +}
> +
> +static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> +{
> +	if (phy->attrs.mode == PHY_MODE_MIPI_DPHY)
> +		return mixel_dphy_configure_mipi_dphy(phy, opts);
> +	else if (phy->attrs.mode == PHY_MODE_LVDS)
> +		return mixel_dphy_configure_lvds_phy(phy, opts);
> +
> +	dev_err(&phy->dev,
> +		"Failed to configure PHY with invalid PHY mode: %d\n",
> +							phy->attrs.mode);
> +	return -EINVAL;
> +}
> +
> +static int
> +mixel_dphy_validate_lvds_phy(struct phy *phy, union phy_configure_opts *opts)
> +{
> +	struct phy_configure_opts_lvds *lvds_cfg = &opts->lvds;
> +
> +	if (lvds_cfg->bits_per_lane_and_dclk_cycle != 7) {
> +		dev_err(&phy->dev, "Invalid bits per LVDS data lane: %u\n",
> +					lvds_cfg->bits_per_lane_and_dclk_cycle);
> +		return -EINVAL;
> +	}
> +
> +	if (lvds_cfg->lanes != 4) {
> +		dev_err(&phy->dev, "Invalid LVDS data lanes: %u\n",
> +						lvds_cfg->lanes);
> +		return -EINVAL;
> +	}
> +
> +	if (lvds_cfg->differential_clk_rate < MIN_LVDS_REFCLK_FREQ ||
> +	    lvds_cfg->differential_clk_rate > MAX_LVDS_REFCLK_FREQ) {
> +		dev_err(&phy->dev,
> +			"Invalid LVDS differential clock rate: %lu\n",
> +					lvds_cfg->differential_clk_rate);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mixel_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
>  			       union phy_configure_opts *opts)
>  {
> -	struct mixel_dphy_cfg cfg = { 0 };
> +	if (mode == PHY_MODE_MIPI_DPHY) {
> +		struct mixel_dphy_cfg mipi_dphy_cfg = { 0 };
>  
> -	if (mode != PHY_MODE_MIPI_DPHY)
> -		return -EINVAL;
> +		return mixel_dphy_config_from_opts(phy, &opts->mipi_dphy,
> +							&mipi_dphy_cfg);
> +	} else if (mode == PHY_MODE_LVDS) {
> +		return mixel_dphy_validate_lvds_phy(phy, opts);
> +	}
>  
> -	return mixel_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
> +	dev_err(&phy->dev,
> +		"Failed to validate PHY with invalid PHY mode: %d\n", mode);
> +	return -EINVAL;
>  }
>  
>  static int mixel_dphy_init(struct phy *phy)
> @@ -373,27 +510,75 @@ static int mixel_dphy_exit(struct phy *phy)
>  	return 0;
>  }
>  
> -static int mixel_dphy_power_on(struct phy *phy)
> +static int mixel_dphy_power_on_mipi_dphy(struct phy *phy)
>  {
>  	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
>  	u32 locked;
>  	int ret;
>  
> -	ret = clk_prepare_enable(priv->phy_ref_clk);
> -	if (ret < 0)
> -		return ret;
> -
>  	phy_write(phy, PWR_ON, DPHY_PD_PLL);
>  	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
>  				       locked, PLL_LOCK_SLEEP,
>  				       PLL_LOCK_TIMEOUT);
>  	if (ret < 0) {
>  		dev_err(&phy->dev, "Could not get DPHY lock (%d)!\n", ret);
> -		goto clock_disable;
> +		return ret;
>  	}
>  	phy_write(phy, PWR_ON, DPHY_PD_DPHY);
>  
>  	return 0;
> +}
> +
> +static int mixel_dphy_power_on_lvds_phy(struct phy *phy)
> +{
> +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> +	u32 locked;
> +	int ret;
> +
> +	regmap_update_bits(priv->lvds_regmap, PHY_CTRL, LVDS_EN, LVDS_EN);
> +
> +	phy_write(phy, PWR_ON, DPHY_PD_DPHY);
> +	phy_write(phy, PWR_ON, DPHY_PD_PLL);
> +
> +	/* do not wait for slave LVDS PHY being locked */
> +	if (priv->is_slave)
> +		return 0;
> +
> +	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
> +				       locked, PLL_LOCK_SLEEP,
> +				       PLL_LOCK_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(&phy->dev, "Could not get LVDS PHY lock (%d)!\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mixel_dphy_power_on(struct phy *phy)
> +{
> +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->phy_ref_clk);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (phy->attrs.mode == PHY_MODE_MIPI_DPHY) {
> +		ret = mixel_dphy_power_on_mipi_dphy(phy);
> +	} else if (phy->attrs.mode == PHY_MODE_LVDS) {
> +		ret = mixel_dphy_power_on_lvds_phy(phy);
> +	} else {
> +		dev_err(&phy->dev,
> +			"Failed to power on PHY with invalid PHY mode: %d\n",
> +							phy->attrs.mode);
> +		ret = -EINVAL;
> +	}
> +
> +	if (ret)
> +		goto clock_disable;
> +
> +	return 0;
>  clock_disable:
>  	clk_disable_unprepare(priv->phy_ref_clk);
>  	return ret;
> @@ -406,16 +591,51 @@ static int mixel_dphy_power_off(struct phy *phy)
>  	phy_write(phy, PWR_OFF, DPHY_PD_PLL);
>  	phy_write(phy, PWR_OFF, DPHY_PD_DPHY);
>  
> +	if (phy->attrs.mode == PHY_MODE_LVDS)
> +		regmap_update_bits(priv->lvds_regmap, PHY_CTRL, LVDS_EN, 0);
> +
>  	clk_disable_unprepare(priv->phy_ref_clk);
>  
>  	return 0;
>  }
>  
> +static int mixel_dphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	if (priv->devdata->is_combo && mode != PHY_MODE_LVDS) {
> +		dev_err(&phy->dev, "Failed to set PHY mode for combo PHY\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!priv->devdata->is_combo && mode != PHY_MODE_MIPI_DPHY) {
> +		dev_err(&phy->dev, "Failed to set PHY mode to MIPI DPHY\n");
> +		return -EINVAL;
> +	}
> +
> +	if (priv->devdata->is_combo) {
> +		u32 rsc = priv->id ? IMX_SC_R_MIPI_1 : IMX_SC_R_MIPI_0;
> +
> +		ret = imx_sc_misc_set_control(priv->ipc_handle,
> +					      rsc, IMX_SC_C_MODE,
> +					      mode == PHY_MODE_LVDS);
> +		if (ret) {
> +			dev_err(&phy->dev,
> +				"Failed to set PHY mode via SCU ipc: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct phy_ops mixel_dphy_phy_ops = {
>  	.init = mixel_dphy_init,
>  	.exit = mixel_dphy_exit,
>  	.power_on = mixel_dphy_power_on,
>  	.power_off = mixel_dphy_power_off,
> +	.set_mode = mixel_dphy_set_mode,
>  	.configure = mixel_dphy_configure,
>  	.validate = mixel_dphy_validate,
>  	.owner = THIS_MODULE,
> @@ -424,6 +644,8 @@ static const struct phy_ops mixel_dphy_phy_ops = {
>  static const struct of_device_id mixel_dphy_of_match[] = {
>  	{ .compatible = "fsl,imx8mq-mipi-dphy",
>  	  .data = &mixel_dphy_devdata[MIXEL_IMX8MQ] },
> +	{ .compatible = "fsl,imx8qxp-mipi-dphy",
> +	  .data = &mixel_dphy_devdata[MIXEL_IMX8QXP] },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, mixel_dphy_of_match);
> @@ -436,6 +658,7 @@ static int mixel_dphy_probe(struct platform_device *pdev)
>  	struct mixel_dphy_priv *priv;
>  	struct phy *phy;
>  	void __iomem *base;
> +	int ret;
>  
>  	if (!np)
>  		return -ENODEV;
> @@ -467,6 +690,30 @@ static int mixel_dphy_probe(struct platform_device *pdev)
>  	dev_dbg(dev, "phy_ref clock rate: %lu\n",
>  		clk_get_rate(priv->phy_ref_clk));
>  
> +	if (priv->devdata->is_combo) {
> +		priv->lvds_regmap =
> +			syscon_regmap_lookup_by_phandle(np, "fsl,syscon");
> +		if (IS_ERR(priv->lvds_regmap)) {
> +			ret = PTR_ERR(priv->lvds_regmap);
> +			dev_err_probe(dev, ret, "Failed to get LVDS regmap\n");
> +			return ret;
> +		}
> +
> +		priv->id = of_alias_get_id(np, "mipi_dphy");
> +		if (priv->id < 0) {
> +			dev_err(dev, "Failed to get phy node alias id: %d\n",
> +								 priv->id);
> +			return priv->id;
> +		}
> +
> +		ret = imx_scu_get_handle(&priv->ipc_handle);
> +		if (ret) {
> +			dev_err_probe(dev, ret,
> +				      "Failed to get SCU ipc handle\n");
> +			return ret;
> +		}
> +	}
> +
>  	dev_set_drvdata(dev, priv);
>  
>  	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);

Reviewed-by: Guido Günther <agx@sigxcpu.org>
Cheers,
 -- Guido

> -- 
> 2.7.4
> 
