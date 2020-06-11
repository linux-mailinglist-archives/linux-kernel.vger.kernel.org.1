Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37AF1F5FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 03:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgFKBrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 21:47:47 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41262 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgFKBrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:47:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 476192016C6;
        Thu, 11 Jun 2020 03:47:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B6EA20031A;
        Thu, 11 Jun 2020 03:47:40 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 41ACF4028F;
        Thu, 11 Jun 2020 09:47:33 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        horia.geanta@nxp.com, peng.fan@nxp.com, fugang.duan@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] arm64: dts: imx8mp: Add fallback compatible to ocotp node
Date:   Thu, 11 Jun 2020 09:36:53 +0800
Message-Id: <1591839413-32102-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "fsl,imx8mm-ocotp" as fallback compatible of i.MX8MP ocotp
to support SoC serial_number read.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c248e7f..3e01c072 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -341,7 +341,7 @@
 			};
 
 			ocotp: efuse@30350000 {
-				compatible = "fsl,imx8mp-ocotp", "syscon";
+				compatible = "fsl,imx8mp-ocotp", "fsl,imx8mm-ocotp", "syscon";
 				reg = <0x30350000 0x10000>;
 				clocks = <&clk IMX8MP_CLK_OCOTP_ROOT>;
 				/* For nvmem subnodes */
-- 
2.7.4

