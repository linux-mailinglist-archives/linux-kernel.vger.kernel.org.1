Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E622DE30D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgLRNE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 08:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgLRNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:04:58 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1907C061248
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 05:03:40 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id r4so2460833wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 05:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SomAFJ7qnr9L26Nv065Zuy2S1du+XbrqDmOV4WPXjeU=;
        b=U1KMxVzDQK+RNwGlKwzAXYBj1Z/srGWMkEn80K2EG0vu9G203qa91mdPbk7+9UYuNV
         DyqbwFdU1ueCb38HkoLJqzj27/J3wtYjZcsiIB9Ait7yzA5akuQZ3SLqFGtQGKLVSXCr
         dlHQc0j+ltXEa253C+4o0UzLongsIeKTAMyaaEkqUuJKIuRn2uui0YmRjMIXJxIubpBO
         JvVhvqpLy+oUTFcS2Aca79mGxad3Ej6mjBwyZbCJFUFbhe5XYCO0sEsbv0wbvnmSZRjs
         WQUATAUDNY/pU9u0i6wDhiOEJyFAc6V+6dcjc1zxlyAYOsRAUb7zxKL0/EBZE9ofi55P
         Stgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SomAFJ7qnr9L26Nv065Zuy2S1du+XbrqDmOV4WPXjeU=;
        b=F15sWPQ9C2twblMM9smwDjZq3HE2caByVAgX6TM7uESBMTlvuMNgB8d9CCLIFaNyiZ
         K4KJn48WroZKlzc9jT1zyjCTJZRapqCB1ZhvIBC6vUY4opFFv70zhy3LmrWby7Yh6grP
         oIS5yj+OZyQQvAq0pILAflU8UGxxHVF78FVOAlQVVB4LlhdIA/K0CTBo4at00iTheHRI
         BoOSeh/P7YgxeIPWS0WfNpq7X+semsBqr1taWjuz/ByuXo3ssKFx9Fnu6gkqmUQEjC9w
         QdzvbmLYF8ixCvoAXgcT5tc1Xo2o9WEVqcIsIhFheKok6Ck77GJGO3I23Q/9zfNaR+8J
         WeRQ==
X-Gm-Message-State: AOAM533K8bOM5zZNIKKBFP0IQvs8VS9+bQwuhxgmeO7fuNZi0FT85NGW
        v0Px+y9YFE17b6KXl0JjSQzAAw==
X-Google-Smtp-Source: ABdhPJy3TRK4KR0kt1rJjBb5DwXLbEceU0wwDzYhwxK7dx27xGTt8DOqw7uOQuVnRHvdJjxtGtSsAQ==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr4146812wme.189.1608296619518;
        Fri, 18 Dec 2020 05:03:39 -0800 (PST)
Received: from localhost.localdomain (dh207-99-82.xnet.hr. [88.207.99.82])
        by smtp.googlemail.com with ESMTPSA id l1sm13945720wrq.64.2020.12.18.05.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 05:03:38 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH 2/3] hwmon: add Texas Instruments TPS23861 driver
Date:   Fri, 18 Dec 2020 14:03:28 +0100
Message-Id: <20201218130329.258254-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218130329.258254-1-robert.marko@sartura.hr>
References: <20201218130329.258254-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic monitoring support as well as port on/off control for Texas
Instruments TPS23861 PoE PSE IC.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 drivers/hwmon/Kconfig    |  11 ++
 drivers/hwmon/Makefile   |   1 +
 drivers/hwmon/tps23861.c | 398 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 410 insertions(+)
 create mode 100644 drivers/hwmon/tps23861.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a850e4f0e0bd..3368ecfa7a9c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1102,6 +1102,17 @@ config SENSORS_TC654
 	  This driver can also be built as a module. If so, the module
 	  will be called tc654.
 
