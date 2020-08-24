Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56E72508D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 21:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHXTIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 15:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgHXTII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:08:08 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25B33208E4;
        Mon, 24 Aug 2020 19:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296087;
        bh=+6fsx9inRaN4fvWlXSXEShmnP49N2TqHhDeCV/p1ZRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6KnQAfxLvus3HjYnQ4zMGO6O23IE5mJUuOi9UUTaa5Py+2zNBaSII525Aly1V9xg
         pDFoX0my+rraFXo5d/9YW24vrE42c8ptxoRpuk8qGqaPYG+u1z/Q2Q+/Gh5I/BUe65
         kJTWMaSzclWQFXzUrMsRg6TtdB7svE0Gmk28MB+M=
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
Subject: [PATCH 11/16] arm64: dts: imx8mq-librem5-devkit: Align pin configuration group names with schema
Date:   Mon, 24 Aug 2020 21:06:56 +0200
Message-Id: <20200824190701.8447-11-krzk@kernel.org>
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
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts     | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 6900ac274f5b..377591a0e6e9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -734,7 +734,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
 			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
@@ -751,7 +751,7 @@
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
 			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
@@ -768,13 +768,13 @@
 		>;
 	};
 
-	pinctrl_usdhc2_pwr: usdhc2grppwr {
+	pinctrl_usdhc2_pwr: usdhc2pwrgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
 		>;
 	};
 
-	pinctrl_usdhc2_gpio: usdhc2grpgpio {
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_WP_GPIO2_IO20		0x80 /* WIFI_WAKE */
 		>;
@@ -791,7 +791,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x8d
 			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xcd
@@ -802,7 +802,7 @@
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x9f
 			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xcf
-- 
2.17.1

