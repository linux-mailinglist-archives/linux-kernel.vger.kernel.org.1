Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B202EFA90
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbhAHV33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:29:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:42127 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729878AbhAHV3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:29:25 -0500
IronPort-SDR: t3NAS6H88GMUWQnie26sdWzrOsdy1WLoUxL2iUutPI0aLFpq0mMXgn9JhdWnRMfFBsjOlLPHn5
 Cm7SyaWRA9cQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="165344228"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="165344228"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:06 -0800
IronPort-SDR: jog9K8NuV0Ob5I1tji9S5RB7K7rJQonZCx0HYNYNKTB9tYUtRLpLpCmAX17CChxI8YJZIt/C5e
 iVoLcrWwGpDw==
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="380257706"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:05 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id E70C06368;
        Fri,  8 Jan 2021 13:26:05 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kxzGn-0009cz-Qc; Fri, 08 Jan 2021 13:26:05 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
Subject: [PATCH v2 27/34] misc: Tsens ARM host thermal driver.
Date:   Fri,  8 Jan 2021 13:25:53 -0800
Message-Id: <20210108212600.36850-28-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108212600.36850-1-mgross@linux.intel.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "C, Udhayakumar" <udhayakumar.c@intel.com>

Add tsens ARM host thermal driver for Intel Edge.AI Computer Vision
platforms.

About Intel Edge.AI Computer Vision platforms:
---------------------------------------------
The Intel Edge.AI Computer Vision platforms are vision processing systems
targeting machine vision applications for connected devices.

They are based on ARM A53 CPU running Linux and acts as a PCIe
endpoint device.

High-level architecture:
------------------------

Remote Host IA CPU                    Local Host ARM CPU
----------------                     --------------------------
|  Platform    |                     |  Thermal Daemon        |
| Management SW|                     |                        |
----------------                     --------------------------
|  Intel tsens |                     |  intel tsens i2c slave |
|  i2c client  |                     |  and thermal driver    |
----------------                     --------------------------
|  XLINK I2C   |                     |  XLINK I2C Slave       |
|  controller  |     <=========>     |   controller           |
----------------        smbus        --------------------------

intel tsens module:
-------------------
The tsens module enables reading of on chip sensors present
in the Intel Edge.AI Computer Vision platforms. In the tsens module
various junction and SoC temperatures are reported using thermal
subsystem and i2c subsystem.

Temperature data reported using thermal subsystem will be used for
various cooling agents such as DVFS, fan control and shutdown the
system in case of critical temperature.

Temperature data reported using i2c subsystem will be used by
platform manageability software running in IA host.

- Local Host driver
  * Intended for ARM CPU
  * It is based on Thermal and I2C slave  Framework
  * Driver path:
  {tree}/drivers/misc/intel_tsens/intel_tsens_thermal.c

Local host and Remote host drivers communicates using
XLINK I2C SMBUS protocol.

Acked-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: C, Udhayakumar <udhayakumar.c@intel.com>
---
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/intel_tsens_sensor.rst    |  67 ++
 MAINTAINERS                                   |   5 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/intel_tsens/Kconfig              |  15 +
 drivers/misc/intel_tsens/Makefile             |   7 +
 .../misc/intel_tsens/intel_tsens_thermal.c    | 651 ++++++++++++++++++
 .../misc/intel_tsens/intel_tsens_thermal.h    |  38 +
 include/linux/hddl_device.h                   | 153 ++++
 10 files changed, 939 insertions(+)
 create mode 100644 Documentation/hwmon/intel_tsens_sensor.rst
 create mode 100644 drivers/misc/intel_tsens/Kconfig
 create mode 100644 drivers/misc/intel_tsens/Makefile
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_thermal.c
 create mode 100644 drivers/misc/intel_tsens/intel_tsens_thermal.h
 create mode 100644 include/linux/hddl_device.h

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index fcb870ce6286..fc29100bef73 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -80,6 +80,7 @@ Hardware Monitoring Kernel Drivers
    ir38064
    isl68137
    it87
+   intel_tsens_sensor.rst
    jc42
    k10temp
    k8temp
