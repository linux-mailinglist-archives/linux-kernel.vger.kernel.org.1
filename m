Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215AB2E2641
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgLXLTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:19:34 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35756 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgLXLT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:19:28 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBHlnI076299;
        Thu, 24 Dec 2020 05:17:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608808667;
        bh=14cbnSxHB44iZkpTWbvcT9c4bCPw1pt8QKkVr6DRwOw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dNL8+IajYYcwHIMcONVNE6wWn9oJbQVX3WN2Bf2JRIPs3yN4OfinRR90yoICgegUp
         cmqB6pRQI0AvqIrpLL1GjW2g3IPlPXRt0fFPB1bQ2yf6KPBsxbuGyhcmr/Hn0MJbJh
         z9axrQas3+dyluJ7rrHk9zB3yvN1ZyUj9d/3gIkg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBHlAD094322
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:17:47 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:17:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:17:46 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGWGK116630;
        Thu, 24 Dec 2020 05:17:43 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 14/15] arm64: dts: ti: k3-j721e-common-proc-board: Use external clock for SERDES
Date:   Thu, 24 Dec 2020 16:46:26 +0530
Message-ID: <20201224111627.32590-15-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224111627.32590-1-kishon@ti.com>
References: <20201224111627.32590-1-kishon@ti.com>
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

