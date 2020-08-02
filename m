Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5991235A82
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 22:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHBU2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 16:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgHBU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 16:28:10 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF02C06174A;
        Sun,  2 Aug 2020 13:28:10 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c2so19957275edx.8;
        Sun, 02 Aug 2020 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3J37uxaE+JC2NHgQ9X6Djh4nwsDEJFu6G317WySC1bg=;
        b=n/IHoxrjJZ4ZhisSgFBb+cdqsIWOU93JzjASNqIBYlJcdJoyQjMZeLAFyk68m0sRFa
         0ko5rcM41/kx665Np0hPtss5VMYQcKZcMIjFJ/6WF6x0752s7rgpn97X8iYRpTXQwF12
         BUpPp9C488EyaoKda6Qokl7bG2ecXNk80LTmmlbb9pevyFzTdlYSCSiJh5utObNJVPSc
         gOpJPDRzGJDTdsflxZhMkHo9Jh9kuSpaGcpKLdaywIjFO6H3kbwBUSy2T7ndl2SDrS9k
         t36inOWdMd/Ja15gUWfvHsSt5Wf1Xo+GWhMemXUE+c9qw6f9YOI9u0yXVYru/9tM0mbw
         1U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3J37uxaE+JC2NHgQ9X6Djh4nwsDEJFu6G317WySC1bg=;
        b=j9H6x34cJS+5/9mxyqXBAKJPsEiheY/A3Rxcf7nmIa6CtAadLE/szAh3qf/VqY0kOR
         jHHOWrSxuK1B85IG0IB1S4BqXatkJLN+Cb+lAA6TG6Sw7XCaKk/8/CjaW1jNQZE/Inxc
         rGc9tiHiqRWsD7eeSPE3dVyXBb2mn/r9AfnYvk/Pi8eNtHQV7HEa7AiNz/US1PBFJNUh
         zjCqylRA3t9uQCLe2jaAKbyimfFOnciXCqJQULwi72+LX+xZXgFku1lfX7u9xhQsn2Cd
         5GD+Q0ITE0Ji1dHGvBPxSH+3GcM6evN8hyuMqcMyeO86TMKVHn2PsQn+epZipb2+1LRl
         izbQ==
X-Gm-Message-State: AOAM533K5rrRjtY8hGl96wer6PMvoC3c2/4eqxwi9dj+B6Mh1g35aDiH
        3JbLIW/ekSPUe8aNgKjInUHDSutbsjk1kA==
X-Google-Smtp-Source: ABdhPJykd60igEvNngpngTLYpb3bfNgCI6epetnrMQauXCt5NpCR2Lt53L0v8jfBzcACFQgwy+H/yQ==
X-Received: by 2002:a05:6402:3128:: with SMTP id dd8mr2988200edb.97.1596400089110;
        Sun, 02 Aug 2020 13:28:09 -0700 (PDT)
Received: from localhost.localdomain ([31.177.242.137])
        by smtp.gmail.com with ESMTPSA id u17sm14090239ejx.10.2020.08.02.13.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 13:28:08 -0700 (PDT)
From:   stulluk@gmail.com
To:     mripard@kernel.org
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sertac TULLUK <stulluk@gmail.com>
Subject: arm: dts: allwinner: a20: Add Drejo DS167 initial support
Date:   Sun,  2 Aug 2020 23:27:45 +0300
Message-Id: <20200802202745.5082-1-stulluk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sertac TULLUK <stulluk@gmail.com>

Drejo DS167 is an Allwinner A20 based IoT device, which support 

- Allwinner A20 Cortex-A7
- Mali-400MP2 GPU
- AXP209 PMIC
- 1GB DDR3 RAM
- 8GB eMMC
- 10/100M Ethernet
- SATA
- HDMI
- 10.1inch and 7.0inch LVDS LCD and Touch screens
- CSI: OV5640 sensor
- USB OTG
- 2x USB2.0
- builtin KNX Transceiver
- 3x Dry Contact Input
- 3x Relay output
- IR
- UART3
- SPI1
- RTC Battery
- 8x GPIO
- Analogue + Digital Microphone
- PAM8620 speaker Amplifier
- 12V DC power supply
- 3.7V Battery Operable

Signed-off-by: Sertac TULLUK <stulluk@gmail.com>
---
 arch/arm/boot/dts/Makefile                    |   2 +
 .../boot/dts/sun7i-a20-drejo-ds167-emmc.dts   |  69 ++++
 arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts   | 361 ++++++++++++++++++
 3 files changed, 432 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3823090d0..574305522 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1115,6 +1115,8 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-olinuxino-lime2-emmc.dtb \
 	sun7i-a20-olinuxino-micro.dtb \
 	sun7i-a20-olinuxino-micro-emmc.dtb \
+	sun7i-a20-drejo-ds167.dtb \
+	sun7i-a20-drejo-ds167-emmc.dtb \
 	sun7i-a20-orangepi.dtb \
 	sun7i-a20-orangepi-mini.dtb \
 	sun7i-a20-pcduino3.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts b/arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts
