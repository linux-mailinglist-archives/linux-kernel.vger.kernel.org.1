Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D52C29881A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771365AbgJZIL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:11:59 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55266 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1771250AbgJZIKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:10:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 73F942009BA;
        Mon, 26 Oct 2020 09:10:46 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0541A200994;
        Mon, 26 Oct 2020 09:10:41 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EF6C4402BB;
        Mon, 26 Oct 2020 09:10:33 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [RESEND 02/11] arm64: dts: ls1043a: add DT node for external interrupt lines
Date:   Mon, 26 Oct 2020 16:01:18 +0800
Message-Id: <20201026080127.40499-2-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026080127.40499-1-biwen.li@oss.nxp.com>
References: <20201026080127.40499-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Add device-tree node for external interrupt lines IRQ0-IRQ11.

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 5c2e370f6316..38a6d951ecc5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -3,7 +3,7 @@
  * Device Tree Include file for Freescale Layerscape-1043A family SoC.
  *
  * Copyright 2014-2015 Freescale Semiconductor, Inc.
- * Copyright 2018 NXP
+ * Copyright 2018-2020 NXP
  *
  * Mingkai Hu <Mingkai.hu@freescale.com>
  */
@@ -311,6 +311,31 @@
 			compatible = "fsl,ls1043a-scfg", "syscon";
 			reg = <0x0 0x1570000 0x0 0x10000>;
 			big-endian;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x1570000 0x10000>;
+
+			extirq: interrupt-controller@1ac {
+				compatible = "fsl,ls1043a-extirq";
+				#interrupt-cells = <2>;
+				#address-cells = <0>;
+				interrupt-controller;
+				reg = <0x1ac 4>;
+				interrupt-map =
+					<0 0 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+					<6 0 &gic GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					<7 0 &gic GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+					<8 0 &gic GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+					<9 0 &gic GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &gic GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &gic GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-map-mask = <0xffffffff 0x0>;
+			};
 		};
 
 		crypto: crypto@1700000 {
-- 
2.17.1

