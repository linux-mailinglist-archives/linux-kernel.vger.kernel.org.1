Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BAC2E94BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbhADMXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:23:31 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52844 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADMXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:23:30 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 104CMlcJ092723;
        Mon, 4 Jan 2021 06:22:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609762967;
        bh=bcKpGUBe0fOJfXDJUBX9rPDmhCuFi5ZCwNpQdzadubE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WcRsXGJC7qI+Iugod/lEHKg25OtIHn2Lox8+seU3OwHDoeG1z9iOwS4V01vtc/NFJ
         AELod16DhKEp2moNhl6PKEB8lHL9hTvWTvzMt2pOk/O/XrRzgDGxoxaiNAxL75NqIA
         80LO7htfDSt/0pXc23PVNHChPXsS70GJ6rl1JepA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 104CMlQR055757
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jan 2021 06:22:47 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 Jan
 2021 06:22:46 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 Jan 2021 06:22:46 -0600
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 104CMZhP002211;
        Mon, 4 Jan 2021 06:22:44 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/6] arm64: dts: ti: k3-j7200-main: Add SERDES and WIZ device tree node
Date:   Mon, 4 Jan 2021 17:52:29 +0530
Message-ID: <20210104122232.24071-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210104122232.24071-1-kishon@ti.com>
References: <20210104122232.24071-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt node for the single instance of WIZ (SERDES wrapper) and
SERDES module shared by PCIe, CPSW (SGMII/QSGMII) and USB.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 63 +++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index b0094212aa82..fbe4cd1e6e09 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -5,6 +5,13 @@
  * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+/ {
+	serdes_refclk: serdes-refclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+	};
+};
+
 &cbass_main {
 	msmc_ram: sram@70000000 {
 		compatible = "mmio-sram";
@@ -531,6 +538,62 @@
 		dma-coherent;
 	};
 
+	serdes_wiz0: wiz@5060000 {
+		compatible = "ti,j721e-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 292 11>, <&k3_clks 292 85>, <&serdes_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		ranges = <0x5060000 0x0 0x5060000 0x10000>;
+
+		assigned-clocks = <&k3_clks 292 85>;
+		assigned-clock-parents = <&k3_clks 292 89>;
+
+		wiz0_pll0_refclk: pll0-refclk {
+			clocks = <&k3_clks 292 85>, <&serdes_refclk>;
+			clock-output-names = "wiz0_pll0_refclk";
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz0_pll0_refclk>;
+			assigned-clock-parents = <&k3_clks 292 85>;
+		};
+
+		wiz0_pll1_refclk: pll1-refclk {
+			clocks = <&k3_clks 292 85>, <&serdes_refclk>;
+			clock-output-names = "wiz0_pll1_refclk";
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz0_pll1_refclk>;
+			assigned-clock-parents = <&k3_clks 292 85>;
+		};
+
+		wiz0_refclk_dig: refclk-dig {
+			clocks = <&k3_clks 292 85>, <&serdes_refclk>;
+			clock-output-names = "wiz0_refclk_dig";
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz0_refclk_dig>;
+			assigned-clock-parents = <&k3_clks 292 85>;
+		};
+
+		wiz0_cmn_refclk_dig_div: cmn-refclk-dig-div {
+			clocks = <&wiz0_refclk_dig>;
+			#clock-cells = <0>;
+		};
+
+		serdes0: serdes@5060000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05060000 0x00010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz0 0>;
+			reset-names = "torrent_reset";
+			clocks = <&wiz0_pll0_refclk>;
+			clock-names = "refclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	usbss0: cdns-usb@4104000 {
 		compatible = "ti,j721e-usb";
 		reg = <0x00 0x4104000 0x00 0x100>;
-- 
2.17.1

