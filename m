Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BC7300127
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbhAVLFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:05:33 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35782 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727662AbhAVKwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:52:25 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MAlTTJ011229;
        Fri, 22 Jan 2021 11:51:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=xBg98SbBGLF4n9asLs6McJi2R+rOyJSMagp1wCQF4WE=;
 b=3Sr56C/8StI7XBhS+MFeaqhRIkUdTY4+Vr1oVSrD7WTF1RX06Fi0lHWS8IQFilOMvBxV
 RQGuQtBy8Q6o/4ScKUE8F8uHvLZaxe6lyDYyA2ze3KDV/IIZjY9xCIjzddqUX9aAxdLd
 KbBV3QGHbPMXWVkd4FJYlm+yzhdurMYB80FP0n4n+QbzvwH7cbw5qg1lkUWr9/hwkT7j
 No4rPJFJ/UKiuUTSRXNa/X3bQLkcT/7UZknWmsrzqTZssoFVt6y9K1CDF5DD//JsRlq1
 9a3BEKkBsCK26lt/COX4a4Hz1DkpRslxX2eHK7y6ZOQM8axP+sFD84rOMiNx+IdSFfwV NQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3668pe1e2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 11:51:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 832B8100034;
        Fri, 22 Jan 2021 11:51:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7464E22DBCA;
        Fri, 22 Jan 2021 11:51:27 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Jan 2021 11:51:27
 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/14] ARM: dts: stm32: move clocks/resets to SCMI resources for stm32mp15
Date:   Fri, 22 Jan 2021 11:50:59 +0100
Message-ID: <20210122105101.27374-13-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122105101.27374-1-gabriel.fernandez@foss.st.com>
References: <20210122105101.27374-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_06:2021-01-21,2021-01-22 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

This change reflects board hardware configuration where RCC security
features are configured for RCC[TZEN]=1 and RCC[MCKPROT]=0, that is
RCC TrustZone is hardened and RCC MCKPROT is disabled.

Clock and reset controllers that relate to SoC secure resources are
moved from a RCC clock/reset handle to a SCMI clock/reset_domain handle.

These clocks are all the platform oscillators (HSI/LSI/CSI/HSE/LSE),
clocks for few subsystem and peripheral interfaces.

This change add a SCMI clock dependency on RCC clock device since it
registers clocks which parent clocks are provided by the SCMI clock
driver. This change allows the RCC clock device probe to be deferred
until SCMI clocks are fully registered in the system.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi  | 77 +++++++++++-------------------
 arch/arm/boot/dts/stm32mp153.dtsi  |  4 +-
 arch/arm/boot/dts/stm32mp157.dtsi  |  2 +-
 arch/arm/boot/dts/stm32mp15xc.dtsi |  4 +-
 4 files changed, 32 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index da3647373365..e06882e0611d 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -102,38 +102,6 @@
 		interrupt-parent = <&intc>;
 	};
 
