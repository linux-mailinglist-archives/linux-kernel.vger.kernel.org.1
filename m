Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECF11E6BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 21:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406803AbgE1TxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 15:53:18 -0400
Received: from lists.gateworks.com ([108.161.130.12]:57836 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406687AbgE1TxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:53:15 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jeOdH-0000tP-Cd; Thu, 28 May 2020 19:56:03 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] ARM: dts: imx6qdl-gw53xx: allow boot firmware to set eth1 MAC
Date:   Thu, 28 May 2020 12:53:03 -0700
Message-Id: <1590695583-1327-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GW53xx has a PCIe based GbE as the 2nd ethernet device. The
boot firmware will populate the local-mac-address field of the
device aliased to ethernet1 thus adding the PCIe device to
dt allows boot firmware to set its MAC address.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 8942bec..6601d07 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -8,6 +8,7 @@
 / {
 	/* these are used by bootloader for disabling nodes */
 	aliases {
+		ethernet1 = &eth1;
 		led0 = &led0;
 		led1 = &led1;
 		led2 = &led2;
@@ -341,6 +342,23 @@
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
+
+	pcie@0,0,0 {
+		reg = <0x0000 0 0 0 0>;
+
+		pcie@1,0,0 {
+			reg = <0x0000 0 0 0 0>;
+
+			pcie@2,4,0 {
+				reg = <0x2000 0 0 0 0>;
+
+				eth1: pcie@4,0,0 {
+					reg = <0x0000 0 0 0 0>;
+					local-mac-address = [00 00 00 00 00 00];
+				};
+			};
+		};
+	};
 };
 
 &pwm2 {
-- 
2.7.4

