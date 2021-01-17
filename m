Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932E62F965C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 00:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbhAQXqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 18:46:52 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57983 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730826AbhAQXpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 18:45:09 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8ECBF5C012E;
        Sun, 17 Jan 2021 18:43:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 17 Jan 2021 18:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=7CZQ3Ynd/Nxtd
        ggtzJL3Hu3UvMx+xdFKbu8d3vDBITo=; b=ekuIq/Yt0j3Dbom/OQoNBDm/uYetY
        H7MF6T7Ok8z8p9l45bgxYfA7D5/tzlgHDhlUhKN35Isl9z5EpRvVmTQ4Tyu8EB1H
        6Cc9sWM9c8TjEyTq8Fu03JkFbHxKIfpazCGMlXDP90nUHSHknPd8plMiiyufDFd8
        EJqouGpEbQtUaBXEXhA0Ncaqv3NeUDWuHqQU7uKpYe3ttzxcSYccqaxTP7EsWo4B
        x2972SCN6xLqr/qtwbqOe8lS1UpK27xmAnoz0iNMeuEoTMerN8Xuq4wlKWZN/Rc8
        h/To0LfveQULOYIAVjjY495trCvgBMCfiGxEDUmunT5bYR9A0gey+CPEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=7CZQ3Ynd/NxtdggtzJL3Hu3UvMx+xdFKbu8d3vDBITo=; b=eAAL11lY
        Leghmzotywkt8j/CMQGuNAOi+8f//fLo83x9oW4KhN/0II2NKjunAwrTrquPRanE
        p42bFXDRMjcPRRG/pN6NrxV8LeYGw24EQGtQVyW+b1kESwtDHrU6XwYPU77Hru3e
        +wNOkkYgu7jzyMfAkpWTTWkA5eT9klRjlOjTVHcnzQxtQ1+yCfL5M9fkQAQ15viF
        aTOXHmQ603jl9iAvYDKbtuunFDfHjew1WBpipUdRY+TITV7jdfcPPKq1X+Ff5R2C
        tKY0YCZo3myhEW5vklpSmRIxXfOzDRyjHjgakFqTNwJTgvlwJwDGQqygS/j7bbtQ
        079nUoQRDFuOkg==
X-ME-Sender: <xms:rcsEYAD7FOD4gu9yVLS4815CXXDv2Ns3ZwRBWXuZW1Wfr1bIZyF9wg>
    <xme:rcsEYCj7Zu6ZvOUP2bVEnq1E3xW86gGwPaAOMrGzRA_sREQLueWm8G6aGam8Puxh9
    ULuz5-zL3qK3EQKY8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecukfhppeejfedrleef
    rdekgedrvddtkeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:rcsEYDk4vzc5PrbnsYJLA77yYtJN8EvtqkRcIhOMZLSWqa0yoEAmEA>
    <xmx:rcsEYGySXRBstmNa9AMXAD2d5TXGEWMkKRhBXkDo1THQ7_dwkKtEog>
    <xmx:rcsEYFQkOOkKRUi8Mao9IVAqEH8LDkPYNlGkoT7kHu89c9iiC-j-dw>
    <xmx:rcsEYEEgt3ZdjD1aZxciSbkIkYmT46p1U8SJ08eB6jR3OfRIA_XwpA>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 75DDE240057;
        Sun, 17 Jan 2021 18:43:40 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 6/6] arch/arm: reMarkable2: Enable lcdif
Date:   Sat, 16 Jan 2021 20:25:39 -0800
Message-Id: <20210117042539.1609-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210117042539.1609-1-alistair@alistair23.me>
References: <20210117042539.1609-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Connect the dispaly on the reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 70 +++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index f419ab704f06..d4e93f7ca7ea 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -221,6 +221,42 @@ reg_epdpmic: vcom {
 	};
 };
 
+&lcdif {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lcdif>;
+	pinctrl-1 = <&pinctrl_lcdif>;
+	lcd-supply = <&reg_epdpmic>;
+	lcd2-supply = <&reg_sdoe>;
+	display = <&display0>;
+	prevent-frying-pan;
+	status = "okay";
+
+	display0: display {
+		bits-per-pixel = <24>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+
+			timing0: timing0 {
+				clock-frequency = <40000000>;
+				hactive = <334>;
+				vactive = <1405>;
+				hfront-porch = <1>;
+				hback-porch = <1>;
+				hsync-len = <1>;
+				vback-porch = <1>;
+				vfront-porch = <1>;
+				vsync-len = <1>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+		};
+	};
+};
+
 &sdma {
 	status = "okay";
 };
@@ -331,6 +367,40 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
+			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
+			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
+			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
+			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
+			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
+			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
+			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
+			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
+			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
+			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
+			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
+			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
+			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
+			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
+			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
+
+			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
+			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
+			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
+			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
+
+			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
+			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
+			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
+			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+			MX7D_PAD_LCD_RESET__LCD_RESET		0x79
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.29.2

