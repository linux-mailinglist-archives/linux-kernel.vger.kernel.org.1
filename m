Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C85304E86
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404559AbhA0Acw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:32:52 -0500
Received: from mail.strohwolke.at ([116.203.115.155]:55666 "EHLO
        mail.strohwolke.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393049AbhAZRog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:44:36 -0500
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jan 2021 12:44:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=strohwolke.at;
        s=mail; t=1611682606; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=9h7YhDjgDT8NilUyDfIEx2adGYOKZaRN/aD+KVYcVD4=;
        b=PevSaX/hcSyllldPT0RhS/EgNipfzkVRkK7SS7+1v3AtadoMX7/C8q19bFYTF+ENj1dxZU
        hFN3vRPo5pNsCEoXzKW5gIPl6jU/KbfzMFyeTPOL4NmqbR+diko+2XI7SrAfkHx93bKF71
        DE491oDl50ngBP5fTo4oS9E40xttEN4=
From:   Armin Preiml <apreiml@strohwolke.at>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Kemnade <andreas@kemnade.info>,
        Armin Preiml <apreiml@strohwolke.at>
Subject: [PATCH] dts: ARM: add kobo glo hd ebook reader
Date:   Tue, 26 Jan 2021 18:31:31 +0100
Message-Id: <20210126173130.45427-1-apreiml@strohwolke.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic support for the kobo glo hd reader. It defines CPU, 
memory, UART and storage.Also add pin control settings for i2c and sdhc. 

All values where extracted from the vendor kernel and u-boot sources.

Signed-off-by: Armin Preiml <apreiml@strohwolke.at>

---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/imx6sl-kobo-glo-hd.dts | 164 +++++++++++++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sl-kobo-glo-hd.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3d1ea0b25..ba608414e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -598,6 +598,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6qp-zii-rdu2.dtb
 dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb \
+	imx6sl-kobo-glo-hd.dtb \
 	imx6sl-tolino-shine2hd.dtb \
 	imx6sl-tolino-shine3.dtb \
 	imx6sl-warp.dtb
diff --git a/arch/arm/boot/dts/imx6sl-kobo-glo-hd.dts b/arch/arm/boot/dts/imx6sl-kobo-glo-hd.dts
new file mode 100644
index 000000000..759699e9e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sl-kobo-glo-hd.dts
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Device tree for the Kobo Glo HD ebook reader.
+ *
+ * Name on mainboard is: 37NB-E60Q90+4A1
+ * Board name in uboot sources: E60Q90  
+ *
+ * Copyright 2021 Armin Preiml
+ * based on works
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "imx6sl.dtsi"
+
+/ {
+	model = "Kobo Glo HD";
+	compatible = "kobo,glohd", "fsl,imx6sl";
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		power {
+			label = "Power";
+			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+};
+
+&iomuxc {
+        i2c1grp {
+                fsl,pins = <
+			MX6SL_PAD_I2C1_SCL__I2C1_SCL 0x1f8b1
+			MX6SL_PAD_I2C1_SDA__I2C1_SDA 0x1f8b1
+		>;
+	};
+
+	i2c2grp {
+                fsl,pins = <
+			MX6SL_PAD_I2C2_SCL__I2C2_SCL 0x1f8b1
+			MX6SL_PAD_I2C2_SDA__I2C2_SDA 0x1f8b1
+		>;
+	};
+
+        i2c3grp {
+                fsl,pins = <
+			MX6SL_PAD_REF_CLK_32K__I2C3_SDA 0x1f8b1
+			MX6SL_PAD_REF_CLK_24M__I2C3_SCL 0x1f8b1
+		>;
+	};
+
+        pinctrl_gpio_keys: gpio_keysgrp {
+                fsl,pins = <
+			MX6SL_PAD_SD1_DAT1__GPIO5_IO08 0x110b0
+		>;
+	};
+
+        pinctrl_uart1: uart1grp {
+                fsl,pins = <
+			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
+			MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp { /* 50MHZ (>50MHZ: 0x1f0f9) */
+                fsl,pins = <
+			MX6SL_PAD_SD1_CLK__SD1_CLK 0x1f071
+			MX6SL_PAD_SD1_CMD__SD1_CMD 0x1f071
+			MX6SL_PAD_SD1_DAT0__SD1_DATA0 0x1f071
+			MX6SL_PAD_SD1_DAT1__SD1_DATA1 0x1f071
+			MX6SL_PAD_SD1_DAT2__SD1_DATA2 0x1f071
+			MX6SL_PAD_SD1_DAT3__SD1_DATA3 0x1f071
+			MX6SL_PAD_SD1_DAT4__SD1_DATA4 0x1f071
+			MX6SL_PAD_SD1_DAT5__SD1_DATA5 0x1f071
+			MX6SL_PAD_SD1_DAT6__SD1_DATA6 0x1f071
+			MX6SL_PAD_SD1_DAT7__SD1_DATA7 0x1f071
+		>;
+	};
+
+        pinctrl_usdhc2: usdhc2grp { 
+                fsl,pins = <
+			MX6SL_PAD_SD2_CLK__SD2_CLK 0x1f071
+			MX6SL_PAD_SD2_CMD__SD2_CMD 0x1f071
+			MX6SL_PAD_SD2_DAT0__SD2_DATA0 0x1f071
+			MX6SL_PAD_SD2_DAT1__SD2_DATA1 0x1f071
+			MX6SL_PAD_SD2_DAT2__SD2_DATA2 0x1f071
+			MX6SL_PAD_SD2_DAT3__SD2_DATA3 0x1f071
+		>;
+	};
+
+        pinctrl_usdhc3: usdhc3grp {
+                fsl,pins = <
+			MX6SL_PAD_SD3_CLK__SD3_CLK 0x1f071
+			MX6SL_PAD_SD3_CMD__SD3_CMD 0x1f071
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0 0x1f071
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1 0x1f071
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2 0x1f071
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3 0x1f071
+		>;
+	};
+
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6SL_PAD_FEC_MDIO__SD4_CLK 0x1f071
+			MX6SL_PAD_FEC_TX_CLK__SD4_CMD 0x1f071
+			MX6SL_PAD_FEC_RX_ER__SD4_DATA0 0x1f071
+			MX6SL_PAD_FEC_CRS_DV__SD4_DATA1 0x1f071
+			MX6SL_PAD_FEC_RXD1__SD4_DATA2 0x1f071
+			MX6SL_PAD_FEC_TXD0__SD4_DATA3 0x1f071
+			MX6SL_PAD_FEC_MDC__SD4_DATA4 0x1f071
+			MX6SL_PAD_FEC_RXD0__SD4_DATA5 0x1f071
+			MX6SL_PAD_FEC_TX_EN__SD4_DATA6 0x1f071
+			MX6SL_PAD_FEC_TXD1__SD4_DATA7 0x1f071
+		>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	status = "okay";
+};
+
+&usdhc2 {
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	status = "okay";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	status = "okay";
+};
-- 
2.30.0

