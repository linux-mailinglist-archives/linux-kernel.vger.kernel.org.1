Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AB82C4FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 08:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgKZHoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 02:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgKZHoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:44:19 -0500
X-Greylist: delayed 2327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Nov 2020 23:44:18 PST
Received: from srv1.deutnet.info (srv1.deutnet.info [IPv6:2a01:4f8:c2c:6846::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D3CC0613D4;
        Wed, 25 Nov 2020 23:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deutnet.info; s=default; h=Message-Id:Date:Subject:Cc:To:From:in-reply-to;
         bh=P0S8C3sSe2e5YSzuN2CkiWD27lD7mYY9AT/48Cv9nDE=; b=RIZr7NZCF5JkZPLcIb82qnp7C
        I45HU3TocjuB0V74WDz4i14+QQWL+PO/01KjwdFLAcFaztCeAFsyMoFsjZzhVbcqzmFQBJx50CoQw
        ALIvbTxMFtGkQcyI+ecFfwOD7Jc8d3LmlAo4XcybxzQsMOjRktWk2vCt/0QpQ/voQGiEGRRdGe4ZH
        PFOJdrc2m4/XlLnxeWYHPcyionHUb17+hY67sJ+kA2BlNPtHUHrahZBQytZVf0/PSrPGohRngGhQ8
        uPEdFppj61pSBVmPv6On3cBjH0/IL/7f+1nGOMYM78HEGYsyTwa1MxyQZRNh1jebiSIGmzhjLfPhy
        w2rtl8u/g==;
Received: from [2001:bc8:3dc9::1] (helo=srv100.deutnet.info)
        by srv1.deutnet.info with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1kiBLG-0000zG-G7; Thu, 26 Nov 2020 08:05:22 +0100
Received: from agriveaux by srv100.deutnet.info with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1kiBLG-000MLv-5A; Thu, 26 Nov 2020 08:05:22 +0100
From:   agriveaux@deutnet.info
To:     michal.simek@xilinx.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre GRIVEAUX <agriveaux@deutnet.info>
Subject: [PATCH v2] ARM: zynq: Add Z-turn board V5
Date:   Thu, 26 Nov 2020 08:05:16 +0100
Message-Id: <20201126070516.85882-1-agriveaux@deutnet.info>
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

Changes v1 -> v2: Instead of using new board, the v2 using a common devicetree
for z-turn boards (zynq-zturn-common.dtsi) and for each board a specific DT

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
index ce66ffd5a1bb..3de85fe42f76 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1302,6 +1302,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
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

