Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F65A2CBCA1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgLBMO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgLBMO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:14:27 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7ACC061A4C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:13:22 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b26so485293pfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lOLburI5REi8XxNEfsx+l1Yfjn3Mdw/dSmT+meng16U=;
        b=VkgUyUOe801WHXulJuh0h1iM22vZlUwP19yyJXakAtt/1CxFmyMLJPJaHNYcdx9i6L
         ulGvy+vYY13dKOb7sGWHyWwcIagHEqSvZLucv5gOKuljCGyhvCB2pvNQMNefETUpM1Am
         XUKqIZ2usQa40RhVVEX34FN7xJaCnzJNCk8XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lOLburI5REi8XxNEfsx+l1Yfjn3Mdw/dSmT+meng16U=;
        b=Qp5Q5hA9OPkD0PYFHnoo3PznKzkHjCyLqCQYTqMGcOi7OD3+67oH/Qxf0t8zNawXCn
         t+3t9682uMJ1c5vXt5kuAxIGxlsGise3R9gjs3hoWC9RkN8zw5iikfjFbJJQGdpd4H2g
         KT+n4x8BLRI7Bq0pzzxKVhAfxhM5edXTtaM/3GWcodqLXxedtn5kdmOdTQCY47QnCEi1
         +mKuPTa11FOq0nmsjyIbUAxMscJb5lymZGCmufLaq5WcdQYDOw5B8914Vdj3pPV+atY/
         fRGlrg+/QKftbD9d/H0vW5RX70g86cvoaP81Ss8O2CnLgBJely0kYKZduDXdCWSBfdIj
         jeFA==
X-Gm-Message-State: AOAM5308Ww39XcF7eYAeHfDm6emsXXegMy6WrY8MlWLW63/r77PuLXda
        BrITLJ1uEPp86ZPc1wZHl55xVg==
X-Google-Smtp-Source: ABdhPJz2sJHf7lm6GIvWquPTTPNJ1yYmN3vfUlwIo0tZwN5TSjURr1Hu1fFS7tayTu5UTfyBPx6JLA==
X-Received: by 2002:a05:6a00:1389:b029:18b:2d21:2f1a with SMTP id t9-20020a056a001389b029018b2d212f1amr2333328pfg.1.1606911202134;
        Wed, 02 Dec 2020 04:13:22 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:fd53:e9ba:b313:1b1d])
        by smtp.gmail.com with ESMTPSA id b37sm1951315pgl.31.2020.12.02.04.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:13:21 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Matteo Lisi <matteo.lisi@engicam.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 04/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini SOM
Date:   Wed,  2 Dec 2020 17:42:35 +0530
Message-Id: <20201202121241.109952-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202121241.109952-1-jagan@amarulasolutions.com>
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.

General features:
- NXP i.MX8MM
- Up to 2GB LDDR4
- 8/16GB eMMC
- Gigabit Ethernet
- USB 2.0 Host/OTG
- PCIe Gen2 interface
- I2S
- MIPI DSI to LVDS
- rest of i.MX8MM features

i.Core MX8M Mini needs to mount on top of Engicam baseboards for
creating complete platform boards.

Possible baseboards are,
- EDIMM2.2
- C.TOUCH 2.0

Add support for it.

Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../freescale/imx8mm-engicam-icore-mx8mm.dtsi | 209 ++++++++++++++++++
 1 file changed, 209 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi
new file mode 100644
index 000000000000..b87917c40587
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-icore-mx8mm.dtsi
@@ -0,0 +1,209 @@
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
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pf8100@8 {
+		compatible = "nxp,pf8x00";
+		reg = <0x08>;
+
+		regulators {
+			reg_ldo1: ldo1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <5000000>;
+				regulator-min-microvolt = <1500000>;
+			};
+
+			reg_ldo2: ldo2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <5000000>;
+				regulator-min-microvolt = <1500000>;
+			};
+
+			reg_ldo3: ldo3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <5000000>;
+				regulator-min-microvolt = <1500000>;
+			};
+
+			reg_ldo4: ldo4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <5000000>;
+				regulator-min-microvolt = <1500000>;
+			};
+
+			reg_buck1: buck1 {
+				fsl,ilim-ma = <4500>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+			};
+
+			reg_buck2: buck2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+			};
+
+			reg_buck3: buck3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+			};
+
+			reg_buck4: buck4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+				fast-slew = <1>;
+			};
+
+			reg_buck5: buck5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+			};
+
+			reg_buck6: buck6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+			};
+
+			reg_buck7: buck7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+			};
+
+			reg_vsnvs: vsnvs {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_usdhc1_gpio: usdhc1grpgpio {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x41
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
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
+	assigned-clock-rates = <400000000>;
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

