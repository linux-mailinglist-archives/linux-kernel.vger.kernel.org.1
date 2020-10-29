Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADD229F21F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgJ2Quh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:50:37 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:35424 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgJ2Quf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:35 -0400
Received: by mail-ej1-f65.google.com with SMTP id p5so4788271ejj.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uBrxBRxxTarAjthI/6yYbLkWUG8wKNojoQzE7DEDDlo=;
        b=CDhexATO+3fUxzst2rqN1bkvnwMv7yPK65fPygSd0EjgPIpFA/IGyfPYmniUrYdyk1
         CqG2FWiEHsClVxiXmwbBMNnLcZ2lmkidOnrYRhSCNRcFJhx4uo84K1ZSlBTAZceJKWjY
         8inYhHQih0ckN+aUut5hvxsFVvCXroCXPvBD3dFmB3FGvGPZP36DjyRXj/eR5h+lUeei
         esJJv/SMl5uSkckwXviRoJmJhJ8uCSKySy5Y+a9O5QSCHtT0+1kH8ggG5l2/X7o8oaii
         QS8lLgy5YozReDH9NWnx9EwKNCRkIgMN6mytRbsUZ8glsX1/B75mDClk+gMx/NNGQYoX
         KBxA==
X-Gm-Message-State: AOAM532kqCLELpaifhYPVLJaXup7coiHeocYJQaug259N+v8iIdF+Lmr
        HDc6CPKEXT1nP1mVaaOC5GU=
X-Google-Smtp-Source: ABdhPJyzrn9eK+i1/M24SroHeDBR18Gy84aE59n8TsOlqmQWsOXPr7AJa0EMWD1bhAmWao4JQaAnkA==
X-Received: by 2002:a17:907:40c2:: with SMTP id nv2mr4711715ejb.337.1603990233349;
        Thu, 29 Oct 2020 09:50:33 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id dm8sm1845090edb.57.2020.10.29.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:32 -0700 (PDT)
Date:   Thu, 29 Oct 2020 17:50:29 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
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
        Colin Ian King <colin.king@canonical.com>,
        Ondrej Jirman <megous@megous.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Remi Pommarel <repk@triplefau.lt>,
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
Subject: Re: [PATCH 14/17] phy: samsung: convert to
 devm_platform_ioremap_resource
Message-ID: <20201029165029.GA84818@kozik-lap>
References: <1603940079-8131-1-git-send-email-chunfeng.yun@mediatek.com>
 <1603940079-8131-14-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1603940079-8131-14-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:54:36AM +0800, Chunfeng Yun wrote:
> Use devm_platform_ioremap_resource to simplify code
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

>  drivers/phy/samsung/phy-exynos-pcie.c     | 7 ++-----
>  drivers/phy/samsung/phy-exynos5-usbdrd.c  | 4 +---
>  drivers/phy/samsung/phy-exynos5250-sata.c | 5 +----
>  drivers/phy/samsung/phy-samsung-usb2.c    | 4 +---
>  4 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
> index 7e28b1aea0d1..c98fff5c1ac8 100644
> --- a/drivers/phy/samsung/phy-exynos-pcie.c
> +++ b/drivers/phy/samsung/phy-exynos-pcie.c
> @@ -232,7 +232,6 @@ static int exynos_pcie_phy_probe(struct platform_device *pdev)
>  	struct exynos_pcie_phy *exynos_phy;
>  	struct phy *generic_phy;
>  	struct phy_provider *phy_provider;
> -	struct resource *res;
>  	const struct exynos_pcie_phy_data *drv_data;
>  
>  	drv_data = of_device_get_match_data(dev);
> @@ -243,13 +242,11 @@ static int exynos_pcie_phy_probe(struct platform_device *pdev)
>  	if (!exynos_phy)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	exynos_phy->phy_base = devm_ioremap_resource(dev, res);
> +	exynos_phy->phy_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(exynos_phy->phy_base))
>  		return PTR_ERR(exynos_phy->phy_base);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	exynos_phy->blk_base = devm_ioremap_resource(dev, res);
> +	exynos_phy->blk_base = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(exynos_phy->blk_base))
>  		return PTR_ERR(exynos_phy->blk_base);
>  
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index cfa9b8b7e5ac..ee0848fe8432 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -829,7 +829,6 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
>  	struct device_node *node = dev->of_node;
>  	struct exynos5_usbdrd_phy *phy_drd;
>  	struct phy_provider *phy_provider;
> -	struct resource *res;
>  	const struct exynos5_usbdrd_phy_drvdata *drv_data;
>  	struct regmap *reg_pmu;
>  	u32 pmu_offset;
> @@ -843,8 +842,7 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
>  	dev_set_drvdata(dev, phy_drd);
>  	phy_drd->dev = dev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	phy_drd->reg_phy = devm_ioremap_resource(dev, res);
> +	phy_drd->reg_phy = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(phy_drd->reg_phy))
>  		return PTR_ERR(phy_drd->reg_phy);
>  
> diff --git a/drivers/phy/samsung/phy-exynos5250-sata.c b/drivers/phy/samsung/phy-exynos5250-sata.c
> index 4dd7324d91b2..9ec234243f7c 100644
> --- a/drivers/phy/samsung/phy-exynos5250-sata.c
> +++ b/drivers/phy/samsung/phy-exynos5250-sata.c
> @@ -162,7 +162,6 @@ static int exynos_sata_phy_probe(struct platform_device *pdev)
>  {
>  	struct exynos_sata_phy *sata_phy;
>  	struct device *dev = &pdev->dev;
> -	struct resource *res;
>  	struct phy_provider *phy_provider;
>  	struct device_node *node;
>  	int ret = 0;
> @@ -171,9 +170,7 @@ static int exynos_sata_phy_probe(struct platform_device *pdev)
>  	if (!sata_phy)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	sata_phy->regs = devm_ioremap_resource(dev, res);
> +	sata_phy->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(sata_phy->regs))
>  		return PTR_ERR(sata_phy->regs);
>  
> diff --git a/drivers/phy/samsung/phy-samsung-usb2.c b/drivers/phy/samsung/phy-samsung-usb2.c
> index a3ed3ff04690..f79f605cff79 100644
> --- a/drivers/phy/samsung/phy-samsung-usb2.c
> +++ b/drivers/phy/samsung/phy-samsung-usb2.c
> @@ -143,7 +143,6 @@ static int samsung_usb2_phy_probe(struct platform_device *pdev)
>  	const struct samsung_usb2_phy_config *cfg;
>  	struct device *dev = &pdev->dev;
>  	struct phy_provider *phy_provider;
> -	struct resource *mem;
>  	struct samsung_usb2_phy_driver *drv;
>  	int i, ret;
>  
> @@ -167,8 +166,7 @@ static int samsung_usb2_phy_probe(struct platform_device *pdev)
>  	drv->cfg = cfg;
>  	drv->dev = dev;
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	drv->reg_phy = devm_ioremap_resource(dev, mem);
> +	drv->reg_phy = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(drv->reg_phy)) {
>  		dev_err(dev, "Failed to map register memory (phy)\n");
>  		return PTR_ERR(drv->reg_phy);
> -- 
> 2.18.0
