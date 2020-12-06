Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2647A2D061F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgLFQyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:54:49 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:38276 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgLFQx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:53:58 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 374D3C013D;
        Sun,  6 Dec 2020 17:53:17 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 9AD35C1D42; Sun,  6 Dec 2020 17:53:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id F405BC1D4A;
        Sun,  6 Dec 2020 17:51:33 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v3 5/5] ARM: dts: sun8i-v3: Add support for the SL631 Action Camera with IMX179
Date:   Sun,  6 Dec 2020 17:51:31 +0100
Message-Id: <20201206165131.1041983-6-contact@paulk.fr>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206165131.1041983-1-contact@paulk.fr>
References: <20201206165131.1041983-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SL631 is a family of Allwinner V3 action cameras sold under
various names, such as SJCAM SJ4000 Air or F60 Action Camera.

Devices in this family share a common board design but can be found
with different image sensors, including the IMX179 and the OV4689.

This adds support for a common dtsi for the SL631 family as well as
a specific dts for the IMX179 fashion, which will later be populated
with an IMX179 node when a driver is available.

Features that were tested on the device include:
- UART debug
- MMC
- USB peripheral (e.g. g_ether)
- Buttons
- SPI NOR flash

Note that the exact designer/vendor of these boards is unknown.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts |  12 ++
 arch/arm/boot/dts/sun8i-v3-sl631.dtsi       | 138 ++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts
 create mode 100644 arch/arm/boot/dts/sun8i-v3-sl631.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ad41489e591d..44cbfb2fa79c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1213,6 +1213,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-s3-lichee-zero-plus.dtb \
 	sun8i-s3-pinecube.dtb \
 	sun8i-t3-cqa3t-bv3.dtb \
+	sun8i-v3-sl631-imx179.dtb \
 	sun8i-v3s-licheepi-zero.dtb \
 	sun8i-v3s-licheepi-zero-dock.dtb \
 	sun8i-v40-bananapi-m2-berry.dtb
diff --git a/arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts b/arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts
new file mode 100644
index 000000000000..117aeece4e55
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-v3-sl631-imx179.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright 2020 Paul Kocialkowski <contact@paulk.fr>
+ */
+
+#include "sun8i-v3-sl631.dtsi"
+
+/ {
+	model = "SL631 Action Camera with IMX179";
+	compatible = "allwinner,sl631-imx179", "allwinner,sl631",
+		     "allwinner,sun8i-v3";
+};
diff --git a/arch/arm/boot/dts/sun8i-v3-sl631.dtsi b/arch/arm/boot/dts/sun8i-v3-sl631.dtsi
new file mode 100644
index 000000000000..e0d2a31efc7f
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-v3-sl631.dtsi
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright 2020 Paul Kocialkowski <contact@paulk.fr>
+ */
+
+/dts-v1/;
+
+#include "sun8i-v3.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "SL631 Action Camera";
+	compatible = "allwinner,sl631", "allwinner,sun8i-v3";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp209: pmic@34 {
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pb_pins>;
+	status = "okay";
+};
+
+&lradc {
+	vref-supply = <&reg_ldo2>;
+	status = "okay";
+
+	button-174 {
+		label = "Down";
+		linux,code = <KEY_DOWN>;
+		channel = <0>;
+		voltage = <174603>;
+	};
+
+	button-384 {
+		label = "Up";
+		linux,code = <KEY_UP>;
+		channel = <0>;
+		voltage = <384126>;
+	};
+
+	button-593 {
+		label = "OK";
+		linux,code = <KEY_OK>;
+		channel = <0>;
+		voltage = <593650>;
+	};
+};
+
+&mmc0 {
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	bus-width = <4>;
+	vmmc-supply = <&reg_dcdc3>;
+	status = "okay";
+};
+
+&pio {
+	vcc-pd-supply = <&reg_dcdc3>;
+	vcc-pe-supply = <&reg_dcdc3>;
+};
+
+#include "axp209.dtsi"
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1250000>;
+	regulator-max-microvolt = <1250000>;
+	regulator-name = "vdd-sys-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vdd-3v3";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&spi0 {
+	status = "okay";
+
+	spi-flash@0 {
+		reg = <0>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pg_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.29.2

