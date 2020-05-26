Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD9C1A0713
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 08:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgDGGOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 02:14:46 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42746 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgDGGOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:14:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D1EB1A10E6;
        Tue,  7 Apr 2020 08:14:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 854A31A1064;
        Tue,  7 Apr 2020 08:14:40 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2074840294;
        Tue,  7 Apr 2020 14:14:35 +0800 (SGT)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, ran.wang_1@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: [PATCH 1/4] arm64: dts: lx2160a: add ftm_alarm0 DT node
Date:   Tue,  7 Apr 2020 14:10:51 +0800
Message-Id: <20200407061054.16912-1-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

The patch adds ftm_alarm0 DT node for Soc LX2160A
FlexTimer1 module is used to wakeup the system in deep sleep

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index e5ee5591e52b..e0d8d68ce070 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -16,6 +16,10 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		rtc1 = &ftm_alarm0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -768,6 +772,20 @@
 			timeout-sec = <30>;
 		};
 
+		rcpm: rcpm@1e34040 {
+			compatible = "fsl,lx2160a-rcpm", "fsl,qoriq-rcpm-2.1+";
+			reg = <0x0 0x1e34040 0x0 0x1c>;
+			#fsl,rcpm-wakeup-cells = <7>;
+			little-endian;
+		};
+
+		ftm_alarm0: timer@2800000 {
+			compatible = "fsl,lx2160a-ftm-alarm";
+			reg = <0x0 0x2800000 0x0 0x10000>;
+			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
+			interrupts = <0 44 4>;
+		};
+
 		usb0: usb@3100000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
-- 
2.17.1

