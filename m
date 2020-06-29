Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0884B20D13A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgF2Sjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:39:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54506 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgF2Sjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:39:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05TCr4Ph015342;
        Mon, 29 Jun 2020 07:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593435184;
        bh=prnwTOgxqOwaVzHicWh00ZrdSrVyEiINn+lOenIn0iI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KN/J4ROR/oI5Az5/BT4HzEw3lmfTgU9XuuKif52wr4+knLyt8ZqQ53HDp0MRiyuXr
         VKuqfawTMNL0HmyO0GpHpR6onydb7AT2EqQyU3aOccmijzvJ+7s8VuEunDX+lg9qFe
         lF/r2rSe3H9fB1x/q5Wxm6+imz5T/SWjIEbPuD4o=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05TCr4RE111295
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jun 2020 07:53:04 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 29
 Jun 2020 07:53:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 29 Jun 2020 07:53:03 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05TCqugx015456;
        Mon, 29 Jun 2020 07:53:02 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 2/6] arm64: dts: ti: k3-j721e-main: Add WIZ and SERDES PHY nodes
Date:   Mon, 29 Jun 2020 15:52:50 +0300
Message-ID: <20200629125254.28754-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629125254.28754-1-rogerq@ti.com>
References: <20200629125254.28754-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

Add DT nodes for all instances of WIZ and SERDES modules.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 241 ++++++++++++++++++++++
 1 file changed, 241 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 96c929da639d..b11cb51af747 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
  */
