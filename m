Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11512E94F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbhADMhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:37:01 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:34228 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADMhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:37:01 -0500
Received: by mail-wm1-f54.google.com with SMTP id g25so7638166wmh.1;
        Mon, 04 Jan 2021 04:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bmz5H27nwmeYsTtVcS7MKZk8aIlltd6hD5uF34esfWQ=;
        b=gALk6G6U3FBwWN73uV+zICJg9j7Uca5s/P9TYj0T6DqluWHGzquoYrDxHoNoqTusua
         zuru1rFFTjlfFUm1cKShyj51qHFBLIGsYrx4cGuBBVfHxgXTnV98X3J/7jc/Mv8F0mw2
         +Syf3UXxDZzFCHqFPROgu+dLMGc+Sky8150Ozq/CTPfm9MGLZjj88tVzc/L+H5wgtTER
         VLm8kQnBNMxgTHZv1t4tXXk6VzANVr2OuOGVHehTLCEnxLw5qh9n63SI0kHLjx0hjuxd
         QvVIYj+5+Qlp6A3a3fmYaHgSFYNzMf20n3E10H3KZ1CLFMgCD2vN4uIZjwpTzDg2LmLz
         Xv6Q==
X-Gm-Message-State: AOAM531HRmlPdGxhI/se3EsP7fZVihHbWnMIgX6MJGxTJpcwIWTYCgLn
        nXQfpeLYzRc6zr36lTpZeXGz8vkfy4T8aA==
X-Google-Smtp-Source: ABdhPJyadpQat5iRhp9+jBlw7vUIvZA96GAzQ3euhk4XTDmfFHQf63OdMYjHiYWaSimKOncjeOhROA==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr26902395wmb.180.1609763778334;
        Mon, 04 Jan 2021 04:36:18 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h15sm88230447wru.4.2021.01.04.04.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 04:36:17 -0800 (PST)
Date:   Mon, 4 Jan 2021 13:36:15 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8mm: Add Gateworks i.MX 8M Mini
 Development Kits
Message-ID: <20210104123615.GA5974@kozik-lap>
References: <1609351123-22418-1-git-send-email-tharvey@gateworks.com>
 <1609351123-22418-2-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1609351123-22418-2-git-send-email-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 09:58:43AM -0800, Tim Harvey wrote:
