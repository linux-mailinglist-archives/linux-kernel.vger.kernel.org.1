Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63A32C6369
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgK0Ktq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgK0Ktl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:49:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964A1C0613D4;
        Fri, 27 Nov 2020 02:49:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B5DBE1F461A2
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] arm64: dts: mt8183: Add dsi node
Date:   Fri, 27 Nov 2020 11:49:28 +0100
Message-Id: <20201127104930.1981497-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127104930.1981497-1-enric.balletbo@collabora.com>
References: <20201127104930.1981497-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jitao Shi <jitao.shi@mediatek.com>

Add dsi and mipitx nodes to the MT8183.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 7839480df075..da7212e21fdf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -892,10 +892,27 @@ mmc1: mmc@11240000 {
 			status = "disabled";
 		};
 
+		mipi_tx0: mipi-dphy@11e50000 {
+			compatible = "mediatek,mt8183-mipi-tx";
+			reg = <0 0x11e50000 0 0x1000>;
+			clocks = <&apmixedsys CLK_APMIXED_MIPID0_26M>;
+			clock-names = "ref_clk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+			clock-output-names = "mipi_tx0_pll";
+			nvmem-cells = <&mipi_tx_calibration>;
+			nvmem-cell-names = "calibration-data";
+		};
+
 		efuse: efuse@11f10000 {
 			compatible = "mediatek,mt8183-efuse",
 				     "mediatek,efuse";
 			reg = <0 0x11f10000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			mipi_tx_calibration: calib@190 {
+				reg = <0x190 0xc>;
+			};
 		};
 
 		u3phy: usb-phy@11f40000 {
@@ -937,6 +954,20 @@ mmsys: syscon@14000000 {
 			#clock-cells = <1>;
 		};
 
+		dsi0: dsi@14014000 {
+			compatible = "mediatek,mt8183-dsi";
+			reg = <0 0x14014000 0 0x1000>;
+			interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+			mediatek,syscon-dsi = <&mmsys 0x140>;
+			clocks = <&mmsys CLK_MM_DSI0_MM>,
+				 <&mmsys CLK_MM_DSI0_IF>,
+				 <&mipi_tx0>;
+			clock-names = "engine", "digital", "hs";
+			phys = <&mipi_tx0>;
+			phy-names = "dphy";
+		};
+
 		smi_common: smi@14019000 {
 			compatible = "mediatek,mt8183-smi-common", "syscon";
 			reg = <0 0x14019000 0 0x1000>;
-- 
2.29.2

