Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763292ACFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgKJGnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:43:41 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:56802 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgKJGnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:43:41 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1107549|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.343704-0.0050523-0.651244;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.IuodFRh_1604990611;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IuodFRh_1604990611)
          by smtp.aliyun-inc.com(10.147.41.187);
          Tue, 10 Nov 2020 14:43:35 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tiny.windzz@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [RESEND PATCH 15/19] arm64: allwinner: A100: enable EHCI, OHCI and USB PHY nodes in Perf1
Date:   Tue, 10 Nov 2020 14:43:28 +0800
Message-Id: <86d2814f666b748defa0460dea118a5eeaeecf01.1604988979.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604988979.git.frank@allwinnertech.com>
References: <cover.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add USB support on A100 perf1 board, which include two USB2.0 port.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 .../allwinner/sun50i-a100-allwinner-perf1.dts | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
index d34c2bb1079f..ef205c9b8ff4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
@@ -7,6 +7,8 @@
 
 #include "sun50i-a100.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 /{
 	model = "Allwinner A100 Perf1";
 	compatible = "allwinner,a100-perf1", "allwinner,sun50i-a100";
@@ -18,6 +20,35 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	reg_usb1_vbus: usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
+		enable-active-high;
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
 };
 
 &pio {
@@ -178,3 +209,10 @@ &uart0 {
 	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+	usb0_vbus-supply = <&reg_drivevbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.28.0

