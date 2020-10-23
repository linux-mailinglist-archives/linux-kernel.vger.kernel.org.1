Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159C7297340
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbgJWQKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465150AbgJWQKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:10:50 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F870C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:10:49 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c15so3155546ejs.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0VrFCmtOJEoxunIpFeIHExWUdQU/hcpWXszyYHPDZ+Q=;
        b=NXos4019Tyduk907dFAxl8EYEWZdEI2fU3hGlMBv2Ptejfen5boRkquv9we1Q0KTMU
         6vI3uPDlSSeb38Xe2g9CLWYzZILi0sBh5ARnCRouQiVw+mMYCL/OWXPVzxwddhZPjgfX
         c4kUcRWG4rlkuV74PxYM9zlQ5um0/3GJxwTzaN6mqBCDYSDR3MxkBh47PMNLaLce4D6X
         etg9H5eEywPi81NOFmIqcNEsc3bzqiXorC6UrZsCHeYjKpxAdypv0mgzRhuuIxxTLcsG
         p7vkBLnuFBcYiorz6GYlmxsbbNf/cRKEaorxVUcJ9v0tHSiE4iE0tWRHAz3ugq6HwuP8
         2gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0VrFCmtOJEoxunIpFeIHExWUdQU/hcpWXszyYHPDZ+Q=;
        b=Px44C+9Ag1XOnEZVJSmmfPaQVfT2OaMfWHTUzu4xON3uWD2LaqxzU5dumO2Px4ks3/
         +H410fAyJiM0LYJGHyssP14gl6JW35SBFdO1KgXoIjxkTf4LbgpDzM4jytGrFYsBb+oP
         p86DP6TF4FIJNHG6FKg8NYXiIcuUq1CP8IhLJhQf4n6xkXo0lGgkvSco0EBaO8l/ulo2
         Lc6dljBcCS0sXOr/1KTGRSM4Ef7WHaENBTNpJ26uPj5t6ufSZ744i0vSsMIO+QdcBNKT
         f0EAhaRSi253OXczcXNvRLQ/QXRHD5Qbc4ov6sO6UJ1A8YUbcLIyQVKnR2/kd8SqQxRq
         E7TA==
X-Gm-Message-State: AOAM53247DxPoudC3oiPsz1YQF6wKJzDFIJ3J6UyF/zvruRcIsXi31l2
        adIC7weyKrpJBeHhIBgEgQsZ
X-Google-Smtp-Source: ABdhPJxyEiQ7xe4BfDP+TMSbXYbICo7V6nicWeWnmB+GGd01OzaJVB9+MwasSOVz4vZhwodgEgO5mQ==
X-Received: by 2002:a17:906:1189:: with SMTP id n9mr2845257eja.190.1603469447964;
        Fri, 23 Oct 2020 09:10:47 -0700 (PDT)
Received: from localhost.localdomain ([213.149.61.126])
        by smtp.gmail.com with ESMTPSA id r24sm989420edm.95.2020.10.23.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:10:47 -0700 (PDT)
From:   Vladimir Vid <vladimir.vid@sartura.hr>
To:     devicetree@vger.kernel.org
Cc:     pali@kernel.org, a.heider@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tmn505@gmail.com,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, robh+dt@kernel.org,
        Vladimir Vid <vladimir.vid@sartura.hr>
Subject: [PATCH v2] arm64: dts: marvell: add DT for ESPRESSObin-Ultra
Date:   Fri, 23 Oct 2020 18:21:11 +0200
Message-Id: <20201023162110.265857-1-vladimir.vid@sartura.hr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for ESPRESSObin-Ultra from Globalscale.

Specifications are similar to the base ESPRESSObin board, with main
difference being being WAN port with PoE capability and 2 additional ethernet ports.

Full specifications:

