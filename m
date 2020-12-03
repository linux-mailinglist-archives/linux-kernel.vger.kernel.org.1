Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BE42CDACE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgLCQHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgLCQH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:07:29 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE43C061A52;
        Thu,  3 Dec 2020 08:06:43 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id p6so1388945plo.6;
        Thu, 03 Dec 2020 08:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XusUUMOcsxyHAHts7eRaEqOJ9Ba5mevgTlGY1m+u6no=;
        b=DFiej7Rt4Q1riBniDscweT1OzOxLklM91nqD+QbexX28mOEEEQ7cVFuSZItBW0EKCd
         amgj/bBB62s3FOMn2VoKlJHN+5AcflebE72qIZj+wvJyWwEE5ps7RyQb/3YNiW2bd27Y
         zbw2x1vFECMayTxbyOUhg+7oGVlYbPqgOf2cPb1M8oculPUjZ37OPHoeXAUCfBoaIZYM
         hCqlrwodHp0Xuk/urgdXrZjrwpKB/s8bgC5lNppfh0SD8uAw43ts4YEk8L1mYJJBRq3C
         kzcoCsJ/+6QpCyfbthe/jGfvKjbgxrlZUWJnfDh/kAJzRlfRQ2EjHM6Vdvr4q6AxZ36V
         Ue+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XusUUMOcsxyHAHts7eRaEqOJ9Ba5mevgTlGY1m+u6no=;
        b=X/f/tuKQKy1IzFi4V7LZ9/5AXP1AtLSILybdGcfzCszuGT6JfTFYy2gzf7TFfppuPa
         ErjIzAqbawdVDiTb4I+sBeUeT9b3KvY3Fm3TZJpcGYSSSfhs6jnJsCzUUN/VRaqioWd4
         8qPZewUWmlmzZAs9vQM4slFMAlCJ6B5n5YFW8lhoUF10l0nk+U8sBeEoErdXYPLf/fvM
         8bzDBZa4fV5ckyaXrmppXIrfumo0CA99AtV6mL1R/qnvNRfOIHwF6eecQZC2H4+7L+i6
         imBcZlP8ak1XwcJeSN8ZBPTj6Gz1hyGN129/twKxTk7MW02ZcDhA2Y164/1qVqvzME6v
         jhAg==
X-Gm-Message-State: AOAM530wydiDCr3xRLPNcQISNpwy5poycBL9fmGwlTE0juZ20kKFNZYC
        UOsXAtDi6CKNBrPyW6GCddI=
X-Google-Smtp-Source: ABdhPJxLOo1w/yGlUJzY7chjLIJeKvn/HhnjK/TLHIGD/n8YCrn7D7KB77aBVOOqsaowQQp308eBtQ==
X-Received: by 2002:a17:902:8a87:b029:d7:cf56:ce1f with SMTP id p7-20020a1709028a87b02900d7cf56ce1fmr1839663plo.22.1607011603214;
        Thu, 03 Dec 2020 08:06:43 -0800 (PST)
Received: from localhost.localdomain (1-171-1-217.dynamic-ip.hinet.net. [1.171.1.217])
        by smtp.gmail.com with ESMTPSA id h6sm92503pgc.15.2020.12.03.08.06.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:06:42 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] mfd: rt4831: Adds support for Richtek RT4831 MFD core
Date:   Fri,  4 Dec 2020 00:06:32 +0800
Message-Id: <1607011595-13603-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This adds support Richtek RT4831 MFD core. It includes four channel WLED driver
and Display Bias Voltage outputs.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Changes since v2
- Add copyright.
- Refine error log text in probe.
- Refine comment lines in remove and shutdown callback.
- Refine Kconfig descriptions.
---
 drivers/mfd/Kconfig       |  10 ++++
 drivers/mfd/Makefile      |   1 +
 drivers/mfd/rt4831-core.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 drivers/mfd/rt4831-core.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b99a13..dfb2640 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1088,6 +1088,16 @@ config MFD_RDC321X
 	  southbridge which provides access to GPIOs and Watchdog using the
 	  southbridge PCI device configuration space.
 
