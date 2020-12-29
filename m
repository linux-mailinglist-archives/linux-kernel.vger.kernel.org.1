Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844BE2E7013
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgL2Lsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2Lse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:48:34 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE9C061798;
        Tue, 29 Dec 2020 03:47:53 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D816823E59;
        Tue, 29 Dec 2020 12:47:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1609242472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ld+A0HhuA3C8Ww4lOY/hMzuwgXH7hjyMJ90SgxZ0JfQ=;
        b=Tyv7buTDP/cTQUoICHn+ZkT5CrMrEDQWPXpfFYl9IjCqXUvXhRb/zThXi5KteuYOAM7TqW
        Jb8DLeElt18KtFyutdmDCyMMsKd2GKRVAdxWeg0dp6BTmHsToGnTQ48xgME5wekMTOIvtC
        AcblEDn6s4XBwTp8nO5vtHh6Ttv81DM=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 4/7] arm64: dts: ls1046a: use constants in the clockgen phandle
Date:   Tue, 29 Dec 2020 12:47:37 +0100
Message-Id: <20201229114740.7936-5-michael@walle.cc>
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
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 73 ++++++++++++-------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 025e1f587662..bfad3efafda2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -8,6 +8,7 @@
  * Mingkai Hu <mingkai.hu@nxp.com>
  */
 
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -39,7 +40,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x0>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
@@ -49,7 +50,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x1>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
@@ -59,7 +60,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x2>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
@@ -69,7 +70,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x3>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_PH20>;
 			#cooling-cells = <2>;
@@ -295,7 +296,10 @@
 			reg-names = "QuadSPI", "QuadSPI-memory";
 			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "qspi_en", "qspi";
-			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -303,7 +307,7 @@
 			compatible = "fsl,ls1046a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 2 1>;
+			clocks = <&clockgen QORIQ_CLK_HWACCEL 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			big-endian;
@@ -454,7 +458,8 @@
 			reg = <0x0 0x2100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			spi-num-chipselects = <5>;
 			big-endian;
 			status = "disabled";
@@ -466,7 +471,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2180000 0x0 0x10000>;
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			dmas = <&edma0 1 39>,
 			       <&edma0 1 38>;
 			dma-names = "tx", "rx";
@@ -479,7 +485,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -489,7 +496,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x21a0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -499,7 +507,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x21b0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -507,7 +516,8 @@
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0500 0x0 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -515,7 +525,8 @@
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0600 0x0 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -523,7 +534,8 @@
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21d0500 0x0 0x100>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -531,7 +543,8 @@
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21d0600 0x0 0x100>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -579,7 +592,8 @@
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2950000 0x0 0x1000>;
 			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			clock-names = "ipg";
 			status = "disabled";
 		};
@@ -588,7 +602,8 @@
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2960000 0x0 0x1000>;
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			status = "disabled";
 		};
@@ -597,7 +612,8 @@
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2970000 0x0 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			status = "disabled";
 		};
@@ -606,7 +622,8 @@
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2980000 0x0 0x1000>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			status = "disabled";
 		};
@@ -615,7 +632,8 @@
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x2990000 0x0 0x1000>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			status = "disabled";
 		};
@@ -624,7 +642,8 @@
 			compatible = "fsl,ls1021a-lpuart";
 			reg = <0x0 0x29a0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg";
 			status = "disabled";
 		};
@@ -633,7 +652,8 @@
 			compatible = "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			big-endian;
 		};
 
@@ -649,8 +669,10 @@
 			dma-channels = <32>;
 			big-endian;
 			clock-names = "dmamux0", "dmamux1";
-			clocks = <&clockgen 4 1>,
-				 <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 		};
 
 		usb0: usb@2f00000 {
@@ -689,7 +711,8 @@
 				<0x0 0x20140520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 		};
 
 		msi1: msi-controller@1580000 {
-- 
2.20.1

