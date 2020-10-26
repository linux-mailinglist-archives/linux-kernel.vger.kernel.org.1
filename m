Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCBD2991F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785105AbgJZQL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:11:56 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55900 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1741440AbgJZQKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:10:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ECE362002F6;
        Mon, 26 Oct 2020 17:10:44 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E024A200C9C;
        Mon, 26 Oct 2020 17:10:44 +0100 (CET)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9980820308;
        Mon, 26 Oct 2020 17:10:44 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v4 04/11] arm64: dts: ls1088ardb: add QSGMII PHY nodes
Date:   Mon, 26 Oct 2020 18:09:58 +0200
Message-Id: <20201026161005.5421-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026161005.5421-1-ioana.ciornei@nxp.com>
References: <20201026161005.5421-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate the external MDIO1 node and describe the 8 QSGMII PHYs found on
the LS1088ARDB board and add phy-handles for DPMACs 3-10 to its
associated PHY.  Also, add the internal PCS MDIO nodes for the internal
MDIO buses found on the LS1088A SoC along with their internal PCS PHY
and link the corresponding DPMAC to the PCS through the pcs-handle.
Also, rename the dpmac@x nodes to ethernet@x in order to be compliant
with the naming convention used by ethernet controllers.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - none
Changes in v3:
 - renamed dpmac@x into ethernet@x
Changes in v4:
 - none


 .../boot/dts/freescale/fsl-ls1088a-rdb.dts    | 100 ++++++++++++++++++
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  70 ++++++++++--
 2 files changed, 160 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 5633e59febc3..d7886b084f7f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -17,6 +17,98 @@ / {
 	compatible = "fsl,ls1088a-rdb", "fsl,ls1088a";
 };
 
+&dpmac3 {
+	phy-handle = <&mdio1_phy5>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs3_0>;
+};
+
+&dpmac4 {
+	phy-handle = <&mdio1_phy6>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs3_1>;
+};
+
+&dpmac5 {
+	phy-handle = <&mdio1_phy7>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs3_2>;
+};
+
+&dpmac6 {
+	phy-handle = <&mdio1_phy8>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs3_3>;
+};
+
+&dpmac7 {
+	phy-handle = <&mdio1_phy1>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs7_0>;
+};
+
+&dpmac8 {
+	phy-handle = <&mdio1_phy2>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs7_1>;
+};
+
+&dpmac9 {
+	phy-handle = <&mdio1_phy3>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs7_2>;
+};
+
+&dpmac10 {
+	phy-handle = <&mdio1_phy4>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs7_3>;
+};
+
+&emdio1 {
+	status = "okay";
+
+	mdio1_phy1: emdio1_phy@1 {
+		reg = <0x1c>;
+	};
+
+	mdio1_phy2: emdio1_phy@2 {
+		reg = <0x1d>;
+	};
+
+	mdio1_phy3: emdio1_phy@3 {
+		reg = <0x1e>;
+	};
+
+	mdio1_phy4: emdio1_phy@4 {
+		reg = <0x1f>;
+	};
+
+	mdio1_phy5: emdio1_phy@5 {
+		reg = <0x0c>;
+	};
+
+	mdio1_phy6: emdio1_phy@6 {
+		reg = <0x0d>;
+	};
+
+	mdio1_phy7: emdio1_phy@7 {
+		reg = <0x0e>;
+	};
+
+	mdio1_phy8: emdio1_phy@8 {
+		reg = <0x0f>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -87,6 +179,14 @@ &esdhc {
 	status = "okay";
 };
 
+&pcs_mdio3 {
+	status = "okay";
+};
+
+&pcs_mdio7 {
+	status = "okay";
+};
+
 &qspi {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index aea42e9e947f..9241d32e5513 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -690,6 +690,56 @@ emdio2: mdio@8b97000 {
 			status = "disabled";
 		};
 
+		pcs_mdio3: mdio@8c0f000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c0f000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs3_0: pcs-phy@0 {
+				reg = <0>;
+			};
+
+			pcs3_1: pcs-phy@1 {
+				reg = <1>;
+			};
+
+			pcs3_2: pcs-phy@2 {
+				reg = <2>;
+			};
+
+			pcs3_3: pcs-phy@3 {
+				reg = <3>;
+			};
+		};
+
+		pcs_mdio7: mdio@8c1f000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c1f000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs7_0: pcs-phy@0 {
+				reg = <0>;
+			};
+
+			pcs7_1: pcs-phy@1 {
+				reg = <1>;
+			};
+
+			pcs7_2: pcs-phy@2 {
+				reg = <2>;
+			};
+
+			pcs7_3: pcs-phy@3 {
+				reg = <3>;
+			};
+		};
+
 		cluster1_core0_watchdog: wdt@c000000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
@@ -767,52 +817,52 @@ dpmacs {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				dpmac1: dpmac@1 {
+				dpmac1: ethernet@1 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <1>;
 				};
 
-				dpmac2: dpmac@2 {
+				dpmac2: ethernet@2 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <2>;
 				};
 
-				dpmac3: dpmac@3 {
+				dpmac3: ethernet@3 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <3>;
 				};
 
-				dpmac4: dpmac@4 {
+				dpmac4: ethernet@4 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <4>;
 				};
 
-				dpmac5: dpmac@5 {
+				dpmac5: ethernet@5 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <5>;
 				};
 
-				dpmac6: dpmac@6 {
+				dpmac6: ethernet@6 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <6>;
 				};
 
-				dpmac7: dpmac@7 {
+				dpmac7: ethernet@7 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <7>;
 				};
 
-				dpmac8: dpmac@8 {
+				dpmac8: ethernet@8 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <8>;
 				};
 
-				dpmac9: dpmac@9 {
+				dpmac9: ethernet@9 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <9>;
 				};
 
-				dpmac10: dpmac@a {
+				dpmac10: ethernet@a {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xa>;
 				};
-- 
2.28.0

