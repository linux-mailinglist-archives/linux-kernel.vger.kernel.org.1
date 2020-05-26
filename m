Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4B81D017C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 00:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbgELWDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 18:03:02 -0400
Received: from lists.gateworks.com ([108.161.130.12]:51401 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgELWDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:03:02 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jYd1W-0007G4-Ax; Tue, 12 May 2020 22:05:14 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] ARM: dts: imx6qdl-gw5910: fix wlan regulator
Date:   Tue, 12 May 2020 15:02:34 -0700
Message-Id: <1589320954-25219-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Connect the wl_reg regulator to usdhc2 such that it can be enabled
and disabled as needed. There is no need for this to be always-on.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
index b850f8f..0857de5 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
@@ -81,7 +81,6 @@
 		enable-active-high;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
 	};
 };
 
@@ -251,7 +250,7 @@
 &usdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2>;
-	vmmc-supply = <&reg_3p3v>;
+	vmmc-supply = <&reg_wl>;
 	non-removable;
 	bus-width = <4>;
 	status = "okay";
-- 
2.7.4

