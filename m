Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEFB2E1B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgLWLGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgLWLGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:06:01 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2658C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:05:21 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n10so10396415pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IeBVDoKx8P7ruCXAEHPJs+rWdNCAKxiwqnaq9oGNJaU=;
        b=PVZhsMw+EGTb36uwbHOLAk6aRi7kJqSViCf9/n+n5kHjr1+dEyeSmLBzeZZ7ODDgLO
         yVLx4vEaobtksPOKXx9+ihR4bUQ7F02xgCBq6Jnri47uSp066DeS54JFy/G42rfPubaJ
         1o3K8mT48km2an3dMYZFsI4ltFxiAh2Fk8zYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IeBVDoKx8P7ruCXAEHPJs+rWdNCAKxiwqnaq9oGNJaU=;
        b=Xd3cfudJcgbawOYY9imNsmZx7A3GAHQJZf0JCWJa7IO+cyeYQ/oxuDEEpVVMS4BS9t
         ZN4/PtSmJOgeahmER9OHagqYhgWhe+lDuzy4441luoQed6R+Y2qZutoIb3GYcQeP7eBW
         L6J8KJKkSTKvKV7QsSpckdqb1IuRsS+bR/8grsDfELT0kHwlFBVvLFubcmYcsE0NYh8+
         tTMk1yCI5h8BwSt56YIp0Y2RicUkD3PhC2ejrf7Ztj3EUSRMJoIhHx/OOzRwLlAhL7Tf
         T/oPaaR4F50aKQbg4aX1I8ZRIm05QQWchY7sKY8T2WnHW/U3tnU86v4y59EnOOIquLhg
         UJjA==
X-Gm-Message-State: AOAM530z+liaM5YtSw2iDSLPZqCpjjWM+hik04bRPXszIF2t9A9egrhj
        GbKDcygCeSkr5sdGqI4tFxod4g==
X-Google-Smtp-Source: ABdhPJx8XT38O5aXRz0uJ6uxfOz0+ZxoA0IWTlpJG4CpRhtLNv7vOqnIHliMKsXKbfsMLuBBKYvZuQ==
X-Received: by 2002:a63:1401:: with SMTP id u1mr12411577pgl.229.1608721521191;
        Wed, 23 Dec 2020 03:05:21 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:eca4:40c1:8784:571c])
        by smtp.gmail.com with ESMTPSA id 3sm23275909pfv.92.2020.12.23.03.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 03:05:20 -0800 (PST)
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
Subject: [PATCH v3 3/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini SoM
Date:   Wed, 23 Dec 2020 16:33:40 +0530
Message-Id: <20201223110343.126638-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223110343.126638-1-jagan@amarulasolutions.com>
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
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
Changes for v3:
- keep regulator min/max hoping
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
index 000000000000..b40148d728ea
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
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_ldo2: ldo2 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_ldo3: ldo3 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_ldo4: ldo4 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck1: buck1 {
+				regulator-min-microvolt =  <400000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck2: buck2 {
+				regulator-min-microvolt =  <400000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck3: buck3 {
+				regulator-min-microvolt =  <400000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck4: buck4 {
+				regulator-min-microvolt =  <400000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck5: buck5 {
+				regulator-min-microvolt =  <400000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck6: buck6 {
+				regulator-min-microvolt =  <400000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_buck7: buck7 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			reg_vsnvs: vsnvs {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
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

