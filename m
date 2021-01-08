Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A8D2EFA96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbhAHVaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:30:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:42119 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbhAHV3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:29:25 -0500
IronPort-SDR: spv9ots1n6TiXz3/x/midlnpC6wPZRX/7jADvVUBRgLXTE488adVrNrG55a43ehnrolfGP3IX0
 gz0x8v4KCASQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="165344235"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="165344235"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:06 -0800
IronPort-SDR: fKSR2AFDtLp7W9IF0udYDEjv4dh8f145gNUnbWizovvLwRMT2556bjg0f+wgEGvvkX0BbOL278
 hKQHrMrSGANw==
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="396426971"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:06 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 0AB946368;
        Fri,  8 Jan 2021 13:26:06 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kxzGn-0009d2-Tk; Fri, 08 Jan 2021 13:26:05 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
Subject: [PATCH v2 28/34] misc: Intel tsens IA host driver.
Date:   Fri,  8 Jan 2021 13:25:54 -0800
Message-Id: <20210108212600.36850-29-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108212600.36850-1-mgross@linux.intel.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "C, Udhayakumar" <udhayakumar.c@intel.com>

Add Intel tsens IA host driver for Intel Edge.AI Computer Vision
platforms.

About Intel Edge.AI Computer Vision platforms:
---------------------------------------------
The Intel Edge.AI Computer Vision platforms are vision processing systems
targeting machine vision applications for connected devices.

They are based on ARM A53 CPU running Linux and acts as a PCIe
endpoint device.

High-level architecture:
------------------------

Remote Host IA CPU                      Local Host ARM CPU
----------------                     --------------------------
|  Platform    |                     |  Thermal Daemon        |
| Management SW|                     |                        |
----------------                     --------------------------
|  Intel tsens |                     |  intel tsens i2c slave |
|  i2c client  |                     |  and thermal driver    |
----------------                     --------------------------
|  XLINK I2C   |                     |  XLINK I2C Slave       |
|  controller  |     <=========>     |   controller           |
----------------     xlink smbus     --------------------------

intel tsens module:
-------------------
The tsens module enables reading of on chip sensors present
in the Intel Edge.AI Computer Vision platforms.In the tsens module
various junction and SoC temperatures are reported using thermal
subsystem and i2c subsystem.

Temperature data reported using thermal subsystem will be used for
various cooling agents such as DVFS, fan control and shutdown the
system in case of critical temperature.

Temperature data reported using i2c subsystem will be used by
platform manageability software running in IA host.

- Remote Host driver
  * Intended for IA CPU
  * It is a I2C client driver
  * Driver path:
  {tree}/drivers/misc/intel_tsens/intel_tsens_host.c

Local host and Remote host drivers communicates using
I2C SMBUS protocol.

Acked-by: Mark Mross <mgross@linux.intel.com>
Signed-off-by: C, Udhayakumar <udhayakumar.c@intel.com>
---
 Documentation/hwmon/index.rst               |   1 +
 Documentation/hwmon/intel_tsens_host.rst    |  71 ++++
 drivers/misc/intel_tsens/Kconfig            |  13 +
 drivers/misc/intel_tsens/Makefile           |   1 +
 drivers/misc/intel_tsens/intel_tsens_host.c | 351 ++++++++++++++++++++
 include/linux/intel_tsens_host.h            |  34 ++
 6 files changed, 471 insertions(+)
 create mode 100644 Documentation/hwmon/intel_tsens_host.rst
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_host.c
 create mode 100644 include/linux/intel_tsens_host.h

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index fc29100bef73..7a9eaddd1ab3 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -81,6 +81,7 @@ Hardware Monitoring Kernel Drivers
    isl68137
    it87
    intel_tsens_sensor.rst
+   intel_tsens_host.rst
    jc42
    k10temp
    k8temp
