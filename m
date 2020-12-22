Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC202E0AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgLVNlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:41:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52548 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726958AbgLVNlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:41:19 -0500
X-UUID: fa5fa224c554422fa5c8e9c9ef71e8f2-20201222
X-UUID: fa5fa224c554422fa5c8e9c9ef71e8f2-20201222
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1725449829; Tue, 22 Dec 2020 21:40:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Dec 2020 21:40:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Dec 2020 21:40:12 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH 1/2] arm64: dts: mediatek: Add mt8192 clock controllers
Date:   Tue, 22 Dec 2020 21:40:13 +0800
Message-ID: <1608644414-17793-2-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1608644414-17793-1-git-send-email-weiyi.lu@mediatek.com>
References: <1608644414-17793-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock controller nodes for SoC mt8192

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 163 +++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index e12e024..92dcfbd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -5,6 +5,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/clock/mt8192-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
@@ -213,6 +214,24 @@
 			};
 		};
 
+		topckgen: syscon@10000000 {
+			compatible = "mediatek,mt8192-topckgen", "syscon";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg: syscon@10001000 {
+			compatible = "mediatek,mt8192-infracfg", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pericfg: syscon@10003000 {
+			compatible = "mediatek,mt8192-pericfg", "syscon";
+			reg = <0 0x10003000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		pio: pinctrl@10005000 {
 			compatible = "mediatek,mt8192-pinctrl";
 			reg = <0 0x10005000 0 0x1000>,
@@ -238,6 +257,12 @@
 			#interrupt-cells = <2>;
 		};
 
+		apmixedsys: syscon@1000c000 {
+			compatible = "mediatek,mt8192-apmixedsys", "syscon";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		systimer: timer@10017000 {
 			compatible = "mediatek,mt8192-timer",
 				     "mediatek,mt6765-timer";
@@ -247,6 +272,12 @@
 			clock-names = "clk13m";
 		};
 
+		scp_adsp: syscon@10720000 {
+			compatible = "mediatek,mt8192-scp_adsp", "syscon";
+			reg = <0 0x10720000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt8192-uart",
 				     "mediatek,mt6577-uart";
@@ -267,6 +298,12 @@
 			status = "disabled";
 		};
 
+		imp_iic_wrap_c: syscon@11007000 {
+			compatible = "mediatek,mt8192-imp_iic_wrap_c", "syscon";
+			reg = <0 0x11007000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		spi0: spi@1100a000 {
 			compatible = "mediatek,mt8192-spi",
 				     "mediatek,mt6765-spi";
@@ -379,6 +416,12 @@
 			status = "disabled";
 		};
 
+		audsys: syscon@11210000 {
+			compatible = "mediatek,mt8192-audsys", "syscon";
+			reg = <0 0x11210000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		i2c3: i2c3@11cb0000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11cb0000 0 0x1000>,
@@ -392,6 +435,12 @@
 			status = "disabled";
 		};
 
+		imp_iic_wrap_e: syscon@11cb1000 {
+			compatible = "mediatek,mt8192-imp_iic_wrap_e", "syscon";
+			reg = <0 0x11cb1000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		i2c7: i2c7@11d00000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d00000 0 0x1000>,
@@ -431,6 +480,12 @@
 			status = "disabled";
 		};
 
+		imp_iic_wrap_s: syscon@11d03000 {
+			compatible = "mediatek,mt8192-imp_iic_wrap_s", "syscon";
+			reg = <0 0x11d03000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		i2c1: i2c1@11d20000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11d20000 0 0x1000>,
@@ -470,6 +525,12 @@
 			status = "disabled";
 		};
 
+		imp_iic_wrap_ws: syscon@11d23000 {
+			compatible = "mediatek,mt8192-imp_iic_wrap_ws", "syscon";
+			reg = <0 0x11d23000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		i2c5: i2c5@11e00000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11e00000 0 0x1000>,
@@ -483,6 +544,12 @@
 			status = "disabled";
 		};
 
+		imp_iic_wrap_w: syscon@11e01000 {
+			compatible = "mediatek,mt8192-imp_iic_wrap_w", "syscon";
+			reg = <0 0x11e01000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		i2c0: i2c0@11f00000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11f00000 0 0x1000>,
@@ -508,5 +575,101 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		imp_iic_wrap_n: syscon@11f02000 {
+			compatible = "mediatek,mt8192-imp_iic_wrap_n", "syscon";
+			reg = <0 0x11f02000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		msdc_top: syscon@11f10000 {
+			compatible = "mediatek,mt8192-msdc_top", "syscon";
+			reg = <0 0x11f10000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		msdc: syscon@11f60000 {
+			compatible = "mediatek,mt8192-msdc", "syscon";
+			reg = <0 0x11f60000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		mfgcfg: syscon@13fbf000 {
+			compatible = "mediatek,mt8192-mfgcfg", "syscon";
+			reg = <0 0x13fbf000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		mmsys: syscon@14000000 {
+			compatible = "mediatek,mt8192-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys: syscon@15020000 {
+			compatible = "mediatek,mt8192-imgsys", "syscon";
+			reg = <0 0x15020000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		imgsys2: syscon@15820000 {
+			compatible = "mediatek,mt8192-imgsys2", "syscon";
+			reg = <0 0x15820000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdecsys_soc: syscon@1600f000 {
+			compatible = "mediatek,mt8192-vdecsys_soc", "syscon";
+			reg = <0 0x1600f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdecsys: syscon@1602f000 {
+			compatible = "mediatek,mt8192-vdecsys", "syscon";
+			reg = <0 0x1602f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vencsys: syscon@17000000 {
+			compatible = "mediatek,mt8192-vencsys", "syscon";
+			reg = <0 0x17000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys: syscon@1a000000 {
+			compatible = "mediatek,mt8192-camsys", "syscon";
+			reg = <0 0x1a000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_rawa: syscon@1a04f000 {
+			compatible = "mediatek,mt8192-camsys_rawa", "syscon";
+			reg = <0 0x1a04f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_rawb: syscon@1a06f000 {
+			compatible = "mediatek,mt8192-camsys_rawb", "syscon";
+			reg = <0 0x1a06f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_rawc: syscon@1a08f000 {
+			compatible = "mediatek,mt8192-camsys_rawc", "syscon";
+			reg = <0 0x1a08f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ipesys: syscon@1b000000 {
+			compatible = "mediatek,mt8192-ipesys", "syscon";
+			reg = <0 0x1b000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		mdpsys: syscon@1f000000 {
+			compatible = "mediatek,mt8192-mdpsys", "syscon";
+			reg = <0 0x1f000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 };
-- 
1.8.1.1.dirty

