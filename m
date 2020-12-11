Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42632D7B08
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbgLKQeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgLKQeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:34:36 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F870C0613D6;
        Fri, 11 Dec 2020 08:33:56 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id x24so1627720pgf.0;
        Fri, 11 Dec 2020 08:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c0JzkxeKvUmVjLZtQ0iR3bcMUriEJk5xZfAPGPcmCCI=;
        b=fev7I9AaJjVecCNtHNukGw+QuBh9liNP6thUeLOQN87XrdYMRktJZfH6GgfnQGxfzs
         hEXZPcLZfGT4hpwDhtSEoRyQmmzz4JmCQksfcJncda0no0iMcW8u5ojypUVDMGWrj5MZ
         W2vXd7pWXOEXbYE/gyhyGrIL7NkujVrj9TO3ITjCAAhMMZeu9dOOaS9Q0/7YP/vzKHFb
         yt6SJw6X6SjypgcgU/g+hyRuzsfXZh/G1uF3WiGcAUDhOqeXAq3xaQsbQboHRmTpTwOV
         sYoR5yTK1bWvBy3hpvpIS6vyCOpp+EFLFg/NTJ8DWJR/R9mBL58IoT3D0BPcEIdYvKco
         pv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c0JzkxeKvUmVjLZtQ0iR3bcMUriEJk5xZfAPGPcmCCI=;
        b=l1+UqfyVdzZwUkW+pQ/XDXB5MP4OpVoIgWGcXDh+5AFb4hkZzqAAh+ckQ4++rqXuUO
         JqUKyOQSMzHZ/BBEVS7xAPzuAnMw7VGu+OcLXknINF5IlXMfvvCqxg/JfcW15JGlUe3I
         oJQsMQvQIKbqc+6a9jXitwRDyPVZczSreq3UvoyOuD/iRj9ZFlvSIe3I4696Tmfh6nAR
         71kw68CF+9lgwKOraPKsIO0lGyEjHJJ91XDXALf1jT7S3CicGpqFhd6+l8hbYijQi14I
         pBrRMbsOXEbjSDr125sehuDq5flbCjRxh/SxTtVOY7Jg7KJD8EMuKwTkZ02cPRRh+3PG
         JOIw==
X-Gm-Message-State: AOAM5308tng7eBexgedzfUbt0N/PBeLHCMYo7n6SvJcjg/Hfn4beWInj
        hPAfTBchTQeS2+6SeoVXzOfKNWicjBc=
X-Google-Smtp-Source: ABdhPJwIXCi8EGTeuGsQAJ30tZvUDw+hZUQjmHRTJU5QYOYvJHMUQlaDlpmcNitlwWis4hO+dsg6cg==
X-Received: by 2002:a63:643:: with SMTP id 64mr7983571pgg.422.1607704435939;
        Fri, 11 Dec 2020 08:33:55 -0800 (PST)
Received: from localhost.localdomain (1-171-10-206.dynamic-ip.hinet.net. [1.171.10.206])
        by smtp.gmail.com with ESMTPSA id gm18sm7987947pjb.55.2020.12.11.08.33.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 08:33:54 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/3] mfd: rt4831: Adds support for Richtek RT4831 MFD core
Date:   Sat, 12 Dec 2020 00:33:42 +0800
Message-Id: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
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

