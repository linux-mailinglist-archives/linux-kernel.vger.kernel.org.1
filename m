Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0814329948C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788862AbgJZR4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:56:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33836 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788708AbgJZRzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:55:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 93D531F44FCB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 03/16] arm64: dts: mediatek: Add mt8173 power domain controller
Date:   Mon, 26 Oct 2020 18:55:12 +0100
Message-Id: <20201026175526.2915399-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026175526.2915399-1-enric.balletbo@collabora.com>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domain controller node for SoC mt8173.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2:
- Add a scpsys syscon node as parent and a SPM (System Power Manager) as
  a child.

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 164 ++++++++++++++++-------
 1 file changed, 115 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 5e046f9d48ce..7fa870e4386a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -450,16 +450,82 @@ pins1 {
 			};
 		};
 
-		scpsys: power-controller@10006000 {
-			compatible = "mediatek,mt8173-scpsys";
-			#power-domain-cells = <1>;
+		scpsys: syscon@10006000 {
+			compatible = "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-			clocks = <&clk26m>,
-				 <&topckgen CLK_TOP_MM_SEL>,
-				 <&topckgen CLK_TOP_VENC_SEL>,
-				 <&topckgen CLK_TOP_VENC_LT_SEL>;
-			clock-names = "mfg", "mm", "venc", "venc_lt";
-			infracfg = <&infracfg>;
+			#power-domain-cells = <1>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8173-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				/* power domains of the SoC */
+				power-domain@MT8173_POWER_DOMAIN_VDEC {
+					reg = <MT8173_POWER_DOMAIN_VDEC>;
+					clocks = <&topckgen CLK_TOP_MM_SEL>;
+					clock-names = "mm";
+					#power-domain-cells = <0>;
+				};
+				power-domain@MT8173_POWER_DOMAIN_VENC {
+					reg = <MT8173_POWER_DOMAIN_VENC>;
+					clocks = <&topckgen CLK_TOP_MM_SEL>,
+						 <&topckgen CLK_TOP_VENC_SEL>;
+					clock-names = "mm", "venc";
+					#power-domain-cells = <0>;
+				};
+				power-domain@MT8173_POWER_DOMAIN_ISP {
+					reg = <MT8173_POWER_DOMAIN_ISP>;
+					clocks = <&topckgen CLK_TOP_MM_SEL>;
+					clock-names = "mm";
+					#power-domain-cells = <0>;
+				};
+				power-domain@MT8173_POWER_DOMAIN_MM {
+					reg = <MT8173_POWER_DOMAIN_MM>;
+					clocks = <&topckgen CLK_TOP_MM_SEL>;
+					clock-names = "mm";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+				power-domain@MT8173_POWER_DOMAIN_VENC_LT {
+					reg = <MT8173_POWER_DOMAIN_VENC_LT>;
+					clocks = <&topckgen CLK_TOP_MM_SEL>,
+						 <&topckgen CLK_TOP_VENC_LT_SEL>;
+					clock-names = "mm", "venclt";
+					#power-domain-cells = <0>;
+				};
+				power-domain@MT8173_POWER_DOMAIN_AUDIO {
+					reg = <MT8173_POWER_DOMAIN_AUDIO>;
+					#power-domain-cells = <0>;
+				};
+				power-domain@MT8173_POWER_DOMAIN_USB {
+					reg = <MT8173_POWER_DOMAIN_USB>;
+					#power-domain-cells = <0>;
+				};
+				power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
+					reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
+					clocks = <&clk26m>;
+					clock-names = "mfg";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8173_POWER_DOMAIN_MFG_2D {
+						reg = <MT8173_POWER_DOMAIN_MFG_2D>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8173_POWER_DOMAIN_MFG {
+							reg = <MT8173_POWER_DOMAIN_MFG>;
+							#power-domain-cells = <0>;
+							mediatek,infracfg = <&infracfg>;
+						};
+					};
+				};
+			};
 		};
 
 		watchdog: watchdog@10007000 {
@@ -792,7 +858,7 @@ afe: audio-controller@11220000  {
 			compatible = "mediatek,mt8173-afe-pcm";
 			reg = <0 0x11220000 0 0x1000>;
 			interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_FALLING>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_AUDIO>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_AUDIO>;
 			clocks = <&infracfg CLK_INFRA_AUDIO>,
 				 <&topckgen CLK_TOP_AUDIO_SEL>,
 				 <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
@@ -868,7 +934,7 @@ ssusb: usb@11271000 {
 			phys = <&u2port0 PHY_TYPE_USB2>,
 			       <&u3port0 PHY_TYPE_USB3>,
 			       <&u2port1 PHY_TYPE_USB2>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_USB>;
 			clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
 			clock-names = "sys_ck", "ref_ck";
 			mediatek,syscon-wakeup = <&pericfg 0x400 1>;
@@ -882,7 +948,7 @@ usb_host: xhci@11270000 {
 				reg = <0 0x11270000 0 0x1000>;
 				reg-names = "mac";
 				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
-				power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
+				power-domains = <&spm MT8173_POWER_DOMAIN_USB>;
 				clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
 				clock-names = "sys_ck", "ref_ck";
 				status = "disabled";
@@ -925,7 +991,7 @@ u2port1: usb-phy@11291000 {
 		mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8173-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			assigned-clocks = <&topckgen CLK_TOP_MM_SEL>;
 			assigned-clock-rates = <400000000>;
 			#clock-cells = <1>;
@@ -940,7 +1006,7 @@ mdp_rdma0: rdma@14001000 {
 			reg = <0 0x14001000 0 0x1000>;
 			clocks = <&mmsys CLK_MM_MDP_RDMA0>,
 				 <&mmsys CLK_MM_MUTEX_32K>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
 			mediatek,larb = <&larb0>;
 			mediatek,vpu = <&vpu>;
@@ -951,7 +1017,7 @@ mdp_rdma1: rdma@14002000 {
 			reg = <0 0x14002000 0 0x1000>;
 			clocks = <&mmsys CLK_MM_MDP_RDMA1>,
 				 <&mmsys CLK_MM_MUTEX_32K>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_RDMA1>;
 			mediatek,larb = <&larb4>;
 		};
@@ -960,28 +1026,28 @@ mdp_rsz0: rsz@14003000 {
 			compatible = "mediatek,mt8173-mdp-rsz";
 			reg = <0 0x14003000 0 0x1000>;
 			clocks = <&mmsys CLK_MM_MDP_RSZ0>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 		};
 
 		mdp_rsz1: rsz@14004000 {
 			compatible = "mediatek,mt8173-mdp-rsz";
 			reg = <0 0x14004000 0 0x1000>;
 			clocks = <&mmsys CLK_MM_MDP_RSZ1>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 		};
 
 		mdp_rsz2: rsz@14005000 {
 			compatible = "mediatek,mt8173-mdp-rsz";
 			reg = <0 0x14005000 0 0x1000>;
 			clocks = <&mmsys CLK_MM_MDP_RSZ2>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 		};
 
 		mdp_wdma0: wdma@14006000 {
 			compatible = "mediatek,mt8173-mdp-wdma";
 			reg = <0 0x14006000 0 0x1000>;
 			clocks = <&mmsys CLK_MM_MDP_WDMA>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_WDMA>;
 			mediatek,larb = <&larb0>;
 		};
@@ -990,7 +1056,7 @@ mdp_wrot0: wrot@14007000 {
 			compatible = "mediatek,mt8173-mdp-wrot";
 			reg = <0 0x14007000 0 0x1000>;
 			clocks = <&mmsys CLK_MM_MDP_WROT0>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_WROT0>;
 			mediatek,larb = <&larb0>;
 		};
@@ -999,7 +1065,7 @@ mdp_wrot1: wrot@14008000 {
 			compatible = "mediatek,mt8173-mdp-wrot";
 			reg = <0 0x14008000 0 0x1000>;
 			clocks = <&mmsys CLK_MM_MDP_WROT1>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_WROT1>;
 			mediatek,larb = <&larb4>;
 		};
@@ -1008,7 +1074,7 @@ ovl0: ovl@1400c000 {
 			compatible = "mediatek,mt8173-disp-ovl";
 			reg = <0 0x1400c000 0 0x1000>;
 			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_OVL0>;
 			iommus = <&iommu M4U_PORT_DISP_OVL0>;
 			mediatek,larb = <&larb0>;
@@ -1019,7 +1085,7 @@ ovl1: ovl@1400d000 {
 			compatible = "mediatek,mt8173-disp-ovl";
 			reg = <0 0x1400d000 0 0x1000>;
 			interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_OVL1>;
 			iommus = <&iommu M4U_PORT_DISP_OVL1>;
 			mediatek,larb = <&larb4>;
@@ -1030,7 +1096,7 @@ rdma0: rdma@1400e000 {
 			compatible = "mediatek,mt8173-disp-rdma";
 			reg = <0 0x1400e000 0 0x1000>;
 			interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
 			mediatek,larb = <&larb0>;
@@ -1041,7 +1107,7 @@ rdma1: rdma@1400f000 {
 			compatible = "mediatek,mt8173-disp-rdma";
 			reg = <0 0x1400f000 0 0x1000>;
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
 			mediatek,larb = <&larb4>;
@@ -1052,7 +1118,7 @@ rdma2: rdma@14010000 {
 			compatible = "mediatek,mt8173-disp-rdma";
 			reg = <0 0x14010000 0 0x1000>;
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA2>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA2>;
 			mediatek,larb = <&larb4>;
@@ -1063,7 +1129,7 @@ wdma0: wdma@14011000 {
 			compatible = "mediatek,mt8173-disp-wdma";
 			reg = <0 0x14011000 0 0x1000>;
 			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_WDMA0>;
 			iommus = <&iommu M4U_PORT_DISP_WDMA0>;
 			mediatek,larb = <&larb0>;
@@ -1074,7 +1140,7 @@ wdma1: wdma@14012000 {
 			compatible = "mediatek,mt8173-disp-wdma";
 			reg = <0 0x14012000 0 0x1000>;
 			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_WDMA1>;
 			iommus = <&iommu M4U_PORT_DISP_WDMA1>;
 			mediatek,larb = <&larb4>;
@@ -1085,7 +1151,7 @@ color0: color@14013000 {
 			compatible = "mediatek,mt8173-disp-color";
 			reg = <0 0x14013000 0 0x1000>;
 			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x3000 0x1000>;
 		};
@@ -1094,7 +1160,7 @@ color1: color@14014000 {
 			compatible = "mediatek,mt8173-disp-color";
 			reg = <0 0x14014000 0 0x1000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_COLOR1>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
 		};
@@ -1103,7 +1169,7 @@ aal@14015000 {
 			compatible = "mediatek,mt8173-disp-aal";
 			reg = <0 0x14015000 0 0x1000>;
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_AAL>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
 		};
@@ -1112,7 +1178,7 @@ gamma@14016000 {
 			compatible = "mediatek,mt8173-disp-gamma";
 			reg = <0 0x14016000 0 0x1000>;
 			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_GAMMA>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x6000 0x1000>;
 		};
@@ -1120,21 +1186,21 @@ gamma@14016000 {
 		merge@14017000 {
 			compatible = "mediatek,mt8173-disp-merge";
 			reg = <0 0x14017000 0 0x1000>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_MERGE>;
 		};
 
 		split0: split@14018000 {
 			compatible = "mediatek,mt8173-disp-split";
 			reg = <0 0x14018000 0 0x1000>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_SPLIT0>;
 		};
 
 		split1: split@14019000 {
 			compatible = "mediatek,mt8173-disp-split";
 			reg = <0 0x14019000 0 0x1000>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_SPLIT1>;
 		};
 
@@ -1142,7 +1208,7 @@ ufoe@1401a000 {
 			compatible = "mediatek,mt8173-disp-ufoe";
 			reg = <0 0x1401a000 0 0x1000>;
 			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_UFOE>;
 		};
 
@@ -1150,7 +1216,7 @@ dsi0: dsi@1401b000 {
 			compatible = "mediatek,mt8173-dsi";
 			reg = <0 0x1401b000 0 0x1000>;
 			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DSI0_ENGINE>,
 				 <&mmsys CLK_MM_DSI0_DIGITAL>,
 				 <&mipi_tx0>;
@@ -1164,7 +1230,7 @@ dsi1: dsi@1401c000 {
 			compatible = "mediatek,mt8173-dsi";
 			reg = <0 0x1401c000 0 0x1000>;
 			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DSI1_ENGINE>,
 				 <&mmsys CLK_MM_DSI1_DIGITAL>,
 				 <&mipi_tx1>;
@@ -1178,7 +1244,7 @@ dpi0: dpi@1401d000 {
 			compatible = "mediatek,mt8173-dpi";
 			reg = <0 0x1401d000 0 0x1000>;
 			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DPI_PIXEL>,
 				 <&mmsys CLK_MM_DPI_ENGINE>,
 				 <&apmixedsys CLK_APMIXED_TVDPLL>;
@@ -1218,7 +1284,7 @@ mutex: mutex@14020000 {
 			compatible = "mediatek,mt8173-disp-mutex";
 			reg = <0 0x14020000 0 0x1000>;
 			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_MUTEX_32K>;
 			mediatek,gce-events = <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
                                               <CMDQ_EVENT_MUTEX1_STREAM_EOF>;
@@ -1228,7 +1294,7 @@ larb0: larb@14021000 {
 			compatible = "mediatek,mt8173-smi-larb";
 			reg = <0 0x14021000 0 0x1000>;
 			mediatek,smi = <&smi_common>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_SMI_LARB0>,
 				 <&mmsys CLK_MM_SMI_LARB0>;
 			clock-names = "apb", "smi";
@@ -1237,7 +1303,7 @@ larb0: larb@14021000 {
 		smi_common: smi@14022000 {
 			compatible = "mediatek,mt8173-smi-common";
 			reg = <0 0x14022000 0 0x1000>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_SMI_COMMON>,
 				 <&mmsys CLK_MM_SMI_COMMON>;
 			clock-names = "apb", "smi";
@@ -1285,7 +1351,7 @@ larb4: larb@14027000 {
 			compatible = "mediatek,mt8173-smi-larb";
 			reg = <0 0x14027000 0 0x1000>;
 			mediatek,smi = <&smi_common>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_SMI_LARB4>,
 				 <&mmsys CLK_MM_SMI_LARB4>;
 			clock-names = "apb", "smi";
@@ -1301,7 +1367,7 @@ larb2: larb@15001000 {
 			compatible = "mediatek,mt8173-smi-larb";
 			reg = <0 0x15001000 0 0x1000>;
 			mediatek,smi = <&smi_common>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_ISP>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_ISP>;
 			clocks = <&imgsys CLK_IMG_LARB2_SMI>,
 				 <&imgsys CLK_IMG_LARB2_SMI>;
 			clock-names = "apb", "smi";
@@ -1338,7 +1404,7 @@ vcodec_dec: vcodec@16000000 {
 				 <&iommu M4U_PORT_HW_VDEC_VLD_EXT>,
 				 <&iommu M4U_PORT_HW_VDEC_VLD2_EXT>;
 			mediatek,vpu = <&vpu>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_VDEC>;
 			clocks = <&apmixedsys CLK_APMIXED_VCODECPLL>,
 				 <&topckgen CLK_TOP_UNIVPLL_D2>,
 				 <&topckgen CLK_TOP_CCI400_SEL>,
@@ -1370,7 +1436,7 @@ larb1: larb@16010000 {
 			compatible = "mediatek,mt8173-smi-larb";
 			reg = <0 0x16010000 0 0x1000>;
 			mediatek,smi = <&smi_common>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_VDEC>;
 			clocks = <&vdecsys CLK_VDEC_CKEN>,
 				 <&vdecsys CLK_VDEC_LARB_CKEN>;
 			clock-names = "apb", "smi";
@@ -1386,7 +1452,7 @@ larb3: larb@18001000 {
 			compatible = "mediatek,mt8173-smi-larb";
 			reg = <0 0x18001000 0 0x1000>;
 			mediatek,smi = <&smi_common>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_VENC>;
 			clocks = <&vencsys CLK_VENC_CKE1>,
 				 <&vencsys CLK_VENC_CKE0>;
 			clock-names = "apb", "smi";
@@ -1443,7 +1509,7 @@ jpegdec: jpegdec@18004000 {
 				 <&vencsys CLK_VENC_CKE3>;
 			clock-names = "jpgdec-smi",
 				      "jpgdec";
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_VENC>;
 			mediatek,larb = <&larb3>;
 			iommus = <&iommu M4U_PORT_JPGDEC_WDMA>,
 				 <&iommu M4U_PORT_JPGDEC_BSDMA>;
@@ -1459,7 +1525,7 @@ larb5: larb@19001000 {
 			compatible = "mediatek,mt8173-smi-larb";
 			reg = <0 0x19001000 0 0x1000>;
 			mediatek,smi = <&smi_common>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC_LT>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_VENC_LT>;
 			clocks = <&vencltsys CLK_VENCLT_CKE1>,
 				 <&vencltsys CLK_VENCLT_CKE0>;
 			clock-names = "apb", "smi";
-- 
2.28.0

