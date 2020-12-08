Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87222D2EC7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgLHPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbgLHPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:55:44 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A327C061749;
        Tue,  8 Dec 2020 07:54:58 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w16so12513450pga.9;
        Tue, 08 Dec 2020 07:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c0JzkxeKvUmVjLZtQ0iR3bcMUriEJk5xZfAPGPcmCCI=;
        b=ayE4HE36VWOpLMXdGIqwSb3AmyYIX1zfJREG1JZLXvHKhEAJbOdSD/cIGXHzlHUIIK
         smWM0mbJSMiiNOc2aBdm4M16VSVQyDSBG3O4hZ+lJqcCd4C8zqTGI06y+RnIUO/dSEuk
         KI5+NUf2ezDPQZmyHtp1JBWriyNJfZuHAx6XFzNPX2Q1zfGz1oS1PRGN2zIPffOAQ2Jj
         OCrHID6QaehTsxVUK/I84htQ0zyu4/r4BynT2kxowm6Sw4lt3grSLUuqciOmm9UXbQgA
         kkMvtarhPat7Z5s1OiZMbsiEFLFZOUKrg8z2n5UVstqZGkPT0RxMVuV86IIrinC90U+z
         pjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c0JzkxeKvUmVjLZtQ0iR3bcMUriEJk5xZfAPGPcmCCI=;
        b=JG9nS9traPiJI+ACKEudruv9GTAYz3KhGapc3xB23I7H10VcYaDO32tEiHn3aIBExz
         HtkYaCDp0gpNPbRCD1gBJYwZL10N4OzkaLP+LHW/eGBVwa25KEouU54NxMA6NNaShRQ4
         vT7ctzBc7jJmfpPT2ABdAG/bKZTC4x/2v6IQRUzOTzeXCRMKMt6FZWosn0W2reouy+eG
         mxZYYjKJzWS3j03Gwqye+IfPfxAYQelJyz/wbkyzWu7JcRwr5yB2+0Z1NWll/Tu/1oiE
         +VsmAzB0yU9fDvqiQ00/gvlZ9rPN8RruYwd+Txv3RJrpnvwfRWzMliNa8hFev7hxGGFp
         aQTA==
X-Gm-Message-State: AOAM533rmTu8XKciHSbuoUQlptGO+9RvGMhxd89zXQayeF46AVxllf7E
        Bupp/no9CEpVxhWyhU5cdi4=
X-Google-Smtp-Source: ABdhPJwL4SHje2G9lloLT2R4uA9q8EIPyz9tgmLgaInCVfbaA0yvhJ/C19NU8Duw/o2WaPf04SEOOQ==
X-Received: by 2002:a63:4703:: with SMTP id u3mr23281412pga.199.1607442897803;
        Tue, 08 Dec 2020 07:54:57 -0800 (PST)
Received: from localhost.localdomain (1-171-4-151.dynamic-ip.hinet.net. [1.171.4.151])
        by smtp.gmail.com with ESMTPSA id a17sm6700725pgw.80.2020.12.08.07.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 07:54:56 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/4] mfd: rt4831: Adds support for Richtek RT4831 MFD core
Date:   Tue,  8 Dec 2020 23:54:43 +0800
Message-Id: <1607442886-13046-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This adds support Richtek RT4831 MFD core. It includes four channel WLED driver
and Display Bias Voltage outputs.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
since v2
- Refine Kconfig descriptions.
- Add copyright.
- Refine error logs in probe.
- Refine comment lines in remove and shutdown.
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

