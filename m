Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D8286C7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 03:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgJHBwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 21:52:07 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:10440 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbgJHBwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 21:52:03 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0981VMiY057072;
        Thu, 8 Oct 2020 09:31:22 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Oct
 2020 09:51:11 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 2/2] Arm: dts: aspeed-g6: Add sgpio node and pinctrl setting
Date:   Thu, 8 Oct 2020 09:51:06 +0800
Message-ID: <20201008015106.3198-3-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008015106.3198-1-billy_tsai@aspeedtech.com>
References: <20201008015106.3198-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0981VMiY057072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to add sgpiom and sgpios nodes and add pinctrl setting
for sgpiom1

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   |  5 ++
 arch/arm/boot/dts/aspeed-g6.dtsi           | 53 ++++++++++++++++++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 30 ++++++++++--
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
index 7028e21bdd98..a16ecf08e307 100644
--- a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
@@ -862,6 +862,11 @@
 		groups = "SGPM1";
 	};
 
+	pinctrl_sgpm2_default: sgpm2_default {
+		function = "SGPM2";
+		groups = "SGPM2";
+	};
+
 	pinctrl_sgps1_default: sgps1_default {
 		function = "SGPS1";
 		groups = "SGPS1";
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index ad19dce038ea..bdbcb88763d5 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -366,6 +366,58 @@
 				#interrupt-cells = <2>;
 			};
 
