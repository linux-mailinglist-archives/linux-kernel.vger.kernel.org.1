Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AC52DFB91
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 12:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgLULdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 06:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgLULdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:33:38 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F53C061257
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:32:23 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y8so5454647plp.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WOFEUXTrIEFwAJjA7uwBOdNVJbs2hAoilHaZiMMbFn8=;
        b=pcsFX0KWUq0hkPjks8Q70d29QajxqL1bVJbnoh5sA8Uq5BbOB1UEzcIB8Uq2DidSPp
         HPepWMRZm2ZRgWFEHCcdJL0ZUbxsB9qXbo3bx8VH4Pau3LfzEZ0XQ4CBd/y1tJWFasXb
         icDEx2rcaijkYxgRgPH2CIzskCsnB7adYJ/AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WOFEUXTrIEFwAJjA7uwBOdNVJbs2hAoilHaZiMMbFn8=;
        b=jxJg7fV7QU2dC6MnCrAh8lRSdeCOy3yfJDgJZQEk6/CO+afXRXEsC958Pj5naO0GAk
         Wjby44Z1XzRDuW3vRCfZ9Y56tps4Aqq/nvVNNsfEhrSsp4yyTvqXwsW9B5BWx/0Z7n0u
         tH6pqZoeC0RyuGP8l9QOYiWwSS+Fbxi4kyIjRkGTle4YTdQqI3G1lCd3eJVesmDBZM7f
         lG/U6X685zSNyDYUYqr5O6CglvhSY6DNDr+SPg+0X/d9VqrwI4W7IlQMTeT7OIKFYWIH
         Q356a5iNEwAlzXclymztRsvpUsWH8WInYkBxVxoTKlaA3Uf9prYBALT3XMkqG2IJM/P4
         NlRw==
X-Gm-Message-State: AOAM530KVx5CIiH4iG3He2PDdRMzQAA/UcJ4deK7RjFJR9GBUlYNxXhT
        Ap7b0EaIl1E9ujwi5qBLRRA3K/KCcYLZm2u5
X-Google-Smtp-Source: ABdhPJxxgmqGjlE4tDAYi6d+90aGwpSMgjahhbi3PwZqAUeO/VaD2xxuNsFqP0wlm+nKTuP/Kq+GOw==
X-Received: by 2002:a17:902:ee86:b029:da:76bc:2aa4 with SMTP id a6-20020a170902ee86b02900da76bc2aa4mr15872351pld.62.1608550343277;
        Mon, 21 Dec 2020 03:32:23 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:b9d4:ed90:a69c:2530])
        by smtp.gmail.com with ESMTPSA id 197sm16714859pgd.69.2020.12.21.03.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 03:32:22 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Subject: [PATCH v2 3/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini SoM
Date:   Mon, 21 Dec 2020 17:01:48 +0530
Message-Id: <20201221113151.94515-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201221113151.94515-1-jagan@amarulasolutions.com>
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini
from Engicam.

General features:
- NXP i.MX8M Mini
- Up to 2GB LDDR4
- 8/16GB eMMC
- Gigabit Ethernet
- USB 2.0 Host/OTG
- PCIe Gen2 interface
- I2S
- MIPI DSI to LVDS
- rest of i.MX8M Mini features

i.Core MX8M Mini needs to mount on top of Engicam baseboards
for creating complete platform solutions.

Add support for it.

Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- updated commit message
- add cpu nodes
- add fec1 node
- fixed pmic tree comments
- dropped engicam from filename since it aligned with imx6 engicam
  dts files naming conventions.

 .../dts/freescale/imx8mm-icore-mx8mm.dtsi     | 232 ++++++++++++++++++
 1 file changed, 232 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi
new file mode 100644
index 000000000000..e67865fd102a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 NXP
+ * Copyright (c) 2019 Engicam srl
+ * Copyright (c) 2020 Amarula Solutons(India)
+ */
+
+/ {
+	compatible = "engicam,icore-mx8mm", "fsl,imx8mm";
+};
+
+&A53_0 {
+	cpu-supply = <&reg_buck4>;
+};
+
+&A53_1 {
+	cpu-supply = <&reg_buck4>;
+};
+
+&A53_2 {
+	cpu-supply = <&reg_buck4>;
+};
+
+&A53_3 {
+	cpu-supply = <&reg_buck4>;
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@3 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <3>;
+			reset-gpios = <&gpio3 7 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic@8 {
+		compatible = "nxp,pf8121a";
+		reg = <0x08>;
+
+		regulators {
+			reg_ldo1: ldo1 {
+				regulator-max-microvolt = <5000000>;
+				regulator-min-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_ldo2: ldo2 {
+				regulator-max-microvolt = <5000000>;
+				regulator-min-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_ldo3: ldo3 {
+				regulator-max-microvolt = <5000000>;
+				regulator-min-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_ldo4: ldo4 {
+				regulator-max-microvolt = <5000000>;
+				regulator-min-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck1: buck1 {
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck2: buck2 {
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck3: buck3 {
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck4: buck4 {
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck5: buck5 {
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck6: buck6 {
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck7: buck7 {
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_vsnvs: vsnvs {
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
+&iomuxc {
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
+			MX8MM_IOMUXC_NAND_DATA01_GPIO3_IO7		0x19
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x190
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d0
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d0
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d0
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d0
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d0
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d0
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d0
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d0
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d0
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d0
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x194
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d4
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d4
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d4
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d4
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d4
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d4
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d4
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d4
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d4
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0x196
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0x1d6
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0x1d6
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0x1d6
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0x1d6
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0x1d6
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4             0x1d6
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5            0x1d6
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6            0x1d6
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d6
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x196
+		>;
+	};
+};
+
+/* eMMC */
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
-- 
2.25.1

