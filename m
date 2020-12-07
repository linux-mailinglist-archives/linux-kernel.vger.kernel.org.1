Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431C82D0AEE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgLGHB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:01:59 -0500
Received: from inva020.nxp.com ([92.121.34.13]:58490 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgLGHB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:01:59 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4ECBC1A0DC0;
        Mon,  7 Dec 2020 08:01:12 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 934FF1A0DB3;
        Mon,  7 Dec 2020 08:01:08 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A0E41402C9;
        Mon,  7 Dec 2020 08:01:03 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mn: Fix duplicate node name
Date:   Mon,  7 Dec 2020 14:53:24 +0800
Message-Id: <1607324004-12960-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error log:
sysfs: cannot create duplicate filename '/bus/platform/devices/30000000.bus'

The spba bus name is duplicate with aips bus name.
Refine spba bus name to fix this issue.

Fixes: 970406eaef3a ("arm64: dts: imx8mn: Enable Asynchronous Sample Rate Converter")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index fd669c0f3fe5..30762eb4f0a7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -246,7 +246,7 @@ aips1: bus@30000000 {
 			#size-cells = <1>;
 			ranges;
 
-			spba: bus@30000000 {
+			spba: spba-bus@30000000 {
 				compatible = "fsl,spba-bus", "simple-bus";
 				#address-cells = <1>;
 				#size-cells = <1>;
-- 
2.27.0

