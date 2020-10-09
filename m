Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C1288C46
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbgJIPKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbgJIPKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:10:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27903C0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 08:10:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id md26so13546508ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PxegeFhCelh8zIkzz2DAsEp3aMgGY2ESeOZ7M8gRsPk=;
        b=bgoRtOrEpgbz7WhutgSEfrnwH3BlqYE2xJSHBLzlD5UQ/5G7rUcgtCzdhWPMP9OmVm
         UzswZs1pAUk5D/g4eVDb5pHFtaf3gSPjqrDA/pAOWbCFqJXhFnys/bIRM0I90BnfvROg
         Haji1l1GQ1QNnj4GrawRO36OCzdvTgCpW5ppvuW6PjMzoCkhCAPBG0eIhCPM25lQv4w9
         +yvopdJ3XjwN9xa8Fke3LUUuTLhXSs0U+1xy5HG4xiDC+XH28TfsUX7HqeLd4V1x9y0y
         C7CdusnQNbzidE40gtXwvhWFlYDZLFp29GwllZzej/XYanRMaqUL/8xXcTs3bTpUoU9B
         d9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PxegeFhCelh8zIkzz2DAsEp3aMgGY2ESeOZ7M8gRsPk=;
        b=eBX2xU0S6cda3JWcwGCmBxzHHnwEHmxi18bhmm5p+OWZPeiWKFjdlTL3VyoXLZ9oBH
         Ec0V9rDpfUWLHkP5V2tRBVe7N/yNEaY1fYREp2z+U41EV5W3E6AAtmkdCFzcE7kiOXTk
         NB5eYWNg9nDbZYT6jhRs0S/5xB4Kz+FH6Wn98uFxR5advhJ5FDXPpf8o4lLNG5mqE/ep
         9wLqivSNEtgj6lo65W6106rDZY4ilIdRznFF7BqR/3+UNA75Cpn4oqXPMhaBiQayC7Bo
         +zNJ0Khwjjpm0lgfm3REBbIlJdqH79SmFM3X2lZfP90ypYBcW3FdfWR1Boq2oEz2Pq6S
         eSjg==
X-Gm-Message-State: AOAM532JLh9PNhtkBclqssOE3y1FjM0n/iX6v1oz5/FB21tEDGMjEG1O
        Xl7GD0rsKjJXnV06SIarlwRb
X-Google-Smtp-Source: ABdhPJzMIgFk28EN8/d2dnhX1USbdyYR4wk9/F/9x0Jjty1KuNDay5rcnHjCrmhCBvzlduX+O0MP3A==
X-Received: by 2002:a17:906:4ec7:: with SMTP id i7mr14468618ejv.439.1602256233965;
        Fri, 09 Oct 2020 08:10:33 -0700 (PDT)
Received: from archlinux.localdomain ([89.18.44.40])
        by smtp.gmail.com with ESMTPSA id o9sm6281809eds.5.2020.10.09.08.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:10:33 -0700 (PDT)
From:   Vladimir Vid <vladimir.vid@sartura.hr>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tmn505@gmail.com, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        robh+dt@kernel.org, Vladimir Vid <vladimir.vid@sartura.hr>
Subject: [PATCH] arm64: dts: marvell: add DT for ESPRESSObin-Ultra
Date:   Fri,  9 Oct 2020 17:27:10 +0200
Message-Id: <20201009152710.316047-1-vladimir.vid@sartura.hr>
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
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../marvell/armada-3720-espressobin-ultra.dts | 242 ++++++++++++++++++
 2 files changed, 243 insertions(+)
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
index 000000000000..25d10b628e77
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -0,0 +1,242 @@
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
+#include <dt-bindings/gpio/gpio.h>
+#include "armada-372x.dtsi"
+
+/ {
+	model = "Marvell Armada 3720 ESPRESSOBin-Ultra";
+	compatible = "globalscale,espressobin-ultra", "marvell,armada3720",
+		     "marvell,armada3710";
+
+	aliases {
+		ethernet0 = &eth0;
+		/* for dsa slave device */
+		ethernet1 = &switch0port1;
+		ethernet2 = &switch0port2;
+		ethernet3 = &switch0port3;
+		ethernet4 = &switch0port4;
+		ethernet5 = &switch0port5;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
+	};
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
+&pcie0 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
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
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_quad_pins>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <108000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "u-boot";
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
+&uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
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
+	status = "okay";
+	usb-phy = <&usb3_phy>;
+};
+
+&usb2 {
+	status = "okay";
+};
+
+&eth0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	phy-mode = "rgmii-id";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	extphy: ethernet-phy@0 {
+		reg = <1>;
+	};
+
+	switch0: switch0@1 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <3>;
+
+		dsa,member = <0 0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch0port0: port@0 {
+				reg = <0>;
+				label = "cpu";
+				ethernet = <&eth0>;
+			};
+
+			switch0port1: port@1 {
+				reg = <1>;
+				label = "lan0";
+				phy-handle = <&switch0phy1>;
+			};
+
+			switch0port2: port@2 {
+				reg = <2>;
+				label = "lan1";
+				phy-handle = <&switch0phy2>;
+			};
+
+			switch0port3: port@3 {
+				reg = <3>;
+				label = "lan2";
+				phy-handle = <&switch0phy3>;
+			};
+
+			switch0port4: port@4 {
+				reg = <4>;
+				label = "lan3";
+				phy-handle = <&switch0phy4>;
+			};
+
+			switch0port5: port@5 {
+				reg = <5>;
+				label = "wan";
+				phy-handle = <&extphy>;
+				phy-mode = "sgmii";
+			};
+		};
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch0phy1: switch0phy1@11 {
+				reg = <0x11>;
+			};
+			switch0phy2: switch0phy2@12 {
+				reg = <0x12>;
+			};
+			switch0phy3: switch0phy3@13 {
+				reg = <0x13>;
+			};
+			switch0phy4: switch0phy4@14 {
+				reg = <0x14>;
+			};
+		};
+	};
+};
-- 
2.27.0

