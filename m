Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B99F27897C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgIYNZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:25:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59396 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbgIYNZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:25:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 66E361A08C4;
        Fri, 25 Sep 2020 15:25:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 555D51A08B1;
        Fri, 25 Sep 2020 15:25:07 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 171672030E;
        Fri, 25 Sep 2020 15:25:07 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/9] arm64: dts: ls1088a: add external MDIO device nodes
Date:   Fri, 25 Sep 2020 16:24:55 +0300
Message-Id: <20200925132503.30206-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925132503.30206-1-ioana.ciornei@nxp.com>
References: <20200925132503.30206-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the external MDIO device nodes found in the WRIOP global memory
region. This is needed for management of external PHYs.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 169f4742ae3b..22544e3b7737 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -654,6 +654,24 @@ ptp-timer@8b95000 {
 			fsl,extts-fifo;
 		};
 
+		emdio1: mdio@0x8B96000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8B96000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		emdio2: mdio@0x8B97000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8B97000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		cluster1_core0_watchdog: wdt@c000000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
-- 
2.25.1

