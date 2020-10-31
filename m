Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CAA2A1AA0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 22:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgJaVIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 17:08:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:41503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgJaVIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 17:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604178466;
        bh=6kIwOvToBk/SLvIqFjb96pL4reUdhiumzjH84jgLgr0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=QEnFX0D6BDpVzs0PNGJA2ZuQfLza0tI0bibufvzMYQxbv9udHf1HdHB6NORsos934
         ex04fum7oxVIkoD3vCx/NGvBGC9oIvBpe+InqKoDvDIFbd0liMkMwOgUKdGcTC+5w4
         gfimk+p0rrA01RDSP7a2nP7YXSEjVaMIqBV1P8N8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3se8-1kPzv80dY8-00zlZC; Sat, 31
 Oct 2020 22:07:46 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx50-kobo-aura: Add 'grp' suffix to pinctrl node names
Date:   Sat, 31 Oct 2020 22:07:29 +0100
Message-Id: <20201031210729.2804471-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qO6POicQelRNDbFBvXUHQ+jpyNIJLKhios/IbWEzRqdd1vGPHx3
 yPqobUMNsUdYfOc8/XdXBzaG/GXQsW0iXPE9CUIALlfotZiIaIJrXU+fulcbwySt0U0s2m1
 Rf1quwH7FFgmeDSk+6EC2vw9jCq+eLiBWJ9udMskSt/hZ867bXXhuM/IWhP/ldqZUQAK23S
 Ed7gVsrX8IjFGRSa0AdEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L5ZVkTJLT6k=:2aBHolru70jfXyzewr7sYm
 oZtVHu4r3Um+mcRz6cPvrmLKcwEOY/CilayXsqhCluRgC4kO0xq3gnMf8IF8vITMpn+agDosR
 YZaDRv6T7yBhgKAanxm4521AjcrE1zmKxAIFKQ7sfNHg/evEQ54Cb1FGS5aqxPcSYW168Pnyw
 3G+moK9hvG2e3VMN0f30vO+QMinOdeSegMy8wilS8oUPkjkVLukVC97txi+IIQ4KsAoHpDs3h
 NzDkoJj8pLgR3Szws4u1vtl91ppvakfpA6Hdcv5MAJq66r9cWgIsZ/utmeAqPmnjveQyuO0/s
 akeGBn8X9EqriZGvbzGRBx9KeRkERYHVKFXTwnFqhEp6AZkHXXA0aCvqfG1Sw7F1BQou47iD+
 iAWUOGOhW4bM2oNgQSG5zkTiPjc1iaGJG78LDp1K8AyDx8fqhGZXwZrGADzDrykERaRewGMzt
 iDqhHcNsgk6dmfZKE9MYImPhhB8GhCfGBtLFim6FvEGGeRZJjR1Iv3kf01XAHxnI7eXAdP0zE
 2bYOYc80JrLVVyXGyEazNu2J0LyekV5QfIvx8k/VA5wAkz7OR2+hDF1LQsVEAoevRNORfImKZ
 AWPAGYwm30AsCCcpEYcmJhXvsIiLZ8PJV+B5VaHKqRhuEPBlZf3dHkj9x4uBgchyV4Fe4xWP+
 4hinwWEvPA9GU7tbbKDBwLPisu04eQfYSb0S2Ns7xU52j9jtw8o+1gU11H2KL5OFzauwCNy3p
 YQNDef7U0bDkmDhvrjFhCx871i0t56cdW5WkhJ0niBR6hOt9DgVS0kNkGSkTCv9VsihlqsTVZ
 BPiaIa6HX6rXNSBhHcv+twMxWsGL540izC1veB4gA+PKgru/EQianGyFcKDunubH8BKsdBobe
 0W8OlVzrYwT01Xu6wFhg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX pinctrl group nodes should have names that ends with 'grp'.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/boot/dts/imx50-kobo-aura.dts | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx50-kobo-aura.dts b/arch/arm/boot/dts/imx=
