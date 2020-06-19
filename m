Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA6220064B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbgFSK3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 06:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbgFSK2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:28:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFC3C06174E;
        Fri, 19 Jun 2020 03:28:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 541892A51FB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, erwanaliasr1@gmail.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 6/7] arm64: dts: mt8183: Add USB3.0 support
Date:   Fri, 19 Jun 2020 12:27:56 +0200
Message-Id: <20200619102757.1358675-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619102757.1358675-1-enric.balletbo@collabora.com>
References: <20200619102757.1358675-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB3.0 phyter and controller for the MediaTek's MT8183 SoC.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 57 ++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index e356076749148..a1576f1b5a447 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/reset-controller/mt8183-resets.h>
+#include <dt-bindings/phy/phy.h>
 #include "mt8183-pinfunc.h"
 
 / {
@@ -648,6 +649,36 @@ i2c8: i2c@1101b000 {
 			status = "disabled";
 		};
 
+		ssusb: usb@11201000 {
+			compatible ="mediatek,mt8183-mtu3", "mediatek,mtu3";
+			reg = <0 0x11201000 0 0x2e00>,
+			      <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
+			phys = <&u2port0 PHY_TYPE_USB2>,
+			       <&u3port0 PHY_TYPE_USB3>;
+			clocks = <&infracfg CLK_INFRA_UNIPRO_SCK>,
+				 <&infracfg CLK_INFRA_USB>;
+			clock-names = "sys_ck", "ref_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			usb_host: xhci@11200000 {
+				compatible = "mediatek,mt8183-xhci",
+					     "mediatek,mtk-xhci";
+				reg = <0 0x11200000 0 0x1000>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
+				clocks = <&infracfg CLK_INFRA_UNIPRO_SCK>,
+					 <&infracfg CLK_INFRA_USB>;
+				clock-names = "sys_ck", "ref_ck";
+				status = "disabled";
+			};
+		};
+
 		audiosys: syscon@11220000 {
 			compatible = "mediatek,mt8183-audiosys", "syscon";
 			reg = <0 0x11220000 0 0x1000>;
@@ -684,6 +715,32 @@ efuse: efuse@11f10000 {
 			reg = <0 0x11f10000 0 0x1000>;
 		};
 
+		u3phy: usb-phy@11f40000 {
+			compatible = "mediatek,mt8183-tphy",
+				     "mediatek,generic-tphy-v2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x11f40000 0x1000>;
+			status = "okay";
+
+			u2port0: usb-phy@0 {
+				reg = <0x0 0x700>;
+				clocks = <&clk26m>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+				mediatek,discth = <15>;
+				status = "okay";
+			};
+
+			u3port0: usb-phy@0700 {
+				reg = <0x0700 0x900>;
+				clocks = <&clk26m>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+				status = "okay";
+			};
+		};
+
 		mfgcfg: syscon@13000000 {
 			compatible = "mediatek,mt8183-mfgcfg", "syscon";
 			reg = <0 0x13000000 0 0x1000>;
-- 
2.27.0

