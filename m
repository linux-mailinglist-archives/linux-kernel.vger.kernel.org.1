Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B062E7014
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgL2Lsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgL2Lsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:48:32 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A77C061793;
        Tue, 29 Dec 2020 03:47:51 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EEEFE23E43;
        Tue, 29 Dec 2020 12:47:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1609242468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQlqGoKr6Wm+yz109aeAsjU1p/cV+CZQBcKrzaqo7gs=;
        b=JJv1uN3oBCVuJBb/IHRGCrbn/QKJzysHLM3AfJBmik1KBRAeWPTq/U4fjvXMp+ULisA7/K
        5+lsdouTucoQJueIqUOTEAogbx0QgD0XghgdJRS/Favt/tcTcj8ubk6fmeb50FR4I8g4rH
        Z7UdRA1ELtO/SER43Qvs55l03zRSeVo=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/7] arm64: dts: ls1012a: use constants in the clockgen phandle
Date:   Tue, 29 Dec 2020 12:47:34 +0100
Message-Id: <20201229114740.7936-2-michael@walle.cc>
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
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 60 +++++++++++++------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 626b709d1fb9..7de6b376d792 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -7,6 +7,7 @@
  *
  */
 
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -34,7 +35,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			#cooling-cells = <2>;
 			cpu-idle-states = <&CPU_PH20>;
 		};
@@ -148,7 +149,10 @@
 			reg-names = "QuadSPI", "QuadSPI-memory";
 			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "qspi_en", "qspi";
-			clocks = <&clockgen 4 0>, <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			status = "disabled";
 		};
 
@@ -156,7 +160,8 @@
 			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <0 62 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			big-endian;
@@ -174,7 +179,8 @@
 			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1580000 0x0 0x10000>;
 			interrupts = <0 65 0x4>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			big-endian;
@@ -341,7 +347,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2180000 0x0 0x10000>;
 			interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -351,7 +358,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			status = "disabled";
 		};
 
@@ -362,7 +370,8 @@
 			reg = <0x0 0x2100000 0x0 0x10000>;
 			interrupts = <0 64 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			spi-num-chipselects = <5>;
 			big-endian;
 			status = "disabled";
@@ -372,7 +381,8 @@
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0500 0x0 0x100>;
 			interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			status = "disabled";
 		};
 
@@ -380,7 +390,8 @@
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0600 0x0 0x100>;
 			interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			status = "disabled";
 		};
 
@@ -409,7 +420,7 @@
 				     "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
 			interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(1)>;
 			big-endian;
 		};
 
@@ -418,8 +429,14 @@
 			compatible = "fsl,vf610-sai";
 			reg = <0x0 0x2b50000 0x0 0x10000>;
 			interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>,
-				 <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 47>,
@@ -432,8 +449,14 @@
 			compatible = "fsl,vf610-sai";
 			reg = <0x0 0x2b60000 0x0 0x10000>;
 			interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>,
-				 <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
 			dma-names = "tx", "rx";
 			dmas = <&edma0 1 45>,
@@ -453,8 +476,10 @@
 			dma-channels = <32>;
 			big-endian;
 			clock-names = "dmamux0", "dmamux1";
-			clocks = <&clockgen 4 3>,
-				 <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 		};
 
 		usb0: usb@2f00000 {
@@ -473,7 +498,8 @@
 				<0x0 0x20140520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 0>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			dma-coherent;
 			status = "disabled";
 		};
-- 
2.20.1

