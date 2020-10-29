Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144E129E678
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgJ2Iey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 04:34:54 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:34352 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgJ2Iev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 04:34:51 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A67C03AE2CE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:18:29 +0000 (UTC)
X-Originating-IP: 82.66.179.123
Received: from localhost (unknown [82.66.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 3D55FFF817;
        Thu, 29 Oct 2020 08:17:56 +0000 (UTC)
Date:   Thu, 29 Oct 2020 09:24:15 +0100
From:   Remi Pommarel <repk@triplefau.lt>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Ondrej Jirman <megous@megous.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Joe Perches <joe@perches.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>, Roger Quadros <rogerq@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Anil Varughese <aniljoy@cadence.com>, Li Jun <jun.li@nxp.com>,
        Ma Feng <mafeng.ma@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 02/17] phy: amlogic: convert to
 devm_platform_ioremap_resource
Message-ID: <20201029082415.GB15700@pilgrim>
References: <1603940079-8131-1-git-send-email-chunfeng.yun@mediatek.com>
 <1603940079-8131-2-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603940079-8131-2-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 29, 2020 at 10:54:24AM +0800, Chunfeng Yun wrote:
> Use devm_platform_ioremap_resource to simplify code
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c | 4 +---
>  drivers/phy/amlogic/phy-meson-axg-pcie.c             | 4 +---
>  drivers/phy/amlogic/phy-meson-g12a-usb2.c            | 4 +---
>  drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c       | 4 +---
>  drivers/phy/amlogic/phy-meson-gxl-usb2.c             | 4 +---
>  5 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> index 1431cbf885e1..7d06cda329fb 100644
> --- a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> +++ b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> @@ -126,7 +126,6 @@ static int phy_axg_mipi_pcie_analog_probe(struct platform_device *pdev)
>  	struct phy_axg_mipi_pcie_analog_priv *priv;
>  	struct device_node *np = dev->of_node;
>  	struct regmap *map;
> -	struct resource *res;
>  	void __iomem *base;
>  	int ret;
>  
> @@ -134,8 +133,7 @@ static int phy_axg_mipi_pcie_analog_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base)) {
>  		dev_err(dev, "failed to get regmap base\n");
>  		return PTR_ERR(base);

This patch will conflict with [0] that uses syscon to map those shared
resources instead and that is hopefully going to be merged soon.

So I think you can skip this file.

> diff --git a/drivers/phy/amlogic/phy-meson-axg-pcie.c b/drivers/phy/amlogic/phy-meson-axg-pcie.c
> index 377ed0dcd0d9..58a7507a8422 100644
> --- a/drivers/phy/amlogic/phy-meson-axg-pcie.c
> +++ b/drivers/phy/amlogic/phy-meson-axg-pcie.c
> @@ -129,7 +129,6 @@ static int phy_axg_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct phy_axg_pcie_priv *priv;
>  	struct device_node *np = dev->of_node;
> -	struct resource *res;
>  	void __iomem *base;
>  	int ret;
>  
> @@ -145,8 +144,7 @@ static int phy_axg_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> index b26e30e1afaf..9d1efa0d9394 100644
> --- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> @@ -292,7 +292,6 @@ static int phy_meson_g12a_usb2_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct phy_provider *phy_provider;
> -	struct resource *res;
>  	struct phy_meson_g12a_usb2_priv *priv;
>  	struct phy *phy;
>  	void __iomem *base;
> @@ -305,8 +304,7 @@ static int phy_meson_g12a_usb2_probe(struct platform_device *pdev)
>  	priv->dev = dev;
>  	platform_set_drvdata(pdev, priv);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> index 08e322789e59..ebe3d0ddd304 100644
> --- a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
> @@ -386,7 +386,6 @@ static int phy_g12a_usb3_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	struct phy_g12a_usb3_pcie_priv *priv;
> -	struct resource *res;
>  	struct phy_provider *phy_provider;
>  	void __iomem *base;
>  	int ret;
> @@ -395,8 +394,7 @@ static int phy_g12a_usb3_pcie_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb2.c b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
> index 43ec9bf24abf..875afb2672c7 100644
> --- a/drivers/phy/amlogic/phy-meson-gxl-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
> @@ -230,7 +230,6 @@ static int phy_meson_gxl_usb2_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct phy_provider *phy_provider;
> -	struct resource *res;
>  	struct phy_meson_gxl_usb2_priv *priv;
>  	struct phy *phy;
>  	void __iomem *base;
> @@ -242,8 +241,7 @@ static int phy_meson_gxl_usb2_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, priv);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  

So without the modification on phy-meson-axg-mipi-pcie-analog.c and
FWIW,

Reviewed-by: Remi Pommarel <repk@triplefau.lt>

Thanks,

[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20200915130339.11079-4-narmstrong@baylibre.com/

-- 
Remi
