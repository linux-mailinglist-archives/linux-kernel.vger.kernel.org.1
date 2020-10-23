Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D956296C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461595AbgJWJex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:34:53 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:38679 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461588AbgJWJex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:34:53 -0400
Received: by mail-ej1-f66.google.com with SMTP id ce10so1458183ejc.5;
        Fri, 23 Oct 2020 02:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xIVItItN3N7pseJnKSLk982NZI9iT/uzBTeYcyfN29E=;
        b=Nm51sgLq2+m4HZ9wqqBtBqYssNJD9o73m1kvvbQW6WgkdMrzhdZa7fvPUTz94jsahh
         FvHLgD/1cTd7CrnRdsL2nIODRBahoAYZLwiKpskflX5oEqlE35iYT8OekYK4qVvn4n3b
         GqONA+AcAQ2sQRj/z1C4SAxdZ1UcnP3Hm5IyS79r0no4MZOq/s2OdhkYEFouuiJBod3N
         +NIdXf8VLG47/2di9/59z1bCLA3L8OV4MKzd+dizVCW0bgdX9I7WsPMMvWujB23zK3br
         SGUPTGI5pAFdAw1H2+31YAFc9dkrvm1Zp9BSCj9dzIGXy0XU8Xo5ZFQCpifpwAnQ9Hj2
         YkoQ==
X-Gm-Message-State: AOAM531MF4EHuJFHm/XVTt2+Ca4bYkkhltp92SBnYOrJFsE+D3Y1CxeC
        Nkcw4mS7F75QWBfh1gJy77g=
X-Google-Smtp-Source: ABdhPJywWFJR+C6CVaxj6LAyvrlb/aO/MBxhqBvkTXk7NZnjqRsiBabbSt5uIPlkaEVqN6Tbz2s4HQ==
X-Received: by 2002:a17:906:2dc5:: with SMTP id h5mr1035220eji.507.1603445691039;
        Fri, 23 Oct 2020 02:34:51 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id s12sm498655ejy.25.2020.10.23.02.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:34:49 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:34:46 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, marex@denx.de,
        aford@beaconembedded.com, l.stach@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm: Add GPU node
Message-ID: <20201023093446.GA42872@kozik-lap>
References: <20201022171639.773702-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022171639.773702-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:16:39PM -0500, Adam Ford wrote:
> According to the documentation from NXP, the i.MX8M Nano has a
> Vivante GC7000 Ultra Lite as its GPU core.
> 
> With this patch, the Etnaviv driver presents the GPU as:
>    etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
> 
> It uses the GPCV2 controller to enable the power domain for the GPU.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> This patch depends on a series located:
> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=368903
> and
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 605e6dbd2c6f..62c8cd3dea7c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -4,6 +4,8 @@
>   */
>  
>  #include <dt-bindings/clock/imx8mn-clock.h>
> +#include <dt-bindings/power/imx8mn-power.h>
> +#include <dt-bindings/reset/imx8mq-reset.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -1019,6 +1021,31 @@ gpmi: nand-controller@33002000 {
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

Plaese indent it till '=' and put each entry in new line. This will
match other 'assigned-clock' properties.

Best regards,
Krzysztof
