Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C33F2ACFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbgKJGll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:41:41 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:43760 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731423AbgKJGll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:41:41 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07599229|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.458737-0.00102727-0.540235;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.Iuo7NOU_1604990492;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.Iuo7NOU_1604990492)
          by smtp.aliyun-inc.com(10.147.41.199);
          Tue, 10 Nov 2020 14:41:36 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [RESEND PATCH 14/19] arm64: dts: allwinner: a100: add usb related nodes
Date:   Tue, 10 Nov 2020 14:41:31 +0800
Message-Id: <10e2377a9d20977b17b99584ee25960cbb5fbe74.1604988979.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604988979.git.frank@allwinnertech.com>
References: <cover.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Allwinner A64 have two HCI USB controllers, a OTG controller and a USB
PHY device, let's add nodes on dts.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index 6aa3337ce0e9..c731bb9727c2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -290,6 +290,97 @@ ths: thermal-sensor@5070400 {
 			#thermal-sensor-cells = <1>;
 		};
 
+		usbphy: phy@5100400 {
+			#phy-cells = <1>;
+			compatible = "allwinner,sun50i-a100-usb-phy";
+			reg = <0x05100400 0x14>,
+			      <0x05101800 0x4>,
+			      <0x05200800 0x4>;
+			reg-names = "phy_ctrl",
+				    "pmu0",
+				    "pmu1";
+			clocks = <&ccu CLK_USB_PHY0>,
+				 <&ccu CLK_USB_PHY1>;
+			clock-names = "usb0_phy",
+				      "usb1_phy";
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>;
+			reset-names = "usb0_reset",
+				      "usb1_reset";
+			status = "disabled";
+		};
+
+		ehci0: usb@5101000 {
+			compatible = "allwinner,sun50i-a100-ehci",
+				     "generic-ehci";
+			reg = <0x05101000 0x100>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_BUS_EHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>,
+				 <&ccu RST_BUS_EHCI0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb@5101400 {
+			compatible = "allwinner,sun50i-a100-ohci",
+				     "generic-ohci";
+			reg = <0x05101400 0x100>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		usb_otg: usb@5100000 {
+			compatible = "allwinner,sun50i-a100-musb",
+				     "allwinner,sun8i-h3-musb";
+			reg = <0x05100000 0x0400>;
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			extcon = <&usbphy 0>;
+			dr_mode = "otg";
+			status = "disabled";
+		};
+
+		ehci1: usb@5200000 {
+			compatible = "allwinner,sun50i-a100-ehci",
+				     "generic-ehci";
+			reg = <0x05200000 0x100>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_BUS_EHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>,
+				 <&ccu RST_BUS_EHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci1: usb@5200400 {
+			compatible = "allwinner,sun50i-a100-ohci",
+				     "generic-ohci";
+			reg = <0x05200400 0x100>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		r_ccu: clock@7010000 {
 			compatible = "allwinner,sun50i-a100-r-ccu";
 			reg = <0x07010000 0x300>;
-- 
2.28.0

