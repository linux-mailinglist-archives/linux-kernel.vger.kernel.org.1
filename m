Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E35287BCD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgJHSkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:40:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:51368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgJHSkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:40:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9DF3EAC83;
        Thu,  8 Oct 2020 18:40:09 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Bastian Germann <bage@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: sun8i: h2+: Fix Orange Pi Zero device description.
Date:   Thu,  8 Oct 2020 20:40:05 +0200
Message-Id: <59f7b5c566825838bbb62b778e05c514fe355e74.1602182270.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two models of Orange Pi zero which are confusingly marketed
under the same name. Old model comes without a flash memory and current
model does have a flash memory. Build device tree for each model.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../sun8i-h2-plus-orangepi-zero-no-flash.dts  | 210 ++++++++++++++++++
 .../boot/dts/sun8i-h2-plus-orangepi-zero.dts  | 201 +----------------
 3 files changed, 215 insertions(+), 197 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero-no-flash.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4572db3fa5ae..f2853cea0c9c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1168,6 +1168,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h2-plus-libretech-all-h3-cc.dtb \
 	sun8i-h2-plus-orangepi-r1.dtb \
 	sun8i-h2-plus-orangepi-zero.dtb \
+	sun8i-h2-plus-orangepi-zero-no-flash.dtb \
 	sun8i-h3-bananapi-m2-plus.dtb \
 	sun8i-h3-bananapi-m2-plus-v1.2.dtb \
 	sun8i-h3-beelink-x2.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero-no-flash.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero-no-flash.dts
new file mode 100644
index 000000000000..3859b663e3f0
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero-no-flash.dts
@@ -0,0 +1,210 @@
+/*
+ * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * Based on sun8i-h3-orangepi-one.dts, which is:
+ *   Copyright (C) 2016 Hans de Goede <hdegoede@redhat.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "sun8i-h3.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Xunlong Orange Pi Zero (old model without flash memory)";
+	compatible = "xunlong,orangepi-zero-no-flash",
+		   "xunlong,orangepi-zero", "allwinner,sun8i-h2-plus";
+
+	aliases {
+		serial0 = &uart0;
+		/* ethernet0 is the H3 emac, defined in sun8i-h3.dtsi */
+		ethernet0 = &emac;
+		ethernet1 = &xr819;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pwr_led {
+			label = "orangepi:green:pwr";
+			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		status_led {
+			label = "orangepi:red:status";
+			gpios = <&pio 0 17 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	reg_vcc_wifi: reg_vcc_wifi {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc-wifi";
+		enable-active-high;
+		gpio = <&pio 0 20 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_vdd_cpux: vdd-cpux-regulator {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd-cpux";
+		regulator-type = "voltage";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-ramp-delay = <50>; /* 4ms */
+
+		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		enable-active-high;
+		gpios-states = <1>;
+		states = <1100000 0>, <1300000 1>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>;
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	status = "okay";
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_vcc_wifi>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	/*
+	 * Explicitly define the sdio device, so that we can add an ethernet
+	 * alias for it (which e.g. makes u-boot set a mac-address).
+	 */
+	xr819: sdio_wifi@1 {
+		reg = <1>;
+	};
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&spi0 {
+	/* On the old model of Orange Pi Zero the flash memory is not mounted */
+	status = "disabled";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mxicy,mx25l1606e", "winbond,w25q128";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pa_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "disabled";
+};
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	/*
+	 * USB Type-A port VBUS is always on. However, MicroUSB VBUS can only
+	 * power up the board; when it's used as OTG port, this VBUS is
+	 * always off even if the board is powered via GPIO pins.
+	 */
+	status = "okay";
+	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+};
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index f19ed981da9d..e718ed143ad7 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -1,209 +1,16 @@
-/*
- * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
- *
- * Based on sun8i-h3-orangepi-one.dts, which is:
- *   Copyright (C) 2016 Hans de Goede <hdegoede@redhat.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
+// SPDX-License-Identifier: GPL-2.0
 /dts-v1/;
-#include "sun8i-h3.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
+#include "sun8i-h2-plus-orangepi-zero-no-flash.dts"
 
 / {
 	model = "Xunlong Orange Pi Zero";
-	compatible = "xunlong,orangepi-zero", "allwinner,sun8i-h2-plus";
-
-	aliases {
-		serial0 = &uart0;
-		/* ethernet0 is the H3 emac, defined in sun8i-h3.dtsi */
-		ethernet0 = &emac;
-		ethernet1 = &xr819;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		pwr_led {
-			label = "orangepi:green:pwr";
-			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-
-		status_led {
-			label = "orangepi:red:status";
-			gpios = <&pio 0 17 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	reg_vcc_wifi: reg_vcc_wifi {
-		compatible = "regulator-fixed";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-name = "vcc-wifi";
-		enable-active-high;
-		gpio = <&pio 0 20 GPIO_ACTIVE_HIGH>;
-	};
-
-	reg_vdd_cpux: vdd-cpux-regulator {
-		compatible = "regulator-gpio";
-		regulator-name = "vdd-cpux";
-		regulator-type = "voltage";
-		regulator-boot-on;
-		regulator-always-on;
-		regulator-min-microvolt = <1100000>;
-		regulator-max-microvolt = <1300000>;
-		regulator-ramp-delay = <50>; /* 4ms */
-
-		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
-		enable-active-high;
-		gpios-states = <1>;
-		states = <1100000 0>, <1300000 1>;
-	};
-
-	wifi_pwrseq: wifi_pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>;
-		post-power-on-delay-ms = <200>;
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&reg_vdd_cpux>;
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&emac {
-	phy-handle = <&int_mii_phy>;
-	phy-mode = "mii";
-	allwinner,leds-active-low;
-	status = "okay";
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-	status = "okay";
-};
-
-&mmc1 {
-	vmmc-supply = <&reg_vcc_wifi>;
-	mmc-pwrseq = <&wifi_pwrseq>;
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
-
-	/*
-	 * Explicitly define the sdio device, so that we can add an ethernet
-	 * alias for it (which e.g. makes u-boot set a mac-address).
-	 */
-	xr819: sdio_wifi@1 {
-		reg = <1>;
-	};
+	compatible = "xunlong,orangepi-zero-with-flash",
+		   "xunlong,orangepi-zero", "allwinner,sun8i-h2-plus";
 };
 
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
 
 &spi0 {
 	/* Disable SPI NOR by default: it optional on Orange Pi Zero boards */
-	status = "disabled";
-
-	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "mxicy,mx25l1606e", "winbond,w25q128";
-		reg = <0>;
-		spi-max-frequency = <40000000>;
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pa_pins>;
 	status = "okay";
 };
 
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins>;
-	status = "disabled";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins>;
-	status = "disabled";
-};
-
-&usb_otg {
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&usbphy {
-	/*
-	 * USB Type-A port VBUS is always on. However, MicroUSB VBUS can only
-	 * power up the board; when it's used as OTG port, this VBUS is
-	 * always off even if the board is powered via GPIO pins.
-	 */
-	status = "okay";
-	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
-};
-- 
2.28.0

