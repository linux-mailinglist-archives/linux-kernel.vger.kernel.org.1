Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067192D0CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgLGJVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:21:15 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44398 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgLGJVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:21:14 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 22A9F200B51;
        Mon,  7 Dec 2020 10:20:28 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 10B80200D75;
        Mon,  7 Dec 2020 10:20:24 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 70552402AB;
        Mon,  7 Dec 2020 10:20:18 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH 1/3] arm64: dts: imx8mn: Configure clock rate for audio plls
Date:   Mon,  7 Dec 2020 17:12:34 +0800
Message-Id: <1607332356-13431-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607332356-13431-1-git-send-email-shengjiu.wang@nxp.com>
References: <1607332356-13431-1-git-send-email-shengjiu.wang@nxp.com>
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
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index e35182ff6f59..439cf6ca3114 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -581,7 +581,9 @@ clk: clock-controller@30380000 {
 						<&clk IMX8MN_CLK_NOC>,
 						<&clk IMX8MN_CLK_AUDIO_AHB>,
 						<&clk IMX8MN_CLK_IPG_AUDIO_ROOT>,
-						<&clk IMX8MN_SYS_PLL3>;
+						<&clk IMX8MN_SYS_PLL3>,
+						<&clk IMX8MN_AUDIO_PLL1>,
+						<&clk IMX8MN_AUDIO_PLL2>;
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_800M>,
 							 <&clk IMX8MN_ARM_PLL_OUT>,
 							 <&clk IMX8MN_SYS_PLL3_OUT>,
@@ -589,7 +591,9 @@ clk: clock-controller@30380000 {
 				assigned-clock-rates = <0>, <0>, <0>,
 							<400000000>,
 							<400000000>,
-							<600000000>;
+							<600000000>,
+							<393216000>,
+							<361267200>;
 			};
 
 			src: reset-controller@30390000 {
-- 
2.27.0

