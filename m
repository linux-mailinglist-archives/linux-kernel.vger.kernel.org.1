Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2027C10C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgI2JZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgI2JZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:25:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769D3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:25:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so3897202wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v9c1L7bUzqt1ZGy8xPf6IsuN+4ufXucqMXMZTtjee18=;
        b=15gqtpmAD0OaMKuUPYlal5hDi+UNrQBkvSUYSJZRg7VAPrBpqq4zycCzc3FJJnWAk/
         oMbSNNKgpC8UUw8ojTm4M53K5KSDBmHAitJS0eXKFqHK17RNzvxUsR3SS+BxicnekA+f
         Jnthrtl1ovaIft9tFqT2qHH7u8jCMxrPRtbunGxblDA6uZHPfOtiLdn2+1a+GS7MtQcI
         bGJ4edLfB0hYJx+F+FvLvTvUMxk/jdon7tnPsNOpdHZSnap5YotNeygp1aeZb0xmOO+E
         KTtx76DJqVE7TeuqhToVrWF6o7WsZQaDW+U6Ww2b4mSCbN+mbG6dqZHA6EE6ClibKMK+
         qiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=v9c1L7bUzqt1ZGy8xPf6IsuN+4ufXucqMXMZTtjee18=;
        b=jbiVZ3xLANrluz0lO90k1YfX21GKv/X5dPFGFULYmsRJjHa5Kd2e51q2NFx1iE1rHk
         xAtI06rEO3ZPgme626mQ5U2w0c+CzLJhD3NBWVMIPvvsYRq7S3Pz45PpgbRlJtojH9YI
         DxxhCVXpCi6Y4dYoD/+UxGo5S4Dr3wQqXQkCpSyBvvcfVJtB+o3pZkm/mzTzdubfVLxR
         geIyGeMOikbYU7HDLtfRL1QDuAhgxQyTClhD5tTrQPGzZQHwmNx3fbHKr1TbKNh3oRNI
         sgq+fRqxYT41ZqPcYsodmM4b98h1gXbLPp7csmFY2vYmv2be+M0smMr3TQY6vAEQLCGh
         DB4w==
X-Gm-Message-State: AOAM533f4O2UZ3sXx7NWVuMhX00AZ50sUVTWVKk3kvmiiyNQM9/3yarf
        pyqXIqINKQsvVi5QiKE+hU4kqZ/fs1M0wEaa
X-Google-Smtp-Source: ABdhPJzDxUzxjsNRbjoNYDUCPZDL7AiNK138Zwox9ijD51mws2kOEv6wosJOL8a2oRC3h3TuE3dD4w==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr3629696wme.46.1601371551527;
        Tue, 29 Sep 2020 02:25:51 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:d50c:1ee4:fec5:ad12? ([2a01:e35:2ec0:82b0:d50c:1ee4:fec5:ad12])
        by smtp.gmail.com with ESMTPSA id n66sm4715316wmb.35.2020.09.29.02.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 02:25:50 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] phy: amlogic: phy-meson-axg-mipi-pcie-analog: add
 support for MIPI DSI analog
To:     kishon@ti.com, repk@triplefau.lt
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200915130339.11079-1-narmstrong@baylibre.com>
 <20200915130339.11079-4-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <6f87aa99-e044-f7f6-802f-ea2fe8b9de6d@baylibre.com>
Date:   Tue, 29 Sep 2020 11:25:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915130339.11079-4-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

Gentle ping.

Thanks,
Neil

