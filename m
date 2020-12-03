Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584962CD01B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388072AbgLCHII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:08:08 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61440 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387393AbgLCHIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:08:07 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B375B36025485;
        Thu, 3 Dec 2020 02:07:13 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 355vjemw6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 02:07:12 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0B377BGV062119
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Dec 2020 02:07:11 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 3 Dec 2020
 02:07:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 3 Dec 2020 02:07:10 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0B3775E6018799;
        Thu, 3 Dec 2020 02:07:07 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <Weston.Sapia@analog.com>, <Brad.Lovell@analog.com>,
        <Sal.Afzal@analog.com>, <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v3 1/3] hwmon: ltc2992: Add support
Date:   Thu, 3 Dec 2020 09:11:53 +0200
Message-ID: <20201203071155.68859-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203071155.68859-1-alexandru.tachici@analog.com>
References: <20201203071155.68859-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_03:2020-11-30,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

LTC2992 is a rail-to-rail system monitor that
measures current, voltage, and power of two supplies.

Two ADCs simultaneously measure each supply’s current.
A third ADC monitors the input voltages and four
auxiliary external voltages.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/ltc2992.rst |  56 +++
 drivers/hwmon/Kconfig           |  11 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/ltc2992.c         | 813 ++++++++++++++++++++++++++++++++
 5 files changed, 882 insertions(+)
 create mode 100644 Documentation/hwmon/ltc2992.rst
 create mode 100644 drivers/hwmon/ltc2992.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index e6b91ab12978..98575a8b1918 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -100,6 +100,7 @@ Hardware Monitoring Kernel Drivers
    lm95234
    lm95245
    lochnagar
+   ltc2992
    ltc2945
    ltc2947
    ltc2978
diff --git a/Documentation/hwmon/ltc2992.rst b/Documentation/hwmon/ltc2992.rst
new file mode 100644
index 000000000000..46aa1aa84a1a
--- /dev/null
+++ b/Documentation/hwmon/ltc2992.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver ltc2992
+=====================
+
+Supported chips:
+  * Linear Technology LTC2992
+    Prefix: 'ltc2992'
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2992.pdf
+
+Author: Alexandru Tachici <alexandru.tachici@analog.com>
+
+
+Description
+-----------
+
+This driver supports hardware monitoring for Linear Technology LTC2992 power monitor.
+
+LTC2992 is a rail-to-rail system monitor that measures current,
+voltage, and power of two supplies.
+
+Two ADCs simultaneously measure each supply’s current. A third ADC monitors
+the input voltages and four auxiliary external voltages.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported. Limits are read-write,
+all other attributes are read-only.
+
+in_reset_history	Reset all highest/lowest values.
+
+inX_input		Measured voltage.
+inX_lowest		Minimum measured voltage.
+inX_highest		Maximum measured voltage.
+inX_min			Minimum voltage allowed.
+inX_max			Maximum voltage allowed.
+inX_min_alarm		An undervoltage occurred. Cleared on read.
+inX_max_alarm		An overvoltage occurred. Cleared on read.
+
+currX_input		Measured current.
+currX_lowest		Minimum measured current.
+currX_highest		Maximum measured current.
+currX_min		Minimum current allowed.
+currX_max		Maximum current allowed.
+currX_min_alarm		An undercurrent occurred. Cleared on read.
+currX_max_alarm		An overcurrent occurred. Cleared on read.
+
+powerX_input		Measured power.
+powerX_input_lowest	Minimum measured voltage.
+powerX_input_highest	Maximum measured voltage.
+powerX_min		Minimum power.
+powerX_max		Maximum power.
+powerX_min_alarm	An underpower occurred. Cleared on read.
+powerX_max_alarm	An overpower occurred. Cleared on read.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a850e4f0e0bd..bf9e387270d6 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -858,6 +858,17 @@ config SENSORS_LTC2990
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2990.
 
+config SENSORS_LTC2992
+	tristate "Linear Technology LTC2992"
+	depends on I2C
+	help
+	  If you say yes here you get support for Linear Technology LTC2992
+	  I2C System Monitor. The LTC2992 measures current, voltage, and
+	  power of two supplies.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc2992.
+
 config SENSORS_LTC4151
 	tristate "Linear Technology LTC4151"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 9db2903b61e5..d6172c4807c4 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_SENSORS_LTC2947)	+= ltc2947-core.o
 obj-$(CONFIG_SENSORS_LTC2947_I2C) += ltc2947-i2c.o
 obj-$(CONFIG_SENSORS_LTC2947_SPI) += ltc2947-spi.o
 obj-$(CONFIG_SENSORS_LTC2990)	+= ltc2990.o
