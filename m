Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC1126E07B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgIQQUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:20:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49622 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgIQQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:17:23 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08HGGrqq042236;
        Thu, 17 Sep 2020 11:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600359413;
        bh=5lU20OTzeQcU31eieOtb5nIQ85me365Qr/oGPgGuChI=;
        h=From:To:CC:Subject:Date;
        b=WomWtlRDesaoRWc4UbG1X7VCiYB9rrIQ56UuR7H+kWPGH5yM0f8S0BpL7vHGLw+6M
         GHW3T3+BMwqfFRhPtiLixKIlY6MWTzYUmldXPyBh8xyjs+0QfjqKuEJrFe1hVVcerT
         Xj+onhARwNKUCevEfj3A5H6eXnNXGOBMQFK6aUEI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08HGGr4j102902
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 11:16:53 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 11:16:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 11:16:53 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HGGo39004196;
        Thu, 17 Sep 2020 11:16:51 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <peda@axentia.se>, <nm@ti.com>
CC:     <t-kristo@ti.com>, <nsekhar@ti.com>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721e: Rename mux header and update macro names
Date:   Thu, 17 Sep 2020 19:16:49 +0300
Message-ID: <20200917161649.27667-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We intend to use one header file for SERDES MUX for all
TI SoCs so rename the header file.

