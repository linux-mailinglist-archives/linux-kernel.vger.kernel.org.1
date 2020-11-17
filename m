Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7AF2B57F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 04:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgKQDem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 22:34:42 -0500
Received: from inva020.nxp.com ([92.121.34.13]:56540 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgKQDel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 22:34:41 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 66F821A01D1;
        Tue, 17 Nov 2020 04:34:39 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 62ED21A0678;
        Tue, 17 Nov 2020 04:34:36 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0C2D5402ED;
        Tue, 17 Nov 2020 04:34:31 +0100 (CET)
From:   andy.tang@nxp.com
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 2/2] ARM: dts: ls1021a: update calibration table for TMU module
Date:   Tue, 17 Nov 2020 11:43:05 +0800
Message-Id: <20201117034305.42546-2-andy.tang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117034305.42546-1-andy.tang@nxp.com>
References: <20201117034305.42546-1-andy.tang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

Update the calibration table to make the temperature more accurate.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 77 ++++++++++++++++------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 827373ef1a54..0d569be0d2b2 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -288,46 +288,43 @@
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f00000 0x0 0x10000>;
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-			fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x30061>;
-			fsl,tmu-calibration = <0x00000000 0x0000000f
-					       0x00000001 0x00000017
-					       0x00000002 0x0000001e
-					       0x00000003 0x00000026
-					       0x00000004 0x0000002e
-					       0x00000005 0x00000035
-					       0x00000006 0x0000003d
-					       0x00000007 0x00000044
-					       0x00000008 0x0000004c
-					       0x00000009 0x00000053
-					       0x0000000a 0x0000005b
-					       0x0000000b 0x00000064
-
-					       0x00010000 0x00000011
-					       0x00010001 0x0000001c
-					       0x00010002 0x00000024
-					       0x00010003 0x0000002b
-					       0x00010004 0x00000034
-					       0x00010005 0x00000039
-					       0x00010006 0x00000042
-					       0x00010007 0x0000004c
-					       0x00010008 0x00000051
-					       0x00010009 0x0000005a
-					       0x0001000a 0x00000063
-
-					       0x00020000 0x00000013
-					       0x00020001 0x00000019
-					       0x00020002 0x00000024
-					       0x00020003 0x0000002c
-					       0x00020004 0x00000035
-					       0x00020005 0x0000003d
-					       0x00020006 0x00000046
-					       0x00020007 0x00000050
-					       0x00020008 0x00000059
-
-					       0x00030000 0x00000002
-					       0x00030001 0x0000000d
-					       0x00030002 0x00000019
-					       0x00030003 0x00000024>;
+			fsl,tmu-range = <0xb0000 0x9002c 0x6004e 0x30066>;
+			fsl,tmu-calibration = <0x00000000 0x00000020
+					       0x00000001 0x00000024
+					       0x00000002 0x0000002a
+					       0x00000003 0x00000032
+					       0x00000004 0x00000038
+					       0x00000005 0x0000003e
+					       0x00000006 0x00000043
+					       0x00000007 0x0000004a
+					       0x00000008 0x00000050
+					       0x00000009 0x00000059
+					       0x0000000a 0x0000005f
+					       0x0000000b 0x00000066
+
+					       0x00010000 0x00000023
+					       0x00010001 0x0000002b
+					       0x00010002 0x00000033
+					       0x00010003 0x0000003a
+					       0x00010004 0x00000042
+					       0x00010005 0x0000004a
+					       0x00010006 0x00000054
+					       0x00010007 0x0000005c
+					       0x00010008 0x00000065
+					       0x00010009 0x0000006f
+
+					       0x00020000 0x00000029
+					       0x00020001 0x00000033
+					       0x00020002 0x0000003d
+					       0x00020003 0x00000048
+					       0x00020004 0x00000054
+					       0x00020005 0x00000060
+					       0x00020006 0x0000006c
+
+					       0x00030000 0x00000025
+					       0x00030001 0x00000033
+					       0x00030002 0x00000043
+					       0x00030003 0x00000055>;
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

