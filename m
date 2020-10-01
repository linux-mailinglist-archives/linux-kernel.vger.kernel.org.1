Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47304280031
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbgJANbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:31:01 -0400
Received: from mail-vi1eur05on2090.outbound.protection.outlook.com ([40.107.21.90]:22295
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731993AbgJANbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:31:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDT1ebAf4VzuDkPrMmytKg/mBAQDndvH9hU5cHCIswa0dDmd+eIFDZBdfvRnZz5I6Wvmc1ReULlJ1Fkb1fw06rZh/ttp2lqc0yrVi9+aryVs4XDcz3R8YnyAwVsAQzRUI0IUqaA8PEzpfIWiU+k6riDRXEdzRB1oIkJ16pwcFlauUN519PuDMxEEJ3CPN9aPWts1B07JCRGCQrZOep2wAx5whGowA+ESfIJ5Npc4HFzSELHm+pVUBc0TPE/buGKZ86NPMH9P6tRhaDSIG5y6RTeDKDHk04bT5iHD68LyLCKEyFuC5+jrppDZsM4/ZOKlUoXFmJNSfTlvESWhU13zBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOm5LSYwumBLjuRbgwIPRLrTu33FvMwAFZAdHEHWJRc=;
 b=Ehwr1+E5G7hIZqZ9x6e1Rhlm3vZC4K4jkWx2VEYDK5m2PVZ+CoFRppC4x2R2CyXXkvSkpDwadk27VWYvO4QpE5/hbwim2mlGHmVihRu75U4k6XVdD5IhNGoGRrpVY1dp8byzrJbtTxzVShqbGia9LaA00MrwDeNp5myEagJ3QPrFz6eDqv6Yr2Ri7L8cDEXomhds3+z3cuUAIvXEIt6uqfwog775HHhfhLUp7mkxrn6fHE/o+9nGuMJQFW11n1K5oXO84nzxO6Fz7Uq6mubujMfMLq4efsxQV5nEWATzB2s0yxmWbDQUGQsE9LatuWKghFc8gK6wYasX/jeenlD8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOm5LSYwumBLjuRbgwIPRLrTu33FvMwAFZAdHEHWJRc=;
 b=LihSZqRYN47eHSTGDXGawIStn9TVmGopfx9IMU4Aux1twhXe2shVlcTerj+TJufSiX3odr/3FSxSqheL6JtvtMRmzJkQvrANr2fyEo9TzdX4XnOqoZo7EW8XSKFYYwLnPggJOGbgpNr2hW2ID22xmKvpY4zMzOBzzFhvDTUqVMI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM9PR10MB4071.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 13:30:54 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 13:30:54 +0000
Subject: Re: [PATCH v3 1/2] arm64: dts: Add the Kontron i.MX8M Mini SoMs and
 baseboards
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?Q?S=c3=a9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201001120717.13027-1-frieder.schrempf@kontron.de>
 <20201001125722.GA6082@kozik-lap>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <985c5eb3-3f8a-2b70-8831-b7b52671ee4f@kontron.de>
Date:   Thu, 1 Oct 2020 15:30:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201001125722.GA6082@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.247.42.197]
X-ClientProxiedBy: AM6P194CA0096.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::37) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (89.247.42.197) by AM6P194CA0096.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 13:30:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 178f131d-18c8-47f1-d1c9-08d8660e38bf
X-MS-TrafficTypeDiagnostic: AM9PR10MB4071:
X-Microsoft-Antispam-PRVS: <AM9PR10MB40712A1AF4D0758D09CBF044E9300@AM9PR10MB4071.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XN4QutawlJC7AFUBxlC5KCzatldGdWtjiGRHQtVmewV6B/Hox6JdFLoGphJRwXmm6KeYKsLAhRBxotYFOvIrKkYP6h/eedsp7yiOdp4znlokzsfNd5EuuZvE4hVirIbXlRy0TmoFUws/IK6Ms5nPDt06N1hdWooChytTDa4+7mZ1sbk3268hTfs/GHsenhUhSXd4rzxJHysn9iiGRo8bYOab1CRwWfMszkdnVePsHGZUaMV2pxLeDhVgkPuFg0ZL+BBqVSVjZvpGcjdMVyzmwpeDMpUmZly0c5b8zA+D6U1KQNTxjLcfsGAmp4mixEyYngePIsZset7mKWt6dbD/vjkVLC6TGy9IVUYQF/oK4mnoisM8Af4QVsGx1gRP5lu4iZaiOevygdodMJJGpo5waw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(4636009)(39850400004)(376002)(136003)(346002)(396003)(366004)(30864003)(2906002)(16526019)(5660300002)(44832011)(54906003)(26005)(186003)(86362001)(52116002)(31686004)(83380400001)(53546011)(2616005)(956004)(6486002)(8936002)(66946007)(4326008)(66556008)(316002)(66476007)(31696002)(36756003)(8676002)(6916009)(16576012)(478600001)(7416002)(43740500002)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7mI41WDFEdF/Mnd3Wba+FfEuWin+h+YYLGzWzlQSAQv5G43TsX8rUnOKcLtLxi0bltCBFZFEcTmEzO6Fs3VJshfwsqp+ZwBm9aK8N/ocyVuvHreEd4WTnP1pD8RiVIzoXMATgilhXvf7g7Dr5iteUGy1WjRE5NSBWJLKHlFCOMocv8yrsaDDOKWNrJYWw/AzrSUZ35gYRy+idBH4nNWXazOAsFm/5mmPBvO90xpOo9VM07ixGc6NELvTZR51hKvM+FI2wjUCmV8IY8fI97tO3Hv7EYL83h8Hw9e71teshQf5MMR+UEZk7EmoE6CJJ/bXRrYB2SrFfCxn41GKCpl/b3rC8G/rV4NXUYLVqGfkWEfISwTZCsLJFxAXErZYNtyjFCv/gjj+dv0pHFJ9HBIFQn3qHiB2MVtN0HxjUfyzh30CH8c2/dAgMCu7JtjgDg70UpNcylRTlKrZv30qeF3dGZKP+CG2HvNjwLzXXntE7wwKfoewhZhsH/JxhmFTXODBUxrl0cCuNmAP+H+rjM19lBO2hYo8wv4a0nMiQhWOjGuaTiMXOiTJM+twp9W8aLo7nBsLZTWMUHqm8tDilHfnG3TGUFVlEuCaUdOIeGr13nn0lTIWHGeT2mnbPUYNDe1ivH9hEHRM9jVCvOKbSoBIVQ==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 178f131d-18c8-47f1-d1c9-08d8660e38bf
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 13:30:54.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OBUYMkopa0oL2xJzodN036UV+fm65YSzBcGxkAf+lmrX2m3ef+HZfDy2rgZGXoCb9Y7L1ZXyrae3ZE+FOfam0+JbsEeg3pxb6TTDODSSBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.20 14:57, Krzysztof Kozlowski wrote:
> On Thu, Oct 01, 2020 at 02:06:58PM +0200, Schrempf Frieder wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> Kontron Electronics GmbH offers small and powerful SoMs based on the
>> i.MX8M Mini SoC including PMIC, LPDDR4-RAM, eMMC and SPI NOR.
>>
>> The matching baseboards have the same form factor and similar interfaces
>> as the other boards from the Kontron "Board-Line" family, including
>> SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
>> RS485, CAN, LVDS or HDMI, RTC and much more.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>> Changes for v3:
>> * Remove needless status properties
>> * Remove needless regulator properties for reg_vdd_5v
>> * Use proper PHY reset properties in PHY node
>> * Use phy-connection-type instead of phy-mode
>> * Adjust PMIC node name and label
>> * Add over-current-active-low to usbotg1 node
>> * Remove redundant bus-width property from usdhc2 node
>> * Remove needless regulator-compatible from reg_vdd_snvs
>> * Set minimum voltage to 85mV for reg_vdd_snvs
>>
>> Changes for v2:
>> * Make the licensing less strict (GPL-2.0+ OR MIT)
>> * Merge the SoM and baseboard DTs for N8010 and N8011 into one as
>>    they only differ in DDR and eMMC size.
>> * Change compatibles and model strings to "n810x" and "N8010X".
>> * Only use a common memory node that will be updated by the
>>    bootloader reflecting the detected DDR size.
>> * Improve naming for 16MHz CAN fixed oscillator and set
>>    "clock-output-names".
>> * Consistently use "reg_" prefix for regulators.
>> * Remove "userspi" node.
>> * Slightly improve commit message.
>> ---
>>   .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 323 ++++++++++++++++++
>>   .../freescale/imx8mm-kontron-n801x-som.dtsi   | 293 ++++++++++++++++
>>   2 files changed, 616 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>> new file mode 100644
>> index 000000000000..389e735b2880
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>> @@ -0,0 +1,323 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>> +/*
>> + * Copyright (C) 2019 Kontron Electronics GmbH
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "imx8mm-kontron-n801x-som.dtsi"
>> +
>> +/ {
>> +	model = "Kontron i.MX8MM N801X S";
>> +	compatible = "kontron,imx8mm-n801x-s", "kontron,imx8mm-n801x-som", "fsl,imx8mm";
>> +
>> +	aliases {
>> +		ethernet1 = &usbnet;
>> +	};
>> +
>> +	/* fixed crystal dedicated to mcp2515 */
>> +	osc_can: clock-osc-can {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <16000000>;
>> +		clock-output-names = "osc-can";
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_gpio_led>;
>> +
>> +		led1 {
>> +			label = "led1";
>> +			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +
>> +		led2 {
>> +			label = "led2";
>> +			gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led3 {
>> +			label = "led3";
>> +			gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led4 {
>> +			label = "led4";
>> +			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led5 {
>> +			label = "led5";
>> +			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led6 {
>> +			label = "led6";
>> +			gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +
>> +	pwm-beeper {
>> +		compatible = "pwm-beeper";
>> +		pwms = <&pwm2 0 5000 0>;
>> +	};
>> +
>> +	reg_rst_eth2: regulator-rst-eth2 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "rst-usb-eth2";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_usb_eth2>;
>> +		gpio = <&gpio3 2 GPIO_ACTIVE_LOW>;
>> +	};
>> +
>> +	reg_vdd_5v: regulator-5v {
> 
> Why do you need it if it cannot be controlled? The CAN driver should use
> dummy regulator in absence of real one.

Yes, it's not really useful. I added it for the sake of completeness and 
to describe the hardware as best as possible. It feels better than using 
a dummy but of course it doesn't really make a difference.

> 
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vdd-5v";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +	};
>> +};
>> +
>> +&ecspi2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi2>;
>> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +
>> +	can0: can@0 {
>> +		compatible = "microchip,mcp2515";
>> +		reg = <0>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_can>;
>> +		clocks = <&osc_can>;
>> +		interrupt-parent = <&gpio4>;
>> +		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
>> +		spi-max-frequency = <100000>;
>> +		vdd-supply = <&reg_vdd_3v3>;
>> +		xceiver-supply = <&reg_vdd_5v>;
>> +		status = "okay";
> 
> Status should not be needed as it is a default for new nodes.

Right, I forgot to drop this one.

> 
>> +	};
>> +};
>> +
>> +&ecspi3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi3>;
>> +	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +};
>> +
>> +&fec1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_enet>;
>> +	phy-connection-type = "rgmii";
>> +	phy-handle = <&ethphy>;
>> +	status = "okay";
>> +
>> +	mdio {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ethphy: ethernet-phy@0 {
>> +			reg = <0>;
>> +			reset-assert-us = <100>;
>> +			reset-deassert-us = <100>;
>> +			reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +};
>> +
>> +&i2c4 {
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c4>;
>> +	status = "okay";
>> +
>> +	rtc@32 {
>> +		compatible = "epson,rx8900";
>> +		reg = <0x32>;
>> +	};
>> +};
>> +
>> +&pwm2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_pwm2>;
>> +	status = "okay";
>> +};
>> +
>> +&uart1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart1>;
>> +	uart-has-rtscts;
>> +	status = "okay";
>> +};
>> +
>> +&uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart2>;
>> +	linux,rs485-enabled-at-boot-time;
>> +	uart-has-rtscts;
>> +	status = "okay";
>> +};
>> +
>> +&usbotg1 {
>> +	dr_mode = "otg";
>> +	over-current-active-low;
>> +	status = "okay";
>> +};
>> +
>> +&usbotg2 {
>> +	dr_mode = "host";
>> +	disable-over-current;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	status = "okay";
>> +
>> +	usb1@1 {
>> +		compatible = "usb424,9514";
>> +		reg = <1>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		usbnet: usbether@1 {
>> +			compatible = "usb424,ec00";
>> +			reg = <1>;
>> +			mac-address = [ 00 00 00 00 00 00 ];
> 
> I think you want here local-mac-address (to be filled by U-Boot).
> mac-address has slightly different meaning in dtschema.

Yes, I think you're right.

> 
>> +		};
>> +	};
>> +};
>> +
>> +&usdhc2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc2>;
>> +	vmmc-supply = <&reg_vdd_3v3>;
>> +	vqmmc-supply = <&reg_nvcc_sd>;
>> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +};
>> +
>> +&iomuxc {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_gpio>;
>> +
>> +	pinctrl_can: cangrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_ecspi2: ecspi2grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
>> +			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
>> +			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
>> +			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_ecspi3: ecspi3grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x82
>> +			MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x82
>> +			MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x82
>> +			MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_enet: enetgrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
>> +			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
>> +			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
>> +			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
>> +			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
>> +			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
>> +			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
>> +			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
>> +			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
>> +			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
>> +			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
>> +			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
>> +			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
>> +			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
>> +			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19 /* PHY RST */
>> +			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25		0x19 /* ETH IRQ */
>> +		>;
>> +	};
>> +
>> +	pinctrl_gpio_led: gpioledgrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x19
>> +			MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7		0x19
>> +			MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8		0x19
>> +			MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x19
>> +			MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17		0x19
>> +			MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18		0x19
>> +			MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_gpio: gpiogrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19
>> +			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
>> +			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
>> +			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x19
>> +			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19
>> +			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x19
>> +			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x19
>> +			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c4: i2c4grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
>> +			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
>> +		>;
>> +	};
>> +
>> +	pinctrl_pwm2: pwm2grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart1: uart1grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
>> +			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
>> +			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
>> +			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart2: uart2grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x140
>> +			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x140
>> +			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x140
>> +			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x140
>> +		>;
>> +	};
>> +
>> +	pinctrl_usb_eth2: usbeth2grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2: usdhc2grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
>> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
>> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
>> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
>> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
>> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
>> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>> +		>;
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> new file mode 100644
>> index 000000000000..5c6a660f4395
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> @@ -0,0 +1,293 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>> +/*
>> + * Copyright (C) 2019 Kontron Electronics GmbH
>> + */
>> +
>> +#include "imx8mm.dtsi"
>> +
>> +/ {
>> +	model = "Kontron i.MX8MM N801X SoM";
>> +	compatible = "kontron,imx8mm-n801x-som", "fsl,imx8mm";
>> +
>> +	memory@40000000 {
>> +		device_type = "memory";
>> +		/*
>> +		 * There are multiple SoM flavors with different DDR sizes.
>> +		 * The smallest is 1GB. For larger sizes the bootloader will
>> +		 * update the reg property.
>> +		 */
>> +		reg = <0x0 0x40000000 0 0x80000000>;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = &uart3;
>> +	};
>> +};
>> +
>> +&A53_0 {
>> +	cpu-supply = <&reg_vdd_arm>;
>> +};
>> +
>> +&A53_1 {
>> +	cpu-supply = <&reg_vdd_arm>;
>> +};
>> +
>> +&A53_2 {
>> +	cpu-supply = <&reg_vdd_arm>;
>> +};
>> +
>> +&A53_3 {
>> +	cpu-supply = <&reg_vdd_arm>;
>> +};
>> +
>> +&ddrc {
>> +	operating-points-v2 = <&ddrc_opp_table>;
>> +
>> +	ddrc_opp_table: opp-table {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp-25M {
>> +			opp-hz = /bits/ 64 <25000000>;
>> +		};
>> +
>> +		opp-100M {
>> +			opp-hz = /bits/ 64 <100000000>;
>> +		};
>> +
>> +		opp-750M {
>> +			opp-hz = /bits/ 64 <750000000>;
>> +		};
>> +	};
>> +};
>> +
>> +&ecspi1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi1>;
>> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
>> +	status = "okay";
>> +
>> +	spi-flash@0 {
>> +		compatible = "mxicy,mx25r1635f", "jedec,spi-nor";
>> +		spi-max-frequency = <80000000>;
>> +		reg = <0>;
>> +	};
>> +};
>> +
>> +&i2c1 {
>> +	clock-frequency = <400000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c1>;
>> +	status = "okay";
>> +
>> +	pca9450: pmic@25 {
>> +		compatible = "nxp,pca9450a";
>> +		reg = <0x25>;
>> +		pinctrl-0 = <&pinctrl_pmic>;
> 
> I guess this was copied from the same sources as other DTS. :) You need
> pinctrl-names, otherwise it won't work.

Of course!

> 
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <0 GPIO_ACTIVE_LOW>;
> 
> Same as in other boards, wrong flag. I guess this is IRQ_TYPE_LEVEL_LOW.
> 
> I was fixing this recently in all boards (most already in next).

I remember seeing your fixes, but then I forgot about them. Thanks for 
reminding me.

> 
>> +
>> +		regulators {
>> +			reg_vdd_soc: BUCK1 {
>> +				regulator-name = "BUCK1";
> 
> All regulator names should be lowercase, as dtschema asks. Node names
> can stay uppercase, although I guess it would be better to have them
> lower as it is also naming convention for device tree.

Ok, I will change the regulator and node names to lowercase.

> 
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +				regulator-ramp-delay = <3125>;
>> +			};
>> +
>> +			reg_vdd_arm: BUCK2 {
>> +				regulator-name = "BUCK2";
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-boot-on;
>> +				regulator-ramp-delay = <3125>;
>> +				nxp,dvs-run-voltage = <950000>;
>> +				nxp,dvs-standby-voltage = <850000>;
>> +			};
>> +
>> +			reg_vdd_dram: BUCK3 {
>> +				regulator-name = "BUCK3";
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_vdd_3v3: BUCK4 {
>> +				regulator-name = "BUCK4";
>> +				regulator-min-microvolt = <3300000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_vdd_1v8: BUCK5 {
>> +				regulator-name = "BUCK5";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_nvcc_dram: BUCK6 {
>> +				regulator-name = "BUCK6";
>> +				regulator-min-microvolt = <1100000>;
>> +				regulator-max-microvolt = <1100000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_nvcc_snvs: LDO1 {
>> +				regulator-name = "LDO1";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_vdd_snvs: LDO2 {
>> +				regulator-name = "LDO2";
>> +				regulator-min-microvolt = <850000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_vdda: LDO3 {
>> +				regulator-name = "LDO3";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_vdd_phy: LDO4 {
>> +				regulator-name = "LDO4";
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			reg_nvcc_sd: LDO5 {
>> +				regulator-name = "LDO5";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&uart3 { /* console */
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart3>;
>> +	status = "okay";
>> +};
>> +
>> +&usdhc1 {
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +	pinctrl-0 = <&pinctrl_usdhc1>;
>> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
>> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
>> +	vmmc-supply = <&reg_vdd_3v3>;
>> +	vqmmc-supply = <&reg_vdd_1v8>;
>> +	bus-width = <8>;
>> +	non-removable;
>> +	status = "okay";
>> +};
>> +
>> +&wdog1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_wdog>;
>> +	fsl,ext-reset-output;
>> +	status = "okay";
>> +};
>> +
>> +&iomuxc {
>> +	pinctrl_ecspi1: ecspi1grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x82
>> +			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI		0x82
>> +			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK		0x82
>> +			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
>> +		>;
>> +	};
>> +
>> +	pinctrl_i2c1: i2c1grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c3
>> +			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
>> +		>;
>> +	};
>> +
>> +	pinctrl_pmic: pmicgrp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x41
> 
> Missing pull up.

Right.

> 
>> +		>;
>> +	};
>> +
>> +	pinctrl_uart3: uart3grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX		0x140
>> +			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX		0x140
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1: usdhc1grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x190
>> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d0
>> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
>> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x190
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> 
> Put "grp" at the end of node name, so for example"usdhc1-100mhzgrp".
> Here and below. Naming enforced by dtschema.

Ok, thanks for reviewing!

> 
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK			0x194
>> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD			0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7		0x1d4
>> +			MX8MM_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0x019
>> +			MX8MM_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x194
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> 
> Best regards,
> Krzysztof
> 
