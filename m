Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F4F2FF817
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbhAUWiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:38:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:35602 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbhAUWil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:38:41 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1E35A50E;
        Thu, 21 Jan 2021 23:37:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1611268676;
        bh=mWURBj6RaXT6C5m2AXt2YVFGkQ1ZtlccLo1/SMFcSWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qbWAd+5RdXT6IMz1qh1A4vJDeBfKtbmfIzfhb4OMxTg4W/M4Dau9r9bK9COk/4bXi
         ItPL60lN55I1TX7zKGWN36rjkNCQOOLh9McJfXtgzFIUM1FKmQ2qKP39WwAB8TvKoR
         ZwEwberf0+cL019Mq0BnXESyH3tRk2fiwtr9rjds=
Date:   Fri, 22 Jan 2021 00:37:38 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: zynqmp: Wire up the DisplayPort subsystem
Message-ID: <YAoCMqq/hpY0Jz6A@pendragon.ideasonboard.com>
References: <cover.1611232558.git.michal.simek@xilinx.com>
 <9769d4d103b6eb75e3324825117f6832a746004e.1611232558.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9769d4d103b6eb75e3324825117f6832a746004e.1611232558.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Thu, Jan 21, 2021 at 01:36:07PM +0100, Michal Simek wrote:
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Enable the dpsub device and wire it up to the PS-GTR PHY lanes routed to
> the DisplayPort connector.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Wire all the boards
> 
> ---
>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 31 +++++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 10 ++++++
>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 11 +++++++
>  .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 11 +++++++
>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 11 +++++++
>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 11 +++++++
>  6 files changed, 85 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index 71ebcaadb7c8..a53598c3624b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/phy/phy.h>
>  
>  / {
>  	model = "ZynqMP ZCU100 RevC";
> @@ -108,6 +109,18 @@ ina226 {
>  		compatible = "iio-hwmon";
>  		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
>  	};
> +
> +	si5335a_0: clk26 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +	};
> +
> +	si5335a_1: clk27 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <27000000>;
> +	};

This is fine as a workaround for now, but I'm still wondering how we'll
solve this properly. We can declare the SI5335A in DT without wiring the
output that provides the clock to the PS, otherwise it will be disabled
as part of the boot process.

>  };
>  
>  &dcc {
> @@ -224,6 +237,13 @@ i2csw_7: i2c@7 {
>  	};
>  };
>  
> +&psgtr {
> +	status = "okay";
> +	/* usb3, dps */
> +	clocks = <&si5335a_0>, <&si5335a_1>;
> +	clock-names = "ref0", "ref1";
> +};
> +
>  &rtc {
>  	status = "okay";
>  };
> @@ -295,3 +315,14 @@ &usb1 {
>  &watchdog0 {
>  	status = "okay";
>  };
> +
> +&zynqmp_dpdma {
> +	status = "okay";
> +};
> +
> +&zynqmp_dpsub {
> +	status = "okay";
> +	phy-names = "dp-phy0", "dp-phy1";
> +	phys = <&psgtr 1 PHY_TYPE_DP 0 1>,
> +	       <&psgtr 0 PHY_TYPE_DP 1 1>;
> +};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 9abd10f6785a..12e8bd48dc8c 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -714,3 +714,13 @@ &usb0 {
>  &watchdog0 {
>  	status = "okay";
>  };
> +
> +&zynqmp_dpdma {
> +	status = "okay";
> +};
> +
> +&zynqmp_dpsub {
> +	status = "okay";
> +	phy-names = "dp-phy0";
> +	phys = <&psgtr 1 PHY_TYPE_DP 0 3>;
> +};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index 8ede619fea52..5637e1c17fdf 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -224,3 +224,14 @@ &usb0 {
>  &watchdog0 {
>  	status = "okay";
>  };
> +
> +&zynqmp_dpdma {
> +	status = "okay";
> +};
> +
> +&zynqmp_dpsub {
> +	status = "okay";
> +	phy-names = "dp-phy0", "dp-phy1";
> +	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
> +	       <&psgtr 0 PHY_TYPE_DP 1 3>;
> +};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index 414f98f1831e..7f2e32831b05 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -280,3 +280,14 @@ &usb0 {
>  &watchdog0 {
>  	status = "okay";
>  };
> +
> +&zynqmp_dpdma {
> +	status = "okay";
> +};
> +
> +&zynqmp_dpsub {
> +	status = "okay";
> +	phy-names = "dp-phy0", "dp-phy1";
> +	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
> +	       <&psgtr 0 PHY_TYPE_DP 1 3>;
> +};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index d60a30787022..18771e868399 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -156,6 +156,17 @@ &dcc {
>  	status = "okay";
>  };
>  
> +&zynqmp_dpdma {
> +	status = "okay";
> +};
> +
> +&zynqmp_dpsub {
> +	status = "okay";
> +	phy-names = "dp-phy0", "dp-phy1";
> +	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
> +	       <&psgtr 0 PHY_TYPE_DP 1 3>;
> +};
> +
>  /* fpd_dma clk 667MHz, lpd_dma 500MHz */
>  &fpd_dma_chan1 {
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index 758de05c4a4b..d4b68f0d0098 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -584,3 +584,14 @@ &usb0 {
>  	status = "okay";
>  	dr_mode = "host";
>  };
> +
> +&zynqmp_dpdma {
> +	status = "okay";
> +};
> +
> +&zynqmp_dpsub {
> +	status = "okay";
> +	phy-names = "dp-phy0", "dp-phy1";
> +	phys = <&psgtr 1 PHY_TYPE_DP 0 1>,
> +	       <&psgtr 0 PHY_TYPE_DP 1 1>;
> +};

-- 
Regards,

Laurent Pinchart
