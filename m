Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85772E2631
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgLXLS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:18:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35732 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgLXLSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:18:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBHbob076276;
        Thu, 24 Dec 2020 05:17:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608808657;
        bh=TA56idjSLu14l1mLeNOv3BuYpulaKUC46doLv8n2T5I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=t2PpE3bQhvJn/i8xiij4TYjy8c5u6bPRFje0AmzFHa0mcMAjM0EJ8YKJWHINkzWGq
         oS6KphtURwQW92h4cbePiat6RmlJjE7+KRp9g5I7ax/Ij/6pPkuijd8NMWTfLfamTw
         Ts3qQ6z/UOuM/adx9bg0iSipHcn+LtqBiaZy5LLI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBHbDE094263
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:17:37 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:17:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:17:37 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGWGI116630;
        Thu, 24 Dec 2020 05:17:33 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 12/15] arm64: dts: ti: k3-j721e-main: Add DT nodes for clocks within Sierra SERDES
Date:   Thu, 24 Dec 2020 16:46:24 +0530
Message-ID: <20201224111627.32590-13-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224111627.32590-1-kishon@ti.com>
References: <20201224111627.32590-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for clocks within Sierra SERDES.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 128 ++++++++++++++++++++--
 1 file changed, 120 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 2d526ea44a85..9d1edce31829 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -400,8 +400,36 @@
 			#size-cells = <0>;
 			resets = <&serdes_wiz0 0>;
 			reset-names = "sierra_reset";
-			clocks = <&wiz0_cmn_refclk_dig_div>, <&wiz0_cmn_refclk1_dig_div>;
-			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+			clocks = <&wiz0_cmn_refclk_dig_div>, <&wiz0_cmn_refclk1_dig_div>, <&serdes0_pll_cmnlc>, <&serdes0_pll_cmnlc1>;
+			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div", "pll_cmnlc", "pll_cmnlc1";
+
+			serdes0_refrcv: refrcv {
+				clocks = <&wiz0_pll0_refclk>;
+				clock-names = "pll_refclk";
+				#clock-cells = <0>;
+			};
+
+			serdes0_refrcv1: refrcv1 {
+				clocks = <&wiz0_pll1_refclk>;
+				clock-names = "pll_refclk";
+				#clock-cells = <0>;
+			};
+
+			serdes0_pll_cmnlc: pll_cmnlc {
+				clocks = <&wiz0_pll0_refclk>, <&serdes0_refrcv1>;
+				clock-names = "pll_refclk", "refrcv";
+				#clock-cells = <0>;
+				assigned-clocks = <&serdes0_pll_cmnlc>;
+				assigned-clock-parents = <&wiz0_pll0_refclk>;
+			};
+
+			serdes0_pll_cmnlc1: pll_cmnlc1 {
+				clocks = <&wiz0_pll1_refclk>, <&serdes0_refrcv>;
+				clock-names = "pll_refclk", "refrcv";
+				#clock-cells = <0>;
+				assigned-clocks = <&serdes0_pll_cmnlc1>;
+				assigned-clock-parents = <&wiz0_pll1_refclk>;
+			};
 		};
 	};
 
@@ -457,8 +485,36 @@
 			#size-cells = <0>;
 			resets = <&serdes_wiz1 0>;
 			reset-names = "sierra_reset";
-			clocks = <&wiz1_cmn_refclk_dig_div>, <&wiz1_cmn_refclk1_dig_div>;
-			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+			clocks = <&wiz1_cmn_refclk_dig_div>, <&wiz1_cmn_refclk1_dig_div>, <&serdes1_pll_cmnlc>, <&serdes1_pll_cmnlc1>;
+			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div", "pll_cmnlc", "pll_cmnlc1";
+
+			serdes1_refrcv: refrcv {
+				clocks = <&wiz1_pll0_refclk>;
+				clock-names = "pll_refclk";
+				#clock-cells = <0>;
+			};
+
+			serdes1_refrcv1: refrcv1 {
+				clocks = <&wiz1_pll1_refclk>;
+				clock-names = "pll_refclk";
+				#clock-cells = <0>;
+			};
+
+			serdes1_pll_cmnlc: pll_cmnlc {
+				clocks = <&wiz1_pll0_refclk>, <&serdes1_refrcv1>;
+				clock-names = "pll_refclk", "refrcv";
+				#clock-cells = <0>;
+				assigned-clocks = <&serdes1_pll_cmnlc>;
+				assigned-clock-parents = <&wiz1_pll0_refclk>;
+			};
+
+			serdes1_pll_cmnlc1: pll_cmnlc1 {
+				clocks = <&wiz1_pll1_refclk>, <&serdes1_refrcv>;
+				clock-names = "pll_refclk", "refrcv";
+				#clock-cells = <0>;
+				assigned-clocks = <&serdes1_pll_cmnlc1>;
+				assigned-clock-parents = <&wiz1_pll1_refclk>;
+			};
 		};
 	};
 