+			sgpiom0: sgpiom@1e780500 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2600-sgpiom";
+				reg = <0x1e780500 0x100>;
+				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				ngpios = <128>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+				interrupt-controller;
+				bus-frequency = <12000000>;
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_sgpm1_default>;
+				status = "disabled";
+			};
+
+			sgpiom1: sgpiom@1e780600 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2600-sgpiom";
+				reg = <0x1e780600 0x100>;
+				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+				ngpios = <80>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+				interrupt-controller;
+				bus-frequency = <12000000>;
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_sgpm2_default>;
+				status = "disabled";
+			};
+
+			sgpios0: sgpios@1e780700 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2600-sgpios";
+				reg = <0x1e780700 0x40>;
+				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+				status = "disabled";
+			};
+
+			sgpios1: sgpios@1e780740 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2600-sgpios";
+				reg = <0x1e780740 0x40>;
+				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+				status = "disabled";
+			};
+
 			gpio1: gpio@1e780800 {
 				#gpio-cells = <2>;
 				gpio-controller;
@@ -377,6 +429,7 @@
 				clocks = <&syscon ASPEED_CLK_APB1>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				status = "disabled";
 			};
 
 			rtc: rtc@1e781000 {
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 34803a6c7664..b673a44ffa3b 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -46,8 +46,10 @@
 #define SCU620		0x620 /* Disable GPIO Internal Pull-Down #4 */
 #define SCU634		0x634 /* Disable GPIO Internal Pull-Down #5 */
 #define SCU638		0x638 /* Disable GPIO Internal Pull-Down #6 */
+#define SCU690		0x690 /* Multi-function Pin Control #24 */
 #define SCU694		0x694 /* Multi-function Pin Control #25 */
 #define SCU69C		0x69C /* Multi-function Pin Control #27 */
+#define SCU6D0		0x6D0 /* Multi-function Pin Control #28 */
 #define SCUC20		0xC20 /* PCIE configuration Setting Control */
 
 #define ASPEED_G6_NR_PINS 256
@@ -81,13 +83,21 @@ FUNC_GROUP_DECL(I2C12, L26, K24);
 #define K26 4
 SIG_EXPR_LIST_DECL_SESG(K26, MACLINK1, MACLINK1, SIG_DESC_SET(SCU410, 4));
 SIG_EXPR_LIST_DECL_SESG(K26, SCL13, I2C13, SIG_DESC_SET(SCU4B0, 4));
-PIN_DECL_2(K26, GPIOA4, MACLINK1, SCL13);
+/*SGPM2 is A1 Only */
+SIG_EXPR_LIST_DECL_SESG(K26, SGPM2CLK, SGPM2, SIG_DESC_SET(SCU6D0, 4),
+			  SIG_DESC_CLEAR(SCU410, 4), SIG_DESC_CLEAR(SCU4B0, 4),
+			  SIG_DESC_CLEAR(SCU690, 4));
+PIN_DECL_3(K26, GPIOA4, SGPM2CLK, MACLINK1, SCL13);
 FUNC_GROUP_DECL(MACLINK1, K26);
 
 #define L24 5
 SIG_EXPR_LIST_DECL_SESG(L24, MACLINK2, MACLINK2, SIG_DESC_SET(SCU410, 5));
 SIG_EXPR_LIST_DECL_SESG(L24, SDA13, I2C13, SIG_DESC_SET(SCU4B0, 5));
-PIN_DECL_2(L24, GPIOA5, MACLINK2, SDA13);
+/*SGPM2 is A1 Only */
+SIG_EXPR_LIST_DECL_SESG(L24, SGPM2LD, SGPM2, SIG_DESC_SET(SCU6D0, 5),
+			  SIG_DESC_CLEAR(SCU410, 5), SIG_DESC_CLEAR(SCU4B0, 5),
+			  SIG_DESC_CLEAR(SCU690, 5));
+PIN_DECL_3(L24, GPIOA5, SGPM2LD, MACLINK2, SDA13);
 FUNC_GROUP_DECL(MACLINK2, L24);
 
 FUNC_GROUP_DECL(I2C13, K26, L24);
@@ -95,16 +105,26 @@ FUNC_GROUP_DECL(I2C13, K26, L24);
 #define L23 6
 SIG_EXPR_LIST_DECL_SESG(L23, MACLINK3, MACLINK3, SIG_DESC_SET(SCU410, 6));
 SIG_EXPR_LIST_DECL_SESG(L23, SCL14, I2C14, SIG_DESC_SET(SCU4B0, 6));
-PIN_DECL_2(L23, GPIOA6, MACLINK3, SCL14);
+/*SGPM2 is A1 Only */
+SIG_EXPR_LIST_DECL_SESG(L23, SGPM2O, SGPM2, SIG_DESC_SET(SCU6D0, 6),
+			  SIG_DESC_CLEAR(SCU410, 6), SIG_DESC_CLEAR(SCU4B0, 6),
+			  SIG_DESC_CLEAR(SCU690, 6));
+PIN_DECL_3(L23, GPIOA6, SGPM2O, MACLINK3, SCL14);
 FUNC_GROUP_DECL(MACLINK3, L23);
 
 #define K25 7
 SIG_EXPR_LIST_DECL_SESG(K25, MACLINK4, MACLINK4, SIG_DESC_SET(SCU410, 7));
 SIG_EXPR_LIST_DECL_SESG(K25, SDA14, I2C14, SIG_DESC_SET(SCU4B0, 7));
-PIN_DECL_2(K25, GPIOA7, MACLINK4, SDA14);
+/*SGPM2 is A1 Only */
+SIG_EXPR_LIST_DECL_SESG(K25, SGPM2I, SGPM2, SIG_DESC_SET(SCU6D0, 7),
+			  SIG_DESC_CLEAR(SCU410, 7), SIG_DESC_CLEAR(SCU4B0, 7),
+			  SIG_DESC_CLEAR(SCU690, 7));
+PIN_DECL_3(K25, GPIOA7, SGPM2I, MACLINK4, SDA14);
 FUNC_GROUP_DECL(MACLINK4, K25);
 
 FUNC_GROUP_DECL(I2C14, L23, K25);
+/*SGPM2 is A1 Only */
+FUNC_GROUP_DECL(SGPM2, K26, L24, L23, K25);
 
 #define J26 8
 SIG_EXPR_LIST_DECL_SESG(J26, SALT1, SALT1, SIG_DESC_SET(SCU410, 8));
@@ -2060,6 +2080,7 @@ static const struct aspeed_pin_group aspeed_g6_groups[] = {
 	ASPEED_PINCTRL_GROUP(EMMCG4),
 	ASPEED_PINCTRL_GROUP(EMMCG8),
 	ASPEED_PINCTRL_GROUP(SGPM1),
+	ASPEED_PINCTRL_GROUP(SGPM2),
 	ASPEED_PINCTRL_GROUP(SGPS1),
 	ASPEED_PINCTRL_GROUP(SIOONCTRL),
 	ASPEED_PINCTRL_GROUP(SIOPBI),
@@ -2276,6 +2297,7 @@ static const struct aspeed_pin_function aspeed_g6_functions[] = {
 	ASPEED_PINCTRL_FUNC(SD1),
 	ASPEED_PINCTRL_FUNC(SD2),
 	ASPEED_PINCTRL_FUNC(SGPM1),
+	ASPEED_PINCTRL_FUNC(SGPM2),
 	ASPEED_PINCTRL_FUNC(SGPS1),
 	ASPEED_PINCTRL_FUNC(SIOONCTRL),
 	ASPEED_PINCTRL_FUNC(SIOPBI),
-- 
2.17.1

