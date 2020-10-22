Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA7295B04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509806AbgJVIxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:53:40 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47008 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509775AbgJVIxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:53:32 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 98738201301;
        Thu, 22 Oct 2020 10:53:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C6D12012EC;
        Thu, 22 Oct 2020 10:53:25 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CF89C402DD;
        Thu, 22 Oct 2020 10:53:17 +0200 (CEST)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [PATCH 05/11] arm64: dts: ls1088a: add DT node for external interrupt lines
Date:   Thu, 22 Oct 2020 16:44:04 +0800
Message-Id: <20201022084410.28249-5-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022084410.28249-1-biwen.li@oss.nxp.com>
References: <20201022084410.28249-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Add device-tree node for external interrupt lines IRQ0-IRQ11.

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 36a799554620..c8b583cb2b9f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Include file for NXP Layerscape-1088A family SoC.
  *
- * Copyright 2017 NXP
+ * Copyright 2017-2020 NXP
  *
  * Harninder Rai <harninder.rai@nxp.com>
  *
@@ -205,6 +205,37 @@
 			little-endian;
 		};
 
+		isc: syscon@1f70000 {
+			compatible = "fsl,ls1088a-isc", "syscon";
+			reg = <0x0 0x1f70000 0x0 0x10000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x1f70000 0x10000>;
+
+			extirq: interrupt-controller@14 {
+				compatible = "fsl,ls1088a-extirq";
+				#interrupt-cells = <2>;
+				#address-cells = <0>;
+				interrupt-controller;
+				reg = <0x14 4>;
+				interrupt-map =
+					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+					<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					<8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-map-mask = <0xffffffff 0x0>;
+			};
+		};
+
 		tmu: tmu@1f80000 {
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f80000 0x0 0x10000>;
-- 
2.17.1

