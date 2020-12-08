Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D52D2791
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgLHJ0g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Dec 2020 04:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbgLHJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:26:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD6AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 01:25:49 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kmZFd-0004D0-NE; Tue, 08 Dec 2020 10:25:41 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kmZFb-0004Fu-52; Tue, 08 Dec 2020 10:25:39 +0100
Message-ID: <07c0b7a0caf47ddef27e55e6d6887fa55305d9d5.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] reset: hisilicon: correct vendor prefix
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date:   Tue, 08 Dec 2020 10:25:39 +0100
In-Reply-To: <20201204014236.1158-2-thunder.leizhen@huawei.com>
References: <20201204014236.1158-1-thunder.leizhen@huawei.com>
         <20201204014236.1158-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

On Fri, 2020-12-04 at 09:42 +0800, Zhen Lei wrote:
> The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
> stated in "vendor-prefixes.yaml".
> 
> Fixes: 1527058736fa ("reset: hisilicon: add reset-hi3660")
> Fixes: 35ca8168133c ("arm64: dts: Add dts files for Hisilicon Hi3660 SoC")
> Fixes: dd8c7b78c11b ("arm64: dts: Add devicetree for Hisilicon Hi3670 SoC")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 2 +-
>  drivers/reset/hisilicon/reset-hi3660.c    | 2 +-

Please keep device tree patches and reset driver patch separate, as they
were in v1.

>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 49c19c6879f95ce..bfb1375426d2b58 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -345,7 +345,7 @@
>  		crg_rst: crg_rst_controller {
>  			compatible = "hisilicon,hi3660-reset";
>  			#reset-cells = <2>;
> -			hisi,rst-syscon = <&crg_ctrl>;
> +			hisilicon,rst-syscon = <&crg_ctrl>;
>  		};
>  
>  
> @@ -376,7 +376,7 @@
>  
>  		iomcu_rst: reset {
>  			compatible = "hisilicon,hi3660-reset";
> -			hisi,rst-syscon = <&iomcu>;
> +			hisilicon,rst-syscon = <&iomcu>;
>  			#reset-cells = <2>;
>  		};
>  
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index 85b0dfb35d6d396..5c5a5dc964ea848 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -155,7 +155,7 @@
>  			compatible = "hisilicon,hi3670-reset",
>  				     "hisilicon,hi3660-reset";
>  			#reset-cells = <2>;
> -			hisi,rst-syscon = <&crg_ctrl>;
> +			hisilicon,rst-syscon = <&crg_ctrl>;
>  		};
>  
>  		pctrl: pctrl@e8a09000 {
> diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
> index a7d4445924e558c..8f1953159a65b31 100644
> --- a/drivers/reset/hisilicon/reset-hi3660.c
> +++ b/drivers/reset/hisilicon/reset-hi3660.c
> @@ -83,7 +83,7 @@ static int hi3660_reset_probe(struct platform_device *pdev)
>  	if (!rc)
>  		return -ENOMEM;
>  
> -	rc->map = syscon_regmap_lookup_by_phandle(np, "hisi,rst-syscon");
> +	rc->map = syscon_regmap_lookup_by_phandle(np, "hisilicon,rst-syscon");

This should fall back to the deprecated compatible, for example:

	rc->map = syscon_regmap_lookup_by_phandle(np, "hisilicon,rst-syscon");
	if (PTR_ERR(rc->map) == -ENODEV)
		rc->map = syscon_regmap_lookup_by_phandle(np, "hisi,rst-
syscon");

>  	if (IS_ERR(rc->map)) {
>  		dev_err(dev, "failed to get hi3660,rst-syscon\n");
>  		return PTR_ERR(rc->map);

regards
Philipp
