Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E23A2E7015
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgL2Lsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:48:40 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:36173 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgL2Lsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:48:37 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2259523E63;
        Tue, 29 Dec 2020 12:47:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1609242474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FOmKeCjYomUUA6VaUP8Rbhpromvfdll+dp4HcVM/W78=;
        b=qD3jFqKERK670FbKBkfLhLb8/1JJF7d9G7/18B6LfRPmmOxcmdKXITkjJwwsaCWS2Vzv60
        HyXfh3IfM3ZIKI6i+43j8opEh6NSoKYKdCOUMmFFzmEC6v5K17tVmSj+BlQts1nyqaVT/g
        sg/eLLmkBXa2z7sTsxB5ILmUhobb71Q=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 7/7] arm64: dts: lx2160a: use constants in the clockgen phandle
Date:   Tue, 29 Dec 2020 12:47:40 +0100
Message-Id: <20201229114740.7936-8-michael@walle.cc>
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
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 92 ++++++++++++-------
 1 file changed, 57 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 197397777c83..b16e7f738f52 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -4,6 +4,7 @@
 //
 // Copyright 2018-2020 NXP
 
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -30,7 +31,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x0>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -47,7 +48,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x1>;
-			clocks = <&clockgen 1 0>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 0>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -64,7 +65,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x100>;
-			clocks = <&clockgen 1 1>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 1>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -81,7 +82,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x101>;
-			clocks = <&clockgen 1 1>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 1>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -98,7 +99,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x200>;
-			clocks = <&clockgen 1 2>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 2>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -115,7 +116,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x201>;
-			clocks = <&clockgen 1 2>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 2>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -132,7 +133,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x300>;
-			clocks = <&clockgen 1 3>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 3>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -149,7 +150,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x301>;
-			clocks = <&clockgen 1 3>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 3>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -166,7 +167,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x400>;
-			clocks = <&clockgen 1 4>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 4>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -183,7 +184,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x401>;
-			clocks = <&clockgen 1 4>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 4>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -200,7 +201,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x500>;
-			clocks = <&clockgen 1 5>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 5>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -217,7 +218,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x501>;
-			clocks = <&clockgen 1 5>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 5>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -234,7 +235,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x600>;
-			clocks = <&clockgen 1 6>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 6>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -251,7 +252,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x601>;
-			clocks = <&clockgen 1 6>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 6>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -268,7 +269,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x700>;
-			clocks = <&clockgen 1 7>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 7>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -285,7 +286,7 @@
 			compatible = "arm,cortex-a72";
 			enable-method = "psci";
 			reg = <0x701>;
-			clocks = <&clockgen 1 7>;
+			clocks = <&clockgen QORIQ_CLK_CMUX 7>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
@@ -685,7 +686,8 @@
 			reg = <0x0 0x2000000 0x0 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			scl-gpio = <&gpio2 15 GPIO_ACTIVE_HIGH>;
 			status = "disabled";
 		};
@@ -697,7 +699,8 @@
 			reg = <0x0 0x2010000 0x0 0x10000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			status = "disabled";
 		};
 
@@ -708,7 +711,8 @@
 			reg = <0x0 0x2020000 0x0 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			status = "disabled";
 		};
 
@@ -719,7 +723,8 @@
 			reg = <0x0 0x2030000 0x0 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			status = "disabled";
 		};
 
@@ -730,7 +735,8 @@
 			reg = <0x0 0x2040000 0x0 0x10000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			scl-gpio = <&gpio2 16 GPIO_ACTIVE_HIGH>;
 			status = "disabled";
 		};
@@ -742,7 +748,8 @@
 			reg = <0x0 0x2050000 0x0 0x10000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			status = "disabled";
 		};
 
@@ -753,7 +760,8 @@
 			reg = <0x0 0x2060000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			status = "disabled";
 		};
 
@@ -764,7 +772,8 @@
 			reg = <0x0 0x2070000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
-			clocks = <&clockgen 4 15>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(16)>;
 			status = "disabled";
 		};
 
@@ -776,7 +785,10 @@
 			      <0x0 0x20000000 0x0 0x10000000>;
 			reg-names = "fspi_base", "fspi_mmap";
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			clock-names = "fspi_en", "fspi";
 			status = "disabled";
 		};
@@ -787,7 +799,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>;
 			clock-names = "dspi";
 			spi-num-chipselects = <5>;
 			bus-num = <0>;
@@ -800,7 +813,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>;
 			clock-names = "dspi";
 			spi-num-chipselects = <5>;
 			bus-num = <1>;
@@ -813,7 +827,8 @@
 			#size-cells = <0>;
 			reg = <0x0 0x2120000 0x0 0x10000>;
 			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 7>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>;
 			clock-names = "dspi";
 			spi-num-chipselects = <5>;
 			bus-num = <2>;
@@ -824,7 +839,8 @@
 			compatible = "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
 			interrupts = <0 28 0x4>; /* Level high type */
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			dma-coherent;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
@@ -837,7 +853,8 @@
 			compatible = "fsl,esdhc";
 			reg = <0x0 0x2150000 0x0 0x10000>;
 			interrupts = <0 63 0x4>; /* Level high type */
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			dma-coherent;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
@@ -973,7 +990,8 @@
 			      <0x7 0x100520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			dma-coherent;
 			status = "disabled";
 		};
@@ -984,7 +1002,8 @@
 			      <0x7 0x100520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			dma-coherent;
 			status = "disabled";
 		};
@@ -995,7 +1014,8 @@
 			      <0x7 0x100520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			dma-coherent;
 			status = "disabled";
 		};
@@ -1006,7 +1026,8 @@
 			      <0x7 0x100520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
 			dma-coherent;
 			status = "disabled";
 		};
@@ -1279,7 +1300,8 @@
 		ptp-timer@8b95000 {
 			compatible = "fsl,dpaa2-ptp";
 			reg = <0x0 0x8b95000 0x0 0x100>;
-			clocks = <&clockgen 4 1>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			little-endian;
 			fsl,extts-fifo;
 		};
-- 
2.20.1

