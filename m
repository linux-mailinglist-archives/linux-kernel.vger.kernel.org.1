Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C12C3190
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgKXUBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 15:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbgKXUBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:01:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C0AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 12:01:08 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kheUo-0003N1-Gn; Tue, 24 Nov 2020 21:01:02 +0100
Message-ID: <89724abeca0eb407c24807507ff6b1bc310d7275.camel@pengutronix.de>
Subject: Re: dts: add MNT Reform 2.0
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Lukas F. Hartmann" <lukas@mntre.com>
Cc:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 24 Nov 2020 21:01:01 +0100
In-Reply-To: <20201124172735.981878-1-lukas@mntre.com>
References: <20201124172735.981878-1-lukas@mntre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

just some general comments, not a full review.

Am Dienstag, den 24.11.2020, 18:27 +0100 schrieb Lukas F. Hartmann:
> This is the device tree for the MNT Reform 2.0 open hardware laptop
> which is based on NXP i.MX8MQ. It is designed around the Boundary Devices
> Nitrogen8M SoM.

Since this is based on a module the DT should be split in a module dtsi
and a baseboard dts.

> Technical details: https://mntre.com/reform
> 
> Signed-off-by: Lukas F. Hartmann <lukas@mntre.com>
> ---
>  .../boot/dts/freescale/imx8mq-mnt-reform2.dts | 783 ++++++++++++++++++
>  1 file changed, 783 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts b/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
> new file mode 100644
> index 000000000..c95a22a1e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
> @@ -0,1 +1,782 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2018 Boundary Devices
> + * Copyright 2019-2020 MNT Research GmbH
> + */
> +
> +/dts-v1/;
> +
> +#include "dt-bindings/input/input.h"
> +#include "dt-bindings/pwm/pwm.h"
> +#include "dt-bindings/usb/pd.h"
> +#include "dt-bindings/gpio/gpio.h"
> +#include "imx8mq.dtsi"
> +
> +/ {
> +	model = "MNT Reform 2";
> +	compatible = "fsl,imx8mq";

This needs a more specific compatible.

> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	// 4GB of RAM
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x40000000 0 0xc0000000>;
> +	};

Do you need this node? Most bootloaders should be able to patch in the
correct amount of memory before passing control to the kernel.

> +
> +	reg_vref_0v9: regulator-vref-0v9 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref-0v9";
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_vref_1v2: regulator-vref-1v2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref-1v2";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_vref_1v8: regulator-vref-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref-1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_vref_2v5: regulator-vref-2v5 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref-2v5";
> +		regulator-min-microvolt = <2500000>;
> +		regulator-max-microvolt = <2500000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_vref_3v3: regulator-vref-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_vref_5v: regulator-vref-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm2 0 10000>;
> +		enable-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +		brightness-levels = <0 32 64 128 160 200 255>;
> +		default-brightness-level = <6>;
> +	};
> +
> +	panel {
> +		compatible = "innolux,n125hce-gn1";
> +		power = <&reg_vref_3v3>;
> +		backlight = <&backlight>;
> +		no-hpd;
> +
> +		port@0 {
> +			panel_in: endpoint {
> +				remote-endpoint = <&edp_bridge_out>;
> +			};
> +		};
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "wm8960-audio";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&dai_cpu_master>;
> +		simple-audio-card,bitclock-master = <&dai_cpu_master>;
> +
> +		simple-audio-card,widgets =
> +		"Microphone", "Mic Jack",
> +		"Line", "Line In",
> +		"Line", "Line Out",
> +		"Speaker", "Speaker",
> +		"Headphone", "Headphone Jack";
> +		simple-audio-card,routing =
> +		"Headphone Jack", "HP_L",
> +		"Headphone Jack", "HP_R",
> +		"Speaker", "SPK_LP",
> +		"Speaker", "SPK_LN",
> +		"Speaker", "SPK_RP",
> +		"Speaker", "SPK_RN",
> +		"Mic Jack", "MICB",
> +		"LINPUT1", "Mic Jack",
> +		"LINPUT2", "Line In",
> +		"RINPUT2", "Line In";
> +
> +		dai_cpu_master: simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +		};
> +
> +		dailink0: simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +		};
> +	};
> +
> +	pcie0_refclk: pcie0-refclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
> +
> +	pcie1_refclk: pcie1-refclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};

