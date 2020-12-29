Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31462E701D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgL2Lsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:48:36 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:46749 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgL2Lse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:48:34 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BC58223E55;
        Tue, 29 Dec 2020 12:47:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1609242471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5+yqctbj7LyDINpXF/b11patOEn+w1AjPMH2SD9wQ0=;
        b=Ti2FbErlIcVKp5i58jsYHUCBX3bkTC9PDJ71REp1AoaF2wQhYB7UR6WyCkiRzj3aDFQvYO
        nNIzQVSZZV3XyJrsio4cQB1AdKGhJlyqv7AVo581l5sTSCqwDE7Opd7eLcr7fijL2h3QFw
        bf5ruYiLTJHQK7YxznGTjIvDycsWJf4=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 3/7] arm64: dts: ls1043a: use constants in the clockgen phandle
Date:   Tue, 29 Dec 2020 12:47:36 +0100
Message-Id: <20201229114740.7936-4-michael@walle.cc>
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
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 73 ++++++++++++-------
 .../boot/dts/freescale/qoriq-fman3-0.dtsi     |  6 +-
 2 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index bbae4b353d3f..073f17ed634f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -8,6 +8,7 @@
  * Mingkai Hu <Mingkai.hu@freescale.com>
  */
 
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -44,7 +45,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
@@ -54,7 +55,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
@@ -64,7 +65,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x2>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
@@ -74,7 +75,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x3>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
@@ -377,7 +378,10 @@
 			reg-names = "QuadSPI", "QuadSPI-memory";
 			interrupts = <0 99 0x4>;
 			clock-names = "qspi_en", "qspi";
-			clocks = <&clockgen 4 0>, <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			status = "disabled";
 		};
 
@@ -476,7 +480,8 @@
 			reg = <0x0 0x2100000 0x0 0x10000>;
 			interrupts = <0 64 0x4>;
 			clock-names = "dspi";
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			spi-num-chipselects = <5>;
 			big-endian;
 			status = "disabled";
@@ -489,7 +494,8 @@
 			reg = <0x0 0x2110000 0x0 0x10000>;
 			interrupts = <0 65 0x4>;
 			clock-names = "dspi";
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			spi-num-chipselects = <5>;
 			big-endian;
 			status = "disabled";
@@ -502,7 +508,8 @@
 			reg = <0x0 0x2180000 0x0 0x10000>;
 			interrupts = <0 56 0x4>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			dmas = <&edma0 1 39>,
 			       <&edma0 1 38>;
 			dma-names = "tx", "rx";
@@ -516,7 +523,8 @@
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <0 57 0x4>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			status = "disabled";
 		};
 
@@ -527,7 +535,8 @@
 			reg = <0x0 0x21a0000 0x0 0x10000>;
 			interrupts = <0 58 0x4>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			status = "disabled";
 		};
 
@@ -538,7 +547,8 @@
 			reg = <0x0 0x21b0000 0x0 0x10000>;
 			interrupts = <0 59 0x4>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			status = "disabled";
 		};
 
@@ -546,28 +556,32 @@
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0500 0x0 0x100>;
 			interrupts = <0 54 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 		};
 
 		duart1: serial@21c0600 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0600 0x0 0x100>;
 			interrupts = <0 54 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 		};
 
 		duart2: serial@21d0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21d0500 0x0 0x100>;
 			interrupts = <0 55 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 		};
 
 		duart3: serial@21d0600 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21d0600 0x0 0x100>;
 			interrupts = <0 55 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 		};
 
 		gpio1: gpio@2300000 {
@@ -679,7 +693,7 @@
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2950000 0x0 0x1000>;
 			interrupts = <0 48 0x4>;
-			clocks = <&clockgen 0 0>;
+			clocks = <&clockgen QORIQ_CLK_SYSCLK 0>;
 			clock-names = "ipg";
 			status = "disabled";
 		};
@@ -688,7 +702,8 @@
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2960000 0x0 0x1000>;
 			interrupts = <0 49 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "ipg";
 			status = "disabled";
 		};
@@ -697,7 +712,8 @@
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2970000 0x0 0x1000>;
 			interrupts = <0 50 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "ipg";
 			status = "disabled";
 		};
@@ -706,7 +722,8 @@
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2980000 0x0 0x1000>;
 			interrupts = <0 51 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "ipg";
 			status = "disabled";
 		};
@@ -715,7 +732,8 @@
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2990000 0x0 0x1000>;
 			interrupts = <0 52 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "ipg";
 			status = "disabled";
 		};
@@ -724,7 +742,8 @@
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x29a0000 0x0 0x1000>;
 			interrupts = <0 53 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "ipg";
 			status = "disabled";
 		};
@@ -733,7 +752,8 @@
 			compatible = "fsl,ls1043a-wdt", "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
 			interrupts = <0 83 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "wdog";
 			big-endian;
 		};
@@ -750,8 +770,10 @@
 			dma-channels = <32>;
 			big-endian;
 			clock-names = "dmamux0", "dmamux1";
-			clocks = <&clockgen 4 0>,
-				 <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 		};
 
 		usb0: usb@2f00000 {
@@ -793,7 +815,8 @@
 				<0x0 0x20140520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <0 69 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			dma-coherent;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
index 4338db14c5da..ae1c2abaaf36 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
@@ -6,6 +6,8 @@
  *
  */
 
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
+
 fman0: fman@1a00000 {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -15,7 +17,7 @@ fman0: fman@1a00000 {
 	reg = <0x0 0x1a00000 0x0 0xfe000>;
 	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clockgen 3 0>;
+	clocks = <&clockgen QORIQ_CLK_FMAN 0>;
 	clock-names = "fmanclk";
 	fsl,qman-channel-range = <0x800 0x10>;
 	ptimer-handle = <&ptp_timer0>;
@@ -81,6 +83,6 @@ ptp_timer0: ptp-timer@1afe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x0 0x1afe000 0x0 0x1000>;
 	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clockgen 3 0>;
+	clocks = <&clockgen QORIQ_CLK_FMAN 0>;
 	fsl,extts-fifo;
 };
-- 
2.20.1