+obj-$(CONFIG_SENSORS_LTC2992)	+= ltc2992.o
 obj-$(CONFIG_SENSORS_LTC4151)	+= ltc4151.o
 obj-$(CONFIG_SENSORS_LTC4215)	+= ltc4215.o
 obj-$(CONFIG_SENSORS_LTC4222)	+= ltc4222.o
diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
new file mode 100644
index 000000000000..c11d585a9600
--- /dev/null
+++ b/drivers/hwmon/ltc2992.c
@@ -0,0 +1,813 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * LTC2992 - Dual Wide Range Power Monitor
+ *
+ * Copyright 2020 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#define LTC2992_CTRLB			0x01
+#define LTC2992_FAULT1			0x03
+#define LTC2992_POWER1			0x05
+#define LTC2992_POWER1_MAX		0x08
+#define LTC2992_POWER1_MIN		0x0B
+#define LTC2992_POWER1_MAX_THRESH	0x0E
+#define LTC2992_POWER1_MIN_THRESH	0x11
+#define LTC2992_DSENSE1			0x14
+#define LTC2992_DSENSE1_MAX		0x16
+#define LTC2992_DSENSE1_MIN		0x18
+#define LTC2992_DSENSE1_MAX_THRESH	0x1A
+#define LTC2992_DSENSE1_MIN_THRESH	0x1C
+#define LTC2992_SENSE1			0x1E
+#define LTC2992_SENSE1_MAX		0x20
+#define LTC2992_SENSE1_MIN		0x22
+#define LTC2992_SENSE1_MAX_THRESH	0x24
+#define LTC2992_SENSE1_MIN_THRESH	0x26
+#define LTC2992_G1			0x28
+#define LTC2992_G1_MAX			0x2A
+#define LTC2992_G1_MIN			0x2C
+#define LTC2992_G1_MAX_THRESH		0x2E
+#define LTC2992_G1_MIN_THRESH		0x30
+#define LTC2992_FAULT2			0x35
+#define LTC2992_G2			0x5A
+#define LTC2992_G2_MAX			0x5C
+#define LTC2992_G2_MIN			0x5E
+#define LTC2992_G2_MAX_THRESH		0x60
+#define LTC2992_G2_MIN_THRESH		0x62
+#define LTC2992_G3			0x64
+#define LTC2992_G3_MAX			0x66
+#define LTC2992_G3_MIN			0x68
+#define LTC2992_G3_MAX_THRESH		0x6A
+#define LTC2992_G3_MIN_THRESH		0x6C
+#define LTC2992_G4			0x6E
+#define LTC2992_G4_MAX			0x70
+#define LTC2992_G4_MIN			0x72
+#define LTC2992_G4_MAX_THRESH		0x74
+#define LTC2992_G4_MIN_THRESH		0x76
+#define LTC2992_FAULT3			0x92
+
+#define LTC2992_POWER(x)		(LTC2992_POWER1 + ((x) * 0x32))
+#define LTC2992_POWER_MAX(x)		(LTC2992_POWER1_MAX + ((x) * 0x32))
+#define LTC2992_POWER_MIN(x)		(LTC2992_POWER1_MIN + ((x) * 0x32))
+#define LTC2992_POWER_MAX_THRESH(x)	(LTC2992_POWER1_MAX_THRESH + ((x) * 0x32))
+#define LTC2992_POWER_MIN_THRESH(x)	(LTC2992_POWER1_MIN_THRESH + ((x) * 0x32))
+#define LTC2992_DSENSE(x)		(LTC2992_DSENSE1 + ((x) * 0x32))
+#define LTC2992_DSENSE_MAX(x)		(LTC2992_DSENSE1_MAX + ((x) * 0x32))
+#define LTC2992_DSENSE_MIN(x)		(LTC2992_DSENSE1_MIN + ((x) * 0x32))
+#define LTC2992_DSENSE_MAX_THRESH(x)	(LTC2992_DSENSE1_MAX_THRESH + ((x) * 0x32))
+#define LTC2992_DSENSE_MIN_THRESH(x)	(LTC2992_DSENSE1_MIN_THRESH + ((x) * 0x32))
+#define LTC2992_SENSE(x)		(LTC2992_SENSE1 + ((x) * 0x32))
+#define LTC2992_SENSE_MAX(x)		(LTC2992_SENSE1_MAX + ((x) * 0x32))
+#define LTC2992_SENSE_MIN(x)		(LTC2992_SENSE1_MIN + ((x) * 0x32))
+#define LTC2992_SENSE_MAX_THRESH(x)	(LTC2992_SENSE1_MAX_THRESH + ((x) * 0x32))
+#define LTC2992_SENSE_MIN_THRESH(x)	(LTC2992_SENSE1_MIN_THRESH + ((x) * 0x32))
+#define LTC2992_POWER_FAULT(x)		(LTC2992_FAULT1 + ((x) * 0x32))
+#define LTC2992_SENSE_FAULT(x)		(LTC2992_FAULT1 + ((x) * 0x32))
+#define LTC2992_DSENSE_FAULT(x)		(LTC2992_FAULT1 + ((x) * 0x32))
+
+/* CTRLB register bitfields */
+#define LTC2992_RESET_HISTORY		BIT(3)
+
+/* FAULT1 FAULT2 registers common bitfields */
+#define LTC2992_POWER_FAULT_MSK(x)	(BIT(6) << (x))
+#define LTC2992_DSENSE_FAULT_MSK(x)	(BIT(4) << (x))
+#define LTC2992_SENSE_FAULT_MSK(x)	(BIT(2) << (x))
+
+/* FAULT1 bitfields */
+#define LTC2992_GPIO1_FAULT_MSK(x)	(BIT(0) << (x))
+
+/* FAULT2 bitfields */
+#define LTC2992_GPIO2_FAULT_MSK(x)	(BIT(0) << (x))
+
+/* FAULT3 bitfields */
+#define LTC2992_GPIO3_FAULT_MSK(x)	(BIT(6) << (x))
+#define LTC2992_GPIO4_FAULT_MSK(x)	(BIT(4) << (x))
+
+#define LTC2992_IADC_NANOV_LSB		12500
+#define LTC2992_VADC_UV_LSB		25000
+#define LTC2992_VADC_GPIO_UV_LSB	500
+
+struct ltc2992_state {
+	struct i2c_client		*client;
+	struct regmap			*regmap;
+	u32				r_sense_uohm[2];
+};
+
+struct ltc2992_gpio_regs {
+	u8	data;
+	u8	max;
+	u8	min;
+	u8	max_thresh;
+	u8	min_thresh;
+	u8	alarm;
+	u8	min_alarm_msk;
+	u8	max_alarm_msk;
+};
+
+static const struct ltc2992_gpio_regs ltc2992_gpio_addr_map[] = {
+	{
+		.data = LTC2992_G1,
+		.max = LTC2992_G1_MAX,
+		.min = LTC2992_G1_MIN,
+		.max_thresh = LTC2992_G1_MAX_THRESH,
+		.min_thresh = LTC2992_G1_MIN_THRESH,
+		.alarm = LTC2992_FAULT1,
+		.min_alarm_msk = LTC2992_GPIO1_FAULT_MSK(0),
+		.max_alarm_msk = LTC2992_GPIO1_FAULT_MSK(1),
+	},
+	{
+		.data = LTC2992_G2,
+		.max = LTC2992_G2_MAX,
+		.min = LTC2992_G2_MIN,
+		.max_thresh = LTC2992_G2_MAX_THRESH,
+		.min_thresh = LTC2992_G2_MIN_THRESH,
+		.alarm = LTC2992_FAULT2,
+		.min_alarm_msk = LTC2992_GPIO2_FAULT_MSK(0),
+		.max_alarm_msk = LTC2992_GPIO2_FAULT_MSK(1),
+	},
+	{
+		.data = LTC2992_G3,
+		.max = LTC2992_G3_MAX,
+		.min = LTC2992_G3_MIN,
+		.max_thresh = LTC2992_G3_MAX_THRESH,
+		.min_thresh = LTC2992_G3_MIN_THRESH,
+		.alarm = LTC2992_FAULT3,
+		.min_alarm_msk = LTC2992_GPIO3_FAULT_MSK(0),
+		.max_alarm_msk = LTC2992_GPIO3_FAULT_MSK(1),
+	},
+	{
+		.data = LTC2992_G4,
+		.max = LTC2992_G4_MAX,
+		.min = LTC2992_G4_MIN,
+		.max_thresh = LTC2992_G4_MAX_THRESH,
+		.min_thresh = LTC2992_G4_MIN_THRESH,
+		.alarm = LTC2992_FAULT3,
+		.min_alarm_msk = LTC2992_GPIO4_FAULT_MSK(0),
+		.max_alarm_msk = LTC2992_GPIO4_FAULT_MSK(1),
+	},
+};
+
+static int ltc2992_read_reg(struct ltc2992_state *st, u8 addr, const u8 reg_len)
+{
+	u8 regvals[4];
+	int ret;
+	int val;
+	int i;
+
+	ret = regmap_bulk_read(st->regmap, addr, regvals, reg_len);
+	if (ret < 0)
+		return ret;
+
+	val = 0;
+	for (i = 0; i < reg_len; i++)
+		val |= regvals[reg_len - i - 1] << (i * 8);
+
+	return val;
+}
+
+static int ltc2992_write_reg(struct ltc2992_state *st, u8 addr, const u8 reg_len, u32 val)
+{
+	u8 regvals[4];
+	int i;
+
+	for (i = 0; i < reg_len; i++)
+		regvals[reg_len - i - 1] = (val >> (i * 8)) & 0xFF;
+
+	return regmap_bulk_write(st->regmap, addr, regvals, reg_len);
+}
+
+static umode_t ltc2992_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
+				  int channel)
+{
+	const struct ltc2992_state *st = data;
+
+	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_in_reset_history:
+			return 0200;
+		}
+		break;
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+		case hwmon_in_lowest:
+		case hwmon_in_highest:
+		case hwmon_in_min_alarm:
+		case hwmon_in_max_alarm:
+			return 0444;
+		case hwmon_in_min:
+		case hwmon_in_max:
+			return 0644;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+		case hwmon_curr_lowest:
+		case hwmon_curr_highest:
+		case hwmon_curr_min_alarm:
+		case hwmon_curr_max_alarm:
+			if (st->r_sense_uohm[channel])
+				return 0444;
+			break;
+		case hwmon_curr_min:
+		case hwmon_curr_max:
+			if (st->r_sense_uohm[channel])
+				return 0644;
+			break;
+		}
+		break;
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+		case hwmon_power_input_lowest:
+		case hwmon_power_input_highest:
+		case hwmon_power_min_alarm:
+		case hwmon_power_max_alarm:
+			if (st->r_sense_uohm[channel])
+				return 0444;
+			break;
+		case hwmon_power_min:
+		case hwmon_power_max:
+			if (st->r_sense_uohm[channel])
+				return 0644;
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int ltc2992_get_voltage(struct ltc2992_state *st, u32 reg, u32 scale, long *val)
+{
+	int reg_val;
+
+	reg_val = ltc2992_read_reg(st, reg, 2);
+	if (reg_val < 0)
+		return reg_val;
+
+	reg_val = reg_val >> 4;
+	*val = DIV_ROUND_CLOSEST(reg_val * scale, 1000);
+
+	return 0;
+}
+
+static int ltc2992_set_voltage(struct ltc2992_state *st, u32 reg, u32 scale, long val)
+{
+	val = DIV_ROUND_CLOSEST(val * 1000, scale);
+	val = val << 4;
+
+	return ltc2992_write_reg(st, reg, 2, val);
+}
+
+static int ltc2992_read_gpio_alarm(struct ltc2992_state *st, int nr_gpio, u32 attr, long *val)
+{
+	int reg_val;
+	u32 mask;
+
+	if (attr == hwmon_in_max_alarm)
+		mask = ltc2992_gpio_addr_map[nr_gpio].max_alarm_msk;
+	else
+		mask = ltc2992_gpio_addr_map[nr_gpio].min_alarm_msk;
+
+	reg_val = ltc2992_read_reg(st, ltc2992_gpio_addr_map[nr_gpio].alarm, 1);
+	if (reg_val < 0)
+		return reg_val;
+
+	*val = !!(reg_val & mask);
+	reg_val &= ~mask;
+
+	return ltc2992_write_reg(st, ltc2992_gpio_addr_map[nr_gpio].alarm, 1, reg_val);
+}
+
+static int ltc2992_read_gpios_in(struct device *dev, u32 attr, int nr_gpio, long *val)
+{
+	struct ltc2992_state *st = dev_get_drvdata(dev);
+	u32 reg;
+
+	switch (attr) {
+	case hwmon_in_input:
+		reg = ltc2992_gpio_addr_map[nr_gpio].data;
+		break;
+	case hwmon_in_lowest:
+		reg = ltc2992_gpio_addr_map[nr_gpio].min;
+		break;
+	case hwmon_in_highest:
+		reg = ltc2992_gpio_addr_map[nr_gpio].max;
+		break;
+	case hwmon_in_min:
+		reg = ltc2992_gpio_addr_map[nr_gpio].min_thresh;
+		break;
+	case hwmon_in_max:
+		reg = ltc2992_gpio_addr_map[nr_gpio].max_thresh;
+		break;
+	case hwmon_in_min_alarm:
+	case hwmon_in_max_alarm:
+		return ltc2992_read_gpio_alarm(st, nr_gpio, attr, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ltc2992_get_voltage(st, reg, LTC2992_VADC_GPIO_UV_LSB, val);
+}
+
+static int ltc2992_read_in_alarm(struct ltc2992_state *st, int channel, long *val, u32 attr)
+{
+	u32 reg_val;
+	u32 mask;
+
+	if (attr == hwmon_in_max_alarm)
+		mask = LTC2992_SENSE_FAULT_MSK(1);
+	else
+		mask = LTC2992_SENSE_FAULT_MSK(0);
+
+	reg_val = ltc2992_read_reg(st, LTC2992_SENSE_FAULT(channel), 1);
+	if (reg_val < 0)
+		return reg_val;
+
+	*val = !!(reg_val & mask);
+	reg_val &= ~mask;
+
+	return ltc2992_write_reg(st, LTC2992_SENSE_FAULT(channel), 1, reg_val);
+}
+
+static int ltc2992_read_in(struct device *dev, u32 attr, int channel, long *val)
+{
+	struct ltc2992_state *st = dev_get_drvdata(dev);
+	u32 reg;
+
+	if (channel > 1)
+		return ltc2992_read_gpios_in(dev, attr, channel - 2, val);
+
+	switch (attr) {
+	case hwmon_in_input:
+		reg = LTC2992_SENSE(channel);
+		break;
+	case hwmon_in_lowest:
+		reg = LTC2992_SENSE_MIN(channel);
+		break;
+	case hwmon_in_highest:
+		reg = LTC2992_SENSE_MAX(channel);
+		break;
+	case hwmon_in_min:
+		reg = LTC2992_SENSE_MIN_THRESH(channel);
+		break;
+	case hwmon_in_max:
+		reg = LTC2992_SENSE_MAX_THRESH(channel);
+		break;
+	case hwmon_in_min_alarm:
+	case hwmon_in_max_alarm:
+		return ltc2992_read_in_alarm(st, channel, val, attr);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ltc2992_get_voltage(st, reg, LTC2992_VADC_UV_LSB, val);
+}
+
+static int ltc2992_get_current(struct ltc2992_state *st, u32 reg, u32 channel, long *val)
+{
+	u32 reg_val;
+
+	reg_val = ltc2992_read_reg(st, reg, 2);
+	if (reg_val < 0)
+		return reg_val;
+
+	reg_val = reg_val >> 4;
+	*val = DIV_ROUND_CLOSEST(reg_val * LTC2992_IADC_NANOV_LSB, st->r_sense_uohm[channel]);
+
+	return 0;
+}
+
+static int ltc2992_set_current(struct ltc2992_state *st, u32 reg, u32 channel, long val)
+{
+	u32 reg_val;
+
+	reg_val = DIV_ROUND_CLOSEST(val * st->r_sense_uohm[channel], LTC2992_IADC_NANOV_LSB);
+	reg_val = reg_val << 4;
+
+	return ltc2992_write_reg(st, reg, 2, reg_val);
+}
+
+static int ltc2992_read_curr_alarm(struct ltc2992_state *st, int channel, long *val, u32 attr)
+{
+	u32 reg_val;
+	u32 mask;
+
+	if (attr == hwmon_curr_max_alarm)
+		mask = LTC2992_DSENSE_FAULT_MSK(1);
+	else
+		mask = LTC2992_DSENSE_FAULT_MSK(0);
+
+	reg_val = ltc2992_read_reg(st, LTC2992_DSENSE_FAULT(channel), 1);
+	if (reg_val < 0)
+		return reg_val;
+
+	*val = !!(reg_val & mask);
+
+	reg_val &= ~mask;
+	return ltc2992_write_reg(st, LTC2992_DSENSE_FAULT(channel), 1, reg_val);
+}
+
+static int ltc2992_read_curr(struct device *dev, u32 attr, int channel, long *val)
+{
+	struct ltc2992_state *st = dev_get_drvdata(dev);
+	u32 reg;
+
+	switch (attr) {
+	case hwmon_curr_input:
+		reg = LTC2992_DSENSE(channel);
+		break;
+	case hwmon_curr_lowest:
+		reg = LTC2992_DSENSE_MIN(channel);
+		break;
+	case hwmon_curr_highest:
+		reg = LTC2992_DSENSE_MAX(channel);
+		break;
+	case hwmon_curr_min:
+		reg = LTC2992_DSENSE_MIN_THRESH(channel);
+		break;
+	case hwmon_curr_max:
+		reg = LTC2992_DSENSE_MAX_THRESH(channel);
+		break;
+	case hwmon_curr_min_alarm:
+	case hwmon_curr_max_alarm:
+		return ltc2992_read_curr_alarm(st, channel, val, attr);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ltc2992_get_current(st, reg, channel, val);
+}
+
+static int ltc2992_get_power(struct ltc2992_state *st, u32 reg, u32 channel, long *val)
+{
+	u32 reg_val;
+
+	reg_val = ltc2992_read_reg(st, reg, 3);
+	if (reg_val < 0)
+		return reg_val;
+
+	*val = mul_u64_u32_div(reg_val, LTC2992_VADC_UV_LSB * LTC2992_IADC_NANOV_LSB,
+			       st->r_sense_uohm[channel] * 1000);
+
+	return 0;
+}
+
+static int ltc2992_set_power(struct ltc2992_state *st, u32 reg, u32 channel, long val)
+{
+	u32 reg_val;
+
+	reg_val = mul_u64_u32_div(val, st->r_sense_uohm[channel] * 1000,
+				  LTC2992_VADC_UV_LSB * LTC2992_IADC_NANOV_LSB);
+
+	return ltc2992_write_reg(st, reg, 3, reg_val);
+}
+
+static int ltc2992_read_power_alarm(struct ltc2992_state *st, int channel, long *val, u32 attr)
+{
+	u32 reg_val;
+	u32 mask;
+
+	if (attr == hwmon_power_max_alarm)
+		mask = LTC2992_POWER_FAULT_MSK(1);
+	else
+		mask = LTC2992_POWER_FAULT_MSK(0);
+
+	reg_val = ltc2992_read_reg(st, LTC2992_POWER_FAULT(channel), 1);
+	if (reg_val < 0)
+		return reg_val;
+
+	*val = !!(reg_val & mask);
+	reg_val &= ~mask;
+
+	return ltc2992_write_reg(st, LTC2992_POWER_FAULT(channel), 1, reg_val);
+}
+
+static int ltc2992_read_power(struct device *dev, u32 attr, int channel, long *val)
+{
+	struct ltc2992_state *st = dev_get_drvdata(dev);
+	u32 reg;
+
+	switch (attr) {
+	case hwmon_power_input:
+		reg = LTC2992_POWER(channel);
+		break;
+	case hwmon_power_input_lowest:
+		reg = LTC2992_POWER_MIN(channel);
+		break;
+	case hwmon_power_input_highest:
+		reg = LTC2992_POWER_MAX(channel);
+		break;
+	case hwmon_power_min:
+		reg = LTC2992_POWER_MIN_THRESH(channel);
+		break;
+	case hwmon_power_max:
+		reg = LTC2992_POWER_MAX_THRESH(channel);
+		break;
+	case hwmon_power_min_alarm:
+	case hwmon_power_max_alarm:
+		return ltc2992_read_power_alarm(st, channel, val, attr);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ltc2992_get_power(st, reg, channel, val);
+}
+
+static int ltc2992_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
+			long *val)
+{
+	switch (type) {
+	case hwmon_in:
+		return ltc2992_read_in(dev, attr, channel, val);
+	case hwmon_curr:
+		return ltc2992_read_curr(dev, attr, channel, val);
+	case hwmon_power:
+		return ltc2992_read_power(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ltc2992_write_curr(struct device *dev, u32 attr, int channel, long val)
+{
+	struct ltc2992_state *st = dev_get_drvdata(dev);
+	u32 reg;
+
+	switch (attr) {
+	case hwmon_curr_min:
+		reg = LTC2992_DSENSE_MIN_THRESH(channel);
+		break;
+	case hwmon_curr_max:
+		reg = LTC2992_DSENSE_MAX_THRESH(channel);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ltc2992_set_current(st, reg, channel, val);
+}
+
+static int ltc2992_write_gpios_in(struct device *dev, u32 attr, int nr_gpio, long val)
+{
+	struct ltc2992_state *st = dev_get_drvdata(dev);
+	u32 reg;
+
+	switch (attr) {
+	case hwmon_in_min:
+		reg = ltc2992_gpio_addr_map[nr_gpio].min_thresh;
+		break;
+	case hwmon_in_max:
+		reg = ltc2992_gpio_addr_map[nr_gpio].max_thresh;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ltc2992_set_voltage(st, reg, LTC2992_VADC_GPIO_UV_LSB, val);
+}
+
+static int ltc2992_write_in(struct device *dev, u32 attr, int channel, long val)
+{
+	struct ltc2992_state *st = dev_get_drvdata(dev);
+	u32 reg;
+
+	if (channel > 1)
+		return ltc2992_write_gpios_in(dev, attr, channel - 2, val);
+
+	switch (attr) {
+	case hwmon_in_min:
+		reg = LTC2992_SENSE_MIN_THRESH(channel);
+		break;
+	case hwmon_in_max:
+		reg = LTC2992_SENSE_MAX_THRESH(channel);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ltc2992_set_voltage(st, reg, LTC2992_VADC_UV_LSB, val);
+}
+
+static int ltc2992_write_power(struct device *dev, u32 attr, int channel, long val)
+{
+	struct ltc2992_state *st = dev_get_drvdata(dev);
+	u32 reg;
+
+	switch (attr) {
+	case hwmon_power_min:
+		reg = LTC2992_POWER_MIN_THRESH(channel);
+		break;
+	case hwmon_power_max:
+		reg = LTC2992_POWER_MAX_THRESH(channel);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ltc2992_set_power(st, reg, channel, val);
+}
+
+static int ltc2992_write_chip(struct device *dev, u32 attr, int channel, long val)
+{
+	struct ltc2992_state *st = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_chip_in_reset_history:
+		return regmap_update_bits(st->regmap, LTC2992_CTRLB, LTC2992_RESET_HISTORY,
+					  LTC2992_RESET_HISTORY);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ltc2992_write(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
+			 long val)
+{
+	switch (type) {
+	case hwmon_chip:
+		return ltc2992_write_chip(dev, attr, channel, val);
+	case hwmon_in:
+		return ltc2992_write_in(dev, attr, channel, val);
+	case hwmon_curr:
+		return ltc2992_write_curr(dev, attr, channel, val);
+	case hwmon_power:
+		return ltc2992_write_power(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_ops ltc2992_hwmon_ops = {
+	.is_visible = ltc2992_is_visible,
+	.read = ltc2992_read,
+	.write = ltc2992_write,
+};
+
+static const u32 ltc2992_chip_config[] = {
+	HWMON_C_IN_RESET_HISTORY,
+	0
+};
+
+static const struct hwmon_channel_info ltc2992_chip = {
+	.type = hwmon_chip,
+	.config = ltc2992_chip_config,
+};
+
+static const u32 ltc2992_in_config[] = {
+	HWMON_I_INPUT | HWMON_I_LOWEST | HWMON_I_HIGHEST | HWMON_I_MIN | HWMON_I_MAX |
+	HWMON_I_MIN_ALARM | HWMON_I_MAX_ALARM,
+	HWMON_I_INPUT | HWMON_I_LOWEST | HWMON_I_HIGHEST | HWMON_I_MIN | HWMON_I_MAX |
+	HWMON_I_MIN_ALARM | HWMON_I_MAX_ALARM,
+	HWMON_I_INPUT | HWMON_I_LOWEST | HWMON_I_HIGHEST | HWMON_I_MIN | HWMON_I_MAX |
+	HWMON_I_MIN_ALARM | HWMON_I_MAX_ALARM,
+	HWMON_I_INPUT | HWMON_I_LOWEST | HWMON_I_HIGHEST | HWMON_I_MIN | HWMON_I_MAX |
+	HWMON_I_MIN_ALARM | HWMON_I_MAX_ALARM,
+	HWMON_I_INPUT | HWMON_I_LOWEST | HWMON_I_HIGHEST | HWMON_I_MIN | HWMON_I_MAX |
+	HWMON_I_MIN_ALARM | HWMON_I_MAX_ALARM,
+	HWMON_I_INPUT | HWMON_I_LOWEST | HWMON_I_HIGHEST | HWMON_I_MIN | HWMON_I_MAX |
+	HWMON_I_MIN_ALARM | HWMON_I_MAX_ALARM,
+	0
+};
+
+static const struct hwmon_channel_info ltc2992_in = {
+	.type = hwmon_in,
+	.config = ltc2992_in_config,
+};
+
+static const u32 ltc2992_curr_config[] = {
+	HWMON_C_INPUT | HWMON_C_LOWEST | HWMON_C_HIGHEST | HWMON_C_MIN | HWMON_C_MAX |
+	HWMON_C_MIN_ALARM | HWMON_C_MAX_ALARM,
+	HWMON_C_INPUT | HWMON_C_LOWEST | HWMON_C_HIGHEST | HWMON_C_MIN | HWMON_C_MAX |
+	HWMON_C_MIN_ALARM | HWMON_C_MAX_ALARM,
+	0
+};
+
+static const struct hwmon_channel_info ltc2992_curr = {
+	.type = hwmon_curr,
+	.config = ltc2992_curr_config,
+};
+
+static const u32 ltc2992_power_config[] = {
+	HWMON_P_INPUT | HWMON_P_INPUT_LOWEST | HWMON_P_INPUT_HIGHEST | HWMON_P_MIN | HWMON_P_MAX |
+	HWMON_P_MIN_ALARM | HWMON_P_MAX_ALARM,
+	HWMON_P_INPUT | HWMON_P_INPUT_LOWEST | HWMON_P_INPUT_HIGHEST | HWMON_P_MIN | HWMON_P_MAX |
+	HWMON_P_MIN_ALARM | HWMON_P_MAX_ALARM,
+	0
+};
+
+static const struct hwmon_channel_info ltc2992_power = {
+	.type = hwmon_power,
+	.config = ltc2992_power_config,
+};
+
+static const struct hwmon_channel_info *ltc2992_info[] = {
+	&ltc2992_chip,
+	&ltc2992_in,
+	&ltc2992_curr,
+	&ltc2992_power,
+	NULL
+};
+
+static const struct hwmon_chip_info ltc2992_chip_info = {
+	.ops = &ltc2992_hwmon_ops,
+	.info = ltc2992_info,
+};
+
+static const struct regmap_config ltc2992_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xE8,
+};
+
+static int ltc2992_parse_dt(struct ltc2992_state *st)
+{
+	struct fwnode_handle *fwnode;
+	struct fwnode_handle *child;
+	u32 addr;
+	u32 val;
+	int ret;
+
+	fwnode = dev_fwnode(&st->client->dev);
+
+	fwnode_for_each_available_child_node(fwnode, child) {
+		ret = fwnode_property_read_u32(child, "reg", &addr);
+		if (ret < 0)
+			return ret;
+
+		if (addr > 1)
+			return -EINVAL;
+
+		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
+		if (!ret)
+			st->r_sense_uohm[addr] = val;
+	}
+
+	return 0;
+}
+
+static int ltc2992_i2c_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct device *hwmon_dev;
+	struct ltc2992_state *st;
+	int ret;
+
+	st = devm_kzalloc(&client->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->client = client;
+	st->regmap = devm_regmap_init_i2c(client, &ltc2992_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	ret = ltc2992_parse_dt(st);
+	if (ret < 0)
+		return ret;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&client->dev, client->name, st,
+							 &ltc2992_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct of_device_id ltc2992_of_match[] = {
+	{ .compatible = "adi,ltc2992" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc2992_of_match);
+
+static const struct i2c_device_id ltc2992_i2c_id[] = {
+	{"ltc2992", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ltc2992_i2c_id);
+
+static struct i2c_driver ltc2992_i2c_driver = {
+	.driver = {
+		.name = "ltc2992",
+		.of_match_table = ltc2992_of_match,
+	},
+	.probe    = ltc2992_i2c_probe,
+	.id_table = ltc2992_i2c_id,
+};
+
+module_i2c_driver(ltc2992_i2c_driver);
+
+MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");
+MODULE_DESCRIPTION("Hwmon driver for Linear Technology 2992");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.20.1

