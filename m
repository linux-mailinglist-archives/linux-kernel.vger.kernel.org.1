Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F59273957
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgIVDkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:40:05 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37930 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgIVDkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:40:05 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 94DC51A0EA8;
        Tue, 22 Sep 2020 05:40:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5279C1A0E8F;
        Tue, 22 Sep 2020 05:40:00 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D6F304029A;
        Tue, 22 Sep 2020 05:39:56 +0200 (CEST)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Zhao Qiang <qiang.zhao@nxp.com>
Subject: [Patch v2] arm64: dts: layerscape: correct watchdog clocks for LS1088A
Date:   Tue, 22 Sep 2020 11:31:46 +0800
Message-Id: <20200922033146.27118-1-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Qiang <qiang.zhao@nxp.com>

On LS1088A, watchdog clk are divided by 16, correct it in dts.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2:
	- rebase

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index c909ad1..80448b4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -675,56 +675,56 @@
 		cluster1_core0_watchdog: wdt@c000000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster1_core1_watchdog: wdt@c010000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc010000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster1_core2_watchdog: wdt@c020000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc020000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster1_core3_watchdog: wdt@c030000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc030000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster2_core0_watchdog: wdt@c100000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc100000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster2_core1_watchdog: wdt@c110000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc110000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster2_core2_watchdog: wdt@c120000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc120000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
 		cluster2_core3_watchdog: wdt@c130000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc130000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 15>, <&clockgen 4 15>;
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
-- 
2.7.4

