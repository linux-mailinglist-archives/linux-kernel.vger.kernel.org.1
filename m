Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0A92508CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 21:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgHXTHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 15:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgHXTHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:07:48 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9113A20866;
        Mon, 24 Aug 2020 19:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296067;
        bh=FkLjw7Jcs543SiKoNIN05bHQA4tIrsY4ElZISGC6hZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9wigELx9n/FYrR60grGQ+VxPQsbdRYB5alC5zUN/1bM6XJZQPzmQH+9avv/orlbu
         PLuLOfjKcAR+Js/6eOQnfT6s0kNRrS3nar0UXy/UDMLtizZs+Rqyvy0m0LjGjq/uZ6
         NBFnkV9x+MIlAdJUwmQ12edpV5LDv6iYzL7odjrc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, Li Jun <jun.li@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 07/16] arm64: dts: imx8mm-evk: Align pin configuration group names with schema
Date:   Mon, 24 Aug 2020 21:06:52 +0200
Message-Id: <20200824190701.8447-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824190701.8447-1-krzk@kernel.org>
References: <20200824190701.8447-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree schema expects pin configuration groups to end with 'grp'
suffix, otherwise dtbs_check complain with a warning like:

    ... do not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index 0115f07bbc9d..207dc8de3145 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -423,13 +423,13 @@
 		>;
 	};
 
-	pinctrl_pmic: pmicirq {
+	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x41
 		>;
 	};
 
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmc {
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
 		>;
@@ -457,7 +457,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
 		>;
@@ -475,7 +475,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
 			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
@@ -487,7 +487,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
 			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
@@ -515,7 +515,7 @@
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x194
 			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
@@ -531,7 +531,7 @@
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x196
 			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
-- 
2.17.1