diff --git a/Documentation/hwmon/intel_tsens_host.rst b/Documentation/hwmon/intel_tsens_host.rst
new file mode 100644
index 000000000000..012c593f969f
--- /dev/null
+++ b/Documentation/hwmon/intel_tsens_host.rst
@@ -0,0 +1,71 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Kernel driver: intel_tsens
+==========================
+
+Supported chips:
+  * Intel Edge.AI Computer Vision platforms: Keem Bay
+
+    Slave address: The address is assigned by the hddl device management
+                   driver.
+
+    Datasheet:
+      Documentation/hwmon/intel_tsens_sensor.rst#Remote Thermal Interface
+
+Authors:
+    - Thalaiappan, Rathina <rathina.thalaiappan@intel.com
+    - Udhayakumar C <udhayakumar.c@intel.com>
+
+Description
+===========
+The intel_tsens is a temperature sensor driver receiving the junction temperature
+from different heating points inside the SOC. The driver will receive the
+temperature on SMBUS connection. The reported temperature is in degrees Celsius.
+
+In Keem Bay, the four thermal junction temperature points are,
+Media Subsystem (mss), NN subsystem (nce), Compute subsystem (cse) and
+SOC(Maximum of mss, nce and cse).
+
+Example
+=======
+Temperature reported by a Keem Bay on the Linux Thermal sysfs interface.
+
+# cat /sys/class/thermal/thermal_zone*/type
+mss
+css
+nce
+soc
+
+# cat /sys/class/thermal/thermal_zone*/temp
+0
+29210
+28478
+29210
+
++-----------+-------------+
+| offset    |   Sensor    |
++-----------+-------------+
+|   0       |   mss       |
++-----------+-------------+
+|   1       |   css       |
++-----------+-------------+
+|   2       |   nce       |
++-----------+-------------+
+|   3       |   soc       |
++-----------+-------------+
+
+#sudo i2cdetect -l
+i2c-8   smbus           SMBus I801 adapter at efa0              SMBus adapte    r
+
+To read mss junction temperature:
+#i2cget -y 8 <slave addr> 0x0 w
+
+To read cse junction temperature:
+#i2cget -y 8 <slave addr> 0x1 w
+
+To read nce junction temperature:
+#i2cget -y 8 <slave addr> 0x2 w
+
+To read overall SoC temperature:
+#i2cget -y 8 <slave addr> 0x3 w
diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
index bfb8fe1997f4..8b263fdd80c3 100644
--- a/drivers/misc/intel_tsens/Kconfig
+++ b/drivers/misc/intel_tsens/Kconfig
@@ -13,3 +13,16 @@ config INTEL_TSENS_LOCAL_HOST
 	  management controller.
 	  Say Y if using a processor that includes the Intel VPU such as
 	  Keem Bay.  If unsure, say N.
+
+config INTEL_TSENS_IA_HOST
+	tristate "Temperature sensor driver for intel tsens remote host"
+	depends on I2C && THERMAL
+	depends on I2C_SMBUS
+	help
+	  This option enables tsens i2c and thermal local Host driver.
+
+	  This driver is used for reading thermal data via I2C SMBUS
+	  and registers itself to thermal framework, which can be
+	  used by thermal daemon in remote IA host
+	  Say Y if using a processor that includes the Intel VPU such as
+	  Keem Bay.  If unsure, say N.
diff --git a/drivers/misc/intel_tsens/Makefile b/drivers/misc/intel_tsens/Makefile
index 93dee8b9f481..250dc484fb49 100644
--- a/drivers/misc/intel_tsens/Makefile
+++ b/drivers/misc/intel_tsens/Makefile
@@ -5,3 +5,4 @@
 #
 
 obj-$(CONFIG_INTEL_TSENS_LOCAL_HOST)	+= intel_tsens_thermal.o