+config MFD_RT4831
+	tristate "Richtek RT4831 four channel WLED and Display Bias Voltage"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  This enables support for the Richtek RT4831 that includes 4 channel
+	  WLED driving and Display Bias Voltage. It's commonly used to provide
+	  power to the LCD display and LCD backlight.
+
 config MFD_RT5033
 	tristate "Richtek RT5033 Power Management IC"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 1780019..4108141 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -235,6 +235,7 @@ obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
 obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
 obj-$(CONFIG_MFD_DLN2)		+= dln2.o
+obj-$(CONFIG_MFD_RT4831)	+= rt4831-core.o
 obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
 obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
 
diff --git a/drivers/mfd/rt4831-core.c b/drivers/mfd/rt4831-core.c
new file mode 100644
index 00000000..f837c06
--- /dev/null
+++ b/drivers/mfd/rt4831-core.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2020 Richtek Technology Corp.
+ *
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define RT4831_REG_REVISION	0x01
+#define RT4831_REG_ENABLE	0x08
+#define RT4831_REG_I2CPROT	0x15
+
+#define RICHTEK_VID		0x03
+#define RT4831_VID_MASK		GENMASK(1, 0)
+#define RT4831_RESET_MASK	BIT(7)
+#define RT4831_I2CSAFETMR_MASK	BIT(0)
+
+static const struct mfd_cell rt4831_subdevs[] = {
+	OF_MFD_CELL("rt4831-backlight", NULL, NULL, 0, 0, "richtek,rt4831-backlight"),
+	MFD_CELL_NAME("rt4831-regulator")
+};
+
+static bool rt4831_is_accessible_reg(struct device *dev, unsigned int reg)
+{
+	if (reg >= RT4831_REG_REVISION && reg <= RT4831_REG_I2CPROT)
+		return true;
+	return false;
+}
+
+static const struct regmap_config rt4831_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RT4831_REG_I2CPROT,
+
+	.readable_reg = rt4831_is_accessible_reg,
+	.writeable_reg = rt4831_is_accessible_reg,
+};
+
+static int rt4831_probe(struct i2c_client *client)
+{
+	struct gpio_desc *enable;
+	struct regmap *regmap;
+	unsigned int val;
+	int ret;
+
+	enable = devm_gpiod_get_optional(&client->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(enable)) {
+		dev_err(&client->dev, "Failed to get 'enable' GPIO\n");
+		return PTR_ERR(enable);
+	}
+
+	regmap = devm_regmap_init_i2c(client, &rt4831_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to initialize regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	ret = regmap_read(regmap, RT4831_REG_REVISION, &val);
+	if (ret) {
+		dev_err(&client->dev, "Failed to get H/W revision\n");
+		return ret;
+	}
+
+	if ((val & RT4831_VID_MASK) != RICHTEK_VID) {
+		dev_err(&client->dev, "VID not matched, val = 0x%02x\n", val);
+		return -ENODEV;
+	}
+
+	/*
+	 * Used to prevent the abnormal shutdown.
+	 * If SCL/SDA both keep low for one second to reset HW.
+	 */
+	ret = regmap_update_bits(regmap, RT4831_REG_I2CPROT, RT4831_I2CSAFETMR_MASK,
+				 RT4831_I2CSAFETMR_MASK);
+	if (ret) {
+		dev_err(&client->dev, "Failed to enable I2C safety timer\n");
+		return ret;
+	}
+
+	return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, rt4831_subdevs,
+				    ARRAY_SIZE(rt4831_subdevs), NULL, 0, NULL);
+}
+
+static int rt4831_remove(struct i2c_client *client)
+{
+	struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
+
+	/* Disable WLED and DSV outputs */
+	return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
+}
+
+static void rt4831_shutdown(struct i2c_client *client)
+{
+	struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
+
+	/* Disable WLED and DSV outputs */
+	regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
+}
+
+static const struct of_device_id __maybe_unused rt4831_of_match[] = {
+	{ .compatible = "richtek,rt4831", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rt4831_of_match);
+
+static struct i2c_driver rt4831_driver = {
+	.driver = {
+		.name = "rt4831",
+		.of_match_table = of_match_ptr(rt4831_of_match),
+	},
+	.probe_new = rt4831_probe,
+	.remove = rt4831_remove,
+	.shutdown = rt4831_shutdown,
+};
+module_i2c_driver(rt4831_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

