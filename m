Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6732E0691
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgLVHHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:07:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59186 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgLVHHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:07:19 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BM76BnK034492;
        Tue, 22 Dec 2020 01:06:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608620771;
        bh=QTzzUhajMm8IhBdGfHPyShrRRd86TMVhnsXp4t435rE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RbMVg0/WfeDhjGQFt1h4lNJmWLd/5u4RqFwc9+PDCyoUml4OZwsvkL8t7rzCIABN+
         oP9yTK968Ron+3Lpoh175jjyRRoK6Wb1on6VSE8vLp8OauW6JTPwPG+xiBSYt8NdJA
         KhdkoKXu2jsrqEdvdPNGrvM2KQPR0Z2npplvlGjM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BM766S3109122
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 01:06:06 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 01:06:05 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 01:06:05 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BM75N7K050344;
        Tue, 22 Dec 2020 01:06:02 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nishanth Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 11/14] arm64: dts: ti: k3-j721e-main: Add DT nodes for clocks within Sierra SERDES
Date:   Tue, 22 Dec 2020 12:35:17 +0530
Message-ID: <20201222070520.28132-12-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222070520.28132-1-kishon@ti.com>
References: <20201222070520.28132-1-kishon@ti.com>
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
index b32df591c766..00d2d51689f1 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -432,8 +432,36 @@
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
 
@@ -489,8 +517,36 @@
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
 
@@ -546,8 +602,36 @@
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
 
@@ -603,8 +687,36 @@
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

