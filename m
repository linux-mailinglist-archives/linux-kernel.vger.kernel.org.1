Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B222C2BA35E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgKTHex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:34:53 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40524 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgKTHew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:34:52 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AK7YkoM047000;
        Fri, 20 Nov 2020 01:34:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605857686;
        bh=ka305g9Wih6EMyf9XOXG43a6Vtb/HkkXTQoC5oJWRwU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oyltxBa/LuwDGjoW9KCFG+f/hcglGEcDbSnoH24PCpiVGUn+QAS7Lr+TFs+KJt2GT
         cBxP3hhUEniwqpKg26GA9bila/t9SIAPHb+ajYMDU8wjgH0WvWRCpeDtCGMYgLaPOm
         u4TkZdJGflTPi90ApEZw2hh9cZB0gz2VvYr5SWbs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AK7YkVi083857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 01:34:46 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 20
 Nov 2020 01:34:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 20 Nov 2020 01:34:46 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AK7YftW089749;
        Fri, 20 Nov 2020 01:34:44 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nsekhar@ti.com>, <vigneshr@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j7200-som-p0: main_i2c0 have an ioexpander on the SOM
Date:   Fri, 20 Nov 2020 09:35:32 +0200
Message-ID: <20201120073533.24486-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120073533.24486-1-peter.ujfalusi@ti.com>
References: <20201120073533.24486-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J7200 SOM have additional io expander which is used to control several
SOM level muxes to make sure that the correct signals are routed to the
correct pin on the SOM <-> CPB connectors.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 11 --------
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 26 +++++++++++++++++++
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 6b3863108571..2721137d8943 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -43,13 +43,6 @@ J721E_WKUP_IOPAD(0x0098, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
 };
 
 &main_pmx0 {
-	main_i2c0_pins_default: main-i2c0-pins-default {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
-			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
-		>;
-	};
-
 	main_i2c1_pins_default: main-i2c1-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0xdc, PIN_INPUT_PULLUP, 3) /* (U3) ECAP0_IN_APWM_OUT.I2C1_SCL */
@@ -146,10 +139,6 @@ &cpsw_port1 {
 };
 
 &main_i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c0_pins_default>;
-	clock-frequency = <400000>;
-
 	exp1: gpio@20 {
 		compatible = "ti,tca6416";
 		reg = <0x20>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index fbd17d38f6b6..7b5e9aa0324e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -48,6 +48,15 @@ J721E_WKUP_IOPAD(0x28, PIN_INPUT, 1) /* (A7) MCU_OSPI0_D7.MCU_HYPERBUS0_DQ7 */
 	};
 };
 
+&main_pmx0 {
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
+			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
+		>;
+	};
+};
+
 &hbmc {
 	/* OSPI and HBMC are muxed inside FSS, Bootloader will enable
 	 * appropriate node based on board detection
@@ -131,3 +140,20 @@ &mailbox0_cluster10 {
 &mailbox0_cluster11 {
 	status = "disabled";
 };
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	exp_som: gpio@21 {
+		compatible = "ti,tca6408";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "USB2.0_MUX_SEL", "CANUART_MUX1_SEL0",
+				  "CANUART_MUX2_SEL0", "CANUART_MUX_SEL1",
+				  "UART/LIN_MUX_SEL", "TRC_D17/AUDIO_REFCLK_SEL",
+				  "GPIO_LIN_EN", "CAN_STB";
+	};
+};
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

