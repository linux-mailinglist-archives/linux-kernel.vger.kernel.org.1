Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9078A2F966B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 00:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbhAQXso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 18:48:44 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44995 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730803AbhAQXor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 18:44:47 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 406205C0117;
        Sun, 17 Jan 2021 18:43:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 17 Jan 2021 18:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ZxXHh1dTfWTeK
        1bvgGiu5yW1zex0oOu65PsZmlaHig0=; b=JZlGiKsIRiIAfMzHGnqWlTJKNgBaF
        jYxoCmSMsDpp9KUQL5vTQEqiSz5btjCAY/7vCmGB0i/6EchETbIjif0VL5dydxAY
        lCYO4ZiKmSnWLAzeYH2DmdlRda6sq6SavDKWfsmEvcU/UE+qdmtaDzDVxHCWzp0z
        sdDuHYKlTuDNnv2W4m5uKZTyYqsjAWSLyRUPdQ3/eNxgDlhV98oj4WeAKz6EyQ5B
        Kd8prp4YH0+npjPGDhD4iOsjsAG56aRZtEVjP+3PZlglDvp37ROA1AvjcbRfvCiS
        za3jhl2r7zLLFIU0k4cmnI1V554oKA71jfbPbJBXlxx2F1JdUxdX9rmTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ZxXHh1dTfWTeK1bvgGiu5yW1zex0oOu65PsZmlaHig0=; b=H0rCDhFp
        pFj2yQJDP7BbJG2VX8A7WDloMPRvgKB2NMCr3I99GkErdGIIb33Xz1C/DjMPvabv
        1uhQcNy044cHGo3rp9oGuv4k3/xkPd22Ul+rwKxlrtdGAYvkPdsdqxIWUN9L+npa
        4HuMp3FExezAscAWdIv1lP+BqDFD2PhWHWGzRiZWyAM9iAOfDna8LZFMq7pgAn/w
        OO2vLSI9X3mioZWhnqIFpeY4by+Pejdbk3kihBougzg4lqKUoYGL90k6d/RHiqAl
        FjFsi+LZi8tX9as9NWk8Q0mKHo2o2MtyTmCxe40YaLzspGKmg29MXkpObJTRc9b8
        BR9kzJDz1s+13A==
X-ME-Sender: <xms:q8sEYB0hHRpF03USV7Bd9qgwc8vooM2YQqGdzV1YrQ2M5jbdMc_s3Q>
    <xme:q8sEYIFD2T4JWcFFSHqWMFs3TUcYULIIdJbHghaZW53Xn-qz93gmSZi35DgTGfAET
    yzi6jg7cu8lhN9-Pxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucfkphepjeefrdelfedrkeegrddvtdeknecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:q8sEYB78cwXyJTC4mvoLA60vgaTq07KI9or8oQGJ705uO_i12ww2eQ>
    <xmx:q8sEYO24cDv1SRyWBbZWyXtGkptSmTU9NRYgn0a99TBuktx0BAyI9g>
    <xmx:q8sEYEFv49GFAXrk_7jbb0HyHeFrQ20jA2Y6zyACT29wN63bkJCYCA>
    <xmx:q8sEYJ4HOWhDjpIbBoIzqqzPDZyt893gI0ypavfTThnbJ_hiT_KbQw>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 21EB7240057;
        Sun, 17 Jan 2021 18:43:38 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 4/6] regulator: Initial commit of sy7636a
Date:   Sat, 16 Jan 2021 20:25:37 -0800
Message-Id: <20210117042539.1609-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210117042539.1609-1-alistair@alistair23.me>
References: <20210117042539.1609-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A-regulator Power Management chip
driver.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/Kconfig             |   6 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/sy7636a-regulator.c | 233 ++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)
 create mode 100644 drivers/regulator/sy7636a-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5abdd29fb9f3..76510a0db4f9 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1097,6 +1097,12 @@ config REGULATOR_STW481X_VMMC
 	  This driver supports the internal VMMC regulator in the STw481x
 	  PMIC chips.
 