-	clocks {
-		clk_hse: clk-hse {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <24000000>;
-		};
-
-		clk_hsi: clk-hsi {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <64000000>;
-		};
-
-		clk_lse: clk-lse {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-		};
-
-		clk_lsi: clk-lsi {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32000>;
-		};
-
-		clk_csi: clk-csi {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <4000000>;
-		};
-	};
-
 	thermal-zones {
 		cpu_thermal: cpu-thermal {
 			polling-delay-passive = <0>;
@@ -595,7 +563,7 @@
 			compatible = "st,stm32-cec";
 			reg = <0x40016000 0x400>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc CEC_K>, <&clk_lse>;
+			clocks = <&rcc CEC_K>, <&scmi0_clk CK_SCMI0_LSE>;
 			clock-names = "cec", "hdmi-cec";
 			status = "disabled";
 		};
@@ -1156,10 +1124,17 @@
 		};
 
 		rcc: rcc@50000000 {
-			compatible = "st,stm32mp1-rcc", "syscon";
+			compatible = "st,stm32mp1-rcc-secure", "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+
+			clock-names = "hse", "hsi", "csi", "lse", "lsi";
+			clocks = <&scmi0_clk CK_SCMI0_HSE>,
+				 <&scmi0_clk CK_SCMI0_HSI>,
+				 <&scmi0_clk CK_SCMI0_CSI>,
+				 <&scmi0_clk CK_SCMI0_LSE>,
+				 <&scmi0_clk CK_SCMI0_LSI>;
 		};
 
 		pwr_regulators: pwr@50001000 {
@@ -1342,8 +1317,8 @@
 			compatible = "st,stm32f756-hash";
 			reg = <0x54002000 0x400>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc HASH1>;
-			resets = <&rcc HASH1_R>;
+			clocks = <&scmi0_clk CK_SCMI0_HASH1>;
+			resets = <&scmi0_reset RST_SCMI0_HASH1>;
 			dmas = <&mdma1 31 0x2 0x1000A02 0x0 0x0>;
 			dma-names = "in";
 			dma-maxburst = <2>;
@@ -1353,8 +1328,8 @@
 		rng1: rng@54003000 {
 			compatible = "st,stm32-rng";
 			reg = <0x54003000 0x400>;
-			clocks = <&rcc RNG1_K>;
-			resets = <&rcc RNG1_R>;
+			clocks = <&scmi0_clk CK_SCMI0_RNG1>;
+			resets = <&scmi0_reset RST_SCMI0_RNG1>;
 			status = "disabled";
 		};
 
@@ -1363,7 +1338,7 @@
 			reg = <0x58000000 0x1000>;
 			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc MDMA>;
-			resets = <&rcc MDMA_R>;
+			resets = <&scmi0_reset RST_SCMI0_MDMA>;
 			#dma-cells = <5>;
 			dma-channels = <32>;
 			dma-requests = <48>;
@@ -1524,7 +1499,7 @@
 		iwdg2: watchdog@5a002000 {
 			compatible = "st,stm32mp1-iwdg";
 			reg = <0x5a002000 0x400>;
-			clocks = <&rcc IWDG2>, <&rcc CK_LSI>;
+			clocks = <&rcc IWDG2>, <&scmi0_clk CK_SCMI0_LSI>;
 			clock-names = "pclk", "lsi";
 			status = "disabled";
 		};
@@ -1553,7 +1528,8 @@
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc USART1_K>;
+			clocks = <&scmi0_clk CK_SCMI0_USART1>;
+			resets = <&scmi0_reset RST_SCMI0_USART1>;
 			status = "disabled";
 		};
 
@@ -1563,8 +1539,8 @@
 			compatible = "st,stm32h7-spi";
 			reg = <0x5c001000 0x400>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc SPI6_K>;
-			resets = <&rcc SPI6_R>;
+			clocks = <&scmi0_clk CK_SCMI0_SPI6>;
+			resets = <&scmi0_reset RST_SCMI0_SPI6>;
 			dmas = <&mdma1 34 0x0 0x40008 0x0 0x0>,
 			       <&mdma1 35 0x0 0x40002 0x0 0x0>;
 			dma-names = "rx", "tx";
