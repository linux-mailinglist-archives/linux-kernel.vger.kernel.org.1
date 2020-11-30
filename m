Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874E12C86AC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgK3O2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:28:33 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33757 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgK3O2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:28:32 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A73B3E001D;
        Mon, 30 Nov 2020 14:27:42 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
        robh+dt@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v2] ARM: dts: mvebu: Add device tree for
 RD-AC3X-48G4X2XL board
In-Reply-To: <20201126044544.17829-1-aryan.srivastava@alliedtelesis.co.nz>
References: <20201126044544.17829-1-aryan.srivastava@alliedtelesis.co.nz>
Date:   Mon, 30 Nov 2020 15:27:41 +0100
Message-ID: <87zh2yj4wy.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aryan,

> Add device tree for RD-AC3X-48G4X2XL board. This has a Armada 382 SoC on
> a interposer board connected to a baseboard with a Prestera AC3X ASIC
> connected via PCI.
>
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
> Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied on mvebu/dt

Thanks,

Gregory

> ---
>
> Notes:
>     Changes in v2:
>     -Added comment for CPLD
>
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/armada-382-rd-ac3x-48g4x2xl.dts  | 112 ++++++++++++++++++
>  2 files changed, 113 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-382-rd-ac3x-48g4x2xl.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ce66ffd5a1bb..a60407ad7347 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1319,6 +1319,7 @@ dtb-$(CONFIG_MACH_ARMADA_370) += \
>  dtb-$(CONFIG_MACH_ARMADA_375) += \
>  	armada-375-db.dtb
>  dtb-$(CONFIG_MACH_ARMADA_38X) += \
> +	armada-382-rd-ac3x-48g4x2xl.dtb \
>  	armada-385-clearfog-gtr-s4.dtb \
>  	armada-385-clearfog-gtr-l8.dtb \
>  	armada-385-db-88f6820-amc.dtb \
> diff --git a/arch/arm/boot/dts/armada-382-rd-ac3x-48g4x2xl.dts b/arch/arm/boot/dts/armada-382-rd-ac3x-48g4x2xl.dts
> new file mode 100644
> index 000000000000..584f0d0398a5
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-382-rd-ac3x-48g4x2xl.dts
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Device Tree file for Marvell Armada 382 reference board
> + * (RD-AC3X-48G4X2XL)
> + *
> + * Copyright (C) 2020 Allied Telesis Labs
> + */
> +
> +/dts-v1/;
> +#include "armada-385.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Marvell Armada 382 RD-AC3X";
> +	compatible = "marvell,rd-ac3x-48g4x2xl", "marvell,rd-ac3x",
> +			 "marvell,armada385", "marvell,armada380";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	aliases {
> +		ethernet0 = &eth1;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>; /* 512MB */
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
> +			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
> +	};
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +	status = "okay";
> +
> +	eeprom@53{
> +		compatible = "atmel,24c64";
> +		reg = <0x53>;
> +	};
> +
> +	/* CPLD device present at 0x3c. Function unknown */
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins>;
> +	status = "okay";
> +};
> +
> +&eth1 {
> +	status = "okay";
> +	phy = <&phy0>;
> +	phy-mode = "rgmii-id";
> +};
> +
> +&mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mdio_pins>;
> +
> +	phy0: ethernet-phy@0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&pciec {
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	/* Port 0, Lane 0 */
> +	status = "okay";
> +};
> +
> +&nand_controller {
> +	status = "okay";
> +
> +	nand@0 {
> +		reg = <0>;
> +		label = "pxa3xx_nand-0";
> +		nand-rb = <0>;
> +		nand-on-flash-bbt;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@0 {
> +				reg = <0x00000000 0x00500000>;
> +				label = "u-boot";
> +			};
> +			partition@500000{
> +				reg = <0x00500000 0x00400000>;
> +				label = "u-boot env";
> +			};
> +			partition@900000{
> +				reg = <0x00900000 0x3F700000>;
> +				label = "user";
> +			};
> +		};
> +	};
> +};
> +
> +&refclk {
> +	clock-frequency = <200000000>;
> +};
> -- 
> 2.29.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
