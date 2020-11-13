Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3897B2B2669
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgKMVTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:19:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42142 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgKMVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:18:56 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADLIR51082661;
        Fri, 13 Nov 2020 15:18:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605302308;
        bh=ZLPR2rd79CUU2nlWQU9YMM7dbL48xCX4ukiFtOgxu8Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=b+Jk3uElQEbz2+pPPiDl32rX6QKUvTTygWm4bJz5A6ksK8oOD8gyrlS4xXUgbPovw
         68O4zJnq0bJA7uIF/yEmXTPdjpAYQProxMBzcCTabYuaSB1TJ38cFRHJOdbMjB33Ah
         YUeFXE95Qr4JmHMVsxjFzCBqD44zjJupMNtish0Q=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADLIRRa118032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 15:18:27 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 15:18:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 15:18:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADLIREW092285;
        Fri, 13 Nov 2020 15:18:27 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 2/5] arm64: dts: ti: k3-j721e*: Cleanup disabled nodes at SoC dtsi level
Date:   Fri, 13 Nov 2020 15:18:23 -0600
Message-ID: <20201113211826.13087-3-nm@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113211826.13087-1-nm@ti.com>
References: <20201113211826.13087-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree standard states that when the status property is
not present under a node, the okay value is assumed. There are many
reasons for doing the same, the number of strings in the device
tree, default power management functionality, etc. are a few of the
reasons.

In general, after a few rounds of discussions [1] there are few
options one could take when dealing with SoC dtsi and board dts

a. SoC dtsi provide nodes as a super-set default (aka enabled) state and
   to prevent messy board files, when more boards are added per SoC, we
   optimize and disable commonly un-used nodes in board-common.dtsi
b. SoC dtsi disables all hardware dependent nodes by default and board
   dts files enable nodes based on a need basis.
c. Subjectively pick and choose which nodes we will disable by default
   in SoC dtsi and over the years we can optimize things and change
   default state depending on the need.

While there are pros and cons on each of these approaches, the right
thing to do will be to stick with device tree default standards and
work within those established rules. So, we choose to go with option
(a).

Lets cleanup defaults of j721e SoC dtsi before this gets more harder
to cleanup later on and new SoCs are added.

The only functional difference between the dtb generated is
status='okay' is no longer necessary for mcasp10 and depends on the
default state.

NOTE: There is a known risk of omission that new board dts developers
might miss reviewing both the board schematics in addition to all the
DT nodes of the SoC when setting appropriate nodes status to disable
or reserved in the board dts. This can expose issues in drivers that
may not anticipate an incomplete node (example: missing appropriate
board properties) being in an "okay" state. These cases are considered
bugs and need to be fixed in the drivers as and when identified.

[1] https://lore.kernel.org/linux-arm-kernel/20201027130701.GE5639@atomide.com/

Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
Change in v4: Dropped Fixes

v3: https://lore.kernel.org/linux-arm-kernel/20201112183538.6805-3-nm@ti.com/
V2: https://lore.kernel.org/linux-arm-kernel/20201112014929.25227-3-nm@ti.com/
V1: https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-3-nm@ti.com/

 .../dts/ti/k3-j721e-common-proc-board.dts     | 48 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 26 ----------
 2 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 52e121155563..9416528caa8a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -540,6 +540,46 @@ &dss {
 				 <&k3_clks 152 18>;	/* PLL23_HSDIV0 */
 };
 
+&mcasp0 {
+	status = "disabled";
+};
+
+&mcasp1 {
+	status = "disabled";
+};
+
+&mcasp2 {
+	status = "disabled";
+};
+
+&mcasp3 {
+	status = "disabled";
+};
+
+&mcasp4 {
+	status = "disabled";
+};
+
+&mcasp5 {
+	status = "disabled";
+};
+
+&mcasp6 {
+	status = "disabled";
+};
+
+&mcasp7 {
+	status = "disabled";
+};
+
+&mcasp8 {
+	status = "disabled";
+};
+
+&mcasp9 {
+	status = "disabled";
+};
+
 &mcasp10 {
 	#sound-dai-cells = <0>;
 
@@ -556,8 +596,10 @@ &mcasp10 {
 	>;
 	tx-num-evt = <0>;
 	rx-num-evt = <0>;
+};
 
-	status = "okay";
+&mcasp11 {
+	status = "disabled";
 };
 
 &serdes0 {
@@ -639,3 +681,7 @@ &pcie3_rc {
 &pcie3_ep {
 	status = "disabled";
 };
+
+&dss {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 620e69e42974..137966c6be1f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1327,8 +1327,6 @@ dss: dss@4a00000 {
 				  "common_s1",
 				  "common_s2";
 
-		status = "disabled";
-
 		dss_ports: ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1350,8 +1348,6 @@ mcasp0: mcasp@2b00000 {
 		clocks = <&k3_clks 174 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 174 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp1: mcasp@2b10000 {
@@ -1369,8 +1365,6 @@ mcasp1: mcasp@2b10000 {
 		clocks = <&k3_clks 175 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 175 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp2: mcasp@2b20000 {
@@ -1388,8 +1382,6 @@ mcasp2: mcasp@2b20000 {
 		clocks = <&k3_clks 176 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 176 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp3: mcasp@2b30000 {
@@ -1407,8 +1399,6 @@ mcasp3: mcasp@2b30000 {
 		clocks = <&k3_clks 177 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 177 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp4: mcasp@2b40000 {
@@ -1426,8 +1416,6 @@ mcasp4: mcasp@2b40000 {
 		clocks = <&k3_clks 178 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp5: mcasp@2b50000 {
@@ -1445,8 +1433,6 @@ mcasp5: mcasp@2b50000 {
 		clocks = <&k3_clks 179 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp6: mcasp@2b60000 {
@@ -1464,8 +1450,6 @@ mcasp6: mcasp@2b60000 {
 		clocks = <&k3_clks 180 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 180 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp7: mcasp@2b70000 {
@@ -1483,8 +1467,6 @@ mcasp7: mcasp@2b70000 {
 		clocks = <&k3_clks 181 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 181 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp8: mcasp@2b80000 {
@@ -1502,8 +1484,6 @@ mcasp8: mcasp@2b80000 {
 		clocks = <&k3_clks 182 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp9: mcasp@2b90000 {
@@ -1521,8 +1501,6 @@ mcasp9: mcasp@2b90000 {
 		clocks = <&k3_clks 183 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 183 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp10: mcasp@2ba0000 {
@@ -1540,8 +1518,6 @@ mcasp10: mcasp@2ba0000 {
 		clocks = <&k3_clks 184 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	mcasp11: mcasp@2bb0000 {
@@ -1559,8 +1535,6 @@ mcasp11: mcasp@2bb0000 {
 		clocks = <&k3_clks 185 1>;
 		clock-names = "fck";
 		power-domains = <&k3_pds 185 TI_SCI_PD_EXCLUSIVE>;
-
-		status = "disabled";
 	};
 
 	watchdog0: watchdog@2200000 {
-- 
2.29.2

