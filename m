Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D122FD2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390358AbhATObD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388785AbhATOYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:24:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5FCC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 06:23:07 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l2ENH-0001dD-CW; Wed, 20 Jan 2021 15:22:19 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l2ENG-0007jj-6n; Wed, 20 Jan 2021 15:22:18 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v1 3/7] ARM: dts: imx6dl-prtvt7: Add display and panel nodes
Date:   Wed, 20 Jan 2021 15:22:13 +0100
Message-Id: <20210120142217.29652-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210120142217.29652-1-o.rempel@pengutronix.de>
References: <20210120142217.29652-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Innolux G070Y2-T02 panel to the Protonic VT7 board.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-prtvt7.dts | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/imx6dl-prtvt7.dts
index ae6da241f13e..d9cb1e41cc10 100644
--- a/arch/arm/boot/dts/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
@@ -31,6 +31,30 @@ backlight_lcd: backlight-lcd {
 		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
 	};
 
+	display {
+		compatible = "fsl,imx-parallel-display";
+		pinctrl-0 = <&pinctrl_ipu1_disp>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			display_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			display_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+
 	keys {
 		compatible = "gpio-keys";
 		autorepeat;
@@ -138,6 +162,18 @@ led-debug0 {
 		};
 	};
 
+	panel {
+		compatible = "innolux,g070y2-t02";
+		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
+
 	reg_bl_12v0: regulator-bl-12v0 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -149,6 +185,13 @@ reg_bl_12v0: regulator-bl-12v0 {
 		enable-active-high;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_1v8: regulator-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "1v8";
@@ -260,6 +303,10 @@ &ipu1 {
 	status = "okay";
 };
 
+&ipu1_di0_disp0 {
+	remote-endpoint = <&display_in>;
+};
+
 &pwm1 {
 	#pwm-cells = <2>;
 	pinctrl-names = "default";
-- 
2.30.0

