Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC53D28AE25
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgJLGNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:13:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727255AbgJLGMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:12:50 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ECE7F3E397944D9E8192;
        Mon, 12 Oct 2020 14:12:45 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 14:12:36 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 02/10] ARM: dts: hisilicon: fix errors detected by pl011.yaml
Date:   Mon, 12 Oct 2020 14:12:17 +0800
Message-ID: <20201012061225.1597-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201012061225.1597-1-thunder.leizhen@huawei.com>
References: <20201012061225.1597-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Change node name to match '^serial(@[0-9a-f,]+)*$'
2. Change clock-names to "uartclk", "apb_pclk". Both of them use the same
   clock.
3. Change pinctrl-names to "default", "sleep".

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/hi3519.dtsi       | 20 ++++++++++----------
 arch/arm/boot/dts/hi3620-hi4511.dts | 20 ++++++++++----------
 arch/arm/boot/dts/hi3620.dtsi       | 30 +++++++++++++++---------------
 arch/arm/boot/dts/hisi-x5hd2.dtsi   | 30 +++++++++++++++---------------
 4 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/arm/boot/dts/hi3519.dtsi b/arch/arm/boot/dts/hi3519.dtsi
index 410409a0ed66251..630753c0d704427 100644
--- a/arch/arm/boot/dts/hi3519.dtsi
+++ b/arch/arm/boot/dts/hi3519.dtsi
@@ -52,8 +52,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12100000 0x1000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg HI3519_UART0_CLK>;
-			clock-names = "apb_pclk";
+			clocks = <&crg HI3519_UART0_CLK>, <&crg HI3519_UART0_CLK>;
+			clock-names = "uartclk", "apb_pclk";
 			status = "disable";
 		};
 
@@ -61,8 +61,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12101000 0x1000>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg HI3519_UART1_CLK>;
-			clock-names = "apb_pclk";
+			clocks = <&crg HI3519_UART1_CLK>, <&crg HI3519_UART1_CLK>;
+			clock-names = "uartclk", "apb_pclk";
 			status = "disable";
 		};
 
@@ -70,8 +70,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12102000 0x1000>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg HI3519_UART2_CLK>;
-			clock-names = "apb_pclk";
+			clocks = <&crg HI3519_UART2_CLK>, <&crg HI3519_UART2_CLK>;
+			clock-names = "uartclk", "apb_pclk";
 			status = "disable";
 		};
 
@@ -79,8 +79,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12103000 0x1000>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg HI3519_UART3_CLK>;
-			clock-names = "apb_pclk";
+			clocks = <&crg HI3519_UART3_CLK>, <&crg HI3519_UART3_CLK>;
+			clock-names = "uartclk", "apb_pclk";
 			status = "disable";
 		};
 
@@ -88,8 +88,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12104000 0x1000>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&crg HI3519_UART4_CLK>;
-			clock-names = "apb_pclk";
+			clocks = <&crg HI3519_UART4_CLK>, <&crg HI3519_UART4_CLK>;
+			clock-names = "uartclk", "apb_pclk";
 			status = "disable";
 		};
 
diff --git a/arch/arm/boot/dts/hi3620-hi4511.dts b/arch/arm/boot/dts/hi3620-hi4511.dts
index 8c703c3f2fe09b7..1c62bdcca647a9a 100644
--- a/arch/arm/boot/dts/hi3620-hi4511.dts
+++ b/arch/arm/boot/dts/hi3620-hi4511.dts
@@ -27,36 +27,36 @@
 			status = "ok";
 		};
 
