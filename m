Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726FD2E7019
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgL2Lsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:48:39 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:38137 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgL2Lsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:48:37 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5087A23E5F;
        Tue, 29 Dec 2020 12:47:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1609242473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N87C7fYMH4HpUzGIjbHPvTDymgLtY75oD1GPbdeuXpM=;
        b=JzYBphXxtMtOAa9snJKbgdFE38DrgHnimvD/Te+9GHsVT54jkcnNcNS8CcD5BcLrzcY0s7
        n873PVq9qGMrTCXuipiLKrxsQVpsgTK+IETa06dGr60t0grC9PSCSxEDB1S0f94LbOC3j4
        GIF91DQ3c7G99OhyNsrpMNX0+A6RUok=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 6/7] arm64: dts: ls208xa: use constants in the clockgen phandle
Date:   Tue, 29 Dec 2020 12:47:39 +0100
Message-Id: <20201229114740.7936-7-michael@walle.cc>
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
 .../arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 17 ++--
 .../arm64/boot/dts/freescale/fsl-ls2088a.dtsi | 17 ++--
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 85 ++++++++++++++-----
 3 files changed, 81 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index f9c1d30cf4a7..76ab68d2de0b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -9,6 +9,7 @@
  *
  */
 
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include "fsl-ls208xa.dtsi"
 
 &cpu {
@@ -16,7 +17,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a57";
 		reg = <0x0>;
-		clocks = <&clockgen 1 0>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster0_l2>;
 		#cooling-cells = <2>;
@@ -26,7 +27,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a57";
 		reg = <0x1>;
-		clocks = <&clockgen 1 0>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster0_l2>;
 		#cooling-cells = <2>;
@@ -36,7 +37,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a57";
 		reg = <0x100>;
-		clocks = <&clockgen 1 1>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 1>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster1_l2>;
 		#cooling-cells = <2>;
@@ -46,7 +47,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a57";
 		reg = <0x101>;
-		clocks = <&clockgen 1 1>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 1>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster1_l2>;
 		#cooling-cells = <2>;
@@ -56,7 +57,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a57";
 		reg = <0x200>;
-		clocks = <&clockgen 1 2>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 2>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster2_l2>;
 		#cooling-cells = <2>;
@@ -66,7 +67,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a57";
 		reg = <0x201>;
-		clocks = <&clockgen 1 2>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 2>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster2_l2>;
 		#cooling-cells = <2>;
@@ -76,7 +77,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a57";
 		reg = <0x300>;
-		clocks = <&clockgen 1 3>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 3>;
 		next-level-cache = <&cluster3_l2>;
 		cpu-idle-states = <&CPU_PW20>;
 		#cooling-cells = <2>;
@@ -86,7 +87,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a57";
 		reg = <0x301>;
-		clocks = <&clockgen 1 3>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 3>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster3_l2>;
 		#cooling-cells = <2>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
index a5f668d786b8..da24dc127698 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
@@ -9,6 +9,7 @@
  *
  */
 
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include "fsl-ls208xa.dtsi"
 
 &cpu {
@@ -16,7 +17,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a72";
 		reg = <0x0>;
-		clocks = <&clockgen 1 0>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster0_l2>;
 		#cooling-cells = <2>;
@@ -26,7 +27,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a72";
 		reg = <0x1>;
-		clocks = <&clockgen 1 0>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster0_l2>;
 		#cooling-cells = <2>;
@@ -36,7 +37,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a72";
 		reg = <0x100>;
-		clocks = <&clockgen 1 1>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 1>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster1_l2>;
 		#cooling-cells = <2>;
@@ -46,7 +47,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a72";
 		reg = <0x101>;
-		clocks = <&clockgen 1 1>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 1>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster1_l2>;
 		#cooling-cells = <2>;
@@ -56,7 +57,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a72";
 		reg = <0x200>;
-		clocks = <&clockgen 1 2>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 2>;
 		next-level-cache = <&cluster2_l2>;
 		cpu-idle-states = <&CPU_PW20>;
 		#cooling-cells = <2>;
@@ -66,7 +67,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a72";
 		reg = <0x201>;
-		clocks = <&clockgen 1 2>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 2>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster2_l2>;
 		#cooling-cells = <2>;
@@ -76,7 +77,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a72";
 		reg = <0x300>;
-		clocks = <&clockgen 1 3>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 3>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster3_l2>;
 		#cooling-cells = <2>;
@@ -86,7 +87,7 @@
 		device_type = "cpu";
 		compatible = "arm,cortex-a72";
 		reg = <0x301>;
-		clocks = <&clockgen 1 3>;
+		clocks = <&clockgen QORIQ_CLK_CMUX 3>;
 		cpu-idle-states = <&CPU_PW20>;
 		next-level-cache = <&cluster3_l2>;
 		#cooling-cells = <2>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index c68901f8c6f0..6110025f02a4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -9,6 +9,7 @@
  *
  */
 
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -325,84 +326,112 @@
 		serial0: serial@21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21c0500 0x0 0x100>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			interrupts = <0 32 0x4>; /* Level high type */
 		};
 
 		serial1: serial@21c0600 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21c0600 0x0 0x100>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			interrupts = <0 32 0x4>; /* Level high type */
 		};
 
 		serial2: serial@21d0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21d0500 0x0 0x100>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			interrupts = <0 33 0x4>; /* Level high type */
 		};
 
 		serial3: serial@21d0600 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21d0600 0x0 0x100>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			interrupts = <0 33 0x4>; /* Level high type */
 		};
 
 		cluster1_core0_watchdog: wdt@c000000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster1_core1_watchdog: wdt@c010000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc010000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster2_core0_watchdog: wdt@c100000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc100000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster2_core1_watchdog: wdt@c110000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc110000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster3_core0_watchdog: wdt@c200000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc200000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster3_core1_watchdog: wdt@c210000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc210000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster4_core0_watchdog: wdt@c300000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc300000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster4_core1_watchdog: wdt@c310000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc310000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
