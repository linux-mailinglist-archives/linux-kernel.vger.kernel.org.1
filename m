Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BC22F94B0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 19:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbhAQShn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 13:37:43 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:52319 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbhAQShi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 13:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610908658; x=1642444658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5zEtVXUtLNSl7Itit1n2Vbnz8QdINdtV9kRZRL9aMTo=;
  b=yIHT/5nyGb2/XfHyYpu2kUN5ahXHPNuJ27kJEJj0oRnp5vbegX+ptBSV
   3gYcqGIrtYsZO+PXAHUGReMumRD9uN1oEm8U86ODGdMnIxuhL4Ef5uotl
   41S5/DX/x1IfKuY9KB8OxQXp9Jpy/ktK9pU3YUYweycJWNa6m8FGhrf4y
   MVOPLsD1KgfUHWPgOqLFTYsr122hawoIH3lGOhT8ETDoxkaVfm63koOps
   VmmlJXF8VINKOoo86W5ujH9+96uDyULngzZk1C1kQK9VShwG39CcA4e2S
   +mFtW3I/tITz0yWKyofGE6i7I2eF9rpcNMOdaBroYhxdNphRXKm2bkO4t
   w==;
IronPort-SDR: yWjOMqHUnzQemjZ4spKMTavd5xNjDCVMKqSHjMv7rjrfxiwD93wOFzCnA2DPfgXGshMegp2tTX
 Cbq6tsUfXAmhM3ptiN1SYI/gyDYViLB5NCRwaX4/L1d6V9IZ2/QXIPvijaTr1BwiXrOzSgKvra
 m4a/ksSfaoPmZg/UZITnuktinFwp86ENNSJr/BOOfOW/aJQ40xr9h5JtZ8PR3TJMyYta0NtbXI
 ZrUWUhjsORtBoGawCa026ECWEddLw5qxH1H33pPJ3uPWEfSVTUT/O1temMHcNKrNk24c/oieFm
 Dzg=
X-IronPort-AV: E=Sophos;i="5.79,354,1602572400"; 
   d="scan'208";a="40702894"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2021 11:36:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 17 Jan 2021 11:36:18 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 17 Jan 2021 11:36:15 -0700
From:   <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ARM: dts: at91-sama5d27_wlsom1: add i2c recovery
Date:   Sun, 17 Jan 2021 19:35:58 +0100
Message-ID: <20210117183558.5369-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add the i2c gpio pinctrls to support the i2c bus recovery on this board.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 22 +++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
index a06700e53e4c..025a78310e3a 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
@@ -43,14 +43,20 @@ uart6: serial@200 {
 
 &i2c0 {
 	pinctrl-0 = <&pinctrl_i2c0_default>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	pinctrl-names = "default", "gpio";
+	sda-gpios = <&pioA PIN_PD21 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&pioA PIN_PD22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 };
 
 &i2c1 {
 	dmas = <0>, <0>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	sda-gpios = <&pioA PIN_PD19 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&pioA PIN_PD20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	mcp16502@5b {
@@ -258,12 +264,24 @@ pinctrl_i2c0_default: i2c0_default {
 		bias-disable;
 	};
 
+	pinctrl_i2c0_gpio: i2c0_gpio {
+		pinmux = <PIN_PD21__GPIO>,
+			 <PIN_PD22__GPIO>;
+		bias-disable;
+	};
+
 	pinctrl_i2c1_default: i2c1_default {
 		pinmux = <PIN_PD19__TWD1>,
 			 <PIN_PD20__TWCK1>;
 		bias-disable;
 	};
 
+	pinctrl_i2c1_gpio: i2c1_gpio {
+		pinmux = <PIN_PD19__GPIO>,
+			 <PIN_PD20__GPIO>;
+		bias-disable;
+	};
+
 	pinctrl_macb0_default: macb0_default {
 		pinmux = <PIN_PB14__GTXCK>,
 			 <PIN_PB15__GTXEN>,
-- 
2.30.0