The exsting macros are too generic. Prefix them with SoC name.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 11 ++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 13 +++--
 include/dt-bindings/mux/mux-j721e-wiz.h       | 53 ------------------
 include/dt-bindings/mux/ti-serdes.h           | 55 +++++++++++++++++++
 4 files changed, 68 insertions(+), 64 deletions(-)
 delete mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
 create mode 100644 include/dt-bindings/mux/ti-serdes.h

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 8bc1e6ecc50e..493f64ee7a2a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -404,11 +404,12 @@
 };
 
 &serdes_ln_ctrl {
-	idle-states = <SERDES0_LANE0_PCIE0_LANE0>, <SERDES0_LANE1_PCIE0_LANE1>,
-		      <SERDES1_LANE0_PCIE1_LANE0>, <SERDES1_LANE1_PCIE1_LANE1>,
-		      <SERDES2_LANE0_PCIE2_LANE0>, <SERDES2_LANE1_PCIE2_LANE1>,
-		      <SERDES3_LANE0_USB3_0_SWAP>, <SERDES3_LANE1_USB3_0>,
-		      <SERDES4_LANE0_EDP_LANE0>, <SERDES4_LANE1_EDP_LANE1>, <SERDES4_LANE2_EDP_LANE2>, <SERDES4_LANE3_EDP_LANE3>;
+	idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_PCIE0_LANE1>,
+		      <J721E_SERDES1_LANE0_PCIE1_LANE0>, <J721E_SERDES1_LANE1_PCIE1_LANE1>,
+		      <J721E_SERDES2_LANE0_PCIE2_LANE0>, <J721E_SERDES2_LANE1_PCIE2_LANE1>,
+		      <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,
+		      <J721E_SERDES4_LANE0_EDP_LANE0>, <J721E_SERDES4_LANE1_EDP_LANE1>,
+		      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
 };
 
 &serdes_wiz3 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index d14060207f00..924c51146d01 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -6,7 +6,7 @@
  */
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/mux/mux.h>
-#include <dt-bindings/mux/mux-j721e-wiz.h>
+#include <dt-bindings/mux/ti-serdes.h>
 
 &cbass_main {
 	msmc_ram: sram@70000000 {
@@ -38,11 +38,12 @@
 					<0x40b0 0x3>, <0x40b4 0x3>, /* SERDES3 lane0/1 select */
 					<0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
 					/* SERDES4 lane0/1/2/3 select */
-			idle-states = <SERDES0_LANE0_PCIE0_LANE0>, <SERDES0_LANE1_PCIE0_LANE1>,
-				      <SERDES1_LANE0_PCIE1_LANE0>, <SERDES1_LANE1_PCIE1_LANE1>,
-				      <SERDES2_LANE0_PCIE2_LANE0>, <SERDES2_LANE1_PCIE2_LANE1>,
-				      <MUX_IDLE_AS_IS>, <SERDES3_LANE1_USB3_0>,
-				      <SERDES4_LANE0_EDP_LANE0>, <SERDES4_LANE1_EDP_LANE1>, <SERDES4_LANE2_EDP_LANE2>, <SERDES4_LANE3_EDP_LANE3>;
+			idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_PCIE0_LANE1>,
+				      <J721E_SERDES1_LANE0_PCIE1_LANE0>, <J721E_SERDES1_LANE1_PCIE1_LANE1>,
+				      <J721E_SERDES2_LANE0_PCIE2_LANE0>, <J721E_SERDES2_LANE1_PCIE2_LANE1>,
+				      <MUX_IDLE_AS_IS>, <J721E_SERDES3_LANE1_USB3_0>,
+				      <J721E_SERDES4_LANE0_EDP_LANE0>, <J721E_SERDES4_LANE1_EDP_LANE1>,
+				      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
 		};
 
 		usb_serdes_mux: mux-controller@4000 {
diff --git a/include/dt-bindings/mux/mux-j721e-wiz.h b/include/dt-bindings/mux/mux-j721e-wiz.h
deleted file mode 100644
index fd1c4ea9fc7f..000000000000
--- a/include/dt-bindings/mux/mux-j721e-wiz.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for J721E WIZ.
- */
-
-#ifndef _DT_BINDINGS_J721E_WIZ
-#define _DT_BINDINGS_J721E_WIZ
-
-#define SERDES0_LANE0_QSGMII_LANE1	0x0
-#define SERDES0_LANE0_PCIE0_LANE0	0x1
-#define SERDES0_LANE0_USB3_0_SWAP	0x2
-
-#define SERDES0_LANE1_QSGMII_LANE2	0x0
-#define SERDES0_LANE1_PCIE0_LANE1	0x1
-#define SERDES0_LANE1_USB3_0		0x2
-
-#define SERDES1_LANE0_QSGMII_LANE3	0x0
-#define SERDES1_LANE0_PCIE1_LANE0	0x1
-#define SERDES1_LANE0_USB3_1_SWAP	0x2
-#define SERDES1_LANE0_SGMII_LANE0	0x3
-
-#define SERDES1_LANE1_QSGMII_LANE4	0x0
-#define SERDES1_LANE1_PCIE1_LANE1	0x1
-#define SERDES1_LANE1_USB3_1		0x2
-#define SERDES1_LANE1_SGMII_LANE1	0x3
-
-#define SERDES2_LANE0_PCIE2_LANE0	0x1
-#define SERDES2_LANE0_SGMII_LANE0	0x3
-#define SERDES2_LANE0_USB3_1_SWAP	0x2
-
-#define SERDES2_LANE1_PCIE2_LANE1	0x1
-#define SERDES2_LANE1_USB3_1		0x2
-#define SERDES2_LANE1_SGMII_LANE1	0x3
-
-#define SERDES3_LANE0_PCIE3_LANE0	0x1
-#define SERDES3_LANE0_USB3_0_SWAP	0x2
-
-#define SERDES3_LANE1_PCIE3_LANE1	0x1
-#define SERDES3_LANE1_USB3_0		0x2
-
-#define SERDES4_LANE0_EDP_LANE0		0x0
-#define SERDES4_LANE0_QSGMII_LANE5	0x2
-
-#define SERDES4_LANE1_EDP_LANE1		0x0
-#define SERDES4_LANE1_QSGMII_LANE6	0x2
-
-#define SERDES4_LANE2_EDP_LANE2		0x0
-#define SERDES4_LANE2_QSGMII_LANE7	0x2
-
-#define SERDES4_LANE3_EDP_LANE3		0x0
-#define SERDES4_LANE3_QSGMII_LANE8	0x2
-
-#endif /* _DT_BINDINGS_J721E_WIZ */
diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
new file mode 100644
index 000000000000..3e1f2d243e4a
--- /dev/null
+++ b/include/dt-bindings/mux/ti-serdes.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for SERDES MUX for TI SoCs
+ */
+
+#ifndef _DT_BINDINGS_TI_SERDES_MUX
+#define _DT_BINDINGS_TI_SERDES_MUX
+
+/* J721E */
+
+#define J721E_SERDES0_LANE0_QSGMII_LANE1	0x0
+#define J721E_SERDES0_LANE0_PCIE0_LANE0		0x1
+#define J721E_SERDES0_LANE0_USB3_0_SWAP		0x2
+
+#define J721E_SERDES0_LANE1_QSGMII_LANE2	0x0
+#define J721E_SERDES0_LANE1_PCIE0_LANE1		0x1
+#define J721E_SERDES0_LANE1_USB3_0		0x2
+
+#define J721E_SERDES1_LANE0_QSGMII_LANE3	0x0
+#define J721E_SERDES1_LANE0_PCIE1_LANE0		0x1
+#define J721E_SERDES1_LANE0_USB3_1_SWAP		0x2
+#define J721E_SERDES1_LANE0_SGMII_LANE0		0x3
+
+#define J721E_SERDES1_LANE1_QSGMII_LANE4	0x0
+#define J721E_SERDES1_LANE1_PCIE1_LANE1		0x1
+#define J721E_SERDES1_LANE1_USB3_1		0x2
+#define J721E_SERDES1_LANE1_SGMII_LANE1		0x3
+
+#define J721E_SERDES2_LANE0_PCIE2_LANE0		0x1
+#define J721E_SERDES2_LANE0_SGMII_LANE0		0x3
+#define J721E_SERDES2_LANE0_USB3_1_SWAP		0x2
+
+#define J721E_SERDES2_LANE1_PCIE2_LANE1		0x1
+#define J721E_SERDES2_LANE1_USB3_1		0x2
+#define J721E_SERDES2_LANE1_SGMII_LANE1		0x3
+
+#define J721E_SERDES3_LANE0_PCIE3_LANE0		0x1
+#define J721E_SERDES3_LANE0_USB3_0_SWAP		0x2
+
+#define J721E_SERDES3_LANE1_PCIE3_LANE1		0x1
+#define J721E_SERDES3_LANE1_USB3_0		0x2
+
+#define J721E_SERDES4_LANE0_EDP_LANE0		0x0
+#define J721E_SERDES4_LANE0_QSGMII_LANE5	0x2
+
+#define J721E_SERDES4_LANE1_EDP_LANE1		0x0
+#define J721E_SERDES4_LANE1_QSGMII_LANE6	0x2
+
+#define J721E_SERDES4_LANE2_EDP_LANE2		0x0
+#define J721E_SERDES4_LANE2_QSGMII_LANE7	0x2
+
+#define J721E_SERDES4_LANE3_EDP_LANE3		0x0
+#define J721E_SERDES4_LANE3_QSGMII_LANE8	0x2
+
+#endif /* _DT_BINDINGS_TI_SERDES_MUX */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