One of those doesn't actually exist, as I know that one of the PCIe
interfaces on the BD module uses the SoC internal refclock.

> +};
> +
> +&A53_0 {
> +	cpu-supply = <&reg_arm_dram>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&reg_arm_dram>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&reg_arm_dram>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&reg_arm_dram>;
> +};
> +
> +/ {
> +	soc@0 {
> +		bus@32c00000 {
> +			dcss: display-controller@32e00000 {
> +				status = "okay";
> +
> +				compatible = "nxp,imx8mq-dcss";
> +				reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
> +				interrupts = <6>, <8>, <9>;
> +				interrupt-names = "ctxld", "ctxld_kick", "vblank";
> +				interrupt-parent = <&irqsteer>;
> +				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>,
> +					<&clk IMX8MQ_CLK_DISP_AXI_ROOT>,
> +					<&clk IMX8MQ_CLK_DISP_RTRM_ROOT>,
> +					<&clk IMX8MQ_CLK_DC_PIXEL>,
> +					<&clk IMX8MQ_CLK_DISP_DTRC>;
> +				clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
> +				assigned-clocks = <&clk IMX8MQ_CLK_DISP_AXI>,
> +					<&clk IMX8MQ_CLK_DISP_RTRM>,
> +					<&clk IMX8MQ_VIDEO2_PLL1_REF_SEL>,
> +					<&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
> +					<&clk IMX8MQ_CLK_DC_PIXEL>;
> +				assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
> +					<&clk IMX8MQ_SYS1_PLL_800M>,
> +					<&clk IMX8MQ_CLK_27M>,
> +					<&clk IMX8MQ_CLK_25M>,
> +					<&clk IMX8MQ_VIDEO_PLL1_OUT>;
> +				assigned-clock-rates = <800000000>,
> +					<400000000>,
> +					<27000000>,
> +					<25000000>,
> +					<594000000>;

This whole node shouldn't be in this DT. I hadn't realized that the
DCSS DT patch is not yet upstream. Please work with Shawn and Laurentiu
to get this node into the imx8mq.dtsi instead.

> +				port {
> +					dcss_dsi_out: endpoint {
> +						remote-endpoint = <&mipi_dsi_in>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +// LCDIF is not used, but has to be active or DCSS won't work

This sounds fishy. There is no dependency between the two interfaces,
so you shouldn't need to enable the lcdif to get the dcss working. Do
you miss some clock assignment in the dcss node?

> +&lcdif {
> +	status = "okay";
> +	/delete-node/ port@0;
> +};
> +
> +&dphy {
> +	status = "okay";
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@4 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <4>;
> +			interrupts = <&gpio1 11 IRQ_TYPE_LEVEL_LOW>;
> +			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	// I2C Mux on Nitrogen8M_SOM
> +	i2cmux@70 {
> +		compatible = "nxp,pca9546";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_i2c1_pca9546>;
> +		reg = <0x70>;
> +		reset-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c1a: i2c1@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			// Regulator on Nitrogen8M_SOM
> +			reg_arm_dram: fan53555@60 {
> +				compatible = "fcs,fan53555";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_reg_arm_dram>;
> +				reg = <0x60>;
> +				regulator-min-microvolt =	 <900000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-ramp-delay = <8000>;
> +				regulator-always-on;
> +				vsel-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
> +			};
> +		};
> +
> +		i2c1b: i2c1@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			// Regulator on Nitrogen8M_SOM
> +			reg_dram_1p1v: fan53555@60 {
> +				compatible = "fcs,fan53555";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_reg_dram_1p1v>;
> +				reg = <0x60>;
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-ramp-delay = <8000>;
> +				regulator-always-on;
> +				vsel-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> +			};
> +		};
> +
> +		i2c1c: i2c1@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			// Regulator on Nitrogen8M_SOM
> +			reg_soc_gpu_vpu: fan53555@60 {
> +				compatible = "fcs,fan53555";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_reg_soc_gpu_vpu>;
> +				reg = <0x60>;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-ramp-delay = <8000>;
> +				regulator-always-on;
> +				vsel-gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
> +			};
> +		};
> +
> +		// No peripheral connected, available on DSI connector
> +		i2c1d: i2c1@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> +
> +// No peripheral connected, available on CSI connector
> +&i2c2 {
> +	status = "disabled";
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	// Audio chip on motherboard
> +	codec: wm8960@1a {
> +		compatible = "wlf,wm8960";
> +		reg = <0x1a>;
> +		clocks = <&clk IMX8MQ_CLK_SAI2>;
> +		clock-names = "mclk";
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	// Realtime clock chip on motherboard
> +	pcf8523: pcf8523@68 {
> +		compatible = "nxp,pcf8523";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +
> +	// DSI to eDP converter on motherboard
> +	edp_bridge: sn65dsi86@2c {
> +		compatible = "ti,sn65dsi86";
> +		reg = <0x2c>;
> +		enable-gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				edp_bridge_in: endpoint {
> +					remote-endpoint = <&mipi_dsi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				edp_bridge_out: endpoint {
> +					remote-endpoint = <&panel_in>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +		// WL_EN on Nitrogen8M_SOM, pin 38, goes to /EN input of SN65DSI86
> +		MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20		0x19
> +		MX8MQ_IOMUXC_GPIO1_IO14_GPIO1_IO14		0x56
> +		>;
> +	};
> +
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
> +		MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO		0x23
> +		MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
> +		MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
> +		MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
> +		MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
> +		MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
> +		MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
> +		MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
> +		MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
> +		MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
> +		MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
> +		MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
> +		MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
> +		MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
> +		MX8MQ_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x59
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
> +		MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
> +		>;
> +	};
> +
> +	pinctrl_i2c1_pca9546: i2c1-pca9546grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_GPIO1_IO04_GPIO1_IO4		0x46
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL			0x4000007f
> +		MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA			0x4000007f
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_I2C3_SCL_I2C3_SCL			0x4000007f
> +		MX8MQ_IOMUXC_I2C3_SDA_I2C3_SDA			0x4000007f
> +		>;
> +	};
> +
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_I2C4_SCL_I2C4_SCL			0x4000007f
> +		MX8MQ_IOMUXC_I2C4_SDA_I2C4_SDA			0x4000007f
> +		>;
> +	};
> +
> +	pinctrl_pcie0: pcie0grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_ECSPI1_MOSI_GPIO5_IO7		0x16
> +		>;
> +	};
> +
> +	pinctrl_pcie1: pcie1grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x16
> +		>;
> +	};
> +
> +	pinctrl_pwm2: pwm2grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SPDIF_RX_PWM2_OUT			0x16
> +		>;
> +	};
> +
> +	pinctrl_pwm3: pwm3grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SPDIF_TX_PWM3_OUT			0x16
> +		>;
> +	};
> +
> +	// Backlight
> +	pinctrl_pwm4: pwm4grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SAI3_MCLK_PWM4_OUT			0x16
> +		>;
> +	};
> +
> +	pinctrl_reg_arm_dram: reg-arm-dram {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x16
> +		>;
> +	};
> +
> +	pinctrl_reg_dram_1p1v: reg-dram-1p1v {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SD1_STROBE_GPIO2_IO11		0x16
> +		>;
> +	};
> +
> +	pinctrl_reg_soc_gpu_vpu: reg-soc-gpu-vpu {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SD2_WP_GPIO2_IO20			0x16
> +		>;
> +	};
> +
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0		0xd6	/* Pin 166 */
> +		MX8MQ_IOMUXC_SAI2_RXFS_SAI2_RX_SYNC		0xd6	/* Pin 168 */
> +		MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK		0xd6	/* Pin 170 */
> +		MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC		0xd6	/* Pin 172 */
> +		MX8MQ_IOMUXC_SAI2_RXC_SAI2_RX_BCLK		0xd6	/* Pin 174 */
> +		MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK		0xd6	/* Pin 176 */
> +		MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0		0xd6	/* Pin 168 */
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x45
> +		MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x45
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX		0x45
> +		MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX		0x45
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_UART3_RXD_UART3_DCE_RX		0x45
> +		MX8MQ_IOMUXC_UART3_TXD_UART3_DCE_TX		0x45
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
> +		MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
> +		MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
> +		MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
> +		MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
> +		MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
> +		MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
> +		MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
> +		MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
> +		MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
> +		MX8MQ_IOMUXC_SD1_RESET_B_GPIO2_IO10		0x41
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
> +		MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
> +		MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xcd
> +		MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xcd
> +		MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xcd
> +		MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xcd
> +		MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xcd
> +		MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xcd
> +		MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xcd
> +		MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xcd
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
> +		MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
> +		MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xdf
> +		MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xdf
> +		MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xdf
> +		MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xdf
> +		MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xdf
> +		MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xdf
> +		MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xdf
> +		MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xdf
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x03
> +		MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
> +		MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
> +		MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
> +		MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
> +		MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x0d
> +		MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xcd
> +		MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xcd
> +		MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xcd
> +		MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xcd
> +		MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xcd
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x1e
> +		MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xce
> +		MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xce
> +		MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xce
> +		MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xce
> +		MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xce
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +		MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
> +		>;
> +	};
> +};