50-kobo-aura.dts
index a0eaf869b9135..53b3995d37e7f 100644
=2D-- a/arch/arm/boot/dts/imx50-kobo-aura.dts
+++ b/arch/arm/boot/dts/imx50-kobo-aura.dts
@@ -139,7 +139,7 @@ &i2c3 {
 };

 &iomuxc {
-	pinctrl_gpiokeys: gpiokeys {
+	pinctrl_gpiokeys: gpiokeysgrp {
 		fsl,pins =3D <
 			MX50_PAD_CSPI_MISO__GPIO4_10		0x0
 			MX50_PAD_SD2_D7__GPIO5_15		0x0
@@ -147,34 +147,34 @@ MX50_PAD_KEY_ROW0__GPIO4_1		0x0
 		>;
 	};

-	pinctrl_i2c1: i2c1 {
+	pinctrl_i2c1: i2c1grp {
 		fsl,pins =3D <
 			MX50_PAD_I2C1_SCL__I2C1_SCL		0x400001fd
 			MX50_PAD_I2C1_SDA__I2C1_SDA		0x400001fd
 		>;
 	};

-	pinctrl_i2c2: i2c2 {
+	pinctrl_i2c2: i2c2grp {
 		fsl,pins =3D <
 			MX50_PAD_I2C2_SCL__I2C2_SCL		0x400001fd
 			MX50_PAD_I2C2_SDA__I2C2_SDA		0x400001fd
 		>;
 	};

-	pinctrl_i2c3: i2c3 {
+	pinctrl_i2c3: i2c3grp {
 		fsl,pins =3D <
 			MX50_PAD_I2C3_SCL__I2C3_SCL		0x400001fd
 			MX50_PAD_I2C3_SDA__I2C3_SDA		0x400001fd
 		>;
 	};

-	pinctrl_leds: leds {
+	pinctrl_leds: ledsgrp {
 		fsl,pins =3D <
 			MX50_PAD_PWM1__GPIO6_24			0x0
 		>;
 	};

-	pinctrl_sd1: sd1 {
+	pinctrl_sd1: sd1grp {
 		fsl,pins =3D <
 			MX50_PAD_SD1_CMD__ESDHC1_CMD		0x1e4
 			MX50_PAD_SD1_CLK__ESDHC1_CLK		0xd4
@@ -187,7 +187,7 @@ MX50_PAD_SD2_CD__GPIO5_17		0x0
 		>;
 	};

-	pinctrl_sd2: sd2 {
+	pinctrl_sd2: sd2grp {
 		fsl,pins =3D <
 			MX50_PAD_SD2_CMD__ESDHC2_CMD		0x1e4
 			MX50_PAD_SD2_CLK__ESDHC2_CLK		0xd4
@@ -198,19 +198,19 @@ MX50_PAD_SD2_D3__ESDHC2_DAT3		0x1d4
 		>;
 	};

-	pinctrl_sd2_reset: sd2-reset {
+	pinctrl_sd2_reset: sd2-resetgrp {
 		fsl,pins =3D <
 			MX50_PAD_ECSPI2_MOSI__GPIO4_17		0x0
 		>;
 	};

-	pinctrl_sd2_vmmc: sd2-vmmc {
+	pinctrl_sd2_vmmc: sd2-vmmcgrp {
 		fsl,pins =3D <
 			MX50_PAD_ECSPI1_SCLK__GPIO4_12		0x0
 		>;
 	};

-	pinctrl_sd3: sd3 {
+	pinctrl_sd3: sd3grp {
 		fsl,pins =3D <
 			MX50_PAD_SD3_CMD__ESDHC3_CMD		0x1e4
 			MX50_PAD_SD3_CLK__ESDHC3_CLK		0xd4
@@ -225,14 +225,14 @@ MX50_PAD_SD3_D7__ESDHC3_DAT7		0x1d4
 		>;
 	};

-	pinctrl_uart2: uart2 {
+	pinctrl_uart2: uart2grp {
 		fsl,pins =3D <
 			MX50_PAD_UART2_TXD__UART2_TXD_MUX	0x1e4
 			MX50_PAD_UART2_RXD__UART2_RXD_MUX	0x1e4
 		>;
 	};

-	pinctrl_usbphy: usbphy {
+	pinctrl_usbphy: usbphygrp {
 		fsl,pins =3D <
 			MX50_PAD_ECSPI2_SS0__GPIO4_19		0x0
 		>;
=2D-
2.28.0