+config REGULATOR_SY7636A
+	tristate "Silergy SY7636A voltage regulator"
+	depends on MFD_SY7636A
+	help
+	  This driver supports Silergy SY3686A voltage regulator.
+
 config REGULATOR_SY8106A
 	tristate "Silergy SY8106A regulator"
 	depends on I2C && (OF || COMPILE_TEST)
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 680e539f6579..fe05347cbf84 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -131,6 +131,7 @@ obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
 obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
 obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
+obj-$(CONFIG_REGULATOR_SY7636A) += sy7636a-regulator.o
 obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
 obj-$(CONFIG_REGULATOR_SY8824X) += sy8824x.o
 obj-$(CONFIG_REGULATOR_SY8827N) += sy8827n.o
diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
new file mode 100644
index 000000000000..a639830298d6
--- /dev/null
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Functions to access SY3686A power management chip voltages
+ *
+ * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
+ *
+ * Author: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
+
+#include <linux/mfd/sy7636a.h>
+
+static int get_vcom_voltage_op(struct regulator_dev *rdev)
+{
+	int ret = get_vcom_voltage_mv(rdev->regmap);
+
+	if (ret < 0)
+		return ret;
+
+	return ret * 1000;
+}
+
+static int disable_regulator(struct regulator_dev *rdev)
+{
+	struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
+	int ret = 0;
+
+	mutex_lock(&sy7636a->reglock);
+	ret = regulator_disable_regmap(rdev);
+	usleep_range(30000, 35000);
+	mutex_unlock(&sy7636a->reglock);
+
+	return ret;
+}
+
+static int sy7636a_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
+	int ret;
+
+	mutex_lock(&sy7636a->reglock);
+	ret = regulator_is_enabled_regmap(rdev);
+	mutex_unlock(&sy7636a->reglock);
+
+	return ret;
+}
+
+static int enable_regulator_pgood(struct regulator_dev *rdev)
+{
+	struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
+	int pwr_good = 0;
+	int ret = 0;
+	unsigned long t0, t1;
+	const unsigned int wait_time = 500;
+	unsigned int wait_cnt;
+
+	t0 = jiffies;
+
+	mutex_lock(&sy7636a->reglock);
+
+	ret = regulator_enable_regmap(rdev);
+	if (ret)
+		goto finish;
+
+	for (wait_cnt = 0; wait_cnt < wait_time; wait_cnt++) {
+		pwr_good = gpiod_get_value_cansleep(sy7636a->pgood_gpio);
+		if (pwr_good < 0) {
+			dev_err(&rdev->dev, "Failed to read pgood gpio: %d\n", pwr_good);
+			ret = pwr_good;
+			goto finish;
+		} else if (pwr_good)
+			break;
+
+		usleep_range(1000, 1500);
+	}
+
+	t1 = jiffies;
+
+	if (!pwr_good) {
+		dev_err(&rdev->dev, "Power good signal timeout after %u ms\n",
+				jiffies_to_msecs(t1 - t0));
+		ret = -ETIME;
+		goto finish;
+	}
+
+	dev_dbg(&rdev->dev, "Power good OK (took %u ms, %u waits)\n",
+		jiffies_to_msecs(t1 - t0),
+		wait_cnt);
+
+finish:
+	mutex_unlock(&sy7636a->reglock);
+	return ret;
+}
+
+static const struct regulator_ops sy7636a_vcom_volt_ops = {
+	.get_voltage = get_vcom_voltage_op,
+	.enable = enable_regulator_pgood,
+	.disable = disable_regulator,
+	.is_enabled = sy7636a_regulator_is_enabled,
+};
+
+struct regulator_desc desc = {
+	.name = "vcom",
+	.id = 0,
+	.ops = &sy7636a_vcom_volt_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.enable_reg = SY7636A_REG_OPERATION_MODE_CRL,
+	.enable_mask = SY7636A_OPERATION_MODE_CRL_ONOFF,
+	.regulators_node = of_match_ptr("regulators"),
+	.of_match = of_match_ptr("vcom"),
+};
+
+static int sy7636a_regulator_init(struct sy7636a *sy7636a)
+{
+	return regmap_write(sy7636a->regmap,
+				SY7636A_REG_POWER_ON_DELAY_TIME,
+				0x0);
+}
+
+static int sy7636a_regulator_suspend(struct device *dev)
+{
+	int ret;
+	struct sy7636a *sy7636a = dev_get_drvdata(dev->parent);
+
+	ret = get_vcom_voltage_mv(sy7636a->regmap);
+
+	if (ret > 0)
+		sy7636a->vcom = (unsigned int)ret;
+
+	return 0;
+}
+
+static int sy7636a_regulator_resume(struct device *dev)
+{
+	int ret;
+
+	struct sy7636a *sy7636a = dev_get_drvdata(dev->parent);
+
+	if (!sy7636a->vcom || sy7636a->vcom > 5000) {
+		dev_warn(dev, "Vcom value invalid, and thus not restored\n");
+	} else {
+		ret = set_vcom_voltage_mv(sy7636a->regmap, sy7636a->vcom);
+		if (ret)
+			return ret;
+	}
+
+	return sy7636a_regulator_init(sy7636a);
+}
+
+static int sy7636a_regulator_probe(struct platform_device *pdev)
+{
+	struct sy7636a *sy7636a = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	struct gpio_desc *gdp;
+	int ret;
+
+	if (!sy7636a)
+		return -EPROBE_DEFER;
+
+	platform_set_drvdata(pdev, sy7636a);
+
+	mutex_init(&sy7636a->reglock);
+
+	gdp = devm_gpiod_get(sy7636a->dev, "epd-pwr-good", GPIOD_IN);
+	if (IS_ERR(gdp)) {
+		dev_err(sy7636a->dev, "Power good GPIO fault %ld\n", PTR_ERR(gdp));
+		return PTR_ERR(gdp);
+	}
+
+	sy7636a->pgood_gpio = gdp;
+	dev_info(sy7636a->dev,
+		"Power good GPIO registered (gpio# %d)\n",
+		desc_to_gpio(sy7636a->pgood_gpio));
+
+	ret = sy7636a_regulator_init(sy7636a);
+	if (ret) {
+		dev_err(sy7636a->dev, "Failed to initialize regulator: %d\n", ret);
+		return ret;
+	}
+
+	config.dev = &pdev->dev;
+	config.dev->of_node = sy7636a->dev->of_node;
+	config.driver_data = sy7636a;
+	config.regmap = sy7636a->regmap;
+
+	rdev = devm_regulator_register(&pdev->dev, &desc, &config);
+	if (IS_ERR(rdev)) {
+		dev_err(sy7636a->dev, "Failed to register %s regulator\n",
+			pdev->name);
+		return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id sy7636a_regulator_id_table[] = {
+	{ "sy7636a-regulator", },
+};
+MODULE_DEVICE_TABLE(platform, sy7636a_regulator_id_table);
+
+static const struct dev_pm_ops sy7636a_pm_ops = {
+	.suspend = sy7636a_regulator_suspend,
+	.resume = sy7636a_regulator_resume,
+};
+
+static struct platform_driver sy7636a_regulator_driver = {
+	.driver = {
+		.name = "sy7636a-regulator",
+		.pm = &sy7636a_pm_ops,
+	},
+	.probe = sy7636a_regulator_probe,
+	.id_table = sy7636a_regulator_id_table,
+};
+module_platform_driver(sy7636a_regulator_driver);
+
+MODULE_AUTHOR("Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>");
+MODULE_DESCRIPTION("SY7636A voltage regulator driver");
+MODULE_LICENSE("GPL v2");
-- 
2.29.2

