Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD74296BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461092AbgJWJFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460856AbgJWJFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:05:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EDAC0613CE;
        Fri, 23 Oct 2020 02:05:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l18so738609pgg.0;
        Fri, 23 Oct 2020 02:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQ/CVKCNragvB1O7ANGOionjdGWwalxvzO9nuCzggIA=;
        b=lZPzSKMpBaufNwfzgJ3zRO/Rfr0J01u0IxvQuMJV1PNUPQQTjP1dx8Xc3u9nAr1rUC
         HN6C3m87DNZfYZAeARKz5j8X31EZ06MjAjQ73RcspsClUi+CrUPSjFAa/K1/vgkWao8w
         mgChmaTMWB8Sf4y5Brqka5lVG1TI8U/b+abs/x+KhwN4pewFuF+9v/JbotrUVPt0aYcK
         E5oLNxlfQ7XfxewIXE5SklFawuGURi+6adgJF2WqVZltVVt6+eT0xRM3kgS789zDdQJZ
         /9FlKc6wHfe3MPr6QDHY9aI06bIvmJDl7WvZlxC1OMRl5t+6FjcOv64ZOnlBWDQwu6wd
         p8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQ/CVKCNragvB1O7ANGOionjdGWwalxvzO9nuCzggIA=;
        b=kNXbH0sv3U6kr1hEztpg8BGyXso8QRAkHZ6iZVJGZykjj63kipT3pcBkOhHpkrryvN
         3Dle3PFv1RxmKrgY6KaxZVvV/HjOPVtTQQATOUU5wSQQLxAWJF6GTQBe0waqdIRQA+R8
         q1DjWNsTeELL0QDEcqTg6S1rTRDF8xHhKOsNRsBZKRBQqaq2E5yNbBn+m0kfXwS+6hTz
         Zz5vRCpn/73UTiGa8a0TXoMDMUaA3J227iiBlGZrQAi1JP+hG8TfGsSU2P8POcmJkpmG
         6Mi8TrEElKQ80ozu0OyOOK1ulxhVtSOEj95wIGw7O1p8ai02Yi6kmVvGsgc6M9gSKlD1
         ul5g==
X-Gm-Message-State: AOAM532ueO7T8x6svZqbo22kcxgyhrQ0QolhOdJDvBFfSDVZLbYJX5qY
        PHW4YfN74gUhBNXRb6AsQ6OQ/eETscJ/qpZc
X-Google-Smtp-Source: ABdhPJyCo9y+h78hQs56Kwo+EEu42JwV5Q0/e+JHwjNWuHWTft9FmFBjJkn6S4tP7fGOa7Ubji1SYg==
X-Received: by 2002:a17:90a:8684:: with SMTP id p4mr1372581pjn.232.1603443900074;
        Fri, 23 Oct 2020 02:05:00 -0700 (PDT)
Received: from ruantu-3.localdomain ([103.230.142.242])
        by smtp.gmail.com with ESMTPSA id n5sm1057296pgm.82.2020.10.23.02.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:04:59 -0700 (PDT)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH] ARM: dts: sun8i: add FriendlyArm ZeroPi support
Date:   Fri, 23 Oct 2020 17:04:52 +0800
Message-Id: <20201023090452.10409-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  The ZeroPi is another fun board developed
  by FriendlyELEC for makers,
  hobbyists and fans.

  ZeroPi key features
  - Allwinner H3, Quad-core Cortex-A7@1.2GHz
  - 256MB/512MB DDR3 RAM
  - microsd slot
  - 10/100/1000Mbps Ethernet
  - Debug Serial Port
  - DC 5V/2A power-supply

Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
---
 .../devicetree/bindings/arm/sunxi.yaml        |  5 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/sun8i-h3-zeropi.dts         | 69 +++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-zeropi.dts

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index efc9118233b4..9392a9a3f7e7 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -246,6 +246,11 @@ properties:
           - const: friendlyarm,nanopi-neo-plus2
           - const: allwinner,sun50i-h5
 
+      - description: FriendlyARM ZeroPi
+        items:
+          - const: friendlyarm,zeropi
+          - const: allwinner,sun50i-h3
+
       - description: Gemei G9 Tablet
         items:
           - const: gemei,g9
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4572db3fa5ae..f05e54257947 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1187,6 +1187,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-orangepi-plus2e.dtb \
 	sun8i-h3-orangepi-zero-plus2.dtb \
 	sun8i-h3-rervision-dvk.dtb \
+	sun8i-h3-zeropi.dtb \
 	sun8i-h3-emlid-neutis-n5h3-devboard.dtb \
 	sun8i-r16-bananapi-m2m.dtb \
 	sun8i-r16-nintendo-nes-classic.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-zeropi.dts b/arch/arm/boot/dts/sun8i-h3-zeropi.dts
new file mode 100644
index 000000000000..388ad6b6da2b
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-zeropi.dts
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Yu-Tung Chang <mtwget@gmail.com>
+ */
+
+#include "sun8i-h3-nanopi.dtsi"
+
+/ {
+	model = "FriendlyARM ZeroPi";
+	compatible = "friendlyarm,zeropi", "allwinner,sun8i-h3";
+
+	aliases {
+		ethernet0 = &emac;
+	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gmac_power_pin_nanopi>;
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pio {
+	gmac_power_pin_nanopi: gmac_power_pin@0 {
+		pins = "PD6";
+		function = "gpio_out";
+	};
+};
+
+&external_mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+	};
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_gmac_3v3>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii";
+
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+	dr_mode = "peripheral";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+};
-- 
2.29.0

