Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED4E29EF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgJ2PPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:15:54 -0400
Received: from smtp1.axis.com ([195.60.68.17]:5868 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgJ2PPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=5282; q=dns/txt; s=axis-central1;
  t=1603984553; x=1635520553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d+luN4TIkqRnHvrfez9ugeVq+wez4kakTqwYyauhCE0=;
  b=J4Hq++e5WSLWTr6gKV1nXEZYSHCT7z+fuhpnLVeD3ozrtKd9FiOAVQEy
   o/G5FBvqdJXk4Ke+Blov/V7Hu2Td5YkGwQb56+ngsC55koiDsv4XLE3Yt
   rp/YfZ5xfpffxqRiE7GFteLbkXaeDFR8GmGGEW/nZyK5PZHD5aEnxDGT7
   0uKvaHgm9M2wxNsaNZtnuAABtM+x7kR/bMgwJj4h1LyNEQYhv08O1xA9B
   a5pZELu9Lg+028qboohjeygrR+X4WDs6EerMYEXw4YMlx7sfx5+LLTAfq
   Sgiz2FOCNMVYCjAlAqBWyEtWBcr5GjiQHE1r1S2FqIHGUV8w36V6wxwMP
   g==;
IronPort-SDR: aFCSd9MxpzFYJCVmOapFaJVVEpTfD/nmd8in7Ta3vSg4/18oikwYW0A3nQnka3CJOdciEWpg+L
 ugu7e9bQmLxlxFi6gd8c+WpHS8FGqaS4Be3Gekgru56horWmGA+5FvSpt6ZMzCShDqBN5CMRcM
 VO0Ifh47mY1EO3/1DZJjmqebMR8JJfk+FX/r+5LjivSm3hoHiEC1M2kKkJ7+qccpGOlBSBuGsd
 BHPtIhi4WDsjwHDDjRDQFDUopuqvwWRUB02RfYUMwyyWu2FxLbhSfm1eB6aLt5Ge++NLgnMNOU
 9cU=
X-IronPort-AV: E=Sophos;i="5.77,430,1596492000"; 
   d="scan'208";a="14562030"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <support.opensource@diasemi.com>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 2/2] regulator: Add support for DA9121 regulator
Date:   Thu, 29 Oct 2020 16:15:38 +0100
Message-ID: <20201029151538.23463-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029151538.23463-1-vincent.whitchurch@axis.com>
References: <20201029151538.23463-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Dialog Semiconductor DA9121, a single-channel
dual-phase buck converter controlled via I2C.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/regulator/Kconfig            |  12 +++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/da9121-regulator.c | 111 +++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 drivers/regulator/da9121-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 020a00d6696b..005a6036dd38 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -303,6 +303,18 @@ config REGULATOR_DA9063
 	  This driver can also be built as a module. If so, the module
 	  will be called da9063-regulator.
 
+config REGULATOR_DA9121
+	tristate "Dialog Semiconductor DA9121 regulator"
+	depends on I2C && OF
+	select REGMAP_I2C
+	help
+	  Say y here to support for the Dialog Semiconductor DA9121.  The
+	  DA9210 is a dual-phase buck converter controlled through an I2C
+	  interface.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called da9121-regulator.
+
 config REGULATOR_DA9210
 	tristate "Dialog Semiconductor DA9210 regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 6ebae516258e..6096862a1d60 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
 obj-$(CONFIG_REGULATOR_DA9055)	+= da9055-regulator.o
 obj-$(CONFIG_REGULATOR_DA9062)	+= da9062-regulator.o
 obj-$(CONFIG_REGULATOR_DA9063)	+= da9063-regulator.o
+obj-$(CONFIG_REGULATOR_DA9121) += da9121-regulator.o
 obj-$(CONFIG_REGULATOR_DA9210) += da9210-regulator.o
 obj-$(CONFIG_REGULATOR_DA9211) += da9211-regulator.o
 obj-$(CONFIG_REGULATOR_DBX500_PRCMU) += dbx500-prcmu.o
diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
new file mode 100644
index 000000000000..d712e8f07c41
--- /dev/null
+++ b/drivers/regulator/da9121-regulator.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2020 Axis Communications AB */
+
+#include <linux/of_device.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/driver.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+
+#define DA9121_BUCK_BUCK1_0			0x20
+#define DA9121_BUCK_BUCK1_0_CH1_EN		BIT(0)
+
+#define DA9121_BUCK_BUCK1_5			0x25
+#define DA9121_BUCK_BUCK1_5_CH1_A_VOUT		GENMASK(7, 0)
+
+#define DA9121_MIN_MV		300
+#define DA9121_MAX_MV		1900
+#define DA9121_STEP_MV		10
+#define DA9121_MIN_SEL		(DA9121_MIN_MV / DA9121_STEP_MV)
+#define DA9121_N_VOLTAGES	(((DA9121_MAX_MV - DA9121_MIN_MV) / DA9121_STEP_MV) \
+				 + 1 + DA9121_MIN_SEL)
+
+static const struct regmap_config da9121_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct regulator_ops da9121_buck_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+};
+
+static const struct regulator_desc da9121_reg = {
+	.name = "da9121",
+	.owner = THIS_MODULE,
+	.ops = &da9121_buck_ops,
+	.type = REGULATOR_VOLTAGE,
+	.n_voltages = DA9121_N_VOLTAGES,
+	.min_uV = DA9121_MIN_MV * 1000,
+	.uV_step = DA9121_STEP_MV * 1000,
+	.linear_min_sel = DA9121_MIN_SEL,
+	.vsel_reg = DA9121_BUCK_BUCK1_5,
+	.vsel_mask = DA9121_BUCK_BUCK1_5_CH1_A_VOUT,
+	.enable_reg = DA9121_BUCK_BUCK1_0,
+	.enable_mask = DA9121_BUCK_BUCK1_0_CH1_EN,
+	/* Default value of BUCK_BUCK1_0.CH1_SRC_DVC_UP */
+	.ramp_delay = 20000,
+	/* tBUCK_EN */
+	.enable_time = 20,
+};
+
+static const struct of_device_id da9121_dt_ids[] = {
+	{ .compatible = "dlg,da9121", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, da9121_dt_ids);
+
+static int da9121_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct device *dev = &i2c->dev;
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(i2c, &da9121_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	config.dev = &i2c->dev;
+	config.of_node = dev->of_node;
+	config.regmap = regmap;
+
+	config.init_data = of_get_regulator_init_data(dev, dev->of_node, &da9121_reg);
+	if (!config.init_data)
+		return -ENOMEM;
+
+	rdev = devm_regulator_register(&i2c->dev, &da9121_reg, &config);
+	if (IS_ERR(rdev)) {
+		dev_err(&i2c->dev, "Failed to register da9121 regulator\n");
+		return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id da9121_i2c_id[] = {
+	{ "da9121", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, da9121_i2c_id);
+
+static struct i2c_driver da9121_regulator_driver = {
+	.driver = {
+		.name = "da9121",
+		.of_match_table = of_match_ptr(da9121_dt_ids),
+	},
+	.probe = da9121_i2c_probe,
+	.id_table = da9121_i2c_id,
+};
+
+module_i2c_driver(da9121_regulator_driver);
+
+MODULE_LICENSE("GPL v2");
-- 
2.28.0