> The Gateworks Venice GW71xx-0x/GW72xx-0x/GW73xx-0x are development
> kits comprised of a GW700x SoM and a Baseboard. Future SoM's such
> as the GW701x will create additional combinations.
> 
> The GW700x SoM contains:
>  - i.MX 8M Mini SoC
>  - LPDDR4 DRAM
>  - eMMC FLASH
>  - Gateworks System Controller (eeprom/pushbutton/reset/voltage-monitor)
>  - GbE PHY connected to the i.MX 8M Mini FEC
>  - Power Management IC
> 
> The GW71xx Baseboard contains:
>  - 1x MiniPCIe Socket with USB2.0, PCIe, and SIM
>  - 1x RJ45 GbE (i.MX 8M Mini FEC)
>  - I/O connector with 1x-SPI/1x-I2C/1x-UART/4x-GPIO signals
>  - PCIe Clock generator
>  - GPS and accelerometer
>  - 1x USB 2.0 Front Panel connector
>  - wide range power supply
> 
> The GW72xx Baseboard contains:
>  - 2x MiniPCIe Socket with USB2.0, PCIe, and SIM
>  - 2x RJ45 GbE (i.MX 8M Mini FEC and LAN743x)
>  - 1x MicroSD connector
>  - 1x USB 2.0 Front Panel connector
>  - 1x SPI connector
>  - 1x Serial connector supporting 2x-UART or 1x-UART configured as 1 of:
>    RS232 w/ flow-controll, RS485, RS422
>  - PCIe Clock generator
>  - GPS and accelerometer
>  - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
>  - I/O connector with 2x-ADC,2x-GPIO,1x-UART,1x-I2C
>  - wide range power supply
> 
> The GW73xx Baseboard contains:
>  - 3x MiniPCIe Socket with USB2.0, PCIe, and SIM
>  - 2x RJ45 GbE (i.MX 8M Mini FEC and LAN743x)
>  - 1x MicroSD connector
>  - 1x USB 2.0 Front Panel connector
>  - 1x SPI connector
>  - 1x Serial connector supporting 2x-UART or 1x-UART configured as 1 of:
>    RS232 w/ flow-controll, RS485, RS422
>  - WiFi/BT
>  - PCIe Clock generator
>  - GPS and accelerometer
>  - Media Expansion connector (MIPI-CSI/MIPI-DSI/GPIO/I2S)
>  - I/O connector with 2x-ADC,2x-GPIO,1x-UART,1x-I2C
>  - wide range power supply
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v4:
>  - replace underscore with hyphen for gpio-keys node
>  - add 'off-board header' comments to i2c/spi/uart nodes that go off-board
>  - move node comments to own line above node
>  - add spaces after comma
>  - move uart2_gpio rs485 config pinmux to hoggroup as they don't necessarily
>    relate to uart2
>  - fix fifo-depth dt property for phy
> 
> v3:
>  - fix gpio controller node name
>  - add rtc node to SoM
>  - add pmic pinctrl to SoM
>  - fixed compatible string for SoM eeprom's
> 
> v2:
>  - fix i.MX 8M Mini name in commit log
>  - consistent use of underscore vs hyphen in labels
>  - fix gsc interrupt type
>  - fix iomux group node names
>  - fix led-controller bindings:
>    (use correct node names, color, function and remove label)
>  - use accelerometer node name vs accel
>  - remove sai3 from gw71xx baseboard
>  - added serial connector description to commit message
>  - added I/O connector description to commit message
>  - removed unnecessary #address-cells/#size-cells from gpio-keys node
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile             |   3 +
>  .../boot/dts/freescale/imx8mm-venice-gw700x.dtsi   | 497 +++++++++++++++++++++
>  .../boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts |  19 +
>  .../boot/dts/freescale/imx8mm-venice-gw71xx.dtsi   | 186 ++++++++
>  .../boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts |  20 +
>  .../boot/dts/freescale/imx8mm-venice-gw72xx.dtsi   | 314 +++++++++++++
>  .../boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts |  19 +
>  .../boot/dts/freescale/imx8mm-venice-gw73xx.dtsi   | 366 +++++++++++++++
>  8 files changed, 1424 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index f8d5943..ecdd233 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -32,6 +32,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
> new file mode 100644
> index 00000000..5985a39
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
> @@ -0,0 +1,497 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2020 Gateworks Corporation
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0 0x80000000>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		user_pb {

All these nodes as well - hyphens instead of underscore.


> +			label = "user_pb";
> +			gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
> +			linux,code = <BTN_0>;
> +		};
> +
> +		user_pb1x {
> +			label = "user_pb1x";
> +			linux,code = <BTN_1>;
> +			interrupt-parent = <&gsc>;
> +			interrupts = <0>;
> +		};
> +
> +		key_erased {
> +			label = "key_erased";
> +			linux,code = <BTN_2>;
> +			interrupt-parent = <&gsc>;
> +			interrupts = <1>;
> +		};
> +
> +		eeprom_wp {
> +			label = "eeprom_wp";
> +			linux,code = <BTN_3>;
> +			interrupt-parent = <&gsc>;
> +			interrupts = <2>;
> +		};
> +
> +		tamper {
> +			label = "tamper";
> +			linux,code = <BTN_4>;
> +			interrupt-parent = <&gsc>;
> +			interrupts = <5>;
> +		};
> +
> +		switch_hold {
> +			label = "switch_hold";
> +			linux,code = <BTN_5>;
> +			interrupt-parent = <&gsc>;
> +			interrupts = <7>;
> +		};
> +	};

Rest of DTS looks ok, thanks!

Best regards,
Krzysztof

