Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F131528DE3E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 12:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgJNKFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 06:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgJNKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 06:05:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9573C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 03:05:08 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kSdeZ-0000dn-0O; Wed, 14 Oct 2020 12:05:03 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1kSdeX-0003j6-Tf; Wed, 14 Oct 2020 12:05:01 +0200
Date:   Wed, 14 Oct 2020 12:05:01 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/3] ARM: dts: add Van der Laan LANMCU board
Message-ID: <20201014100501.djbfqzdeodowm4ov@pengutronix.de>
References: <20201014085316.11916-1-o.rempel@pengutronix.de>
 <20201014085316.11916-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014085316.11916-3-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:54:21 up 334 days,  1:12, 373 users,  load average: 0.07, 0.16,
 0.12
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

pls can you send a patch adding this board to:
Documentation/devicetree/bindings/arm/fsl.yaml

infront of this patch?

On 20-10-14 10:53, Oleksij Rempel wrote:
> Van der Laan LANMCU is a module for the food storage rooms to control
> proper gas composition.
> 
> Co-Developed-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/Makefile          |   1 +
>  arch/arm/boot/dts/imx6dl-lanmcu.dts | 468 ++++++++++++++++++++++++++++
>  2 files changed, 469 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-lanmcu.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2289a28c0ff6..dc2543a7b7e9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -447,6 +447,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-icore.dtb \
>  	imx6dl-icore-mipi.dtb \
>  	imx6dl-icore-rqs.dtb \
> +	imx6dl-lanmcu.dtb \
>  	imx6dl-mamoj.dtb \
>  	imx6dl-nit6xlite.dtb \
>  	imx6dl-nitrogen6x.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-lanmcu.dts b/arch/arm/boot/dts/imx6dl-lanmcu.dts
> new file mode 100644
> index 000000000000..60336c972286
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-lanmcu.dts
> @@ -0,0 +1,468 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Protonic Holland
> + * Copyright (c) 2020 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include "imx6dl.dtsi"
> +
> +/ {

...

> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rmii";
> +	clocks = <&clks IMX6QDL_CLK_ENET>,
> +		 <&clks IMX6QDL_CLK_ENET>,
> +		 <&clock_ksz8081>;
> +	clock-names = "ipg", "ahb", "ptp";
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* Microchip KSZ8081RNA PHY */
> +		rgmii_phy: ethernet-phy@0 {

Do you need this phandle here?

> +			reg = <0>;
> +			interrupts-extended = <&gpio5 23 IRQ_TYPE_LEVEL_LOW>;
> +			reset-gpios = <&gpio5 22 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <300>;
> +		};
> +	};
> +};

...

> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	edt-ft5406@38 {

Please use generic names like: touchscreen@38 or touchcontroller@38.

> +		compatible = "edt,edt-ft5406";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ts_edt>;
> +		reg = <0x38>;

reg should be 2nd entry.

> +		interrupts-extended = <&gpio3 20 IRQ_TYPE_EDGE_FALLING>;
> +
> +		touchscreen-size-x = <1792>;
> +		touchscreen-size-y = <1024>;
> +
> +		touchscreen-fuzz-x = <0>;
> +		touchscreen-fuzz-y = <0>;
> +
> +		/* Touch screen calibration */
> +		threshold = <50>;
> +		gain = <5>;
> +		offset = <10>;
> +	};
> +
> +	rtc@51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +	};
> +};

...

> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	no-1-8-v;
> +	non-removable;
> +	mmc-pwrseq = <&usdhc2_wifi_pwrseq>;
> +	status = "okay";

status is always the last property of this list.

> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	brcmf: bcrmf@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
> +};

Regards,
  Marco
