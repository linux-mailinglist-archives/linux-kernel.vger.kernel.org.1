Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFF72F9E28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390251AbhARL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390092AbhARLRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:17:11 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A3DC0613D6;
        Mon, 18 Jan 2021 03:15:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m187so6981474wme.2;
        Mon, 18 Jan 2021 03:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84hqDsD1aWG+I+xBb80stfPRfbHQcj53TiHrV61lb8M=;
        b=UBG7+zYRvcq6LHODqI9yyScH47x21Zla/tkfqTTsaQyF4gv2NqhbFbOKeYMuL3HMZ7
         7qdnOa4Y6+P9HyGisy7ZoM2j+SZ4lLLqQoTlHN1VBW03CZARUUXoW9xx8nlHM5ydQi40
         bBIl5JxbrhCwfjXku7p2tcsPfTUuzdCdx44IACvGuh3fz3ytfgE2/hLZ0or640K6KzPS
         gnLwPZApumUtFecErME1zsqimmdL9B5TV4bqD1CBcG4pgZwW4A2DVpw8IioIyyRulJjc
         eFeFiFQx2vvNZAIEOYXIWFjIFUi1ccf5lmVYCDPPMTuK07tQ2rYDNZSRiAjeZfu/+0ED
         NK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84hqDsD1aWG+I+xBb80stfPRfbHQcj53TiHrV61lb8M=;
        b=dtAnvcsWWWuJE57fINksNKQKmIUJz6i+KH4jpTi8b7j8V9GFVI2063Wqc6YdfVcvhe
         OSiKjNP+B4uv+gSlz4ZsX1V8qdLRDm/2H5XZjS9ZY8WIq1Y/RPX50W89xhIkCuzbgBAY
         9mIGHV+tASoZvE2hJQ3U2Fd9j5H2wZj0obnF96tXY9JEgBXf016tBPc/CFoZVbvzpmNj
         uiRv6lwtlcl7qflqfGv2HvsUVpesAUNTGxDDin6bbyXyze/Zyz6tlhL8cUh0pbww9K8/
         hVYDqDQpjPqB0uCmG1s1XLb6qVeCQ8JHuNC0+rsfuShMwsnBfkGGdQ8zDw3TtWzt5jEp
         9f+Q==
X-Gm-Message-State: AOAM532oPKqtQPnNN5gtGMa2/uNXdNWi71dEjgJJm8eAKjZ5BbTvRf8l
        Rf+Tb0iDlAOgFcsA/oriwSw=
X-Google-Smtp-Source: ABdhPJxqozvbrl0maUWSnpdVx5xneM0D0APWMqvx7LqByTqrOR0NJKBAG80h5gT0irCT9zjLPHH3hQ==
X-Received: by 2002:a7b:cd91:: with SMTP id y17mr20413684wmj.5.1610968538564;
        Mon, 18 Jan 2021 03:15:38 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd2700989047bbcea0de57.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9890:47bb:cea0:de57])
        by smtp.gmail.com with ESMTPSA id b132sm26778440wmh.21.2021.01.18.03.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 03:15:38 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     shawnguo@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v5 2/3] arm64: dts: imx: Add i.mx8mm nitrogen8mm basic dts support
Date:   Mon, 18 Jan 2021 12:15:30 +0100
Message-Id: <20210118111531.903154-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118111531.903154-1-adrien.grassein@gmail.com>
References: <20210118111531.903154-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with a basic Build Root configuration booting from sdcard.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 395 ++++++++++++++++++
 2 files changed, 396 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 38559943c15d..398b5cb4f3e2 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -49,6 +49,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-nitrogen.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen8mm_rev2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-phanbell.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-pico-pi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-thor96.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
new file mode 100644
index 000000000000..755088387ea5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for Boundary Devices i.MX8MMini Nitrogen8MM Rev2 board.
+ * Adrien Grassein <adrien.grassein@gmail.com.com>
+ */
+/dts-v1/;
+#include "imx8mm.dtsi"
+
+/ {
+	model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
+	compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
+};
+
+&A53_0 {
+	cpu-supply = <&reg_sw3>;
+};
+
+&A53_1 {
+	cpu-supply = <&reg_sw3>;
+};
+
+&A53_2 {
+	cpu-supply = <&reg_sw3>;
+};
+
+&A53_3 {
+	cpu-supply = <&reg_sw3>;
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@4 {
+			compatible = "ethernet-phy-id004d.d072",
+				"ethernet-phy-ieee802.3-c22";
+			reg = <4>;
+			interrupts-extended = <&gpio3 16 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic@8 {
+		compatible = "nxp,pf8121a";
+		reg = <0x8>;
+
+		regulators {
+		    reg_ldo1: ldo1 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_ldo2: ldo2 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_ldo3: ldo3 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_ldo4: ldo4 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_buck1: buck1 {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_buck2: buck2 {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_sw3: buck3 {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_buck4: buck4 {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_buck5: buck5 {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_buck6: buck6 {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_buck7: buck7 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_vsnvs: vsnvs {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	i2cmux@70 {
+		compatible = "nxp,pca9540";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c3 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rtc@68 {
+				compatible = "microcrystal,rv4162";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c3a_rv4162>;
+				reg = <0x68>;
+				interrupts-extended = <&gpio4 22 IRQ_TYPE_LEVEL_LOW>;
+				wakeup-source;
+			};
+		};
+	};
+};
+
+/* console */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
+	assigned-clock-parents = <&clk IMX8MM_CLK_24M>;
+	status = "okay";
+};
+
+/* eMMC */
+&usdhc1 {
+	bus-width = <8>;
+	sdhci-caps-mask = <0x80000000 0x0>;
+	non-removable;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	status = "okay";
+};
+
+/* sdcard */
+&usdhc2 {
+	bus-width = <4>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	vqmmc-supply = <&reg_ldo2>;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
+			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3
+			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f
+			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f
+			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f
+			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f
+			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
+			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
+			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
+			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
+			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
+			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
+			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x159
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3 0x09
+			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8 0x09
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL 0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA 0x400001c3
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL 0x400001c3
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA 0x400001c3
+		>;
+	};
+
+	pinctrl_i2c3a_rv4162: i2c3a-rv4162grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22 0x1c0
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX 0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX 0x140
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
+			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4	0x1d0
+			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5	0x1d0
+			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6	0x1d0
+			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7	0x1d0
+			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x141
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
+			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4	0x1d4
+			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5	0x1d4
+			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6	0x1d4
+			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
+			MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4	0x1d6
+			MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5	0x1d6
+			MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6	0x1d6
+			MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7	0x1d6
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12	0x1c4
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhz-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhz-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x190
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d0
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d0
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d0
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d0
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d0
+			MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x03
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK	0x194
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d4
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d4
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d4
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d4
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK	0x196
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD	0x1d6
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d6
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d6
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d6
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d6
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0x140
+		>;
+	};
+};
-- 
2.25.1

