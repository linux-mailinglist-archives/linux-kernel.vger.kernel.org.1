Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004022B435D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgKPMK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:10:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:31993 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729907AbgKPMK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:10:26 -0500
IronPort-SDR: 3XHDip/Wd9moDM2yw47vCeamgdDTEOsOkdj+TLiZS4sV8Y1i5kTuGl3g/C9Dzvz5DfvZFAISIP
 pddffUY4RH9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="255446432"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="255446432"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:10:25 -0800
IronPort-SDR: dYl3GQANEfpYIKX4L5jkkRlE+s5MzsNZ8aWMtRsy4TPi0g/MeQ+yhx5srvAqAq5n5wwP6zL9B5
 FJd5jtgJjmJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="356259745"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga008.jf.intel.com with ESMTP; 16 Nov 2020 04:10:22 -0800
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v4 2/2] phy: intel: Add Keem Bay USB PHY support
Date:   Mon, 16 Nov 2020 20:08:31 +0800
Message-Id: <20201116120831.32641-3-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116120831.32641-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20201116120831.32641-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY driver for the USB3.1 and USB 2.0 PHYs found on Intel
Keem Bay SoC. This driver takes care of enabling the required
USB susbsystem (USS) clocks, initializing the PHYs and turning
on/off the USB dwc3 core.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 drivers/phy/intel/Kconfig                 |  12 +
 drivers/phy/intel/Makefile                |   1 +
 drivers/phy/intel/phy-intel-keembay-usb.c | 301 ++++++++++++++++++++++
 3 files changed, 314 insertions(+)
 create mode 100644 drivers/phy/intel/phy-intel-keembay-usb.c

diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
index 58ec695c92ec..f72c699a3e02 100644
--- a/drivers/phy/intel/Kconfig
+++ b/drivers/phy/intel/Kconfig
@@ -14,6 +14,18 @@ config PHY_INTEL_KEEMBAY_EMMC
 	  To compile this driver as a module, choose M here: the module
 	  will be called phy-keembay-emmc.ko.
 
+config PHY_INTEL_KEEMBAY_USB
+	tristate "Intel Keem Bay USB PHY driver"
+	depends on ARCH_KEEMBAY || COMPILE_TEST
+	depends on HAS_IOMEM
+	select GENERIC_PHY
+	select REGMAP_MMIO
+	help
+	  Choose this option if you have an Intel Keem Bay SoC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called phy-keembay-usb.ko.
+
 config PHY_INTEL_LGM_COMBO
 	bool "Intel Lightning Mountain ComboPHY driver"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
index a5e0af5ccd75..14550981a707 100644
--- a/drivers/phy/intel/Makefile
+++ b/drivers/phy/intel/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PHY_INTEL_KEEMBAY_EMMC)	+= phy-intel-keembay-emmc.o
+obj-$(CONFIG_PHY_INTEL_KEEMBAY_USB)	+= phy-intel-keembay-usb.o
 obj-$(CONFIG_PHY_INTEL_LGM_COMBO)	+= phy-intel-lgm-combo.o
 obj-$(CONFIG_PHY_INTEL_LGM_EMMC)	+= phy-intel-lgm-emmc.o
