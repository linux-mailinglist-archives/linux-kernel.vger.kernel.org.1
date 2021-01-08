Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3592EF2B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbhAHM57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:57:59 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:44940 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbhAHM56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:57:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 22441FB02;
        Fri,  8 Jan 2021 13:57:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ad-lw2qiTfel; Fri,  8 Jan 2021 13:57:11 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B15D740887; Fri,  8 Jan 2021 13:57:10 +0100 (CET)
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
Subject: [PATCH v3 2/4] arm64: dts: imx8mq-librem5-devkit: Tweak pmic regulators
Date:   Fri,  8 Jan 2021 13:57:08 +0100
Message-Id: <a0f7efc0fcd23093706e2958b489383d91d11aca.1610110514.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610110514.git.agx@sigxcpu.org>
References: <cover.1610110514.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUCK3 needs a regulator-enable-ramp-delay since otherwise the board
freezes on etnaviv probe. With this pgc_gpu suspends and resumes as
expected. This must have been always broken since gpcv2 support was
enabled.

We also enable all the regulators needed for Deep Sleep Mode (DSM) as
always-on:

- VDD_SOC supplied by BUCK1
- VDDA_1P8 supplied by BUCK7
- VDDA_0P9 supplied by LDO4
- VDDA_DRAM supplied by LDO3
- NVCC_DRAM supplied by BUCK8
- VDD_DRAM supplied by BUCK5

Finally LDO5 and LDO6 provide VDD_PHY_1V8 and VDD_PHY_0V9 used by the
SOCs MIPI, HDMI and USB IP cores. While we would in theory be able to
turn these off (and I've tested that or LDO6 and mipi with USB disabled)
it is of little practical use atm since USB doesn't runtime suspend so
let's revisit this at a later point.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts      | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index af139b283daf..f35d6897fbf7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -298,6 +298,7 @@ buck1_reg: BUCK1 {
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
+				regulator-always-on;
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <900000>;
 				rohm,dvs-idle-voltage = <850000>;
@@ -319,6 +320,7 @@ buck3_reg: BUCK3 {
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
+				regulator-enable-ramp-delay = <200>;
 				rohm,dvs-run-voltage = <900000>;
 			};
 
@@ -334,6 +336,7 @@ buck5_reg: BUCK5 {
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			buck6_reg: BUCK6 {
@@ -341,6 +344,7 @@ buck6_reg: BUCK6 {
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			buck7_reg: BUCK7 {
@@ -348,6 +352,7 @@ buck7_reg: BUCK7 {
 				regulator-min-microvolt = <1605000>;
 				regulator-max-microvolt = <1995000>;
 				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			buck8_reg: BUCK8 {
@@ -355,6 +360,7 @@ buck8_reg: BUCK8 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1400000>;
 				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			ldo1_reg: LDO1 {
@@ -380,6 +386,7 @@ ldo3_reg: LDO3 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			ldo4_reg: LDO4 {
@@ -387,12 +394,14 @@ ldo4_reg: LDO4 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			ldo5_reg: LDO5 {
 				regulator-name = "ldo5";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			ldo6_reg: LDO6 {
@@ -400,6 +409,7 @@ ldo6_reg: LDO6 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
+				regulator-always-on;
 			};
 
 			ldo7_reg: LDO7 {
@@ -407,6 +417,7 @@ ldo7_reg: LDO7 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
+				regulator-always-on;
 			};
 		};
 	};
-- 
2.29.2

