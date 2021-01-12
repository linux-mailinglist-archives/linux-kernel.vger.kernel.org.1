Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1914A2F4029
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbhALXRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbhALXRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:17:04 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CAFC0617A3;
        Tue, 12 Jan 2021 15:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=scWPcaQPFYoop25JOTONGlOQdYVEvi//1NfKWBjr6uU=; b=OFXLk2tB0fOYU8BmkAkZ3fJj/P
        rWeSc6j7gp0pUt7Q/NurdyjQGkb+W/zzVmOUVv/aqh3PF0BsoOXqTHgEOmfDUIECv+zUbR7Yk+Hiw
        /7tqCCtHRGof+qTH3Vo5HntcakdkJczr8ALCCJVF8rfPqNO4eG8ipnQ+bA0MgHW/DA8Q=;
Received: from p200300ccff1586001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff15:8600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kzSte-0005Ts-O7; Wed, 13 Jan 2021 00:16:18 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1kzSte-0007oG-G9; Wed, 13 Jan 2021 00:16:18 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 4/4] ARM: dts: imx: e60k02: add second uart
Date:   Wed, 13 Jan 2021 00:15:49 +0100
Message-Id: <20210112231549.29957-6-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210112231549.29957-1-andreas@kemnade.info>
References: <20210112231549.29957-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is another uart next to the console uart used by vendor uboot and
kernel, enable it and document its location.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/e60k02.dtsi              |  6 ++++++
 arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 13 ++++++++++++-
 arch/arm/boot/dts/imx6sll-kobo-clarahd.dts | 13 ++++++++++++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
index 3af1ab4458ef..cfb239d5186a 100644
--- a/arch/arm/boot/dts/e60k02.dtsi
+++ b/arch/arm/boot/dts/e60k02.dtsi
@@ -278,6 +278,12 @@
 };
 
 &uart1 {
+	/* J4, through-hole */
+	status = "okay";
+};
+
+&uart4 {
+	/* TP198, next to J4, SMD pads */
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
index 62d2ebda04ff..e3f1e8d79528 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
@@ -94,7 +94,6 @@
 			MX6SL_PAD_KEY_ROW7__GPIO4_IO07		0x79
 			MX6SL_PAD_ECSPI2_MOSI__GPIO4_IO13	0x79
 			MX6SL_PAD_KEY_COL5__GPIO4_IO02		0x79
-			MX6SL_PAD_KEY_ROW6__GPIO4_IO05		0x79
 		>;
 	};
 
@@ -160,6 +159,13 @@
 		>;
 	};
 
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6SL_PAD_KEY_ROW6__UART4_TX_DATA 0x1b0b1
+			MX6SL_PAD_KEY_COL6__UART4_RX_DATA 0x1b0b1
+		>;
+	};
+
 	pinctrl_usbotg1: usbotg1grp {
 		fsl,pins = <
 			MX6SL_PAD_EPDC_PWRCOM__USB_OTG1_ID 0x17059
@@ -300,6 +306,11 @@
 	pinctrl-0 = <&pinctrl_uart1>;
 };
 
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+};
+
 &usdhc2 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc2>;
diff --git a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
index 7214d1c98249..90b32f5eb529 100644
--- a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
+++ b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
@@ -104,7 +104,6 @@
 			MX6SLL_PAD_KEY_ROW7__GPIO4_IO07		0x79
 			MX6SLL_PAD_ECSPI2_MOSI__GPIO4_IO13	0x79
 			MX6SLL_PAD_KEY_COL5__GPIO4_IO02		0x79
-			MX6SLL_PAD_KEY_ROW6__GPIO4_IO05		0x79
 		>;
 	};
 
@@ -170,6 +169,13 @@
 		>;
 	};
 
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6SLL_PAD_KEY_ROW6__UART4_DCE_TX 0x1b0b1
+			MX6SLL_PAD_KEY_COL6__UART4_DCE_RX 0x1b0b1
+		>;
+	};
+
 	pinctrl_usbotg1: usbotg1grp {
 		fsl,pins = <
 			MX6SLL_PAD_EPDC_PWR_COM__USB_OTG1_ID 0x17059
@@ -302,6 +308,11 @@
 	pinctrl-0 = <&pinctrl_uart1>;
 };
 
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+};
+
 &usdhc2 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz","sleep";
 	pinctrl-0 = <&pinctrl_usdhc2>;
-- 
2.20.1