On 15/09/2020 15:03, Neil Armstrong wrote:
> The AXG Analog MIPI-DSI PHY also provides functions to the PCIe PHY,
> thus we need to have inclusive support for both interfaces at runtime.
> 
> This fixes the regmap get from parent node, removes cell param
> to select a mode and implement runtime configuration & power on/off
> for both functions since they are not exclusive.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/phy/amlogic/Kconfig                   |   1 +
>  .../amlogic/phy-meson-axg-mipi-pcie-analog.c  | 204 ++++++++++++------
>  2 files changed, 136 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 99e8a4c7f1f3..db5d0cd757e3 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -66,6 +66,7 @@ config PHY_MESON_AXG_MIPI_PCIE_ANALOG
>  	depends on OF && (ARCH_MESON || COMPILE_TEST)
>  	select GENERIC_PHY
>  	select REGMAP_MMIO
> +	select GENERIC_PHY_MIPI_DPHY
>  	help
>  	  Enable this to support the Meson MIPI + PCIE analog PHY
>  	  found in Meson AXG SoCs.
> diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> index 1431cbf885e1..6eb21551bdd9 100644
> --- a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> +++ b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> @@ -4,9 +4,13 @@
>   *
>   * Copyright (C) 2019 Remi Pommarel <repk@triplefau.lt>
>   */
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/module.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
>  #include <dt-bindings/phy/phy.h>
>  
> @@ -14,10 +18,10 @@
>  #define		HHI_MIPI_CNTL0_COMMON_BLOCK	GENMASK(31, 28)
>  #define		HHI_MIPI_CNTL0_ENABLE		BIT(29)
>  #define		HHI_MIPI_CNTL0_BANDGAP		BIT(26)
> -#define		HHI_MIPI_CNTL0_DECODE_TO_RTERM	GENMASK(15, 12)
> -#define		HHI_MIPI_CNTL0_OUTPUT_EN	BIT(3)
> +#define		HHI_MIPI_CNTL0_DIF_REF_CTL1	GENMASK(25, 16)
> +#define		HHI_MIPI_CNTL0_DIF_REF_CTL0	GENMASK(15, 0)
>  
> -#define HHI_MIPI_CNTL1 0x01
> +#define HHI_MIPI_CNTL1 0x04
>  #define		HHI_MIPI_CNTL1_CH0_CML_PDR_EN	BIT(12)
>  #define		HHI_MIPI_CNTL1_LP_ABILITY	GENMASK(5, 4)
>  #define		HHI_MIPI_CNTL1_LP_RESISTER	BIT(3)
> @@ -25,100 +29,170 @@
>  #define		HHI_MIPI_CNTL1_INPUT_SEL	BIT(1)
>  #define		HHI_MIPI_CNTL1_PRBS7_EN		BIT(0)
>  
> -#define HHI_MIPI_CNTL2 0x02
> +#define HHI_MIPI_CNTL2 0x08
>  #define		HHI_MIPI_CNTL2_CH_PU		GENMASK(31, 25)
>  #define		HHI_MIPI_CNTL2_CH_CTL		GENMASK(24, 19)
>  #define		HHI_MIPI_CNTL2_CH0_DIGDR_EN	BIT(18)
>  #define		HHI_MIPI_CNTL2_CH_DIGDR_EN	BIT(17)
>  #define		HHI_MIPI_CNTL2_LPULPS_EN	BIT(16)
> -#define		HHI_MIPI_CNTL2_CH_EN(n)		BIT(15 - (n))
> +#define		HHI_MIPI_CNTL2_CH_EN		GENMASK(15, 11)
>  #define		HHI_MIPI_CNTL2_CH0_LP_CTL	GENMASK(10, 1)
>  
> +#define DSI_LANE_0              (1 << 4)
> +#define DSI_LANE_1              (1 << 3)
> +#define DSI_LANE_CLK            (1 << 2)
> +#define DSI_LANE_2              (1 << 1)
> +#define DSI_LANE_3              (1 << 0)
> +#define DSI_LANE_MASK		(0x1F)
> +
>  struct phy_axg_mipi_pcie_analog_priv {
>  	struct phy *phy;
> -	unsigned int mode;
>  	struct regmap *regmap;
> +	bool dsi_configured;
> +	bool dsi_enabled;
> +	bool powered;
> +	struct phy_configure_opts_mipi_dphy config;
>  };
>  
> -static const struct regmap_config phy_axg_mipi_pcie_analog_regmap_conf = {
> -	.reg_bits = 8,
> -	.val_bits = 32,
> -	.reg_stride = 4,
> -	.max_register = HHI_MIPI_CNTL2,
> -};
> +static void phy_bandgap_enable(struct phy_axg_mipi_pcie_analog_priv *priv)
> +{
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			HHI_MIPI_CNTL0_BANDGAP, HHI_MIPI_CNTL0_BANDGAP);
>  
> -static int phy_axg_mipi_pcie_analog_power_on(struct phy *phy)
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			HHI_MIPI_CNTL0_ENABLE, HHI_MIPI_CNTL0_ENABLE);
> +}
> +
> +static void phy_bandgap_disable(struct phy_axg_mipi_pcie_analog_priv *priv)
>  {
> -	struct phy_axg_mipi_pcie_analog_priv *priv = phy_get_drvdata(phy);
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			HHI_MIPI_CNTL0_BANDGAP, 0);
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			HHI_MIPI_CNTL0_ENABLE, 0);
> +}
>  
> -	/* MIPI not supported yet */
> -	if (priv->mode != PHY_TYPE_PCIE)
> -		return -EINVAL;
> +static void phy_dsi_analog_enable(struct phy_axg_mipi_pcie_analog_priv *priv)
> +{
> +	u32 reg;
>  
>  	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> -			   HHI_MIPI_CNTL0_BANDGAP, HHI_MIPI_CNTL0_BANDGAP);
> +			   HHI_MIPI_CNTL0_DIF_REF_CTL1,
> +			   FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL1, 0x1b8));
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			   BIT(31), BIT(31));
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			   HHI_MIPI_CNTL0_DIF_REF_CTL0,
> +			   FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL0, 0x8));
> +
> +	regmap_write(priv->regmap, HHI_MIPI_CNTL1, 0x001e);
> +
> +	regmap_write(priv->regmap, HHI_MIPI_CNTL2,
> +		     (0x26e0 << 16) | (0x459 << 0));
> +
> +	reg = DSI_LANE_CLK;
> +	switch (priv->config.lanes) {
> +	case 4:
> +		reg |= DSI_LANE_3;
> +		fallthrough;
> +	case 3:
> +		reg |= DSI_LANE_2;
> +		fallthrough;
> +	case 2:
> +		reg |= DSI_LANE_1;
> +		fallthrough;
> +	case 1:
> +		reg |= DSI_LANE_0;
> +		break;
> +	default:
> +		reg = 0;
> +	}
> +
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL2,
> +			   HHI_MIPI_CNTL2_CH_EN,
> +			   FIELD_PREP(HHI_MIPI_CNTL2_CH_EN, reg));
> +
> +	priv->dsi_enabled = true;
> +}
>  
> +static void phy_dsi_analog_disable(struct phy_axg_mipi_pcie_analog_priv *priv)
> +{
>  	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> -			   HHI_MIPI_CNTL0_ENABLE, HHI_MIPI_CNTL0_ENABLE);
> -	return 0;
> +			HHI_MIPI_CNTL0_DIF_REF_CTL1,
> +			FIELD_PREP(HHI_MIPI_CNTL0_DIF_REF_CTL1, 0));
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0, BIT(31), 0);
> +	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> +			HHI_MIPI_CNTL0_DIF_REF_CTL1, 0);
> +
> +	regmap_write(priv->regmap, HHI_MIPI_CNTL1, 0x6);
> +
> +	regmap_write(priv->regmap, HHI_MIPI_CNTL2, 0x00200000);
> +
> +	priv->dsi_enabled = false;
>  }
>  
> -static int phy_axg_mipi_pcie_analog_power_off(struct phy *phy)
> +static int phy_axg_mipi_pcie_analog_configure(struct phy *phy,
> +					      union phy_configure_opts *opts)
>  {
>  	struct phy_axg_mipi_pcie_analog_priv *priv = phy_get_drvdata(phy);
> +	int ret;
>  
> -	/* MIPI not supported yet */
> -	if (priv->mode != PHY_TYPE_PCIE)
> -		return -EINVAL;
> +	ret = phy_mipi_dphy_config_validate(&opts->mipi_dphy);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(&priv->config, opts, sizeof(priv->config));
> +
> +	priv->dsi_configured = true;
> +
> +	/* If PHY was already powered on, setup the DSI analog part */
> +	if (priv->powered) {
> +		/* If reconfiguring, disable & reconfigure */
> +		if (priv->dsi_enabled)
> +			phy_dsi_analog_disable(priv);
> +
> +		usleep_range(100, 200);
> +
> +		phy_dsi_analog_enable(priv);
> +	}
>  
> -	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> -			   HHI_MIPI_CNTL0_BANDGAP, 0);
> -	regmap_update_bits(priv->regmap, HHI_MIPI_CNTL0,
> -			   HHI_MIPI_CNTL0_ENABLE, 0);
>  	return 0;
>  }
>  
> -static int phy_axg_mipi_pcie_analog_init(struct phy *phy)
> +static int phy_axg_mipi_pcie_analog_power_on(struct phy *phy)
>  {
> +	struct phy_axg_mipi_pcie_analog_priv *priv = phy_get_drvdata(phy);
> +
> +	phy_bandgap_enable(priv);
> +
> +	if (priv->dsi_configured)
> +		phy_dsi_analog_enable(priv);
> +
> +	priv->powered = true;
> +
>  	return 0;
>  }
>  
> -static int phy_axg_mipi_pcie_analog_exit(struct phy *phy)
> +static int phy_axg_mipi_pcie_analog_power_off(struct phy *phy)
>  {
> +	struct phy_axg_mipi_pcie_analog_priv *priv = phy_get_drvdata(phy);
> +
> +	phy_bandgap_disable(priv);
> +
> +	if (priv->dsi_enabled)
> +		phy_dsi_analog_disable(priv);
> +
> +	priv->powered = false;
> +
>  	return 0;
>  }
>  
>  static const struct phy_ops phy_axg_mipi_pcie_analog_ops = {
> -	.init = phy_axg_mipi_pcie_analog_init,
> -	.exit = phy_axg_mipi_pcie_analog_exit,
> +	.configure = phy_axg_mipi_pcie_analog_configure,
>  	.power_on = phy_axg_mipi_pcie_analog_power_on,
>  	.power_off = phy_axg_mipi_pcie_analog_power_off,
>  	.owner = THIS_MODULE,
>  };
>  
> -static struct phy *phy_axg_mipi_pcie_analog_xlate(struct device *dev,
> -						  struct of_phandle_args *args)
> -{
> -	struct phy_axg_mipi_pcie_analog_priv *priv = dev_get_drvdata(dev);
> -	unsigned int mode;
> -
> -	if (args->args_count != 1) {
> -		dev_err(dev, "invalid number of arguments\n");
> -		return ERR_PTR(-EINVAL);
> -	}
> -
> -	mode = args->args[0];
> -
> -	/* MIPI mode is not supported yet */
> -	if (mode != PHY_TYPE_PCIE) {
> -		dev_err(dev, "invalid phy mode select argument\n");
> -		return ERR_PTR(-EINVAL);
> -	}
> -
> -	priv->mode = mode;
> -	return priv->phy;
> -}
> -
>  static int phy_axg_mipi_pcie_analog_probe(struct platform_device *pdev)
>  {
>  	struct phy_provider *phy;
> @@ -126,27 +200,20 @@ static int phy_axg_mipi_pcie_analog_probe(struct platform_device *pdev)
>  	struct phy_axg_mipi_pcie_analog_priv *priv;
>  	struct device_node *np = dev->of_node;
>  	struct regmap *map;
> -	struct resource *res;
> -	void __iomem *base;
>  	int ret;
>  
>  	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(base)) {
> -		dev_err(dev, "failed to get regmap base\n");
> -		return PTR_ERR(base);
> -	}
> -
> -	map = devm_regmap_init_mmio(dev, base,
> -				    &phy_axg_mipi_pcie_analog_regmap_conf);
> +	/* Get the hhi system controller node */
> +	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
>  	if (IS_ERR(map)) {
> -		dev_err(dev, "failed to get HHI regmap\n");
> +		dev_err(dev,
> +			"failed to get HHI regmap\n");
>  		return PTR_ERR(map);
>  	}
> +
>  	priv->regmap = map;
>  
>  	priv->phy = devm_phy_create(dev, np, &phy_axg_mipi_pcie_analog_ops);
> @@ -160,8 +227,7 @@ static int phy_axg_mipi_pcie_analog_probe(struct platform_device *pdev)
>  	phy_set_drvdata(priv->phy, priv);
>  	dev_set_drvdata(dev, priv);
>  
> -	phy = devm_of_phy_provider_register(dev,
> -					    phy_axg_mipi_pcie_analog_xlate);
> +	phy = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>  
>  	return PTR_ERR_OR_ZERO(phy);
>  }
> 

