Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F1827897E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgIYNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:25:14 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59432 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbgIYNZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:25:13 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 83EA41A08DE;
        Fri, 25 Sep 2020 15:25:08 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 76B2D1A08C6;
        Fri, 25 Sep 2020 15:25:08 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4284E2030E;
        Fri, 25 Sep 2020 15:25:08 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 5/9] arm64: dts: ls2088ardb: add PHY nodes for the CS4340 PHYs
Date:   Fri, 25 Sep 2020 16:24:59 +0300
Message-Id: <20200925132503.30206-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925132503.30206-1-ioana.ciornei@nxp.com>
References: <20200925132503.30206-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate the EMDIO1 node and describe the 4 10GBASER PHYs found on the
LS2088ARDB board. Also, add phy-handles for DPMACs 1-4 to their
associated PHY.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../boot/dts/freescale/fsl-ls2088a-rdb.dts    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
index f6b4d75a258b..0d1935fcd201 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
@@ -22,3 +22,44 @@ chosen {
 		stdout-path = "serial1:115200n8";
 	};
 };
+
+&dpmac1 {
+	phy-handle = <&mdio1_phy1>;
+};
+
+&dpmac2 {
+	phy-handle = <&mdio1_phy2>;
+};
+
+&dpmac3 {
+	phy-handle = <&mdio1_phy3>;
+};
+
+&dpmac4 {
+	phy-handle = <&mdio1_phy4>;
+};
+
+&emdio1 {
+	status = "okay";
+
+	mdio1_phy1: emdio1_phy@1 {
+		compatible = "ethernet-phy-id13e5.1002";
+		reg = <0x10>;
+		phy-connection-type = "10gbase-r";
+	};
+	mdio1_phy2: emdio1_phy@2 {
+		compatible = "ethernet-phy-id13e5.1002";
+		reg = <0x11>;
+		phy-connection-type = "10gbase-r";
+	};
+	mdio1_phy3: emdio1_phy@3 {
+		compatible = "ethernet-phy-id13e5.1002";
+		reg = <0x12>;
+		phy-connection-type = "10gbase-r";
+	};
+	mdio1_phy4: emdio1_phy@4 {
+		compatible = "ethernet-phy-id13e5.1002";
+		reg = <0x13>;
+		phy-connection-type = "10gbase-r";
+	};
+};
-- 
2.25.1

