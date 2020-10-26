Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7B298CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774919AbgJZMTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:19:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33182 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1774881AbgJZMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:19:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id w23so9046261edl.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTHIg975ANe/3LfUGyg9LuIsi6dFt4edztioVJoG9b0=;
        b=yERvvOV8x1xvJ3GOCWEQoKMVeaybAVKQsoOQzIUh3UGYg4KIfqYkrLZlr7wFu/MTmT
         TyZfn1/k59cczTQUOgFKs4isPncDBrUHPT54vLyC8407/iTpth4wqyAMT0JgZgnkZ/4h
         9Xk7FMRIk5tDTpg0oqzYEwn2M6eN4DINuoGB/7I/BDFgeNX9PE2QRugdHsG3Inh5XTno
         za+a4P3rsOZE/LLyOoaSSoAb/fI/O1rP5bPfbILobSRLUCS0udt5B5atIZUXvriKCyNZ
         teTDzujV+AUdOi4Y6DkLYpT0UqsVq5g3t63GukBnCwsjjj5cl/Q5CWb/zbbjG6XnCCyU
         k43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTHIg975ANe/3LfUGyg9LuIsi6dFt4edztioVJoG9b0=;
        b=k8W/QptGr3ArDg+tY4R44GnZcyMLIyIg7vO3j7Z3cIj5gFIPc3O8KXScKr7tDwoqz8
         pHyPF6cW3tqNXGwiJTxj2F93aqol1ldtL5r3FO4Q0bUqFr4BX0Y7yx1zCj7ewbH8OyIU
         Hvcz/+MsMPEFdCt6/r/uq+jdDyLh3bKgRXpzyfI6kRIwqowVESKIZF2MJd1q7Rw2PTdg
         kFyg4mPvQ3E75GNgbnOmEFBJXgtnxMdN9mOrpgaIT6jwyyGSa/pvS5VRJUOcyjnLOw9P
         EHHkriBOgehmiviiY7BE8oMDzSxWI1/y7XwNhj8djFiHlnf/h6z1zZiB+7YUrgnd83Lt
         3ORA==
X-Gm-Message-State: AOAM530zfLNUAmdry0nei+2ii0b2Km4XqfD6oKz4OMjTyTqIYt0yyeG/
        lzQjHW8FJIIizSJyh37briAS
X-Google-Smtp-Source: ABdhPJxvoB4OTz/ZcMzArqgkoGqn4HcBF4UMQzbBwnp9NUKJExS/s8O1BU64YrvQov6Vz6sRITLk8A==
X-Received: by 2002:aa7:d54f:: with SMTP id u15mr15387076edr.239.1603714746737;
        Mon, 26 Oct 2020 05:19:06 -0700 (PDT)
Received: from localhost.localdomain (cm-2252.cable.globalnet.hr. [213.149.62.253])
        by smtp.gmail.com with ESMTPSA id o15sm5847472ejm.38.2020.10.26.05.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:19:06 -0700 (PDT)
From:   Vladimir Vid <vladimir.vid@sartura.hr>
To:     devicetree@vger.kernel.org
Cc:     pali@kernel.org, a.heider@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tmn505@gmail.com,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, robh+dt@kernel.org,
        Vladimir Vid <vladimir.vid@sartura.hr>
Subject: [PATCH v3] arm64: dts: marvell: add DT for ESPRESSObin-Ultra
Date:   Mon, 26 Oct 2020 13:36:34 +0100
Message-Id: <20201026123633.82758-1-vladimir.vid@sartura.hr>
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

v3 changes:
- added aliases for DSA
- updated sdhci0 node based on the latest changes

---
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../marvell/armada-3720-espressobin-ultra.dts | 165 ++++++++++++++++++
 2 files changed, 166 insertions(+)
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
index 000000000000..f664c7dfab87
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -0,0 +1,165 @@
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
+	aliases {
+		/* ethernet1 is WAN port */
+		ethernet1 = &switch0port5;
+		ethernet2 = &switch0port1;
+		ethernet3 = &switch0port2;
+		ethernet4 = &switch0port3;
+		ethernet5 = &switch0port4;
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
+		switch0port1: port@1 {
+			reg = <1>;
+			label = "lan0";
+			phy-handle = <&switch0phy0>;
+		};
+
+		switch0port2: port@2 {
+			reg = <2>;
+			label = "lan1";
+			phy-handle = <&switch0phy1>;
+		};
+
+		switch0port3: port@3 {
+			reg = <3>;
+			label = "lan2";
+			phy-handle = <&switch0phy2>;
+		};
+
+		switch0port4: port@4 {
+			reg = <4>;
+			label = "lan3";
+			phy-handle = <&switch0phy3>;
+		};
+
+		switch0port5: port@5 {
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

