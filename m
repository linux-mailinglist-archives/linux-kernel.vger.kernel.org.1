Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2986296BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461150AbgJWJJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461032AbgJWJJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:09:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3ACC0613CE;
        Fri, 23 Oct 2020 02:09:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so508860pll.11;
        Fri, 23 Oct 2020 02:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90y1EmZ8ExMVl4uu0iOAC31TNJDdFr08bOUs5sThwIc=;
        b=AVC5r633pDK3sSsRQxrljPVbC2JNShoDmTSlP9f4KImqz+7AN/bL7JOKVQY0R+0QcZ
         r3Diz0DSsyHxkIQW+f7BbyBEPe64ogPnXsCFFq27wND9rND/Obgxyf9rTvwG09RwEksD
         pyP3t1PotiqF02guRlM1cvwkHW3s6EnFlZOty7wLcJZME/q7L+b9wKfZ5WkLbRpdwFYe
         /Yka+0G67vWgfXyEa0S5scOatD4AI2Uuh5NJJvGNjdcapf8V/NiDeZRjYw4S3qSbvvwE
         XWEfg3KGm4jZ7sg/9K8sSFSLZAzHcGmaNJM+zDekrKLImPwYd55ExS+bV20omxHQ9rJn
         WoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90y1EmZ8ExMVl4uu0iOAC31TNJDdFr08bOUs5sThwIc=;
        b=t/8H4juaZOKcJ0i3LBAVR+OtZI8wVNpNr0Cr4h7/LvB6jNqN5THOEHo6raoRoXGbxZ
         Fwpo4loDx+w+Z4e10IrUakyo7K0PypUZuGpbsgX7jJG0Aj7Vd1lqHf8ososE3l545YcZ
         oM8NxNceaOr76VJDI7xqrtjG1Ew4kyZPSOuxtPVqkqoyX4P9SPSbOMSLoTIovwC/3P2+
         SCCtpvFDnCOShPVnxu7Z2h5Jx580s9ZotWe8kTTOQh2SmnBIK7o1o3PmHSVC1CNWMQkH
         /tOL5Gdsf94elsomxFFawGCmiv9c6WAJGikCIBrEKPqNWDvuTIiGi0EZm1+YICOvHE68
         tPlw==
X-Gm-Message-State: AOAM531XzJHHxQ4XMfiEmT9QBq6+oG5XBrNAydaYC7F8fFBe6yyK0T+t
        0RcFRWqv7G3Zls1qXwleXeeOpK2QG36zifwX
X-Google-Smtp-Source: ABdhPJzoANkVSJjRlPgNhGGO6NAgZx4i19k6LUz3orIq32M1CEgOf4KPOA0GFOfHXEjf4Ux1+gWOvA==
X-Received: by 2002:a17:902:7249:b029:d6:4d:7d82 with SMTP id c9-20020a1709027249b02900d6004d7d82mr1376694pll.74.1603444156880;
        Fri, 23 Oct 2020 02:09:16 -0700 (PDT)
Received: from ruantu-3.localdomain ([103.230.142.242])
        by smtp.gmail.com with ESMTPSA id z23sm1132381pgf.12.2020.10.23.02.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:09:16 -0700 (PDT)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH v1] ARM: dts: sun8i: add FriendlyArm ZeroPi support
Date:   Fri, 23 Oct 2020 17:09:08 +0800
Message-Id: <20201023090908.10659-1-mtwget@gmail.com>
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

