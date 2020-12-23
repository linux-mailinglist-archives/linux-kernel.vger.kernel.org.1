Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037322E1B61
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgLWLGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgLWLGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:06:22 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8BFC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:05:41 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b5so3024287pjk.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 03:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVdPMRsewutYyQa3a3tMwfhmr8a/l+PGH7T6jTGl21c=;
        b=FZR/gcAPqMlS9WE/2oDMTQAipX6LG/yOjUOjIbBsDqMP9okhJJpu92BXeKlOJAoVqo
         DWRnFxinFJThs9XzKsokctMy0sF+pXnevZ0TVdSUwrGS2lG0l069xzIDH8A7mS3CqIb1
         QVmNvK6O45NDh+x81KvPLOZxgnGigpEF+iztY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVdPMRsewutYyQa3a3tMwfhmr8a/l+PGH7T6jTGl21c=;
        b=AhZs/0+wp3MyMaS3h5HP2XFkLQkoL3kSpct0s03gBs50/kwBtCxlO5ek7XhgOF3AMT
         cicsjFP4C2jq+eKW/N2G4ze9b0PS9YO01IkRM+fbhrrFTivA4ZzoP5agPpIA1QSKhyH8
         3s4s9kdTuFpOXPfyDaaIEqpTwJe//z57m/oQ7cUAUK46fUjJw0ceyHLl99zjqBJ3Z0dG
         5lqW4Ye3bWIg53/Y/mhtta37qdLRD9RQchyqztqMsUYiyXVDAJ4k0Vt4fBrY1AAHZbUA
         6+0udByuTHFSAw5F0btibMDFfPjYIVSb9UOqujTiA5QKMymbMTtsRe2jXloredTts1Pl
         3qQA==
X-Gm-Message-State: AOAM530a5pQBhKHxzg1DooTHSlS/HtVkqtpMBN5FxI2uzIYVT8b1qi9+
        d1S/NM+3uKCa8mItOYy+Di696Q==
X-Google-Smtp-Source: ABdhPJy1QGJWY9E3F1MZRZ5CZgAMvDRqAOXV15SDryE8xm0muuyq1ozYJD7HMOIs/q4s7Nr8qkkI4g==
X-Received: by 2002:a17:90b:3844:: with SMTP id nl4mr26146461pjb.93.1608721541257;
        Wed, 23 Dec 2020 03:05:41 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a884:eca4:40c1:8784:571c])
        by smtp.gmail.com with ESMTPSA id 3sm23275909pfv.92.2020.12.23.03.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 03:05:40 -0800 (PST)
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
Subject: [PATCH v3 4/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini C.TOUCH 2.0
Date:   Wed, 23 Dec 2020 16:33:41 +0530
Message-Id: <20201223110343.126638-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201223110343.126638-1-jagan@amarulasolutions.com>
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
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
Changes for v3:
- don't maintain common nodes and include it, if no feature diff
Changes for v2:
- enabled fec1 node
- updated commit message
- dropped engicam from filename since it aligned with imx6 engicam
  dts files naming conventions.
- add i2c nodes
- fixed v1 comments

 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../dts/freescale/imx8mm-engicam-ctouch2.dtsi | 82 +++++++++++++++++++
 .../freescale/imx8mm-icore-mx8mm-ctouch2.dts  | 21 +++++
 3 files changed, 104 insertions(+)
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
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
new file mode 100644
index 000000000000..f7870efd9dab
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
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

