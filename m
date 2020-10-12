Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7819928B4EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbgJLMs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:48:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42200 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729704AbgJLMsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:48:54 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9787520010A;
        Mon, 12 Oct 2020 14:48:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 647B8200DC9;
        Mon, 12 Oct 2020 14:48:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5A6B2402BC;
        Mon, 12 Oct 2020 14:48:35 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org,
        aford173@gmail.com, daniel.baluta@nxp.com, shengjiu.wang@nxp.com,
        peter.chen@nxp.com, alifer.wsdm@gmail.com, abel.vesa@nxp.com,
        yibin.gong@nxp.com, jun.li@nxp.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/3] arm64: dts: imx8mn: Correct WDOG_B pin configuration
Date:   Mon, 12 Oct 2020 20:44:01 +0800
Message-Id: <1602506642-5262-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602506642-5262-1-git-send-email-Anson.Huang@nxp.com>
References: <1602506642-5262-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different revision of i.MX8MN EVK boards may have different external
pull up registor design, some are enabled while some are NOT, to make
sure the WDOG_B pin works properly, better to enable internal pull up
resistor. Since enabling internal pull up resistor is NOT harmful and
having benefit of flexibility on different board design, just enable
it for all i.MX8MN boards; And schmitt input is NOT necessary for this
WDOG_B output pin, so remove it; Open drain outputs provide more
flexibility to a designer as they can be pulled-up to any voltage found
in the system, so enable it as well.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- Provide more explanation of removing schmitt input and enabling open drain in commit msg.
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi     | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 4aa0dbd..fda8905 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -340,7 +340,7 @@
 
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
+			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x166
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
index a2d0190..dde01da 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
@@ -545,7 +545,7 @@
 
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0xc6
+			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x166
 		>;
 	};
 };
-- 
2.7.4