+config SENSORS_TPS23861
+	tristate "Texas Instruments TPS23861 PoE PSE"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for Texas Instruments
+	  TPS23861 802.3at PoE PSE chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called tps23861.
+
 config SENSORS_MENF21BMC_HWMON
 	tristate "MEN 14F021P00 BMC Hardware Monitoring"
 	depends on MFD_MENF21BMC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 9db2903b61e5..7493e9d5dc43 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_MAX31790)	+= max31790.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
 obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
 obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
+obj-$(CONFIG_SENSORS_TPS23861)	+= tps23861.o
 obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
 obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
 obj-$(CONFIG_SENSORS_MR75203)	+= mr75203.o
diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
new file mode 100644
index 000000000000..e8b614267084
--- /dev/null
+++ b/drivers/hwmon/tps23861.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for the TI TPS23861 PoE PSE.
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+
+#define FW_VERSION			0x41
+#define TEMPERATURE			0x2c
+#define INPUT_VOLTAGE_LSB		0x2e
+#define INPUT_VOLTAGE_MSB		0x2f
+#define PORT_1_CURRENT_LSB		0x30
+#define PORT_1_CURRENT_MSB		0x31
+#define PORT_1_VOLTAGE_LSB		0x32
+#define PORT_1_VOLTAGE_MSB		0x33
+#define PORT_2_CURRENT_LSB		0x34
+#define PORT_2_CURRENT_MSB		0x35
+#define PORT_2_VOLTAGE_LSB		0x36
+#define PORT_2_VOLTAGE_MSB		0x37
+#define PORT_3_CURRENT_LSB		0x38
+#define PORT_3_CURRENT_MSB		0x39
+#define PORT_3_VOLTAGE_LSB		0x3a
+#define PORT_3_VOLTAGE_MSB		0x3b
+#define PORT_4_CURRENT_LSB		0x3c
+#define PORT_4_CURRENT_MSB		0x3d
+#define PORT_4_VOLTAGE_LSB		0x3e
+#define PORT_4_VOLTAGE_MSB		0x3f
+#define VOLTAGE_CURRENT_MASK		GENMASK(13, 0)
+#define PORT_1_STATUS			0x0c
+#define PORT_2_STATUS			0x0d
+#define PORT_3_STATUS			0x0e
+#define PORT_4_STATUS			0x0f
+#define PORT_STATUS_CLASS_MASK		GENMASK(7, 4)
+#define PORT_STATUS_DETECT_MASK		GENMASK(3, 0)
+#define PORT_CLASS_UNKNOWN		0
+#define PORT_CLASS_1			1
+#define PORT_CLASS_2			2
+#define PORT_CLASS_3			3
+#define PORT_CLASS_4			4
+#define PORT_CLASS_RESERVED		5
+#define PORT_CLASS_0			6
+#define PORT_CLASS_OVERCURRENT		7
+#define PORT_CLASS_MISMATCH		8
+#define PORT_DETECT_UNKNOWN		0
+#define PORT_DETECT_SHORT		1
+#define PORT_DETECT_RESERVED		2
+#define PORT_DETECT_RESISTANCE_LOW	3
+#define PORT_DETECT_RESISTANCE_OK	4
+#define PORT_DETECT_RESISTANCE_HIGH	5
+#define PORT_DETECT_OPEN_CIRCUIT	6
+#define PORT_DETECT_RESERVED_2		7
+#define PORT_DETECT_MOSFET_FAULT	8
+#define PORT_DETECT_LEGACY		9
+/* Measurment beyond clamp voltage */
+#define PORT_DETECT_CAPACITANCE_INVALID_BEYOND	10
+/* Insufficient voltage delta */
+#define PORT_DETECT_CAPACITANCE_INVALID_DELTA	11
+#define PORT_DETECT_CAPACITANCE_OUT_OF_RANGE	12
+#define POE_PLUS				0x40
+
+#define DETECT_CLASS_RESTART		0x18
+#define POWER_ENABLE			0x19
+
+#define TEMPERATURE_LSB			652 /* 0.652 degrees Celsius */
+#define VOLTAGE_LSB			3662 /* 3.662 mV */
+#define SHUNT_RESISTOR_DEFAULT		255000 /* 255 mOhm */
+#define CURRENT_LSB_255			62260 /* 62.260 uA */
+#define CURRENT_LSB_250			61039 /* 61.039 uA */
+
+struct tps23861_data {
+	struct regmap *regmap;
+	u32 shunt_resistor;
+};
+
+static struct regmap_config tps23861_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static ssize_t tps23861_simple_value_show(struct device *dev,
+				 struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct tps23861_data *data = dev_get_drvdata(dev);
+	unsigned int regval;
+
+	regmap_read(data->regmap, attr->index, &regval);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", regval);
+}
+
+static ssize_t tps23861_temperature_show(struct device *dev,
+				 struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct tps23861_data *data = dev_get_drvdata(dev);
+	unsigned int regval;
+	int temperature;
+
+	regmap_read(data->regmap, attr->index, &regval);
+
+	temperature = (regval * TEMPERATURE_LSB) - 20000;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", temperature);
+}
+
+static ssize_t tps23861_voltage_show(struct device *dev,
+				 struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct tps23861_data *data = dev_get_drvdata(dev);
+	u16 regval;
+	unsigned int voltage;
+
+	regmap_bulk_read(data->regmap, attr->index, &regval, 2);
+
+	voltage = (FIELD_GET(VOLTAGE_CURRENT_MASK, regval) * VOLTAGE_LSB) / 1000;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", voltage);
+}
+
+static ssize_t tps23861_current_show(struct device *dev,
+				 struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct tps23861_data *data = dev_get_drvdata(dev);
+	u16 regval;
+	unsigned int current_mA;
+	unsigned int current_lsb;
+
+	if (data->shunt_resistor == SHUNT_RESISTOR_DEFAULT)
+		current_lsb = CURRENT_LSB_255;
+	else
+		current_lsb = CURRENT_LSB_250;
+
+	regmap_bulk_read(data->regmap, attr->index, &regval, 2);
+
+	current_mA = (FIELD_GET(VOLTAGE_CURRENT_MASK, regval) * current_lsb) / 1000000;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", current_mA);
+}
+
+static ssize_t tps23861_port_status_show(struct device *dev,
+				 struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct tps23861_data *data = dev_get_drvdata(dev);
+	char *detect_status, *class_status;
+	unsigned int regval;
+	u8 class, detect;
+
+	regmap_read(data->regmap, attr->index, &regval);
+	detect = FIELD_GET(PORT_STATUS_DETECT_MASK, regval);
+	class = FIELD_GET(PORT_STATUS_CLASS_MASK, regval);
+
+	switch (detect) {
+	case PORT_DETECT_UNKNOWN:
+		detect_status = "Unknown device";
+		break;
+	case PORT_DETECT_SHORT:
+		detect_status = "Short circuit detected";
+		break;
+	case PORT_DETECT_RESISTANCE_LOW:
+		detect_status = "Too low resistance detected";
+		break;
+	case PORT_DETECT_RESISTANCE_OK:
+		detect_status = "Valid resistance detected";
+		break;
+	case PORT_DETECT_RESISTANCE_HIGH:
+		detect_status = "Too high resistance detected";
+		break;
+	case PORT_DETECT_OPEN_CIRCUIT:
+		detect_status = "Open circuit detected";
+		break;
+	case PORT_DETECT_MOSFET_FAULT:
+		detect_status = "MOSFET fault detected";
+		break;
+	case PORT_DETECT_LEGACY:
+		detect_status = "Legacy device detected";
+		break;
+	case PORT_DETECT_CAPACITANCE_INVALID_BEYOND:
+		detect_status = "Invalid capacitance, beyond clamp voltage";
+		break;
+	case PORT_DETECT_CAPACITANCE_INVALID_DELTA:
+		detect_status = "Invalid capacitance, insufficient voltage delta";
+		break;
+	case PORT_DETECT_CAPACITANCE_OUT_OF_RANGE:
+		detect_status = "Valid capacitance, outside of legacy range";
+		break;
+	case PORT_DETECT_RESERVED:
+	case PORT_DETECT_RESERVED_2:
+	default:
+		return -EINVAL;
+	}
+
+	switch (class) {
+	case PORT_CLASS_UNKNOWN:
+		class_status = "Unknown class";
+		break;
+	case PORT_CLASS_RESERVED:
+	case PORT_CLASS_0:
+		class_status = "Class 0";
+		break;
+	case PORT_CLASS_1:
+		class_status = "Class 1";
+		break;
+	case PORT_CLASS_2:
+		class_status = "Class 2";
+		break;
+	case PORT_CLASS_3:
+		class_status = "Class 3";
+		break;
+	case PORT_CLASS_4:
+		class_status = "Class 4";
+		break;
+	case PORT_CLASS_OVERCURRENT:
+		class_status = "Overcurrent";
+		break;
+	case PORT_CLASS_MISMATCH:
+		class_status = "Class mismatch";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%s, %s\n", detect_status, class_status);
+}
+
+static ssize_t tps23861_poe_plus_show(struct device *dev,
+				 struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct tps23861_data *data = dev_get_drvdata(dev);
+	char *ports[4];
+	unsigned int regval;
+	int i;
+
+	regmap_read(data->regmap, attr->index, &regval);
+
+	for (i = 0; i < 4; i++) {
+		if (BIT(i + 4) & regval)
+			ports[i] = "Yes";
+		else
+			ports[i] = "No";
+	}
+
+	return snprintf(buf, PAGE_SIZE, "Port 1: %s\nPort 2: %s\nPort 3: %s\nPort 4: %s\n",
+		ports[0], ports[1], ports[2], ports[3]);
+}
+
+static ssize_t tps23861_port_disable_store(struct device *dev,
+				  struct device_attribute *da,
+				  const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct tps23861_data *data = dev_get_drvdata(dev);
+	unsigned int regval, port;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &port);
+	if (ret < 0)
+		return ret;
+
+	regmap_read(data->regmap, attr->index, &regval);
+	regval |= BIT(port + 3);
+	regmap_write(data->regmap, attr->index, regval);
+
+	return count;
+}
+
+static ssize_t tps23861_port_enable_store(struct device *dev,
+				  struct device_attribute *da,
+				  const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct tps23861_data *data = dev_get_drvdata(dev);
+	unsigned int regval, port;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &port);
+	if (ret < 0)
+		return ret;
+
+	regmap_read(data->regmap, attr->index, &regval);
+	regval |= BIT(port - 1);
+	regval |= BIT(port + 3);
+	regmap_write(data->regmap, attr->index, regval);
+
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR_RO(fw_ver, tps23861_simple_value, FW_VERSION);
+static SENSOR_DEVICE_ATTR_RO(temperature, tps23861_temperature, TEMPERATURE);
+static SENSOR_DEVICE_ATTR_RO(in_voltage, tps23861_voltage, INPUT_VOLTAGE_LSB);
+static SENSOR_DEVICE_ATTR_RO(port1_current, tps23861_current, PORT_1_CURRENT_LSB);
+static SENSOR_DEVICE_ATTR_RO(port1_voltage, tps23861_voltage, PORT_1_VOLTAGE_LSB);
+static SENSOR_DEVICE_ATTR_RO(port1_status, tps23861_port_status, PORT_1_STATUS);
+static SENSOR_DEVICE_ATTR_RO(port2_current, tps23861_current, PORT_2_CURRENT_LSB);
+static SENSOR_DEVICE_ATTR_RO(port2_voltage, tps23861_voltage, PORT_2_VOLTAGE_LSB);
+static SENSOR_DEVICE_ATTR_RO(port2_status, tps23861_port_status, PORT_2_STATUS);
+static SENSOR_DEVICE_ATTR_RO(port3_current, tps23861_current, PORT_3_CURRENT_LSB);
+static SENSOR_DEVICE_ATTR_RO(port3_voltage, tps23861_voltage, PORT_3_VOLTAGE_LSB);
+static SENSOR_DEVICE_ATTR_RO(port3_status, tps23861_port_status, PORT_3_STATUS);
+static SENSOR_DEVICE_ATTR_RO(port4_current, tps23861_current, PORT_4_CURRENT_LSB);
+static SENSOR_DEVICE_ATTR_RO(port4_voltage, tps23861_voltage, PORT_4_VOLTAGE_LSB);
+static SENSOR_DEVICE_ATTR_RO(port4_status, tps23861_port_status, PORT_4_STATUS);
+static SENSOR_DEVICE_ATTR_RO(poe_plus_status, tps23861_poe_plus, POE_PLUS);
+static SENSOR_DEVICE_ATTR_WO(port_disable, tps23861_port_disable, POWER_ENABLE);
+static SENSOR_DEVICE_ATTR_WO(port_enable, tps23861_port_enable, DETECT_CLASS_RESTART);
+
+static struct attribute *tps23861_attrs[] = {
+	&sensor_dev_attr_fw_ver.dev_attr.attr,
+	&sensor_dev_attr_temperature.dev_attr.attr,
+	&sensor_dev_attr_in_voltage.dev_attr.attr,
+	&sensor_dev_attr_port1_current.dev_attr.attr,
+	&sensor_dev_attr_port1_voltage.dev_attr.attr,
+	&sensor_dev_attr_port1_status.dev_attr.attr,
+	&sensor_dev_attr_port2_current.dev_attr.attr,
+	&sensor_dev_attr_port2_voltage.dev_attr.attr,
+	&sensor_dev_attr_port2_status.dev_attr.attr,
+	&sensor_dev_attr_port3_current.dev_attr.attr,
+	&sensor_dev_attr_port3_voltage.dev_attr.attr,
+	&sensor_dev_attr_port3_status.dev_attr.attr,
+	&sensor_dev_attr_port4_current.dev_attr.attr,
+	&sensor_dev_attr_port4_voltage.dev_attr.attr,
+	&sensor_dev_attr_port4_status.dev_attr.attr,
+	&sensor_dev_attr_poe_plus_status.dev_attr.attr,
+	&sensor_dev_attr_port_disable.dev_attr.attr,
+	&sensor_dev_attr_port_enable.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group tps23861_group = {
+	.attrs = tps23861_attrs,
+};
+
+static const struct attribute_group *tps23861_groups[] = {
+	&tps23861_group,
+	NULL,
+};
+
+static int tps23861_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct tps23861_data *data;
+	struct device *hwmon_dev;
+	u32 shunt_resistor;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->regmap = devm_regmap_init_i2c(client, &tps23861_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(dev, "failed to allocate register map\n");
+		return PTR_ERR(data->regmap);
+	}
+
+	if (of_property_read_u32(dev->of_node, "shunt-resistor-micro-ohms", &shunt_resistor) < 0)
+		data->shunt_resistor = shunt_resistor;
+	else
+		data->shunt_resistor = SHUNT_RESISTOR_DEFAULT;
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, tps23861_groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused tps23861_of_match[] = {
+	{ .compatible = "ti,tps23861", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tps23861_of_match);
+
+static struct i2c_driver tps23861_driver = {
+	.probe_new		= tps23861_probe,
+	.driver = {
+		.name		= "tps23861",
+		.of_match_table	= of_match_ptr(tps23861_of_match),
+	},
+};
+module_i2c_driver(tps23861_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
+MODULE_DESCRIPTION("TI TPS23861 PoE PSE");
-- 
2.29.2