new file mode 100644
index 000000000..b6147eb01
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-drejo-ds167-emmc.dts
@@ -0,0 +1,69 @@
+/*
+ * Copyright 2020 Sertac TULLUK
+ *
+ * Sertac TULLUK <stulluk@gmail.com>
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
+#include "sun7i-a20-drejo-ds167.dts"
+
+/ {
+	model = "drejo DS167-eMMC";
+	compatible = "drejo,sun7i-a20-drejo-ds167-emmc", "allwinner,sun7i-a20";
+
+	mmc2_pwrseq: pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&pio 2 24 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	non-removable;
+	mmc-pwrseq = <&mmc2_pwrseq>;
+	status = "okay";
+
+	emmc: emmc@0 {
+		reg = <0>;
+		compatible = "mmc-card";
+		broken-hpi;
+	};
+};
diff --git a/arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts b/arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts
new file mode 100644
index 000000000..1103a6082
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-drejo-ds167.dts
@@ -0,0 +1,361 @@
+/*
+ * Copyright 2020 Sertac TULLUK
+ *
+ * Sertac TULLUK <stulluk@gmail.com>
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
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "drejo DS167";
+	compatible = "drejo,sun7i-a20-drejo-ds167", "allwinner,sun7i-a20";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart3;
+
+		spi0 = &spi1;
+		spi1 = &spi2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+        backlight: backlight {
+                compatible = "pwm-backlight";
+
+                brightness-levels = <0 1 2 4 8 16 32 64 128 255>;
+                default-brightness-level = <9>;
+        };
+
+        panel {
+                compatible = "drejo,ds167-10inch-panel", "panel-lvds";
+                backlight = <&backlight>;
+
+                width-mm = <220>;
+                height-mm = <132>;
+                data-mapping = "vesa-24";
+
+                panel-timing {
+                        /* 1280x800 @60Hz */
+                        clock-frequency = <69000000>;
+                        hactive = <1280>;
+                        vactive = <800>;
+                        hsync-len = <1>; /* hs */
+                        hfront-porch = <118>; /* ri */
+                        hback-porch = <19>; /* le */
+                        vfront-porch = <6>; /* lo */
+                        vback-porch = <9>; /* up */
+                        vsync-len = <1>; /* vs */
+                };
+
+                port {
+                        panel_input: endpoint {
+                                remote-endpoint = <&tcon0_out_lcd>;
+                        };
+                };
+        };
+	
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_ds167>;
+
+		red {
+			label = "ds167-status";
+			gpios = <&pio 8 9 GPIO_ACTIVE_LOW>;  /* PI9 STATUS LED NEAR A20 */
+			default-state = "on";
+		};
+	};
+};
+
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&de {
+	status = "okay";
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
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_mii_pins>, <&gmac_txerr>;
+	phy-handle = <&phy1>;
+	phy-mode = "mii";
+	status = "okay";
+};
+
+&mali {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
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
+	status = "okay";
+};
+
+
+&i2c2 {
+	status = "okay";
+
+   	clock-frequency = <400000>;
+        polytouch: edt-ft5x06@38 {
+              compatible = "edt,edt-ft5406", "edt,edt-ft5x06";
+              reg = <0x38>;
+	      interrupt-parent = <&pio>;
+	      interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /* PH21 */
+	      wake-gpios = <&pio 1 13 GPIO_ACTIVE_HIGH>; /* PB13 */
+              touchscreen-size-x = <1200>;
+              touchscreen-size-y = <800>;
+       };
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+
+&lradc {
+	vref-supply = <&reg_vcc3v0>;
+	status = "okay";
+};
+
+&gmac_mdio {
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
+	status = "okay";
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
+&otg_sram {
+	status = "okay";
+};
+
+&pio {
+	gmac_txerr: gmac-txerr-pin {
+		pins = "PA17";
+		function = "gmac";
+	};
+
+	led_pins_ds167: led-pins {  
+		pins = "PI9";   /* Status led, on schematic, this is LED_EN */
+		function = "gpio_out";
+		drive-strength = <20>;
+	};
+};
+
+&pwm {
+      pinctrl-names = "default";
+      pinctrl-0 = <&pwm0_pin>, <&pwm1_pin>;
+      status = "okay";
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
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_ahci_5v {
+	status = "okay";
+};
+
+&reg_usb0_vbus {
+	status = "okay";
+};
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pi_pins>,
+		    <&spi1_cs0_pi_pin>;
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pc_pins>,
+		    <&spi2_cs0_pc_pin>;
+	status = "okay";
+};
+
+&tcon0 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&lcd_lvds0_pins>;
+};
+
+&tcon0_out {
+        tcon0_out_lcd: endpoint {
+                remote-endpoint = <&panel_input>;
+        };
+};
+
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pg_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
+	usb0_vbus_det-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PH5 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
-- 
2.17.1

