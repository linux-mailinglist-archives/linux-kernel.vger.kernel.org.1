Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6111DA6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 03:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgETBDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 21:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgETBDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:03:54 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D03E3207D8;
        Wed, 20 May 2020 01:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589936633;
        bh=xv5tC9SfdYETWhqIHch5RTfzK5Pk9+7hxv07xTNN8NQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pBFD8ygSm3Qep6poMkwji+pn7GmJFpf91j3rgSaA5S5EXFFLN7NMiHLb8jppFGALf
         hs8ux30q27f3Oy1fXSBQilCmqyVK4MSIhtZ+h7/mPEUpb0PoVOOLcqoAVzkuE8YPHV
         SWrDQzlsI/nbDZutWimsoVWCaNpR2n97/CSue92U=
Date:   Wed, 20 May 2020 09:03:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconemedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm: Add support for micfil
Message-ID: <20200520010348.GE11739@dragon>
References: <20200502125949.194032-1-aford173@gmail.com>
 <20200502125949.194032-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502125949.194032-2-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 07:59:48AM -0500, Adam Ford wrote:
> The i.MX8M Mini has supports the MICFIL digital interface.
> It's a 16-bit audio signal from a PDM microphone bitstream.
> The driver is already in the kernel, but the node is missing.
> 
> This patch adds the micfil node.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index c63685ae80ee..d46e727fc362 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -339,6 +339,25 @@ sai6: sai@30060000 {
>  				status = "disabled";
>  			};
>  
> +			micfil: micfil@30080000 {

Find a generic node name, audio-controller maybe?

Shawn

> +				compatible = "fsl,imx8mm-micfil";
> +				reg = <0x30080000 0x10000>;
> +				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MM_CLK_PDM_IPG>,
> +					 <&clk IMX8MM_CLK_PDM_ROOT>,
> +					 <&clk IMX8MM_AUDIO_PLL1_OUT>,
> +					 <&clk IMX8MM_AUDIO_PLL2_OUT>,
> +					 <&clk IMX8MM_CLK_EXT3>;
> +				clock-names = "ipg_clk", "ipg_clk_app",
> +					      "pll8k", "pll11k", "clkext3";
> +				dmas = <&sdma2 24 25 0x80000000>;
> +				dma-names = "rx";
> +				status = "disabled";
> +			};
> +
>  			gpio1: gpio@30200000 {
>  				compatible = "fsl,imx8mm-gpio", "fsl,imx35-gpio";
>  				reg = <0x30200000 0x10000>;
> -- 
> 2.25.1
> 
