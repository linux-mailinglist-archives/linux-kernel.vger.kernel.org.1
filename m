Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DF12C6364
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgK0Ktl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgK0Ktk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:49:40 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD44C0613D1;
        Fri, 27 Nov 2020 02:49:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D05161F461A4
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/3] arm64: dts: mt8183: Add iommu and larb nodes
Date:   Fri, 27 Nov 2020 11:49:29 +0100
Message-Id: <20201127104930.1981497-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127104930.1981497-1-enric.balletbo@collabora.com>
References: <20201127104930.1981497-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iommu and larb nodes to the MT8183.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 79 ++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index da7212e21fdf..ba9ff192cda3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/memory/mt8183-larb-port.h>
 #include <dt-bindings/power/mt8183-power.h>
 #include <dt-bindings/reset-controller/mt8183-resets.h>
 #include <dt-bindings/phy/phy.h>
@@ -521,6 +522,15 @@ systimer: timer@10017000 {
 			clock-names = "clk13m";
 		};
 
+		iommu: iommu@10205000 {
+			compatible = "mediatek,mt8183-m4u";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,larbs = <&larb0 &larb1 &larb2 &larb3
+					  &larb4 &larb5 &larb6>;
+			#iommu-cells = <1>;
+		};
+
 		gce: mailbox@10238000 {
 			compatible = "mediatek,mt8183-gce";
 			reg = <0 0x10238000 0 0x4000>;
@@ -968,6 +978,16 @@ dsi0: dsi@14014000 {
 			phy-names = "dphy";
 		};
 
+		larb0: larb@14017000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x14017000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_SMI_LARB0>,
+				 <&mmsys CLK_MM_SMI_LARB0>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+			clock-names = "apb", "smi";
+		};
+
 		smi_common: smi@14019000 {
 			compatible = "mediatek,mt8183-smi-common", "syscon";
 			reg = <0 0x14019000 0 0x1000>;
@@ -984,18 +1004,57 @@ imgsys: syscon@15020000 {
 			#clock-cells = <1>;
 		};
 
+		larb5: larb@15021000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x15021000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&imgsys CLK_IMG_LARB5>, <&imgsys CLK_IMG_LARB5>,
+				 <&mmsys CLK_MM_GALS_IMG2MM>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8183_POWER_DOMAIN_ISP>;
+		};
+
+		larb2: larb@1502f000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x1502f000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&imgsys CLK_IMG_LARB2>, <&imgsys CLK_IMG_LARB2>,
+				 <&mmsys CLK_MM_GALS_IPU2MM>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8183_POWER_DOMAIN_ISP>;
+		};
+
 		vdecsys: syscon@16000000 {
 			compatible = "mediatek,mt8183-vdecsys", "syscon";
 			reg = <0 0x16000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb1: larb@16010000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x16010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vdecsys CLK_VDEC_VDEC>, <&vdecsys CLK_VDEC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8183_POWER_DOMAIN_VDEC>;
+		};
+
 		vencsys: syscon@17000000 {
 			compatible = "mediatek,mt8183-vencsys", "syscon";
 			reg = <0 0x17000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb4: larb@17010000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x17010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vencsys CLK_VENC_LARB>,
+				 <&vencsys CLK_VENC_LARB>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8183_POWER_DOMAIN_VENC>;
+		};
+
 		ipu_conn: syscon@19000000 {
 			compatible = "mediatek,mt8183-ipu_conn", "syscon";
 			reg = <0 0x19000000 0 0x1000>;
@@ -1025,5 +1084,25 @@ camsys: syscon@1a000000 {
 			reg = <0 0x1a000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		larb6: larb@1a001000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x1a001000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&camsys CLK_CAM_LARB6>, <&camsys CLK_CAM_LARB6>,
+				 <&mmsys CLK_MM_GALS_CAM2MM>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8183_POWER_DOMAIN_CAM>;
+		};
+
+		larb3: larb@1a002000 {
+			compatible = "mediatek,mt8183-smi-larb";
+			reg = <0 0x1a002000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&camsys CLK_CAM_LARB3>, <&camsys CLK_CAM_LARB3>,
+				 <&mmsys CLK_MM_GALS_IPU12MM>;
+			clock-names = "apb", "smi", "gals";
+			power-domains = <&spm MT8183_POWER_DOMAIN_CAM>;
+		};
 	};
 };
-- 
2.29.2

