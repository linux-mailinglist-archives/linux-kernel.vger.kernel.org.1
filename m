Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C101D2E263E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgLXLT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:19:28 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35746 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgLXLT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:19:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBHgOV076292;
        Thu, 24 Dec 2020 05:17:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608808662;
        bh=ldtRgeUKammL4+qtr5CA5LK2LIOwvnUVwhoio6N+/GE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vZZhO7bBdpFiwtDahIIaOGZoaQBMmu6Q/zurOkhC+p15a7Gn4lV3VeEExvmezcOBI
         N4mrii7pu2pOzDsZ7IkEC5xOE6qvaKs/2UQLo5Vp1A0uY7esRe0gOqIwcjaAqsAH4/
         FC7yG5NRG6uxHoTRsikUO4pXvciW7KG+8QkKgWQw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBHgoN061386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:17:42 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:17:42 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:17:42 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGWGJ116630;
        Thu, 24 Dec 2020 05:17:38 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 13/15] arm64: dts: ti: k3-j721e-main: Fix external refclk input to SERDES
Date:   Thu, 24 Dec 2020 16:46:25 +0530
Message-ID: <20201224111627.32590-14-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224111627.32590-1-kishon@ti.com>
References: <20201224111627.32590-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the external refclk inputs to the SERDES from
dummy_cmn_refclk/dummy_cmn_refclk1 to cmn_refclk/cmn_refclk1
respectively. Also move the external refclk DT nodes outside the
cbass_main DT node. Since in j721e common processor board, only the
cmn_refclk1 is connected to 100MHz clock, fix the clock frequency.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     |  4 ++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 58 ++++++++++---------
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 60764366e22b..86f7ab511ee8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -635,6 +635,10 @@
 	status = "disabled";
 };
 
