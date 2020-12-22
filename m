Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708122E0B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgLVOAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:00:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59933 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727050AbgLVOAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:00:52 -0500
X-UUID: e7a17596386048a79cceac2aea50eae5-20201222
X-UUID: e7a17596386048a79cceac2aea50eae5-20201222
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1638723132; Tue, 22 Dec 2020 22:00:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Dec 2020 22:00:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Dec 2020 22:00:00 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4] arm64: dts: mediatek: Add mt8192 power domains controller
Date:   Tue, 22 Dec 2020 21:59:54 +0800
Message-ID: <1608645594-18809-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domains controller node for SoC mt8192

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
This patch is base on v5.10-rc1,
series "Add new driver for SCPSYS power domains controller"[1]
and series "Add MediaTek MT8192 clock provider device nodes"[2]

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=374013
[2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=405329

change since v4: correct the power domain node names

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 201 +++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index ac5dca6..9958a64 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
+#include <dt-bindings/power/mt8192-power.h>
 
 / {
 	compatible = "mediatek,mt8192";
@@ -257,6 +258,206 @@
 			#interrupt-cells = <2>;
 		};
 
+		scpsys: syscon@10006000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0 0x10006000 0 0x1000>;
+			#power-domain-cells = <1>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8192-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				/* power domain of the SoC */
+				power-domain@MT8192_POWER_DOMAIN_AUDIO {
+					reg = <MT8192_POWER_DOMAIN_AUDIO>;
+					clocks = <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
+						 <&infracfg CLK_INFRA_AUDIO_26M_B>,
+						 <&infracfg CLK_INFRA_AUDIO>;
+					clock-names = "audio", "audio1", "audio2";
+					mediatek,infracfg = <&infracfg>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8192_POWER_DOMAIN_CONN {
+					reg = <MT8192_POWER_DOMAIN_CONN>;
+					clocks = <&infracfg CLK_INFRA_PMIC_CONN>;
+					clock-names = "conn";
+					mediatek,infracfg = <&infracfg>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8192_POWER_DOMAIN_MFG0 {
+					reg = <MT8192_POWER_DOMAIN_MFG0>;
+					clocks = <&topckgen CLK_TOP_MFG_PLL_SEL>;
+					clock-names = "mfg";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8192_POWER_DOMAIN_MFG1 {
+						reg = <MT8192_POWER_DOMAIN_MFG1>;
+						mediatek,infracfg = <&infracfg>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8192_POWER_DOMAIN_MFG2 {
+							reg = <MT8192_POWER_DOMAIN_MFG2>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8192_POWER_DOMAIN_MFG3 {
+							reg = <MT8192_POWER_DOMAIN_MFG3>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8192_POWER_DOMAIN_MFG4 {
+							reg = <MT8192_POWER_DOMAIN_MFG4>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8192_POWER_DOMAIN_MFG5 {
+							reg = <MT8192_POWER_DOMAIN_MFG5>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8192_POWER_DOMAIN_MFG6 {
+							reg = <MT8192_POWER_DOMAIN_MFG6>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8192_POWER_DOMAIN_DISP {
+					reg = <MT8192_POWER_DOMAIN_DISP>;
+					clocks = <&topckgen CLK_TOP_DISP_SEL>,
+						 <&mmsys CLK_MM_SMI_INFRA>,
+						 <&mmsys CLK_MM_SMI_COMMON>,
+						 <&mmsys CLK_MM_SMI_GALS>,
+						 <&mmsys CLK_MM_SMI_IOMMU>;
+					clock-names = "disp", "disp-0", "disp-1", "disp-2",
+						      "disp-3";
+					mediatek,infracfg = <&infracfg>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8192_POWER_DOMAIN_IPE {
+						reg = <MT8192_POWER_DOMAIN_IPE>;
+						clocks = <&topckgen CLK_TOP_IPE_SEL>,
+							 <&ipesys CLK_IPE_LARB19>,
+							 <&ipesys CLK_IPE_LARB20>,
+							 <&ipesys CLK_IPE_SMI_SUBCOM>,
+							 <&ipesys CLK_IPE_GALS>;
+						clock-names = "ipe", "ipe-0", "ipe-1", "ipe-2",
+							      "ipe-3";
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8192_POWER_DOMAIN_ISP {
+						reg = <MT8192_POWER_DOMAIN_ISP>;
+						clocks = <&topckgen CLK_TOP_IMG1_SEL>,
+							 <&imgsys CLK_IMG_LARB9>,
+							 <&imgsys CLK_IMG_GALS>;
+						clock-names = "isp", "isp-0", "isp-1";
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8192_POWER_DOMAIN_ISP2 {
+						reg = <MT8192_POWER_DOMAIN_ISP2>;
+						clocks = <&topckgen CLK_TOP_IMG2_SEL>,
+							 <&imgsys2 CLK_IMG2_LARB11>,
+							 <&imgsys2 CLK_IMG2_GALS>;
+						clock-names = "isp2", "isp2-0", "isp2-1";
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8192_POWER_DOMAIN_MDP {
+						reg = <MT8192_POWER_DOMAIN_MDP>;
+						clocks = <&topckgen CLK_TOP_MDP_SEL>,
+							 <&mdpsys CLK_MDP_SMI0>;
+						clock-names = "mdp", "mdp-0";
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8192_POWER_DOMAIN_VENC {
+						reg = <MT8192_POWER_DOMAIN_VENC>;
+						clocks = <&topckgen CLK_TOP_VENC_SEL>,
+							 <&vencsys CLK_VENC_SET1_VENC>;
+						clock-names = "venc", "venc-0";
+						mediatek,infracfg = <&infracfg>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8192_POWER_DOMAIN_VDEC {
+						reg = <MT8192_POWER_DOMAIN_VDEC>;
+						clocks = <&topckgen CLK_TOP_VDEC_SEL>,
+							 <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
+							 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
+							 <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
+						clock-names = "vdec", "vdec-0", "vdec-1", "vdec-2";
+						mediatek,infracfg = <&infracfg>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8192_POWER_DOMAIN_VDEC2 {
+							reg = <MT8192_POWER_DOMAIN_VDEC2>;
+							clocks = <&vdecsys CLK_VDEC_VDEC>,
+								 <&vdecsys CLK_VDEC_LAT>,
+								 <&vdecsys CLK_VDEC_LARB1>;
+							clock-names = "vdec2-0", "vdec2-1",
+								      "vdec2-2";
+							#power-domain-cells = <0>;
+						};
+					};
+
+					power-domain@MT8192_POWER_DOMAIN_CAM {
+						reg = <MT8192_POWER_DOMAIN_CAM>;
+						clocks = <&topckgen CLK_TOP_CAM_SEL>,
+							 <&camsys CLK_CAM_LARB13>,
+							 <&camsys CLK_CAM_LARB14>,
+							 <&camsys CLK_CAM_CCU_GALS>,
+							 <&camsys CLK_CAM_CAM2MM_GALS>;
+						clock-names = "cam", "cam-0", "cam-1", "cam-2",
+							      "cam-3";
+						mediatek,infracfg = <&infracfg>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8192_POWER_DOMAIN_CAM_RAWA {
+							reg = <MT8192_POWER_DOMAIN_CAM_RAWA>;
+							clocks = <&camsys_rawa CLK_CAM_RAWA_LARBX>;
+							clock-names = "cam_rawa-0";
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8192_POWER_DOMAIN_CAM_RAWB {
+							reg = <MT8192_POWER_DOMAIN_CAM_RAWB>;
+							clocks = <&camsys_rawb CLK_CAM_RAWB_LARBX>;
+							clock-names = "cam_rawb-0";
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8192_POWER_DOMAIN_CAM_RAWC {
+							reg = <MT8192_POWER_DOMAIN_CAM_RAWC>;
+							clocks = <&camsys_rawc CLK_CAM_RAWC_LARBX>;
+							clock-names = "cam_rawc-0";
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+			};
+		};
+
 		apmixedsys: syscon@1000c000 {
 			compatible = "mediatek,mt8192-apmixedsys", "syscon";
 			reg = <0 0x1000c000 0 0x1000>;
-- 
1.8.1.1.dirty

