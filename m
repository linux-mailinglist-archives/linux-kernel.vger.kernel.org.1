Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFADF280373
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbgJAQCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:02:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38698 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732576AbgJAQCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:02:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 43C4C29D764
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 12/12] arm64: dts: mediatek: Add mt8183 power domains controller
Date:   Thu,  1 Oct 2020 18:01:54 +0200
Message-Id: <20201001160154.3587848-13-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001160154.3587848-1-enric.balletbo@collabora.com>
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Add power domains controller node for SoC mt8183

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2: None

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 162 +++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c         |   4 -
 2 files changed, 162 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 0e4d3e18cad5..9082bc65e15e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/mt8183-power.h>
 #include <dt-bindings/reset-controller/mt8183-resets.h>
 #include <dt-bindings/phy/phy.h>
 #include "mt8183-pinfunc.h"
@@ -316,6 +317,167 @@ pio: pinctrl@10005000 {
 			#interrupt-cells = <2>;
 		};
 
+		scpsys: syscon@10006000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0 0x10006000 0 0x1000>;
+			#power-domain-cells = <1>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8183-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				/* power domain of the SoC */
+				power-domain@MT8183_POWER_DOMAIN_AUDIO {
+					reg = <MT8183_POWER_DOMAIN_AUDIO>;
+					clocks = <&topckgen CLK_TOP_MUX_AUD_INTBUS>,
+						 <&infracfg CLK_INFRA_AUDIO>,
+						 <&infracfg CLK_INFRA_AUDIO_26M_BCLK>;
+					clock-names = "audio", "audio1", "audio2";
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8183_POWER_DOMAIN_CONN {
+					reg = <MT8183_POWER_DOMAIN_CONN>;
+					mediatek,infracfg = <&infracfg>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8183_POWER_DOMAIN_MFG_ASYNC {
+					reg = <MT8183_POWER_DOMAIN_MFG_ASYNC>;
+					clocks =  <&topckgen CLK_TOP_MUX_MFG>;
+					clock-names = "mfg";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8183_POWER_DOMAIN_MFG {
+						reg = <MT8183_POWER_DOMAIN_MFG>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8183_POWER_DOMAIN_MFG_CORE0 {
+							reg = <MT8183_POWER_DOMAIN_MFG_CORE0>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8183_POWER_DOMAIN_MFG_CORE1 {
+							reg = <MT8183_POWER_DOMAIN_MFG_CORE1>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8183_POWER_DOMAIN_MFG_2D {
+							reg = <MT8183_POWER_DOMAIN_MFG_2D>;
+							mediatek,infracfg = <&infracfg>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8183_POWER_DOMAIN_DISP {
+					reg = <MT8183_POWER_DOMAIN_DISP>;
+					clocks = <&topckgen CLK_TOP_MUX_MM>,
+						 <&mmsys CLK_MM_SMI_COMMON>,
+						 <&mmsys CLK_MM_SMI_LARB0>,
+						 <&mmsys CLK_MM_SMI_LARB1>,
+						 <&mmsys CLK_MM_GALS_COMM0>,
+						 <&mmsys CLK_MM_GALS_COMM1>,
+						 <&mmsys CLK_MM_GALS_CCU2MM>,
+						 <&mmsys CLK_MM_GALS_IPU12MM>,
+						 <&mmsys CLK_MM_GALS_IMG2MM>,
+						 <&mmsys CLK_MM_GALS_CAM2MM>,
+						 <&mmsys CLK_MM_GALS_IPU2MM>;
+					clock-names = "mm", "mm-0", "mm-1", "mm-2", "mm-3",
+						      "mm-4", "mm-5", "mm-6", "mm-7",
+						      "mm-8", "mm-9";
+					mediatek,infracfg = <&infracfg>;
+					mediatek,smi = <&smi_common>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8183_POWER_DOMAIN_CAM {
+						reg = <MT8183_POWER_DOMAIN_CAM>;
+						clocks = <&topckgen CLK_TOP_MUX_CAM>,
+							 <&camsys CLK_CAM_LARB6>,
+							 <&camsys CLK_CAM_LARB3>,
+							 <&camsys CLK_CAM_SENINF>,
+							 <&camsys CLK_CAM_CAMSV0>,
+							 <&camsys CLK_CAM_CAMSV1>,
+							 <&camsys CLK_CAM_CAMSV2>,
+							 <&camsys CLK_CAM_CCU>;
+						clock-names = "cam", "cam-0", "cam-1",
+							      "cam-2", "cam-3", "cam-4",
+							      "cam-5", "cam-6";
+						mediatek,infracfg = <&infracfg>;
+						mediatek,smi = <&smi_common>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8183_POWER_DOMAIN_ISP {
+						reg = <MT8183_POWER_DOMAIN_ISP>;
+						clocks = <&topckgen CLK_TOP_MUX_IMG>,
+							 <&imgsys CLK_IMG_LARB5>,
+							 <&imgsys CLK_IMG_LARB2>;
+						clock-names = "isp", "isp-0", "isp-1";
+						mediatek,infracfg = <&infracfg>;
+						mediatek,smi = <&smi_common>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8183_POWER_DOMAIN_VDEC {
+						reg = <MT8183_POWER_DOMAIN_VDEC>;
+						mediatek,smi = <&smi_common>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8183_POWER_DOMAIN_VENC {
+						reg = <MT8183_POWER_DOMAIN_VENC>;
+						mediatek,smi = <&smi_common>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8183_POWER_DOMAIN_VPU_TOP {
+						reg = <MT8183_POWER_DOMAIN_VPU_TOP>;
+						clocks = <&topckgen CLK_TOP_MUX_IPU_IF>,
+							 <&topckgen CLK_TOP_MUX_DSP>,
+							 <&ipu_conn CLK_IPU_CONN_IPU>,
+							 <&ipu_conn CLK_IPU_CONN_AHB>,
+							 <&ipu_conn CLK_IPU_CONN_AXI>,
+							 <&ipu_conn CLK_IPU_CONN_ISP>,
+							 <&ipu_conn CLK_IPU_CONN_CAM_ADL>,
+							 <&ipu_conn CLK_IPU_CONN_IMG_ADL>;
+						clock-names = "vpu", "vpu1", "vpu-0", "vpu-1",
+							      "vpu-2", "vpu-3", "vpu-4", "vpu-5";
+						mediatek,infracfg = <&infracfg>;
+						mediatek,smi = <&smi_common>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8183_POWER_DOMAIN_VPU_CORE0 {
+							reg = <MT8183_POWER_DOMAIN_VPU_CORE0>;
+							clocks = <&topckgen CLK_TOP_MUX_DSP1>;
+							clock-names = "vpu2";
+							mediatek,infracfg = <&infracfg>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8183_POWER_DOMAIN_VPU_CORE1 {
+							reg = <MT8183_POWER_DOMAIN_VPU_CORE1>;
+							clocks = <&topckgen CLK_TOP_MUX_DSP2>;
+							clock-names = "vpu3";
+							mediatek,infracfg = <&infracfg>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+			};
+		};
+
 		watchdog: watchdog@10007000 {
 			compatible = "mediatek,mt8183-wdt",
 				     "mediatek,mt6589-wdt";
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index ec4cc5eeabff..0c490f509655 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -560,10 +560,6 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 		.compatible = "mediatek,mt8173-mmsys",
 		.data = &mt8173_mmsys_driver_data,
 	},
-	{
-		.compatible = "mediatek,mt8183-mmsys",
-		.data = &mt8183_mmsys_driver_data,
-	},
 	{ }
 };
 
-- 
2.28.0

