Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1B229A3C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 05:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505529AbgJ0E4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 00:56:16 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33242 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505485AbgJ0Ez5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 00:55:57 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6FE141A0DD9;
        Tue, 27 Oct 2020 05:55:54 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A2C0A1A0020;
        Tue, 27 Oct 2020 05:55:48 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C82D54031B;
        Tue, 27 Oct 2020 05:55:37 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [v2 09/11] arm64: dts: lx2160a: add DT node for external interrupt lines
Date:   Tue, 27 Oct 2020 12:46:17 +0800
Message-Id: <20201027044619.41879-9-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027044619.41879-1-biwen.li@oss.nxp.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Add device-tree node for external interrupt lines IRQ0-IRQ11.

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v2:
	- none

 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index d247e4228d60..095298a84f4e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -664,6 +664,37 @@
 			little-endian;
 		};
 
+		isc: syscon@1f70000 {
+			compatible = "fsl,lx2160a-isc", "syscon";
+			reg = <0x0 0x1f70000 0x0 0x10000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x1f70000 0x10000>;
+
+			extirq: interrupt-controller@14 {
+				compatible = "fsl,lx2160a-extirq", "fsl,ls1088a-extirq";
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

