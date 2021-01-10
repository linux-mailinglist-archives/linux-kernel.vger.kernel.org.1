Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061092F0A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 00:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbhAJXZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 18:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbhAJXZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 18:25:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8504C06179F;
        Sun, 10 Jan 2021 15:24:22 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m5so14581743wrx.9;
        Sun, 10 Jan 2021 15:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uKOE5c9sCRoTv4gScpDYlZXaPlv+Ek0O5Sa14S5FuDg=;
        b=eF8bI+3A2c07S4sNo39zBLzz0SD8IY/+U0wrMILXPuNjsPg5/DLVgM5C+RjV+mLaOq
         19IiAVDVRqgoSBZRsgG46ob/dH5xAixvs7a3CaSCKSDKTESVp+sA52te6CV36ZvrAV/G
         rIse2rdGfQQbmF1zi5C8ZMEre3+o+3ELHRhaJpgnj1Ex+IjMjjNmkV/X0vm1cpTE0lJ+
         g0Xq+VVHwBA1IuCDYacDo2FHgAIuYS86vupdqhjwXSopmHmn5FSjSRtULJK8Sg5BvAZB
         DVa/TzZ5zVlrREsQsd53QXGtGrbGyCFy/jVLHhG8J2qI1Iq49HyoqdgsGxx2CqVbnY1G
         vvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKOE5c9sCRoTv4gScpDYlZXaPlv+Ek0O5Sa14S5FuDg=;
        b=XwsRNWHfnsg19919yXYBDbtVcz2yxQ0ZT5jS+dixRXwH86Q2luJ7iruu3sQ4P6fOGy
         aFXUPmULjaYd4L3H9V2mnUpA+wOeu7DVzEfh6IclyNweN75l6c6BAUzGKayfckt6kNLh
         6/sLavDrqSXb5AbLl02ORDxeoP3//zRbq3D7LxAHGvWl9xxoVbGEo5CFoRsuR4fCAqoM
         NbZYm67reWJlwWJUTSze1Tu23qDbxHPKT03undPK4qWsKb86hS9ZcXOvUIdrldFfpznz
         fam+tNK5ArzPdLNyXX70orxao463C/BYGnorNCpmzwD7wzuBWtO7hn7uJfQmtioTCwrT
         FKgA==
X-Gm-Message-State: AOAM5327Fmzop4b5WDmEqwWMFyjpAEeZdQijLV9MF9LBfC7DdFw5xDOP
        EyrC6/6nJnjwyysfPR5/fzE=
X-Google-Smtp-Source: ABdhPJwxWqTzllIi601pXBcwQSGNhbhzbsgFiPY+tNt5hKP+WNkqtcrvxoYLR0N5NsYPgLY4wboREw==
X-Received: by 2002:adf:df03:: with SMTP id y3mr13723763wrl.102.1610321061539;
        Sun, 10 Jan 2021 15:24:21 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270029536a450755141e.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:2953:6a45:755:141e])
        by smtp.gmail.com with ESMTPSA id a12sm23426104wrh.71.2021.01.10.15.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 15:24:21 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 2/3] arm64: dts: imx: Add i.mx8mm nitrogen8mm basic dts support
Date:   Mon, 11 Jan 2021 00:24:06 +0100
Message-Id: <20210110232407.1666059-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210110232407.1666059-1-adrien.grassein@gmail.com>
References: <20210110232407.1666059-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with a basic Build Root configuration booting from sdcard.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 657 ++++++++++++++++++
 2 files changed, 658 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 901d80086b47..b2eb7a5e4db3 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -45,6 +45,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-nitrogen.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen8mm_rev2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-phanbell.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-pico-pi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-thor96.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
