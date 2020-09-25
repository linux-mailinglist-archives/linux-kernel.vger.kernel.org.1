Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EC52789A2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgIYNeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:34:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34670 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728795AbgIYNd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:33:59 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9EB452016B4;
        Fri, 25 Sep 2020 15:25:09 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 92D752005E9;
        Fri, 25 Sep 2020 15:25:09 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C2852030E;
        Fri, 25 Sep 2020 15:25:09 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 9/9] arm64: dts: lx2160ardb: add nodes for the AQR107 PHYs
Date:   Fri, 25 Sep 2020 16:25:03 +0300
Message-Id: <20200925132503.30206-10-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925132503.30206-1-ioana.ciornei@nxp.com>
References: <20200925132503.30206-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate the EMDIO1 node and describe the 2 AQR107 PHYs found on the
LX2160ARDB board. Also, add the necessary phy-handles for DPMACs 3 and 4
to their associated PHY.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 54fe8cd3a711..7723ad5efd37 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -35,6 +35,18 @@ &crypto {
 	status = "okay";
 };
 
+&dpmac3 {
+	phy-handle = <&aquantia_phy1>;
+	phy-connection-type = "usxgmii";
+	managed = "in-band-status";
+};
+
+&dpmac4 {
+	phy-handle = <&aquantia_phy2>;
+	phy-connection-type = "usxgmii";
+	managed = "in-band-status";
+};
+
 &dpmac17 {
 	phy-handle = <&rgmii_phy1>;
 	phy-connection-type = "rgmii-id";
@@ -61,6 +73,18 @@ rgmii_phy2: ethernet-phy@2 {
 		reg = <0x2>;
 		eee-broken-1000t;
 	};
+
+	aquantia_phy1: ethernet-phy@4 {
+		/* AQR107 PHY */
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <0x4>;
+	};
+
+	aquantia_phy2: ethernet-phy@5 {
+		/* AQR107 PHY */
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <0x5>;
+	};
 };
 
 &esdhc0 {
@@ -156,6 +180,14 @@ rtc@51 {
 	};
 };
 
+&pcs_mdio3 {
+	status = "okay";
+};
+
+&pcs_mdio4 {
+	status = "okay";
+};
+
 &sata0 {
 	status = "okay";
 };
-- 
2.25.1

