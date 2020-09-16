Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F80826BA95
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIPDT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:19:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:57885 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIPDTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:19:25 -0400
IronPort-SDR: Vqe5QGyHUCFYMVJ6F88zDxlBol46u25FxBnpGo221RTkycGIwIh8Qoc6JFHfYYVxDVnMlx2T+l
 x39dzigDLpDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="160324850"
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="160324850"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 20:19:19 -0700
IronPort-SDR: xvvtnPMW7TRxgeEVUPvvJIx1yB8CUwIKziPlKNI8FigQCqXBSNM94PVMfgnjLAFO8KHG/Jhh0J
 tMCvcolIoRKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="507842371"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2020 20:19:16 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     linux@roeck-us.net, jdelvare@suse.com, lee.jones@linaro.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, mdf@kernel.org
Subject: [PATCH v2] hwmon: intel-m10-bmc-hwmon: add hwmon support for Intel MAX 10 BMC
Date:   Wed, 16 Sep 2020 11:14:22 +0800
Message-Id: <1600226062-25755-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600226062-25755-1-git-send-email-yilun.xu@intel.com>
References: <1600226062-25755-1-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds hwmon functionality for Intel MAX 10 BMC chip. This BMC
chip connects to a set of sensor chips to monitor current, voltage,
thermal and power of different components on board. The BMC firmware is
responsible for sensor data sampling and recording in shared registers.
Host driver reads the sensor data from these shared registers and
exposes them to users as hwmon interfaces.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: add the Documentation
    refactor the code, provide static hwmon_channel_info
    remove Unnecessary hwmon-sysfs.h
    make the sensor data table const
---
 Documentation/hwmon/index.rst               |   1 +
 Documentation/hwmon/intel-m10-bmc-hwmon.rst |  78 ++++++
 drivers/hwmon/Kconfig                       |  11 +
 drivers/hwmon/Makefile                      |   1 +
 drivers/hwmon/intel-m10-bmc-hwmon.c         | 355 ++++++++++++++++++++++++++++
 5 files changed, 446 insertions(+)
 create mode 100644 Documentation/hwmon/intel-m10-bmc-hwmon.rst
 create mode 100644 drivers/hwmon/intel-m10-bmc-hwmon.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index a926f1a..4bcb1a7 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -74,6 +74,7 @@ Hardware Monitoring Kernel Drivers
    ina209
    ina2xx
    ina3221
+   intel-m10-bmc-hwmon
    ir35221
    ir38064
    isl68137
diff --git a/Documentation/hwmon/intel-m10-bmc-hwmon.rst b/Documentation/hwmon/intel-m10-bmc-hwmon.rst
new file mode 100644
index 0000000..3d148c6
--- /dev/null
+++ b/Documentation/hwmon/intel-m10-bmc-hwmon.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver intel-m10-bmc-hwmon
+=================================
+
+Supported chips:
+
+ * Intel MAX 10 BMC for Intel PAC N3000
+
+   Prefix: 'n3000bmc-hwmon'
+
+Author: Xu Yilun <yilun.xu@intel.com>
+
+
+Description
+-----------
+
+This driver adds the temperature, voltage, current and power reading
+support for the Intel MAX 10 Board Management Controller (BMC) chip.
+The BMC chip is integrated in some Intel Programmable Acceleration
+Cards (PAC). It connects to a set of sensor chips to monitor the
+sensor data of different components on the board. The BMC firmware is
+responsible for sensor data sampling and recording in shared
+registers. The host driver reads the sensor data from these shared
+registers and exposes them to users as hwmon interfaces.
+
+The BMC chip is implemented using the Intel MAX 10 CPLD. It could be
+reprogramed to some variants in order to support different Intel
+PACs. The driver is designed to be able to distinguish between the
+variants, but now it only supports the BMC for Intel PAC N3000.
+
+
+Sysfs attributes
+----------------
+
+The following attributes are supported:
+
+- Intel MAX 10 BMC for Intel PAC N3000:
+
+======================= =======================================================
+tempX_input             Temperature of the component (specified by tempX_label)
+tempX_max               Temperature maximum setpoint of the component
+tempX_crit              Temperature critical setpoint of the component
+tempX_max_hyst          Hysteresis for temperature maximum of the component
+tempX_crit_hyst         Hysteresis for temperature critical of the component
+temp1_label             "Board Temperature"
+temp2_label             "FPGA Die Temperature"
+temp3_label             "QSFP0 Temperature"
+temp4_label             "QSFP1 Temperature"
+temp5_label             "Retimer A Temperature"
+temp6_label             "Retimer A SerDes Temperature"
+temp7_label             "Retimer B Temperature"
+temp8_label             "Retimer B SerDes Temperature"
+
+inX_input               Measured voltage of the component (specified by
+                        inX_label)
+in0_label               "QSFP0 Supply Voltage"
+in1_label               "QSFP1 Supply Voltage"
+in2_label               "FPGA Core Voltage"
+in3_label               "12V Backplane Voltage"
+in4_label               "1.2V Voltage"
+in5_label               "12V AUX Voltage"
+in6_label               "1.8V Voltage"
+in7_label               "3.3V Voltage"
+
+currX_input             Measured current of the component (specified by
+                        currX_label)
+curr1_label             "FPGA Core Current"
+curr2_label             "12V Backplane Current"
+curr3_label             "12V AUX Current"
+
+powerX_input            Measured power of the component (specified by
+                        powerX_label)
+power1_label            "Board Power"
+
+======================= =======================================================
+
+All the attributes are read-only.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 8dc28b2..53af15c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2064,6 +2064,17 @@ config SENSORS_XGENE
 	  If you say yes here you get support for the temperature
 	  and power sensors for APM X-Gene SoC.
 
