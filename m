Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E11E2991FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785133AbgJZQMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:12:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45854 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785060AbgJZQKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:10:48 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1843B1A0C37;
        Mon, 26 Oct 2020 17:10:46 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0AFD61A0287;
        Mon, 26 Oct 2020 17:10:46 +0100 (CET)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B6AA220308;
        Mon, 26 Oct 2020 17:10:45 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v4 07/11] arm64: dts: ls2088ardb: add PHY nodes for the CS4340 PHYs
Date:   Mon, 26 Oct 2020 18:10:01 +0200
Message-Id: <20201026161005.5421-8-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026161005.5421-1-ioana.ciornei@nxp.com>
References: <20201026161005.5421-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate the EMDIO1 node and describe the 4 10GBASER PHYs found on the
LS2088ARDB board. Also, add phy-handles for DPMACs 1-4 to their
associated PHY.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - none
Changes in v3:
 - none
Changes in v4:
 - move the phy-connection-type attribute to the ethernet node


 .../boot/dts/freescale/fsl-ls2088a-rdb.dts    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
index f6b4d75a258b..6f4acb7a3528 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
@@ -22,3 +22,44 @@ chosen {
 		stdout-path = "serial1:115200n8";
 	};
 };
+
+&dpmac1 {
+	phy-handle = <&mdio1_phy1>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac2 {
+	phy-handle = <&mdio1_phy2>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac3 {
+	phy-handle = <&mdio1_phy3>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac4 {
+	phy-handle = <&mdio1_phy4>;
+	phy-connection-type = "10gbase-r";
+};
+
+&emdio1 {
+	status = "okay";
+
+	mdio1_phy1: emdio1_phy@1 {
+		compatible = "ethernet-phy-id13e5.1002";
+		reg = <0x10>;
+	};
+	mdio1_phy2: emdio1_phy@2 {
+		compatible = "ethernet-phy-id13e5.1002";
+		reg = <0x11>;
+	};
+	mdio1_phy3: emdio1_phy@3 {
+		compatible = "ethernet-phy-id13e5.1002";
+		reg = <0x12>;
+	};
+	mdio1_phy4: emdio1_phy@4 {
+		compatible = "ethernet-phy-id13e5.1002";
+		reg = <0x13>;
+	};
+};
-- 
2.28.0

