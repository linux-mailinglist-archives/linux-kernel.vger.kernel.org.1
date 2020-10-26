Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3303C2991FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785129AbgJZQMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:12:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45878 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785063AbgJZQKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:10:48 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CA4DF1A0C97;
        Mon, 26 Oct 2020 17:10:46 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BCA2A1A0287;
        Mon, 26 Oct 2020 17:10:46 +0100 (CET)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 71B5F20308;
        Mon, 26 Oct 2020 17:10:46 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v4 09/11] arm64: dts: ls208xa: add PCS MDIO and PCS PHY nodes
Date:   Mon, 26 Oct 2020 18:10:03 +0200
Message-Id: <20201026161005.5421-10-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026161005.5421-1-ioana.ciornei@nxp.com>
References: <20201026161005.5421-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCS MDIO nodes for the internal MDIO buses on the LS208x SoCs, along
with their internal PCS PHYs which will be used when the DPMAC object is
in TYPE_PHY mode.
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

 .../boot/dts/freescale/fsl-ls2088a-rdb.dts    |  32 +++
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 256 ++++++++++++++++--
 2 files changed, 272 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
index 037c7a8f3d5b..6f279667fc6f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
@@ -104,3 +104,35 @@ mdio2_phy4: emdio2_phy@4 {
 		reg = <0x3>;
 	};
 };
+
+&pcs_mdio1 {
+	status = "okay";
+};
+
+&pcs_mdio2 {
+	status = "okay";
+};
+
+&pcs_mdio3 {
+	status = "okay";
+};
+
+&pcs_mdio4 {
+	status = "okay";
+};
+
+&pcs_mdio5 {
+	status = "okay";
+};
+
+&pcs_mdio6 {
+	status = "okay";
+};
+
+&pcs_mdio7 {
+	status = "okay";
+};
+
+&pcs_mdio8 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 76aab49f0d50..4da70343f8e4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -476,6 +476,214 @@ emdio2: mdio@8b97000 {
 			status = "disabled";
 		};
 
+		pcs_mdio1: mdio@8c07000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c07000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs1: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio2: mdio@8c0b000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c0b000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs2: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio3: mdio@8c0f000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c0f000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs3: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio4: mdio@8c13000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c13000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs4: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio5: mdio@8c17000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c17000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs5: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio6: mdio@8c1b000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c1b000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs6: pcs-phy@0 {
+				reg = <0>;
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
+			pcs7: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio8: mdio@8c23000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c23000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs8: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio9: mdio@8c27000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c27000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs9: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio10: mdio@8c2b000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c2b000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs10: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio11: mdio@8c2f000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c2f000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs11: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio12: mdio@8c33000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c33000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs12: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio13: mdio@8c37000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c37000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs13: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio14: mdio@8c3b000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c3b000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs14: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio15: mdio@8c3f000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c3f000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs15: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio16: mdio@8c43000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c43000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs16: pcs-phy@0 {
+				reg = <0>;
+			};
+		};
+
 		fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
@@ -500,84 +708,100 @@ dpmacs {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				dpmac1: dpmac@1 {
+				dpmac1: ethernet@1 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x1>;
+					pcs-handle = <&pcs1>;
 				};
 
-				dpmac2: dpmac@2 {
+				dpmac2: ethernet@2 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x2>;
+					pcs-handle = <&pcs2>;
 				};
 
-				dpmac3: dpmac@3 {
+				dpmac3: ethernet@3 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x3>;
+					pcs-handle = <&pcs3>;
 				};
 
-				dpmac4: dpmac@4 {
+				dpmac4: ethernet@4 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x4>;
+					pcs-handle = <&pcs4>;
 				};
 
-				dpmac5: dpmac@5 {
+				dpmac5: ethernet@5 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x5>;
+					pcs-handle = <&pcs5>;
 				};
 
-				dpmac6: dpmac@6 {
+				dpmac6: ethernet@6 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x6>;
+					pcs-handle = <&pcs6>;
 				};
 
-				dpmac7: dpmac@7 {
+				dpmac7: ethernet@7 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x7>;
+					pcs-handle = <&pcs7>;
 				};
 
-				dpmac8: dpmac@8 {
+				dpmac8: ethernet@8 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x8>;
+					pcs-handle = <&pcs8>;
 				};
 
-				dpmac9: dpmac@9 {
+				dpmac9: ethernet@9 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x9>;
+					pcs-handle = <&pcs9>;
 				};
 
-				dpmac10: dpmac@a {
+				dpmac10: ethernet@a {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xa>;
+					pcs-handle = <&pcs10>;
 				};
 
-				dpmac11: dpmac@b {
+				dpmac11: ethernet@b {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xb>;
+					pcs-handle = <&pcs11>;
 				};
 
-				dpmac12: dpmac@c {
+				dpmac12: ethernet@c {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xc>;
+					pcs-handle = <&pcs12>;
 				};
 
-				dpmac13: dpmac@d {
+				dpmac13: ethernet@d {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xd>;
+					pcs-handle = <&pcs13>;
 				};
 
-				dpmac14: dpmac@e {
+				dpmac14: ethernet@e {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xe>;
+					pcs-handle = <&pcs14>;
 				};
 
-				dpmac15: dpmac@f {
+				dpmac15: ethernet@f {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xf>;
+					pcs-handle = <&pcs15>;
 				};
 
-				dpmac16: dpmac@10 {
+				dpmac16: ethernet@10 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x10>;
+					pcs-handle = <&pcs16>;
 				};
 			};
 		};
-- 
2.28.0

