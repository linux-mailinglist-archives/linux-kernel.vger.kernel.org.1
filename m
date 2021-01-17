Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28C32F9658
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 00:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbhAQXpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 18:45:24 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52879 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730243AbhAQXoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 18:44:22 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D4B6F5C0105;
        Sun, 17 Jan 2021 18:43:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 17 Jan 2021 18:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=b4mHUeOWPcqjn
        2WqMnHXiZEBOckEPH0BrsMpO0y3Ab4=; b=oiVpP549gZWdl3ZdhwziXBBCI4AVb
        JUQ71rQ2WFq+D3RVQI/fhRg9NWW0LxKGDEbl8qkPRYYv5gbOBdxr0GixZfuWrUlx
        QYc8stzJZMDwlOQEj4s8fY1oaE1+s2UDP/H4/LwL8ERzncNuKuodN66ZE7a/WISZ
        4zWBPddsjQQSBhtGh5seR6HKCUphW5Lwz2fneff4xU9jCmw8b+O4kORg5myR9hKV
        1rO/quCfeTwgQnM3UREDMjPZIe4yheYXYUR9WL9tzfStYW9yL7Kh452SczzVzAmF
        jUYdq53+xzMzhUtg85wqgRex/FNv2TbSP5l5u4TOxfKsrmghp5XDHHQjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=b4mHUeOWPcqjn2WqMnHXiZEBOckEPH0BrsMpO0y3Ab4=; b=nFaEM5iz
        n8hOOSDXqmgprCSv/IAGzhUF27ONUoTHhc+l8sfw0kpTD9xbK7c0QA1jkvHa8q+c
        fV7v6sUofXpc85p8UyY/hsEbZyAzLdg3cStoSqIpWinpKTFdOTO57Wv1fvCbm7a3
        ZTJoI+tTufTjMSMi/+HHj/dY8+2HYYyMHv0PMD0FrpVA5RRZHP4t9/NKTtRNxS62
        VbE6x0zz6m5aqS4tir8U0fJU/DSrrWU9EkRrJgscSxQtiEBBTqnitNltFZn0eDmW
        rxwpdSm9qDkcalYNQ6tNkREGrc/Cqmqvt2oNtlNrE7rxc5wjAno5smRtyxHC8lI/
        ikY3tH/yG0rQyg==
X-ME-Sender: <xms:p8sEYCHQYGmtu2oMjj2kELgg71foXZGVOR8-zWbHAbKv9LaO8eMong>
    <xme:p8sEYDVgmJ2BFzh5BjqlEAEPsDEDmUs0ufrY2rjiFHtjYlzSNw1Iin0dVISyExjRv
    6qQFJOSSZoS7_gve6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucfkphepjeefrdelfedrkeegrddvtdeknecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:p8sEYMLsjJ4cfqK2yw1hRIIDSg2m6Pq6_UbU9nkZpyhFCBwzrD2Afg>
    <xmx:p8sEYMGGcuJSk9zFU0BNAHLFL4UbeafoTcRs3oDj1WFTQuaJ53pQIw>
    <xmx:p8sEYIWKBCRFCthrEleJ0VRPXPQPvEney30NqhZ5z19wQMO6JzkEDg>
    <xmx:p8sEYKJ_lt3qyXzLLq7hvzfnT7GgmiKuckVIOccmredCT0qSwZhGvA>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id AF2BC24005C;
        Sun, 17 Jan 2021 18:43:34 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 2/6] mfd: Initial commit of sy7636a
Date:   Sat, 16 Jan 2021 20:25:35 -0800
Message-Id: <20210117042539.1609-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210117042539.1609-1-alistair@alistair23.me>
References: <20210117042539.1609-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A Power Management chip
driver.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/mfd/Kconfig         |  10 ++
 drivers/mfd/Makefile        |   2 +
 drivers/mfd/sy7636a.c       | 252 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sy7636a.h |  50 +++++++
 4 files changed, 314 insertions(+)
 create mode 100644 drivers/mfd/sy7636a.c
 create mode 100644 include/linux/mfd/sy7636a.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index bdfce7b15621..c8c62d92433c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1360,6 +1360,16 @@ config MFD_SYSCON
 	  Select this option to enable accessing system control registers
 	  via regmap.
 