+#include <dt-bindings/phy/phy.h>
 
 &cbass_main {
 	msmc_ram: sram@70000000 {
@@ -277,6 +278,246 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	dummy_cmn_refclk: dummy-cmn-refclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <100000000>;
+	};
+
+	dummy_cmn_refclk1: dummy-cmn-refclk1 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <100000000>;
+	};
+
+	serdes_wiz0: wiz@5000000 {
+		compatible = "ti,j721e-wiz-16g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&dummy_cmn_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		assigned-clocks = <&k3_clks 292 11>, <&k3_clks 292 0>;
+		assigned-clock-parents = <&k3_clks 292 15>, <&k3_clks 292 4>;
+		num-lanes = <2>;
+		#reset-cells = <1>;
+		ranges = <0x5000000 0x0 0x5000000 0x10000>;
+
+		wiz0_pll0_refclk: pll0-refclk {
+			clocks = <&k3_clks 292 11>, <&dummy_cmn_refclk>;
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz0_pll0_refclk>;
+			assigned-clock-parents = <&k3_clks 292 11>;
+		};
+
+		wiz0_pll1_refclk: pll1-refclk {
+			clocks = <&k3_clks 292 0>, <&dummy_cmn_refclk1>;
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz0_pll1_refclk>;
+			assigned-clock-parents = <&k3_clks 292 0>;
+		};
+
+		wiz0_refclk_dig: refclk-dig {
+			clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz0_refclk_dig>;
+			assigned-clock-parents = <&k3_clks 292 11>;
+		};
+
+		wiz0_cmn_refclk_dig_div: cmn-refclk-dig-div {
+			clocks = <&wiz0_refclk_dig>;
+			#clock-cells = <0>;
+		};
+
+		wiz0_cmn_refclk1_dig_div: cmn-refclk1-dig-div {
+			clocks = <&wiz0_pll1_refclk>;
+			#clock-cells = <0>;
+		};
+
+		serdes0: serdes@5000000 {
+			compatible = "ti,sierra-phy-t0";
+			reg-names = "serdes";
+			reg = <0x5000000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			resets = <&serdes_wiz0 0>;
+			reset-names = "sierra_reset";
+			clocks = <&wiz0_cmn_refclk_dig_div>, <&wiz0_cmn_refclk1_dig_div>;
+			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+		};
+	};
+
+	serdes_wiz1: wiz@5010000 {
+		compatible = "ti,j721e-wiz-16g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 293 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 293 5>, <&k3_clks 293 13>, <&dummy_cmn_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		assigned-clocks = <&k3_clks 293 13>, <&k3_clks 293 0>;
+		assigned-clock-parents = <&k3_clks 293 17>, <&k3_clks 293 4>;
+		num-lanes = <2>;
+		#reset-cells = <1>;
+		ranges = <0x5010000 0x0 0x5010000 0x10000>;
+
+		wiz1_pll0_refclk: pll0-refclk {
+			clocks = <&k3_clks 293 13>, <&dummy_cmn_refclk>;
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz1_pll0_refclk>;
+			assigned-clock-parents = <&k3_clks 293 13>;
+		};
+
+		wiz1_pll1_refclk: pll1-refclk {
+			clocks = <&k3_clks 293 0>, <&dummy_cmn_refclk1>;
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz1_pll1_refclk>;
+			assigned-clock-parents = <&k3_clks 293 0>;
+		};
+
+		wiz1_refclk_dig: refclk-dig {
+			clocks = <&k3_clks 293 13>, <&k3_clks 293 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz1_refclk_dig>;
+			assigned-clock-parents = <&k3_clks 293 13>;
+		};
+
+		wiz1_cmn_refclk_dig_div: cmn-refclk-dig-div{
+			clocks = <&wiz1_refclk_dig>;
+			#clock-cells = <0>;
+		};
+
+		wiz1_cmn_refclk1_dig_div: cmn-refclk1-dig-div {
+			clocks = <&wiz1_pll1_refclk>;
+			#clock-cells = <0>;
+		};
+
+		serdes1: serdes@5010000 {
+			compatible = "ti,sierra-phy-t0";
+			reg-names = "serdes";
+			reg = <0x5010000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			resets = <&serdes_wiz1 0>;
+			reset-names = "sierra_reset";
+			clocks = <&wiz1_cmn_refclk_dig_div>, <&wiz1_cmn_refclk1_dig_div>;
+			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+		};
+	};
+
+	serdes_wiz2: wiz@5020000 {
+		compatible = "ti,j721e-wiz-16g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 294 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 294 5>, <&k3_clks 294 11>, <&dummy_cmn_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		assigned-clocks = <&k3_clks 294 11>, <&k3_clks 294 0>;
+		assigned-clock-parents = <&k3_clks 294 15>, <&k3_clks 294 4>;
+		num-lanes = <2>;
+		#reset-cells = <1>;
+		ranges = <0x5020000 0x0 0x5020000 0x10000>;
+
+		wiz2_pll0_refclk: pll0-refclk {
+			clocks = <&k3_clks 294 11>, <&dummy_cmn_refclk>;
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz2_pll0_refclk>;
+			assigned-clock-parents = <&k3_clks 294 11>;
+		};
+
+		wiz2_pll1_refclk: pll1-refclk {
+			clocks = <&k3_clks 294 0>, <&dummy_cmn_refclk1>;
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz2_pll1_refclk>;
+			assigned-clock-parents = <&k3_clks 294 0>;
+		};
+
+		wiz2_refclk_dig: refclk-dig {
+			clocks = <&k3_clks 294 11>, <&k3_clks 294 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz2_refclk_dig>;
+			assigned-clock-parents = <&k3_clks 294 11>;
+		};
+
+		wiz2_cmn_refclk_dig_div: cmn-refclk-dig-div {
+			clocks = <&wiz2_refclk_dig>;
+			#clock-cells = <0>;
+		};
+
+		wiz2_cmn_refclk1_dig_div: cmn-refclk1-dig-div {
+			clocks = <&wiz2_pll1_refclk>;
+			#clock-cells = <0>;
+		};
+
+		serdes2: serdes@5020000 {
+			compatible = "ti,sierra-phy-t0";
+			reg-names = "serdes";
+			reg = <0x5020000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			resets = <&serdes_wiz2 0>;
+			reset-names = "sierra_reset";
+			clocks = <&wiz2_cmn_refclk_dig_div>, <&wiz2_cmn_refclk1_dig_div>;
+			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+		};
+	};
+
+	serdes_wiz3: wiz@5030000 {
+		compatible = "ti,j721e-wiz-16g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 295 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 295 5>, <&k3_clks 295 9>, <&dummy_cmn_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		assigned-clocks = <&k3_clks 295 9>, <&k3_clks 295 0>;
+		assigned-clock-parents = <&k3_clks 295 13>, <&k3_clks 295 4>;
+		num-lanes = <2>;
+		#reset-cells = <1>;
+		ranges = <0x5030000 0x0 0x5030000 0x10000>;
+
+		wiz3_pll0_refclk: pll0-refclk {
+			clocks = <&k3_clks 295 9>, <&dummy_cmn_refclk>;
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz3_pll0_refclk>;
+			assigned-clock-parents = <&k3_clks 295 9>;
+		};
+
+		wiz3_pll1_refclk: pll1-refclk {
+			clocks = <&k3_clks 295 0>, <&dummy_cmn_refclk1>;
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz3_pll1_refclk>;
+			assigned-clock-parents = <&k3_clks 295 0>;
+		};
+
+		wiz3_refclk_dig: refclk-dig {
+			clocks = <&k3_clks 295 9>, <&k3_clks 295 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz3_refclk_dig>;
+			assigned-clock-parents = <&k3_clks 295 9>;
+		};
+
+		wiz3_cmn_refclk_dig_div: cmn-refclk-dig-div {
+			clocks = <&wiz3_refclk_dig>;
+			#clock-cells = <0>;
+		};
+
+		wiz3_cmn_refclk1_dig_div: cmn-refclk1-dig-div {
+			clocks = <&wiz3_pll1_refclk>;
+			#clock-cells = <0>;
+		};
+
+		serdes3: serdes@5030000 {
+			compatible = "ti,sierra-phy-t0";
+			reg-names = "serdes";
+			reg = <0x5030000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			resets = <&serdes_wiz3 0>;
+			reset-names = "sierra_reset";
+			clocks = <&wiz3_cmn_refclk_dig_div>, <&wiz3_cmn_refclk1_dig_div>;
+			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+		};
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

