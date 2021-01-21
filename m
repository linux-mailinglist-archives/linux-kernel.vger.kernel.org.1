Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD102FE84E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbhAULCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:02:40 -0500
Received: from inva021.nxp.com ([92.121.34.21]:54672 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbhAUK64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:58:56 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 37D872016D6;
        Thu, 21 Jan 2021 11:58:09 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 891F7200C68;
        Thu, 21 Jan 2021 11:58:06 +0100 (CET)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1D7E940291;
        Thu, 21 Jan 2021 11:58:03 +0100 (CET)
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [Patch v2 1/3] arm64: dts: lx2160a: Add flexcan support
Date:   Thu, 21 Jan 2021 16:27:37 +0530
Message-Id: <1611226659-30129-2-git-send-email-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611226659-30129-1-git-send-email-kuldeep.singh@nxp.com>
References: <1611226659-30129-1-git-send-email-kuldeep.singh@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LX2160A supports two flexcan controllers. Add the support.
Enable support further for LX2160A-RDB/QDS.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 16 +++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 24 +++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 16ae3b0..d858d9c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -33,6 +33,14 @@
 	};
 };
 
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
 &crypto {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 6f82759..5dbf274 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -89,6 +89,22 @@
 	};
 };
 
+&can0 {
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
+
+&can1 {
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
+
 &esdhc0 {
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 451e443..0551f6f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -895,6 +895,30 @@
 			status = "disabled";
 		};
 
+		can0: can@2180000 {
+			compatible = "fsl,lx2160ar1-flexcan";
+			reg = <0x0 0x2180000 0x0 0x10000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>,
+				 <&clockgen QORIQ_CLK_SYSCLK 0>;
+			clock-names = "ipg", "per";
+			fsl,clk-source = <0>;
+			status = "disabled";
+		};
+
+		can1: can@2190000 {
+			compatible = "fsl,lx2160ar1-flexcan";
+			reg = <0x0 0x2190000 0x0 0x10000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>,
+				 <&clockgen QORIQ_CLK_SYSCLK 0>;
+			clock-names = "ipg", "per";
+			fsl,clk-source = <0>;
+			status = "disabled";
+		};
+
 		uart0: serial@21c0000 {
 			compatible = "arm,sbsa-uart","arm,pl011";
 			reg = <0x0 0x21c0000 0x0 0x1000>;
-- 
2.7.4

