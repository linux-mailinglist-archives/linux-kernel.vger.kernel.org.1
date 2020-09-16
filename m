Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC46126BAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgIPDtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:49:08 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45670 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgIPDs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:48:56 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 095602008D0;
        Wed, 16 Sep 2020 05:48:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9905B2008BD;
        Wed, 16 Sep 2020 05:48:50 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 105C14035E;
        Wed, 16 Sep 2020 05:11:22 +0200 (CEST)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mturquette@baylibre.com
Cc:     andy.tang@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH 2/2] arm64: dts: layerscape: modify clocks divider to 32 for wdt
Date:   Wed, 16 Sep 2020 11:03:11 +0800
Message-Id: <20200916030311.17280-2-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916030311.17280-1-qiang.zhao@nxp.com>
References: <20200916030311.17280-1-qiang.zhao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Qiang <qiang.zhao@nxp.com>

On LX2088A, wdt's clock are get from clockgen divided by 32,
so modify clocks in device tree.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 7016791..de6c751 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -194,56 +194,56 @@
 		cluster1_core0_watchdog: wdt@c000000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 31>, <&clockgen 4 31>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster1_core1_watchdog: wdt@c010000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc010000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 31>, <&clockgen 4 31>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster2_core0_watchdog: wdt@c100000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc100000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 31>, <&clockgen 4 31>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster2_core1_watchdog: wdt@c110000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc110000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 31>, <&clockgen 4 31>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster3_core0_watchdog: wdt@c200000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc200000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 31>, <&clockgen 4 31>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster3_core1_watchdog: wdt@c210000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc210000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 31>, <&clockgen 4 31>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster4_core0_watchdog: wdt@c300000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc300000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 31>, <&clockgen 4 31>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
 		cluster4_core1_watchdog: wdt@c310000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc310000 0x0 0x1000>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 31>, <&clockgen 4 31>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
-- 
2.7.4

