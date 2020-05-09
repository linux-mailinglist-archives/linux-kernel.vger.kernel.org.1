Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F311CC0D6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 13:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgEILTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 07:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbgEILTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:19:18 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 May 2020 04:19:18 PDT
Received: from pruto.48.io (48.io [IPv6:2a01:430:17:1::ffff:361])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66977C061A0C;
        Sat,  9 May 2020 04:19:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pruto.48.io (Postfix) with ESMTPSA id AA1599167A;
        Sat,  9 May 2020 13:19:16 +0200 (CEST)
DMARC-Filter: OpenDMARC Filter v1.3.2 pruto.48.io AA1599167A
Authentication-Results: pruto.48.io; dmarc=none (p=none dis=none) header.from=48.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=48.io; s=default;
        t=1589023156; bh=PD4G1VYzdYofQB3xLNm3Mdoe2zymwjMy9UKjQHmAphY=;
        h=From:To:Cc:Subject:Date;
        b=xCPj/SzfAgpQ7IypVAykco6zMAZCdBHNDnx0EZZVwCVNE0rD7DTCIvdg2WMCzlguZ
         /YJsGK5UjY2YgVkdKKqaETxN6QUVMqT4fEpqzLSJOnTvAv665NvGtTNnhO8iBfj9yn
         DyWBwnzwYYaMrYGmC84w+ADoSyoR0D7a0sNUK4r8=
From:   srk@48.io
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Richard Marko <srk@48.io>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 1/1] ARM: dts: novena: Add LVDS-to-eDP bridge bindings
Date:   Sat,  9 May 2020 13:19:07 +0200
Message-Id: <20200509111907.26685-1-srk@48.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marex@denx.de>

Add bindings for the LVDS-to-eDP bridge chip, IT6251, which is
used to connect the standard 1920x1080 panel on Novena laptop.

Tested on a Kosagi Novena laptop with imx6 display controller.

Based on v5.7-rc2, applies to drm-misc-next 5e6ed29d72d2

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Richard Marko <srk@48.io>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx6q-novena.dts | 57 +++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index 69f170ff31c5..803a97e04dc4 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -109,6 +109,12 @@ heartbeat {
 	panel: panel {
 		compatible = "innolux,n133hse-ea1";
 		backlight = <&backlight>;
+
+		port {
+			panel_in_edp0: endpoint {
+				remote-endpoint = <&bridge_out_edp0>;
+			};
+		};
 	};
 
 	reg_2p5v: regulator-2p5v {
@@ -146,6 +152,7 @@ reg_display: regulator-display {
 		startup-delay-us = <200000>;
 		gpio = <&gpio5 28 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		regulator-always-on;
 	};
 
 	reg_lvds_lcd: regulator-lvds-lcd {
@@ -155,6 +162,7 @@ reg_lvds_lcd: regulator-lvds-lcd {
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		regulator-always-on;
 	};
 
 	reg_pcie: regulator-pcie {
@@ -212,6 +220,17 @@ &audmux {
 	status = "okay";
 };
 
+&clks {
+	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
+			  <&clks IMX6QDL_CLK_IPU1_DI0_PRE_SEL>,
+			  <&clks IMX6QDL_CLK_IPU2_DI0_PRE_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
+				 <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
+				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
+				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>;
+};
+
 &ecspi3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3_novena>;
@@ -423,6 +442,29 @@ codec: es8328@11 {
 					 <&clks IMX6QDL_CLK_CKO1_PODF>;
 		assigned-clock-rates = <0 0 722534400 22579200>;
 	};
+
+	it6251@5c {
+		compatible = "ite,it6251";
+		reg = <0x5c>, <0x5e>;
+		reg-names = "bridge", "lvds";
+		power-supply = <&reg_display>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lvdsbridge_novena>;
+
+		ports {
+			port@0 {
+				bridge_out_edp0: endpoint {
+					remote-endpoint = <&panel_in_edp0>;
+				};
+			};
+
+			port@1 {
+				bridge_in_lvds0: endpoint {
+					remote-endpoint = <&lvds0_out>;
+				};
+			};
+		};
+	};
 };
 
 &kpp {
@@ -443,6 +485,14 @@ lvds-channel@0 {
 		fsl,data-width = <24>;
 		fsl,panel = <&panel>;
 		status = "okay";
+
+		port@4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&bridge_in_lvds0>;
+			};
+		};
 	};
 };
 
@@ -529,10 +579,15 @@ MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		0x130b0
 		>;
 	};
 
+	pinctrl_lvdsbridge_novena: lvdsbridgegrp-novena {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT10__GPIO5_IO28	0x1b0b1
+		>;
+	};
+
 	pinctrl_backlight_novena: backlightgrp-novena {
 		fsl,pins = <
 			MX6QDL_PAD_DISP0_DAT8__PWM1_OUT		0x1b0b0
-			MX6QDL_PAD_CSI0_DAT10__GPIO5_IO28	0x1b0b1
 			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b1
 		>;
 	};
-- 
2.25.1

