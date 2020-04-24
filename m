Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524961B7C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgDXRKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 13:10:24 -0400
Received: from lists.gateworks.com ([108.161.130.12]:45290 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXRKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:10:24 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jS1sO-0007Ma-0R; Fri, 24 Apr 2020 17:12:32 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] ARM: dts: gw552x: add USB OTG support
Date:   Fri, 24 Apr 2020 10:10:15 -0700
Message-Id: <1587748215-9587-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GW552x-B board revision adds USB OTG support.

Enable the device-tree node and configure the OTG_ID pin.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index dc646b7..133a1e3 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -12,8 +12,6 @@
 		led1 = &led1;
 		led2 = &led2;
 		nand = &gpmi;
-		usb0 = &usbh1;
-		usb1 = &usbotg;
 	};
 
 	chosen {
@@ -258,6 +256,14 @@
 	status = "okay";
 };
 
+&usbotg {
+	vbus-supply = <&reg_5p0v>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "okay";
+};
+
 &wdog1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog>;
@@ -359,6 +365,12 @@
 		>;
 	};
 
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x13059
+		>;
+	};
+
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
-- 
2.7.4

