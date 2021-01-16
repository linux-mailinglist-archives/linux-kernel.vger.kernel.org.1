Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C70A2F8A15
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbhAPAy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:54:28 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33178 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbhAPAy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:54:27 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10G0q3Hp126853;
        Fri, 15 Jan 2021 18:52:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610758323;
        bh=DzUbwP7nb2tbbYzvsD7uYmHzOGYXMnQzBTsU5fUEmLc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YiVhyya3xnv9/xRWTbhQF2BFkr+rVWx3I4B12TtoeZ89ACUycTOtwC3fNAGd6iJlP
         8Sx71tUG82TVFf4ayS9E+0xwfcCHsH3h1IXEQYLwPyRY5Zuf8Ke8nGhp3sQH/VqXfK
         I4VEMS0RE9ucn5YWhfOuBs7iZ/hXzPj8B3rujoiw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10G0q3ar055654
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jan 2021 18:52:03 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 15
 Jan 2021 18:52:03 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 15 Jan 2021 18:52:03 -0600
Received: from [10.250.34.42] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10G0q2ib113879;
        Fri, 15 Jan 2021 18:52:02 -0600
Subject: Re: [PATCH 2/2] soc: ti: pruss: add support for AM18XX/OMAP-L138
 PRUSS
To:     David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210104183021.330112-1-david@lechnology.com>
 <20210104183021.330112-3-david@lechnology.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <4b60b60b-7e59-28fb-dc3a-f3f097e4cc8a@ti.com>
Date:   Fri, 15 Jan 2021 18:52:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104183021.330112-3-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 1/4/21 12:30 PM, David Lechner wrote:
> This adds support for the PRUSS found in AM18XX/OMAP-L138. This PRUSS
> doesn't have a CFG register, so that is made optional as selected by
> the device tree compatible string.
> 
> ARCH_DAVINCI is added in the Kconfig so that the driver can be selected
> on that platform.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  drivers/soc/ti/Kconfig |  2 +-
>  drivers/soc/ti/pruss.c | 76 ++++++++++++++++++++++++------------------
>  2 files changed, 45 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 7e2fb1c16af1..7a692a21480a 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -85,7 +85,7 @@ config TI_K3_SOCINFO
>  
>  config TI_PRUSS
>  	tristate "TI PRU-ICSS Subsystem Platform drivers"
> -	depends on SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
> +	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
>  	select MFD_SYSCON
>  	help
>  	  TI PRU-ICSS Subsystem platform specific support.
> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
> index 5d6e7132a5c4..bfaf3ff74b01 100644
> --- a/drivers/soc/ti/pruss.c
> +++ b/drivers/soc/ti/pruss.c
> @@ -24,10 +24,12 @@
>   * struct pruss_private_data - PRUSS driver private data
>   * @has_no_sharedram: flag to indicate the absence of PRUSS Shared Data RAM
>   * @has_core_mux_clock: flag to indicate the presence of PRUSS core clock
> + * @has_cfg: flag to indicate the presence of PRUSS CFG registers

I recommend to change this to a negative flag as the Davinci platforms are the
only ones that don't have CFG (being the very first SoCs with a PRUSS IP)
sub-module.

>   */
>  struct pruss_private_data {
>  	bool has_no_sharedram;
>  	bool has_core_mux_clock;
> +	bool has_cfg;
>  };
>  
>  static void pruss_of_free_clk_provider(void *data)
> @@ -239,42 +241,44 @@ static int pruss_probe(struct platform_device *pdev)
>  		goto rpm_disable;
>  	}
>  

And use it here to skip all the cfg code parsing. All the below delta is just
for the additional indentation for the flag. If you don't like goto's in
non-error paths, then we can refactor the CFG parse code into a separate function.

regards
Suman

