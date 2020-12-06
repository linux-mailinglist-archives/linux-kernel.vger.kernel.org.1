Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECA12D07B5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 23:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgLFWjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 17:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgLFWjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 17:39:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBCFC0613D0;
        Sun,  6 Dec 2020 14:38:27 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0BC878D;
        Sun,  6 Dec 2020 23:38:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1607294304;
        bh=1wx/bpAq1sVWUhiUMz+GMMhPtjFkX7zepuboWLVNUj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9OReHadtVPn4VA99AVGXswMtfibJLXuJ4bubdePZGNeg+A+ZMGaxf/eWo2r6F6vR
         Z+3PEioIfI9A0pTmWgzDVmzWPtkke/81vPZimW5P3qNsN9ng7d4zCbdLi22nGFAuQq
         ITxN8CON5sxERUUwW9DTPSGLRIL/iC3C6M5Gfp6U=
Date:   Mon, 7 Dec 2020 00:38:21 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/12] arm64: dts: zynqmp: Enable and wire reset
 controller
Message-ID: <X81dXV0uCccZ3360@pendragon.ideasonboard.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
 <c0a99c5b0438e34073429624d99a2c3f16532016.1606917949.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0a99c5b0438e34073429624d99a2c3f16532016.1606917949.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Wed, Dec 02, 2020 at 03:06:03PM +0100, Michal Simek wrote:
> Enable reset controller for several IPs.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 29 ++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 68923fbd0e89..4fa820f78d76 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -187,6 +187,11 @@ zynqmp_pcap: pcap {
>  			xlnx_aes: zynqmp-aes {
>  				compatible = "xlnx,zynqmp-aes";
>  			};
> +
> +			zynqmp_reset: reset-controller {
> +				compatible = "xlnx,zynqmp-reset";
> +				#reset-cells = <1>;
> +			};
>  		};
>  	};
>  
> @@ -466,6 +471,8 @@ gem0: ethernet@ff0b0000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			power-domains = <&zynqmp_firmware PD_ETH_0>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_GEM0>;
> +			reset-names = "gem0_rst";

I don't see any of the reset-names used in this patch defined in DT
bindings (or used in drivers). For all devices but the USB controllers
it seems they can be dropped. For the USB controllers, the bindings need
to be updated first.

>  		};
>  
>  		gem1: ethernet@ff0c0000 {
> @@ -478,6 +485,8 @@ gem1: ethernet@ff0c0000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			power-domains = <&zynqmp_firmware PD_ETH_1>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_GEM1>;
> +			reset-names = "gem1_rst";
>  		};
>  
>  		gem2: ethernet@ff0d0000 {
> @@ -490,6 +499,8 @@ gem2: ethernet@ff0d0000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			power-domains = <&zynqmp_firmware PD_ETH_2>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_GEM2>;
> +			reset-names = "gem2_rst";
>  		};
>  
>  		gem3: ethernet@ff0e0000 {
> @@ -502,6 +513,8 @@ gem3: ethernet@ff0e0000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			power-domains = <&zynqmp_firmware PD_ETH_3>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_GEM3>;
> +			reset-names = "gem3_rst";
>  		};
>  
>  		gpio: gpio@ff0a0000 {
> @@ -515,6 +528,8 @@ gpio: gpio@ff0a0000 {
>  			#interrupt-cells = <2>;
>  			reg = <0x0 0xff0a0000 0x0 0x1000>;
>  			power-domains = <&zynqmp_firmware PD_GPIO>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_GPIO>;
> +			reset-names = "gpio_rst";
>  		};
>  
>  		i2c0: i2c@ff020000 {
> @@ -526,6 +541,8 @@ i2c0: i2c@ff020000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			power-domains = <&zynqmp_firmware PD_I2C_0>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_I2C0>;
> +			reset-names = "i2c0_rst";
>  		};
>  
>  		i2c1: i2c@ff030000 {
> @@ -537,6 +554,8 @@ i2c1: i2c@ff030000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			power-domains = <&zynqmp_firmware PD_I2C_1>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_I2C1>;
> +			reset-names = "i2c1_rst";
>  		};
>  
>  		pcie: pcie@fd0e0000 {
> @@ -602,6 +621,8 @@ sata: ahci@fd0c0000 {
>  			interrupt-parent = <&gic>;
>  			interrupts = <0 133 4>;
>  			power-domains = <&zynqmp_firmware PD_SATA>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
> +			reset-names = "sata_rst";
>  		};
>  
>  		sdhci0: mmc@ff160000 {
> @@ -733,6 +754,10 @@ usb0: usb@fe200000 {
>  			reg = <0x0 0xfe200000 0x0 0x40000>;
>  			clock-names = "clk_xin", "clk_ahb";
>  			power-domains = <&zynqmp_firmware PD_USB_0>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_USB0_CORERESET>,
> +				 <&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRESET>,
> +				 <&zynqmp_reset ZYNQMP_RESET_USB0_APB>;
> +			reset-names = "usb0_crst", "usb0_hibrst", "usb0_apbrst";
>  		};
>  
>  		usb1: usb@fe300000 {
> @@ -743,6 +768,10 @@ usb1: usb@fe300000 {
>  			reg = <0x0 0xfe300000 0x0 0x40000>;
>  			clock-names = "clk_xin", "clk_ahb";
>  			power-domains = <&zynqmp_firmware PD_USB_1>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
> +				 <&zynqmp_reset ZYNQMP_RESET_USB1_HIBERRESET>,
> +				 <&zynqmp_reset ZYNQMP_RESET_USB1_APB>;
> +			reset-names = "usb1_crst", "usb1_hibrst", "usb1_apbrst";
>  		};
>  
>  		watchdog0: watchdog@fd4d0000 {

-- 
Regards,

Laurent Pinchart
