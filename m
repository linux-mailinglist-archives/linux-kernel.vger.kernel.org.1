Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3BC2C81BB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgK3KIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:08:04 -0500
Received: from inva020.nxp.com ([92.121.34.13]:60808 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgK3KID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:08:03 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 819231A0A5D;
        Mon, 30 Nov 2020 11:07:16 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B28711A0515;
        Mon, 30 Nov 2020 11:07:10 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 41319402C4;
        Mon, 30 Nov 2020 11:07:03 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [v4 02/11] arm64: dts: ls1043a: add DT node for external interrupt lines
Date:   Mon, 30 Nov 2020 18:15:06 +0800
Message-Id: <20201130101515.27431-2-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130101515.27431-1-biwen.li@oss.nxp.com>
References: <20201130101515.27431-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Add device-tree node for external interrupt lines IRQ0-IRQ11.

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v4:
	- remove copyright to fix corrupt

Change in v3:
	- none

Change in v2:
	- none

 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 0464b8aa4bc4..573e6659cff8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
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

