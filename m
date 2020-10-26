Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05A32991FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785121AbgJZQME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:12:04 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45866 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785062AbgJZQKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:10:48 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 756121A0C93;
        Mon, 26 Oct 2020 17:10:46 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 65BB21A0287;
        Mon, 26 Oct 2020 17:10:46 +0100 (CET)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1739920308;
        Mon, 26 Oct 2020 17:10:46 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v4 08/11] arm64: dts: ls2088ardb: add PHY nodes for the AQR405 PHYs
Date:   Mon, 26 Oct 2020 18:10:02 +0200
Message-Id: <20201026161005.5421-9-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026161005.5421-1-ioana.ciornei@nxp.com>
References: <20201026161005.5421-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate the EMDIO2 node and describe the other 4 10GBASER PHYs found on
the LS2088ARDB board. Also, add phy-handles for DPMACs 5-8 to their
associated PHY.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - none
Changes in v3:
 - none
Changes in v4:
 - move the phy-connection-type attribute to the ethernet node
 - remove the interrupt description

 .../boot/dts/freescale/fsl-ls2088a-rdb.dts    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
index 6f4acb7a3528..037c7a8f3d5b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
@@ -43,6 +43,26 @@ &dpmac4 {
 	phy-connection-type = "10gbase-r";
 };
 
+&dpmac5 {
+	phy-handle = <&mdio2_phy1>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac6 {
+	phy-handle = <&mdio2_phy2>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac7 {
+	phy-handle = <&mdio2_phy3>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac8 {
+	phy-handle = <&mdio2_phy4>;
+	phy-connection-type = "10gbase-r";
+};
+
 &emdio1 {
 	status = "okay";
 
@@ -63,3 +83,24 @@ mdio1_phy4: emdio1_phy@4 {
 		reg = <0x13>;
 	};
 };
+
+&emdio2 {
+	status = "okay";
+
+	mdio2_phy1: emdio2_phy@1 {
+		compatible = "ethernet-phy-id03a1.b4b0", "ethernet-phy-ieee802.3-c45";
+		reg = <0x0>;
+	};
+	mdio2_phy2: emdio2_phy@2 {
+		compatible = "ethernet-phy-id03a1.b4b0", "ethernet-phy-ieee802.3-c45";
+		reg = <0x1>;
+	};
+	mdio2_phy3: emdio2_phy@3 {
+		compatible = "ethernet-phy-id03a1.b4b0", "ethernet-phy-ieee802.3-c45";
+		reg = <0x2>;
+	};
+	mdio2_phy4: emdio2_phy@4 {
+		compatible = "ethernet-phy-id03a1.b4b0", "ethernet-phy-ieee802.3-c45";
+		reg = <0x3>;
+	};
+};
-- 
2.28.0