+&cmn_refclk1 {
+	clock-frequency = <100000000>;
+};
+
 &serdes0 {
 	serdes0_pcie_link: link@0 {
 		reg = <0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 9d1edce31829..20cb390d33b0 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -8,6 +8,20 @@
 #include <dt-bindings/mux/mux.h>
 #include <dt-bindings/mux/ti-serdes.h>
 
+/ {
+	cmn_refclk: cmn-refclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	cmn_refclk1: cmn-refclk1 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+};
+
 &cbass_main {
 	msmc_ram: sram@70000000 {
 		compatible = "mmio-sram";
@@ -336,24 +350,12 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	dummy_cmn_refclk: dummy-cmn-refclk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <100000000>;
-	};
-
-	dummy_cmn_refclk1: dummy-cmn-refclk1 {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <100000000>;
-	};
-
 	serdes_wiz0: wiz@5000000 {
 		compatible = "ti,j721e-wiz-16g";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&dummy_cmn_refclk>;
+		clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&cmn_refclk>;
 		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
 		assigned-clocks = <&k3_clks 292 11>, <&k3_clks 292 0>;
 		assigned-clock-parents = <&k3_clks 292 15>, <&k3_clks 292 4>;
@@ -362,21 +364,21 @@
 		ranges = <0x5000000 0x0 0x5000000 0x10000>;
 
 		wiz0_pll0_refclk: pll0-refclk {
-			clocks = <&k3_clks 292 11>, <&dummy_cmn_refclk>;
+			clocks = <&k3_clks 292 11>, <&cmn_refclk>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz0_pll0_refclk>;
 			assigned-clock-parents = <&k3_clks 292 11>;
 		};
 
 		wiz0_pll1_refclk: pll1-refclk {
-			clocks = <&k3_clks 292 0>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 292 0>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz0_pll1_refclk>;
 			assigned-clock-parents = <&k3_clks 292 0>;
 		};
 
 		wiz0_refclk_dig: refclk-dig {
-			clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 292 11>, <&k3_clks 292 0>, <&cmn_refclk>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz0_refclk_dig>;
 			assigned-clock-parents = <&k3_clks 292 11>;
@@ -438,7 +440,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		power-domains = <&k3_pds 293 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 293 5>, <&k3_clks 293 13>, <&dummy_cmn_refclk>;
+		clocks = <&k3_clks 293 5>, <&k3_clks 293 13>, <&cmn_refclk>;
 		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
 		assigned-clocks = <&k3_clks 293 13>, <&k3_clks 293 0>;
 		assigned-clock-parents = <&k3_clks 293 17>, <&k3_clks 293 4>;
@@ -447,21 +449,21 @@
 		ranges = <0x5010000 0x0 0x5010000 0x10000>;
 
 		wiz1_pll0_refclk: pll0-refclk {
-			clocks = <&k3_clks 293 13>, <&dummy_cmn_refclk>;
+			clocks = <&k3_clks 293 13>, <&cmn_refclk>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz1_pll0_refclk>;
 			assigned-clock-parents = <&k3_clks 293 13>;
 		};
 
 		wiz1_pll1_refclk: pll1-refclk {
-			clocks = <&k3_clks 293 0>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 293 0>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz1_pll1_refclk>;
 			assigned-clock-parents = <&k3_clks 293 0>;
 		};
 
 		wiz1_refclk_dig: refclk-dig {
-			clocks = <&k3_clks 293 13>, <&k3_clks 293 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 293 13>, <&k3_clks 293 0>, <&cmn_refclk>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz1_refclk_dig>;
 			assigned-clock-parents = <&k3_clks 293 13>;
@@ -523,7 +525,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		power-domains = <&k3_pds 294 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 294 5>, <&k3_clks 294 11>, <&dummy_cmn_refclk>;
+		clocks = <&k3_clks 294 5>, <&k3_clks 294 11>, <&cmn_refclk>;
 		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
 		assigned-clocks = <&k3_clks 294 11>, <&k3_clks 294 0>;
 		assigned-clock-parents = <&k3_clks 294 15>, <&k3_clks 294 4>;
@@ -532,21 +534,21 @@
 		ranges = <0x5020000 0x0 0x5020000 0x10000>;
 
 		wiz2_pll0_refclk: pll0-refclk {
-			clocks = <&k3_clks 294 11>, <&dummy_cmn_refclk>;
+			clocks = <&k3_clks 294 11>, <&cmn_refclk>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz2_pll0_refclk>;
 			assigned-clock-parents = <&k3_clks 294 11>;
 		};
 
 		wiz2_pll1_refclk: pll1-refclk {
-			clocks = <&k3_clks 294 0>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 294 0>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz2_pll1_refclk>;
 			assigned-clock-parents = <&k3_clks 294 0>;
 		};
 
 		wiz2_refclk_dig: refclk-dig {
-			clocks = <&k3_clks 294 11>, <&k3_clks 294 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 294 11>, <&k3_clks 294 0>, <&cmn_refclk>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz2_refclk_dig>;
 			assigned-clock-parents = <&k3_clks 294 11>;
@@ -608,7 +610,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		power-domains = <&k3_pds 295 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 295 5>, <&k3_clks 295 9>, <&dummy_cmn_refclk>;
+		clocks = <&k3_clks 295 5>, <&k3_clks 295 9>, <&cmn_refclk>;
 		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
 		assigned-clocks = <&k3_clks 295 9>, <&k3_clks 295 0>;
 		assigned-clock-parents = <&k3_clks 295 13>, <&k3_clks 295 4>;
@@ -617,21 +619,21 @@
 		ranges = <0x5030000 0x0 0x5030000 0x10000>;
 
 		wiz3_pll0_refclk: pll0-refclk {
-			clocks = <&k3_clks 295 9>, <&dummy_cmn_refclk>;
+			clocks = <&k3_clks 295 9>, <&cmn_refclk>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz3_pll0_refclk>;
 			assigned-clock-parents = <&k3_clks 295 9>;
 		};
 
 		wiz3_pll1_refclk: pll1-refclk {
-			clocks = <&k3_clks 295 0>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 295 0>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz3_pll1_refclk>;
 			assigned-clock-parents = <&k3_clks 295 0>;
 		};
 
 		wiz3_refclk_dig: refclk-dig {
-			clocks = <&k3_clks 295 9>, <&k3_clks 295 0>, <&dummy_cmn_refclk>, <&dummy_cmn_refclk1>;
+			clocks = <&k3_clks 295 9>, <&k3_clks 295 0>, <&cmn_refclk>, <&cmn_refclk1>;
 			#clock-cells = <0>;
 			assigned-clocks = <&wiz3_refclk_dig>;
 			assigned-clock-parents = <&k3_clks 295 9>;
-- 
2.17.1

