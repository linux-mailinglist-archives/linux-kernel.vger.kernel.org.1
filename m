Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4AB2F0D68
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbhAKHpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:45:01 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51727 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725880AbhAKHo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:44:57 -0500
X-UUID: 339b4f83d0924f52b1dab4da85b305e5-20210111
X-UUID: 339b4f83d0924f52b1dab4da85b305e5-20210111
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1010270250; Mon, 11 Jan 2021 15:43:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 15:43:58 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 15:43:57 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v3, 03/15] arm64: dts: mt8192: add display node
Date:   Mon, 11 Jan 2021 15:43:39 +0800
Message-ID: <1610351031-21133-4-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add display node

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 134 +++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index e12e024..dcf9fdf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -15,6 +15,11 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		ovl2-2l2 = &ovl_2l2;
+		rdma4 = &rdma4;
+	};
+
 	clk26m: oscillator0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -508,5 +513,134 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+		
+		mmsys: syscon@14000000 {
+			compatible = "mediatek,mt8192-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			//mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
+			//	 <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;
+			//mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+                mutex: mutex@14001000 {
+			compatible = "mediatek,mt8192-disp-mutex";
+			reg = <0 0x14001000 0 0x1000>;
+			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
+			//clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
+			//mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
+			//		      <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;
+		};
+
+		ovl0: ovl@14005000 {
+			compatible = "mediatek,mt8192-disp-ovl";
+			reg = <0 0x14005000 0 0x1000>;
+			interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0>;
+			//clocks = <&mmsys CLK_MM_DISP_OVL0>;
+			//iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>;
+			//power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
+			//mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
+		};
+
+		ovl_2l0: ovl@14006000 {
+			compatible = "mediatek,mt8192-disp-ovl-2l";
+			reg = <0 0x14006000 0 0x1000>;
+			interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0>;
+			//power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
+			//clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
+			//iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>;
+			//mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
+		};
+
+		rdma0: rdma@14007000 {
+			compatible = "mediatek,mt8192-disp-rdma";
+			reg = <0 0x14007000 0 0x1000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>;
+			//clocks = <&mmsys CLK_MM_DISP_RDMA0>;
+			//iommus = <&iommu0 M4U_PORT_L0_DISP_RDMA0>;
+			//mediatek,larb = <&larb0>;
+			//mediatek,rdma-fifo-size = <5120>;
+			//power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
+			//mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x7000 0x1000>;
+		};
+
+		color0: color@14009000 {
+			compatible = "mediatek,mt8192-disp-color",
+				     "mediatek,mt8173-disp-color";
+			reg = <0 0x14009000 0 0x1000>;
+			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
+			//power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
+			//clocks = <&mmsys CLK_MM_DISP_COLOR0>;
+			//mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x9000 0x1000>;
+		};
+
+		ccorr0: ccorr@1400a000 {
+			compatible = "mediatek,mt8192-disp-ccorr";
+			reg = <0 0x1400a000 0 0x1000>;
+			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
+			//power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
+			//clocks = <&mmsys CLK_MM_DISP_CCORR0>;
+			//mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xa000 0x1000>;
+		};
+
+		aal0: aal@1400b000 {
+			compatible = "mediatek,mt8192-disp-aal";
+			reg = <0 0x1400b000 0 0x1000>;
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>;
+			//power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
+			//clocks = <&mmsys CLK_MM_DISP_AAL0>;
+			//mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
+		};
+
+		gamma0: gamma@1400c000 {
+			compatible = "mediatek,mt8183-disp-gamma",
+				     "mediatek,mt8192-disp-gamma";
+			reg = <0 0x1400c000 0 0x1000>;
+			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>;
+			//power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
+			//clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
+			//mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
+		};
+
+		postmask0: postmask@1400d000 {
+			compatible = "mediatek,mt8192-disp-postmask";
+			reg = <0 0x1400d000 0 0x1000>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>;
+			//power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
+			//clocks = <&mmsys CLK_MM_DISP_POSTMASK0>;
+			//mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
+		};
+
+		dither0: dither@1400e000 {
+			compatible = "mediatek,mt8192-disp-dither",
+				     "mediatek,mt8183-disp-dither";
+			reg = <0 0x1400e000 0 0x1000>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>;
+			//power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
+			//clocks = <&mmsys CLK_MM_DISP_DITHER0>;
+			//mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
+		};
+
+		ovl_2l2: ovl@14014000 {
+			compatible = "mediatek,mt8192-disp-ovl-2l";
+			reg = <0 0x14014000 0 0x1000>;
+			interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH 0>;
+			//power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
+			//clocks = <&mmsys CLK_MM_DISP_OVL2_2L>;
+			//iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2>,
+			//	 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2_HDR>;
+			//mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
+		};
+
+		rdma4: rdma@14015000 {
+			compatible = "mediatek,mt8192-disp-rdma";
+			reg = <0 0x14015000 0 0x1000>;
+			interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>;
+			//power-domains = <&scpsys MT8192_POWER_DOMAIN_DISP>;
+			//clocks = <&mmsys CLK_MM_DISP_RDMA4>;
+			//iommus = <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
+			//mediatek,rdma-fifo-size = <2048>;
+			//mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
+		};
 	};
 };
-- 
1.8.1.1.dirty

