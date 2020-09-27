Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9644727A1EF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI0RAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 13:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgI0RAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 13:00:14 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A303823899;
        Sun, 27 Sep 2020 17:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601226014;
        bh=cK6hdYbGGeVjnbbeqGymKZg6oEYJg/flTCaMuiqFPWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JfMNxKMtUq9KZ0v/Jg9V1UkGdpL5B42HKv4UnvVQ07UGwF9UAW6w4Tk9uECUdKIpF
         2dnECJ05mPOFSjUxAdPU9xgepLNA15arSz/QGUasDbBI1FVHBkwvLzZPeS0md64Pog
         vaEnRbfF4nLM0luVE4nrgbINTK0yoIZTzdP9huGw=
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
Subject: [PATCH 4/6] arm64: dts: imx8mn-var-som: fix missing PMIC's interrupt line pull-up
Date:   Sun, 27 Sep 2020 18:59:45 +0200
Message-Id: <20200927165947.7317-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200927165947.7317-1-krzk@kernel.org>
References: <20200927165947.7317-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC's interrupt is level low and should be pulled up.  The PMIC's
device node had pinctrl-0 property but it lacked pinctrl-names which
is required to apply the pin configuration.  The actual problem in DTS
was pointed out by Felix Radensky from Variscite.

Reported-by: Felix Radensky <felix.r@variscite.com>
Fixes: ade0176dd8a0 ("arm64: dts: imx8mn-var-som: Add Variscite VAR-SOM-MX8MN System on Module")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
index a2d0190921e4..7f356edf9f91 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
@@ -116,13 +116,10 @@
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
 
 		regulators {
@@ -388,7 +385,7 @@
 
 	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
-			MX8MN_IOMUXC_SD1_DATA6_GPIO2_IO8	0x101
+			MX8MN_IOMUXC_SD1_DATA6_GPIO2_IO8	0x141
 		>;
 	};
 
-- 
2.17.1