diff --git a/Documentation/hwmon/intel_tsens_sensor.rst b/Documentation/hwmon/intel_tsens_sensor.rst
new file mode 100644
index 000000000000..0f53dfca477e
--- /dev/null
+++ b/Documentation/hwmon/intel_tsens_sensor.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Kernel driver: intel_tsens_thermal
+==================================
+
+Supported chips:
+  * Intel Edge.AI Computer Vision platforms: Keem Bay
+
+    Slave address: The address is assigned by the hddl device management
+                   driver.
+
+Authors:
+    - Thalaiappan, Rathina <rathina.thalaiappan@intel.com>
+    - Udhayakumar C <udhayakumar.c@intel.com>
+
+Description
+===========
+The Intel Edge.AI Computer Vision platforms have memory mapped thermal sensors
+which are accessible locally. The intel_tsens_thermal driver handles these
+thermal sensor and exposes the temperature to
+
+* the external host similar to the standard SMBUS based thermal sensor
+    (like LM73) to the host by registering to the I2C subsystem as
+    slave interface (Documentation/i2c/slave-interface.rst).
+* the local CPU as a standard thermal device.
+
+In Keem Bay, the four thermal junction temperature points are,
+Media Subsystem (mss), NN subsystem (nce), Compute subsystem (cse) and
+SOC(Maximum of mss, nce and cse).
+
+Similarity: /drivers/thermal/qcom
+
+Example
+=======
+Local Thermal Interface:
+
+Temperature reported in Keem Bay on the Linux Thermal sysfs interface.
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
+Remote Thermal Interface:
+
+tsens i2c slave driver reports temperature of various subsytem
+junction temperature based on table as below.
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
diff --git a/MAINTAINERS b/MAINTAINERS
index e4165c9983cd..0dfbe892d852 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1986,6 +1986,11 @@ S:	Supported
 F:	drivers/misc/hddl_device/
 F:	drivers/misc/intel_tsens/
 
+ARM/INTEL TSENS SUPPORT
+M:	Udhayakumar C <udhayakumar.c@intel.com>
+S:	Supported
+F:	drivers/misc/intel_tsens/
+
 ARM/INTEL RESEARCH IMOTE/STARGATE 2 MACHINE SUPPORT
 M:	Jonathan Cameron <jic23@cam.ac.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2d1f7b165cc8..aed3ef61897c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -485,4 +485,5 @@ source "drivers/misc/xlink-pcie/Kconfig"
 source "drivers/misc/xlink-ipc/Kconfig"
 source "drivers/misc/xlink-core/Kconfig"
 source "drivers/misc/vpumgr/Kconfig"
+source "drivers/misc/intel_tsens/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 2936930f3edc..c08502b22778 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -61,3 +61,4 @@ obj-y                           += xlink-pcie/
 obj-$(CONFIG_XLINK_IPC)		+= xlink-ipc/
 obj-$(CONFIG_XLINK_CORE)	+= xlink-core/
 obj-$(CONFIG_VPUMGR)		+= vpumgr/
