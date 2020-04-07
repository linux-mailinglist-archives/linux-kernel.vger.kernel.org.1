Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 968741A0714
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 08:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgDGGOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 02:14:49 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38270 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgDGGOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:14:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B3ED201002;
        Tue,  7 Apr 2020 08:14:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A39D2200FE7;
        Tue,  7 Apr 2020 08:14:41 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4C627402B6;
        Tue,  7 Apr 2020 14:14:36 +0800 (SGT)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, ran.wang_1@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: [PATCH 2/4] arm64: dts: ls1028a: Add ftm_alarm0 DT node
Date:   Tue,  7 Apr 2020 14:10:52 +0800
Message-Id: <20200407061054.16912-2-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200407061054.16912-1-biwen.li@oss.nxp.com>
References: <20200407061054.16912-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

The patch adds ftm_alarm0 DT node for LS1028ARDB board
FlexTimer1 module is used to wakeup the system

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 0bf375ec959b..98233fe61037 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -17,6 +17,10 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		rtc1 = &ftm_alarm0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -724,6 +728,19 @@
 				little-endian;
 			};
 		};
+
+		rcpm: rcpm@1e34040 {
+			compatible = "fsl,ls1028a-rcpm", "fsl,qoriq-rcpm-2.1+";
+			reg = <0x0 0x1e34040 0x0 0x1c>;
+			#fsl,rcpm-wakeup-cells = <7>;
+		};
+
+		ftm_alarm0: timer@2800000 {
+			compatible = "fsl,ls1028a-ftm-alarm";
+			reg = <0x0 0x2800000 0x0 0x10000>;
+			fsl,rcpm-wakeup = <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	malidp0: display@f080000 {
-- 
2.17.1