new file mode 100644
index 000000000000..e942bd175cb5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
@@ -0,0 +1,657 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for Boundary Devices i.MX8MMini Nitrogen8MM Rev2 board.
+ * Adrien Grassein <adrien.grassein@gmail.com.com>
+ */
+/dts-v1/;
+#include "imx8mm.dtsi"
+
+#define MX8MMN(a, b)	MX8MM_##a b
+#define IMX8MMN(a)	IMX8MM_##a
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			/* wm8960 */
+			MX8MMN(IOMUXC_SAI1_MCLK_SAI1_MCLK, 0xd6)
+			MX8MMN(IOMUXC_SAI1_TXFS_SAI1_TX_SYNC, 0xd6)
+			MX8MMN(IOMUXC_SAI1_TXC_SAI1_TX_BCLK, 0xd6)
+			MX8MMN(IOMUXC_SAI1_TXD0_SAI1_TX_DATA0, 0xd6)
+			MX8MMN(IOMUXC_SAI1_RXD0_SAI1_RX_DATA0, 0xd6)
+		>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_ENET_MDC_ENET1_MDC, 0x3)
+			MX8MMN(IOMUXC_ENET_MDIO_ENET1_MDIO, 0x3)
+			MX8MMN(IOMUXC_ENET_TD3_ENET1_RGMII_TD3, 0x1f)
+			MX8MMN(IOMUXC_ENET_TD2_ENET1_RGMII_TD2, 0x1f)
+			MX8MMN(IOMUXC_ENET_TD1_ENET1_RGMII_TD1, 0x1f)
+			MX8MMN(IOMUXC_ENET_TD0_ENET1_RGMII_TD0, 0x1f)
+			MX8MMN(IOMUXC_ENET_RD3_ENET1_RGMII_RD3, 0x91)
+			MX8MMN(IOMUXC_ENET_RD2_ENET1_RGMII_RD2, 0x91)
+			MX8MMN(IOMUXC_ENET_RD1_ENET1_RGMII_RD1, 0x91)
+			MX8MMN(IOMUXC_ENET_RD0_ENET1_RGMII_RD0, 0x91)
+			MX8MMN(IOMUXC_ENET_TXC_ENET1_RGMII_TXC, 0x1f)
+			MX8MMN(IOMUXC_ENET_RXC_ENET1_RGMII_RXC, 0x91)
+			MX8MMN(IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL, 0x91)
+			MX8MMN(IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL, 0x1f)
+#define GPIRQ_FEC1_PHY	<&gpio3 16 IRQ_TYPE_LEVEL_LOW>
+			MX8MMN(IOMUXC_NAND_READY_B_GPIO3_IO16, 0x159)
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_GPIO1_IO03_GPIO1_IO3, 0x09)
+			MX8MMN(IOMUXC_GPIO1_IO08_GPIO1_IO8, 0x09)
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_I2C1_SCL_I2C1_SCL, 0x400001c3)
+			MX8MMN(IOMUXC_I2C1_SDA_I2C1_SDA, 0x400001c3)
+		>;
+	};
+
+	pinctrl_i2c1_1: i2c1_1grp {
+		fsl,pins = <
+#define GP_I2C1_SCL	<&gpio5 14 GPIO_OPEN_DRAIN>
+			MX8MMN(IOMUXC_I2C1_SCL_GPIO5_IO14, 0x400001c3)
+#define GP_I2C1_SDA	<&gpio5 15 GPIO_OPEN_DRAIN>
+			MX8MMN(IOMUXC_I2C1_SDA_GPIO5_IO15, 0x400001c3)
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_I2C2_SCL_I2C2_SCL, 0x400001c3)
+			MX8MMN(IOMUXC_I2C2_SDA_I2C2_SDA, 0x400001c3)
+		>;
+	};
+
+	pinctrl_i2c2_1: i2c2_1grp {
+		fsl,pins = <
+#define GP_I2C2_SCL	<&gpio5 16 GPIO_OPEN_DRAIN>
+			MX8MMN(IOMUXC_I2C2_SCL_GPIO5_IO16, 0x400001c3)
+#define GP_I2C2_SDA	<&gpio5 17 GPIO_OPEN_DRAIN>
+			MX8MMN(IOMUXC_I2C2_SDA_GPIO5_IO17, 0x400001c3)
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_I2C3_SCL_I2C3_SCL, 0x400001c3)
+			MX8MMN(IOMUXC_I2C3_SDA_I2C3_SDA, 0x400001c3)
+		>;
+	};
+
+	pinctrl_i2c3_1: i2c3_1grp {
+		fsl,pins = <
+#define GP_I2C3_SCL	<&gpio5 18 GPIO_OPEN_DRAIN>
+			MX8MMN(IOMUXC_I2C3_SCL_GPIO5_IO18, 0x400001c3)
+#define GP_I2C3_SDA	<&gpio5 19 GPIO_OPEN_DRAIN>
+			MX8MMN(IOMUXC_I2C3_SDA_GPIO5_IO19, 0x400001c3)
+		>;
+	};
+
+	pinctrl_i2c3a_rv4162: i2c3a-rv4162grp {
+		fsl,pins = <
+#define GPIRQ_RV4162		<&gpio4 22 IRQ_TYPE_LEVEL_LOW>
+			MX8MMN(IOMUXC_SAI2_RXC_GPIO4_IO22, 0x1c0)
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_I2C4_SCL_I2C4_SCL, 0x400001c3)
+			MX8MMN(IOMUXC_I2C4_SDA_I2C4_SDA, 0x400001c3)
+		>;
+	};
+
+	pinctrl_i2c4_1: i2c4_1grp {
+		fsl,pins = <
+#define GP_I2C4_SCL	<&gpio5 20 GPIO_OPEN_DRAIN>
+			MX8MMN(IOMUXC_I2C4_SCL_GPIO5_IO20, 0x400001c3)
+#define GP_I2C4_SDA	<&gpio5 21 GPIO_OPEN_DRAIN>
+			MX8MMN(IOMUXC_I2C4_SDA_GPIO5_IO21, 0x400001c3)
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vqmmc: reg_usdhc2_vqmmcgrp {
+		fsl,pins = <
+#define GP_USDHC2_VSEL	<&gpio3 2 GPIO_ACTIVE_HIGH>
+			MX8MMN(IOMUXC_NAND_CE1_B_GPIO3_IO2, 0x16)
+		>;
+	};
+
+	pinctrl_reg_wlan_vmmc: reg-wlan-vmmcgrp {
+		fsl,pins = <
+#define GP_REG_WLAN_VMMC	<&gpio3 20 GPIO_ACTIVE_HIGH>
+			MX8MMN(IOMUXC_SAI5_RXC_GPIO3_IO20, 0x16)
+		>;
+	};
+
+	pinctrl_sound_wm8960: sound-wm8960grp {
+		fsl,pins = <
+#define GP_WM8960_MIC_DET		<&gpio1 10 GPIO_ACTIVE_HIGH>
+			MX8MMN(IOMUXC_GPIO1_IO10_GPIO1_IO10, 0x80)
+#define GP_WM8960_HP_DET		<&gpio4 28 GPIO_ACTIVE_HIGH>
+			MX8MMN(IOMUXC_SAI3_RXFS_GPIO4_IO28, 0x80)
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_UART1_RXD_UART1_DCE_RX, 0x140)
+			MX8MMN(IOMUXC_UART1_TXD_UART1_DCE_TX, 0x140)
+			MX8MMN(IOMUXC_UART3_RXD_UART1_DCE_CTS_B, 0x140)
+			MX8MMN(IOMUXC_UART3_TXD_UART1_DCE_RTS_B, 0x140)
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_UART2_RXD_UART2_DCE_RX, 0x140)
+			MX8MMN(IOMUXC_UART2_TXD_UART2_DCE_TX, 0x140)
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_ECSPI1_SCLK_UART3_DCE_RX, 0x140)
+			MX8MMN(IOMUXC_ECSPI1_MOSI_UART3_DCE_TX, 0x140)
+			MX8MMN(IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B, 0x140)
+			MX8MMN(IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B, 0x140)
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_UART4_RXD_UART4_DCE_RX, 0x140)
+			MX8MMN(IOMUXC_UART4_TXD_UART4_DCE_TX, 0x140)
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_GPIO1_IO12_USB1_OTG_PWR, 0x16)
+			MX8MMN(IOMUXC_GPIO1_IO13_USB1_OTG_OC, 0x156)
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_SD1_CLK_USDHC1_CLK, 0x190)
+			MX8MMN(IOMUXC_SD1_CMD_USDHC1_CMD, 0x1d0)
+			MX8MMN(IOMUXC_SD1_DATA0_USDHC1_DATA0, 0x1d0)
+			MX8MMN(IOMUXC_SD1_DATA1_USDHC1_DATA1, 0x1d0)
+			MX8MMN(IOMUXC_SD1_DATA2_USDHC1_DATA2, 0x1d0)
+			MX8MMN(IOMUXC_SD1_DATA3_USDHC1_DATA3, 0x1d0)
+			MX8MMN(IOMUXC_SD1_DATA4_USDHC1_DATA4, 0x1d0)
+			MX8MMN(IOMUXC_SD1_DATA5_USDHC1_DATA5, 0x1d0)
+			MX8MMN(IOMUXC_SD1_DATA6_USDHC1_DATA6, 0x1d0)
+			MX8MMN(IOMUXC_SD1_DATA7_USDHC1_DATA7, 0x1d0)
+#define GP_EMMC_RESET		<&gpio2 10 GPIO_ACTIVE_LOW>
+			MX8MMN(IOMUXC_SD1_RESET_B_GPIO2_IO10, 0x141)
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX8MMN(IOMUXC_SD1_CLK_USDHC1_CLK, 0x194)
+			MX8MMN(IOMUXC_SD1_CMD_USDHC1_CMD, 0x1d4)
+			MX8MMN(IOMUXC_SD1_DATA0_USDHC1_DATA0, 0x1d4)
+			MX8MMN(IOMUXC_SD1_DATA1_USDHC1_DATA1, 0x1d4)
+			MX8MMN(IOMUXC_SD1_DATA2_USDHC1_DATA2, 0x1d4)
+			MX8MMN(IOMUXC_SD1_DATA3_USDHC1_DATA3, 0x1d4)
+			MX8MMN(IOMUXC_SD1_DATA4_USDHC1_DATA4, 0x1d4)
+			MX8MMN(IOMUXC_SD1_DATA5_USDHC1_DATA5, 0x1d4)
+			MX8MMN(IOMUXC_SD1_DATA6_USDHC1_DATA6, 0x1d4)
+			MX8MMN(IOMUXC_SD1_DATA7_USDHC1_DATA7, 0x1d4)
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX8MMN(IOMUXC_SD1_CLK_USDHC1_CLK, 0x196)
+			MX8MMN(IOMUXC_SD1_CMD_USDHC1_CMD, 0x1d6)
+			MX8MMN(IOMUXC_SD1_DATA0_USDHC1_DATA0, 0x1d6)
+			MX8MMN(IOMUXC_SD1_DATA1_USDHC1_DATA1, 0x1d6)
+			MX8MMN(IOMUXC_SD1_DATA2_USDHC1_DATA2, 0x1d6)
+			MX8MMN(IOMUXC_SD1_DATA3_USDHC1_DATA3, 0x1d6)
+			MX8MMN(IOMUXC_SD1_DATA4_USDHC1_DATA4, 0x1d6)
+			MX8MMN(IOMUXC_SD1_DATA5_USDHC1_DATA5, 0x1d6)
+			MX8MMN(IOMUXC_SD1_DATA6_USDHC1_DATA6, 0x1d6)
+			MX8MMN(IOMUXC_SD1_DATA7_USDHC1_DATA7, 0x1d6)
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_SD2_CLK_USDHC2_CLK, 0x190)
+			MX8MMN(IOMUXC_SD2_CMD_USDHC2_CMD, 0x1d0)
+			MX8MMN(IOMUXC_SD2_DATA0_USDHC2_DATA0, 0x1d0)
+			MX8MMN(IOMUXC_SD2_DATA1_USDHC2_DATA1, 0x1d0)
+			MX8MMN(IOMUXC_SD2_DATA2_USDHC2_DATA2, 0x1d0)
+			MX8MMN(IOMUXC_SD2_DATA3_USDHC2_DATA3, 0x1d0)
+#define GP_USDHC2_CD	<&gpio2 12 GPIO_ACTIVE_LOW>
+			MX8MMN(IOMUXC_SD2_CD_B_GPIO2_IO12, 0x1c4)
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins = <
+			MX8MMN(IOMUXC_SD2_CLK_USDHC2_CLK, 0x194)
+			MX8MMN(IOMUXC_SD2_CMD_USDHC2_CMD, 0x1d4)
+			MX8MMN(IOMUXC_SD2_DATA0_USDHC2_DATA0, 0x1d4)
+			MX8MMN(IOMUXC_SD2_DATA1_USDHC2_DATA1, 0x1d4)
+			MX8MMN(IOMUXC_SD2_DATA2_USDHC2_DATA2, 0x1d4)
+			MX8MMN(IOMUXC_SD2_DATA3_USDHC2_DATA3, 0x1d4)
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins = <
+			MX8MMN(IOMUXC_SD2_CLK_USDHC2_CLK, 0x196)
+			MX8MMN(IOMUXC_SD2_CMD_USDHC2_CMD, 0x1d6)
+			MX8MMN(IOMUXC_SD2_DATA0_USDHC2_DATA0, 0x1d6)
+			MX8MMN(IOMUXC_SD2_DATA1_USDHC2_DATA1, 0x1d6)
+			MX8MMN(IOMUXC_SD2_DATA2_USDHC2_DATA2, 0x1d6)
+			MX8MMN(IOMUXC_SD2_DATA3_USDHC2_DATA3, 0x1d6)
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_NAND_WE_B_USDHC3_CLK, 0x190)
+			MX8MMN(IOMUXC_NAND_WP_B_USDHC3_CMD, 0x1d0)
+			MX8MMN(IOMUXC_NAND_DATA04_USDHC3_DATA0, 0x1d0)
+			MX8MMN(IOMUXC_NAND_DATA05_USDHC3_DATA1, 0x1d0)
+			MX8MMN(IOMUXC_NAND_DATA06_USDHC3_DATA2, 0x1d0)
+			MX8MMN(IOMUXC_NAND_DATA07_USDHC3_DATA3, 0x1d0)
+			/* Bluetooth slow clock */
+			MX8MMN(IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K, 0x03)
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+		fsl,pins = <
+			MX8MMN(IOMUXC_NAND_WE_B_USDHC3_CLK, 0x194)
+			MX8MMN(IOMUXC_NAND_WP_B_USDHC3_CMD, 0x1d4)
+			MX8MMN(IOMUXC_NAND_DATA04_USDHC3_DATA0, 0x1d4)
+			MX8MMN(IOMUXC_NAND_DATA05_USDHC3_DATA1, 0x1d4)
+			MX8MMN(IOMUXC_NAND_DATA06_USDHC3_DATA2, 0x1d4)
+			MX8MMN(IOMUXC_NAND_DATA07_USDHC3_DATA3, 0x1d4)
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+		fsl,pins = <
+			MX8MMN(IOMUXC_NAND_WE_B_USDHC3_CLK, 0x196)
+			MX8MMN(IOMUXC_NAND_WP_B_USDHC3_CMD, 0x1d6)
+			MX8MMN(IOMUXC_NAND_DATA04_USDHC3_DATA0, 0x1d6)
+			MX8MMN(IOMUXC_NAND_DATA05_USDHC3_DATA1, 0x1d6)
+			MX8MMN(IOMUXC_NAND_DATA06_USDHC3_DATA2, 0x1d6)
+			MX8MMN(IOMUXC_NAND_DATA07_USDHC3_DATA3, 0x1d6)
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MMN(IOMUXC_GPIO1_IO02_WDOG1_WDOG_B, 0x140)
+		>;
+	};
+
+};
+
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_1>;
+	scl-gpios = GP_I2C1_SCL;
+	sda-gpios = GP_I2C1_SDA;
+	status = "okay";
+
+	pmic: pf8100@8 {
+		compatible = "nxp,pf8121a";
+		reg = <0x08>;
+		status = "okay";
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
+			reg_sw1: buck1 {
+				nxp,phase = <0>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <400000>;
+				regulator-max-microamp  = <4500000>;
+			};
+
+			reg_sw2: buck2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+			};
+
+			reg_sw3: buck3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+			};
+
+			reg_sw4: buck4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+			};
+
+			reg_sw5: buck5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+			};
+
+			reg_sw6: buck6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt =  <400000>;
+			};
+
+			reg_sw7: buck7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <4100000>;
+				regulator-min-microvolt = <1000000>;
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
+/ {
+	model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
+	compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
+
+	reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vqmmc>;
+		regulator-name = "reg_sd2_vsel";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-type = "voltage";
+		regulator-boot-on;
+		regulator-always-on;
+		gpios = GP_USDHC2_VSEL;
+		states = <1800000 0x1
+			  3300000 0x0>;
+	};
+
+	reg_vref_1v8: regulator-vref-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vref-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_vref_2v5: regulator-vref-2v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "vref-2v5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+	};
+
+	reg_vref_3v3: regulator-vref-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vref-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_vref_5v: regulator-vref-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vref-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_wlan_vmmc: regulator-wlan-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_wlan_vmmc>;
+		regulator-name = "reg_wlan_vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = GP_REG_WLAN_VMMC;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
+	clocks {
+		clk16m: clk16m {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <16000000>;
+		};
+	};
+
+	sound-wm8960 {
+		compatible = "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai1>;
+		codec-master;
+		audio-codec = <&wm8960>;
+		audio-routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"RINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+		/* JD2: hp detect high for headphone*/
+		hp-det = <2 0>;
+		hp-det-gpios = GP_WM8960_HP_DET;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sound_wm8960>;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&reg_sw3>;
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ethphy0: ethernet-phy@4 {
+			compatible = "ethernet-phy-id004D.D072", "ethernet-phy-ieee802.3-c22";
+			reg = <4>;
+			interrupts-extended = GPIRQ_FEC1_PHY;
+		};
+	};
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_1>;
+	scl-gpios = GP_I2C3_SCL;
+	sda-gpios = GP_I2C3_SDA;
+	status = "okay";
+
+	i2cmux@70 {
+		compatible = "nxp,pca9540";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c3a: i2c3@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+				rtc@68 {
+					compatible = "microcrystal,rv4162";
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_i2c3a_rv4162>;
+					reg = <0x68>;
+					interrupts-extended = GPIRQ_RV4162;
+					wakeup-source;
+				};
+		};
+	};
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_1>;
+	scl-gpios = GP_I2C4_SCL;
+	sda-gpios = GP_I2C4_SDA;
+	status = "okay";
+
+	wm8960: codec@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		clocks = <&clk IMX8MMN(CLK_SAI1_ROOT)>;
+		clock-names = "mclk";
+		wlf,shared-lrclk;
+	};
+};
+
+&sai1 {
+	assigned-clocks =
+		<&clk IMX8MMN(AUDIO_PLL1)>,
+		<&clk IMX8MMN(AUDIO_PLL2)>,
+		<&clk IMX8MMN(CLK_SAI1)>;
+	assigned-clock-parents = <0>, <0>, <&clk IMX8MMN(AUDIO_PLL1_OUT)>;
+	assigned-clock-rates = <786432000>, <722534400>, <12288000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
+&uart1 { /* BT */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clk IMX8MMN(CLK_UART1)>;
+	assigned-clock-parents = <&clk IMX8MMN(SYS_PLL1_80M)>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	assigned-clocks = <&clk IMX8MMN(CLK_UART2)>;
+	assigned-clock-parents = <&clk IMX8MMN(CLK_24M)>;
+	status = "okay";
+};
+
+/*eMMC*/
+&usdhc1 {
+	bus-width = <8>;
+	sdhci-caps-mask = <0x80000000 0x0>;
+	non-removable;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	status = "okay";
+	vmmc-supply = <&reg_vref_3v3>;
+	vqmmc-1-8-v;
+	vqmmc-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+/*sdcard*/
+&usdhc2 {
+	bus-width = <4>;
+	cd-gpios = GP_USDHC2_CD;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	status = "okay";
+	vqmmc-supply = <&reg_ldo2>;
+};
+
+/*wlan*/
+&usdhc3 {
+	bus-width = <4>;
+	no-sd-uhs-sdr104;
+	non-removable;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	status = "okay";
+	vmmc-supply = <&reg_wlan_vmmc>;
+	vqmmc-1-8-v;
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
-- 
2.25.1

