Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0659A270135
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIRPjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:39:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40494 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIRPjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:39:03 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IFcvHv011325;
        Fri, 18 Sep 2020 10:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600443537;
        bh=7XDPRqUzl+JVINgiR0D8+gFPVzJBv1P361gPvzhvl6M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qO5WKj8VqbZ/lc9rJ4Jw7lvR4j11mJyVoxtk8AVuZiSk9TUk7szfS1KASOtSVrvPz
         iYLbzyxcV0FrOwRomAwh8U/XJ9kmRxnz935hi+G6VCBG91xi4chbz8lyNhPCjkQAjo
         HX282NG5ttuq5L37cAzrzqQegdI7ZFVujaEhpu/o=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08IFcvoQ122262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 10:38:57 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 10:38:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 10:38:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IFcuB3094740;
        Fri, 18 Sep 2020 10:38:56 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v3 4/4] arm64: dts: ti: k3-j7200-common-proc-board: add mcu cpsw nuss pinmux and phy defs
Date:   Fri, 18 Sep 2020 18:38:29 +0300
Message-ID: <20200918153829.14686-5-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918153829.14686-1-grygorii.strashko@ti.com>
References: <20200918153829.14686-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI j7200 EVM base board has TI DP83867 PHY connected to external CPSW
NUSS Port 1 in rgmii-rxid mode.

Hence, add pinmux and Ethernet PHY configuration for TI j7200 SoC MCU
Gigabit Ethernet two ports Switch subsystem (CPSW NUSS).

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index e27069317c4e..f7e6b9b5ef5f 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "k3-j7200-som-p0.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
 
 / {
 	chosen {
@@ -14,6 +15,32 @@
 	};
 };
 
+&wkup_pmx0 {
+	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x0068, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
+			J721E_WKUP_IOPAD(0x006c, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
+			J721E_WKUP_IOPAD(0x0070, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
+			J721E_WKUP_IOPAD(0x0074, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
+			J721E_WKUP_IOPAD(0x0078, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
+			J721E_WKUP_IOPAD(0x007c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
+			J721E_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
+			J721E_WKUP_IOPAD(0x008c, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
+			J721E_WKUP_IOPAD(0x0090, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
+			J721E_WKUP_IOPAD(0x0094, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
+			J721E_WKUP_IOPAD(0x0080, PIN_INPUT, 0) /* MCU_RGMII1_TXC */
+			J721E_WKUP_IOPAD(0x0084, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
+		>;
+	};
+
+	mcu_mdio_pins_default: mcu-mdio1-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0x009c, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
+			J721E_WKUP_IOPAD(0x0098, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
+		>;
+	};
+};
+
 &wkup_uart0 {
 	/* Wakeup UART is used by System firmware */
 	status = "disabled";
@@ -62,3 +89,21 @@
 	/* UART not brought out */
 	status = "disabled";
 };
+
+&mcu_cpsw {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+};
+
+&davinci_mdio {
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&phy0>;
+};
-- 
2.17.1

