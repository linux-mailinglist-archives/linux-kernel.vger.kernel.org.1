Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DCF2A22F0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 03:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgKBCRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 21:17:10 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42570 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgKBCRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 21:17:10 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3804A201446;
        Mon,  2 Nov 2020 03:17:09 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 80AD3201439;
        Mon,  2 Nov 2020 03:17:05 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9F3294029C;
        Mon,  2 Nov 2020 03:17:00 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] arm64: dts: imx8mq: Configure clock rate for audio plls
Date:   Mon,  2 Nov 2020 10:11:16 +0800
Message-Id: <1604283077-27012-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure clock rate for audio plls. audio pll1 is used
as parent clock for clocks that is multiple of 8kHz.
audio pll2 is used as parent clock for clocks that is
multiple of 11kHz.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- none

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 5e0e7d0f1bc4..49cc79246288 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -606,11 +606,25 @@ clk: clock-controller@30380000 {
 				              "clk_ext3", "clk_ext4";
 				assigned-clocks = <&clk IMX8MQ_CLK_A53_SRC>,
 						  <&clk IMX8MQ_CLK_A53_CORE>,
-						  <&clk IMX8MQ_CLK_NOC>;
+						  <&clk IMX8MQ_CLK_NOC>,
+						  <&clk IMX8MQ_CLK_AUDIO_AHB>,
+						  <&clk IMX8MQ_AUDIO_PLL1_BYPASS>,
+						  <&clk IMX8MQ_AUDIO_PLL2_BYPASS>,
+						  <&clk IMX8MQ_AUDIO_PLL1>,
+						  <&clk IMX8MQ_AUDIO_PLL2>;
 				assigned-clock-rates = <0>, <0>,
-						       <800000000>;
+						       <800000000>,
+						       <0>,
+						       <0>,
+						       <0>,
+						       <786432000>,
+						       <722534400>;
 				assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
-							 <&clk IMX8MQ_ARM_PLL_OUT>;
+							 <&clk IMX8MQ_ARM_PLL_OUT>,
+							 <0>,
+							 <&clk IMX8MQ_SYS2_PLL_500M>,
+							 <&clk IMX8MQ_AUDIO_PLL1>,
+							 <&clk IMX8MQ_AUDIO_PLL2>;
 			};
 
 			src: reset-controller@30390000 {
-- 
2.27.0

