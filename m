Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B882D8F05
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 18:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404092AbgLMRTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 12:19:01 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:59776 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405265AbgLMRSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 12:18:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id CC8ACFB03;
        Sun, 13 Dec 2020 18:17:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ofVPF9c2G04x; Sun, 13 Dec 2020 18:17:17 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4FE9B43FE3; Sun, 13 Dec 2020 18:17:14 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Angus Ainslie <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: imx8mq-librem5-devkit: Mark more regulators as always-on
Date:   Sun, 13 Dec 2020 18:17:13 +0100
Message-Id: <7adc87ee6a5aea7b7d635ce1a0fbc4e2d8def7ed.1607879709.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1607879709.git.agx@sigxcpu.org>
References: <cover.1607879709.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They power vital parts of the board and low power consumption is not
really an issue here. It also brings things more in line with what
Purism is using downstream.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 12f5d75a5e44..5fdea6b74ed5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -297,7 +297,7 @@ buck1_reg: BUCK1 {
 				regulator-name = "buck1";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
+				regulator-always-on;
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <900000>;
 				rohm,dvs-idle-voltage = <850000>;
@@ -308,7 +308,7 @@ buck2_reg: BUCK2 {
 				regulator-name = "buck2";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
+				regulator-always-on;
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <1000000>;
 				rohm,dvs-idle-voltage = <900000>;
@@ -318,7 +318,7 @@ buck3_reg: BUCK3 {
 				regulator-name = "buck3";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
-				regulator-boot-on;
+				regulator-always-on;
 				rohm,dvs-run-voltage = <900000>;
 			};
 
@@ -333,7 +333,7 @@ buck5_reg: BUCK5 {
 				regulator-name = "buck5";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			buck6_reg: BUCK6 {
@@ -354,7 +354,7 @@ buck8_reg: BUCK8 {
 				regulator-name = "buck8";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1400000>;
-				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			ldo1_reg: LDO1 {
@@ -379,34 +379,35 @@ ldo3_reg: LDO3 {
 				regulator-name = "ldo3";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			ldo4_reg: LDO4 {
 				regulator-name = "ldo4";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			ldo5_reg: LDO5 {
 				regulator-name = "ldo5";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			ldo6_reg: LDO6 {
 				regulator-name = "ldo6";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			ldo7_reg: LDO7 {
 				regulator-name = "ldo7";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
+				regulator-always-on;
 			};
 		};
 	};
-- 
2.29.2

