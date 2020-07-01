Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE51210BB0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 15:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbgGANED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730656AbgGANEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:04:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89336C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 06:04:00 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jqcOk-0003Ch-4L; Wed, 01 Jul 2020 15:03:34 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jqcOj-0002Ob-Gb; Wed, 01 Jul 2020 15:03:33 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v9 5/5] ARM: dts: add Protonic RVT board
Date:   Wed,  1 Jul 2020 15:03:30 +0200
Message-Id: <20200701130330.9089-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701130330.9089-1-o.rempel@pengutronix.de>
References: <20200701130330.9089-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protonic RVT is an internal development platform for a wireless ISObus
Virtual Terminal based on COTS tablets, and the predecessor of the WD2
platform.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/imx6dl-prtrvt.dts | 184 ++++++++++++++++++++++++++++
 2 files changed, 185 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-prtrvt.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d72d1f3bf7c7..3d303bfc996e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -455,6 +455,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-pico-hobbit.dtb \
 	imx6dl-pico-nymph.dtb \
 	imx6dl-pico-pi.dtb \
+	imx6dl-prtrvt.dtb \
 	imx6dl-prtvt7.dtb \
 	imx6dl-rex-basic.dtb \
 	imx6dl-riotboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-prtrvt.dts b/arch/arm/boot/dts/imx6dl-prtrvt.dts
new file mode 100644
index 000000000000..fa882458957b
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-prtrvt.dts
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2014 Protonic Holland
+ */
+
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-prti6q.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Protonic RVT board";
+	compatible = "prt,prtrvt", "fsl,imx6dl";
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x10000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		led-debug0 {
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1 &pinctrl_can1phy>;
+	status = "okay";
+};
+
+&ecspi1 {
+	cs-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
+
+&ecspi3 {
+	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	status = "okay";
+
+	nfc@0 {
+		compatible = "ti,trf7970a";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_nfc>;
+		spi-max-frequency = <2000000>;
+		interrupts-extended = <&gpio5 14 IRQ_TYPE_LEVEL_LOW>;
+		ti,enable-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>,
+				  <&gpio5 11 GPIO_ACTIVE_LOW>;
+		vin-supply = <&reg_3v3>;
+		vin-voltage-override = <3100000>;
+		autosuspend-delay = <30000>;
+		irq-status-read-quirk;
+		en2-rf-quirk;
+		t5t-rmb-extra-byte-quirk;
+		status = "okay";
+	};
+};
+
+&i2c3 {
+	adc@49 {
+		compatible = "ti,ads1015";
+		reg = <0x49>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* nc */
+		channel@4 {
+			reg = <4>;
+			ti,gain = <3>;
+			ti,datarate = <3>;
+		};
+
+		/* nc */
+		channel@5 {
+			reg = <5>;
+			ti,gain = <3>;
+			ti,datarate = <3>;
+		};
+
+		/* can1_l */
+		channel@6 {
+			reg = <6>;
+			ti,gain = <3>;
+			ti,datarate = <3>;
+		};
+
+		/* can1_h */
+		channel@7 {
+			reg = <7>;
+			ti,gain = <3>;
+			ti,datarate = <3>;
+		};
+	};
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&pcie {
+	status = "okay";
+};
+
+&usbh1 {
+	status = "disabled";
+};
+
+&vpu {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_can1phy: can1phy {
+		fsl,pins = <
+			/* CAN1_SR */
+			MX6QDL_PAD_KEY_COL3__GPIO4_IO12	0x13070
+			/* CAN1_TERM */
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00	0x1b0b0
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x100b1
+			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI		0x100b1
+			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK		0x100b1
+			/* CS */
+			MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x000b1
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK	0x100b1
+			MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI	0x100b1
+			MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO	0x100b1
+			MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24	0x000b1
+		>;
+	};
+
+	pinctrl_leds: ledsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x1b0b0
+		>;
+	};
+
+	pinctrl_nfc: nfcgrp {
+		fsl,pins = <
+			/* NFC_ASK_OOK */
+			MX6QDL_PAD_DISP0_DAT15__GPIO5_IO09	0x100b1
+			/* NFC_PWR_EN */
+			MX6QDL_PAD_DISP0_DAT16__GPIO5_IO10	0x100b1
+			/* NFC_EN2 */
+			MX6QDL_PAD_DISP0_DAT17__GPIO5_IO11	0x100b1
+			/* NFC_EN */
+			MX6QDL_PAD_DISP0_DAT18__GPIO5_IO12	0x100b1
+			/* NFC_MOD */
+			MX6QDL_PAD_DISP0_DAT19__GPIO5_IO13	0x100b1
+			/* NFC_IRQ */
+			MX6QDL_PAD_DISP0_DAT20__GPIO5_IO14	0x100b1
+		>;
+	};
+};
-- 
2.27.0

