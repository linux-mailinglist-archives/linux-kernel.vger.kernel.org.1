Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F12E27AC41
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgI1KwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:52:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:32990 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgI1KwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:52:13 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D25DC200205;
        Mon, 28 Sep 2020 12:52:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EC7FA2001CA;
        Mon, 28 Sep 2020 12:52:02 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EF05140249;
        Mon, 28 Sep 2020 12:51:57 +0200 (CEST)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Reinhard Pfau <pfau@gdsys.de>,
        Biwen Li <biwen.li@nxp.com>
Subject: [PATCH] hwmon: add support for SMSC EMC2305/03/02/01 fan controller
Date:   Mon, 28 Sep 2020 18:43:26 +0800
Message-Id: <20200928104326.40386-1-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinhard Pfau <pfau@gdsys.de>

Add support for SMSC EMC2305, EMC2303, EMC2302, EMC2301 fan controller
chips.
The driver primary supports the EMC2305 chip which provides RPM-based
PWM control and monitoring for up to 5 fans.

According to the SMSC data sheets the EMC2303, EMC2302 and EMC2301 chips
have basically the same functionality and register layout, but support
less fans and (in case of EMC2302 and EMC2301) less possible I2C addresses.
The driver supports them, too.

The driver supports configuration via devicetree. This can also be used
to restrict the fans exposed via sysfs (see doc for details).

Signed-off-by: Reinhard Pfau <pfau@gdsys.de>
Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 .../devicetree/bindings/hwmon/emc2305.txt     |  33 +
 Documentation/hwmon/emc2305.rst               |  34 +
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/emc2305.c                       | 689 ++++++++++++++++++
 6 files changed, 775 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/emc2305.txt
 create mode 100644 Documentation/hwmon/emc2305.rst
 create mode 100644 drivers/hwmon/emc2305.c

diff --git a/Documentation/devicetree/bindings/hwmon/emc2305.txt b/Documentation/devicetree/bindings/hwmon/emc2305.txt
new file mode 100644
index 000000000000..73165120b88a
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/emc2305.txt
@@ -0,0 +1,33 @@
+EMC2305 (I2C)
+
+This device is a RPM-based PWM Fan Speed Controller for up to 5 fans.
+Each fan can beconfigured individually:
+
+ - The PWM mode:
+    0: PWM is disabled
+    3: RPM based PWM
+
+ - The fan divisor (for RPM mesaurement)
+   1, 2 ,4 or 8
+
+ - The target RPM speed (for RPM based PWM mode)
+   max 16000 (according to data sheet)
+
+
+ - The /emc2305 node
+
+   Required properties:
+
+   - compatible : must be "smsc,emc2305"
+   - reg : I2C bus address of the device
+   - #address-cells : must be <1>
+   - #size-cells : must be <0>
+
+   Example EMC2305 node:
+
+       emc2305@2C {
+	    compatible = "smsc,emc2305";
+	    reg = <0x2C>;
+	    #address-cells = <1>;
+	    #size-cells = <0>;
+       }
diff --git a/Documentation/hwmon/emc2305.rst b/Documentation/hwmon/emc2305.rst
new file mode 100644
index 000000000000..d0cebae09ffd
--- /dev/null
+++ b/Documentation/hwmon/emc2305.rst
@@ -0,0 +1,34 @@
+Kernel driver emc2305
+=====================
+
+Supported chips:
+  * SMSC EMC2305, EMC2303, EMC2302, EMC2301
+    Adresses scanned: I2C 0x2c, 0x2d, 0x2e, 0x2f, 0x4c, 0x4d
+    Prefixes: 'emc2305', 'emc2303', 'emc2302', 'emc2301'
+    Datasheet: Publicly available at the MICROCHIP website :
+        http://ww1.microchip.com/downloads/en/DeviceDoc/2305.pdf
+
+Authors:
+        Reinhard Pfau, Guntermann & Drunck GmbH <pfau@gdsys.de>
+        Biwen Li <biwen.li@nxp.com>
+
+Description
+-----------
+
+The SMSC EMC2305 is a fan controller for up to 5 fans.
+The EMC2303 has the same functionality but supports only up to 3 fans.
+
+The EMC2302 supports 2 fans and the EMC2301 1 fan. These chips support less
+possible I2C addresses.
+
+Fan rotation speeds are reported in RPM.
+The driver supports the RPM based PWM control to keep a fan at a desired speed.
+To enable this function for a fan, write 3 to pwm<num>_enable and the desired
+fan speed to fan<num>_target.
+
+
+Devicetree
+----------
+
+Configuration is also possible via devicetree:
+Documentation/devicetree/bindings/hwmon/emc2305.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index b526b8a66f8a..a506e8071259 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15013,6 +15013,14 @@ S:	Maintained
 F:	Documentation/hwmon/emc2103.rst
 F:	drivers/hwmon/emc2103.c
 
