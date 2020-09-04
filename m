Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B615925D601
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgIDKYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 06:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbgIDKXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:23:38 -0400
Received: from mail.kernel.org (ip5f5ad59b.dynamic.kabel-deutschland.de [95.90.213.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E16062084D;
        Fri,  4 Sep 2020 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599215016;
        bh=iRif6tYG9lH6sF2BTiVslYkjGOYZ9PuRMGMucrM+87g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v7yfpZ6adxV/IrAU46t0m55OmEWAH3/UqYfnBpMQcn50td8cI21gROfCIRRIL/yth
         TjPSkwHD9Cr13m4/riAmiUdT9teRwTLZD6S1U0G1nn2SKqtRdhH2NCfby5iyCXiErA
         OAW1XgkvrDL6uC9L0cpNwGlh5DBOfLHbhrZtuPfU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kE8sX-005Sv6-Lx; Fri, 04 Sep 2020 12:23:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC 01/10] phy: hisilicon: add USB physical layer for Kirin 3670
Date:   Fri,  4 Sep 2020 12:23:23 +0200
Message-Id: <1a1613a60e3e9a79f5ddd81be0f45d44c253ad44.1599214329.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599214329.git.mchehab+huawei@kernel.org>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

Add the Hisilicon Kirin 3670 USB phy driver just after the
hi3660, using the same namespace.

This driver was imported from Linaro's official Hikey 970
tree, from the original patch, removing the addition of
the dwg3-specific parts.

Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/phy/phy-hi3670-usb3.txt          |  25 +
 drivers/phy/hisilicon/Kconfig                 |  10 +
 drivers/phy/hisilicon/Makefile                |   1 +
 drivers/phy/hisilicon/phy-hi3670-usb3.c       | 682 ++++++++++++++++++
 4 files changed, 718 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
 create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c

diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
new file mode 100644
index 000000000000..4cb02612ff23
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
@@ -0,0 +1,25 @@
+Hisilicon Kirin970 usb PHY
+-----------------------
+
+Required properties:
+- compatible: should be "hisilicon,kirin970-usb-phy"
+- #phy-cells: must be 0
+- hisilicon,pericrg-syscon: phandle of syscon used to control phy.
+- hisilicon,pctrl-syscon: phandle of syscon used to control phy.
+- hisilicon,sctrl-syscon: phandle of syscon used to control phy.
+- hisilicon,usb31-misc-syscon: phandle of syscon used to control phy.
+- eye-diagram-param: parameter set for phy
+- usb3-phy-tx-vboost-lvl: parameter set for phy
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Example:
+	usb_phy: usbphy {
+		compatible = "hisilicon,kirin970-usb-phy";
+		#phy-cells = <0>;
+		hisilicon,pericrg-syscon = <&crg_ctrl>;
+		hisilicon,pctrl-syscon = <&pctrl>;
+		hisilicon,sctrl-syscon = <&sctrl>;
+		hisilicon,usb31-misc-syscon = <&usb31_misc>;
+		eye-diagram-param = <0xFDFEE4>;
+		usb3-phy-tx-vboost-lvl = <0x5>;
+	};
diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index 1c73053bcc98..4d008cfc279c 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -23,6 +23,16 @@ config PHY_HI3660_USB
 
 	  To compile this driver as a module, choose M here.
 
+config PHY_HI3670_USB
+	tristate "hi3670 USB PHY support"
+	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the HISILICON HI3670 USB PHY.
+
+	  To compile this driver as a module, choose M here.
+
 config PHY_HISTB_COMBPHY
 	tristate "HiSilicon STB SoCs COMBPHY support"
 	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
diff --git a/drivers/phy/hisilicon/Makefile b/drivers/phy/hisilicon/Makefile
index 92e874ae9c74..51729868145b 100644
--- a/drivers/phy/hisilicon/Makefile
+++ b/drivers/phy/hisilicon/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
 obj-$(CONFIG_PHY_HI3660_USB)		+= phy-hi3660-usb3.o
+obj-$(CONFIG_PHY_HI3670_USB)		+= phy-hi3670-usb3.o
 obj-$(CONFIG_PHY_HISTB_COMBPHY)		+= phy-histb-combphy.o
 obj-$(CONFIG_PHY_HISI_INNO_USB2)	+= phy-hisi-inno-usb2.o
 obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
diff --git a/drivers/phy/hisilicon/phy-hi3670-usb3.c b/drivers/phy/hisilicon/phy-hi3670-usb3.c
new file mode 100644
index 000000000000..4e04ac97728d
--- /dev/null
+++ b/drivers/phy/hisilicon/phy-hi3670-usb3.c
@@ -0,0 +1,682 @@
+/*
+ * Phy provider for USB 3.1 controller on HiSilicon Kirin970 platform
+ *
+ * Copyright (C) 2017-2018 Hilisicon Electronics Co., Ltd.
+ *		http://www.huawei.com
+ *
+ * Authors: Yu Chen <chenyu56@huawei.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/clk.h>
+
+#define SCTRL_SCDEEPSLEEPED		(0x0)
+#define USB_CLK_SELECTED		BIT(20)
+
+#define PERI_CRG_PEREN0			(0x00)
+#define PERI_CRG_PERDIS0		(0x04)
+#define PERI_CRG_PEREN4			(0x40)
+#define PERI_CRG_PERDIS4		(0x44)
+#define PERI_CRG_PERRSTEN4		(0x90)
+#define PERI_CRG_PERRSTDIS4		(0x94)
+#define PERI_CRG_ISODIS			(0x148)
+#define PERI_CRG_PEREN6			(0x410)
+#define PERI_CRG_PERDIS6		(0x414)
+
+#define USB_REFCLK_ISO_EN		BIT(25)
+
+#define GT_CLK_USB2PHY_REF		BIT(19)
+
+#define PCTRL_PERI_CTRL3		(0x10)
+#define PCTRL_PERI_CTRL3_MSK_START	(16)
+#define USB_TCXO_EN			BIT(1)
+
+#define PCTRL_PERI_CTRL24		(0x64)
+#define SC_CLK_USB3PHY_3MUX1_SEL	BIT(25)
+
+#define USB3OTG_CTRL0			(0x00)
+#define USB3OTG_CTRL3			(0x0C)
+#define USB3OTG_CTRL4			(0x10)
+#define USB3OTG_CTRL5			(0x14)
+#define USB3OTG_CTRL7			(0x1C)
+#define USB_MISC_CFG50			(0x50)
+#define USB_MISC_CFG54			(0x54)
+#define USB_MISC_CFG58			(0x58)
+#define USB_MISC_CFG5C			(0x5C)
+#define USB_MISC_CFGA0			(0xA0)
+#define TCA_CLK_RST			(0x200)
+#define TCA_INTR_EN			(0x204)
+#define TCA_INTR_STS			(0x208)
+#define TCA_GCFG			(0x210)
+#define TCA_TCPC			(0x214)
+#define TCA_VBUS_CTRL			(0x240)
+
+#define CTRL0_USB3_VBUSVLD		BIT(7)
+#define CTRL0_USB3_VBUSVLD_SEL		BIT(6)
+
+#define CTRL3_USB2_VBUSVLDEXT0		BIT(6)
+#define CTRL3_USB2_VBUSVLDEXTSEL0	BIT(5)
+
+#define CTRL5_USB2_SIDDQ		BIT(0)
+
+#define CTRL7_USB2_REFCLKSEL_MASK	(3 << 3)
+#define CTRL7_USB2_REFCLKSEL_ABB	(3 << 3)
+#define CTRL7_USB2_REFCLKSEL_PAD	(2 << 3)
+
+#define CFG50_USB3_PHY_TEST_POWERDOWN	BIT(23)
+
+#define CFG54_USB31PHY_CR_ADDR_MASK	(0xFFFF)
+#define CFG54_USB31PHY_CR_ADDR_SHIFT	(16)
+#define CFG54_USB3PHY_REF_USE_PAD	BIT(12)
+#define CFG54_PHY0_PMA_PWR_STABLE	BIT(11)
+#define CFG54_PHY0_PCS_PWR_STABLE	BIT(9)
+#define CFG54_USB31PHY_CR_ACK		BIT(7)
+#define CFG54_USB31PHY_CR_WR_EN		BIT(5)
+#define CFG54_USB31PHY_CR_SEL		BIT(4)
+#define CFG54_USB31PHY_CR_RD_EN		BIT(3)
+#define CFG54_USB31PHY_CR_CLK		BIT(2)
+#define CFG54_USB3_PHY0_ANA_PWR_EN	BIT(1)
+
+#define CFG58_USB31PHY_CR_DATA_MASK     (0xFFFF)
+#define CFG58_USB31PHY_CR_DATA_RD_START (16)
+
+#define CFG5C_USB3_PHY0_SS_MPLLA_SSC_EN	BIT(1)
+
+#define CFGA0_VAUX_RESET		BIT(9)
+#define CFGA0_USB31C_RESET		BIT(8)
+#define CFGA0_USB2PHY_REFCLK_SELECT	BIT(4)
+#define CFGA0_USB3PHY_RESET		BIT(1)
+#define CFGA0_USB2PHY_POR		BIT(0)
+
+#define INTR_EN_XA_TIMEOUT_EVT_EN	BIT(1)
+#define INTR_EN_XA_ACK_EVT_EN		BIT(0)
+
+#define CLK_RST_TCA_REF_CLK_EN		BIT(1)
+#define CLK_RST_SUSPEND_CLK_EN		BIT(0)
+
+#define GCFG_ROLE_HSTDEV		BIT(4)
+
+#define TCPC_VALID			BIT(4)
+#define TCPC_LOW_POWER_EN		BIT(3)
+#define TCPC_MUX_CONTROL_MASK		(3 << 0)
+#define TCPC_MUX_CONTROL_USB31		(1 << 0)
+
+#define VBUS_CTRL_POWERPRESENT_OVERRD	(3 << 2)
+#define VBUS_CTRL_VBUSVALID_OVERRD	(3 << 0)
+
+#define KIRIN970_USB_DEFAULT_PHY_PARAM	(0xFDFEE4)
+#define KIRIN970_USB_DEFAULT_PHY_VBOOST	(0x5)
+
+#define TX_VBOOST_LVL_REG		(0xf)
+#define TX_VBOOST_LVL_START		(6)
+#define TX_VBOOST_LVL_ENABLE		BIT(9)
+
+struct kirin970_priv {
+	struct device *dev;
+	struct regmap *peri_crg;
+	struct regmap *pctrl;
+	struct regmap *sctrl;
+	struct regmap *usb31misc;
+
+	u32 eye_diagram_param;
+	u32 tx_vboost_lvl;
+
+	u32 peri_crg_offset;
+	u32 pctrl_offset;
+	u32 usb31misc_offset;
+};
+
+static int kirin970_phy_cr_clk(struct regmap *usb31misc)
+{
+	int ret;
+
+	/* Clock up */
+	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
+			CFG54_USB31PHY_CR_CLK, CFG54_USB31PHY_CR_CLK);
+	if (ret)
+		return ret;
+
+	/* Clock down */
+	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
+			CFG54_USB31PHY_CR_CLK, 0);
+
+	return ret;
+}
+
+static int kirin970_phy_cr_set_sel(struct regmap *usb31misc)
+{
+	return regmap_update_bits(usb31misc, USB_MISC_CFG54,
+			CFG54_USB31PHY_CR_SEL, CFG54_USB31PHY_CR_SEL);
+}
+
+static int kirin970_phy_cr_start(struct regmap *usb31misc, int direction)
+{
+	int ret;
+
+	if (direction)
+		ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
+			CFG54_USB31PHY_CR_WR_EN, CFG54_USB31PHY_CR_WR_EN);
+	else
+		ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
+			CFG54_USB31PHY_CR_RD_EN, CFG54_USB31PHY_CR_RD_EN);
+
+	if (ret)
+		return ret;
+
+	ret = kirin970_phy_cr_clk(usb31misc);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
+			CFG54_USB31PHY_CR_RD_EN | CFG54_USB31PHY_CR_WR_EN, 0);
+
+	return ret;
+}
+
+static int kirin970_phy_cr_wait_ack(struct regmap *usb31misc)
+{
+	u32 reg;
+	int retry = 100000;
+	int ret;
+
+	while (retry-- > 0) {
+		ret = regmap_read(usb31misc, USB_MISC_CFG54, &reg);
+		if (ret)
+			return ret;
+		if ((reg & CFG54_USB31PHY_CR_ACK) == CFG54_USB31PHY_CR_ACK)
+			return 0;
+
+		ret = kirin970_phy_cr_clk(usb31misc);
+		if (ret)
+			return ret;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int kirin970_phy_cr_set_addr(struct regmap *usb31misc, u32 addr)
+{
+	u32 reg;
+	int ret;
+
+	ret = regmap_read(usb31misc, USB_MISC_CFG54, &reg);
+	if (ret)
+		return ret;
+
+	reg &= ~(CFG54_USB31PHY_CR_ADDR_MASK << CFG54_USB31PHY_CR_ADDR_SHIFT);
+	reg |= ((addr & CFG54_USB31PHY_CR_ADDR_MASK) <<
+			CFG54_USB31PHY_CR_ADDR_SHIFT);
+	ret = regmap_write(usb31misc, USB_MISC_CFG54, reg);
+
+	return ret;
+}
+
+static int kirin970_phy_cr_read(struct regmap *usb31misc, u32 addr, u32 *val)
+{
+	int reg;
+	int i;
+	int ret;
+
+	for (i = 0; i < 100; i++) {
+		ret = kirin970_phy_cr_clk(usb31misc);
+		if (ret)
+			return ret;
+	}
+
+	ret = kirin970_phy_cr_set_sel(usb31misc);
+	if (ret)
+		return ret;
+
+	ret = kirin970_phy_cr_set_addr(usb31misc, addr);
+	if (ret)
+		return ret;
+
+	ret = kirin970_phy_cr_start(usb31misc, 0);
+	if (ret)
+		return ret;
+
+	ret = kirin970_phy_cr_wait_ack(usb31misc);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(usb31misc, USB_MISC_CFG58, &reg);
+	if (ret)
+		return ret;
+
+	*val = (reg >> CFG58_USB31PHY_CR_DATA_RD_START) &
+		CFG58_USB31PHY_CR_DATA_MASK;
+
+	return 0;
+}
+
+static int kirin970_phy_cr_write(struct regmap *usb31misc, u32 addr, u32 val)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < 100; i++) {
+		ret = kirin970_phy_cr_clk(usb31misc);
+		if (ret)
+			return ret;
+	}
+
+	ret = kirin970_phy_cr_set_sel(usb31misc);
+	if (ret)
+		return ret;
+
+	ret = kirin970_phy_cr_set_addr(usb31misc, addr);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(usb31misc, USB_MISC_CFG58,
+			val & CFG58_USB31PHY_CR_DATA_MASK);
+	if (ret)
+		return ret;
+
+	ret = kirin970_phy_cr_start(usb31misc, 1);
+	if (ret)
+		return ret;
+
+	ret = kirin970_phy_cr_wait_ack(usb31misc);
+
+	return ret;
+}
+
+static int kirin970_phy_set_params(struct kirin970_priv *priv)
+{
+	u32 reg;
+	int ret;
+	int retry = 3;
+
+	ret = regmap_write(priv->usb31misc, USB3OTG_CTRL4,
+			priv->eye_diagram_param);
+	if (ret) {
+		dev_err(priv->dev, "set USB3OTG_CTRL4 failed\n");
+		return ret;
+	}
+
+	while (retry-- > 0) {
+		ret = kirin970_phy_cr_read(priv->usb31misc,
+				TX_VBOOST_LVL_REG, &reg);
+		if (!ret)
+			break;
+		else if (ret != -ETIMEDOUT) {
+			dev_err(priv->dev, "read TX_VBOOST_LVL_REG failed\n");
+			return ret;
+		}
+	}
+	if (ret)
+		return ret;
+
+	reg |= (TX_VBOOST_LVL_ENABLE |
+			(priv->tx_vboost_lvl << TX_VBOOST_LVL_START));
+	ret = kirin970_phy_cr_write(priv->usb31misc, TX_VBOOST_LVL_REG, reg);
+	if (ret)
+		dev_err(priv->dev, "write TX_VBOOST_LVL_REG failed\n");
+
+	return ret;
+}
+
+static int kirin970_is_abbclk_seleted(struct kirin970_priv *priv)
+{
+	u32 reg;
+
+	if (!priv->sctrl) {
+		dev_err(priv->dev, "priv->sctrl is null!\n");
+		return 1;
+	}
+
+	if (regmap_read(priv->sctrl, SCTRL_SCDEEPSLEEPED, &reg)) {
+		dev_err(priv->dev, "SCTRL_SCDEEPSLEEPED read failed!\n");
+		return 1;
+	}
+
+	if ((reg & USB_CLK_SELECTED) == 0)
+		return 1;
+
+	return 0;
+}
+
+static int kirin970_config_phy_clock(struct kirin970_priv *priv)
+{
+	u32 val, mask;
+	int ret;
+
+	if (kirin970_is_abbclk_seleted(priv)) {
+		/* usb refclk iso disable */
+		ret = regmap_write(priv->peri_crg, PERI_CRG_ISODIS,
+				USB_REFCLK_ISO_EN);
+		if (ret)
+			goto out;
+
+		/* select usbphy clk from abb */
+		mask = SC_CLK_USB3PHY_3MUX1_SEL;
+		ret = regmap_update_bits(priv->pctrl,
+				PCTRL_PERI_CTRL24, mask, 0);
+		if (ret)
+			goto out;
+
+		ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0,
+				CFGA0_USB2PHY_REFCLK_SELECT, 0);
+		if (ret)
+			goto out;
+
+		ret = regmap_read(priv->usb31misc, USB3OTG_CTRL7, &val);
+		if (ret)
+			goto out;
+		val &= ~CTRL7_USB2_REFCLKSEL_MASK;
+		val |= CTRL7_USB2_REFCLKSEL_ABB;
+		ret = regmap_write(priv->usb31misc, USB3OTG_CTRL7, val);
+		if (ret)
+			goto out;
+	} else {
+		ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFG54,
+				CFG54_USB3PHY_REF_USE_PAD,
+				CFG54_USB3PHY_REF_USE_PAD);
+		if (ret)
+			goto out;
+
+		ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0,
+				CFGA0_USB2PHY_REFCLK_SELECT,
+				CFGA0_USB2PHY_REFCLK_SELECT);
+		if (ret)
+			goto out;
+
+		ret = regmap_read(priv->usb31misc, USB3OTG_CTRL7, &val);
+		if (ret)
+			goto out;
+		val &= ~CTRL7_USB2_REFCLKSEL_MASK;
+		val |= CTRL7_USB2_REFCLKSEL_PAD;
+		ret = regmap_write(priv->usb31misc, USB3OTG_CTRL7, val);
+		if (ret)
+			goto out;
+
+		ret = regmap_write(priv->peri_crg,
+				PERI_CRG_PEREN6, GT_CLK_USB2PHY_REF);
+		if (ret)
+			goto out;
+	}
+
+	return 0;
+out:
+	dev_err(priv->dev, "failed to config phy clock ret: %d\n", ret);
+	return ret;
+}
+
+static int kirin970_config_tca(struct kirin970_priv *priv)
+{
+	u32 val, mask;
+	int ret;
+
+	ret = regmap_write(priv->usb31misc, TCA_INTR_STS, 0xffff);
+	if (ret)
+		goto out;
+
+	ret = regmap_write(priv->usb31misc, TCA_INTR_EN,
+			INTR_EN_XA_TIMEOUT_EVT_EN | INTR_EN_XA_ACK_EVT_EN);
+	if (ret)
+		goto out;
+
+	mask = CLK_RST_TCA_REF_CLK_EN | CLK_RST_SUSPEND_CLK_EN;
+	ret = regmap_update_bits(priv->usb31misc, TCA_CLK_RST, mask, 0);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(priv->usb31misc, TCA_GCFG,
+			GCFG_ROLE_HSTDEV, GCFG_ROLE_HSTDEV);
+	if (ret)
+		goto out;
+
+	ret = regmap_read(priv->usb31misc, TCA_TCPC, &val);
+	if (ret)
+		goto out;
+	val &= ~(TCPC_VALID | TCPC_LOW_POWER_EN | TCPC_MUX_CONTROL_MASK);
+	val |= (TCPC_VALID | TCPC_MUX_CONTROL_USB31);
+	ret = regmap_write(priv->usb31misc, TCA_TCPC, val);
+	if (ret)
+		goto out;
+
+	ret = regmap_write(priv->usb31misc, TCA_VBUS_CTRL,
+		VBUS_CTRL_POWERPRESENT_OVERRD | VBUS_CTRL_VBUSVALID_OVERRD);
+	if (ret)
+		goto out;
+
+	return 0;
+out:
+	dev_err(priv->dev, "failed to config phy clock ret: %d\n", ret);
+	return ret;
+}
+
+static int kirin970_phy_exit(struct phy *phy);
+
+static int kirin970_phy_init(struct phy *phy)
+{
+	struct kirin970_priv *priv = phy_get_drvdata(phy);
+	u32 val;
+	int ret;
+
+	kirin970_phy_exit(phy);
+	dev_info(priv->dev, "%s in\n", __func__);
+	/* assert controller */
+	val = CFGA0_VAUX_RESET | CFGA0_USB31C_RESET;
+	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0, val, 0);
+	if (ret)
+		goto out;
+
+	ret = kirin970_config_phy_clock(priv);
+	if (ret)
+		goto out;
+
+	/* Exit from IDDQ mode */
+	ret = regmap_update_bits(priv->usb31misc, USB3OTG_CTRL5,
+			CTRL5_USB2_SIDDQ, 0);
+	if (ret)
+		goto out;
+
+	/* Release USB31 PHY out of TestPowerDown mode */
+	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFG50,
+			CFG50_USB3_PHY_TEST_POWERDOWN, 0);
+	if (ret)
+		goto out;
+
+	/* Tell the PHY power is stable */
+	val = CFG54_USB3_PHY0_ANA_PWR_EN | CFG54_PHY0_PCS_PWR_STABLE |
+		CFG54_PHY0_PMA_PWR_STABLE;
+	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFG54,
+			val, val);
+	if (ret)
+		goto out;
+
+	ret = kirin970_config_tca(priv);
+	if (ret)
+		goto out;
+
+	/* Enable SSC */
+	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFG5C,
+			CFG5C_USB3_PHY0_SS_MPLLA_SSC_EN,
+			CFG5C_USB3_PHY0_SS_MPLLA_SSC_EN);
+	if (ret)
+		goto out;
+
+	/* Deassert phy */
+	val = CFGA0_USB3PHY_RESET | CFGA0_USB2PHY_POR;
+	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0, val, val);
+	if (ret)
+		goto out;
+
+	udelay(100);
+
+	/* Deassert controller */
+	val = CFGA0_VAUX_RESET | CFGA0_USB31C_RESET;
+	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0, val, val);
+	if (ret)
+		goto out;
+
+	udelay(100);
+
+	/* Set fake vbus valid signal */
+	val = CTRL0_USB3_VBUSVLD | CTRL0_USB3_VBUSVLD_SEL;
+	ret = regmap_update_bits(priv->usb31misc, USB3OTG_CTRL0, val, val);
+	if (ret)
+		goto out;
+
+	val = CTRL3_USB2_VBUSVLDEXT0 | CTRL3_USB2_VBUSVLDEXTSEL0;
+	ret = regmap_update_bits(priv->usb31misc, USB3OTG_CTRL3, val, val);
+	if (ret)
+		goto out;
+
+	udelay(100);
+
+	ret = kirin970_phy_set_params(priv);
+	if (ret)
+		goto out;
+
+	{
+		ret = regmap_read(priv->peri_crg, 0x4c,
+				&val);
+		if (!ret)
+			dev_info(priv->dev, "peri_crg 0x4c %x\n", val);
+		ret = regmap_read(priv->peri_crg, 0x404,
+				&val);
+		if (!ret)
+			dev_info(priv->dev, "peri_crg 0x404 %x\n", val);
+		ret = regmap_read(priv->peri_crg, 0xc,
+				&val);
+		if (!ret)
+			dev_info(priv->dev, "peri_crg 0xc %x\n", val);
+		ret = regmap_read(priv->peri_crg, 0xac,
+				&val);
+		if (!ret)
+			dev_info(priv->dev, "peri_crg 0xac %x\n", val);
+		ret = regmap_read(priv->pctrl, 0x10,
+				&val);
+		if (!ret)
+			dev_info(priv->dev, "pctrl 0x10 %x\n", val);
+	}
+
+	return 0;
+out:
+	dev_err(priv->dev, "failed to init phy ret: %d\n", ret);
+	return ret;
+}
+
+static int kirin970_phy_exit(struct phy *phy)
+{
+	struct kirin970_priv *priv = phy_get_drvdata(phy);
+	u32 mask;
+	int ret;
+
+	/* Assert phy */
+	mask = CFGA0_USB3PHY_RESET | CFGA0_USB2PHY_POR;
+	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0, mask, 0);
+	if (ret)
+		goto out;
+
+	if (!kirin970_is_abbclk_seleted(priv)) {
+		ret = regmap_write(priv->peri_crg, PERI_CRG_PERDIS6,
+				GT_CLK_USB2PHY_REF);
+		if (ret)
+			goto out;
+	}
+
+	return 0;
+out:
+	dev_err(priv->dev, "failed to exit phy ret: %d\n", ret);
+	return ret;
+}
+
+static struct phy_ops kirin970_phy_ops = {
+	.init		= kirin970_phy_init,
+	.exit		= kirin970_phy_exit,
+	.owner		= THIS_MODULE,
+};
+
+static int kirin970_phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct phy *phy;
+	struct kirin970_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->peri_crg = syscon_regmap_lookup_by_phandle(dev->of_node,
+					"hisilicon,pericrg-syscon");
+	if (IS_ERR(priv->peri_crg)) {
+		dev_err(dev, "no hisilicon,pericrg-syscon\n");
+		return PTR_ERR(priv->peri_crg);
+	}
+
+	priv->pctrl = syscon_regmap_lookup_by_phandle(dev->of_node,
+					"hisilicon,pctrl-syscon");
+	if (IS_ERR(priv->pctrl)) {
+		dev_err(dev, "no hisilicon,pctrl-syscon\n");
+		return PTR_ERR(priv->pctrl);
+	}
+
+	priv->sctrl = syscon_regmap_lookup_by_phandle(dev->of_node,
+					"hisilicon,sctrl-syscon");
+	if (IS_ERR(priv->sctrl)) {
+		dev_err(dev, "no hisilicon,sctrl-syscon\n");
+		return PTR_ERR(priv->sctrl);
+	}
+
+	priv->usb31misc = syscon_regmap_lookup_by_phandle(dev->of_node,
+					"hisilicon,usb31-misc-syscon");
+	if (IS_ERR(priv->usb31misc)) {
+		dev_err(dev, "no hisilicon,usb31-misc-syscon\n");
+		return PTR_ERR(priv->usb31misc);
+	}
+
+	if (of_property_read_u32(dev->of_node, "eye-diagram-param",
+				&(priv->eye_diagram_param)))
+		priv->eye_diagram_param = KIRIN970_USB_DEFAULT_PHY_PARAM;
+
+	if (of_property_read_u32(dev->of_node, "usb3-phy-tx-vboost-lvl",
+				&(priv->tx_vboost_lvl)))
+		priv->eye_diagram_param = KIRIN970_USB_DEFAULT_PHY_VBOOST;
+
+	phy = devm_phy_create(dev, NULL, &kirin970_phy_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	phy_set_drvdata(phy, priv);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id kirin970_phy_of_match[] = {
+	{.compatible = "hisilicon,kirin970-usb-phy",},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, kirin970_phy_of_match);
+
+static struct platform_driver kirin970_phy_driver = {
+	.probe	= kirin970_phy_probe,
+	.driver = {
+		.name	= "kirin970-usb-phy",
+		.of_match_table	= kirin970_phy_of_match,
+	}
+};
+module_platform_driver(kirin970_phy_driver);
+
+MODULE_AUTHOR("Yu Chen <chenyu56@huawei.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Hilisicon Kirin970 USB31 PHY Driver");
-- 
2.26.2

