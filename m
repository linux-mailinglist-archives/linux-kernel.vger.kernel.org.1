Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF09A2A1BAC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 03:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgKACDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 22:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgKACDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 22:03:19 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 089A822254;
        Sun,  1 Nov 2020 02:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604196199;
        bh=BEBcBlNDVhWIWQJqnvkgZFa8uAtL4iZ7Q2tdbA7H+/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NbTiqT2f20acDczxbs3/mLYG/CwBvIsdUNES9JEjPqWbP4dTZ/uqC5KTE4BJeQ3SE
         nfzaH+u6/lyWdw1ib1JmhUvRUpFR11c/0hx/FEa5sHn7Pjgr1CLMceSCg1pcK0qa6+
         9soNK+24HUDdyjfjCEvloG5n0ZnBH5vCcmNL/4JU=
Date:   Sun, 1 Nov 2020 10:03:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: dts: imx8mn: Enable Asynchronous Sample Rate
 Converter
Message-ID: <20201101020308.GC31601@dragon>
References: <20201019174529.289499-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019174529.289499-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:45:24PM -0500, Adam Ford wrote:
> The driver exists for the Enhanced Asynchronous Sample Rate Converter
> (EASRC) Controller, but there isn't a device tree entry for it.
> 
> On the vendor kernel, they put this on a spba-bus for SDMA support.
> 
> Add the the node for the spba-bus with the easrc node inside.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 746faf1cf2fb..7d34281332e1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -246,6 +246,34 @@ aips1: bus@30000000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> +			spba-bus@30000000 {

spba: bus@30000000

> +				compatible = "fsl,spba-bus", "simple-bus";

"fsl,spba-bus" is undocumented.  Document it or drop it.

> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = <0x30000000 0x100000>;
> +				ranges;
> +
> +				easrc: easrc@300C0000 {
> +					compatible = "fsl,imx8mn-easrc";
> +					reg = <0x300C0000 0x10000>;
> +					interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
> +					clock-names = "mem";
> +					dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
> +					       <&sdma2 18 23 0> , <&sdma2 19 23 0>,
> +					       <&sdma2 20 23 0> , <&sdma2 21 23 0>,
> +					       <&sdma2 22 23 0> , <&sdma2 23 23 0>;
> +					dma-names = "ctx0_rx", "ctx0_tx",
> +						    "ctx1_rx", "ctx1_tx",
> +						    "ctx2_rx", "ctx2_tx",
> +						    "ctx3_rx", "ctx3_tx";
> +					fsl,easrc-ram-script-name = "imx/easrc/easrc-imx8mn.bin";

Undocumented property?

Shawn

> +					fsl,asrc-rate  = <8000>;
> +					fsl,asrc-width = <16>;
> +					status = "disabled";
> +				};
> +			};
> +
>  			gpio1: gpio@30200000 {
>  				compatible = "fsl,imx8mn-gpio", "fsl,imx35-gpio";
>  				reg = <0x30200000 0x10000>;
> -- 
> 2.25.1
> 