iomuxc should be the last node in the DT file. Other nodes should be
sorted alphabetically.

> +
> +&mipi_dsi {
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			// We don't want input from LCDIF
> +			/delete-node/ endpoint@0;
> +
> +			mipi_dsi_in: endpoint@1 {
> +				reg = <1>;
> +				remote-endpoint = <&dcss_dsi_out>;
> +			};
> +		};
> +		port@1 {
> +			reg = <1>;
> +			mipi_dsi_out: endpoint {
> +				remote-endpoint = <&edp_bridge_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&pcie0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie0>;
> +	reset-gpio = <&gpio5 7 GPIO_ACTIVE_LOW>;
> +	internal-refclk;

This property isn't supported in upstream. The proepr solution would be
to point the pcie_bus clock handle to the internal clock and add
support to the PCIe driver to notice this fact and program the GPR
accordingly.

> +
> +	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
> +		<&clk IMX8MQ_CLK_PCIE1_AUX>,
> +		<&clk IMX8MQ_CLK_PCIE1_PHY>,
> +		<&pcie0_refclk>;
> +
> +	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +
> +	assigned-clocks = <&clk IMX8MQ_CLK_PCIE1_CTRL>,
> +		<&clk IMX8MQ_CLK_PCIE1_PHY>;
> +	assigned-clock-parents = <&clk IMX8MQ_SYS2_PLL_250M>,
> +		<&clk IMX8MQ_SYS2_PLL_100M>;
> +
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie1>;
> +	reset-gpio = <&gpio3 23 GPIO_ACTIVE_LOW>;
> +
> +	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
> +		<&clk IMX8MQ_CLK_PCIE2_AUX>,
> +		<&clk IMX8MQ_CLK_PCIE2_PHY>,
> +		<&pcie1_refclk>;
> +	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +	status = "okay";
> +};
> +
> +&pwm2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm2>;
> +	status = "okay";
> +};
> +
> +&pwm3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm3>;
> +	status = "okay";
> +};
> +
> +// Backlight control
> +&pwm4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm4>;
> +	status = "okay";
> +};
> +
> +&sai2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
> +	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL2_OUT>;
> +	assigned-clock-rates = <12288000>;
> +	status = "okay";
> +};
> +
> +// Don't use i.MX8M internal RTC because we have a dedicated one
> +&snvs_rtc {
> +	status = "disabled";
> +};
> +
> +// Console
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +// Auxiliary serial port on motherboard
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +// connected to LPC11U24 chip on the motherboard
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	status = "okay";
> +};
> +
> +&usb_dwc3_0 {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
> +&usb_dwc3_1 {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
> +&usb3_phy0 {
> +	vbus-supply = <&reg_vref_5v>;
> +	status = "okay";
> +};
> +
> +&usb3_phy1 {
> +	vbus-supply = <&reg_vref_5v>;
> +	status = "okay";
> +};
> +
> +// eMMC on Nitrogen8M_SOM
> +&usdhc1 {
> +	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
> +	assigned-clock-rates = <400000000>;
> +	bus-width = <8>;
> +	no-mmc-hs400;
> +	non-removable;

no-sd maybe, to speed up enumeration?

> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	status = "disabled";
> +};
> +
> +// SD Card on motherboard
> +&usdhc2 {
> +	assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
> +	assigned-clock-rates = <200000000>;
> +	bus-width = <4>;
> +	no-1-8-v; // We don't support 1.8V signaling

This should not be necessary if you instead add a vqmmc-supply and
point it to the same fixed 3.3V regulator as the vmmc.

> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	vmmc-supply = <&reg_vref_3v3>;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> --
> 2.28.0

Regards,
Lucas

