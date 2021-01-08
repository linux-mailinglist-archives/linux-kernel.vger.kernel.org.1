Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733402EFB2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbhAHWX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbhAHWXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:23:54 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407BAC0617AB;
        Fri,  8 Jan 2021 14:22:38 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id b9so16664413ejy.0;
        Fri, 08 Jan 2021 14:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iKuF1Q+0zZX0R5FJch1zT6WhmgjWOfaun6EiC3GExoU=;
        b=Ej73h3jU/xbFAIqzsEtRHOwL+NWS8XRa0ZMykA7nPvU7tivls4drZQ/ei6eal1sjWE
         LJqHidcjFWAxL30jSEgxvbLLkEDQX6rXXSYnvGxhKpRar2txHt04BXZNXcX3cpL5E02n
         JtV5cJEW6nIYQZ0VVcf2qZfMasxwNOooxmQP40Iead5vqPNdIYPs1XTp1EPm8jxpaYR3
         SE19KJMdeauibz2rrjrVgzBZ6SLSwFtUrb409+skNIiD+auGTw6Ky9H3DhSs4mcyKLb4
         oyHEydkFZh3JuSrIme5Zi98j1nnjwcpvNzrtJ4RQQ7nK4c3WwmOJOyUrvWHbcm+MLzCP
         av/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iKuF1Q+0zZX0R5FJch1zT6WhmgjWOfaun6EiC3GExoU=;
        b=lw8rPRGE95VhvXfUoZ7AVX4X15lVcTe680gfG5qBwm1AoEtr9SBC5E6p16LcZ1lkt0
         R7dPrg20je2Ah3jQQczxxR8afwl19EaC6oZOjLsqU1TkI/icM0CRWUuToT0UXUEz2NJb
         KDnVfmBYcxH6XnMF0hzExkCgHIo3fJaR3BgJWlp8/jae5P/+j35DpHrVCxs4uw26fBLI
         +xOU5NT2WHmIfYYHel9igbCQMewh3sTI7B0T2eysL4KYUBSH6oLCwSN47ja+a1tDQy3Y
         hx1G0Vqqf5IBAFvh3tGCuOOjqRQO0UXQtX7OeOC9K6jC/KA6eZlsR1f35jsURXNMVrDa
         51jw==
X-Gm-Message-State: AOAM5307tu1fPdG5z6p+KMXwRpijXSk3tZWZaXTbDjONGewGLJM9ubF9
        4QL+I8zJa+/YGFU05gpYroQ=
X-Google-Smtp-Source: ABdhPJxx7Pj+MDjsm0gAy0eRYLfThaqzLe05xCFUwVtDCzjjlbXvTzJvY+ldqtfo+V2DT6rpqYvGeg==
X-Received: by 2002:a17:906:5043:: with SMTP id e3mr4031396ejk.260.1610144556867;
        Fri, 08 Jan 2021 14:22:36 -0800 (PST)
Received: from localhost (ipv6-8dfc3ce26bc50b06.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:8dfc:3ce2:6bc5:b06])
        by smtp.gmail.com with ESMTPSA id u26sm4226023edo.37.2021.01.08.14.22.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 14:22:36 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     m.felsch@pengutronix.de, narmstrong@baylibre.com,
        parthitce@gmail.com, Oliver Graute <oliver.graute@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/3] ARM: dts: imx6ul: Add Variscite DART-6UL SoM support
Date:   Fri,  8 Jan 2021 23:21:44 +0100
Message-Id: <1610144511-19018-2-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610144511-19018-1-git-send-email-oliver.graute@gmail.com>
References: <1610144511-19018-1-git-send-email-oliver.graute@gmail.com>
X-Patchwork-Bot: notify
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the i.MX6UL variant of the Variscite DART-6UL
SoM Carrier-Board

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>
Cc: Parthiban Nallathambi <parthitce@gmail.com>
---
 .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 300 +++++++++++++++++++++
 1 file changed, 300 insertions(+)

Changelog:

v8:
 - remove can node
 - remove flexscan pinctrl
 - moved lcd and i2c pinctrl
 - sorted regulators
 - add dedicated pinctrl for dvfs regulator

v7:
 - removed cpu0 node
 - fixed phy problem

v6:
 - renamed touch regulator
 - renamed rmii clock
 - moved some muxing to baseboard
 - added pinctrl for gpio key
 - added bus-width to usdhc1
 - fixed missing subnode on partitions

 create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi

diff --git a/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi b/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
new file mode 100644
index 00000000..913a66f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+/ {
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	clk_rmii_ref: clock-rmii-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "rmii-ref";
+	};
+
+	reg_gpio_dvfs: regulator-gpio {
+		compatible = "regulator-gpio";
+		gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_dvfs_reg>;
+		regulator-min-microvolt = <1300000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-name = "gpio_dvfs";
+		regulator-type = "voltage";
+		enable-active-high;
+		states = <1300000 0x1 1400000 0x0>;
+	};
+
+	reg_sd1_vmmc: regulator-sd1-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_touch_3v3: regulator-touch-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "touch_3v3_supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+};
+
+&adc1 {
+	vref-supply = <&reg_touch_3v3>;
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	phy-reset-gpios=<&gpio5 10 1>;
+	phy-reset-duration=<100>;
+	phy-reset-on-resume;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			micrel,rmii-reference-clock-select-25-mhz;
+			clocks = <&clk_rmii_ref>;
+			clock-names = "rmii-ref";
+			reg = <1>;
+		};
+
+		ethphy1: ethernet-phy@3 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			micrel,rmii-reference-clock-select-25-mhz;
+			clocks = <&clk_rmii_ref>;
+			clock-names = "rmii-ref";
+			reg = <3>;
+		};
+	};
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+};
+
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
+			  <&clks IMX6UL_CLK_SAI2>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <0>, <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&snvs_rtc {
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	uart-has-rtscts;
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <4>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	vmmc-supply = <&reg_sd1_vmmc>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
+		>;
+	};
+
+	pinctrl_enet2: enet2grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
+			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x1b0b0
+		>;
+	};
+
+	pinctrl_gpmi_nand: gpminandgrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
+			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
+			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0xb0b1
+			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb000
+			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0xb0b1
+			MX6UL_PAD_NAND_CE1_B__RAWNAND_CE1_B	0xb0b1
+			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0xb0b1
+			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0xb0b1
+			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0xb0b1
+			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0xb0b1
+			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0xb0b1
+			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0xb0b1
+			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0xb0b1
+			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0xb0b1
+			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
+			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT    0x03029
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL	0x4001b8b0
+			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA	0x4001b8b0
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA00__PWM1_OUT		0x110b0
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
+			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
+			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
+			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
+			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
+		>;
+	};
+
+	pinctrl_dvfs_reg: dvfs-grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_CE0_B__GPIO4_IO13	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
+			MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
+			MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO08__WDOG1_WDOG_B	0x78b0
+		>;
+	};
+};
-- 
2.7.4

