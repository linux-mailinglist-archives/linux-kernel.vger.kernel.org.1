Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886DE2CC2DC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgLBQ5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730530AbgLBQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:57:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B025DC061A04
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:56:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h9so2575129ybj.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mJk6kczH3IFjn8UtvUiR0lTnqxxfMkh/xoOMh1jAkBY=;
        b=ky0GjTzcVFN6FxefyzNVCrmBRIQTHIM/lgfC94PaWMFu3hw1hnjzn5Y2/lT5p/WNuU
         wlLHWXsjiVqewraHYpOYdXwUHZH3Voewbjqlt+VvFC+5cEFLI9im9whlWoo2WmfucpvY
         7JNStq52ecpLKorlE3ooruyKXpBURwRZB7+hlnJm2cmjeRc/L/WRd2sFZ+2nHonCtg1X
         has6izFrWD38DPTHUhd6Ap5eqjt5ADGU1axyBdUfqVw3aU+Jgw5FESM2cgeQDKtmwHLa
         GiMJUDcT84DqqMjzZ2nk4JKHd30SPPmyLKfndaOmPzNavFJzVwLkSDN7rQYQvwdnFcq4
         S2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mJk6kczH3IFjn8UtvUiR0lTnqxxfMkh/xoOMh1jAkBY=;
        b=ZhLBDX7fWZVfWSvZvlQx5W6XovM4OsWaxSNkRXrw6/sMDDUVZA8++XrJ6RFbu/3rQZ
         GVXsGFhuJtEEyv24M4hK+neyXQZrGwGbInureae5xtoCcTmRWn1/ZbHlbEBK+Id79c10
         j1loogbkHDAng+u1R9ux1SzdT/6i7imB5QWQm1UxMz/Wm63fq3/HxEizBErd8RMbW7I9
         eBTE7tPs7dHyKsTTUQCLXrqIV+b7r5RN45ZdsKD/qffZkTDxw2Q/3RYoce6VRFK15Roc
         Mq2K5xhGz+g4lyEu7NC86blRgOom+HFklNFTztppcEkneHYiGgEC1f4+BGxxYLI0Ez2Q
         fS7g==
X-Gm-Message-State: AOAM530aoyTbeYamzCfee78/k9E6B9FwlliN/3KdxH9UWB3SWbxS2JYw
        rCUPSUWwzH9vOk/YwcjibRxlq1xPWQ==
X-Google-Smtp-Source: ABdhPJxUKEjcslen8fznBz9gFnyC8xw2BZX0tCmGjXFZ6JbvpdbKRFGxnk1bAMt25dt/HHpv93QVtu55GQ==
Sender: "kunyi via sendgmr" <kunyi@kunyi0.svl.corp.google.com>
X-Received: from kunyi0.svl.corp.google.com ([2620:15c:2c5:3:9657:a5ff:fef2:53bd])
 (user=kunyi job=sendgmr) by 2002:a25:aea0:: with SMTP id b32mr5325273ybj.282.1606928177761;
 Wed, 02 Dec 2020 08:56:17 -0800 (PST)
Date:   Wed,  2 Dec 2020 08:55:59 -0800
In-Reply-To: <20201202165601.1532213-1-kunyi@google.com>
Message-Id: <20201202165601.1532213-2-kunyi@google.com>
Mime-Version: 1.0
References: <20201202165601.1532213-1-kunyi@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH linux hwmon-next v4 1/3] hwmon: (sbtsi) Add basic support for
 SB-TSI sensors
From:   Kun Yi <kunyi@google.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, supreeth.venkatesh@amd.com
Cc:     Kun Yi <kunyi@google.com>, openbmc@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SB Temperature Sensor Interface (SB-TSI) is an SMBus compatible
interface that reports AMD SoC's Ttcl (normalized temperature),
and resembles a typical 8-pin remote temperature sensor's I2C interface
to BMC.

This commit adds basic support using this interface to read CPU
temperature, and read/write high/low CPU temp thresholds.

To instantiate this driver on an AMD CPU with SB-TSI
support, the i2c bus number would be the bus connected from the board
management controller (BMC) to the CPU. The i2c address is specified in
Section 6.3.1 of the spec [1]: The SB-TSI address is normally 98h for
socket 0 and 90h for socket 1, but it could vary based on hardware address
select pins.

[1]: https://www.amd.com/system/files/TechDocs/56255_OSRR.pdf

Test status: tested reading temp1_input, and reading/writing
temp1_max/min.

