Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9AE204E60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 11:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbgFWJrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 05:47:24 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37974 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731921AbgFWJrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:47:23 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E008200C9C;
        Tue, 23 Jun 2020 11:47:21 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 717AF200086;
        Tue, 23 Jun 2020 11:47:21 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0ADA9203C3;
        Tue, 23 Jun 2020 11:47:21 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND] arm64: dts: imx8m: Add NOC nodes
Date:   Tue, 23 Jun 2020 12:47:01 +0300
Message-Id: <1592905621-9689-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

Add nodes for the main interconnect of the imx8m series chips.

These nodes are bound to by devfreq and interconnect drivers.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

This is part of the following patchset:

https://www.spinics.net/lists/arm-kernel/msg797026.html

All the patches are already in except this one.

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 23 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 23 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 23 +++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c6bf8ba..00b96da 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -869,6 +869,29 @@
 
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MM_CLK_NOC>;
+			fsl,ddrc = <&ddrc>;
+			#interconnect-cells = <1>;
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-150M {
+					opp-hz = /bits/ 64 <150000000>;
+				};
+				opp-375M {
+					opp-hz = /bits/ 64 <375000000>;
+				};
+				opp-750M {
+					opp-hz = /bits/ 64 <750000000>;
+				};
+			};
+		};
+
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32c00000 0x400000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 9a4b65a..656fa9b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -756,6 +756,29 @@
 
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mn-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MN_CLK_NOC>;
+			fsl,ddrc = <&ddrc>;
+			#interconnect-cells = <1>;
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100M {
+					opp-hz = /bits/ 64 <100000000>;
+				};
+				opp-600M {
+					opp-hz = /bits/ 64 <600000000>;
+				};
+				opp-800M {
+					opp-hz = /bits/ 64 <800000000>;
+				};
+			};
+		};
+
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32c00000 0x400000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 54bed64..6c24ec1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1037,6 +1037,29 @@
 			};
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MQ_CLK_NOC>;
+			fsl,ddrc = <&ddrc>;
+			#interconnect-cells = <1>;
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-133M {
+					opp-hz = /bits/ 64 <133333333>;
+				};
+				opp-400M {
+					opp-hz = /bits/ 64 <400000000>;
+				};
+				opp-800M {
+					opp-hz = /bits/ 64 <800000000>;
+				};
+			};
+		};
+
 		bus@32c00000 { /* AIPS4 */
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32c00000 0x400000>;
-- 
2.7.4

