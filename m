Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330482E702C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgL2Lt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgL2Lsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:48:32 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EF9C061796;
        Tue, 29 Dec 2020 03:47:52 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0E0D123E45;
        Tue, 29 Dec 2020 12:47:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1609242470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ge3TkUDyygznB7/weZssaf8RZXKW7suoIvOd4GMkabQ=;
        b=j0dvsrc4eKNKmsRepG5vJOXQMW1IqcdvZsvFVvYEDFEC/3UpU8K1nz5718Za88pSxbjl/0
        dOYhj+OpEnTbMo9uabDozrQ+dZDJ5U41AXvHt1LGb2fU92pEpRdHmyw/rGVSNFXYzWtf00
        BAX8KAIz2HJw+mCHmYvfPOxbPoZcwIk=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/7] arm64: dts: ls1028a: use constants in the clockgen phandle
Date:   Tue, 29 Dec 2020 12:47:35 +0100
Message-Id: <20201229114740.7936-3-michael@walle.cc>
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
 .../fsl-ls1028a-kontron-sl28-var3-ads2.dts    |   5 +-
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 162 +++++++++++++-----
 2 files changed, 120 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
index c45d7b40e374..ed4e69e87e30 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
@@ -8,6 +8,8 @@
  */
 
 /dts-v1/;
+
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include "fsl-ls1028a-kontron-sl28.dts"
 
 / {
@@ -120,7 +122,8 @@
 	mclk: clock-mclk@f130080 {
 		compatible = "fsl,vf610-sai-clock";
 		reg = <0x0 0xf130080 0x0 0x80>;
-		clocks = <&clockgen 4 1>;
+		clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+				    QORIQ_CLK_PLL_DIV(2)>;
 		#clock-cells = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 5872ccb3772a..0c05aa8a998c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -8,6 +8,7 @@
  *
  */
 
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -30,7 +31,7 @@
 			compatible = "arm,cortex-a72";
 			reg = <0x0>;
 			enable-method = "psci";
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PW20>;
 			#cooling-cells = <2>;
@@ -41,7 +42,7 @@
 			compatible = "arm,cortex-a72";
 			reg = <0x1>;
 			enable-method = "psci";
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PW20>;
 			#cooling-cells = <2>;
@@ -235,7 +236,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2000000 0x0 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -245,7 +247,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2010000 0x0 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -255,7 +258,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2020000 0x0 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -265,7 +269,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2030000 0x0 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -275,7 +280,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2040000 0x0 0x10000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -285,7 +291,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2050000 0x0 0x10000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -295,7 +302,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2060000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -305,7 +313,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2070000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -317,7 +326,8 @@
 			      <0x0 0x20000000 0x0 0x10000000>;
 			reg-names = "fspi_base", "fspi_mmap";
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 2 0>, <&clockgen 2 0>;
+			clocks = <&clockgen QORIQ_CLK_HWACCEL 0>,
+				 <&clockgen QORIQ_CLK_HWACCEL 0>;
 			clock-names = "fspi_en", "fspi";
 			status = "disabled";
 		};
@@ -329,7 +339,8 @@
 			reg = <0x0 0x2100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			dmas = <&edma0 0 62>, <&edma0 0 60>;
 			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
@@ -344,7 +355,8 @@
 			reg = <0x0 0x2110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			dmas = <&edma0 0 58>, <&edma0 0 56>;
 			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
@@ -359,7 +371,8 @@
 			reg = <0x0 0x2120000 0x0 0x10000>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			dmas = <&edma0 0 54>, <&edma0 0 2>;
 			dma-names = "tx", "rx";
 			spi-num-chipselects = <3>;
@@ -372,7 +385,7 @@
 			reg = <0x0 0x2140000 0x0 0x10000>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <0>; /* fixed up by bootloader */
-			clocks = <&clockgen 2 1>;
+			clocks = <&clockgen QORIQ_CLK_HWACCEL 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			little-endian;
@@ -385,7 +398,7 @@
 			reg = <0x0 0x2150000 0x0 0x10000>;
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <0>; /* fixed up by bootloader */
-			clocks = <&clockgen 2 1>;
+			clocks = <&clockgen QORIQ_CLK_HWACCEL 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			broken-cd;
@@ -398,7 +411,8 @@
 			compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan";
 			reg = <0x0 0x2180000 0x0 0x10000>;
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sysclk>, <&clockgen 4 1>;
+			clocks = <&sysclk>, <&clockgen QORIQ_CLK_PLATFORM_PLL
+						       QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg", "per";
 			status = "disabled";
 		};
