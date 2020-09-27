Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8470627A1E9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 19:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgI0RAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 13:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgI0Q77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 12:59:59 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6059823899;
        Sun, 27 Sep 2020 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601225999;
        bh=DsQjxeaTzdxtV/FNnzMWtGBAiV2ATQVQpSEoosApHDY=;
        h=From:To:Cc:Subject:Date:From;
        b=jWRaHKISj8i/MzZzLzvT9/1wyCUAlxZwzBIf1JXupR8bCUcBqnFUSZ6Ij0r78EdvR
         5AVKMfIpW40ptp8ffyJwJiYD3vrlnG/PCO6fPoxxymOHX9IiFCQNIQZWVuk7wx3+XP
         RYZcCPB2dDN2l8sYw5TlngHRYxhKroS73RRIpO28=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Peter Chen <peter.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/6] arm64: dts: imx8mm-var-som: fix missing PMIC's interrupt line pull-up
Date:   Sun, 27 Sep 2020 18:59:42 +0200
Message-Id: <20200927165947.7317-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC's interrupt is level low and should be pulled up.  The PMIC's
device node had pinctrl-0 property but it lacked pinctrl-names which
is required to apply the pin configuration.  The actual problem in DTS
was pointed out by Felix Radensky from Variscite.

Reported-by: Felix Radensky <felix.r@variscite.com>
Fixes: 5f67317bd967 ("arm64: dts: imx8mm: correct interrupt flags")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
index 4107fe914d08..49082529764f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
@@ -135,13 +135,10 @@
 	pmic@4b {
 		compatible = "rohm,bd71847";
 		reg = <0x4b>;
+		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio2>;
-		/*
-		 * The interrupt is not correct. It should be level low,
-		 * however with internal pull up this causes IRQ storm.
-		 */
-		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 		rohm,reset-snvs-powered;
 
 		#clock-cells = <0>;
@@ -398,7 +395,7 @@
 
 	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
-			MX8MM_IOMUXC_SD1_DATA6_GPIO2_IO8	0x41
+			MX8MM_IOMUXC_SD1_DATA6_GPIO2_IO8	0x141
 		>;
 	};
 
-- 
2.17.1