@@ -453,7 +482,8 @@
 		ptp-timer@8b95000 {
 			compatible = "fsl,dpaa2-ptp";
 			reg = <0x0 0x8b95000 0x0 0x100>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			little-endian;
 			fsl,extts-fifo;
 		};
@@ -864,7 +894,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2100000 0x0 0x10000>;
 			interrupts = <0 26 0x4>; /* Level high type */
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "dspi";
 			spi-num-chipselects = <5>;
 			bus-num = <0>;
@@ -875,7 +906,8 @@
 			compatible = "fsl,ls2080a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
 			interrupts = <0 28 0x4>; /* Level high type */
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			little-endian;
@@ -934,7 +966,8 @@
 			reg = <0x0 0x2000000 0x0 0x10000>;
 			interrupts = <0 34 0x4>; /* Level high type */
 			clock-names = "i2c";
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 		};
 
 		i2c1: i2c@2010000 {
@@ -945,7 +978,8 @@
 			reg = <0x0 0x2010000 0x0 0x10000>;
 			interrupts = <0 34 0x4>; /* Level high type */
 			clock-names = "i2c";
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 		};
 
 		i2c2: i2c@2020000 {
@@ -956,7 +990,8 @@
 			reg = <0x0 0x2020000 0x0 0x10000>;
 			interrupts = <0 35 0x4>; /* Level high type */
 			clock-names = "i2c";
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 		};
 
 		i2c3: i2c@2030000 {
@@ -967,7 +1002,8 @@
 			reg = <0x0 0x2030000 0x0 0x10000>;
 			interrupts = <0 35 0x4>; /* Level high type */
 			clock-names = "i2c";
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 		};
 
 		ifc: ifc@2240000 {
@@ -991,7 +1027,10 @@
 			      <0x0 0x20000000 0x0 0x10000000>;
 			reg-names = "QuadSPI", "QuadSPI-memory";
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "qspi_en", "qspi";
 			status = "disabled";
 		};
@@ -1089,7 +1128,8 @@
 			compatible = "fsl,ls2080a-ahci";
 			reg = <0x0 0x3200000 0x0 0x10000>;
 			interrupts = <0 133 0x4>; /* Level high type */
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			dma-coherent;
 		};
 
@@ -1098,7 +1138,8 @@
 			compatible = "fsl,ls2080a-ahci";
 			reg = <0x0 0x3210000 0x0 0x10000>;
 			interrupts = <0 136 0x4>; /* Level high type */
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			dma-coherent;
 		};
 
-- 
2.20.1

