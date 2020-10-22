Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6079295D75
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897356AbgJVLgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444347AbgJVLgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:36:10 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E71C0613CE;
        Thu, 22 Oct 2020 04:36:10 -0700 (PDT)
From:   Alexis Ballier <aballier@gentoo.org>
Cc:     Alexis Ballier <aballier@gentoo.org>, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rk3399-orangepi: Properly define the type C connector.
Date:   Thu, 22 Oct 2020 13:35:32 +0200
Message-Id: <20201022113532.18470-1-aballier@gentoo.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested:
- USB3 Gigabit adapter
- USB2 mass storage

The wiring is the same as the pinebook pro according to the schematics,
thus this patch is heavily based on its dts.

Signed-off-by: Alexis Ballier <aballier@gentoo.org>
Cc: devicetree@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

---

Any hint on how to get rid of this error:
OF: graph: no port node found in /i2c@ff3d0000/fusb302@22
would be appreciated.
---
 .../boot/dts/rockchip/rk3399-orangepi.dts     | 62 ++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index 6163ae8063a7..ad7c4d00888f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -7,6 +7,7 @@
 
 #include "dt-bindings/pwm/pwm.h"
 #include "dt-bindings/input/input.h"
+#include "dt-bindings/usb/pd.h"
 #include "rk3399.dtsi"
 #include "rk3399-opp.dtsi"
 
@@ -531,6 +532,43 @@ fusb302@22 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&chg_cc_int_l>;
 		vbus-supply = <&vbus_typec>;
+
+		typec_con: connector {
+			compatible = "usb-c-connector";
+			data-role = "host";
+			label = "USB-C";
+			op-sink-microwatt = <1000000>;
+			power-role = "dual";
+			sink-pdos =
+				<PDO_FIXED(5000, 2500, PDO_FIXED_USB_COMM)>;
+			source-pdos =
+				<PDO_FIXED(5000, 1400, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					typec_hs: endpoint {
+						remote-endpoint = <&u2phy0_typec_hs>;
+					};
+				};
+				port@1 {
+					reg = <1>;
+					typec_ss: endpoint {
+						remote-endpoint = <&tcphy0_typec_ss>;
+					};
+				};
+				port@2 {
+					reg = <2>;
+					typec_dp: endpoint {
+						remote-endpoint = <&tcphy0_typec_dp>;
+					};
+				};
+			};
+		};
 	};
 };
 
@@ -717,6 +755,22 @@ &tcphy0 {
 	status = "okay";
 };
 
+&tcphy0_dp {
+	port {
+		tcphy0_typec_dp: endpoint {
+			remote-endpoint = <&typec_dp>;
+		};
+	};
+};
+
+&tcphy0_usb3 {
+	port {
+		tcphy0_typec_ss: endpoint {
+			remote-endpoint = <&typec_ss>;
+		};
+	};
+};
+
 &tcphy1 {
 	status = "okay";
 };
@@ -739,6 +793,12 @@ u2phy0_host: host-port {
 		phy-supply = <&vcc5v0_host>;
 		status = "okay";
 	};
+
+	port {
+		u2phy0_typec_hs: endpoint {
+			remote-endpoint = <&typec_hs>;
+		};
+	};
 };
 
 &u2phy1 {
@@ -799,7 +859,7 @@ &usbdrd3_0 {
 
 &usbdrd_dwc3_0 {
 	status = "okay";
-	dr_mode = "otg";
+	dr_mode = "host";
 };
 
 &usbdrd3_1 {
-- 
2.29.0