1x Marvell 64 bit Dual Core ARM A53 Armada 3700 SOC clocked up to 1.2Ghz
1x Topaz 6341 Networking Switch
1GB DDR4
8GB eMMC
1x WAN with 30W POE
4x Gb LAN
1x RTC Clock and battery
1x DC Jack
1x USB 3.0 Type A
1x USB 2.0 Type A
1x SIM NanoSIM card Slot
1x Power Button
4x LED
1x Reset button
1x microUSB for UART
1x M.2 2280 slot for memory
1x 2x2 802.11ac Wi-Fi
1x MiniPCIE slot for Wi-Fi (PCIe interface)

Signed-off-by: Vladimir Vid <vladimir.vid@sartura.hr>
---

v2 changes:

- added armada-3720-espressobin.dtsi include and updated dts
- updated model name
- renamed first partition from 'u-boot' to 'firmware' 
- disabled usb3 node for the moment as it include usb2 references

---
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../marvell/armada-3720-espressobin-ultra.dts | 161 ++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 3e5f2e7a040c..094f451fdd1d 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -3,6 +3,7 @@
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7-emmc.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-turris-mox.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
new file mode 100644
index 000000000000..87aaf620a171
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for ESPRESSObin-Ultra board.
+ * Copyright (C) 2019 Globalscale technologies, Inc.
+ *
+ * Jason Hung <jhung@globalscaletechnologies.com>
+ */
+
+/dts-v1/;
+
+#include "armada-3720-espressobin.dtsi"
+
+/ {
+	model = "Globalscale Marvell ESPRESSOBin Ultra Board";
+	compatible = "globalscale,espressobin-ultra", "marvell,armada3720",
+		     "marvell,armada3710";
+
+	reg_usb3_vbus: usb3-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb3-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&gpionb 19 GPIO_ACTIVE_HIGH>;
+	};
+
+	usb3_phy: usb3-phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_usb3_vbus>;
+	};
+
+	gpio-leds {
+		pinctrl-names = "default";
+		compatible = "gpio-leds";
+		/* No assigned functions to the LEDs by default */
+		led1 {
+			label = "ebin-ultra:blue:led1";
+			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
+		};
+		led2 {
+			label = "ebin-ultra:green:led2";
+			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
+		};
+		led3 {
+			label = "ebin-ultra:red:led3";
+			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
+		};
+		led4 {
+			label = "ebin-ultra:yellow:led4";
+			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&sdhci0 {
+	status = "okay";
+	non-removable;
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	marvell,pad-type = "fixed-1-8v";
+};
+
+&sdhci1 {
+	status = "disabled";
+};
+
+&spi0 {
+	flash@0 {
+		spi-max-frequency = <108000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "firmware";
+				reg = <0x0 0x3e0000>;
+			};
+			partition@3e0000 {
+				label = "hw-info";
+				reg = <0x3e0000 0x10000>;
+				read-only;
+			};
+			partition@3f0000 {
+				label = "u-boot-env";
+				reg = <0x3f0000 0x10000>;
+			};
+		};
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	clock-frequency = <100000>;
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&usb3 {
+	usb-phy = <&usb3_phy>;
+	status = "disabled";
+};
+
+&mdio {
+	extphy: ethernet-phy@0 {
+		reg = <1>;
+	};
+};
+
+&switch0 {
+	reg = <3>;
+
+	ports {
+		port@1	{
+			reg = <1>;
+			label = "lan0";
+			phy-handle = <&switch0phy0>;
+		};
+
+		port@2 {
+			reg = <2>;
+			label = "lan1";
+			phy-handle = <&switch0phy1>;
+		};
+
+		port@3 {
+			reg = <3>;
+			label = "lan2";
+			phy-handle = <&switch0phy2>;
+		};
+
+		port@4 {
+			reg = <4>;
+			label = "lan3";
+			phy-handle = <&switch0phy3>;
+		};
+
+		port@5 {
+			reg = <5>;
+			label = "wan";
+			phy-handle = <&extphy>;
+			phy-mode = "sgmii";
+		};
+	};
+
+	mdio {
+		switch0phy3: switch0phy3@14 {
+			reg = <0x14>;
+		};
+	};
+};
-- 
2.27.0