diff --git a/drivers/phy/intel/phy-intel-keembay-usb.c b/drivers/phy/intel/phy-intel-keembay-usb.c
new file mode 100644
index 000000000000..c8b05f7b2445
--- /dev/null
+++ b/drivers/phy/intel/phy-intel-keembay-usb.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keem Bay USB PHY driver
+ * Copyright (C) 2020 Intel Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* USS (USB Subsystem) clock control registers */
+#define USS_CPR_CLK_EN		0x00
+#define USS_CPR_CLK_SET		0x04
+#define USS_CPR_CLK_CLR		0x08
+#define USS_CPR_RST_EN		0x10
+#define USS_CPR_RST_SET		0x14
+#define USS_CPR_RST_CLR		0x18
+
+/* USS clock/reset bit fields */
+#define USS_CPR_PHY_TST		BIT(6)
+#define USS_CPR_LOW_JIT		BIT(5)
+#define USS_CPR_CORE		BIT(4)
+#define USS_CPR_SUSPEND		BIT(3)
+#define USS_CPR_ALT_REF		BIT(2)
+#define USS_CPR_REF		BIT(1)
+#define USS_CPR_SYS		BIT(0)
+#define USS_CPR_MASK		GENMASK(6, 0)
+
+/* USS APB slave registers */
+#define USS_USB_CTRL_CFG0		0x10
+#define  VCC_RESET_N_MASK		BIT(31)
+
+#define USS_USB_PHY_CFG0		0x30
+#define  POR_MASK			BIT(15)
+#define  PHY_RESET_MASK			BIT(14)
+#define  PHY_REF_USE_PAD_MASK		BIT(5)
+
+#define USS_USB_PHY_CFG6		0x64
+#define  PHY0_SRAM_EXT_LD_DONE_MASK	BIT(23)
+
+#define USS_USB_PARALLEL_IF_CTRL	0xa0
+#define  USB_PHY_CR_PARA_SEL_MASK	BIT(2)
+
+#define USS_USB_TSET_SIGNALS_AND_GLOB	0xac
+#define  USB_PHY_CR_PARA_CLK_EN_MASK	BIT(7)
+
+#define USS_USB_STATUS_REG		0xb8
+#define  PHY0_SRAM_INIT_DONE_MASK	BIT(3)
+
+#define USS_USB_TIEOFFS_CONSTANTS_REG1	0xc0
+#define  IDDQ_ENABLE_MASK		BIT(10)
+
+struct keembay_usb_phy {
+	struct device *dev;
+	struct regmap *regmap_cpr;
+	struct regmap *regmap_slv;
+};
+
+static const struct regmap_config keembay_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = USS_USB_TIEOFFS_CONSTANTS_REG1,
+};
+
+static int keembay_usb_clocks_on(struct keembay_usb_phy *priv)
+{
+	int ret;
+
+	ret = regmap_update_bits(priv->regmap_cpr, USS_CPR_CLK_SET,
+				 USS_CPR_MASK, USS_CPR_MASK);
+	if (ret) {
+		dev_err(priv->dev, "error clock set: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(priv->regmap_cpr, USS_CPR_RST_SET,
+				 USS_CPR_MASK, USS_CPR_MASK);
+	if (ret) {
+		dev_err(priv->dev, "error reset set: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(priv->regmap_slv,
+				 USS_USB_TIEOFFS_CONSTANTS_REG1,
+				 IDDQ_ENABLE_MASK,
+				 FIELD_PREP(IDDQ_ENABLE_MASK, 0));
+	if (ret) {
+		dev_err(priv->dev, "error iddq disable: %d\n", ret);
+		return ret;
+	}
+
+	/* Wait 30us to ensure all analog blocks are powered up. */
+	usleep_range(30, 60);
+
+	ret = regmap_update_bits(priv->regmap_slv, USS_USB_PHY_CFG0,
+				 PHY_REF_USE_PAD_MASK,
+				 FIELD_PREP(PHY_REF_USE_PAD_MASK, 1));
+	if (ret)
+		dev_err(priv->dev, "error ref clock select: %d\n", ret);
+
+	return ret;
+}
+
+static int keembay_usb_core_off(struct keembay_usb_phy *priv)
+{
+	int ret;
+
+	ret = regmap_update_bits(priv->regmap_slv, USS_USB_CTRL_CFG0,
+				 VCC_RESET_N_MASK,
+				 FIELD_PREP(VCC_RESET_N_MASK, 0));
+	if (ret)
+		dev_err(priv->dev, "error core reset: %d\n", ret);
+
+	return ret;
+}
+
+static int keembay_usb_core_on(struct keembay_usb_phy *priv)
+{
+	int ret;
+
+	ret = regmap_update_bits(priv->regmap_slv, USS_USB_CTRL_CFG0,
+				 VCC_RESET_N_MASK,
+				 FIELD_PREP(VCC_RESET_N_MASK, 1));
+	if (ret)
+		dev_err(priv->dev, "error core on: %d\n", ret);
+
+	return ret;
+}
+
+static int keembay_usb_phys_on(struct keembay_usb_phy *priv)
+{
+	int ret;
+
+	ret = regmap_update_bits(priv->regmap_slv, USS_USB_PHY_CFG0,
+				 POR_MASK | PHY_RESET_MASK,
+				 FIELD_PREP(POR_MASK | PHY_RESET_MASK, 0));
+	if (ret)
+		dev_err(priv->dev, "error phys on: %d\n", ret);
+
+	return ret;
+}
+
+static int keembay_usb_phy_init(struct phy *phy)
+{
+	struct keembay_usb_phy *priv = phy_get_drvdata(phy);
+	u32 val;
+	int ret;
+
+	ret = keembay_usb_core_off(priv);
+	if (ret)
+		return ret;
+
+	/*
+	 * According to Keem Bay datasheet, wait minimum 20us after clock
+	 * enable before bringing PHYs out of reset.
+	 */
+	usleep_range(20, 40);
+
+	ret = keembay_usb_phys_on(priv);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap_slv,
+				 USS_USB_TSET_SIGNALS_AND_GLOB,
+				 USB_PHY_CR_PARA_CLK_EN_MASK,
+				 FIELD_PREP(USB_PHY_CR_PARA_CLK_EN_MASK, 0));
+	if (ret) {
+		dev_err(priv->dev, "error cr clock disable: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * According to Keem Bay datasheet, wait 2us after disabling the
+	 * clock into the USB 3.x parallel interface.
+	 */
+	udelay(2);
+
+	ret = regmap_update_bits(priv->regmap_slv,
+				 USS_USB_PARALLEL_IF_CTRL,
+				 USB_PHY_CR_PARA_SEL_MASK,
+				 FIELD_PREP(USB_PHY_CR_PARA_SEL_MASK, 1));
+	if (ret) {
+		dev_err(priv->dev, "error cr select: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(priv->regmap_slv,
+				 USS_USB_TSET_SIGNALS_AND_GLOB,
+				 USB_PHY_CR_PARA_CLK_EN_MASK,
+				 FIELD_PREP(USB_PHY_CR_PARA_CLK_EN_MASK, 1));
+	if (ret) {
+		dev_err(priv->dev, "error cr clock enable: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read_poll_timeout(priv->regmap_slv, USS_USB_STATUS_REG,
+				       val, val & PHY0_SRAM_INIT_DONE_MASK,
+				       USEC_PER_MSEC, 10 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(priv->dev, "SRAM init not done: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(priv->regmap_slv, USS_USB_PHY_CFG6,
+				 PHY0_SRAM_EXT_LD_DONE_MASK,
+				 FIELD_PREP(PHY0_SRAM_EXT_LD_DONE_MASK, 1));
+	if (ret) {
+		dev_err(priv->dev, "error SRAM init done set: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * According to Keem Bay datasheet, wait 20us after setting the
+	 * SRAM load done bit, before releasing the controller reset.
+	 */
+	usleep_range(20, 40);
+
+	return keembay_usb_core_on(priv);
+}
+
+static const struct phy_ops ops = {
+	.init		= keembay_usb_phy_init,
+	.owner		= THIS_MODULE,
+};
+
+static int keembay_usb_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct keembay_usb_phy *priv;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	void __iomem *base;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource_byname(pdev, "cpr-apb-base");
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->regmap_cpr = devm_regmap_init_mmio(dev, base,
+						 &keembay_regmap_config);
+	if (IS_ERR(priv->regmap_cpr))
+		return PTR_ERR(priv->regmap_cpr);
+
+	base = devm_platform_ioremap_resource_byname(pdev, "slv-apb-base");
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->regmap_slv = devm_regmap_init_mmio(dev, base,
+						 &keembay_regmap_config);
+	if (IS_ERR(priv->regmap_slv))
+		return PTR_ERR(priv->regmap_slv);
+
+	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
+	if (IS_ERR(generic_phy))
+		return dev_err_probe(dev, PTR_ERR(generic_phy),
+				     "failed to create PHY\n");
+
+	phy_set_drvdata(generic_phy, priv);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return dev_err_probe(dev, PTR_ERR(phy_provider),
+				     "failed to register phy provider\n");
+
+	/* Setup USB subsystem clocks */
+	ret = keembay_usb_clocks_on(priv);
+	if (ret)
+		return ret;
+
+	/* and turn on the DWC3 core, prior to DWC3 driver init. */
+	return keembay_usb_core_on(priv);
+}
+
+static const struct of_device_id keembay_usb_phy_dt_ids[] = {
+	{ .compatible = "intel,keembay-usb-phy" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, keembay_usb_phy_dt_ids);
+
+static struct platform_driver keembay_usb_phy_driver = {
+	.probe		= keembay_usb_phy_probe,
+	.driver		= {
+		.name	= "keembay-usb-phy",
+		.of_match_table = keembay_usb_phy_dt_ids,
+	},
+};
+module_platform_driver(keembay_usb_phy_driver);
+
+MODULE_AUTHOR("Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>");
+MODULE_DESCRIPTION("Intel Keem Bay USB PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