@@ -407,7 +421,8 @@
 			compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan";
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sysclk>, <&clockgen 4 1>;
+			clocks = <&sysclk>, <&clockgen QORIQ_CLK_PLATFORM_PLL
+						       QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg", "per";
 			status = "disabled";
 		};
@@ -416,7 +431,8 @@
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0500 0x0 0x100>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -424,7 +440,8 @@
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0600 0x0 0x100>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -433,7 +450,8 @@
 			compatible = "fsl,ls1028a-lpuart";
 			reg = <0x0 0x2260000 0x0 0x1000>;
 			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			dma-names = "rx","tx";
 			dmas = <&edma0 1 32>,
@@ -445,7 +463,8 @@
 			compatible = "fsl,ls1028a-lpuart";
 			reg = <0x0 0x2270000 0x0 0x1000>;
 			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			dma-names = "rx","tx";
 			dmas = <&edma0 1 30>,
@@ -457,7 +476,8 @@
 			compatible = "fsl,ls1028a-lpuart";
 			reg = <0x0 0x2280000 0x0 0x1000>;
 			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			dma-names = "rx","tx";
 			dmas = <&edma0 1 28>,
@@ -469,7 +489,8 @@
 			compatible = "fsl,ls1028a-lpuart";
 			reg = <0x0 0x2290000 0x0 0x1000>;
 			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			dma-names = "rx","tx";
 			dmas = <&edma0 1 26>,
@@ -481,7 +502,8 @@
 			compatible = "fsl,ls1028a-lpuart";
 			reg = <0x0 0x22a0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			dma-names = "rx","tx";
 			dmas = <&edma0 1 24>,
@@ -493,7 +515,8 @@
 			compatible = "fsl,ls1028a-lpuart";
 			reg = <0x0 0x22b0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			dma-names = "rx","tx";
 			dmas = <&edma0 1 22>,
@@ -512,8 +535,10 @@
 			interrupt-names = "edma-tx", "edma-err";
 			dma-channels = <32>;
 			clock-names = "dmamux0", "dmamux1";
-			clocks = <&clockgen 4 1>,
-				 <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 		};
 
 		gpio1: gpio@2300000 {
@@ -575,7 +600,8 @@
 				<0x7 0x100520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -747,14 +773,20 @@
 		cluster1_core0_watchdog: watchdog@c000000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
-			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster1_core1_watchdog: watchdog@c010000 {
 			compatible = "arm,sp805", "arm,primecell";
 			reg = <0x0 0xc010000 0x0 0x1000>;
-			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
@@ -763,8 +795,14 @@
 			compatible = "fsl,vf610-sai";
 			reg = <0x0 0xf100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&clockgen 4 1>, <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 4>,
@@ -778,8 +816,14 @@
 			compatible = "fsl,vf610-sai";
 			reg = <0x0 0xf110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&clockgen 4 1>, <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 6>,
@@ -793,8 +837,14 @@
 			compatible = "fsl,vf610-sai";
 			reg = <0x0 0xf120000 0x0 0x10000>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&clockgen 4 1>, <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 8>,
@@ -808,8 +858,14 @@
 			compatible = "fsl,vf610-sai";
 			reg = <0x0 0xf130000 0x0 0x10000>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&clockgen 4 1>, <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 10>,
@@ -823,8 +879,14 @@
 			compatible = "fsl,vf610-sai";
 			reg = <0x0 0xf140000 0x0 0x10000>;
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&clockgen 4 1>, <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 12>,
@@ -838,8 +900,14 @@
 			compatible = "fsl,vf610-sai";
 			reg = <0x0 0xf150000 0x0 0x10000>;
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
-				 <&clockgen 4 1>, <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 14>,
@@ -961,7 +1029,7 @@
 			ethernet@0,4 {
 				compatible = "fsl,enetc-ptp";
 				reg = <0x000400 0 0 0 0>;
-				clocks = <&clockgen 2 3>;
+				clocks = <&clockgen QORIQ_CLK_HWACCEL 3>;
 				little-endian;
 				fsl,extts-fifo;
 			};
@@ -1056,8 +1124,10 @@
 		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 223 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "DE", "SE";
-		clocks = <&dpclk>, <&clockgen 2 2>, <&clockgen 2 2>,
-			 <&clockgen 2 2>;
+		clocks = <&dpclk>,
+			 <&clockgen QORIQ_CLK_HWACCEL 2>,
+			 <&clockgen QORIQ_CLK_HWACCEL 2>,
+			 <&clockgen QORIQ_CLK_HWACCEL 2>;
 		clock-names = "pxlclk", "mclk", "aclk", "pclk";
 		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
 		arm,malidp-arqos-value = <0xd000d000>;
-- 
2.20.1

