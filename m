Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C628077B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733076AbgJATG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:06:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48526 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733025AbgJATG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:06:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091J6Ja2034346;
        Thu, 1 Oct 2020 14:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601579179;
        bh=7TSxtbrB8Ulz1iEBfQ+PWme41z8+AlBI45mjLZ5+iHE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cBJsTFmtGXZAD+FvTthvCIAeuXC9GT22Q1eGnRZUrRFH2DkOY1mJAldwRXiA/habZ
         etFBRLq04yRaJvstBuiZ1nw09aclzF91QX0q2mQ6ovuSmj08qpxArzgGiIp2qXBQdK
         BkCD8FBiXf8SpwPfHYJh6DCgkJJURZsvahfqA5oo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091J6J7J043230
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 14:06:19 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 14:06:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 14:06:19 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091J5gYr070134;
        Thu, 1 Oct 2020 14:06:15 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <will@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 6/8] arm64: dts: ti: k3-j7200-common-proc-board: Add support SD card UHS modes
Date:   Fri, 2 Oct 2020 00:35:39 +0530
Message-ID: <20201001190541.6364-7-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001190541.6364-1-faiz_abbas@ti.com>
References: <20201001190541.6364-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for UHS modes for the SD card connected at sdhci1. This
involves adding regulators for voltage switching and power cycling the
SD card and removing the no-1-8-v property.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 32 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  1 -
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 50d330245a42..02112c2a63e9 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -7,12 +7,36 @@
 
 #include "k3-j7200-som-p0.dtsi"
 #include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	chosen {
 		stdout-path = "serial2:115200n8";
 		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
 	};
+
+	vdd_mmc1: fixedregulator-sd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpios = <&exp2 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	vdd_sd_dv: gpio-regulator-vdd-sd-dv {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd_sd_dv";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		gpios = <&main_gpio0 55 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0
+			  3300000 0x1>;
+	};
 };
 
 &wkup_pmx0 {
@@ -68,6 +92,12 @@
 			J721E_IOPAD(0xe4, PIN_INPUT, 8) /* (V1) TIMER_IO0.MMC1_SDCD */
 		>;
 	};
+
+	vdd_sd_dv_pins_default: vdd_sd_dv_pins_default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0xd0, PIN_INPUT, 7) /* (T5) SPI0_D1.GPIO0_55 */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -196,6 +226,8 @@
 
 &main_sdhci1 {
 	/* SD card */
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv>;
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	pinctrl-names = "default";
 	ti,driver-strength-ohm = <50>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index f21f22237e0f..7307a94f7f3e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -392,7 +392,6 @@
 		ti,otap-del-sel-sdr50 = <0xc>;
 		ti,otap-del-sel-sdr104 = <0x5>;
 		ti,otap-del-sel-ddr50 = <0xc>;
-		no-1-8-v;
 		dma-coherent;
 	};
 
-- 
2.17.1

