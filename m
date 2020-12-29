Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7EB2E7029
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgL2LtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:49:12 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:34831 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgL2Lsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:48:36 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7BCFD23E5D;
        Tue, 29 Dec 2020 12:47:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1609242473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zwhD5+WwMEQMOXfDliU/g/wgNnPFUxC63goH+T6II2c=;
        b=IxGAHBpkSpcrOX5t/3uvJgFWYhleZGuqH37JLdQa77uOMjaXBtjNy5AVyPR/sU7ZuSOLyA
        6AiDK87x+lTlF0g3beicjmAsLg69VRUIZdDDhubTB0l5qz2GbwxWWvlUv0J966EtYUoJXp
        s6w55a1dRgIaj9VGf3FMyL7tcZNBw+M=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 5/7] arm64: dts: ls1088a: use constants in the clockgen phandle
Date:   Tue, 29 Dec 2020 12:47:38 +0100
Message-Id: <20201229114740.7936-6-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201229114740.7936-1-michael@walle.cc>
References: <20201229114740.7936-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have constants, use them. This is just a mechanical change.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 91 +++++++++++++------
 1 file changed, 64 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 6403455ed039..95647e5afb02 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -7,6 +7,7 @@
  * Harninder Rai <harninder.rai@nxp.com>
  *
  */
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -30,7 +31,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
 		};
@@ -39,7 +40,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
 		};
@@ -48,7 +49,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x2>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
 		};
@@ -57,7 +58,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x3>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
 		};
@@ -66,7 +67,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x100>;
-			clocks = <&clockgen 1 1>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 1>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
 		};
@@ -75,7 +76,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x101>;
-			clocks = <&clockgen 1 1>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 1>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
 		};
@@ -84,7 +85,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x102>;
-			clocks = <&clockgen 1 1>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 1>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
 		};
@@ -93,7 +94,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x103>;
-			clocks = <&clockgen 1 1>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 1>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
 		};
@@ -279,7 +280,8 @@
 			reg = <0x0 0x2100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			spi-num-chipselects = <6>;
 			status = "disabled";
 		};
@@ -287,7 +289,8 @@
 		duart0: serial@21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21c0500 0x0 0x100>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -295,7 +298,8 @@
 		duart1: serial@21c0600 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21c0600 0x0 0x100>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -360,7 +364,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2000000 0x0 0x10000>;
 			interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>;
 			status = "disabled";
 		};
 
@@ -370,7 +375,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2010000 0x0 0x10000>;
 			interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>;
 			status = "disabled";
 		};
 
@@ -380,7 +386,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2020000 0x0 0x10000>;
 			interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>;
 			status = "disabled";
 		};
 
@@ -390,7 +397,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2030000 0x0 0x10000>;
 			interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>;
 			status = "disabled";
 		};
 
@@ -403,7 +411,10 @@
 			reg-names = "QuadSPI", "QuadSPI-memory";
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "qspi_en", "qspi";
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -412,7 +423,7 @@
 			reg = <0x0 0x2140000 0x0 0x10000>;
 			interrupts = <0 28 0x4>; /* Level high type */
 			clock-frequency = <0>;
-			clocks = <&clockgen 2 1>;
+			clocks = <&clockgen QORIQ_CLK_HWACCEL 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			little-endian;
@@ -447,7 +458,8 @@
 				<0x7 0x100520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			dma-coherent;
 			status = "disabled";
 		};
@@ -698,7 +710,8 @@
 		ptp-timer@8b95000 {
 			compatible = "fsl,dpaa2-ptp";
 			reg = <0x0 0x8b95000 0x0 0x100>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			little-endian;
 			fsl,extts-fifo;
 		};
@@ -787,56 +800,80 @@
 		cluster1_core0_watchdog: wdt@c000000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
-			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster1_core1_watchdog: wdt@c010000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc010000 0x0 0x1000>;
-			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster1_core2_watchdog: wdt@c020000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc020000 0x0 0x1000>;
-			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster1_core3_watchdog: wdt@c030000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc030000 0x0 0x1000>;
-			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster2_core0_watchdog: wdt@c100000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc100000 0x0 0x1000>;
-			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster2_core1_watchdog: wdt@c110000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc110000 0x0 0x1000>;
-			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster2_core2_watchdog: wdt@c120000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc120000 0x0 0x1000>;
-			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster2_core3_watchdog: wdt@c130000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc130000 0x0 0x1000>;
-			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-- 
2.20.1

