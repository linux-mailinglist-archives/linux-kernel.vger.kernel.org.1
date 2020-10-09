Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E4F2883EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgJIHw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:52:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42370 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbgJIHw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:52:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C05A120050A;
        Fri,  9 Oct 2020 09:52:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 910D320094D;
        Fri,  9 Oct 2020 09:52:17 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7435D402CA;
        Fri,  9 Oct 2020 09:52:08 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org,
        aford173@gmail.com, daniel.baluta@nxp.com, shengjiu.wang@nxp.com,
        peter.chen@nxp.com, alifer.wsdm@gmail.com, abel.vesa@nxp.com,
        yibin.gong@nxp.com, jun.li@nxp.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] arm64: dts: imx8mm: Correct WDOG_B pin configuration
Date:   Fri,  9 Oct 2020 15:47:45 +0800
Message-Id: <1602229667-13165-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different revision of i.MX8MM EVK boards may have different external
pull up registor design, some are enabled while some are NOT, to make
sure the WDOG_B pin works properly, better to enable internal pull up
resistor. Since enabling internal pull up resistor is NOT harmful and
having benefit of flexibility on different board design, just enable
it for all i.MX8MM boards.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi        | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 6de86a4..a941301 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -398,7 +398,7 @@
 
 		pinctrl_wdog: wdoggrp {
 			fsl,pins = <
-				MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
+				MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x166
 			>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index f305a53..469d570 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -468,7 +468,7 @@
 
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0xc6
+			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x166
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
index 4107fe9..38e879d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
@@ -555,7 +555,7 @@
 
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0xc6
+			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x166
 		>;
 	};
 };
-- 
2.7.4

