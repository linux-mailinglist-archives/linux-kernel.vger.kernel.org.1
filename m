Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0D42CB754
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgLBIgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:36:47 -0500
Received: from m15113.mail.126.com ([220.181.15.113]:37713 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgLBIgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mIWMX
        k6bAr5ed3mL3HtP2Df+7zDxqBKkwm+TGBglJBc=; b=NcxeDDeAZ9sa9XTtUFtCQ
        4OUdzJc7BjetT027tP9SuyHv9cUb90QyHh6NV4AFEfKbPMGaAsOvjM5hOVfhlnFb
        hVgjyyoDYIuIoaXGLcfsA1VDwl33nQhZQMnpwd7kmiCYCBjpRxySQC0PCRXdFw13
        8m43OHMAc9Nq4gbvF3cUdY=
Received: from localhost (unknown [117.136.120.74])
        by smtp3 (Coremail) with SMTP id DcmowAD36fz3Asdfg0jKMA--.20989S2;
        Wed, 02 Dec 2020 10:59:04 +0800 (CST)
From:   "xiao.ma" <max701@126.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiao.mx.ma@deltaww.com,
        jiajia.feng@deltaww.com
Subject: [PATCH v10] hwmon:Driver for Delta power supplies Q54SJ108A2
Date:   Tue,  1 Dec 2020 16:59:00 -1000
Message-Id: <20201202025900.1842-1-max701@126.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowAD36fz3Asdfg0jKMA--.20989S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfJF13Zry3Xr4DKw1kKrW8Crg_yoW8Aw43Zo
        WUKFWru3WDJr13CrW8GF1xtFyUWr4DGrZ7Ar15KrZIkasIkF1rWF15tw1YgwnxX3y5WFW3
        Zry5Jwn8taySy3W7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwxRDDUUUU
X-Originating-IP: [117.136.120.74]
X-CM-SenderInfo: ppd0liar6rjloofrz/1tbi5RjuOFpD6Kt+uQAAs2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xiao.ma" <xiao.mx.ma@deltaww.com>

The driver supports Q54SJ108A2 series modules of Delta.
Standard attributes are in sysfs, and other attributes are in debugfs.

Signed-off-by: xiao.ma <xiao.mx.ma@deltaww.com>
---

Notes:
    Patch v2 changelog:
    	Add delta.rst in Documentation/hwmon.
    	Tristate "DELTA" in Kconfig is changed to "DELTA_POWER_SUPPLIED".
    	Modify code: drop the excessive empty lines, correct the comment content, adjust indent, remove extra brackets.
    Patch v3 changelog:
    	Add delta.rst to Documentation/hwmon/index.rst.
    	Tristate "DELTA_POWER_SUPPLIES" in Kconfig is changed to "Delta Power Supplies".
    Patch v4 changelog:
    	Correct the spelling "Temperature" in the delta.rst.
    	Add Write_protect when write command VOUT_OV_RESPONSE and IOUT_OC_FAULT_RESPONSE.
    Patch v5 changelog:
    	Add some non-standard attributes in sysfs system.
    Patch v6 changelog:
    	delta.c and delta.rst are renamed to q54sj108a2.c and q54sj108a2.rst.
    	Add q54sj108a2 to index.rst.
    	Tristate in Kconfig is changed to "Delta Power Supplies Q54SJ108A2".
    	The non-standard attributes are added to debugfs.
    Patch v7 changelog:
    	Use standard fuctions bin2hex and hex2bin.
    	The return of debugfs write is changed to count.
    	Drop the error checking of debugfs fuctions.
    	Use probe_new fuction.
    	Remove the .remove fuction.
    Patch v8 changelog:
    	Use kstrtou8_from_user instead of hex2bin.
    	Remove included head files which are not used.
    	Done label in debugfs_read fuction is deleted.
    	Change email to send the patch.
    Patch v9 changelog:
    	Fix the compile errors and warnings.
    Patch v10 changelog:
    	Fix the reports from checkpatch.
    	Name of driver is changed to "q54sj108a2".

 Documentation/hwmon/index.rst      |   1 +
 Documentation/hwmon/q54sj108a2.rst |  54 ++++
 drivers/hwmon/pmbus/Kconfig        |   9 +
 drivers/hwmon/pmbus/Makefile       |   1 +
 drivers/hwmon/pmbus/q54sj108a2.c   | 422 +++++++++++++++++++++++++++++
 5 files changed, 487 insertions(+)
 create mode 100644 Documentation/hwmon/q54sj108a2.rst
 create mode 100644 drivers/hwmon/pmbus/q54sj108a2.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index b797db738225..4bb680b3c7ea 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -148,6 +148,7 @@ Hardware Monitoring Kernel Drivers
    powr1220
    pxe1610
    pwm-fan
+   q54sj108a2
    raspberrypi-hwmon
    sch5627
    sch5636
diff --git a/Documentation/hwmon/q54sj108a2.rst b/Documentation/hwmon/q54sj108a2.rst
new file mode 100644
index 000000000000..fabce671985a
--- /dev/null
+++ b/Documentation/hwmon/q54sj108a2.rst
@@ -0,0 +1,54 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver q54sj108a2
+=====================
+
+Supported chips:
+
+  * DELTA Q54SJ108A2NCAH, Q54SJ108A2NCDH, Q54SJ108A2NCPG, Q54SJ108A2NCPH
+
+    Prefix: 'Q54SJ108A2'
+
+    Addresses scanned: -
+
+    Datasheet: https://filecenter.delta-china.com.cn/products/download/01/0102/datasheet/DS_Q54SJ108A2.pdf
+
+Authors:
+    Xiao.ma <xiao.mx.ma@deltaww.com>
+
+
+Description
+-----------
+
+This driver implements support for DELTA Q54SJ108A2NCAH, Q54SJ108A2NCDH,
+Q54SJ108A2NCPG, and Q54SJ108A2NCPH 1/4 Brick DC/DC Regulated Power Module
+with PMBus support.
+
+The driver is a client driver to the core PMBus driver.
+Please see Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
+details.
+
+
+Sysfs entries
+-------------
+
+===================== ===== ==================================================
+curr1_alarm           RO    Output current alarm
+curr1_input           RO    Output current
+curr1_label           RO    'iout1'
+in1_alarm             RO    Input voltage alarm
+in1_input             RO    Input voltage
+in1_label             RO    'vin'
+in2_alarm             RO    Output voltage alarm
+in2_input             RO    Output voltage
+in2_label             RO    'vout1'
+temp1_alarm           RO    Temperature alarm
+temp1_input           RO    Chip temperature
+===================== ===== ==================================================
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index a25faf69fce3..01de280820ee 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -229,6 +229,15 @@ config SENSORS_PXE1610
 	  This driver can also be built as a module. If so, the module will
 	  be called pxe1610.
 
+config SENSORS_Q54SJ108A2
+	tristate "Delta Power Supplies Q54SJ108A2"
+	help
+	  If you say yes here you get hardware monitoring support for Delta
+	  Q54SJ108A2 series Power Supplies.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called q54sj108a2.
+
 config SENSORS_TPS40422
 	tristate "TI TPS40422"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 4c97ad0bd791..a50122cd455b 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
+obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
 obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
 obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
 obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
new file mode 100644
index 000000000000..cbeb1b1ea60c
--- /dev/null
+++ b/drivers/hwmon/pmbus/q54sj108a2.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Delta modules, Q54SJ108A2 series 1/4 Brick DC/DC
+ * Regulated Power Module
+ *
+ * Copyright 2020 Delta LLC.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include "pmbus.h"
+
+#define STORE_DEFAULT_ALL         0x11
+#define ERASE_BLACKBOX_DATA       0xD1
+#define READ_HISTORY_EVENT_NUMBER 0xD2
+#define READ_HISTORY_EVENTS       0xE0
+#define SET_HISTORY_EVENT_OFFSET  0xE1
+#define PMBUS_FLASH_KEY_WRITE     0xEC
+
+enum chips {
+	q54sj108a2
+};
+
+enum {
+	Q54SJ108A2_DEBUGFS_OPERATION = 0,
+	Q54SJ108A2_DEBUGFS_CLEARFAULT,
+	Q54SJ108A2_DEBUGFS_WRITEPROTECT,
+	Q54SJ108A2_DEBUGFS_STOREDEFAULT,
+	Q54SJ108A2_DEBUGFS_VOOV_RESPONSE,
+	Q54SJ108A2_DEBUGFS_IOOC_RESPONSE,
+	Q54SJ108A2_DEBUGFS_PMBUS_VERSION,
+	Q54SJ108A2_DEBUGFS_MFR_ID,
+	Q54SJ108A2_DEBUGFS_MFR_MODEL,
+	Q54SJ108A2_DEBUGFS_MFR_REVISION,
+	Q54SJ108A2_DEBUGFS_MFR_LOCATION,
+	Q54SJ108A2_DEBUGFS_BLACKBOX_ERASE,
+	Q54SJ108A2_DEBUGFS_BLACKBOX_READ_OFFSET,
+	Q54SJ108A2_DEBUGFS_BLACKBOX_SET_OFFSET,
+	Q54SJ108A2_DEBUGFS_BLACKBOX_READ,
+	Q54SJ108A2_DEBUGFS_FLASH_KEY,
+	Q54SJ108A2_DEBUGFS_NUM_ENTRIES
+};
+
+struct q54sj108a2_data {
+	enum chips chip;
+	struct i2c_client *client;
+
+	int debugfs_entries[Q54SJ108A2_DEBUGFS_NUM_ENTRIES];
+};
+
+#define to_psu(x, y) container_of((x), struct q54sj108a2_data, debugfs_entries[(y)])
+
+static struct pmbus_driver_info q54sj108a2_info[] = {
+	[q54sj108a2] = {
+		.pages = 1,
+
+		/* Source : Delta Q54SJ108A2 */
+		.format[PSC_TEMPERATURE] = linear,
+		.format[PSC_VOLTAGE_IN] = linear,
+		.format[PSC_CURRENT_OUT] = linear,
+
+		.func[0] = PMBUS_HAVE_VIN |
+		PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+		PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP |
+		PMBUS_HAVE_STATUS_INPUT,
+	},
+};
+
+static ssize_t  q54sj108a2_debugfs_read(struct file *file, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	int rc;
+	int *idxp = file->private_data;
+	int idx = *idxp;
+	struct q54sj108a2_data *psu = to_psu(idxp, idx);
+	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
+	char data_char[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
+	char *res;
+
+	switch (idx) {
+	case Q54SJ108A2_DEBUGFS_OPERATION:
+		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_OPERATION);
+		if (rc < 0)
+			return rc;
+
+		rc = snprintf(data, 3, "%02x", rc);
+		break;
+	case Q54SJ108A2_DEBUGFS_WRITEPROTECT:
+		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_WRITE_PROTECT);
+		if (rc < 0)
+			return rc;
+
+		rc = snprintf(data, 3, "%02x", rc);
+		break;
+	case Q54SJ108A2_DEBUGFS_VOOV_RESPONSE:
+		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_VOUT_OV_FAULT_RESPONSE);
+		if (rc < 0)
+			return rc;
+
+		rc = snprintf(data, 3, "%02x", rc);
+		break;
+	case Q54SJ108A2_DEBUGFS_IOOC_RESPONSE:
+		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_IOUT_OC_FAULT_RESPONSE);
+		if (rc < 0)
+			return rc;
+
+		rc = snprintf(data, 3, "%02x", rc);
+		break;
+	case Q54SJ108A2_DEBUGFS_PMBUS_VERSION:
+		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_REVISION);
+		if (rc < 0)
+			return rc;
+
+		rc = snprintf(data, 3, "%02x", rc);
+		break;
+	case Q54SJ108A2_DEBUGFS_MFR_ID:
+		rc = i2c_smbus_read_block_data(psu->client, PMBUS_MFR_ID, data);
+		if (rc < 0)
+			return rc;
+		break;
+	case Q54SJ108A2_DEBUGFS_MFR_MODEL:
+		rc = i2c_smbus_read_block_data(psu->client, PMBUS_MFR_MODEL, data);
+		if (rc < 0)
+			return rc;
+		break;
+	case Q54SJ108A2_DEBUGFS_MFR_REVISION:
+		rc = i2c_smbus_read_block_data(psu->client, PMBUS_MFR_REVISION, data);
+		if (rc < 0)
+			return rc;
+		break;
+	case Q54SJ108A2_DEBUGFS_MFR_LOCATION:
+		rc = i2c_smbus_read_block_data(psu->client, PMBUS_MFR_LOCATION, data);
+		if (rc < 0)
+			return rc;
+		break;
+	case Q54SJ108A2_DEBUGFS_BLACKBOX_READ_OFFSET:
+		rc = i2c_smbus_read_byte_data(psu->client, READ_HISTORY_EVENT_NUMBER);
+		if (rc < 0)
+			return rc;
+
+		rc = snprintf(data, 3, "%02x", rc);
+		break;
+	case Q54SJ108A2_DEBUGFS_BLACKBOX_READ:
+		rc = i2c_smbus_read_block_data(psu->client, READ_HISTORY_EVENTS, data);
+		if (rc < 0)
+			return rc;
+
+		res = bin2hex(data, data_char, 32);
+		rc = res - data;
+
+		break;
+	case Q54SJ108A2_DEBUGFS_FLASH_KEY:
+		rc = i2c_smbus_read_block_data(psu->client, PMBUS_FLASH_KEY_WRITE, data);
+		if (rc < 0)
+			return rc;
+
+		res = bin2hex(data, data_char, 4);
+		rc = res - data;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	data[rc] = '\n';
+	rc += 2;
+
+	return simple_read_from_buffer(buf, count, ppos, data, rc);
+}
+
+static ssize_t q54sj108a2_debugfs_write(struct file *file, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	u8 flash_key[4];
+	u8 dst_data;
+	ssize_t rc;
+	int *idxp = file->private_data;
+	int idx = *idxp;
+	struct q54sj108a2_data *psu = to_psu(idxp, idx);
+
+	rc = i2c_smbus_write_byte_data(psu->client, PMBUS_WRITE_PROTECT, 0);
+	if (rc)
+		return rc;
+
+	switch (idx) {
+	case Q54SJ108A2_DEBUGFS_OPERATION:
+		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
+		if (rc < 0)
+			return rc;
+
+		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_OPERATION, dst_data);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case Q54SJ108A2_DEBUGFS_CLEARFAULT:
+		rc = i2c_smbus_write_byte(psu->client, PMBUS_CLEAR_FAULTS);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case Q54SJ108A2_DEBUGFS_STOREDEFAULT:
+		flash_key[0] = 0x7E;
+		flash_key[1] = 0x15;
+		flash_key[2] = 0xDC;
+		flash_key[3] = 0x42;
+		rc = i2c_smbus_write_block_data(psu->client, PMBUS_FLASH_KEY_WRITE, 4, flash_key);
+		if (rc < 0)
+			return rc;
+
+		rc = i2c_smbus_write_byte(psu->client, STORE_DEFAULT_ALL);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case Q54SJ108A2_DEBUGFS_VOOV_RESPONSE:
+		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
+		if (rc < 0)
+			return rc;
+
+		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_VOUT_OV_FAULT_RESPONSE, dst_data);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case Q54SJ108A2_DEBUGFS_IOOC_RESPONSE:
+		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
+		if (rc < 0)
+			return rc;
+
+		rc = i2c_smbus_write_byte_data(psu->client, PMBUS_IOUT_OC_FAULT_RESPONSE, dst_data);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case Q54SJ108A2_DEBUGFS_BLACKBOX_ERASE:
+		rc = i2c_smbus_write_byte(psu->client, ERASE_BLACKBOX_DATA);
+		if (rc < 0)
+			return rc;
+
+		break;
+	case Q54SJ108A2_DEBUGFS_BLACKBOX_SET_OFFSET:
+		rc = kstrtou8_from_user(buf, count, 0, &dst_data);
+		if (rc < 0)
+			return rc;
+
+		rc = i2c_smbus_write_byte_data(psu->client, SET_HISTORY_EVENT_OFFSET, dst_data);
+		if (rc < 0)
+			return rc;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations q54sj108a2_fops = {
+	.llseek = noop_llseek,
+	.read = q54sj108a2_debugfs_read,
+	.write = q54sj108a2_debugfs_write,
+	.open = simple_open,
+};
+
+static const struct i2c_device_id q54sj108a2_id[] = {
+	{ "q54sj108a2", q54sj108a2 },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(i2c, q54sj108a2_id);
+
+static int q54sj108a2_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
+	enum chips chip_id;
+	int ret, i;
+	struct dentry *debugfs;
+	struct dentry *q54sj108a2_dir;
+	struct q54sj108a2_data *psu;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA |
+				     I2C_FUNC_SMBUS_BLOCK_DATA))
+		return -ENODEV;
+
+	if (client->dev.of_node)
+		chip_id = (enum chips)(unsigned long)of_device_get_match_data(dev);
+	else
+		chip_id = i2c_match_id(q54sj108a2_id, client)->driver_data;
+
+	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
+		return ret;
+	}
+	if (ret != 5 || strncmp(buf, "DELTA", 5)) {
+		buf[ret] = '\0';
+		dev_err(dev, "Unsupported Manufacturer ID '%s'\n", buf);
+		return -ENODEV;
+	}
+
+	/*
+	 * The chips support reading PMBUS_MFR_MODEL.
+	 */
+	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read Manufacturer Model\n");
+		return ret;
+	}
+	if (ret != 14 || strncmp(buf, "Q54SJ108A2", 10)) {
+		buf[ret] = '\0';
+		dev_err(dev, "Unsupported Manufacturer Model '%s'\n", buf);
+		return -ENODEV;
+	}
+
+	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_REVISION, buf);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read Manufacturer Revision\n");
+		return ret;
+	}
+	if (ret != 4 || buf[0] != 'S') {
+		buf[ret] = '\0';
+		dev_err(dev, "Unsupported Manufacturer Revision '%s'\n", buf);
+		return -ENODEV;
+	}
+
+	ret = pmbus_do_probe(client, &q54sj108a2_info[chip_id]);
+	if (ret)
+		return ret;
+
+	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
+	if (!psu)
+		return 0;
+
+	psu->client = client;
+
+	debugfs = pmbus_get_debugfs_dir(client);
+
+	q54sj108a2_dir = debugfs_create_dir(client->name, debugfs);
+
+	for (i = 0; i < Q54SJ108A2_DEBUGFS_NUM_ENTRIES; ++i)
+		psu->debugfs_entries[i] = i;
+
+	debugfs_create_file("operation", 0644, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_OPERATION],
+			    &q54sj108a2_fops);
+	debugfs_create_file("clear_fault", 0200, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_CLEARFAULT],
+			    &q54sj108a2_fops);
+	debugfs_create_file("write_protect", 0444, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_WRITEPROTECT],
+			    &q54sj108a2_fops);
+	debugfs_create_file("store_default", 0200, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_STOREDEFAULT],
+			    &q54sj108a2_fops);
+	debugfs_create_file("vo_ov_response", 0644, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_VOOV_RESPONSE],
+			    &q54sj108a2_fops);
+	debugfs_create_file("io_oc_response", 0644, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_IOOC_RESPONSE],
+			    &q54sj108a2_fops);
+	debugfs_create_file("pmbus_revision", 0444, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_PMBUS_VERSION],
+			    &q54sj108a2_fops);
+	debugfs_create_file("mfr_id", 0444, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_MFR_ID],
+			    &q54sj108a2_fops);
+	debugfs_create_file("mfr_model", 0444, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_MFR_MODEL],
+			    &q54sj108a2_fops);
+	debugfs_create_file("mfr_revision", 0444, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_MFR_REVISION],
+			    &q54sj108a2_fops);
+	debugfs_create_file("mfr_location", 0444, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_MFR_LOCATION],
+			    &q54sj108a2_fops);
+	debugfs_create_file("blackbox_erase", 0200, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_BLACKBOX_ERASE],
+			    &q54sj108a2_fops);
+	debugfs_create_file("blackbox_read_offset", 0444, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_BLACKBOX_READ_OFFSET],
+			    &q54sj108a2_fops);
+	debugfs_create_file("blackbox_set_offset", 0200, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_BLACKBOX_SET_OFFSET],
+			    &q54sj108a2_fops);
+	debugfs_create_file("blackbox_read", 0444, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_BLACKBOX_READ],
+			    &q54sj108a2_fops);
+	debugfs_create_file("flash_key", 0444, q54sj108a2_dir,
+			    &psu->debugfs_entries[Q54SJ108A2_DEBUGFS_FLASH_KEY],
+			    &q54sj108a2_fops);
+
+	return 0;
+}
+
+static const struct of_device_id q54sj108a2_of_match[] = {
+	{ .compatible = "delta,q54sj108a2", .data = (void *)q54sj108a2 },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, q54sj108a2_of_match);
+
+static struct i2c_driver q54sj108a2_driver = {
+	.driver = {
+		.name = "q54sj108a2",
+		.of_match_table = q54sj108a2_of_match,
+	},
+	.probe_new = q54sj108a2_probe,
+	.id_table = q54sj108a2_id,
+};
+
+module_i2c_driver(q54sj108a2_driver);
+
+MODULE_AUTHOR("Xiao.Ma <xiao.mx.ma@deltaww.com>");
+MODULE_DESCRIPTION("PMBus driver for Delta Q54SJ108A2 series modules");
+MODULE_LICENSE("GPL");
-- 
2.25.1

