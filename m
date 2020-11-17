Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AAF2B57F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 04:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgKQDek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 22:34:40 -0500
Received: from inva021.nxp.com ([92.121.34.21]:43226 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgKQDek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 22:34:40 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FC3A200E26;
        Tue, 17 Nov 2020 04:34:37 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 60DB12011C9;
        Tue, 17 Nov 2020 04:34:34 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 180A2402D2;
        Tue, 17 Nov 2020 04:34:30 +0100 (CET)
From:   andy.tang@nxp.com
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 1/2] arm64: dts: freescale: update calibration table for TMU module
Date:   Tue, 17 Nov 2020 11:43:04 +0800
Message-Id: <20201117034305.42546-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

Update the calibration table to make the temperature more accurate.
Three platforms have been updated: ls1012a, ls1043a and ls1046a.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 63 ++++++++-------
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 78 ++++++++++---------
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 72 +++++++++--------
 3 files changed, 112 insertions(+), 101 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 5be686a0de54..b3683cda7f5b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -293,43 +293,46 @@
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f00000 0x0 0x10000>;
 			interrupts = <0 33 0x4>;
-			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
-			fsl,tmu-calibration = <0x00000000 0x00000026
-					       0x00000001 0x0000002d
+			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x60062>;
+			fsl,tmu-calibration = <0x00000000 0x00000025
+					       0x00000001 0x0000002c
 					       0x00000002 0x00000032
 					       0x00000003 0x00000039
 					       0x00000004 0x0000003f
 					       0x00000005 0x00000046
-					       0x00000006 0x0000004d
-					       0x00000007 0x00000054
-					       0x00000008 0x0000005a
-					       0x00000009 0x00000061
-					       0x0000000a 0x0000006a
-					       0x0000000b 0x00000071
-
-					       0x00010000 0x00000025
-					       0x00010001 0x0000002c
+					       0x00000006 0x0000004c
+					       0x00000007 0x00000053
+					       0x00000008 0x00000059
+					       0x00000009 0x0000005f
+					       0x0000000a 0x00000066
+					       0x0000000b 0x0000006c
+
+					       0x00010000 0x00000026
+					       0x00010001 0x0000002d
 					       0x00010002 0x00000035
 					       0x00010003 0x0000003d
 					       0x00010004 0x00000045
-					       0x00010005 0x0000004e
-					       0x00010006 0x00000057
-					       0x00010007 0x00000061
-					       0x00010008 0x0000006b
-					       0x00010009 0x00000076
-
-					       0x00020000 0x00000029
-					       0x00020001 0x00000033
-					       0x00020002 0x0000003d
-					       0x00020003 0x00000049
-					       0x00020004 0x00000056
-					       0x00020005 0x00000061
-					       0x00020006 0x0000006d
-
-					       0x00030000 0x00000021
-					       0x00030001 0x0000002a
-					       0x00030002 0x0000003c
-					       0x00030003 0x0000004e>;
+					       0x00010005 0x0000004d
+					       0x00010006 0x00000055
+					       0x00010007 0x0000005d
+					       0x00010008 0x00000065
+					       0x00010009 0x0000006d
+
+					       0x00020000 0x00000026
+					       0x00020001 0x00000030
+					       0x00020002 0x0000003a
+					       0x00020003 0x00000044
+					       0x00020004 0x0000004e
+					       0x00020005 0x00000059
+					       0x00020006 0x00000063
+
+					       0x00030000 0x00000014
+					       0x00030001 0x00000021
+					       0x00030002 0x0000002e
+					       0x00030003 0x0000003a
+					       0x00030004 0x00000047
+					       0x00030005 0x00000053
+					       0x00030006 0x00000060>;
 			big-endian;
 			#thermal-sensor-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index d5d219311161..bbae4b353d3f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -403,43 +403,47 @@
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f00000 0x0 0x10000>;
 			interrupts = <0 33 0x4>;
