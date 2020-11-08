Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC02AAD0C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgKHSv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbgKHSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:51:29 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6964BC0613CF;
        Sun,  8 Nov 2020 10:51:28 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5C0B923E68;
        Sun,  8 Nov 2020 19:51:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604861486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9r+hSbCyw+GjDVQte0+X46Vug4rXOMmeV2Ud5/J7b6o=;
        b=mrcWh0K4maXDHccmQBkcvJG5pSIN6UeowC2+azrPSJoTvYjAdn8YTt+pwNByOyOxVLmPKw
        8thjHGiS/gxj69irqqa/CRGrG8QQ0B+zS2/fs0uXzwhwCd0BbLqTNBOfpjXHgGDYFAT4h/
        hwomcivNnVtF9ZB9vs937p2MUoYUuAQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "Y . b . Lu" <yangbo.lu@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 4/9] arm64: dts: ls1028a: use constants in the clockgen phandle
Date:   Sun,  8 Nov 2020 19:51:08 +0100
Message-Id: <20201108185113.31377-5-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108185113.31377-1-michael@walle.cc>
References: <20201108185113.31377-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have constants, use them. This is just a mechanical change.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v2:
 - new patch

 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 162 +++++++++++++-----
 1 file changed, 116 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 2f60a6ba7e14..055da2c710c3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -8,6 +8,7 @@
  *
  */
 
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -32,7 +33,7 @@
 			compatible = "arm,cortex-a72";
 			reg = <0x0>;
 			enable-method = "psci";
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PW20>;
 			#cooling-cells = <2>;
@@ -43,7 +44,7 @@
 			compatible = "arm,cortex-a72";
 			reg = <0x1>;
 			enable-method = "psci";
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PW20>;
 			#cooling-cells = <2>;
@@ -236,7 +237,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2000000 0x0 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -246,7 +248,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2010000 0x0 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -256,7 +259,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2020000 0x0 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -266,7 +270,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2030000 0x0 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -276,7 +281,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2040000 0x0 0x10000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -286,7 +292,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2050000 0x0 0x10000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -296,7 +303,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2060000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -306,7 +314,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2070000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -318,7 +327,8 @@
 			      <0x0 0x20000000 0x0 0x10000000>;
 			reg-names = "fspi_base", "fspi_mmap";
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 2 0>, <&clockgen 2 0>;
+			clocks = <&clockgen QORIQ_CLK_HWACCEL 0>,
+				 <&clockgen QORIQ_CLK_HWACCEL 0>;
 			clock-names = "fspi_en", "fspi";
 			status = "disabled";
 		};
@@ -330,7 +340,8 @@
 			reg = <0x0 0x2100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			dmas = <&edma0 0 62>, <&edma0 0 60>;
 			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
@@ -345,7 +356,8 @@
 			reg = <0x0 0x2110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			dmas = <&edma0 0 58>, <&edma0 0 56>;
 			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
@@ -360,7 +372,8 @@
 			reg = <0x0 0x2120000 0x0 0x10000>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			dmas = <&edma0 0 54>, <&edma0 0 2>;
 			dma-names = "tx", "rx";
 			spi-num-chipselects = <3>;
@@ -373,7 +386,7 @@
 			reg = <0x0 0x2140000 0x0 0x10000>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <0>; /* fixed up by bootloader */
-			clocks = <&clockgen 2 1>;
+			clocks = <&clockgen QORIQ_CLK_HWACCEL 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			little-endian;
@@ -386,7 +399,7 @@
 			reg = <0x0 0x2150000 0x0 0x10000>;
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <0>; /* fixed up by bootloader */
-			clocks = <&clockgen 2 1>;
+			clocks = <&clockgen QORIQ_CLK_HWACCEL 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			broken-cd;
@@ -399,7 +412,8 @@
 			compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan";
 			reg = <0x0 0x2180000 0x0 0x10000>;
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sysclk>, <&clockgen 4 1>;
+			clocks = <&sysclk>, <&clockgen QORIQ_CLK_PLATFORM_PLL
+						       QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg", "per";
 			status = "disabled";
 		};
@@ -408,7 +422,8 @@
 			compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan";
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sysclk>, <&clockgen 4 1>;
+			clocks = <&sysclk>, <&clockgen QORIQ_CLK_PLATFORM_PLL
+						       QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg", "per";
 			status = "disabled";
 		};
@@ -417,7 +432,8 @@
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0500 0x0 0x100>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -425,7 +441,8 @@
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0600 0x0 0x100>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -434,7 +451,8 @@
 			compatible = "fsl,ls1028a-lpuart";
 			reg = <0x0 0x2260000 0x0 0x1000>;
 			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			dma-names = "rx","tx";
 			dmas = <&edma0 1 32>,
@@ -446,7 +464,8 @@
 			compatible = "fsl,ls1028a-lpuart";
 			reg = <0x0 0x2270000 0x0 0x1000>;
 			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			dma-names = "rx","tx";
 			dmas = <&edma0 1 30>,
@@ -458,7 +477,8 @@
 			compatible = "fsl,ls1028a-lpuart";
 			reg = <0x0 0x2280000 0x0 0x1000>;
 			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			dma-names = "rx","tx";
 			dmas = <&edma0 1 28>,
@@ -470,7 +490,8 @@
 			compatible = "fsl,ls1028a-lpuart";
 			reg = <0x0 0x2290000 0x0 0x1000>;
 			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			dma-names = "rx","tx";
 			dmas = <&edma0 1 26>,
@@ -482,7 +503,8 @@
 			compatible = "fsl,ls1028a-lpuart";
 			reg = <0x0 0x22a0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			dma-names = "rx","tx";
 			dmas = <&edma0 1 24>,
@@ -494,7 +516,8 @@
 			compatible = "fsl,ls1028a-lpuart";
 			reg = <0x0 0x22b0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			dma-names = "rx","tx";
 			dmas = <&edma0 1 22>,
@@ -513,8 +536,10 @@
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
@@ -576,7 +601,8 @@
 				<0x7 0x100520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -748,14 +774,20 @@
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
 
@@ -764,8 +796,14 @@
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
@@ -779,8 +817,14 @@
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
@@ -794,8 +838,14 @@
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
@@ -809,8 +859,14 @@
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
@@ -824,8 +880,14 @@
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
@@ -839,8 +901,14 @@
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

