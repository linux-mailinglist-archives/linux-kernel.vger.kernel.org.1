Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D382F9A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbhARGwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:52:33 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:32520 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732793AbhARGwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:52:14 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 10I6k7m0030964;
        Mon, 18 Jan 2021 14:46:07 +0800 (GMT-8)
        (envelope-from troy_lee@aspeedtech.com)
Received: from localhost.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Jan
 2021 14:51:24 +0800
From:   Troy Lee <troy_lee@aspeedtech.com>
To:     <openbmc@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>
CC:     <ryan_chen@aspeedtech.com>, <chiawei_wang@aspeedtech.com>,
        <leetroy@gmail.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v3 3/4] ARM: dts: aspeed: Add Aspeed AST2600 PWM/Fan node in devicetree
Date:   Mon, 18 Jan 2021 06:50:51 +0000
Message-ID: <20210118065059.2478078-4-troy_lee@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118065059.2478078-1-troy_lee@aspeedtech.com>
References: <20210118065059.2478078-1-troy_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 10I6k7m0030964
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a common node in aspeed-g6.dtsi and add fan nodes for ast2600-evb
dts file.

Changes since v2:
 - Change property name pwm-freq to pwm-freq-hz

Changes since v1:
 - rename properties name in child node

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 152 +++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi         |  10 ++
 2 files changed, 162 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 89be13197780..4d24c051eeae 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -23,6 +23,158 @@ memory@80000000 {
 	};
 };
 
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_tach0_default
+			&pinctrl_pwm1_default &pinctrl_tach1_default
+			&pinctrl_pwm2_default &pinctrl_tach2_default
+			&pinctrl_pwm3_default &pinctrl_tach3_default
+			&pinctrl_pwm4_default &pinctrl_tach4_default
+			&pinctrl_pwm5_default &pinctrl_tach5_default
+			&pinctrl_pwm6_default &pinctrl_tach6_default
+			&pinctrl_pwm7_default &pinctrl_tach7_default
+			&pinctrl_pwm8g1_default &pinctrl_tach8_default
+			&pinctrl_pwm9g1_default &pinctrl_tach9_default
+			&pinctrl_pwm10g1_default &pinctrl_tach10_default
+			&pinctrl_pwm11g1_default &pinctrl_tach11_default
+			&pinctrl_pwm12g1_default &pinctrl_tach12_default
+			&pinctrl_pwm13g1_default &pinctrl_tach13_default
+			&pinctrl_pwm14g1_default &pinctrl_tach14_default
+			&pinctrl_pwm15g1_default &pinctrl_tach15_default>;
+
+	fan@0 {
+		reg = <0x00>;
+		aspeed,pwm-freq-hz = <25000>;
+		aspeed,falling-point = /bits/ 8 <100>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x00>;
+		aspeed,tacho-div = <3>;
+		pulses-per-revolution = <1>;
+	};
+
+	fan@1 {
+		reg = <0x01>;
+		aspeed,pwm-freq-hz = <25000>;
+		aspeed,falling-point = /bits/ 8 <100>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x01>;
+		pulses-per-revolution = <1>;
+	};
+
+	fan@2 {
+		reg = <0x02>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x02>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@3 {
+		reg = <0x03>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x03>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@4 {
+		reg = <0x04>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x04>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@5 {
+		reg = <0x05>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x05>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@6 {
+		reg = <0x06>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x06>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@7 {
+		reg = <0x07>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x07>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@8 {
+		reg = <0x08>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x08>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@9 {
+		reg = <0x09>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x09>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@a {
+		reg = <0x0a>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x0a>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@b {
+		reg = <0x0b>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x0b>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@c {
+		reg = <0x0c>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x0c>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@d {
+		reg = <0x0d>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x0d>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@e {
+		reg = <0x0e>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x0e>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan@f {
+		reg = <0x0f>;
+		aspeed,pwm-freq-hz = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x0f>;
+		pulses-per-revolution = <2>;
+	};
+};
+
 &mdio0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 810b0676ab03..0369f8db123a 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -304,6 +304,16 @@ apb {
 			#size-cells = <1>;
 			ranges;
 
+			pwm_tacho: pwm-tacho-controller@1e610000 {
+				compatible = "aspeed,ast2600-pwm-tachometer";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x1e610000 0x100>;
+				clocks = <&syscon ASPEED_CLK_AHB>;
+				resets = <&syscon ASPEED_RESET_PWM>;
+				status = "disabled";
+			};
+
 			syscon: syscon@1e6e2000 {
 				compatible = "aspeed,ast2600-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1000>;
-- 
2.25.1

