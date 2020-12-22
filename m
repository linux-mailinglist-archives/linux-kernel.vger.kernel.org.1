Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567922E068F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgLVHHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:07:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54106 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLVHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:07:17 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BM76Dei064338;
        Tue, 22 Dec 2020 01:06:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608620773;
        bh=14cbnSxHB44iZkpTWbvcT9c4bCPw1pt8QKkVr6DRwOw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vR+rr+Zo9MLESkQRQA67Sk6S3ilWJuNq0VwR9tEt+70u0mwTWOwOLTcCUQDiXTWlH
         tIOXclliAv+AzLDJV5I7y6af6pkTkKY5aV1kyHfS2T+S4zlHtbwdffHVIpweF6lvrT
         g4/uw9mIJP3y4ADuhYUvIwCzHF2m3SaHxr1BI8oE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BM76DvR109324
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 01:06:13 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 01:06:12 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 01:06:12 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BM75N7M050344;
        Tue, 22 Dec 2020 01:06:09 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nishanth Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 13/14] arm64: dts: ti: k3-j721e-common-proc-board: Use external clock for SERDES
Date:   Tue, 22 Dec 2020 12:35:19 +0530
Message-ID: <20201222070520.28132-14-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222070520.28132-1-kishon@ti.com>
References: <20201222070520.28132-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use external clock for all the SERDES used by PCIe controller. This will
make the same clock used by the local SERDES as well as the clock
provided to the PCIe connector.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 86f7ab511ee8..788126daf91c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -639,6 +639,51 @@
 	clock-frequency = <100000000>;
 };
 
+&wiz0_pll1_refclk {
+	assigned-clocks = <&wiz0_pll1_refclk>;
+	assigned-clock-parents = <&cmn_refclk1>;
+};
+
+&wiz0_refclk_dig {
+	assigned-clocks = <&wiz0_refclk_dig>;
+	assigned-clock-parents = <&cmn_refclk1>;
+};
+
+&serdes0_pll_cmnlc {
+	assigned-clocks = <&serdes0_pll_cmnlc>;
+	assigned-clock-parents = <&serdes0_refrcv1>;
+};
+
+&wiz1_pll1_refclk {
+	assigned-clocks = <&wiz1_pll1_refclk>;
+	assigned-clock-parents = <&cmn_refclk1>;
+};
+
+&wiz1_refclk_dig {
+	assigned-clocks = <&wiz1_refclk_dig>;
+	assigned-clock-parents = <&cmn_refclk1>;
+};
+
+&serdes1_pll_cmnlc {
+	assigned-clocks = <&serdes1_pll_cmnlc>;
+	assigned-clock-parents = <&serdes1_refrcv1>;
+};
+
+&wiz2_pll1_refclk {
+	assigned-clocks = <&wiz2_pll1_refclk>;
+	assigned-clock-parents = <&cmn_refclk1>;
+};
+
+&wiz2_refclk_dig {
+	assigned-clocks = <&wiz2_refclk_dig>;
+	assigned-clock-parents = <&cmn_refclk1>;
+};
+
+&serdes2_pll_cmnlc {
+	assigned-clocks = <&serdes2_pll_cmnlc>;
+	assigned-clock-parents = <&serdes2_refrcv1>;
+};
+
 &serdes0 {
 	serdes0_pcie_link: link@0 {
 		reg = <0>;
-- 
2.17.1

