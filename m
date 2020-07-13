Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7341621C839
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 11:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgGLJUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 05:20:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38238 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbgGLJUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 05:20:17 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ABF102008BF;
        Sun, 12 Jul 2020 11:20:15 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D17872002AB;
        Sun, 12 Jul 2020 11:20:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2ADD0402C8;
        Sun, 12 Jul 2020 17:20:07 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH] ARM: dts: imx6sx-sdb: Add MQS support
Date:   Sun, 12 Jul 2020 17:16:42 +0800
Message-Id: <1594545402-26815-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MQS support. As the pin conflict with usdhc2, then need
to add a separate dts.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in RESEND
- resolve the conflict with latest tree.

 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/imx6sx-sdb-mqs.dts | 48 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb.dtsi    |  7 ++++
 arch/arm/boot/dts/imx6sx.dtsi        |  6 ++++
 4 files changed, 62 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb-mqs.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e6a1cac0bfc7..04f85d6a2af3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -592,6 +592,7 @@ dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-sdb-reva.dtb \
 	imx6sx-sdb-sai.dtb \
 	imx6sx-sdb.dtb \
+	imx6sx-sdb-mqs.dtb \
 	imx6sx-softing-vining-2000.dtb \
 	imx6sx-udoo-neo-basic.dtb \
 	imx6sx-udoo-neo-extended.dtb \
diff --git a/arch/arm/boot/dts/imx6sx-sdb-mqs.dts b/arch/arm/boot/dts/imx6sx-sdb-mqs.dts
new file mode 100644
index 000000000000..a4ab2d3e960c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sx-sdb-mqs.dts
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2014 Freescale Semiconductor, Inc.
+
+#include "imx6sx-sdb.dts"
+/ {
+
+	sound {
+		status = "disabled";
+	};
+
+	sound-mqs {
+		compatible = "fsl,imx6sx-sdb-mqs",
+			     "fsl,imx-audio-mqs";
+		model = "mqs-audio";
+		audio-cpu = <&sai1>;
+		audio-asrc = <&asrc>;
+		audio-codec = <&mqs>;
+	};
+};
+
+&usdhc2 {
+	/* pin conflict with mqs*/
+	status = "disabled";
+};
+
+&mqs {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mqs>;
+	clocks = <&clks IMX6SX_CLK_SAI1>;
+	clock-names = "mclk";
+	status = "okay";
+};
+
+&sai1 {
+	pinctrl-0 = <>;
+	status = "okay";
+};
+
+&ssi2 {
+	status = "disabled";
+};
+
+&sdma {
+	gpr = <&gpr>;
+	/* SDMA event remap for SAI1 */
+	fsl,sdma-event-remap = <0 15 1>, <0 16 1>;
+};
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index 6673532018b2..05d1e9d2efab 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -522,6 +522,13 @@ MX6SX_PAD_LCD1_RESET__GPIO3_IO_27 0x4001b0b0
 			>;
 		};
 
+		pinctrl_mqs: mqsgrp {
+			fsl,pins = <
+				MX6SX_PAD_SD2_CLK__MQS_RIGHT 0x120b0
+				MX6SX_PAD_SD2_CMD__MQS_LEFT  0x120b0
+			>;
+		};
+
 		pinctrl_pcie: pciegrp {
 			fsl,pins = <
 				MX6SX_PAD_ENET1_COL__GPIO2_IO_0 0x10b0
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 5c2b78589aa5..fcb3d064d0cc 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -134,6 +134,12 @@ anaclk2: clock-anaclk2 {
 		clock-output-names = "anaclk2";
 	};
 
+	mqs: mqs {
+		compatible = "fsl,imx6sx-mqs";
+		gpr = <&gpr>;
+		status = "disabled";
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupt-parent = <&gpc>;
-- 
2.27.0