@@ -1577,8 +1553,8 @@
 			interrupt-names = "event", "error";
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc I2C4_K>;
-			resets = <&rcc I2C4_R>;
+			clocks = <&scmi0_clk CK_SCMI0_I2C4>;
+			resets = <&scmi0_reset RST_SCMI0_I2C4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			st,syscfg-fmp = <&syscfg 0x4 0x8>;
@@ -1589,7 +1565,8 @@
 		rtc: rtc@5c004000 {
 			compatible = "st,stm32mp1-rtc";
 			reg = <0x5c004000 0x400>;
-			clocks = <&rcc RTCAPB>, <&rcc RTC>;
+			clocks = <&scmi0_clk CK_SCMI0_RTCAPB>,
+				 <&scmi0_clk CK_SCMI0_RTC>;
 			clock-names = "pclk", "rtc_ck";
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -1614,8 +1591,8 @@
 			interrupt-names = "event", "error";
 			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc I2C6_K>;
-			resets = <&rcc I2C6_R>;
+			clocks = <&scmi0_clk CK_SCMI0_I2C6>;
+			resets = <&scmi0_reset RST_SCMI0_I2C6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			st,syscfg-fmp = <&syscfg 0x4 0x20>;
@@ -1778,7 +1755,7 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 				reg = <0 0x400>;
-				clocks = <&rcc GPIOZ>;
+				clocks = <&scmi0_clk CK_SCMI0_GPIOZ>;
 				st,bank-name = "GPIOZ";
 				st,bank-ioport = <11>;
 				status = "disabled";
@@ -1800,7 +1777,7 @@
 			reg = <0x10000000 0x40000>,
 			      <0x30000000 0x40000>,
 			      <0x38000000 0x10000>;
-			resets = <&rcc MCU_R>;
+			resets = <&scmi0_reset RST_SCMI0_MCU>;
 			st,syscfg-holdboot = <&rcc 0x10C 0x1>;
 			st,syscfg-tz = <&rcc 0x000 0x1>;
 			st,syscfg-pdds = <&pwr_mcu 0x0 0x1>;
diff --git a/arch/arm/boot/dts/stm32mp153.dtsi b/arch/arm/boot/dts/stm32mp153.dtsi
index 1c1889b194cf..db1273854675 100644
--- a/arch/arm/boot/dts/stm32mp153.dtsi
+++ b/arch/arm/boot/dts/stm32mp153.dtsi
@@ -30,7 +30,7 @@
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "int0", "int1";
-			clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
+			clocks = <&scmi0_clk CK_SCMI0_HSE>, <&rcc FDCAN_K>;
 			clock-names = "hclk", "cclk";
 			bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
 			status = "disabled";
@@ -43,7 +43,7 @@
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "int0", "int1";
-			clocks = <&rcc CK_HSE>, <&rcc FDCAN_K>;
+			clocks = <&scmi0_clk CK_SCMI0_HSE>, <&rcc FDCAN_K>;
 			clock-names = "hclk", "cclk";
 			bosch,mram-cfg = <0x1400 0 0 32 0 0 2 2>;
 			status = "disabled";
diff --git a/arch/arm/boot/dts/stm32mp157.dtsi b/arch/arm/boot/dts/stm32mp157.dtsi
index 54e73ccea446..7b06c08e3a23 100644
--- a/arch/arm/boot/dts/stm32mp157.dtsi
+++ b/arch/arm/boot/dts/stm32mp157.dtsi
@@ -20,7 +20,7 @@
 		dsi: dsi@5a000000 {
 			compatible = "st,stm32-dsi";
 			reg = <0x5a000000 0x800>;
-			clocks = <&rcc DSI_K>, <&clk_hse>, <&rcc DSI_PX>;
+			clocks = <&rcc DSI_K>, <&scmi0_clk CK_SCMI0_HSE>, <&rcc DSI_PX>;
 			clock-names = "pclk", "ref", "px_clk";
 			resets = <&rcc DSI_R>;
 			reset-names = "apb";
diff --git a/arch/arm/boot/dts/stm32mp15xc.dtsi b/arch/arm/boot/dts/stm32mp15xc.dtsi
index b06a55a2fa18..435846883f25 100644
--- a/arch/arm/boot/dts/stm32mp15xc.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xc.dtsi
@@ -10,8 +10,8 @@
 			compatible = "st,stm32mp1-cryp";
 			reg = <0x54001000 0x400>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc CRYP1>;
-			resets = <&rcc CRYP1_R>;
+			clocks = <&scmi0_clk CK_SCMI0_CRYP1>;
+			resets = <&scmi0_reset RST_SCMI0_CRYP1>;
 			status = "disabled";
 		};
 	};
-- 
2.17.1