+obj-y                           += intel_tsens/
diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
new file mode 100644
index 000000000000..bfb8fe1997f4
--- /dev/null
+++ b/drivers/misc/intel_tsens/Kconfig
@@ -0,0 +1,15 @@
+# Copyright (C) 2020 Intel Corporation
+# SPDX-License-Identifier: GPL-2.0-only
+
+config INTEL_TSENS_LOCAL_HOST
+	bool "Temperature sensor driver for intel tsens"
+	select THERMAL
+	help
+	  This option enables tsens thermal local Host driver.
+
+	  This driver is used for reporting thermal data via thermal
+	  framework.
+	  Enable this option if you want to have support for thermal
+	  management controller.
+	  Say Y if using a processor that includes the Intel VPU such as
+	  Keem Bay.  If unsure, say N.
diff --git a/drivers/misc/intel_tsens/Makefile b/drivers/misc/intel_tsens/Makefile
new file mode 100644
index 000000000000..93dee8b9f481
--- /dev/null
+++ b/drivers/misc/intel_tsens/Makefile
@@ -0,0 +1,7 @@
+# Copyright (C) 2020 Intel Corporation
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for intel tsens Thermal Linux driver
+#
+
+obj-$(CONFIG_INTEL_TSENS_LOCAL_HOST)	+= intel_tsens_thermal.o
diff --git a/drivers/misc/intel_tsens/intel_tsens_thermal.c b/drivers/misc/intel_tsens/intel_tsens_thermal.c
new file mode 100644
index 000000000000..83aec191555c
--- /dev/null
+++ b/drivers/misc/intel_tsens/intel_tsens_thermal.c
@@ -0,0 +1,651 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *
+ * Intel tsens thermal Driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include "intel_tsens_thermal.h"
+
+struct intel_tsens_trip_info {
+	enum thermal_trip_type trip_type;
+	int temp;
+};
+
+struct intel_tsens {
+	char name[20];
+	u32 n_trips;
+	u32 passive_delay;
+	u32 polling_delay;
+	u32 sensor_type;
+	u64 addr;
+	u64 size;
+	u32 curr_temp;
+	void __iomem *base_addr;
+	struct intel_tsens_trip_info **trip_info;
+	struct thermal_zone_device *tz;
+	void *pdata;
+	struct intel_tsens_plat_info plat_info;
+};
+
+struct intel_tsens_priv {
+	int n_sens;
+	bool global_clk_available;
+	void __iomem *base_addr;
+	struct clk *tsens_clk;
+	u32 tsens_clk_rate;
+	struct intel_tsens **intel_tsens;
+	struct device *dev;
+	struct platform_device *pdev;
+	struct intel_tsens_plat_info plat_info;
+};
+
+static int intel_tsens_register_pdev(struct intel_tsens_plat_info *plat_info)
+{
+	struct intel_tsens_plat_data plat_data;
+	struct platform_device_info pdevinfo;
+	struct platform_device *dd;
+
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+	pdevinfo.name = plat_info->plat_name;
+	pdevinfo.id = plat_info->id;
+	plat_data.base_addr = plat_info->base_addr;
+	plat_data.name = plat_info->plat_name;
+	plat_data.get_temp = NULL;
+	pdevinfo.data = &plat_data;
+	pdevinfo.size_data = sizeof(plat_data);
+	dd = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(dd))
+		return -EINVAL;
+	plat_info->pdev = dd;
+
+	return 0;
+}
+
+static void intel_tsens_unregister_pdev(struct intel_tsens_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->n_sens; i++) {
+		if (priv->plat_info.pdev)
+			platform_device_unregister(priv->plat_info.pdev);
+	}
+}
+
+static int intel_tsens_add_pdev(struct intel_tsens_priv *priv)
+{
+	int i, ret;
+
+	/*
+	 * Register platform device for each sensor.
+	 *
+	 */
+	if (priv->plat_info.plat_name) {
+		priv->plat_info.base_addr = priv->base_addr;
+		ret = intel_tsens_register_pdev(&priv->plat_info);
+		if (ret) {
+			dev_err(&priv->pdev->dev,
+				"platform device register failed for %s\n",
+				priv->plat_info.plat_name);
+			return ret;
+		}
+	}
+	for (i = 0; i < priv->n_sens; i++) {
+		struct intel_tsens *tsens = priv->intel_tsens[i];
+
+		if (!tsens->plat_info.plat_name)
+			continue;
+		tsens->plat_info.base_addr = tsens->base_addr;
+		ret = intel_tsens_register_pdev(&tsens->plat_info);
+		if (ret) {
+			dev_err(&priv->pdev->dev,
+				"platform device register failed for %s\n",
+				tsens->name);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int intel_tsens_thermal_get_temp(struct thermal_zone_device *tz,
+					int *temp)
+{
+	struct intel_tsens *tsens = (struct intel_tsens *)tz->devdata;
+	struct intel_tsens_priv *priv =
+		(struct intel_tsens_priv *)tsens->pdata;
+	struct intel_tsens_plat_data *plat_data;
+	int type = tsens->sensor_type;
+	struct platform_device *pdev;
+
+	if (tsens->plat_info.plat_name) {
+		pdev = tsens->plat_info.pdev;
+		plat_data = pdev->dev.platform_data;
+
+		if (!plat_data) {
+			dev_err(&pdev->dev, "Platform data not found for %s\n",
+				tsens->name);
+			return -EINVAL;
+		}
+		if (!plat_data->get_temp) {
+			*temp = 0;
+			return -EINVAL;
+		}
+		if (plat_data->get_temp(pdev, type, temp))
+			return -EINVAL;
+		tsens->curr_temp = *temp;
+		return 0;
+	}
+	if (priv->plat_info.plat_name) {
+		pdev = priv->plat_info.pdev;
+		plat_data = pdev->dev.platform_data;
+
+		if (!plat_data) {
+			dev_err(&pdev->dev, "Platform data not found for %s\n",
+				tsens->name);
+			return -EINVAL;
+		}
+		if (!plat_data->get_temp) {
+			*temp = 0;
+			return -EINVAL;
+		}
+
+		if (plat_data->get_temp(pdev, type, temp))
+			return -EINVAL;
+		tsens->curr_temp = *temp;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int intel_tsens_thermal_get_trip_type(struct thermal_zone_device *tz,
+					     int trip,
+					     enum thermal_trip_type *type)
+{
+	struct intel_tsens *tsens = (struct intel_tsens *)tz->devdata;
+
+	*type = tsens->trip_info[trip]->trip_type;
+	return 0;
+}
+
+static int intel_tsens_thermal_get_trip_temp(struct thermal_zone_device *tz,
+					     int trip, int *temp)
+{
+	struct intel_tsens *tsens = (struct intel_tsens *)tz->devdata;
+
+	*temp = tsens->trip_info[trip]->temp;
+	return 0;
+}
+
+/* Refer https://lwn.net/Articles/242046/
+ * how to receive this event in userspace
+ */
+static int intel_tsens_notify_user_space(struct thermal_zone_device *tz,
+					 int trip)
+{
+	char *thermal_prop[5];
+	int i, ret = 0;
+
+	mutex_lock(&tz->lock);
+	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", tz->type);
+	thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d",
+				    tz->emul_temperature);
+	thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d", trip);
+	thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", tz->notify_event);
+	thermal_prop[4] = NULL;
+	if (thermal_prop[0] && thermal_prop[1] &&
+	    thermal_prop[2] && thermal_prop[3]) {
+		kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE,
+				   thermal_prop);
+	} else {
+		ret = -ENOMEM;
+	}
+	for (i = 0; i < 4; ++i)
+		kfree(thermal_prop[i]);
+	mutex_unlock(&tz->lock);
+	return ret;
+}
+
+static int intel_tsens_thermal_notify(struct thermal_zone_device *tz,
+				      int trip, enum thermal_trip_type type)
+{
+	intel_tsens_notify_user_space(tz, trip);
+
+	if (type == THERMAL_TRIP_PASSIVE || type == THERMAL_TRIP_CRITICAL)
+		return 1;
+	return 0;
+}
+
+static int intel_tsens_thermal_bind(struct thermal_zone_device *tz,
+				    struct thermal_cooling_device *cdev)
+{
+	struct intel_tsens *tsens = (struct intel_tsens *)tz->devdata;
+	struct intel_tsens_priv *priv =
+		(struct intel_tsens_priv *)tsens->pdata;
+	int ret = -EINVAL;
+
+	/*
+	 * Check here thermal device zone name and cdev name to match,
+	 * then call the bind device
+	 */
+	if (!strncmp(tz->type, cdev->type, THERMAL_NAME_LENGTH) == 0) {
+		ret = thermal_zone_bind_cooling_device
+				(tz,
+				THERMAL_TRIP_PASSIVE,
+				cdev,
+				THERMAL_NO_LIMIT,
+				THERMAL_NO_LIMIT,
+				THERMAL_WEIGHT_DEFAULT);
+		if (ret) {
+			dev_err(&priv->pdev->dev,
+				"binding zone %s with cdev %s failed:%d\n",
+				tz->type, cdev->type, ret);
+		}
+	}
+	return ret;
+}
+
+static int intel_tsens_thermal_unbind(struct thermal_zone_device *tz,
+				      struct thermal_cooling_device *cdev)
+{
+	int ret;
+
+	ret = thermal_zone_unbind_cooling_device(tz, 0, cdev);
+	if (ret) {
+		dev_err(&tz->device,
+			"unbinding zone %s with cdev %s failed:%d\n",
+			tz->type, cdev->type, ret);
+	}
+	return ret;
+}
+
+static struct thermal_zone_device_ops tsens_thermal_ops = {
+	.bind = intel_tsens_thermal_bind,
+	.unbind = intel_tsens_thermal_unbind,
+	.get_temp = intel_tsens_thermal_get_temp,
+	.get_trip_type	= intel_tsens_thermal_get_trip_type,
+	.get_trip_temp	= intel_tsens_thermal_get_trip_temp,
+	.notify		= intel_tsens_thermal_notify,
+/*	.set_emul_temp = tsens_thermal_emulation */
+
+};
+
+static int intel_tsens_get_temp(int type, int *temp, void *pdata)
+{
+	struct intel_tsens_priv *priv = (struct intel_tsens_priv *)pdata;
+
+	if (!priv)
+		return -EINVAL;
+
+	return intel_tsens_thermal_get_temp(priv->intel_tsens[type]->tz, temp);
+}
+
+struct intel_tsens_i2c_plat_data i2c_plat_data = {
+	.get_temp	= intel_tsens_get_temp,
+};
+
+static void intel_tsens_remove_thermal_zones(struct intel_tsens_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->n_sens; i++) {
+		struct intel_tsens *tsens = priv->intel_tsens[i];
+
+		if (tsens->tz) {
+			thermal_zone_device_unregister(tsens->tz);
+			tsens->tz = NULL;
+		}
+	}
+}
+
+static int intel_tsens_add_thermal_zones(struct intel_tsens_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->n_sens; i++) {
+		struct intel_tsens *tsens = priv->intel_tsens[i];
+
+		tsens->tz =
+		thermal_zone_device_register(tsens->name,
+					     tsens->n_trips,
+					     0,
+					     tsens,
+					     &tsens_thermal_ops,
+					     NULL,
+					     tsens->passive_delay,
+					     tsens->polling_delay);
+		if (IS_ERR(tsens->tz)) {
+			dev_err(&priv->pdev->dev,
+				"failed to register thermal zone device %s\n",
+				tsens->name);
+			return PTR_ERR(tsens->tz);
+		}
+	}
+
+	return 0;
+}
+
+static void intel_tsens_remove_clk(struct intel_tsens_priv *priv)
+{
+	struct platform_device *pdev = priv->pdev;
+
+	clk_disable_unprepare(priv->tsens_clk);
+	devm_clk_put(&pdev->dev, priv->tsens_clk);
+}
+
+static int intel_tsens_clk_config(struct intel_tsens_priv *priv)
+{
+	struct platform_device *pdev = priv->pdev;
+	int ret;
+
+	if (priv->global_clk_available) {
+		priv->tsens_clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(priv->tsens_clk)) {
+			ret = PTR_ERR(priv->tsens_clk);
+			if (ret != -EPROBE_DEFER) {
+				dev_err(&pdev->dev,
+					"failed to get thermal clk: %d\n", ret);
+			}
+			return PTR_ERR(priv->tsens_clk);
+		}
+		ret = clk_set_rate(priv->tsens_clk, priv->tsens_clk_rate);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to set rate for thermal clk: %d\n",
+				ret);
+			devm_clk_put(&pdev->dev, priv->tsens_clk);
+			return ret;
+		}
+		ret = clk_prepare_enable(priv->tsens_clk);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to enable thermal clk: %d\n",
+				ret);
+			devm_clk_put(&pdev->dev, priv->tsens_clk);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int intel_tsens_config_sensors(struct device_node *s_node,
+				      struct intel_tsens *tsens,
+				      int sensor_type)
+{
+	struct intel_tsens_priv *priv = (struct intel_tsens_priv *)tsens->pdata;
+	struct platform_device *pdev = priv->pdev;
+	s32 trip_temp_count, trip_temp_type_c, i;
+
+	of_property_read_string_index(s_node, "plat_name", 0,
+				      &tsens->plat_info.plat_name);
+	tsens->plat_info.id = 1 << sensor_type;
+	tsens->sensor_type = sensor_type;
+	if (of_property_read_u32(s_node, "passive_delay",
+				 &tsens->passive_delay)) {
+		dev_err(&pdev->dev,
+			"passive_delay missing in dt for %s\n",
+			tsens->name);
+		return -EINVAL;
+	}
+	if (of_property_read_u32(s_node, "polling_delay",
+				 &tsens->polling_delay)) {
+		dev_err(&pdev->dev,
+			"polling_delay missing in dt for %s\n",
+			tsens->name);
+		return -EINVAL;
+	}
+	trip_temp_count = of_property_count_u32_elems(s_node, "trip_temp");
+	trip_temp_type_c = of_property_count_strings(s_node, "trip_type");
+	if (trip_temp_count != trip_temp_type_c ||
+	    trip_temp_count <= 0 || trip_temp_type_c <= 0) {
+		dev_err(&pdev->dev,
+			"trip temp config is missing in dt for %s\n",
+			tsens->name);
+		return -EINVAL;
+	}
+
+	tsens->trip_info =
+		devm_kcalloc(&pdev->dev, trip_temp_count,
+			     sizeof(struct intel_tsens_trip_info *),
+			     GFP_KERNEL);
+	if (!tsens->trip_info)
+		return -ENOMEM;
+	tsens->n_trips = trip_temp_count;
+	for (i = 0; i < trip_temp_count; i++) {
+		struct intel_tsens_trip_info *trip_info;
+		const char *trip_name;
+
+		trip_info = devm_kzalloc(&pdev->dev,
+					 sizeof(struct intel_tsens_trip_info),
+					 GFP_KERNEL);
+		if (!trip_info)
+			return -ENOMEM;
+
+		of_property_read_u32_index(s_node, "trip_temp", i,
+					   &trip_info->temp);
+		of_property_read_string_index(s_node, "trip_type", i,
+					      &trip_name);
+		if (!strcmp(trip_name, "passive"))
+			trip_info->trip_type = THERMAL_TRIP_PASSIVE;
+		else if (!strcmp(trip_name, "critical"))
+			trip_info->trip_type = THERMAL_TRIP_CRITICAL;
+		else if (!strcmp(trip_name, "hot"))
+			trip_info->trip_type = THERMAL_TRIP_HOT;
+		else
+			trip_info->trip_type = THERMAL_TRIP_ACTIVE;
+		tsens->trip_info[i] = trip_info;
+	}
+
+	return 0;
+}
+
+static int intel_tsens_config_dt(struct intel_tsens_priv *priv)
+{
+	struct platform_device *pdev = priv->pdev;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *s_node = NULL, *node;
+	struct resource *res;
+	int i = 0, ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base_addr = devm_ioremap_resource(&pdev->dev, res);
+	node = of_parse_phandle(np, "soc-sensors", 0);
+	if (!node)
+		return -EINVAL;
+	priv->n_sens = of_get_child_count(node);
+	if (priv->n_sens == 0) {
+		dev_err(&pdev->dev, "No sensors configured in dt\n");
+		return -EINVAL;
+	}
+	priv->global_clk_available = of_property_read_bool(np, "clocks");
+	if (priv->global_clk_available) {
+		ret = of_property_read_u32(np, "clk-rate",
+					   &priv->tsens_clk_rate);
+		if (ret) {
+			dev_err(&pdev->dev, "clk-rate not available in dt");
+			return ret;
+		}
+	}
+	of_property_read_string_index(np, "plat_name", 0,
+				      &priv->plat_info.plat_name);
+	priv->intel_tsens =
+		devm_kcalloc(&pdev->dev, priv->n_sens,
+			     sizeof(struct intel_tsens *),
+			     GFP_KERNEL);
+	if (!priv->intel_tsens)
+		return -ENOMEM;
+	for_each_child_of_node(node, s_node) {
+		int r_count, size_count;
+		struct intel_tsens *ts;
+
+		ts = devm_kzalloc(&pdev->dev, sizeof(struct intel_tsens),
+				  GFP_KERNEL);
+		if (!ts){
+			of_node_put(s_node);
+			return -ENOMEM;
+		}
+		strcpy(ts->name, s_node->name);
+		if (!of_property_read_u32(s_node, "address-cells", &r_count) &&
+		    !of_property_read_u32(s_node, "size-cells", &size_count)) {
+			if (r_count > 1) {
+				ret = of_property_read_u64_index(s_node, "reg",
+								 0, &ts->addr);
+			} else {
+				u32 *addr = (u32 *)&ts->addr;
+
+				ret = of_property_read_u32_index(s_node, "reg",
+								 0, addr);
+			}
+			if (ret) {
+				dev_err(&pdev->dev, "Invalid reg base address");
+				of_node_put(s_node);
+				return ret;
+			}
+			if (size_count > 1) {
+				int index =
+					(r_count > 1) ? (r_count / 2) :
+					r_count;
+
+				ret = of_property_read_u64_index(s_node, "reg",
+								 index,
+								 &ts->size);
+			} else {
+				u32 *size = (u32 *)&ts->size;
+
+				ret = of_property_read_u32_index(s_node, "reg",
+								 r_count, size);
+			}
+			if (ret) {
+				dev_err(&pdev->dev, "Invalid size");
+				of_node_put(s_node);
+				return ret;
+			}
+			ts->base_addr = devm_ioremap(&pdev->dev,
+						     ts->addr,
+						     ts->size);
+		} else {
+			ts->base_addr = priv->base_addr;
+		}
+		if (!ts->base_addr) {
+			dev_err(&pdev->dev, "ioremap failed for %s\n",
+				ts->name);
+			of_node_put(s_node);
+			return -EINVAL;
+		}
+		ts->pdata = priv;
+		if (intel_tsens_config_sensors(s_node, ts, i)) {
+			dev_err(&pdev->dev,
+				"Missing sensor info in dts for %s\n",
+				ts->name);
+			of_node_put(s_node);
+			return -EINVAL;
+		}
+		priv->intel_tsens[i] = ts;
+		i++;
+	}
+
+	return 0;
+}
+
+static int intel_tsens_thermal_probe(struct platform_device *pdev)
+{
+	struct intel_tsens_priv *intel_tsens_priv;
+	int ret;
+
+	intel_tsens_priv = devm_kzalloc(&pdev->dev,
+					sizeof(struct intel_tsens_priv),
+					GFP_KERNEL);
+	if (!intel_tsens_priv)
+		return -ENOMEM;
+	intel_tsens_priv->pdev = pdev;
+	if (pdev->dev.of_node) {
+		ret = intel_tsens_config_dt(intel_tsens_priv);
+		if (ret) {
+			dev_err(&pdev->dev, "dt configuration failed\n");
+			return ret;
+		}
+	} else {
+		dev_err(&pdev->dev, "Non Device Tree build is not supported\n");
+		return -EINVAL;
+	}
+	ret = intel_tsens_clk_config(intel_tsens_priv);
+	if (ret) {
+		dev_err(&pdev->dev, "Thermal clk config failed\n");
+		return ret;
+	}
+	ret = intel_tsens_add_pdev(intel_tsens_priv);
+	if (ret) {
+		dev_err(&pdev->dev, "platform device registration failed\n");
+		goto remove_pdev;
+	}
+	ret = intel_tsens_add_thermal_zones(intel_tsens_priv);
+	if (ret) {
+		dev_err(&pdev->dev, "thermal zone configuration failed\n");
+		goto remove_tz;
+	}
+	platform_set_drvdata(pdev, intel_tsens_priv);
+	i2c_plat_data.pdata = intel_tsens_priv;
+	return 0;
+
+remove_tz:
+	intel_tsens_remove_thermal_zones(intel_tsens_priv);
+remove_pdev:
+	intel_tsens_unregister_pdev(intel_tsens_priv);
+	intel_tsens_remove_clk(intel_tsens_priv);
+	return ret;
+}
+
+/* Device Exit */
+static int intel_tsens_thermal_exit(struct platform_device *pdev)
+{
+	struct intel_tsens_priv *priv = platform_get_drvdata(pdev);
+
+	if (!priv) {
+		dev_err(&pdev->dev,
+			"unable to get private data\n");
+		return -EINVAL;
+	}
+	intel_tsens_remove_thermal_zones(priv);
+	intel_tsens_unregister_pdev(priv);
+	intel_tsens_remove_clk(priv);
+
+	return 0;
+}
+
+static const struct of_device_id intel_tsens_thermal_id_table[] = {
+	{ .compatible = "intel,intel-tsens" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, intel_tsens_thermal_id_table);
+
+static struct platform_driver intel_tsens_thermal_driver = {
+	.probe = intel_tsens_thermal_probe,
+	.remove = intel_tsens_thermal_exit,
+	.driver = {
+		.name = "intel_tsens_thermal",
+		.of_match_table = intel_tsens_thermal_id_table,
+	},
+};
+
+module_platform_driver(intel_tsens_thermal_driver);
+
+MODULE_DESCRIPTION("TSENS Thermal Driver");
+MODULE_AUTHOR("Sandeep Singh <sandeep1.singh@intel.com>");
+MODULE_AUTHOR("Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>");
+MODULE_AUTHOR("Udhayakumar C <udhayakumar.c@intel.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/misc/intel_tsens/intel_tsens_thermal.h b/drivers/misc/intel_tsens/intel_tsens_thermal.h
new file mode 100644
index 000000000000..a531c95b20b3
--- /dev/null
+++ b/drivers/misc/intel_tsens/intel_tsens_thermal.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *
+ * Intel tsens thermal Driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ */
+
+#ifndef _LINUX_INTEL_TSENS_H
+#define _LINUX_INTEL_TSENS_H
+
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+struct intel_tsens_plat_data {
+	const char *name;
+	void __iomem *base_addr;
+	int (*get_temp)(struct platform_device *pdev, int type, int *temp);
+	void *pdata;
+};
+
+struct intel_tsens_plat_info {
+	const char *plat_name;
+	int id;
+	struct platform_device *pdev;
+	void __iomem *base_addr;
+};
+
+struct intel_tsens_i2c_plat_data {
+	int (*get_temp)(int type, int *temp, void *pdata);
+	void *pdata;
+};
+
+/* TSENS i2c platform data */
+extern struct intel_tsens_i2c_plat_data i2c_plat_data;
+
+#endif /* _LINUX_INTEL_TSENS_H */
diff --git a/include/linux/hddl_device.h b/include/linux/hddl_device.h
new file mode 100644
index 000000000000..1c21ad27ea33
--- /dev/null
+++ b/include/linux/hddl_device.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *
+ * High Density Deep Learning Kernel module.
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ */
+
+#ifndef __HDDL_DEVICE_H
+#define __HDDL_DEVICE_H
+
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+#include <linux/types.h>
+#if IS_ENABLED(CONFIG_XLINK_CORE)
+#include <linux/xlink.h>
+#include <linux/xlink_drv_inf.h>
+#endif /* XLINK_CORE */
+
+#define HDDL_ALIGN 4
+
+#define HDDL_MAGIC 'x'
+#define HDDL_READ_SW_ID_DATA		_IOW(HDDL_MAGIC, 'a', void*)
+#define HDDL_SOFT_RESET		_IOW(HDDL_MAGIC, 'b', void*)
+
+struct sw_id_hddl_data {
+	u32 board_id;
+	u32 soc_id;
+	u32 soc_adaptor_no[2];
+	u32 sw_id;
+	u32 return_id;
+};
+
+struct sw_id_soft_reset {
+	u32 sw_id;
+	u32 return_id;
+};
+
+enum hddl_xlink_adapter {
+	HDDL_XLINK_I2C_MASTER,
+	HDDL_XLINK_I2C_SLAVE,
+	HDDL_XLINK_I2C_END,
+};
+
+enum hddl_device {
+	HDDL_I2C_CLIENT		= (1 << 0),
+	HDDL_XLINK_CLIENT	= (1 << 1),
+	HDDL_XLINK_SMBUS_CLIENT	= (1 << 2),
+};
+
+enum hddl_device_status {
+	HDDL_DEV_STATUS_START,
+	HDDL_DEV_STATUS_CONNECTED,
+	HDDL_DEV_STATUS_DISCONNECTED,
+	HDDL_DEV_STATUS_END,
+};
+
+enum hddl_msg_type {
+	HDDL_GET_NSENS		= 0x10,
+	HDDL_GET_SENS_NAME	= 0x11,
+	HDDL_GET_SENS_DETAILS	= 0x12,
+	HDDL_GET_SENS_TRIP_INFO	= 0x13,
+	HDDL_GET_N_I2C_DEVS	= 0x14,
+	HDDL_GET_I2C_DEVS	= 0x15,
+	HDDL_GET_I2C_DEV_ADDR	= 0x16,
+	HDDL_GET_SENS_COMPLETE	= 0x20,
+};
+
+struct intel_hddl_tsens_msg {
+	int msg_type;
+	u32 sensor_type;
+	u32 trip_info_idx;
+} __packed __aligned(HDDL_ALIGN);
+
+struct intel_hddl_board_info {
+	int board_id;
+	int soc_id;
+} __packed __aligned(HDDL_ALIGN);
+
+struct intel_tsens_data {
+	char name[20];
+	u32 n_trips;
+	u32 passive_delay;
+	u32 polling_delay;
+	u32 sensor_type;
+} __packed __aligned(HDDL_ALIGN);
+
+struct intel_hddl_i2c_devs_data {
+	char name[20];
+	u32 addr;
+	u32 bus;
+	int enabled;
+	int local_host;
+	int remote_host;
+} __packed __aligned(HDDL_ALIGN);
+
+struct intel_hddl_i2c_devs {
+	char name[20];
+	u32 addr;
+	u32 bus;
+	int enabled;
+	int local_host;
+	int remote_host;
+	struct i2c_board_info board_info;
+	struct i2c_client *xlk_client;
+	struct i2c_client *i2c_client;
+	struct i2c_client *smbus_client;
+};
+
+struct intel_hddl_clients {
+#if IS_ENABLED(CONFIG_XLINK_CORE)
+	struct xlink_handle xlink_dev;
+#endif /* XLINK_CORE */
+	struct task_struct *hddl_dev_connect_task;
+	void *task;
+	u32 chan_num;
+	void *pdata;
+	struct intel_hddl_board_info board_info;
+	u32 xlink_i2c_ch[HDDL_XLINK_I2C_END];
+	u32 i2c_chan_num;
+	void **tsens;
+	u32 nsens;
+	struct platform_device *xlink_i2c_plt_dev[HDDL_XLINK_I2C_END];
+	struct platform_device *pdev;
+	struct i2c_adapter *adap[HDDL_XLINK_I2C_END];
+	struct i2c_adapter *smbus_adap;
+	struct intel_hddl_i2c_devs **i2c_devs;
+	int n_clients;
+	enum hddl_device_status status;
+	/* hddl device lock */
+	struct mutex lock;
+};
+
+struct intel_tsens_trip_info {
+	enum thermal_trip_type trip_type;
+	int temp;
+} __packed __aligned(HDDL_ALIGN);
+
+#if IS_ENABLED(CONFIG_XLINK_CORE)
+static inline u32 tsens_get_device_id(struct intel_hddl_clients *d)
+{
+	return d->xlink_dev.sw_device_id;
+}
+#else
+static inline u32 tsens_get_device_id(struct intel_hddl_clients *d)
+{
+	return -EINVAL;
+}
+#endif /* XLINK_CORE */
+
+#endif /* __HDDL_DEVICE_H */
-- 
2.17.1

