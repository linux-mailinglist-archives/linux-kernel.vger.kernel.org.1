Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56A72A2364
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 04:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgKBDNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 22:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgKBDNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 22:13:30 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F37C0617A6;
        Sun,  1 Nov 2020 19:13:30 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f38so9583340pgm.2;
        Sun, 01 Nov 2020 19:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=br7iRkZD/QNmcvvpPjhy6T2C30IgSCEp4e9zAlXf3L8=;
        b=gWOLlz1Ci/msu83yaQ0yUMv0wq+VUUAzulVr8SBlVt1QqTkhg8KpLpvuPlGvLD4lqy
         pTaW3euCtIpwC6cpOq4Qo80yX2CiNCZWocuuJgUqIbLqdbcGEMlPwq8CgV9Y38rHQ4sP
         ofy7JtLbqJTDx1+ybt98Dx21TnDmKyQC082s3djgERgVT5KFAJn1wQirKL/9ktFTVLXT
         i5SteabK70H5fDIBNpDvm0GvOnXpKmJ+2M6Ibn2z+DExXM2dR+qJDzBNbykQR9PbZ+td
         UQ+j3y6CMWBGAuDBkYqIz6SwQZCohG1Ix4rGCeGtPb9b3QnNu78FyPj+VBrr9NvBR1mC
         Qdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=br7iRkZD/QNmcvvpPjhy6T2C30IgSCEp4e9zAlXf3L8=;
        b=UjGFUCodelYUW2uRsV3xjos3F+vFelZ51NY0W4eUz0na+cetE58IAoag8cbnhPqbOZ
         R8fWdUi71fYp+ez3rb5fZzIQhOm9fYNcNRCbcWNXoY7VVCBDxIvMmvfEfR7ONd3JZ3aL
         bDtAMyYQrb4VURXt/M7SrJaozF4bm/zbtrtONXLqRaZGOzAyzyuzm9Qtp1F0fnuZAwpS
         18AvJcmt+RAXSHk+h7WbjPRGVWGjC6l8JJq/s6MDP4EGPaLZJ3gqPbzj8EWhXY54BKSq
         TA2lNmyKdNbSywAu+PmD4hEzcYtm+zhhMrYfMcitZdYARGVfxzbFpu8R9xVizS6pkiqA
         b8bQ==
X-Gm-Message-State: AOAM531ckiBQZ1Nj9hLaz/lS6sJ3diTd3pax3YTKKIzMwl1T7CCqG7/v
        vJaeYJmcK1cXgHEa5kn0SLo=
X-Google-Smtp-Source: ABdhPJyW0VO2mAVgT7JxSL9P4CIJkvJB4aYYlh4f+ATPa2sQEXDcAcmmVMXH8yLslKIaenu6GIwkcw==
X-Received: by 2002:a63:160b:: with SMTP id w11mr11800931pgl.110.1604286810204;
        Sun, 01 Nov 2020 19:13:30 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57c:483e:4828:fb14:ce19:d9d0])
        by smtp.gmail.com with ESMTPSA id y137sm12368408pfc.77.2020.11.01.19.13.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 19:13:29 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] mfd: rt4831: Adds support for Richtek RT4831 MFD core
Date:   Mon,  2 Nov 2020 11:13:22 +0800
Message-Id: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds support Richtek RT4831 MFD core.
RT4831 includes backlight and DSV part that can provode display panel
for postive and negative voltage and WLED driving.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/mfd/Kconfig       |  11 +++++
 drivers/mfd/Makefile      |   1 +
 drivers/mfd/rt4831-core.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 drivers/mfd/rt4831-core.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b99a13..a22f002 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1088,6 +1088,17 @@ config MFD_RDC321X
 	  southbridge which provides access to GPIOs and Watchdog using the
 	  southbridge PCI device configuration space.
 
+config MFD_RT4831
+	tristate "Richtek RT4831 WLED and DSV IC"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  This enables support for the Richtek RT4831.
+	  RT4831 includes WLED driver and DisplayBias voltage(+/-) regulator.
+	  It's common used to provide the display power and to drive the
+	  display backlight WLED.
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
index 00000000..5342959
--- /dev/null
+++ b/drivers/mfd/rt4831-core.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0+
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
+		dev_err(&client->dev, "Failed to get chip enable gpio\n");
+		return PTR_ERR(enable);
+	}
+
+	regmap = devm_regmap_init_i2c(client, &rt4831_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to init regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	ret = regmap_read(regmap, RT4831_REG_REVISION, &val);
+	if (ret) {
+		dev_err(&client->dev, "Fail to get version id\n");
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
+	/* Make sure all off before module removal */
+	return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_RESET_MASK, RT4831_RESET_MASK);
+}
+
+static void rt4831_shutdown(struct i2c_client *client)
+{
+	struct regmap *regmap = dev_get_regmap(&client->dev, NULL);
+
+	/* Make sure all off before machine shutdown */
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