+SMSC EMC2305 HARDWARE MONITOR DRIVER
+M:	Biwen Li <biwen.li@nxp.com>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/emc2305
+F:	Documentation/devicetree/bindings/hwmon/emc2305.txt
+F:	drivers/hwmon/emc2305.c
+
 SMSC SCH5627 HARDWARE MONITOR DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2fa4666d5b07..5ab3e975517a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1457,6 +1457,16 @@ config SENSORS_EMC2103
 	  This driver can also be built as a module. If so, the module
 	  will be called emc2103.
 
+config SENSORS_EMC2305
+	tristate "SMSC EMC2305"
+	depends on I2C
+	help
+	  If you say yes here you get support for the SMSC EMC2305
+	  fan controller chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called emc2305.
+
 config SENSORS_EMC6W201
 	tristate "SMSC EMC6W201"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b033e6733b56..b6377d32a2c9 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_SENSORS_DS620)	+= ds620.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_EMC1403)	+= emc1403.o
 obj-$(CONFIG_SENSORS_EMC2103)	+= emc2103.o
+obj-$(CONFIG_SENSORS_EMC2305)	+= emc2305.o
 obj-$(CONFIG_SENSORS_EMC6W201)	+= emc6w201.o
 obj-$(CONFIG_SENSORS_F71805F)	+= f71805f.o
 obj-$(CONFIG_SENSORS_F71882FG)	+= f71882fg.o
diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
new file mode 100644
index 000000000000..d0c99f9b7434
--- /dev/null
+++ b/drivers/hwmon/emc2305.c
@@ -0,0 +1,689 @@
+/*
+ * emc2305.c - hwmon driver for SMSC EMC2305 fan controller
+ * (C) Copyright 2013
+ * Copyright 2020 NXP
+ * Reinhard Pfau, Guntermann & Drunck GmbH <pfau@gdsys.de>
+ * Biwen Li <biwen.li@nxp.com>
+ *
+ * Based on emc2103 driver by SMSC.
+ *
+ * Datasheet available at:
+ * http://ww1.microchip.com/downloads/en/DeviceDoc/2305.pdf
+ *
+ * Also supports the EMC2303 fan controller which has the same functionality
+ * and register layout as EMC2305, but supports only up to 3 fans instead of 5.
+ *
+ * Also supports EMC2302 (up to 2 fans) and EMC2301 (1 fan) fan controller.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * TODO / IDEAS:
+ * - expose more of the configuration and features
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+
+/*
+ * Addresses scanned.
+ * Listed in the same order as they appear in the EMC2305, EMC2303 data sheets.
+ *
+ * Note: these are the I2C adresses which are possible for EMC2305 and EMC2303
+ * chips.
+ * The EMC2302 supports only 0x2e (EMC2302-1) and 0x2f (EMC2302-2).
+ * The EMC2301 supports only 0x2f.
+ */
+static const unsigned short i2c_addresses[] = {
+	0x2E,
+	0x2F,
+	0x2C,
+	0x2D,
+	0x4C,
+	0x4D,
+	I2C_CLIENT_END
+};
+
+/*
+ * global registers
+ */
+enum {
+	REG_CONFIGURATION = 0x20,
+	REG_FAN_STATUS = 0x24,
+	REG_FAN_STALL_STATUS = 0x25,
+	REG_FAN_SPIN_STATUS = 0x26,
+	REG_DRIVE_FAIL_STATUS = 0x27,
+	REG_FAN_INTERRUPT_ENABLE = 0x29,
+	REG_PWM_POLARITY_CONFIG = 0x2a,
+	REG_PWM_OUTPUT_CONFIG = 0x2b,
+	REG_PWM_BASE_FREQ_1 = 0x2c,
+	REG_PWM_BASE_FREQ_2 = 0x2d,
+	REG_SOFTWARE_LOCK = 0xef,
+	REG_PRODUCT_FEATURES = 0xfc,
+	REG_PRODUCT_ID = 0xfd,
+	REG_MANUFACTURER_ID = 0xfe,
+	REG_REVISION = 0xff
+};
+
+/*
+ * fan specific registers
+ */
+enum {
+	REG_FAN_SETTING = 0x30,
+	REG_PWM_DIVIDE = 0x31,
+	REG_FAN_CONFIGURATION_1 = 0x32,
+	REG_FAN_CONFIGURATION_2 = 0x33,
+	REG_GAIN = 0x35,
+	REG_FAN_SPIN_UP_CONFIG = 0x36,
+	REG_FAN_MAX_STEP = 0x37,
+	REG_FAN_MINIMUM_DRIVE = 0x38,
+	REG_FAN_VALID_TACH_COUNT = 0x39,
+	REG_FAN_DRIVE_FAIL_BAND_LOW = 0x3a,
+	REG_FAN_DRIVE_FAIL_BAND_HIGH = 0x3b,
+	REG_TACH_TARGET_LOW = 0x3c,
+	REG_TACH_TARGET_HIGH = 0x3d,
+	REG_TACH_READ_HIGH = 0x3e,
+	REG_TACH_READ_LOW = 0x3f,
+};
+
+#define SEL_FAN(fan, reg) (reg + fan * 0x10)
+
+/*
+ * Factor by equations [2] and [3] from data sheet; valid for fans where the
+ * number of edges equals (poles * 2 + 1).
+ */
+#define FAN_RPM_FACTOR 3932160
+
+struct emc2305_fan_data {
+	bool		enabled;
+	bool		rpm_control;
+	bool		valid;		/* registers are valid */
+	u8		poles;
+	u8		multiplier;
+	u16		tach;
+	u16		target;
+	unsigned long		last_updated;	/* in jiffies */
+};
+
+struct emc2305_data {
+	struct i2c_client	*client;
+	const struct		attribute_group *groups[6];
+	struct mutex		update_lock;
+	int			fan_count; /* num of fan */
+	struct emc2305_fan_data fan[5];
+};
+
+static int read_u8_from_i2c(struct i2c_client *client, u8 i2c_reg, u8 *output)
+{
+	int status = i2c_smbus_read_byte_data(client, i2c_reg);
+	if (status < 0) {
+		dev_warn(&client->dev, "reg 0x%02x, err %d\n",
+			i2c_reg, status);
+	} else {
+		*output = status;
+	}
+	return status;
+}
+
+static void read_fan_from_i2c(struct i2c_client *client, u16 *output,
+			      u8 hi_addr, u8 lo_addr)
+{
+	u8 high_byte, lo_byte;
+
+	if (read_u8_from_i2c(client, hi_addr, &high_byte) < 0)
+		return;
+
+	if (read_u8_from_i2c(client, lo_addr, &lo_byte) < 0)
+		return;
+
+	*output = ((u16)high_byte << 5) | (lo_byte >> 3);
+}
+
+static void write_fan_target_to_i2c(struct i2c_client *client, int fan,
+				    u16 new_target)
+{
+	const u8 lo_reg = SEL_FAN(fan, REG_TACH_TARGET_LOW);
+	const u8 hi_reg = SEL_FAN(fan, REG_TACH_TARGET_HIGH);
+	u8 high_byte = (new_target & 0x1fe0) >> 5;
+	u8 low_byte = (new_target & 0x001f) << 3;
+
+	i2c_smbus_write_byte_data(client, lo_reg, low_byte);
+	i2c_smbus_write_byte_data(client, hi_reg, high_byte);
+}
+
+static void read_fan_config_from_i2c(struct i2c_client *client, int fan_idx)
+
+{
+	struct emc2305_data *data = i2c_get_clientdata(client);
+	u8 conf1;
+
+	if (read_u8_from_i2c(client, SEL_FAN(fan_idx, REG_FAN_CONFIGURATION_1),
+			     &conf1) < 0)
+		return;
+
+	data->fan[fan_idx].rpm_control = (conf1 & 0x80) != 0;
+	data->fan[fan_idx].multiplier = 1 << ((conf1 & 0x60) >> 5);
+	data->fan[fan_idx].poles = ((conf1 & 0x18) >> 3) + 1;
+}
+
+static void read_fan_data(struct i2c_client *client, int fan_idx)
+{
+	struct emc2305_data *data = i2c_get_clientdata(client);
+
+	read_fan_from_i2c(client, &data->fan[fan_idx].target,
+			  SEL_FAN(fan_idx, REG_TACH_TARGET_HIGH),
+			  SEL_FAN(fan_idx, REG_TACH_TARGET_LOW));
+	read_fan_from_i2c(client, &data->fan[fan_idx].tach,
+			  SEL_FAN(fan_idx, REG_TACH_READ_HIGH),
+			  SEL_FAN(fan_idx, REG_TACH_READ_LOW));
+}
+
+static struct emc2305_fan_data *
+emc2305_update_fan(struct i2c_client *client, int fan_idx)
+{
+	struct emc2305_data *data = i2c_get_clientdata(client);
+	struct emc2305_fan_data *fan_data = &data->fan[fan_idx];
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, fan_data->last_updated + HZ + HZ / 2)
+	    || !fan_data->valid) {
+		read_fan_config_from_i2c(client, fan_idx);
+		read_fan_data(client, fan_idx);
+		fan_data->valid = true;
+		fan_data->last_updated = jiffies;
+	}
+
+	mutex_unlock(&data->update_lock);
+	return fan_data;
+}
+
+static struct emc2305_fan_data *
+emc2305_update_device_fan(struct device *dev, struct device_attribute *da)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int fan_idx = to_sensor_dev_attr(da)->index;
+
+	return emc2305_update_fan(client, fan_idx);
+}
+
+/*
+ * set/ config functions
+ */
+
+/*
+ * Note: we also update the fan target here, because its value is
+ * determined in part by the fan clock divider.  This follows the principle
+ * of least surprise; the user doesn't expect the fan target to change just
+ * because the divider changed.
+ */
+static int
+emc2305_set_fan_div(struct i2c_client *client, int fan_idx, long new_div)
+{
+	struct emc2305_data *data = i2c_get_clientdata(client);
+	struct emc2305_fan_data *fan = emc2305_update_fan(client, fan_idx);
+	const u8 reg_conf1 = SEL_FAN(fan_idx, REG_FAN_CONFIGURATION_1);
+	int new_range_bits, old_div = 8 / fan->multiplier;
+	int status = 0;
+
+	if (new_div == old_div) /* No change */
+		return 0;
+
+	switch (new_div) {
+	case 1:
+		new_range_bits = 3;
+		break;
+	case 2:
+		new_range_bits = 2;
+		break;
+	case 4:
+		new_range_bits = 1;
+		break;
+	case 8:
+		new_range_bits = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&data->update_lock);
+
+	status = i2c_smbus_read_byte_data(client, reg_conf1);
+	if (status < 0) {
+		dev_dbg(&client->dev, "reg 0x%02x, err %d\n",
+			reg_conf1, status);
+		goto exit_unlock;
+	}
+	status &= 0x9F;
+	status |= (new_range_bits << 5);
+	status = i2c_smbus_write_byte_data(client, reg_conf1, status);
+	if (status < 0) {
+		goto exit_invalidate;
+	}
+
+	fan->multiplier = 8 / new_div;
+
+	/* update fan target if high byte is not disabled */
+	if ((fan->target & 0x1fe0) != 0x1fe0) {
+		u16 new_target = (fan->target * old_div) / new_div;
+		fan->target = min_t(u16, new_target, 0x1fff);
+		write_fan_target_to_i2c(client, fan_idx, fan->target);
+	}
+
+exit_invalidate:
+	/* invalidate fan data to force re-read from hardware */
+	fan->valid = false;
+exit_unlock:
+	mutex_unlock(&data->update_lock);
+	return status;
+}
+
+static int
+emc2305_set_fan_target(struct i2c_client *client, int fan_idx, long rpm_target)
+{
+	struct emc2305_data *data = i2c_get_clientdata(client);
+	struct emc2305_fan_data *fan = emc2305_update_fan(client, fan_idx);
+
+	/*
+	 * Datasheet states 16000 as maximum RPM target
+	 * (table 2.2 and section 4.3)
+	 */
+	if ((rpm_target < 0) || (rpm_target > 16000))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+
+	if (rpm_target == 0)
+		fan->target = 0x1fff;
+	else
+		fan->target = clamp_val(
+			FAN_RPM_FACTOR * fan->multiplier / rpm_target,
+			0, 0x1fff);
+
+	write_fan_target_to_i2c(client, fan_idx, fan->target);
+
+	mutex_unlock(&data->update_lock);
+	return 0;
+}
+
+static int
+emc2305_set_pwm_enable(struct i2c_client *client, int fan_idx, long enable)
+{
+	struct emc2305_data *data = i2c_get_clientdata(client);
+	struct emc2305_fan_data *fan = emc2305_update_fan(client, fan_idx);
+	const u8 reg_fan_conf1 = SEL_FAN(fan_idx, REG_FAN_CONFIGURATION_1);
+	int status = 0;
+	u8 conf_reg;
+
+	mutex_lock(&data->update_lock);
+	switch (enable) {
+	case 0:
+		fan->rpm_control = false;
+		break;
+	case 3:
+		fan->rpm_control = true;
+		break;
+	default:
+		status = -EINVAL;
+		goto exit_unlock;
+	}
+
+	status = read_u8_from_i2c(client, reg_fan_conf1, &conf_reg);
+	if (status < 0)
+		goto exit_unlock;
+
+	if (fan->rpm_control)
+		conf_reg |= 0x80;
+	else
+		conf_reg &= ~0x80;
+
+	status = i2c_smbus_write_byte_data(client, reg_fan_conf1, conf_reg);
+
+exit_unlock:
+	mutex_unlock(&data->update_lock);
+	return status;
+}
+
+static ssize_t
+fan_input_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct emc2305_fan_data *fan = emc2305_update_device_fan(dev, da);
+	int rpm = 0;
+
+	if (fan->tach != 0)
+		rpm = (FAN_RPM_FACTOR * fan->multiplier) / fan->tach;
+	return sprintf(buf, "%d\n", rpm);
+}
+
+static ssize_t
+fan_fault_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct emc2305_fan_data *fan = emc2305_update_device_fan(dev, da);
+
+	return sprintf(buf, "%d\n", (fan->tach & 0x1fe0) == 0x1fe0);
+}
+
+static ssize_t
+fan_div_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct emc2305_fan_data *fan = emc2305_update_device_fan(dev, da);
+
+	return sprintf(buf, "%d\n", 8 / fan->multiplier);
+}
+
+static ssize_t
+fan_div_store(struct device *dev, struct device_attribute *da,
+	    const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int fan_idx = to_sensor_dev_attr(da)->index;
+	long new_div;
+	int status;
+
+	status = kstrtol(buf, 10, &new_div);
+	if (status < 0)
+		return status;
+
+	status = emc2305_set_fan_div(client, fan_idx, new_div);
+	if (status < 0)
+		return status;
+
+	return count;
+}
+
+static ssize_t
+fan_target_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct emc2305_fan_data *fan = emc2305_update_device_fan(dev, da);
+	int rpm = 0;
+
+	/* high byte of 0xff indicates disabled so return 0 */
+	if ((fan->target != 0) && ((fan->target & 0x1fe0) != 0x1fe0))
+		rpm = FAN_RPM_FACTOR * fan->multiplier
+			/ fan->target;
+
+	return sprintf(buf, "%d\n", rpm);
+}
+
+static ssize_t fan_target_store(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int fan_idx = to_sensor_dev_attr(da)->index;
+	long rpm_target;
+	int status;
+
+	status = kstrtol(buf, 10, &rpm_target);
+	if (status < 0)
+		return status;
+
+	status = emc2305_set_fan_target(client, fan_idx, rpm_target);
+	if (status < 0)
+		return status;
+
+	return count;
+}
+
+static ssize_t
+pwm_enable_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct emc2305_fan_data *fan = emc2305_update_device_fan(dev, da);
+	return sprintf(buf, "%d\n", fan->rpm_control ? 3 : 0);
+}
+
+static ssize_t pwm_enable_store(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int fan_idx = to_sensor_dev_attr(da)->index;
+	long new_value;
+	int status;
+
+	status = kstrtol(buf, 10, &new_value);
+	if (status < 0)
+		return -EINVAL;
+	status = emc2305_set_pwm_enable(client, fan_idx, new_value);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_input, 0);
+static SENSOR_DEVICE_ATTR_RW(fan1_div, fan_div, 0);
+static SENSOR_DEVICE_ATTR_RW(fan1_target, fan_target, 0);
+static SENSOR_DEVICE_ATTR_RO(fan1_fault, fan_fault, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_input, 1);
+static SENSOR_DEVICE_ATTR_RW(fan2_div, fan_div, 1);
+static SENSOR_DEVICE_ATTR_RW(fan2_target, fan_target, 1);
+static SENSOR_DEVICE_ATTR_RO(fan2_fault, fan_fault, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan_input, 2);
+static SENSOR_DEVICE_ATTR_RW(fan3_div, fan_div, 2);
+static SENSOR_DEVICE_ATTR_RW(fan3_target, fan_target, 2);
+static SENSOR_DEVICE_ATTR_RO(fan3_fault, fan_fault, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_input, fan_input, 3);
+static SENSOR_DEVICE_ATTR_RW(fan4_div, fan_div, 3);
+static SENSOR_DEVICE_ATTR_RW(fan4_target, fan_target, 3);
+static SENSOR_DEVICE_ATTR_RO(fan4_fault, fan_fault, 3);
+static SENSOR_DEVICE_ATTR_RO(fan5_input, fan_input, 4);
+static SENSOR_DEVICE_ATTR_RW(fan5_div, fan_div, 4);
+static SENSOR_DEVICE_ATTR_RW(fan5_target, fan_target, 4);
+static SENSOR_DEVICE_ATTR_RO(fan5_fault, fan_fault, 4);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm_enable, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3, pwm_enable, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4, pwm_enable, 3);
+static SENSOR_DEVICE_ATTR_RW(pwm5, pwm_enable, 4);
+
+static struct attribute *emc2305_attributes_fan1[] = {
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan1_target.dev_attr.attr,
+	&sensor_dev_attr_fan1_fault.dev_attr.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	NULL
+};
+
+static struct attribute *emc2305_attributes_fan2[] = {
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_div.dev_attr.attr,
+	&sensor_dev_attr_fan2_target.dev_attr.attr,
+	&sensor_dev_attr_fan2_fault.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	NULL
+};
+
+static struct attribute *emc2305_attributes_fan3[] = {
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_div.dev_attr.attr,
+	&sensor_dev_attr_fan3_target.dev_attr.attr,
+	&sensor_dev_attr_fan3_fault.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	NULL
+};
+
+static struct attribute *emc2305_attributes_fan4[] = {
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_div.dev_attr.attr,
+	&sensor_dev_attr_fan4_target.dev_attr.attr,
+	&sensor_dev_attr_fan4_fault.dev_attr.attr,
+	&sensor_dev_attr_pwm4.dev_attr.attr,
+	NULL
+};
+
+static struct attribute *emc2305_attributes_fan5[] = {
+	&sensor_dev_attr_fan5_input.dev_attr.attr,
+	&sensor_dev_attr_fan5_div.dev_attr.attr,
+	&sensor_dev_attr_fan5_target.dev_attr.attr,
+	&sensor_dev_attr_fan5_fault.dev_attr.attr,
+	&sensor_dev_attr_pwm5.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group emc2305_fan1_group = {
+	.attrs = emc2305_attributes_fan1,
+};
+
+static const struct attribute_group emc2305_fan2_group = {
+	.attrs = emc2305_attributes_fan2,
+};
+
+static const struct attribute_group emc2305_fan3_group = {
+	.attrs = emc2305_attributes_fan3,
+};
+
+static const struct attribute_group emc2305_fan4_group = {
+	.attrs = emc2305_attributes_fan4,
+};
+
+static const struct attribute_group emc2305_fan5_group = {
+	.attrs = emc2305_attributes_fan5,
+};
+
+/*
+ * driver interface
+ */
+static int
+emc2305_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct emc2305_data *data;
+	struct device *hwmon_dev;
+	int status, idx = 0;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EIO;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct emc2305_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	data->client = client;
+	mutex_init(&data->update_lock);
+
+	status = i2c_smbus_read_byte_data(client, REG_PRODUCT_ID);
+	switch (status) {
+	case 0x34: /* EMC2305 */
+		data->fan_count = 5;
+		break;
+	case 0x35: /* EMC2303 */
+		data->fan_count = 3;
+		break;
+	case 0x36: /* EMC2302 */
+		data->fan_count = 2;
+		break;
+	case 0x37: /* EMC2301 */
+		data->fan_count = 1;
+		break;
+	default:
+		if (status < 0)
+			dev_err(&client->dev, "Failed to read reg REG_PRODUCT_ID, status = %d\n", status);
+		else
+			dev_err(&client->dev, "Unknown device, status = %d\n", status);
+		return status;
+	}
+
+	/* sysfs hooks */
+	data->groups[idx++] = &emc2305_fan1_group;
+	if (data->fan_count >= 2)
+		data->groups[idx++] = &emc2305_fan2_group;
+	if (data->fan_count >= 3) {
+		data->groups[idx++] = &emc2305_fan3_group;
+	}
+	if (data->fan_count == 5) {
+		data->groups[idx++] = &emc2305_fan4_group;
+		data->groups[idx++] = &emc2305_fan5_group;
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
+							   client->name, data,
+							   data->groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	dev_info(&client->dev, "pwm fan controller: '%s'\n",
+		 client->name);
+
+	return 0;
+}
+
+static const struct i2c_device_id emc2305_ids[] = {
+	{ "emc2301", 0 },
+	{ "emc2302", 0 },
+	{ "emc2303", 0 },
+	{ "emc2305", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, emc2305_ids);
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int
+emc2305_detect(struct i2c_client *new_client, struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = new_client->adapter;
+	int manufacturer, product;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	manufacturer =
+		i2c_smbus_read_byte_data(new_client, REG_MANUFACTURER_ID);
+	if (manufacturer != 0x5D)
+		return -ENODEV;
+
+	product = i2c_smbus_read_byte_data(new_client, REG_PRODUCT_ID);
+
+	switch (product) {
+	case 0x34:
+		strlcpy(info->type, "emc2305", I2C_NAME_SIZE);
+		break;
+	case 0x35:
+		strlcpy(info->type, "emc2303", I2C_NAME_SIZE);
+		break;
+	case 0x36:
+		strlcpy(info->type, "emc2302", I2C_NAME_SIZE);
+		break;
+	case 0x37:
+		strlcpy(info->type, "emc2301", I2C_NAME_SIZE);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static struct i2c_driver emc2305_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "emc2305",
+	},
+	.probe		= emc2305_probe,
+	.id_table	= emc2305_ids,
+	.detect		= emc2305_detect,
+	.address_list	= i2c_addresses,
+};
+
+module_i2c_driver(emc2305_driver);
+
+MODULE_AUTHOR("Reinhard Pfau <pfau@gdsys>, Biwen Li <biwen.li@nxp.com>\n");
+MODULE_DESCRIPTION("SMSC EMC2305 hwmon driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