+config SENSORS_INTEL_M10_BMC_HWMON
+	tristate "Intel MAX10 BMC Hardware Monitoring"
+	depends on MFD_INTEL_M10_BMC
+	help
+	  This driver provides support for the hardware monitoring functionality
+	  on Intel MAX10 BMC chip.
+
+	  This BMC Chip is used on Intel FPGA PCIe Acceleration Cards (PAC). Its
+	  sensors monitor various telemetry data of different components on the
+	  card, e.g. board temperature, FPGA core temperature/voltage/current.
+
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index a8f4b35..ba5a25a 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
 obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
 obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
 obj-$(CONFIG_SENSORS_INA3221)	+= ina3221.o
+obj-$(CONFIG_SENSORS_INTEL_M10_BMC_HWMON) += intel-m10-bmc-hwmon.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
new file mode 100644
index 0000000..ce73545
--- /dev/null
+++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel MAX 10 BMC HWMON Driver
+ *
+ * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
+ *
+ */
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+
+struct m10bmc_sdata {
+	unsigned int reg_input;
+	unsigned int reg_max;
+	unsigned int reg_crit;
+	unsigned int reg_hyst;
+	unsigned int reg_min;
+	unsigned int multiplier;
+	const char *label;
+};
+
+struct m10bmc_hwmon_board_data {
+	const struct m10bmc_sdata *temp;
+	const struct m10bmc_sdata *in;
+	const struct m10bmc_sdata *curr;
+	const struct m10bmc_sdata *power;
+	const struct hwmon_channel_info **hinfo;
+};
+
+struct m10bmc_hwmon {
+	struct device *dev;
+	struct hwmon_chip_info chip;
+	char *hw_name;
+	struct intel_m10bmc *m10bmc;
+	struct m10bmc_hwmon_board_data *bdata;
+};
+
+static const struct m10bmc_sdata n3000bmc_temp_tbl[] = {
+	{ 0x100, 0x104, 0x108, 0x10c, 0x0, 500, "Board Temperature" },
+	{ 0x110, 0x114, 0x118, 0x0, 0x0, 500, "FPGA Die Temperature" },
+	{ 0x11c, 0x124, 0x120, 0x0, 0x0, 500, "QSFP0 Temperature" },
+	{ 0x12c, 0x134, 0x130, 0x0, 0x0, 500, "QSFP1 Temperature" },
+	{ 0x168, 0x0, 0x0, 0x0, 0x0, 500, "Retimer A Temperature" },
+	{ 0x16c, 0x0, 0x0, 0x0, 0x0, 500, "Retimer A SerDes Temperature" },
+	{ 0x170, 0x0, 0x0, 0x0, 0x0, 500, "Retimer B Temperature" },
+	{ 0x174, 0x0, 0x0, 0x0, 0x0, 500, "Retimer B SerDes Temperature" },
+};
+
+static const struct m10bmc_sdata n3000bmc_in_tbl[] = {
+	{ 0x128, 0x0, 0x0, 0x0, 0x0, 1, "QSFP0 Supply Voltage" },
+	{ 0x138, 0x0, 0x0, 0x0, 0x0, 1, "QSFP1 Supply Voltage" },
+	{ 0x13c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA Core Voltage" },
+	{ 0x144, 0x0, 0x0, 0x0, 0x0, 1, "12V Backplane Voltage" },
+	{ 0x14c, 0x0, 0x0, 0x0, 0x0, 1, "1.2V Voltage" },
+	{ 0x150, 0x0, 0x0, 0x0, 0x0, 1, "12V AUX Voltage" },
+	{ 0x158, 0x0, 0x0, 0x0, 0x0, 1, "1.8V Voltage" },
+	{ 0x15c, 0x0, 0x0, 0x0, 0x0, 1, "3.3V Voltage" },
+};
+
+static const struct m10bmc_sdata n3000bmc_curr_tbl[] = {
+	{ 0x140, 0x0, 0x0, 0x0, 0x0, 1, "FPGA Core Current" },
+	{ 0x148, 0x0, 0x0, 0x0, 0x0, 1, "12V Backplane Current" },
+	{ 0x154, 0x0, 0x0, 0x0, 0x0, 1, "12V AUX Current" },
+};
+
+static const struct m10bmc_sdata n3000bmc_power_tbl[] = {
+	{ 0x160, 0x0, 0x0, 0x0, 0x0, 1000, "Board Power" },
+};
+
+static const struct hwmon_channel_info *n3000bmc_hinfo[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL),
+	HWMON_CHANNEL_INFO(power,
+			   HWMON_P_INPUT | HWMON_P_LABEL),
+	NULL
+};
+
+struct m10bmc_hwmon_board_data n3000bmc_hwmon_bdata = {
+	.temp = n3000bmc_temp_tbl,
+	.in = n3000bmc_in_tbl,
+	.curr = n3000bmc_curr_tbl,
+	.power = n3000bmc_power_tbl,
+	.hinfo = n3000bmc_hinfo,
+};
+
+static umode_t
+m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
+			u32 attr, int channel)
+{
+	return 0444;
+}
+
+static const struct m10bmc_sdata *
+find_sensor_data(struct m10bmc_hwmon *hw, enum hwmon_sensor_types type,
+		 int channel)
+{
+	const struct m10bmc_sdata *tbl;
+
+	switch (type) {
+	case hwmon_temp:
+		tbl = hw->bdata->temp;
+		break;
+	case hwmon_in:
+		tbl = hw->bdata->in;
+		break;
+	case hwmon_curr:
+		tbl = hw->bdata->curr;
+		break;
+	case hwmon_power:
+		tbl = hw->bdata->power;
+		break;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (!tbl)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return &tbl[channel];
+}
+
+static int do_sensor_read(struct m10bmc_hwmon *hw,
+			  const struct m10bmc_sdata *data,
+			  unsigned int regoff, long *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = m10bmc_sys_read(hw->m10bmc, regoff, &regval);
+	if (ret)
+		return ret;
+
+	/*
+	 * BMC Firmware will return 0xdeadbeef if the sensor value is invalid
+	 * at that time. This usually happens on sensor channels which connect
+	 * to external pluggable modules, e.g. QSFP temperature and voltage.
+	 * When the QSFP is unplugged from cage, driver will get 0xdeadbeef
+	 * from their registers.
+	 */
+	if (regval == 0xdeadbeef)
+		return -EBUSY;
+
+	*val = regval * data->multiplier;
+
+	return 0;
+}
+
+static int m10bmc_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			     u32 attr, int channel, long *val)
+{
+	struct m10bmc_hwmon *hw = dev_get_drvdata(dev);
+	unsigned int reg = 0, reg_hyst = 0;
+	const struct m10bmc_sdata *data;
+	long hyst, value;
+	int ret;
+
+	data = find_sensor_data(hw, type, channel);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			reg = data->reg_input;
+			break;
+		case hwmon_temp_max_hyst:
+			reg_hyst = data->reg_hyst;
+			fallthrough;
+		case hwmon_temp_max:
+			reg = data->reg_max;
+			break;
+		case hwmon_temp_crit_hyst:
+			reg_hyst = data->reg_hyst;
+			fallthrough;
+		case hwmon_temp_crit:
+			reg = data->reg_crit;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			reg = data->reg_input;
+			break;
+		case hwmon_in_max:
+			reg = data->reg_max;
+			break;
+		case hwmon_in_crit:
+			reg = data->reg_crit;
+			break;
+		case hwmon_in_min:
+			reg = data->reg_min;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			reg = data->reg_input;
+			break;
+		case hwmon_curr_max:
+			reg = data->reg_max;
+			break;
+		case hwmon_curr_crit:
+			reg = data->reg_crit;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			reg = data->reg_input;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (!reg)
+		return -EOPNOTSUPP;
+
+	ret = do_sensor_read(hw, data, reg, &value);
+	if (ret)
+		return ret;
+
+	if (reg_hyst) {
+		ret = do_sensor_read(hw, data, reg_hyst, &hyst);
+		if (ret)
+			return ret;
+
+		value -= hyst;
+	}
+
+	*val = value;
+
+	return ret;
+}
+
+static int m10bmc_hwmon_read_string(struct device *dev,
+				    enum hwmon_sensor_types type,
+				    u32 attr, int channel, const char **str)
+{
+	struct m10bmc_hwmon *hw = dev_get_drvdata(dev);
+	const struct m10bmc_sdata *data;
+
+	data = find_sensor_data(hw, type, channel);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	*str = data->label;
+
+	return 0;
+}
+
+static const struct hwmon_ops m10bmc_hwmon_ops = {
+	.is_visible = m10bmc_hwmon_is_visible,
+	.read = m10bmc_hwmon_read,
+	.read_string = m10bmc_hwmon_read_string,
+};
+
+static int m10bmc_hwmon_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct intel_m10bmc *m10bmc = dev_get_drvdata(pdev->dev.parent);
+	struct device *hwmon_dev, *dev = &pdev->dev;
+	struct m10bmc_hwmon *hw;
+	int i;
+
+	if (!id || !id->driver_data) {
+		dev_err(dev, "Failed to get board data\n");
+		return -ENODEV;
+	}
+
+	hw = devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return -ENOMEM;
+
+	hw->dev = dev;
+	hw->m10bmc = m10bmc;
+	hw->bdata = (struct m10bmc_hwmon_board_data *)id->driver_data;
+
+	hw->chip.info = hw->bdata->hinfo;
+	hw->chip.ops = &m10bmc_hwmon_ops;
+
+	hw->hw_name = devm_kstrdup(dev, id->name, GFP_KERNEL);
+	if (!hw->hw_name)
+		return -ENOMEM;
+
+	for (i = 0; hw->hw_name[i]; i++)
+		if (hwmon_is_bad_char(hw->hw_name[i]))
+			hw->hw_name[i] = '_';
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, hw->hw_name,
+							 hw, &hw->chip, NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct platform_device_id intel_m10bmc_hwmon_ids[] = {
+	{
+		.name = "n3000bmc-hwmon",
+		.driver_data = (unsigned long)&n3000bmc_hwmon_bdata,
+	},
+	{ }
+};
+
+static struct platform_driver intel_m10bmc_hwmon_driver = {
+	.probe = m10bmc_hwmon_probe,
+	.driver = {
+		.name = "intel-m10-bmc-hwmon",
+	},
+	.id_table = intel_m10bmc_hwmon_ids,
+};
+module_platform_driver(intel_m10bmc_hwmon_driver);
+
+MODULE_DEVICE_TABLE(platform, intel_m10bmc_hwmon_ids);
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel MAX 10 BMC hardware monitor");
+MODULE_LICENSE("GPL");
-- 
2.7.4

