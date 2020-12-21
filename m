Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3152DFBD4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 13:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgLUM11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 07:27:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52632 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726173AbgLUM10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 07:27:26 -0500
X-UUID: 4c68ba0aa9d74be7b99f7817a22da234-20201221
X-UUID: 4c68ba0aa9d74be7b99f7817a22da234-20201221
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1132859232; Mon, 21 Dec 2020 20:26:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Dec 2020 20:26:36 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Dec 2020 20:26:35 +0800
From:   <qii.wang@mediatek.com>
To:     <robh+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>
Subject: [PATCH] arm64: dts: mediatek: Correct i2c clock of MT8192
Date:   Mon, 21 Dec 2020 20:26:30 +0800
Message-ID: <1608553590-26459-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qii Wang <qii.wang@mediatek.com>

imp wrapper clock is the i2c source clock of MT8192

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 43 ++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index faea0d9..9c194a8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -17,6 +17,19 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		i2c9 = &i2c9;
+	};
+
 	clk26m: oscillator0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -593,7 +606,8 @@
 			reg = <0 0x11cb0000 0 0x1000>,
 			      <0 0x10217300 0 0x80>;
 			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_e CLK_IMP_IIC_WRAP_E_I2C3>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -612,7 +626,8 @@
 			reg = <0 0x11d00000 0 0x1000>,
 			      <0 0x10217600 0 0x180>;
 			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C7>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -625,7 +640,8 @@
 			reg = <0 0x11d01000 0 0x1000>,
 			      <0 0x10217780 0 0x180>;
 			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C8>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -638,7 +654,8 @@
 			reg = <0 0x11d02000 0 0x1000>,
 			      <0 0x10217900 0 0x180>;
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C9>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -657,7 +674,8 @@
 			reg = <0 0x11d20000 0 0x1000>,
 			      <0 0x10217100 0 0x80>;
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_ws CLK_IMP_IIC_WRAP_WS_I2C1>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -670,7 +688,8 @@
 			reg = <0 0x11d21000 0 0x1000>,
 			      <0 0x10217180 0 0x180>;
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_ws CLK_IMP_IIC_WRAP_WS_I2C2>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -683,7 +702,8 @@
 			reg = <0 0x11d22000 0 0x1000>,
 			      <0 0x10217380 0 0x180>;
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_ws CLK_IMP_IIC_WRAP_WS_I2C4>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -702,7 +722,8 @@
 			reg = <0 0x11e00000 0 0x1000>,
 			      <0 0x10217500 0 0x80>;
 			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C5>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -721,7 +742,8 @@
 			reg = <0 0x11f00000 0 0x1000>,
 			      <0 0x10217080 0 0x80>;
 			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_n CLK_IMP_IIC_WRAP_N_I2C0>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
@@ -734,7 +756,8 @@
 			reg = <0 0x11f01000 0 0x1000>,
 			      <0 0x10217580 0 0x80>;
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&clk26m>, <&clk26m>;
+			clocks = <&imp_iic_wrap_n CLK_IMP_IIC_WRAP_N_I2C6>,
+				 <&infracfg CLK_INFRA_AP_DMA>;
 			clock-names = "main", "dma";
 			clock-div = <1>;
 			#address-cells = <1>;
-- 
1.9.1

