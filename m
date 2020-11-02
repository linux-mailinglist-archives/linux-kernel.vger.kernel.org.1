Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265B92A27A5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgKBKCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgKBKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:02:10 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8AFC0617A6;
        Mon,  2 Nov 2020 02:02:10 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o3so10333373pgr.11;
        Mon, 02 Nov 2020 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTo11Tb7wflHBO4uFPGRcAdcXJJ5F4UFv+OWMsGUGk0=;
        b=EiU+K/leDo3hmFM4UJLlFq/53qWJq2y7KyhgHO2RkwIMd4ndMZBgKzXuHvQTyAJZHQ
         bDs7aHQCLZx1hO4BRsElqz8VzS1HI7NgEsqD/1JJgI1EOIJcp3bJRjuhrTT6B6r9Acs/
         4+XLxvyR4Nss6F1uTZRW7PGjptBhJNc3ezJJYsBxw13GLSwGgqhvIkdsFHhXUIOcEWvj
         ZYHKQBRhNMVUb9tqwFIuXoZ2MHRWn/G63gPTbSSCzm2AnrmVSGK7Xdm0LnbXafbXjvqo
         gSu40FLgp1viXhWmn5NHwVhWq3VGJ9I+2rMQnRT1w8ibyUeWn9/ZPTq1Q1Kjf+/Ask1w
         GX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTo11Tb7wflHBO4uFPGRcAdcXJJ5F4UFv+OWMsGUGk0=;
        b=c8o35ZOI9FwtXRCnTC2nqO/Nsd5pzhHF6ea3E/LZqN00YWvzEdGZV4QTRrSznZO/M3
         V7Al01aZ0ck1JQGGUs+4zkTY0pbdo65GoyXXCloyXihBvugilOrZDNBA33WROEme4oDR
         Epixwy6kpfTxofSlBNEH1w9e+TWmWiFt2epsAS57WtgfJxaZdxY3WHDnY1Z27ofAr1uq
         3vz1vGTOi05myt6XTAChWi4lLqgqPsBeHdjIYKobLQwROWvMfp7YuuJipTgAi9aO8La2
         lk7MW2RP8e+JT6XVUT1Hb8MR4p0gDrsvXfr3yntPjrbcsy5KOhteV95BYWS6K46u/ezR
         zv/A==
X-Gm-Message-State: AOAM532L5Bc7lAC6BX9P/pmh/Ooa3BWGXOglSRpFcseAaa5YUBJXPKnB
        pN3tnie2OXBCowM++8Qq1KQ=
X-Google-Smtp-Source: ABdhPJzEZIyJfxC1l1tnCgk3pg5FIXm0OoYWoafQr4OACH1LczU8uEooq4c918YQAnR/i6/lOfpjCA==
X-Received: by 2002:aa7:931a:0:b029:164:115:33ca with SMTP id 26-20020aa7931a0000b0290164011533camr21361144pfj.62.1604311329721;
        Mon, 02 Nov 2020 02:02:09 -0800 (PST)
Received: from ruantu-3.localdomain ([103.230.142.242])
        by smtp.gmail.com with ESMTPSA id u7sm13283084pfn.37.2020.11.02.02.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 02:02:09 -0800 (PST)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH v1 1/1] ARM: dts: sun8i: h3: Add initial NanoPi R1 support
Date:   Mon,  2 Nov 2020 18:01:57 +0800
Message-Id: <20201102100157.85801-2-mtwget@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201102100157.85801-1-mtwget@gmail.com>
References: <20201102100157.85801-1-mtwget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NanoPi R1 is a complete open source board developed
by FriendlyElec for makers, hobbyists, fans and etc.

NanoPi R1 key features
- Allwinner H3, Quad-core Cortex-A7@1.2GHz
- 512MB/1GB DDR3 RAM
- 8GB eMMC
- microSD slot
- 10/100/1000M Ethernet x 1
- 10/100 Ethernet x 1
- Wifi 802.11b/g/n
- Bluetooth 4.0
- Serial Debug Port
- 5V 2A DC power-supply

Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
---
 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts      | 169 ++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 0f23133672a3..54a1aaee7e22 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -251,6 +251,11 @@ properties:
           - const: friendlyarm,nanopi-neo-plus2
           - const: allwinner,sun50i-h5
 
+      - description: FriendlyARM NanoPi R1
+        items:
+          - const: friendlyarm,nanopi-r1
+          - const: allwinner,sun8i-h3
+
       - description: FriendlyARM ZeroPi
         items:
           - const: friendlyarm,zeropi
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4f0adfead547..aabaf67f86ed 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1192,6 +1192,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-nanopi-m1-plus.dtb \
 	sun8i-h3-nanopi-neo.dtb \
 	sun8i-h3-nanopi-neo-air.dtb \
+	sun8i-h3-nanopi-r1.dtb \
 	sun8i-h3-orangepi-2.dtb \
 	sun8i-h3-orangepi-lite.dtb \
 	sun8i-h3-orangepi-one.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
new file mode 100644
index 000000000000..204a39f93f4e
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2019 Igor Pecovnik <igor@armbian.com>
+ * Copyright (C) 2020 Jayantajit Gogoi <jayanta.gogoi525@gmail.com>
+ * Copyright (C) 2020 Yu-Tung Chang <mtwget@gmail.com>
+*/
+
+#include "sun8i-h3-nanopi.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "FriendlyARM NanoPi R1";
+	compatible = "friendlyarm,nanopi-r1", "allwinner,sun8i-h3";
+
+	aliases {
+		serial1 = &uart1;
+		ethernet0 = &emac;
+		ethernet1 = &wifi;
+	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+	};
+
+	reg_vdd_cpux: gpio-regulator {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd-cpux";
+		regulator-type = "voltage";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-ramp-delay = <50>;
+		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		gpios-states = <0x1>;
+		states = <1100000 0x0
+			  1300000 0x1>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
+	};
+
+	leds {
+		led-2 {
+			function = LED_FUNCTION_WAN;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
+		};
+
+		led-3 {
+			function = LED_FUNCTION_LAN;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pio 0 9 GPIO_ACTIVE_HIGH>; /* PA9 */
+		};
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_gmac_3v3>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&external_mdio {
+	ext_rgmii_phy: ethernet-phy@7 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+	};
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	wifi: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&reg_usb0_vbus {
+	gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>, <&uart3_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rtc 1>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_vcc3v3>;
+		vddio-supply = <&reg_vcc3v3>;
+		device-wakeup-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
+		host-wakeup-gpios = <&pio 0 7 GPIO_ACTIVE_HIGH>; /* PA7 */
+		shutdown-gpios = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
+	};
+};
+
+&usb_otg {
+	status = "okay";
+	dr_mode = "otg";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	status = "okay";
+};
-- 
2.29.0

