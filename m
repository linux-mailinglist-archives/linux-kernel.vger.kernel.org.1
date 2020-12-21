Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2461D2DFB92
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 12:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgLULdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 06:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgLULdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:33:39 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55388C0611CB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:32:29 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id x1so602788pgh.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UKdlQ3V1hZUict9vjwjzfE9Tv12t/Zmb8p1y78rJO2M=;
        b=R9FXXNW3XH3ZNbeKFe0ySnXKGRy18s7wgqEqVqjtv//KQtuxLbFU06jJUgEcsqs6tn
         Efe8kr76WRDilEB24NumB1aO70VFoLkQmgSM2T2GlLjE4g2VVMAAjZAjo0VcsF++23It
         d4weO18huNALF3Y7mpN0aENjXeiGwkwj5Tyxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKdlQ3V1hZUict9vjwjzfE9Tv12t/Zmb8p1y78rJO2M=;
        b=Pqa2+emglrVJGplG8pJfLhSxqolPT98DzLVFLa04Pabh6VrWliZp5uK+NsPFaOlQCz
         YrksLkiN8QUWmlHUXll9LTvs71rfyqcduSY/ztpKLbkvHTRBTzKFAFoL9idnLiwywN6Q
         psfwKijdw4yVTfu0+aw0gsc/apbz1Ch86t/wKw21sRQe4BdSQ5BuC+93X/AtEdZWjOT9
         P7l9WEqT/pKpTbvWLjGaDOz+HU6BIdRkC11M9Fm7RPoS2z2CpNiT9PsDnwmRI92jnad4
         XZ3j+HvpWWUuWoxXiV0UMzgVhWT/wQVpCzmbSopvc5f0qZXZ9v+KFITW9e5NlqKtYlgm
         eZ6w==
X-Gm-Message-State: AOAM531pZV3TLF87ilpPW0NEA9j457T53zYWE4lHbScFXKxd46AsnsEQ
        Q9jsq0fogjNJuB+1d9qLWcizYA==
X-Google-Smtp-Source: ABdhPJwhWODf8Lhz54lWxo4EG6xtTUKWx+hwVV99f2EMZgyptkmoMGYv0jY9eRZlZsVys/t/ya3lAg==
X-Received: by 2002:a63:d846:: with SMTP id k6mr14951139pgj.167.1608550348772;
        Mon, 21 Dec 2020 03:32:28 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:b9d4:ed90:a69c:2530])
        by smtp.gmail.com with ESMTPSA id 197sm16714859pgd.69.2020.12.21.03.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 03:32:28 -0800 (PST)
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
Subject: [PATCH v2 4/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
Date:   Mon, 21 Dec 2020 17:01:49 +0530
Message-Id: <20201221113151.94515-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201221113151.94515-1-jagan@amarulasolutions.com>
References: <20201221113151.94515-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose Carrier
board.

Genaral features:
- Ethernet 10/100
- Wifi/BT
- USB Type A/OTG
- Audio Out
- CAN
- LVDS panel connector

i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.

i.Core MX8M Mini needs to mount on top of this Carrier board for
creating complete i.Core MX8M Mini C.TOUCH 2.0 board.

Add support for it.

Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- enabled fec1 node
- updated commit message
- dropped engicam from filename since it aligned with imx6 engicam
  dts files naming conventions.
- add i2c nodes
- fixed v1 comments

 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../dts/freescale/imx8mm-engicam-common.dtsi  | 82 +++++++++++++++++++
 .../dts/freescale/imx8mm-engicam-ctouch2.dtsi |  7 ++
 .../freescale/imx8mm-icore-mx8mm-ctouch2.dts  | 21 +++++
 4 files changed, 111 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 6f0777ee6cd6..8d49a2c74604 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
new file mode 100644
index 000000000000..f7870efd9dab
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-common.dtsi
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+&fec1 {
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
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
+	pinctrl_usdhc1_gpio: usdhc1gpiogrp {
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
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+/* SD */
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
+	cd-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+	max-frequency = <50000000>;
+	bus-width = <4>;
+	no-1-8-v;
+	pm-ignore-notify;
+	keep-power-in-suspend;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
new file mode 100644
index 000000000000..294df07289a2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+#include "imx8mm-engicam-common.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dts b/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dts
new file mode 100644
index 000000000000..8eb01b1f882a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 NXP
+ * Copyright (c) 2019 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+/dts-v1/;
+#include "imx8mm.dtsi"
+#include "imx8mm-engicam-ctouch2.dtsi"
+#include "imx8mm-icore-mx8mm.dtsi"
+
+/ {
+	model = "Engicam i.Core MX8M Mini C.TOUCH 2.0";
+	compatible = "engicam,icore-mx8mm-ctouch2", "engicam,icore-mx8mm",
+		     "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
-- 
2.25.1

