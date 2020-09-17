Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E184D26E4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgIQSzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgIQSzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:55:05 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7284A22211;
        Thu, 17 Sep 2020 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600368903;
        bh=Tf6j9/g6ssvG3k+ON3t83cV1K0lTh2I4Nkn5/PHO+4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHEyE9l2fhYri/8Ux0H7W2GgoHVPLOG2EkQ81mTkLbdbGiK0gkzM0JKUPWfBGlD/J
         RX2O57M3kZvkHu4GWi5pCBa444OP2Uy0KA/w/RuuV/VEj/VEzZPPOteKOsq5ab96fD
         2iHgDdU1O3hD3SLYy1wu/nSGptsggS2v2TberEPw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Robin Gong <yibin.gong@nxp.com>,
        Peter Chen <peter.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 2/4] arm64: dts: imx8mm: correct interrupt flags
Date:   Thu, 17 Sep 2020 20:54:47 +0200
Message-Id: <20200917185449.5687-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917185449.5687-1-krzk@kernel.org>
References: <20200917185449.5687-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning:
1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING

Correct the interrupt flags, assuming the author of the code wanted same
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_LOW  => IRQ_TYPE_LEVEL_LOW
  ACTIVE_HIGH => IRQ_TYPE_LEVEL_HIGH

In case of level low interrupts, enable also internal pull up.  It is
required at least on imx8mm-evk, according to schematics.

The schematics for Variscite imx8mm-var-som are not available and
I was unable to get proper configuration from Variscite.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Correct title.
2. Enable pull ups.
---
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi      | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi             | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi         | 6 +++++-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 502faf6144b0..6de86a4f0ec4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -74,7 +74,7 @@
 		reg = <0x4b>;
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <3 GPIO_ACTIVE_LOW>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 		rohm,reset-snvs-powered;
 
 		regulators {
@@ -292,7 +292,7 @@
 
 		pinctrl_pmic: pmicirqgrp {
 			fsl,pins = <
-				MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x41
+				MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x141
 			>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index f572b7d207f4..f305a530ff6f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -123,7 +123,7 @@
 		reg = <0x4b>;
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <3 GPIO_ACTIVE_LOW>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 		rohm,reset-snvs-powered;
 
 		#clock-cells = <0>;
@@ -392,7 +392,7 @@
 
 	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x41
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x141
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
index 67ceda14d648..a56f602ba0a3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
@@ -134,7 +134,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_captouch>;
 		interrupt-parent = <&gpio5>;
-		interrupts = <4 GPIO_ACTIVE_HIGH>;
+		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
 
 		touchscreen-size-x = <800>;
 		touchscreen-size-y = <480>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
index 9c6e91243ba0..4107fe914d08 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
@@ -137,7 +137,11 @@
 		reg = <0x4b>;
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <8 GPIO_ACTIVE_LOW>;
+		/*
+		 * The interrupt is not correct. It should be level low,
+		 * however with internal pull up this causes IRQ storm.
+		 */
+		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
 		rohm,reset-snvs-powered;
 
 		#clock-cells = <0>;
-- 
2.17.1