> -	child = of_get_child_by_name(np, "cfg");
> -	if (!child) {
> -		dev_err(dev, "%pOF is missing its 'cfg' node\n", child);
> -		ret = -ENODEV;
> -		goto rpm_put;
> -	}
> +	if (data->has_cfg) {
> +		child = of_get_child_by_name(np, "cfg");
> +		if (!child) {
> +			dev_err(dev, "%pOF is missing its 'cfg' node\n", child);
> +			ret = -ENODEV;
> +			goto rpm_put;
> +		}
>  
> -	if (of_address_to_resource(child, 0, &res)) {
> -		ret = -ENOMEM;
> -		goto node_put;
> -	}
> +		if (of_address_to_resource(child, 0, &res)) {
> +			ret = -ENOMEM;
> +			goto node_put;
> +		}
>  
> -	pruss->cfg_base = devm_ioremap(dev, res.start, resource_size(&res));
> -	if (!pruss->cfg_base) {
> -		ret = -ENOMEM;
> -		goto node_put;
> -	}
> +		pruss->cfg_base = devm_ioremap(dev, res.start, resource_size(&res));
> +		if (!pruss->cfg_base) {
> +			ret = -ENOMEM;
> +			goto node_put;
> +		}
>  
> -	regmap_conf.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", child,
> -				     (u64)res.start);
> -	regmap_conf.max_register = resource_size(&res) - 4;
> -
> -	pruss->cfg_regmap = devm_regmap_init_mmio(dev, pruss->cfg_base,
> -						  &regmap_conf);
> -	kfree(regmap_conf.name);
> -	if (IS_ERR(pruss->cfg_regmap)) {
> -		dev_err(dev, "regmap_init_mmio failed for cfg, ret = %ld\n",
> -			PTR_ERR(pruss->cfg_regmap));
> -		ret = PTR_ERR(pruss->cfg_regmap);
> -		goto node_put;
> -	}
> +		regmap_conf.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", child,
> +					     (u64)res.start);
> +		regmap_conf.max_register = resource_size(&res) - 4;
> +
> +		pruss->cfg_regmap = devm_regmap_init_mmio(dev, pruss->cfg_base,
> +							  &regmap_conf);
> +		kfree(regmap_conf.name);
> +		if (IS_ERR(pruss->cfg_regmap)) {
> +			dev_err(dev, "regmap_init_mmio failed for cfg, ret = %ld\n",
> +				PTR_ERR(pruss->cfg_regmap));
> +			ret = PTR_ERR(pruss->cfg_regmap);
> +			goto node_put;
> +		}
>  
> -	ret = pruss_clk_init(pruss, child);
> -	if (ret) {
> -		dev_err(dev, "failed to setup coreclk-mux\n");
> -		goto node_put;
> +		ret = pruss_clk_init(pruss, child);
> +		if (ret) {
> +			dev_err(dev, "failed to setup coreclk-mux\n");
> +			goto node_put;
> +		}
>  	}
>  
>  	ret = devm_of_platform_populate(dev);
> @@ -309,19 +313,27 @@ static int pruss_remove(struct platform_device *pdev)
>  }
>  
>  /* instance-specific driver private data */
> +static const struct pruss_private_data am18xx_pruss_data = {
> +	.has_no_sharedram = true,
> +};
> +
>  static const struct pruss_private_data am437x_pruss1_data = {
>  	.has_no_sharedram = false,
> +	.has_cfg = true,
>  };
>  
>  static const struct pruss_private_data am437x_pruss0_data = {
>  	.has_no_sharedram = true,
> +	.has_cfg = true,
>  };
>  
>  static const struct pruss_private_data am65x_j721e_pruss_data = {
>  	.has_core_mux_clock = true,
> +	.has_cfg = true,
>  };
>  
>  static const struct of_device_id pruss_of_match[] = {
> +	{ .compatible = "ti,am1806-pruss", .data = &am18xx_pruss_data, },
>  	{ .compatible = "ti,am3356-pruss" },
>  	{ .compatible = "ti,am4376-pruss0", .data = &am437x_pruss0_data, },
>  	{ .compatible = "ti,am4376-pruss1", .data = &am437x_pruss1_data, },
> 