-		uart0: uart@b00000 {	/* console */
-			pinctrl-names = "default", "idle";
+		uart0: serial@b00000 {	/* console */
+			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart0_pmx_func &uart0_cfg_func>;
 			pinctrl-1 = <&uart0_pmx_idle &uart0_cfg_idle>;
 			status = "ok";
 		};
 
-		uart1: uart@b01000 { /* modem */
-			pinctrl-names = "default", "idle";
+		uart1: serial@b01000 { /* modem */
+			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func>;
 			pinctrl-1 = <&uart1_pmx_idle &uart1_cfg_idle>;
 			status = "ok";
 		};
 
-		uart2: uart@b02000 { /* audience */
-			pinctrl-names = "default", "idle";
+		uart2: serial@b02000 { /* audience */
+			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart2_pmx_func &uart2_cfg_func>;
 			pinctrl-1 = <&uart2_pmx_idle &uart2_cfg_idle>;
 			status = "ok";
 		};
 
-		uart3: uart@b03000 {
-			pinctrl-names = "default", "idle";
+		uart3: serial@b03000 {
+			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart3_pmx_func &uart3_cfg_func>;
 			pinctrl-1 = <&uart3_pmx_idle &uart3_cfg_idle>;
 			status = "ok";
 		};
 
-		uart4: uart@b04000 {
-			pinctrl-names = "default", "idle";
+		uart4: serial@b04000 {
+			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart4_pmx_func &uart4_cfg_func>;
 			pinctrl-1 = <&uart4_pmx_idle &uart4_cfg_func>;
 			status = "ok";
diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
index f683440ee5694b4..d41378391e4cc36 100644
--- a/arch/arm/boot/dts/hi3620.dtsi
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -172,48 +172,48 @@
 			interrupts = <1 13 0xf01>;
 		};
 
-		uart0: uart@b00000 {
+		uart0: serial@b00000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xb00000 0x1000>;
 			interrupts = <0 20 4>;
-			clocks = <&clock HI3620_UARTCLK0>;
-			clock-names = "apb_pclk";
+			clocks = <&clock HI3620_UARTCLK0>, <&clock HI3620_UARTCLK0>;
+			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
 
-		uart1: uart@b01000 {
+		uart1: serial@b01000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xb01000 0x1000>;
 			interrupts = <0 21 4>;
-			clocks = <&clock HI3620_UARTCLK1>;
-			clock-names = "apb_pclk";
+			clocks = <&clock HI3620_UARTCLK1>, <&clock HI3620_UARTCLK1>;
+			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
 
-		uart2: uart@b02000 {
+		uart2: serial@b02000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xb02000 0x1000>;
 			interrupts = <0 22 4>;
-			clocks = <&clock HI3620_UARTCLK2>;
-			clock-names = "apb_pclk";
+			clocks = <&clock HI3620_UARTCLK2>, <&clock HI3620_UARTCLK2>;
+			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
 
-		uart3: uart@b03000 {
+		uart3: serial@b03000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xb03000 0x1000>;
 			interrupts = <0 23 4>;
-			clocks = <&clock HI3620_UARTCLK3>;
-			clock-names = "apb_pclk";
+			clocks = <&clock HI3620_UARTCLK3>, <&clock HI3620_UARTCLK3>;
+			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
 
-		uart4: uart@b04000 {
+		uart4: serial@b04000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xb04000 0x1000>;
 			interrupts = <0 24 4>;
-			clocks = <&clock HI3620_UARTCLK4>;
-			clock-names = "apb_pclk";
+			clocks = <&clock HI3620_UARTCLK4>, <&clock HI3620_UARTCLK4>;
+			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index e2dbf1d8a67bae2..f645487402f6e86 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -86,48 +86,48 @@
 				status = "disabled";
 			};
 
-			uart0: uart@b00000 {
+			uart0: serial@b00000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x00b00000 0x1000>;
 				interrupts = <0 49 4>;
-				clocks = <&clock HIX5HD2_FIXED_83M>;
-				clock-names = "apb_pclk";
+				clocks = <&clock HIX5HD2_FIXED_83M>, <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "uartclk", "apb_pclk";
 				status = "disabled";
 			};
 
-			uart1: uart@6000 {
+			uart1: serial@6000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x00006000 0x1000>;
 				interrupts = <0 50 4>;
-				clocks = <&clock HIX5HD2_FIXED_83M>;
-				clock-names = "apb_pclk";
+				clocks = <&clock HIX5HD2_FIXED_83M>, <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "uartclk", "apb_pclk";
 				status = "disabled";
 			};
 
-			uart2: uart@b02000 {
+			uart2: serial@b02000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x00b02000 0x1000>;
 				interrupts = <0 51 4>;
-				clocks = <&clock HIX5HD2_FIXED_83M>;
-				clock-names = "apb_pclk";
+				clocks = <&clock HIX5HD2_FIXED_83M>, <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "uartclk", "apb_pclk";
 				status = "disabled";
 			};
 
-			uart3: uart@b03000 {
+			uart3: serial@b03000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x00b03000 0x1000>;
 				interrupts = <0 52 4>;
-				clocks = <&clock HIX5HD2_FIXED_83M>;
-				clock-names = "apb_pclk";
+				clocks = <&clock HIX5HD2_FIXED_83M>, <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "uartclk", "apb_pclk";
 				status = "disabled";
 			};
 
-			uart4: uart@b04000 {
+			uart4: serial@b04000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0xb04000 0x1000>;
 				interrupts = <0 53 4>;
-				clocks = <&clock HIX5HD2_FIXED_83M>;
-				clock-names = "apb_pclk";
+				clocks = <&clock HIX5HD2_FIXED_83M>, <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "uartclk", "apb_pclk";
 				status = "disabled";
 			};
 
-- 
1.8.3


