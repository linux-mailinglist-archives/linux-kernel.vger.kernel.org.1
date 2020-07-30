Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3052332A4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 15:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgG3NIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 09:08:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49026 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgG3NI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:08:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D2BB31A0415;
        Thu, 30 Jul 2020 15:08:27 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E6E541A043C;
        Thu, 30 Jul 2020 15:08:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 049F1402BF;
        Thu, 30 Jul 2020 15:08:18 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] ARM: dts: imx: Change gpmi nand node name to nand-controller
Date:   Thu, 30 Jul 2020 21:04:06 +0800
Message-Id: <1596114246-26579-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596114246-26579-1-git-send-email-Anson.Huang@nxp.com>
References: <1596114246-26579-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change i.MX SoCs nand node name from "gpmi-nand" to "nand-controller" to
be compliant with yaml schema, it requires the nodename to be
"nand-controller".

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx23-evk.dts        | 2 +-
 arch/arm/boot/dts/imx23.dtsi           | 2 +-
 arch/arm/boot/dts/imx28-apf28.dts      | 2 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts | 2 +-
 arch/arm/boot/dts/imx28-evk.dts        | 2 +-
 arch/arm/boot/dts/imx28-m28cu3.dts     | 2 +-
 arch/arm/boot/dts/imx28.dtsi           | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi         | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi          | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi          | 2 +-
 arch/arm/boot/dts/imx7s.dtsi           | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 0b2701c..8cbaf1c81 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -53,7 +53,7 @@
 
 	apb@80000000 {
 		apbh@80000000 {
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_pins_fixup>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 18289f6..7f4c602 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -76,7 +76,7 @@
 				status = "disabled";
 			};
 
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				compatible = "fsl,imx23-gpmi-nand";
 				#address-cells = <1>;
 				#size-cells = <1>;
diff --git a/arch/arm/boot/dts/imx28-apf28.dts b/arch/arm/boot/dts/imx28-apf28.dts
index 3ed2b32..14a92fe 100644
--- a/arch/arm/boot/dts/imx28-apf28.dts
+++ b/arch/arm/boot/dts/imx28-apf28.dts
@@ -17,7 +17,7 @@
 
 	apb@80000000 {
 		apbh@80000000 {
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index c5acc19..b86be32 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -13,7 +13,7 @@
 
 	apb@80000000 {
 		apbh@80000000 {
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 96c1d10..7e2b0f1 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -97,7 +97,7 @@
 
 	apb@80000000 {
 		apbh@80000000 {
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg
 					     &gpmi_pins_evk>;
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index 91bd6de..865ac3d 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -17,7 +17,7 @@
 
 	apb@80000000 {
 		apbh@80000000 {
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index a2b799c..94dfbf5 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -100,7 +100,7 @@
 				status = "disabled";
 			};
 
-			gpmi: gpmi-nand@8000c000 {
+			gpmi: nand-controller@8000c000 {
 				compatible = "fsl,imx28-gpmi-nand";
 				#address-cells = <1>;
 				#size-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 43edbf1..de6daa7 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -159,7 +159,7 @@
 			clocks = <&clks IMX6QDL_CLK_APBH_DMA>;
 		};
 
-		gpmi: gpmi-nand@112000 {
+		gpmi: nand-controller@112000 {
 			compatible = "fsl,imx6q-gpmi-nand";
 			reg = <0x00112000 0x2000>, <0x00114000 0x2000>;
 			reg-names = "gpmi-nand", "bch";
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index b480dfa..dfdca18 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -213,7 +213,7 @@
 			clocks = <&clks IMX6SX_CLK_APBH_DMA>;
 		};
 
-		gpmi: gpmi-nand@1806000{
+		gpmi: nand-controller@1806000{
 			compatible = "fsl,imx6sx-gpmi-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 2b088f2..d7d9f3e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -174,7 +174,7 @@
 			clocks = <&clks IMX6UL_CLK_APBHDMA>;
 		};
 
-		gpmi: gpmi-nand@1806000 {
+		gpmi: nand-controller@1806000 {
 			compatible = "fsl,imx6q-gpmi-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1cfaf41..2d23779 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1208,7 +1208,7 @@
 			clocks = <&clks IMX7D_NAND_USDHC_BUS_RAWNAND_CLK>;
 		};
 
-		gpmi: gpmi-nand@33002000{
+		gpmi: nand-controller@33002000{
 			compatible = "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.7.4