Signed-off-by: Kun Yi <kunyi@google.com>
---
 drivers/hwmon/Kconfig      |  10 ++
 drivers/hwmon/Makefile     |   1 +
 drivers/hwmon/sbtsi_temp.c | 265 +++++++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 drivers/hwmon/sbtsi_temp.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 3c059fc23cd6..3d6a809700ae 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1522,6 +1522,16 @@ config SENSORS_SL28CPLD
 	  This driver can also be built as a module.  If so, the module
 	  will be called sl28cpld-hwmon.
 
+config SENSORS_SBTSI
+	tristate "Emulated SB-TSI temperature sensor"
+	depends on I2C
+	help
+	  If you say yes here you get support for emulated temperature
+	  sensors on AMD SoCs with SB-TSI interface connected to a BMC device.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called sbtsi_temp.
+
 config SENSORS_SHT15
 	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 01ca5d3fbad4..ee8c037919da 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -160,6 +160,7 @@ obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
 obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
 obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
 obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
+obj-$(CONFIG_SENSORS_SBTSI)	+= sbtsi_temp.o
 obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
 obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
 obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
new file mode 100644
index 000000000000..6b0a7b9df1f3
--- /dev/null
+++ b/drivers/hwmon/sbtsi_temp.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * sbtsi_temp.c - hwmon driver for a SBI Temperature Sensor Interface (SB-TSI)
+ *                compliant AMD SoC temperature device.
+ *
+ * Copyright (c) 2020, Google Inc.
+ * Copyright (c) 2020, Kun Yi <kunyi@google.com>
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+
+/*
+ * SB-TSI registers only support SMBus byte data access. "_INT" registers are
+ * the integer part of a temperature value or limit, and "_DEC" registers are
+ * corresponding decimal parts.
+ */
+#define SBTSI_REG_TEMP_INT		0x01 /* RO */
+#define SBTSI_REG_STATUS		0x02 /* RO */
+#define SBTSI_REG_CONFIG		0x03 /* RO */
+#define SBTSI_REG_TEMP_HIGH_INT		0x07 /* RW */
+#define SBTSI_REG_TEMP_LOW_INT		0x08 /* RW */
+#define SBTSI_REG_TEMP_DEC		0x10 /* RW */
+#define SBTSI_REG_TEMP_HIGH_DEC		0x13 /* RW */
+#define SBTSI_REG_TEMP_LOW_DEC		0x14 /* RW */
+
+#define SBTSI_CONFIG_READ_ORDER_SHIFT	5
+
+#define SBTSI_TEMP_MIN	0
+#define SBTSI_TEMP_MAX	255875
+
+/* Each client has this additional data */
+struct sbtsi_data {
+	struct i2c_client *client;
+	struct mutex lock;
+};
+
+/*
+ * From SB-TSI spec: CPU temperature readings and limit registers encode the
+ * temperature in increments of 0.125 from 0 to 255.875. The "high byte"
+ * register encodes the base-2 of the integer portion, and the upper 3 bits of
+ * the "low byte" encode in base-2 the decimal portion.
+ *
+ * e.g. INT=0x19, DEC=0x20 represents 25.125 degrees Celsius
+ *
+ * Therefore temperature in millidegree Celsius =
+ *   (INT + DEC / 256) * 1000 = (INT * 8 + DEC / 32) * 125
+ */
+static inline int sbtsi_reg_to_mc(s32 integer, s32 decimal)
+{
+	return ((integer << 3) + (decimal >> 5)) * 125;
+}
+
+/*
+ * Inversely, given temperature in millidegree Celsius
+ *   INT = (TEMP / 125) / 8
+ *   DEC = ((TEMP / 125) % 8) * 32
+ * Caller have to make sure temp doesn't exceed 255875, the max valid value.
+ */
+static inline void sbtsi_mc_to_reg(s32 temp, u8 *integer, u8 *decimal)
+{
+	temp /= 125;
+	*integer = temp >> 3;
+	*decimal = (temp & 0x7) << 5;
+}
+
+static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
+		      u32 attr, int channel, long *val)
+{
+	struct sbtsi_data *data = dev_get_drvdata(dev);
+	s32 temp_int, temp_dec;
+	int err, reg_int, reg_dec;
+	bool reading_input;
+
+	if (type != hwmon_temp)
+		return -EINVAL;
+
+	reading_input = false;
+	switch (attr) {
+	case hwmon_temp_input:
+		reading_input = true;
+		/*
+		 * ReadOrder bit specifies the reading order of integer and
+		 * decimal part of CPU temp for atomic reads. If bit == 0,
+		 * reading integer part triggers latching of the decimal part,
+		 * so integer part should be read first. If bit == 1, read
+		 * order should be reversed.
+		 */
+		err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
+		if (err < 0)
+			return err;
+
+		mutex_lock(&data->lock);
+		if (err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
+			temp_dec = i2c_smbus_read_byte_data(data->client,
+							    SBTSI_REG_TEMP_DEC);
+			temp_int = i2c_smbus_read_byte_data(data->client,
+							    SBTSI_REG_TEMP_INT);
+		} else {
+			temp_int = i2c_smbus_read_byte_data(data->client,
+							    SBTSI_REG_TEMP_INT);
+			temp_dec = i2c_smbus_read_byte_data(data->client,
+							    SBTSI_REG_TEMP_DEC);
+		}
+		mutex_unlock(&data->lock);
+		break;
+	case hwmon_temp_max:
+		reg_int = SBTSI_REG_TEMP_HIGH_INT;
+		reg_dec = SBTSI_REG_TEMP_HIGH_DEC;
+		break;
+	case hwmon_temp_min:
+		reg_int = SBTSI_REG_TEMP_LOW_INT;
+		reg_dec = SBTSI_REG_TEMP_LOW_DEC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!reading_input) {
+		temp_int = i2c_smbus_read_byte_data(data->client, reg_int);
+		temp_dec = i2c_smbus_read_byte_data(data->client, reg_dec);
+	}
+
+	if (temp_int < 0)
+		return temp_int;
+	if (temp_dec < 0)
+		return temp_dec;
+
+	*val = sbtsi_reg_to_mc(temp_int, temp_dec);
+
+	return 0;
+}
+
+static int sbtsi_write(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long val)
+{
+	struct sbtsi_data *data = dev_get_drvdata(dev);
+	int reg_int, reg_dec, err;
+	u8 temp_int, temp_dec;
+
+	if (type != hwmon_temp)
+		return -EINVAL;
+
+	switch (attr) {
+	case hwmon_temp_max:
+		reg_int = SBTSI_REG_TEMP_HIGH_INT;
+		reg_dec = SBTSI_REG_TEMP_HIGH_DEC;
+		break;
+	case hwmon_temp_min:
+		reg_int = SBTSI_REG_TEMP_LOW_INT;
+		reg_dec = SBTSI_REG_TEMP_LOW_DEC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val = clamp_val(val, SBTSI_TEMP_MIN, SBTSI_TEMP_MAX);
+	mutex_lock(&data->lock);
+	sbtsi_mc_to_reg(val, &temp_int, &temp_dec);
+	err = i2c_smbus_write_byte_data(data->client, reg_int, temp_int);
+	if (err)
+		goto exit;
+
+	err = i2c_smbus_write_byte_data(data->client, reg_dec, temp_dec);
+exit:
+	mutex_unlock(&data->lock);
+	return err;
+}
+
+static umode_t sbtsi_is_visible(const void *data,
+				enum hwmon_sensor_types type,
+				u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			return 0444;
+		case hwmon_temp_min:
+			return 0644;
+		case hwmon_temp_max:
+			return 0644;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct hwmon_channel_info *sbtsi_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX),
+	NULL
+};
+
+static const struct hwmon_ops sbtsi_hwmon_ops = {
+	.is_visible = sbtsi_is_visible,
+	.read = sbtsi_read,
+	.write = sbtsi_write,
+};
+
+static const struct hwmon_chip_info sbtsi_chip_info = {
+	.ops = &sbtsi_hwmon_ops,
+	.info = sbtsi_info,
+};
+
+static int sbtsi_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
+	struct sbtsi_data *data;
+
+	data = devm_kzalloc(dev, sizeof(struct sbtsi_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	mutex_init(&data->lock);
+
+	hwmon_dev =
+		devm_hwmon_device_register_with_info(dev, client->name, data,
+						     &sbtsi_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id sbtsi_id[] = {
+	{"sbtsi", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, sbtsi_id);
+
+static const struct of_device_id __maybe_unused sbtsi_of_match[] = {
+	{
+		.compatible = "amd,sbtsi",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sbtsi_of_match);
+
+static struct i2c_driver sbtsi_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "sbtsi",
+		.of_match_table = of_match_ptr(sbtsi_of_match),
+	},
+	.probe = sbtsi_probe,
+	.id_table = sbtsi_id,
+};
+
+module_i2c_driver(sbtsi_driver);
+
+MODULE_AUTHOR("Kun Yi <kunyi@google.com>");
+MODULE_DESCRIPTION("Hwmon driver for AMD SB-TSI emulated sensor");
+MODULE_LICENSE("GPL");
-- 
2.29.2.454.gaff20da3a2-goog

