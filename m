Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985CA25DC74
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgIDOyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 10:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730844AbgIDOy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:54:26 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872EA2074D;
        Fri,  4 Sep 2020 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231265;
        bh=WiUuQ+f9E1CoIhl0AsGPuRKNJE1sq9W7y3PUmmpgAfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yC9JZDM1pIZNcT177wBJGvC0icileilRaqfP8yj48IjAn6vyl4Sh3Qafv/qCD9MXx
         uTDZ+UDi5Rz0jm0+QUFOUh6bToys2IE0ansOLYIQ7BiQST5etwIjxKcVfnK1mUqh6Z
         1R+cG06oJRJ7l6uXQg8uRbu0u7O6ss6p9d5YPx3Q=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Li Yang <leoyang.li@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 11/13] arm64: dts: imx8mq-librem5: Align regulator names with schema
Date:   Fri,  4 Sep 2020 16:53:10 +0200
Message-Id: <20200904145312.10960-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904145312.10960-1-krzk@kernel.org>
References: <20200904145312.10960-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree schema expects regulator names to be lowercase.  This fixes
dtbs_check warnings like:

  pmic@4b: regulators:LDO1:regulator-name:0: 'LDO1' does not match '^ldo[1-7]$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index c3e290703fe8..4e50cb62654d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -645,7 +645,7 @@
 
 		regulators {
 			buck1_reg: BUCK1 {
-				regulator-name = "BUCK1";
+				regulator-name = "buck1";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-ramp-delay = <1250>;
@@ -656,7 +656,7 @@
 			};
 
 			buck2_reg: BUCK2 {
-				regulator-name = "BUCK2";
+				regulator-name = "buck2";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-ramp-delay = <1250>;
@@ -666,7 +666,7 @@
 			};
 
 			buck3_reg: BUCK3 {
-				regulator-name = "BUCK3";
+				regulator-name = "buck3";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				rohm,dvs-run-voltage = <900000>;
@@ -674,42 +674,42 @@
 			};
 
 			buck4_reg: BUCK4 {
-				regulator-name = "BUCK4";
+				regulator-name = "buck4";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				rohm,dvs-run-voltage = <1000000>;
 			};
 
 			buck5_reg: BUCK5 {
-				regulator-name = "BUCK5";
+				regulator-name = "buck5";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 			};
 
 			buck6_reg: BUCK6 {
-				regulator-name = "BUCK6";
+				regulator-name = "buck6";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 
 			buck7_reg: BUCK7 {
-				regulator-name = "BUCK7";
+				regulator-name = "buck7";
 				regulator-min-microvolt = <1605000>;
 				regulator-max-microvolt = <1995000>;
 				regulator-always-on;
 			};
 
 			buck8_reg: BUCK8 {
-				regulator-name = "BUCK8";
+				regulator-name = "buck8";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1400000>;
 				regulator-always-on;
 			};
 
 			ldo1_reg: LDO1 {
-				regulator-name = "LDO1";
+				regulator-name = "ldo1";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
 				/* leave on for snvs power button */
@@ -717,7 +717,7 @@
 			};
 
 			ldo2_reg: LDO2 {
-				regulator-name = "LDO2";
+				regulator-name = "ldo2";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
 				/* leave on for snvs power button */
@@ -725,14 +725,14 @@
 			};
 
 			ldo3_reg: LDO3 {
-				regulator-name = "LDO3";
+				regulator-name = "ldo3";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 
 			ldo4_reg: LDO4 {
-				regulator-name = "LDO4";
+				regulator-name = "ldo4";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
@@ -740,7 +740,7 @@
 
 			ldo5_reg: LDO5 {
 				/* VDD_PHY_0V9 - MIPI and HDMI domains */
-				regulator-name = "LDO5";
+				regulator-name = "ldo5";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
@@ -748,7 +748,7 @@
 
 			ldo6_reg: LDO6 {
 				/* VDD_PHY_0V9 - MIPI, HDMI and USB domains */
-				regulator-name = "LDO6";
+				regulator-name = "ldo6";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
@@ -756,7 +756,7 @@
 
 			ldo7_reg: LDO7 {
 				/* VDD_PHY_3V3 - USB domain */
-				regulator-name = "LDO7";
+				regulator-name = "ldo7";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
-- 
2.17.1