+obj-$(CONFIG_INTEL_TSENS_IA_HOST)	+= intel_tsens_host.o
diff --git a/drivers/misc/intel_tsens/intel_tsens_host.c b/drivers/misc/intel_tsens/intel_tsens_host.c
new file mode 100644
index 000000000000..adb553f3f2e3
--- /dev/null
+++ b/drivers/misc/intel_tsens/intel_tsens_host.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *
+ * Intel tsens I2C thermal Driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ */
+
+#include <asm/page.h>
+#include <linux/cdev.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/hddl_device.h>
+#include <linux/i2c.h>
+#include <linux/ioctl.h>
+#include <linux/intel_tsens_host.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/time.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#include <uapi/linux/stat.h>
+
+#define TSENS_BINDING_NAME	"intel_tsens"
+#define TSENS_BYTE_INDEX_SHIFT  0x6
+#define TSENS_READ_BYTE0	(0x0 << TSENS_BYTE_INDEX_SHIFT)
+#define TSENS_READ_BYTE1	(0x1 << TSENS_BYTE_INDEX_SHIFT)
+#define TSENS_READ_BYTE2	(0x2 << TSENS_BYTE_INDEX_SHIFT)
+#define TSENS_READ_BYTE3	(0x3 << TSENS_BYTE_INDEX_SHIFT)
+
+static int tsens_i2c_smbus_read_byte_data(struct i2c_client *i2c, u8 command,
+					  u8 *i2c_val)
+{
+	union i2c_smbus_data data;
+	int status;
+
+	status = i2c_smbus_xfer(i2c->adapter, i2c->addr, i2c->flags,
+				I2C_SMBUS_READ, command,
+				I2C_SMBUS_BYTE_DATA, &data);
+	*i2c_val = data.byte;
+	return status;
+}
+
+/**
+ * intel_tsens_get_temp - get updated temperatue
+ * @zone: Thermal zone device
+ * @temp: updated temperature value.
+ *
+ * Temperature value read from sensors ranging from -40000 (-40 degree Celsius)
+ * to 126000 (126 degree Celsius). if there is a failure while reading update
+ * temperature, -255 would be returned as temperature to indicate failure.
+ */
+static int intel_tsens_get_temp(struct thermal_zone_device *zone,
+				int *temp)
+{
+	struct intel_tsens_host *tsens =
+		(struct intel_tsens_host *)zone->devdata;
+	struct i2c_client *i2c_c;
+	int status, sensor_type;
+	u8 i2c_val;
+	s32 val;
+
+	if (strstr(zone->type, "smb"))
+		i2c_c = tsens->i2c_smbus;
+	else
+		i2c_c = tsens->i2c_xlk;
+
+	*temp = -255;
+	sensor_type = tsens->t_data->sensor_type | TSENS_READ_BYTE0;
+	status = tsens_i2c_smbus_read_byte_data(i2c_c,
+						sensor_type,
+						&i2c_val);
+	if (status < 0)
+		return status;
+	val = i2c_val;
+	sensor_type = tsens->t_data->sensor_type | TSENS_READ_BYTE1;
+	status = tsens_i2c_smbus_read_byte_data(i2c_c,
+						sensor_type,
+						&i2c_val);
+	if (status < 0)
+		return status;
+	val |= (i2c_val << 8);
+	sensor_type = tsens->t_data->sensor_type | TSENS_READ_BYTE2;
+	status = tsens_i2c_smbus_read_byte_data(i2c_c,
+						sensor_type,
+						&i2c_val);
+	if (status < 0)
+		return status;
+	val |= (i2c_val << 16);
+	sensor_type = tsens->t_data->sensor_type | TSENS_READ_BYTE3;
+	status = tsens_i2c_smbus_read_byte_data(i2c_c,
+						sensor_type,
+						&i2c_val);
+	if (status < 0)
+		return status;
+	val |= (i2c_val << 24);
+	*temp = val;
+	return 0;
+}
+
+static int intel_tsens_thermal_get_trip_type(struct thermal_zone_device *zone,
+					     int trip,
+					     enum thermal_trip_type *type)
+{
+	struct intel_tsens_host *tsens =
+		(struct intel_tsens_host *)zone->devdata;
+
+	*type = tsens->trip_info[trip]->trip_type;
+	return 0;
+}
+
+static int intel_tsens_thermal_get_trip_temp(struct thermal_zone_device *zone,
+					     int trip, int *temp)
+{
+	struct intel_tsens_host *tsens =
+		(struct intel_tsens_host *)zone->devdata;
+
+	*temp = tsens->trip_info[trip]->temp;
+	return 0;
+}
+
+static int intel_tsens_thermal_notify(struct thermal_zone_device *tz,
+				      int trip, enum thermal_trip_type type)
+{
+	int ret = 0;
+
+	switch (type) {
+	case THERMAL_TRIP_ACTIVE:
+		dev_warn(&tz->device,
+			 "zone %s reached to active temperature %d\n",
+			 tz->type, tz->temperature);
+		ret = 1;
+		break;
+	case THERMAL_TRIP_CRITICAL:
+		dev_warn(&tz->device,
+			 "zone %s reached to critical temperature %d\n",
+			 tz->type, tz->temperature);
+		ret = 1;
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static int intel_tsens_bind(struct thermal_zone_device *tz,
+			    struct thermal_cooling_device *cdev)
+{
+	int ret;
+
+	/*
+	 * Check here thermal device zone name and cdev name to match,
+	 * then call the bind device
+	 */
+	if (strncmp(TSENS_BINDING_NAME, cdev->type,
+		    strlen(TSENS_BINDING_NAME)) == 0) {
+		ret = thermal_zone_bind_cooling_device
+				(tz,
+				THERMAL_TRIP_ACTIVE,
+				cdev,
+				THERMAL_NO_LIMIT,
+				THERMAL_NO_LIMIT,
+				THERMAL_WEIGHT_DEFAULT);
+		if (ret) {
+			dev_err(&tz->device,
+				"binding zone %s with cdev %s failed:%d\n",
+				tz->type, cdev->type, ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int intel_tsens_unbind(struct thermal_zone_device *tz,
+			      struct thermal_cooling_device *cdev)
+{
+	int ret;
+
+	if (strncmp(TSENS_BINDING_NAME, cdev->type,
+		    strlen(TSENS_BINDING_NAME)) == 0) {
+		ret = thermal_zone_unbind_cooling_device(tz, 0, cdev);
+		if (ret) {
+			dev_err(&tz->device,
+				"unbinding zone %s with cdev %s failed:%d\n",
+				tz->type, cdev->type, ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static struct thermal_zone_device_ops tsens_thermal_ops = {
+	.bind = intel_tsens_bind,
+	.unbind = intel_tsens_unbind,
+	.get_temp = intel_tsens_get_temp,
+	.get_trip_type	= intel_tsens_thermal_get_trip_type,
+	.get_trip_temp	= intel_tsens_thermal_get_trip_temp,
+	.notify		= intel_tsens_thermal_notify,
+};
+
+static int intel_tsens_add_tz(struct intel_tsens_host *tsens,
+			      struct thermal_zone_device **tz,
+			      const char *name,
+			      struct device *dev,
+			      int i)
+{
+	int ret;
+
+	*tz =  thermal_zone_device_register(name,
+					    tsens->t_data->n_trips,
+					    0, tsens,
+					    &tsens_thermal_ops,
+					    NULL,
+					    tsens->t_data->passive_delay,
+					    tsens->t_data->polling_delay);
+	if (IS_ERR(*tz)) {
+		ret = PTR_ERR(*tz);
+		dev_err(dev,
+			"failed to register thermal zone device %s\n",
+			tsens->t_data->name);
+		return ret;
+	}
+	return 0;
+}
+
+static void intel_tsens_remove_tz(struct intel_hddl_clients *d)
+{
+	int i;
+
+	for (i = 0; i < d->nsens; i++) {
+		struct intel_tsens_host *tsens = d->tsens[i];
+
+		if (tsens->tz_smbus) {
+			thermal_zone_device_unregister(tsens->tz_smbus);
+			tsens->tz_smbus = NULL;
+		}
+		if (tsens->tz_xlk) {
+			thermal_zone_device_unregister(tsens->tz_xlk);
+			tsens->tz_xlk = NULL;
+		}
+	}
+}
+
+static int intel_tsens_tj_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct intel_hddl_clients *d = client->dev.platform_data;
+	u32 device_id = tsens_get_device_id(d);
+	char *i2c_str;
+	int ret, i;
+
+	if (strstr(client->adapter->name, "SMBus I801")) {
+		i2c_str = "smb";
+		for (i = 0; i < d->nsens; i++) {
+			struct intel_tsens_host *tsens = d->tsens[i];
+
+			tsens->sensor_name_smbus =
+				kasprintf(GFP_KERNEL,
+					  "%s_%s-%x",
+					  tsens->t_data->name,
+					  i2c_str, device_id);
+			tsens->i2c_smbus = client;
+			ret = intel_tsens_add_tz(tsens,
+						 &tsens->tz_smbus,
+						 tsens->sensor_name_smbus,
+						 &client->dev,
+						 i);
+			if (ret) {
+				dev_err(&client->dev,
+					"thermal zone configuration failed\n");
+				intel_tsens_remove_tz(d);
+				return ret;
+			}
+		}
+	} else {
+		i2c_str = "xlk";
+		for (i = 0; i < d->nsens; i++) {
+			struct intel_tsens_host *tsens = d->tsens[i];
+
+			tsens->sensor_name_xlk =
+				kasprintf(GFP_KERNEL,
+					  "%s_%s-%x",
+					  tsens->t_data->name,
+					  i2c_str, device_id);
+			tsens->i2c_xlk = client;
+			ret = intel_tsens_add_tz(tsens,
+						 &tsens->tz_xlk,
+						 tsens->sensor_name_xlk,
+						 &client->dev,
+						 i);
+			if (ret) {
+				dev_err(&client->dev,
+					"thermal zone configuration failed\n");
+				intel_tsens_remove_tz(d);
+				return ret;
+			}
+		}
+	}
+
+	i2c_set_clientdata(client, d);
+
+	return 0;
+}
+
+static int intel_tsens_tj_exit(struct i2c_client *client)
+{
+	struct intel_hddl_clients *d = client->dev.platform_data;
+
+	if (!d) {
+		dev_err(&client->dev,
+			"Unable to get private data\n");
+		return -EINVAL;
+	}
+	intel_tsens_remove_tz(d);
+	return 0;
+}
+
+static const struct i2c_device_id i2c_intel_tsens_id[] = {
+	{ "intel_tsens", (kernel_ulong_t)NULL },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, i2c_intel_tsens_id);
+
+static struct i2c_driver i2c_intel_tsens_driver = {
+	.driver = {
+		.name = "intel_tsens",
+	},
+	.probe = intel_tsens_tj_probe,
+	.remove = intel_tsens_tj_exit,
+	.id_table = i2c_intel_tsens_id,
+};
+module_i2c_driver(i2c_intel_tsens_driver);
+
+MODULE_DESCRIPTION("Intel tsens host Device driver");
+MODULE_AUTHOR("Sandeep Singh <sandeep1.singh@intel.com>");
+MODULE_AUTHOR("Vaidya, Mahesh R <mahesh.r.vaidya@intel.com>");
+MODULE_AUTHOR("Udhayakumar C <udhayakumar.c@intel.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/intel_tsens_host.h b/include/linux/intel_tsens_host.h
new file mode 100644
index 000000000000..4b9b2d6a5cfc
--- /dev/null
+++ b/include/linux/intel_tsens_host.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *
+ * Intel tsens host I2C thermal Driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ */
+
+#ifndef _LINUX_INTEL_TSENS_HOST_DEVICE_H
+#define _LINUX_INTEL_TSENS_HOST_DEVICE_H
+
+struct intel_tsens_host_trip_info {
+	enum thermal_trip_type trip_type;
+	int temp;
+} __packed __aligned(4);
+
+struct intel_tsens_host {
+	const char *sensor_name_smbus;
+	const char *sensor_name_xlk;
+	struct intel_tsens_data *t_data;
+	struct intel_tsens_host_trip_info **trip_info;
+	u32 device_id;
+	struct i2c_client *i2c_xlk;
+	struct i2c_client *i2c_smbus;
+	struct thermal_zone_device *tz_xlk;
+	struct thermal_zone_device *tz_smbus;
+};
+
+struct intel_tsens_host_plat_data {
+	int nsens;
+	struct intel_tsens_host **tsens;
+};
+#endif /*_LINUX_INTEL_TSENS_HOST_DEVICE_H*/
-- 
2.17.1

