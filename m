Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F719278329
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgIYIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgIYIuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:50:04 -0400
Received: from srv1.deutnet.info (srv1.deutnet.info [IPv6:2a01:4f8:c2c:6846::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D93C0613CE;
        Fri, 25 Sep 2020 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deutnet.info; s=default; h=Message-Id:Date:Subject:Cc:To:From:in-reply-to;
         bh=GJZmYEJ591Gps8WWZkpi+e+ceyHTNmz71kHb3moL8IQ=; b=leg2mER/qwThATAbIM4mMZ+Ru
        lRaObtmPmzJtHicjyANvwSywGYR2MiM3kc6qHKxx7V81rFRZqIrWz1MFbApsst4G5A1ZzcFXORBmW
        BORVJAAelycM/YnoJ9OZbLpKJb4nwqobn1q07JOVixfG5fABRrLJZM+WZgNChCLOt7Mk3oO1msT3D
        9Xawb+WOy5+uSlZuIWHgjoJeuAH7iufoRMj/XvB8CTD8VlMguoy6WC+1V+Pb5+8w1KoWSjYshMPcV
        EiAC9IfKkFfj+uz+7gWQjOo+bOBFyoS9PH44MP2c6C1FgMEV+HlWN9dC0PLJhzs1TrM+sV29l2V14
        VC5MuVefA==;
Received: from [2001:bc8:3dc9::1] (helo=srv100.deutnet.info)
        by srv1.deutnet.info with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1kLjQS-0004hv-Qn; Fri, 25 Sep 2020 10:49:56 +0200
Received: from agriveaux by srv100.deutnet.info with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1kLjQS-00EPZ2-5G; Fri, 25 Sep 2020 10:49:56 +0200
From:   agriveaux@deutnet.info
To:     michal.simek@xilinx.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre GRIVEAUX <agriveaux@deutnet.info>
Subject: [PATCH] ARM: zynq: Add Z-turn board V5
Date:   Fri, 25 Sep 2020 10:49:47 +0200
Message-Id: <20200925084947.3434819-1-agriveaux@deutnet.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre GRIVEAUX <agriveaux@deutnet.info>

Adding Z-turn board V5 to resolve the change between:

"Z-TURNBOARD_schematic.pdf" schematics state version 1 to 4 has Atheros AR8035
"Z-Turn_Board_sch_V15_20160303.pdf" schematics state version 5 has Micrel KSZ9031

Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/zynq-zturn-common.dtsi | 112 +++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zturn-v5.dts      |  15 +++
 arch/arm/boot/dts/zynq-zturn.dts         | 101 +-------------------
 4 files changed, 129 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm/boot/dts/zynq-zturn-common.dtsi
 create mode 100644 arch/arm/boot/dts/zynq-zturn-v5.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4572db3fa5ae..a75f535c3680 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1287,6 +1287,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
 	zynq-zc770-xm013.dtb \
 	zynq-zed.dtb \
 	zynq-zturn.dtb \
+	zynq-zturn-v5.dtb \
 	zynq-zybo.dtb \
 	zynq-zybo-z7.dtb
 dtb-$(CONFIG_MACH_ARMADA_370) += \
diff --git a/arch/arm/boot/dts/zynq-zturn-common.dtsi b/arch/arm/boot/dts/zynq-zturn-common.dtsi
new file mode 100644
index 000000000000..84f3c85c5bab
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-zturn-common.dtsi
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2015 Andrea Merello <adnrea.merello@gmail.com>
+ *  Copyright (C) 2017 Alexander Graf <agraf@suse.de>
+ *
+ *  Based on zynq-zed.dts which is:
+ *  Copyright (C) 2011 - 2014 Xilinx
+ *  Copyright (C) 2012 National Instruments Corp.
+ *
+ */
+
+/dts-v1/;
+/include/ "zynq-7000.dtsi"
+
+/ {
+	compatible = "xlnx,zynq-7000";
+
+	aliases {
+		ethernet0 = &gem0;
+		serial0 = &uart1;
+		serial1 = &uart0;
+		mmc0 = &sdhci0;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		usr-led1 {
+			label = "usr-led1";
+			gpios = <&gpio0 0x0 0x1>;
+			default-state = "off";
+		};
+
+		usr-led2 {
+			label = "usr-led2";
+			gpios = <&gpio0 0x9 0x1>;
+			default-state = "off";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		K1 {
+			label = "K1";
+			gpios = <&gpio0 0x32 0x1>;
+			linux,code = <0x66>;
+			wakeup-source;
+			autorepeat;
+		};
+	};
+};
+
+&clkc {
+	ps-clk-frequency = <33333333>;
+};
+
+&gem0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy>;
+
+	ethernet_phy: ethernet-phy@0 {
+	};
+};
+
+&sdhci0 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&can0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	stlm75@49 {
+		status = "okay";
+		compatible = "lm75";
+		reg = <0x49>;
+	};
+
+	accelerometer@53 {
+		compatible = "adi,adxl345", "adxl345", "adi,adxl34x", "adxl34x";
+		reg = <0x53>;
+		interrupt-parent = <&intc>;
+		interrupts = <0x0 0x1e 0x4>;
+	};
+};
diff --git a/arch/arm/boot/dts/zynq-zturn-v5.dts b/arch/arm/boot/dts/zynq-zturn-v5.dts
new file mode 100644
index 000000000000..536632a09a25
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-zturn-v5.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+/include/ "zynq-zturn-common.dtsi"
+
+/ {
+	model = "Zynq Z-Turn MYIR Board V5";
+	compatible = "myir,zynq-zturn-v5", "xlnx,zynq-7000";
+};
+
+&gem0 {
+	ethernet_phy: ethernet-phy@0 {
+		reg = <0x3>;
+	};
+};
diff --git a/arch/arm/boot/dts/zynq-zturn.dts b/arch/arm/boot/dts/zynq-zturn.dts
index 5ec616ebca08..620b24a25e06 100644
--- a/arch/arm/boot/dts/zynq-zturn.dts
+++ b/arch/arm/boot/dts/zynq-zturn.dts
@@ -1,114 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- *  Copyright (C) 2015 Andrea Merello <adnrea.merello@gmail.com>
- *  Copyright (C) 2017 Alexander Graf <agraf@suse.de>
- *
- *  Based on zynq-zed.dts which is:
- *  Copyright (C) 2011 - 2014 Xilinx
- *  Copyright (C) 2012 National Instruments Corp.
- *
- */
 
 /dts-v1/;
-/include/ "zynq-7000.dtsi"
+/include/ "zynq-zturn-common.dtsi"
 
 / {
 	model = "Zynq Z-Turn MYIR Board";
 	compatible = "myir,zynq-zturn", "xlnx,zynq-7000";
-
-	aliases {
-		ethernet0 = &gem0;
-		serial0 = &uart1;
-		serial1 = &uart0;
-		mmc0 = &sdhci0;
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x0 0x40000000>;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	gpio-leds {
-		compatible = "gpio-leds";
-		usr-led1 {
-			label = "usr-led1";
-			gpios = <&gpio0 0x0 0x1>;
-			default-state = "off";
-		};
-
-		usr-led2 {
-			label = "usr-led2";
-			gpios = <&gpio0 0x9 0x1>;
-			default-state = "off";
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		autorepeat;
-		K1 {
-			label = "K1";
-			gpios = <&gpio0 0x32 0x1>;
-			linux,code = <0x66>;
-			wakeup-source;
-			autorepeat;
-		};
-	};
-};
-
-&clkc {
-	ps-clk-frequency = <33333333>;
 };
 
 &gem0 {
-	status = "okay";
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethernet_phy>;
-
 	ethernet_phy: ethernet-phy@0 {
 		reg = <0x0>;
 	};
 };
-
-&sdhci0 {
-	status = "okay";
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	dr_mode = "host";
-};
-
-&can0 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	stlm75@49 {
-		status = "okay";
-		compatible = "lm75";
-		reg = <0x49>;
-	};
-
-	accelerometer@53 {
-		compatible = "adi,adxl345", "adxl345", "adi,adxl34x", "adxl34x";
-		reg = <0x53>;
-		interrupt-parent = <&intc>;
-		interrupts = <0x0 0x1e 0x4>;
-	};
-};
-- 
2.20.1

