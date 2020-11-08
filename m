Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68632AACEF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgKHSsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:48:18 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:35598 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHSsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:48:18 -0500
Received: by mail-ej1-f68.google.com with SMTP id f23so2509998ejk.2;
        Sun, 08 Nov 2020 10:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e4MFmro9LRzZqM00MSLpje3m5vP1BDJdx4WIA1ubdow=;
        b=s6GSTn8H+FVYnSwPPpC11opJlBDUZWGeZtZA8V7/GtBiXKPn0mJ/8jEjSMF4FtU9jq
         PHXSZumsUggnU+VG9T81emvWOCg1R1CrF+ZdRjTcw2jnBrWK2WIUknm92+XsrJFuXVq5
         pSbKkjhwB65iSBdG88zx93PUdve9qFaCa8w8lvKIlwEfSm7oB+DzGYVrBwISizzhEzp6
         M/QLcnkCRQ/yfAur0xGC58uNzx1rCozbuweas0740rL/kxyG398cRyfo7vpkXAaZ0BOx
         NH0leQNcOCJhj3fzLQQvL8kJ6YtF1PBNfSB8Nlswg8RChHrcQ8t4wj5z1vuRgoC9NVN1
         ZbRg==
X-Gm-Message-State: AOAM530IJyG1JT5bFHsL9KdrPCggNvh/PlHPM6gY05cvAAz6tdTeyacw
        pjjowrNgyOP99fbvTi4HkMo=
X-Google-Smtp-Source: ABdhPJybxe86P3/r3o9BXNWCXrIOkAU1VasfBNaZH9VotvbwckDMDeAI6+VnIdMDrHItkHNXmDtwbQ==
X-Received: by 2002:a17:906:85c1:: with SMTP id i1mr12060491ejy.157.1604861296017;
        Sun, 08 Nov 2020 10:48:16 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id q8sm6754088ejy.102.2020.11.08.10.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 10:48:14 -0800 (PST)
Date:   Sun, 8 Nov 2020 19:48:13 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 5/5] arm64: dts: imx8mn: Add GPU node
Message-ID: <20201108184813.GD7078@kozik-lap>
References: <20201107140026.1974312-1-aford173@gmail.com>
 <20201107140026.1974312-5-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201107140026.1974312-5-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 08:00:25AM -0600, Adam Ford wrote:
> According to the documentation from NXP, the i.MX8M Nano has a
> Vivante GC7000 Ultra Lite as its GPU core.
> 
> With this patch, the Etnaviv driver presents the GPU as:
>    etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
> 
> The stock operating voltage for the i.MX8M Nano is .85V which means
> the GPU needs to run at 400MHz.  For boards where the operating
> voltage is higher, this can be increased.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Move into this series
>      Update clocking description
> 
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 5e4b6934de40..6e650ea422a7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -1008,6 +1008,31 @@ gpmi: nand-controller@33002000 {
>  			status = "disabled";
>  		};
>  
> +		gpu: gpu@38000000 {
> +			compatible = "vivante,gc";
> +			reg = <0x38000000 0x8000>;
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk IMX8MN_CLK_GPU_AHB>,
> +				<&clk IMX8MN_CLK_GPU_BUS_ROOT>,
> +				<&clk IMX8MN_CLK_GPU_CORE_ROOT>,
> +				<&clk IMX8MN_CLK_GPU_SHADER_DIV>;
> +			clock-names = "reg", "bus", "core", "shader";
> +			assigned-clocks = <&clk IMX8MN_CLK_GPU_CORE_SRC>,
> +					  <&clk IMX8MN_CLK_GPU_SHADER_SRC>,
> +					  <&clk IMX8MN_CLK_GPU_AXI>,
> +					  <&clk IMX8MN_CLK_GPU_AHB>,
> +					  <&clk IMX8MN_GPU_PLL>,
> +					  <&clk IMX8MN_CLK_GPU_CORE_DIV>,
> +					  <&clk IMX8MN_CLK_GPU_SHADER_DIV>;
> +			assigned-clock-parents = <&clk IMX8MN_GPU_PLL_OUT>,
> +						  <&clk IMX8MN_GPU_PLL_OUT>,
> +						  <&clk IMX8MN_SYS_PLL1_800M>,
> +						  <&clk IMX8MN_SYS_PLL1_800M>;
> +			assigned-clock-rates = <0>, <0>, <800000000>, <400000000>, <1200000000>,
> +				<400000000>, <400000000>;

It would be nice to align indentation here to <0> above.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