-			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
-			fsl,tmu-calibration = <0x00000000 0x00000026
-					       0x00000001 0x0000002d
-					       0x00000002 0x00000032
-					       0x00000003 0x00000039
-					       0x00000004 0x0000003f
-					       0x00000005 0x00000046
-					       0x00000006 0x0000004d
-					       0x00000007 0x00000054
-					       0x00000008 0x0000005a
-					       0x00000009 0x00000061
-					       0x0000000a 0x0000006a
-					       0x0000000b 0x00000071
-
-					       0x00010000 0x00000025
-					       0x00010001 0x0000002c
-					       0x00010002 0x00000035
-					       0x00010003 0x0000003d
-					       0x00010004 0x00000045
-					       0x00010005 0x0000004e
-					       0x00010006 0x00000057
-					       0x00010007 0x00000061
-					       0x00010008 0x0000006b
-					       0x00010009 0x00000076
-
-					       0x00020000 0x00000029
-					       0x00020001 0x00000033
-					       0x00020002 0x0000003d
-					       0x00020003 0x00000049
-					       0x00020004 0x00000056
-					       0x00020005 0x00000061
-					       0x00020006 0x0000006d
-
-					       0x00030000 0x00000021
-					       0x00030001 0x0000002a
-					       0x00030002 0x0000003c
-					       0x00030003 0x0000004e>;
+			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
+			fsl,tmu-calibration = <0x00000000 0x00000023
+					       0x00000001 0x0000002a
+					       0x00000002 0x00000031
+					       0x00000003 0x00000037
+					       0x00000004 0x0000003e
+					       0x00000005 0x00000044
+					       0x00000006 0x0000004b
+					       0x00000007 0x00000051
+					       0x00000008 0x00000058
+					       0x00000009 0x0000005e
+					       0x0000000a 0x00000065
+					       0x0000000b 0x0000006b
+
+					       0x00010000 0x00000023
+					       0x00010001 0x0000002b
+					       0x00010002 0x00000033
+					       0x00010003 0x0000003b
+					       0x00010004 0x00000043
+					       0x00010005 0x0000004b
+					       0x00010006 0x00000054
+					       0x00010007 0x0000005c
+					       0x00010008 0x00000064
+					       0x00010009 0x0000006c
+
+					       0x00020000 0x00000021
+					       0x00020001 0x0000002c
+					       0x00020002 0x00000036
+					       0x00020003 0x00000040
+					       0x00020004 0x0000004b
+					       0x00020005 0x00000055
+					       0x00020006 0x0000005f
+
+					       0x00030000 0x00000013
+					       0x00030001 0x0000001d
+					       0x00030002 0x00000028
+					       0x00030003 0x00000032
+					       0x00030004 0x0000003d
+					       0x00030005 0x00000047
+					       0x00030006 0x00000052
+					       0x00030007 0x0000005c>;
 			#thermal-sensor-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 1fa39bacff4b..025e1f587662 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -400,45 +400,49 @@
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f00000 0x0 0x10000>;
 			interrupts = <0 33 0x4>;
-			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
+			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
 			fsl,tmu-calibration =
 				/* Calibration data group 1 */
-				<0x00000000 0x00000026
-				0x00000001 0x0000002d
-				0x00000002 0x00000032
-				0x00000003 0x00000039
-				0x00000004 0x0000003f
-				0x00000005 0x00000046
-				0x00000006 0x0000004d
-				0x00000007 0x00000054
-				0x00000008 0x0000005a
-				0x00000009 0x00000061
-				0x0000000a 0x0000006a
-				0x0000000b 0x00000071
+				<0x00000000 0x00000023
+				0x00000001 0x00000029
+				0x00000002 0x0000002f
+				0x00000003 0x00000036
+				0x00000004 0x0000003c
+				0x00000005 0x00000042
+				0x00000006 0x00000049
+				0x00000007 0x0000004f
+				0x00000008 0x00000055
+				0x00000009 0x0000005c
+				0x0000000a 0x00000062
+				0x0000000b 0x00000068
 				/* Calibration data group 2 */
-				0x00010000 0x00000025
-				0x00010001 0x0000002c
-				0x00010002 0x00000035
-				0x00010003 0x0000003d
-				0x00010004 0x00000045
-				0x00010005 0x0000004e
-				0x00010006 0x00000057
-				0x00010007 0x00000061
-				0x00010008 0x0000006b
-				0x00010009 0x00000076
+				0x00010000 0x00000022
+				0x00010001 0x0000002a
+				0x00010002 0x00000032
+				0x00010003 0x0000003a
+				0x00010004 0x00000042
+				0x00010005 0x0000004a
+				0x00010006 0x00000052
+				0x00010007 0x0000005a
+				0x00010008 0x00000062
+				0x00010009 0x0000006a
 				/* Calibration data group 3 */
-				0x00020000 0x00000029
-				0x00020001 0x00000033
-				0x00020002 0x0000003d
-				0x00020003 0x00000049
-				0x00020004 0x00000056
-				0x00020005 0x00000061
-				0x00020006 0x0000006d
+				0x00020000 0x00000021
+				0x00020001 0x0000002b
+				0x00020002 0x00000035
+				0x00020003 0x0000003e
+				0x00020004 0x00000048
+				0x00020005 0x00000052
+				0x00020006 0x0000005c
 				/* Calibration data group 4 */
-				0x00030000 0x00000021
-				0x00030001 0x0000002a
-				0x00030002 0x0000003c
-				0x00030003 0x0000004e>;
+				0x00030000 0x00000011
+				0x00030001 0x0000001a
+				0x00030002 0x00000024
+				0x00030003 0x0000002e
+				0x00030004 0x00000038
+				0x00030005 0x00000042
+				0x00030006 0x0000004c
+				0x00030007 0x00000056>;
 			big-endian;
 			#thermal-sensor-cells = <1>;
 		};
-- 
2.17.1

