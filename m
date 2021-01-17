Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8C92F966D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 00:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbhAQXtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 18:49:09 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56809 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730805AbhAQXoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 18:44:46 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 652195C012A;
        Sun, 17 Jan 2021 18:43:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 17 Jan 2021 18:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=SLYKavH+p5IE7
        x0cqUgyM7oHmCtlpp1rjjA40keoC/w=; b=NiytnX/sPp3TQShyzRgrobONVwtTu
        0MEz+8o5opYMhvsbgBeRIO56buwuuVICkPS/dJO8t+whelmn3++D2t1JKxcINSdH
        B4Y/ZWD0d/wME+vURyYPcDjUlSpOygaQU6i/EwBbnjoYyC+Iqu9LTDgVxVyu5c/g
        HJWzKL5vKB/Vc1Ul9auY1JYjI0h9vaXdw6Mjd/yB3evkmdgEFXhKX9TPeic/ryWm
        XO+uN768mlSEyDsf8k8gXRi6b2BrotITsv1O9jVTviEIq/RoGd2+rIvW2MCdmDtO
        S4XMQzl+c1/yKN4R4/R9+jJ7qS1c6aMXNvhBU8V9jc2SZBwq09Yd6w/SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=SLYKavH+p5IE7x0cqUgyM7oHmCtlpp1rjjA40keoC/w=; b=c6EH0w05
        RSNV4Nu/vH3aj4mS3MkzsJOQzJiqfo3Ctr8sOjpok5qOEaqaiyr+fpNtoSJhe7a1
        7Q8u6yXjtPIE5KKSvlcEnyIkLsAaGRoNkAe8y/p1YBTw5hmAIRTZnioFJdthJhBP
        ih11IH4ElDWI6RFfVbtHd+nJo38xQ+ZmtoolkLVFY3dNU3d/b2gt2EwgvXQpDgqu
        i4Uxnpcbggp2T5mCb2/33kp6UZvr3WpcVRo2b61L62AWvRgzNjy0pA3i6qmU4dTk
        +o92GZ6G8MGjBI9NzWU4y/5X48ZxlT9QbdJOG1CjVSFTBMdlzx8htQu59u8qTkOR
        jwvjexo4bnWqCQ==
X-ME-Sender: <xms:rMsEYOPPmUGhQI2jkGEZQFjJHPCnX6e2IjnaFGyXvpbK8auRRHMjYg>
    <xme:rMsEYM-RfeZKjUJNisfmgLWSCugnXljXOzN8gfd6uZuHRYWQVooAnyHABvfmac9dg
    cvZQuH8oX00BhF0V0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecukfhppeejfedrleef
    rdekgedrvddtkeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:rMsEYFRnq9i42z5Zo9KPIjFhB680kx2dbpqTKm3A2W-3yas_N5kVXA>
    <xmx:rMsEYOviI56iwalEKB4X-7yByhfEIBjKxp1tDyZh4VLzG9O2lZ8Pnw>
    <xmx:rMsEYGeEDsphKLKoBg3Vn07wlQKDDV-6bOyYyuFLTiuU-Vx4aMxZbw>
    <xmx:rMsEYOTz9tkkaZCxw8n24ypJyX092CcRQBd_OrJHSiS8HtgMhawVsw>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4C321240057;
        Sun, 17 Jan 2021 18:43:39 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 5/6] arch/arm: reMarkable2: Enable silergy,sy7636a
Date:   Sat, 16 Jan 2021 20:25:38 -0800
Message-Id: <20210117042539.1609-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210117042539.1609-1-alistair@alistair23.me>
References: <20210117042539.1609-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 61 +++++++++++++++++++++++++
 arch/arm/configs/remarkable2_defconfig  |  2 +
 2 files changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 8052d884a5e5..f419ab704f06 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -58,6 +58,27 @@ memory {
 		reg = <0x80000000 0x40000000>;
 	};
 
+	thermal-zones {
+		epd-thermal {
+			thermal-sensors = <&epd_pmic>;
+			polling-delay-passive = <30000>;
+			polling-delay = <30000>;
+			trips {
+				trip0 {
+					temperature = <49000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	reg_vref_1v8: regulator-vref-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vref-1v8";
@@ -174,6 +195,32 @@ digitizer: wacom-i2c@9 {
 	};
 };
 
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	epd_pmic: sy7636a@62 {
+		compatible = "silergy,sy7636a";
+		reg = <0x62>;
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_epdpmic>;
+		#thermal-sensor-cells = <0>;
+
+		epd-pwr-good-gpios = <&gpio6 21 GPIO_ACTIVE_HIGH>;
+		regulators {
+			compatible = "silergy,sy7636a-regulator";
+			reg_epdpmic: vcom {
+				regulator-name = "vcom";
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
 &sdma {
 	status = "okay";
 };
@@ -277,6 +324,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SDA__I2C4_SDA		0x4000007f
+			MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
@@ -389,6 +443,13 @@ MX7D_PAD_SD1_WP__CCM_CLKO2		0x00000014
 		>;
 	};
 
+	pinctrl_epdpmic: epdpmicgrp {
+		fsl,pins = <
+			MX7D_PAD_SAI2_RX_DATA__GPIO6_IO21 0x00000074
+			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11 0x00000014
+		>;
+	};
+
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
 			MX7D_PAD_ENET1_COL__WDOG1_WDOG_ANY	0x74
diff --git a/arch/arm/configs/remarkable2_defconfig b/arch/arm/configs/remarkable2_defconfig
index 8c9785555cda..6306568772c3 100644
--- a/arch/arm/configs/remarkable2_defconfig
+++ b/arch/arm/configs/remarkable2_defconfig
@@ -193,6 +193,7 @@ CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_SI476X_CORE=y
 CONFIG_MFD_STMPE=y
+CONFIG_MFD_SY7636A=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
@@ -201,6 +202,7 @@ CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_REGULATOR_PFUZE100=y
+CONFIG_REGULATOR_SY7636A=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
-- 
2.29.2