+config MFD_SY7636A
+	tristate "Silergy SY7636A Power Management chip driver"
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	depends on I2C=y
+	help
+	  Select this option to enable support for the Silergy SY7636A
+	  Power Management chip driver.
+
 config MFD_DAVINCI_VOICECODEC
 	tristate
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 14fdb188af02..1fa1e635f506 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -265,6 +265,8 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 
+obj-$(CONFIG_MFD_SY7636A)	+= sy7636a.o
+
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
diff --git a/drivers/mfd/sy7636a.c b/drivers/mfd/sy7636a.c
new file mode 100644
index 000000000000..39aac965d854
--- /dev/null
+++ b/drivers/mfd/sy7636a.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MFD driver for SY7636A chip
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
+ *
+ * Based on the lp87565 driver by Keerthy <j-keerthy@ti.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+
+#include <linux/mfd/sy7636a.h>
+
+static const struct regmap_config sy7636a_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct mfd_cell sy7636a_cells[] = {
+	{ .name = "sy7636a-regulator", },
+	{ .name = "sy7636a-temperature", },
+	{ .name = "sy7636a-thermal", },
+};
+
+static const struct of_device_id of_sy7636a_match_table[] = {
+	{ .compatible = "silergy,sy7636a", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_sy7636a_match_table);
+
+static const char * const states[] = {
+	"no fault event",
+	"UVP at VP rail",
+	"UVP at VN rail",
+	"UVP at VPOS rail",
+	"UVP at VNEG rail",
+	"UVP at VDDH rail",
+	"UVP at VEE rail",
+	"SCP at VP rail",
+	"SCP at VN rail",
+	"SCP at VPOS rail",
+	"SCP at VNEG rail",
+	"SCP at VDDH rail",
+	"SCP at VEE rail",
+	"SCP at V COM rail",
+	"UVLO",
+	"Thermal shutdown",
+};
+
+int get_vcom_voltage_mv(struct regmap *regmap)
+{
+	int ret;
+	unsigned int val, val_h;
+
+	ret = regmap_read(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_L, &val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_H, &val_h);
+	if (ret)
+		return ret;
+
+	val |= (val_h << 8);
+
+	return (val & 0x1FF) * 10;
+}
+
+int set_vcom_voltage_mv(struct regmap *regmap, unsigned int vcom)
+{
+	int ret;
+	unsigned int val;
+
+	if (vcom < 0 || vcom > 5000)
+		return -EINVAL;
+
+	val = (unsigned int)(vcom / 10) & 0x1ff;
+
+	ret = regmap_write(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_L, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, SY7636A_REG_VCOM_ADJUST_CTRL_H, val >> 8);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static ssize_t state_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	unsigned int val;
+	struct sy7636a *sy7636a = dev_get_drvdata(dev);
+
+	ret = regmap_read(sy7636a->regmap, SY7636A_REG_FAULT_FLAG, &val);
+	if (ret) {
+		dev_err(sy7636a->dev, "Failed to read from device\n");
+		return ret;
+	}
+
+	val = val >> 1;
+
+	if (val >= ARRAY_SIZE(states)) {
+		dev_err(sy7636a->dev, "Unexpected value read from device: %u\n", val);
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", states[val]);
+}
+static DEVICE_ATTR(state, 0444, state_show, NULL);
+
+static ssize_t power_good_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	unsigned int val;
+	struct sy7636a *sy7636a = dev_get_drvdata(dev);
+
+	ret = regmap_read(sy7636a->regmap, SY7636A_REG_FAULT_FLAG, &val);
+	if (ret) {
+		dev_err(sy7636a->dev, "Failed to read from device\n");
+		return ret;
+	}
+
+	val &= 0x01;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", val ? "ON" : "OFF");
+}
+static DEVICE_ATTR(power_good, 0444, power_good_show, NULL);
+
+static ssize_t vcom_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int ret;
+	struct sy7636a *sy7636a = dev_get_drvdata(dev);
+
+	ret = get_vcom_voltage_mv(sy7636a->regmap);
+	if (ret < 0)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", -ret);
+}
+
+static ssize_t vcom_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int ret;
+	int vcom;
+	struct sy7636a *sy7636a = dev_get_drvdata(dev);
+
+	ret = kstrtoint(buf, 0, &vcom);
+	if (ret)
+		return ret;
+
+	if (vcom > 0 || vcom < -5000)
+		return -EINVAL;
+
+	ret = set_vcom_voltage_mv(sy7636a->regmap, (unsigned int)(-vcom));
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR(vcom, 0644, vcom_show, vcom_store);
+
+static struct attribute *sy7636a_sysfs_attrs[] = {
+	&dev_attr_state.attr,
+	&dev_attr_power_good.attr,
+	&dev_attr_vcom.attr,
+	NULL,
+};
+
+static const struct attribute_group sy7636a_sysfs_attr_group = {
+	.attrs = sy7636a_sysfs_attrs,
+};
+
+static int sy7636a_probe(struct i2c_client *client,
+			 const struct i2c_device_id *ids)
+{
+	struct sy7636a *sy7636a;
+	int ret;
+
+	sy7636a = devm_kzalloc(&client->dev, sizeof(struct sy7636a), GFP_KERNEL);
+	if (sy7636a == NULL)
+		return -ENOMEM;
+
+	sy7636a->dev = &client->dev;
+
+	sy7636a->regmap = devm_regmap_init_i2c(client, &sy7636a_regmap_config);
+	if (IS_ERR(sy7636a->regmap)) {
+		ret = PTR_ERR(sy7636a->regmap);
+		dev_err(sy7636a->dev,
+			"Failed to initialize register map: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(client, sy7636a);
+
+	ret = sysfs_create_group(&client->dev.kobj, &sy7636a_sysfs_attr_group);
+	if (ret) {
+		dev_err(sy7636a->dev, "Failed to create sysfs attributes\n");
+		return ret;
+	}
+
+	ret = devm_mfd_add_devices(sy7636a->dev, PLATFORM_DEVID_AUTO,
+					sy7636a_cells, ARRAY_SIZE(sy7636a_cells),
+					NULL, 0, NULL);
+	if (ret) {
+		dev_err(sy7636a->dev, "Failed to add mfd devices\n");
+		sysfs_remove_group(&client->dev.kobj, &sy7636a_sysfs_attr_group);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id sy7636a_id_table[] = {
+	{ "sy7636a", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, sy7636a_id_table);
+
+static struct i2c_driver sy7636a_driver = {
+	.driver	= {
+		.name	= "sy7636a",
+		.of_match_table = of_sy7636a_match_table,
+	},
+	.probe = sy7636a_probe,
+	.id_table = sy7636a_id_table,
+};
+module_i2c_driver(sy7636a_driver);
+
+MODULE_AUTHOR("Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>");
+MODULE_DESCRIPTION("Silergy SY7636A Multi-Function Device Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
new file mode 100644
index 000000000000..642789c4d0a9
--- /dev/null
+++ b/include/linux/mfd/sy7636a.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Functions to access SY3686A power management chip.
+ *
+ * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
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
+#ifndef __LINUX_MFD_SY7636A_H
+#define __LINUX_MFD_SY7636A_H
+
+#include <linux/i2c.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regmap.h>
+
+#define SY7636A_REG_OPERATION_MODE_CRL 0x00
+#define SY7636A_OPERATION_MODE_CRL_VCOMCTL (1 << 6)
+#define SY7636A_OPERATION_MODE_CRL_ONOFF (1 << 7)
+#define SY7636A_REG_VCOM_ADJUST_CTRL_L 0x01
+#define SY7636A_REG_VCOM_ADJUST_CTRL_H 0x02
+#define SY7636A_REG_VCOM_ADJUST_CTRL_MASK 0x01ff
+#define SY7636A_REG_VLDO_VOLTAGE_ADJULST_CTRL 0x03
+#define SY7636A_REG_POWER_ON_DELAY_TIME 0x06
+#define SY7636A_REG_FAULT_FLAG 0x07
+#define SY7636A_FAULT_FLAG_PG (1 << 0)
+#define SY7636A_REG_TERMISTOR_READOUT 0x08
+
+#define SY7636A_REG_MAX 0x08
+
+struct sy7636a {
+	struct device *dev;
+	struct regmap *regmap;
+	unsigned int vcom;
+	struct gpio_desc *pgood_gpio;
+	struct mutex reglock;
+};
+
+int get_vcom_voltage_mv(struct regmap *regmap);
+int set_vcom_voltage_mv(struct regmap *regmap, unsigned int vcom);
+
+#endif /* __LINUX_MFD_SY7636A_H */
-- 
2.29.2

