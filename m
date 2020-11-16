Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AC02B3DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgKPHaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbgKPHae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:30:34 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0366C2225B;
        Mon, 16 Nov 2020 07:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605511834;
        bh=kuJZwKY/IYkjSZSOji4K+N/t3ZrSh9loZk56Bj/FUeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtJyznWc2TNkU+uX/kJ+1njGxc4ik9VYyaku3knQb+Sc7wCIFWEjccKXIaJ8rCGhF
         MyoPYr+lnROdN21gDm8JkGE2XtDdDFTpzm0PH152GnkKSyOzvEIZ68H97dNBk2+R8R
         odHAa4bRBO0PbcqAEx3C709yEQyg/iydFtw6o6ms=
Date:   Mon, 16 Nov 2020 13:00:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/9] phy: ti: j721e-wiz: Don't configure wiz if its
 already configured
Message-ID: <20201116073029.GI7499@vkoul-mobl>
References: <20201103035556.21260-1-kishon@ti.com>
 <20201103035556.21260-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103035556.21260-4-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-11-20, 09:25, Kishon Vijay Abraham I wrote:
> From: Faiz Abbas <faiz_abbas@ti.com>
> 
> Serdes lanes might be shared between multiple cores in some usecases
> and its not possible to lock PLLs for both the lanes independently
> by the two cores. This requires a bootloader to configure both the
> lanes at early boot time.
> 
> To handle this case, skip all configuration if any of the lanes has
> already been enabled.
> 
> While we are here, also fix the wiz_init() to be called before the
> of_platform_device_create() call.

Let's do two patches for these two issues :-)

Other than that, change lgtm, with exception of minor nit

> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/ti/phy-j721e-wiz.c | 36 +++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> index d57d29382ce4..9786e8aec252 100644
> --- a/drivers/phy/ti/phy-j721e-wiz.c
> +++ b/drivers/phy/ti/phy-j721e-wiz.c
> @@ -816,13 +816,14 @@ static int wiz_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *node = dev->of_node;
>  	struct platform_device *serdes_pdev;
> +	bool already_configured = false;
>  	struct device_node *child_node;
>  	struct regmap *regmap;
>  	struct resource res;
>  	void __iomem *base;
>  	struct wiz *wiz;
>  	u32 num_lanes;
> -	int ret;
> +	int ret, val, i;
>  
>  	wiz = devm_kzalloc(dev, sizeof(*wiz), GFP_KERNEL);
>  	if (!wiz)
> @@ -944,10 +945,26 @@ static int wiz_probe(struct platform_device *pdev)
>  		goto err_get_sync;
>  	}
>  
> -	ret = wiz_clock_init(wiz, node);
> -	if (ret < 0) {
> -		dev_warn(dev, "Failed to initialize clocks\n");
> -		goto err_get_sync;
> +	for (i = 0; i < wiz->num_lanes; i++) {
> +		regmap_field_read(wiz->p_enable[i], &val);
> +		if (val & (P_ENABLE | P_ENABLE_FORCE)) {
> +			already_configured = true;
> +			break;
> +		}
> +	}
> +
> +	if (!already_configured) {

do you really need this variable and check, why not move the below into
precceding block and do wiz_clock_init() and wiz_init() inside the
if condition and drop the variable

> +		ret = wiz_clock_init(wiz, node);
> +		if (ret < 0) {
> +			dev_warn(dev, "Failed to initialize clocks\n");
> +			goto err_get_sync;
> +		}
> +
> +		ret = wiz_init(wiz);
> +		if (ret) {
> +			dev_err(dev, "WIZ initialization failed\n");
> +			goto err_pdev_create;
> +		}
>  	}
>  
>  	serdes_pdev = of_platform_device_create(child_node, NULL, dev);
> @@ -958,18 +975,9 @@ static int wiz_probe(struct platform_device *pdev)
>  	}
>  	wiz->serdes_pdev = serdes_pdev;
>  
> -	ret = wiz_init(wiz);
> -	if (ret) {
> -		dev_err(dev, "WIZ initialization failed\n");
> -		goto err_wiz_init;
> -	}
> -
>  	of_node_put(child_node);
>  	return 0;
>  
> -err_wiz_init:
> -	of_platform_device_destroy(&serdes_pdev->dev, NULL);
> -
>  err_pdev_create:
>  	wiz_clock_cleanup(wiz, node);
>  
> -- 
> 2.17.1

-- 
~Vinod