@@ -514,8 +570,36 @@
 			#size-cells = <0>;
 			resets = <&serdes_wiz2 0>;
 			reset-names = "sierra_reset";
-			clocks = <&wiz2_cmn_refclk_dig_div>, <&wiz2_cmn_refclk1_dig_div>;
-			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+			clocks = <&wiz2_cmn_refclk_dig_div>, <&wiz2_cmn_refclk1_dig_div>, <&serdes2_pll_cmnlc>, <&serdes2_pll_cmnlc1>;
+			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div", "pll_cmnlc", "pll_cmnlc1";
+
+			serdes2_refrcv: refrcv {
+				clocks = <&wiz2_pll0_refclk>;
+				clock-names = "pll_refclk";
+				#clock-cells = <0>;
+			};
+
+			serdes2_refrcv1: refrcv1 {
+				clocks = <&wiz2_pll1_refclk>;
+				clock-names = "pll_refclk";
+				#clock-cells = <0>;
+			};
+
+			serdes2_pll_cmnlc: pll_cmnlc {
+				clocks = <&wiz2_pll0_refclk>, <&serdes2_refrcv1>;
+				clock-names = "pll_refclk", "refrcv";
+				#clock-cells = <0>;
+				assigned-clocks = <&serdes2_pll_cmnlc>;
+				assigned-clock-parents = <&wiz2_pll0_refclk>;
+			};
+
+			serdes2_pll_cmnlc1: pll_cmnlc1 {
+				clocks = <&wiz2_pll1_refclk>, <&serdes2_refrcv>;
+				clock-names = "pll_refclk", "refrcv";
+				#clock-cells = <0>;
+				assigned-clocks = <&serdes2_pll_cmnlc1>;
+				assigned-clock-parents = <&wiz2_pll1_refclk>;
+			};
 		};
 	};
 
@@ -571,8 +655,36 @@
 			#size-cells = <0>;
 			resets = <&serdes_wiz3 0>;
 			reset-names = "sierra_reset";
-			clocks = <&wiz3_cmn_refclk_dig_div>, <&wiz3_cmn_refclk1_dig_div>;
-			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div";
+			clocks = <&wiz3_cmn_refclk_dig_div>, <&wiz3_cmn_refclk1_dig_div>, <&serdes3_pll_cmnlc>, <&serdes3_pll_cmnlc1>;
+			clock-names = "cmn_refclk_dig_div", "cmn_refclk1_dig_div", "pll_cmnlc", "pll_cmnlc1";
+
+			serdes3_refrcv: refrcv {
+				clocks = <&wiz3_pll0_refclk>;
+				clock-names = "pll_refclk";
+				#clock-cells = <0>;
+			};
+
+			serdes3_refrcv1: refrcv1 {
+				clocks = <&wiz3_pll1_refclk>;
+				clock-names = "pll_refclk";
+				#clock-cells = <0>;
+			};
+
+			serdes3_pll_cmnlc: pll_cmnlc {
+				clocks = <&wiz3_pll0_refclk>, <&serdes3_refrcv1>;
+				clock-names = "pll_refclk", "refrcv";
+				#clock-cells = <0>;
+				assigned-clocks = <&serdes3_pll_cmnlc>;
+				assigned-clock-parents = <&wiz3_pll0_refclk>;
+			};
+
+			serdes3_pll_cmnlc1: pll_cmnlc1 {
+				clocks = <&wiz3_pll1_refclk>, <&serdes3_refrcv>;
+				clock-names = "pll_refclk", "refrcv";
+				#clock-cells = <0>;
+				assigned-clocks = <&serdes3_pll_cmnlc1>;
+				assigned-clock-parents = <&wiz3_pll1_refclk>;
+			};
 		};
 	};
 
-- 
2.17.1

