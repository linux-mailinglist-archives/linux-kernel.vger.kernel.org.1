Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B828F601
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389756AbgJOPkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:40:20 -0400
Received: from foss.arm.com ([217.140.110.172]:47064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731085AbgJOPkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:40:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A36FB143B;
        Thu, 15 Oct 2020 08:40:15 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACB393F719;
        Thu, 15 Oct 2020 08:40:13 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        broonie@kernel.org, robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        cristian.marussi@arm.com
Subject: [PATCH v2 3/4] regulator: add SCMI driver
Date:   Thu, 15 Oct 2020 16:40:00 +0100
Message-Id: <20201015154001.8931-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015154001.8931-1-cristian.marussi@arm.com>
References: <20201015154001.8931-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple regulator based on SCMI Voltage Domain Protocol.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
----
v1 --> v2
- removed duplicate regulator naming
- removed redundant .get/set_voltage ops: only _sel variants implemented
- removed condexpr on fail path to increase readability

v0 --> v1
- fixed init_data constraint parsing
- fixes for v5.8 (linear_range.h)
- fixed commit message content and subject line format
- factored out SCMI core specific changes to distinct patch
- reworked Kconfig and Makefile to keep proper alphabetic order
- fixed SPDX comment style
- removed unneeded inline functions
- reworked conditionals for legibility
- fixed some return paths to properly report SCMI original errors codes
- added some more descriptive error messages when fw returns invalid ranges
- removed unneeded explicit devm_regulator_unregister from .remove()
---
 drivers/regulator/Kconfig          |   9 +
 drivers/regulator/Makefile         |   1 +
 drivers/regulator/scmi-regulator.c | 453 +++++++++++++++++++++++++++++
 3 files changed, 463 insertions(+)
 create mode 100644 drivers/regulator/scmi-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index de17ef7e18f0..6d3a10cb9833 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -155,6 +155,15 @@ config REGULATOR_ARIZONA_MICSUPP
 	  and Wolfson Microelectronic Arizona codecs
 	  devices.
 
+config REGULATOR_ARM_SCMI
+	tristate "SCMI based regulator driver"
+	depends on ARM_SCMI_PROTOCOL && OF
+	help
+	  This adds the regulator driver support for ARM platforms using SCMI
+	  protocol for device voltage management.
+	  This driver uses SCMI Message Protocol driver to interact with the
+	  firmware providing the device Voltage functionality.
+
 config REGULATOR_AS3711
 	tristate "AS3711 PMIC"
 	depends on MFD_AS3711
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index d8d3ecf526a8..0532a7393d5d 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_REGULATOR_AD5398) += ad5398.o
 obj-$(CONFIG_REGULATOR_ANATOP) += anatop-regulator.o
 obj-$(CONFIG_REGULATOR_ARIZONA_LDO1) += arizona-ldo1.o
 obj-$(CONFIG_REGULATOR_ARIZONA_MICSUPP) += arizona-micsupp.o
+obj-$(CONFIG_REGULATOR_ARM_SCMI) += scmi-regulator.o
 obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
 obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
 obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
new file mode 100644
index 000000000000..e4e7d0345723
--- /dev/null
+++ b/drivers/regulator/scmi-regulator.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// System Control and Management Interface (SCMI) based regulator driver
+//
+// Copyright (C) 2020 ARM Ltd.
+//
+// Implements a regulator driver on top of the SCMI Voltage Protocol.
+//
+// The ARM SCMI Protocol aims in general to hide as much as possible all the
+// underlying operational details while providing an abstracted interface for
+// its users to operate upon: as a consequence the resulting operational
+// capabilities and configurability of this regulator device are much more
+// limited than the ones usually available on a standard physical regulator.
+//
+// The supported SCMI regulator ops are restricted to the bare minimum:
+//
+//  - 'status_ops': enable/disable/is_enabled
+//  - 'voltage_ops': get_voltage_sel/set_voltage_sel
+//		     list_voltage/map_voltage
+//
+// Each SCMI regulator instance is associated, through the means of a proper DT
+// entry description, to a specific SCMI Voltage Domain.
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/linear_range.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+struct scmi_regulator {
+	u32 id;
+	struct scmi_device *sdev;
+	struct regulator_dev *rdev;
+	struct device_node *of_node;
+	struct regulator_desc desc;
+	struct regulator_config conf;
+};
+
+struct scmi_regulator_info {
+	int num_doms;
+	struct scmi_regulator **sregv;
+};
+
+static int scmi_reg_enable(struct regulator_dev *rdev)
+{
+	struct scmi_regulator *sreg = rdev_get_drvdata(rdev);
+	const struct scmi_handle *handle = sreg->sdev->handle;
+
+	return handle->voltage_ops->config_set(handle, sreg->id,
+					       SCMI_VOLTAGE_ARCH_STATE_ON);
+}
+
+static int scmi_reg_disable(struct regulator_dev *rdev)
+{
+	struct scmi_regulator *sreg = rdev_get_drvdata(rdev);
+	const struct scmi_handle *handle = sreg->sdev->handle;
+
+	return handle->voltage_ops->config_set(handle, sreg->id,
+					       SCMI_VOLTAGE_ARCH_STATE_OFF);
+}
+
+static int scmi_reg_is_enabled(struct regulator_dev *rdev)
+{
+	int ret;
+	u32 config;
+	struct scmi_regulator *sreg = rdev_get_drvdata(rdev);
+	const struct scmi_handle *handle = sreg->sdev->handle;
+
+	ret = handle->voltage_ops->config_get(handle, sreg->id,
+					      &config);
+	if (ret) {
+		dev_err(&sreg->sdev->dev,
+			"Error %d reading regulator %s status.\n",
+			ret, sreg->desc.name);
+		return 0;
+	}
+
+	return config & SCMI_VOLTAGE_ARCH_STATE_ON;
+}
+
+static int scmi_reg_get_voltage_sel(struct regulator_dev *rdev)
+{
+	int ret;
+	s32 volt_uV;
+	struct scmi_regulator *sreg = rdev_get_drvdata(rdev);
+	const struct scmi_handle *handle = sreg->sdev->handle;
+
+	ret = handle->voltage_ops->level_get(handle, sreg->id, &volt_uV);
+	if (ret)
+		return ret;
+
+	return sreg->desc.ops->map_voltage(rdev, volt_uV, volt_uV);
+}
+
+static int scmi_reg_set_voltage_sel(struct regulator_dev *rdev,
+				    unsigned int selector)
+{
+	int ret;
+	s32 volt_uV;
+	struct scmi_regulator *sreg = rdev_get_drvdata(rdev);
+	const struct scmi_handle *handle = sreg->sdev->handle;
+
+	volt_uV = sreg->desc.ops->list_voltage(rdev, selector);
+	if (volt_uV <= 0)
+		return -EINVAL;
+
+	ret = handle->voltage_ops->level_set(handle, sreg->id, 0x0, volt_uV);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static const struct regulator_ops scmi_reg_fixed_ops = {
+	.enable = scmi_reg_enable,
+	.disable = scmi_reg_disable,
+	.is_enabled = scmi_reg_is_enabled,
+};
+
+static const struct regulator_ops scmi_reg_linear_ops = {
+	.enable = scmi_reg_enable,
+	.disable = scmi_reg_disable,
+	.is_enabled = scmi_reg_is_enabled,
+	.get_voltage_sel = scmi_reg_get_voltage_sel,
+	.set_voltage_sel = scmi_reg_set_voltage_sel,
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+};
+
+static const struct regulator_ops scmi_reg_range_ops = {
+	.enable = scmi_reg_enable,
+	.disable = scmi_reg_disable,
+	.is_enabled = scmi_reg_is_enabled,
+	.get_voltage_sel = scmi_reg_get_voltage_sel,
+	.set_voltage_sel = scmi_reg_set_voltage_sel,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+};
+
+static const struct regulator_ops scmi_reg_discrete_ops = {
+	.enable = scmi_reg_enable,
+	.disable = scmi_reg_disable,
+	.is_enabled = scmi_reg_is_enabled,
+	.get_voltage_sel = scmi_reg_get_voltage_sel,
+	.set_voltage_sel = scmi_reg_set_voltage_sel,
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+};
+
+static int
+scmi_config_linear_regulator_mappings(struct scmi_regulator *sreg,
+				      const struct scmi_voltage_info *vinfo)
+{
+	/*
+	 * Note that SCMI voltage domains describable by linear ranges
+	 * (segments) {low, high, step} are guaranteed to come in triplets by
+	 * the SCMI Voltage Domain protocol support itself.
+	 */
+	if (vinfo->num_levels == 3) {
+		s32 delta_uV;
+
+		delta_uV = (vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_HIGH] -
+				vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_LOW]);
+		/* Rule out buggy negative-intervals answers from fw */
+		if (delta_uV < 0) {
+			dev_err(&sreg->sdev->dev,
+				"Invalid volt-range %d-%duV for domain %d\n",
+				vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_LOW],
+				vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_HIGH],
+				sreg->id);
+			return -EINVAL;
+		}
+
+		if (!delta_uV) {
+			/* Just one fixed voltage exposed by SCMI */
+			sreg->desc.fixed_uV =
+				vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_LOW];
+			sreg->desc.n_voltages = 1;
+			sreg->desc.ops = &scmi_reg_fixed_ops;
+		} else {
+			/* One simple linear mapping. */
+			sreg->desc.min_uV =
+				vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_LOW];
+			sreg->desc.uV_step =
+				vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_STEP];
+			sreg->desc.linear_min_sel = 0;
+			sreg->desc.n_voltages = delta_uV / sreg->desc.uV_step;
+			sreg->desc.ops = &scmi_reg_linear_ops;
+		}
+	} else {
+		/* Multiple linear mappings. */
+		int i, num_ranges, last_max = -1;
+		struct linear_range *lr;
+
+		num_ranges = vinfo->num_levels / 3;
+		lr = devm_kcalloc(&sreg->sdev->dev, num_ranges,
+				  sizeof(*lr), GFP_KERNEL);
+		if (!lr)
+			return -ENOMEM;
+
+		sreg->desc.n_linear_ranges = num_ranges;
+		sreg->desc.linear_ranges = lr;
+		for (i = 0; num_ranges; num_ranges--, i += 3, lr++) {
+			s32 delta_uV;
+
+			lr->min =
+				vinfo->levels_uv[i + SCMI_VOLTAGE_SEGMENT_LOW];
+			lr->step =
+				vinfo->levels_uv[i + SCMI_VOLTAGE_SEGMENT_STEP];
+			delta_uV =
+			    vinfo->levels_uv[i + SCMI_VOLTAGE_SEGMENT_HIGH] -
+			    lr->min;
+			if (delta_uV <= 0 || !(delta_uV / lr->step)) {
+				dev_err(&sreg->sdev->dev,
+					"Invalid volt-range %d-%duV for domain %d\n",
+				     vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_LOW],
+				    vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_HIGH],
+								      sreg->id);
+				return -EINVAL;
+			}
+			lr->max_sel = delta_uV / lr->step - 1;
+			lr->min_sel = last_max + 1;
+			last_max = lr->max_sel;
+		}
+		sreg->desc.n_voltages = last_max + 1;
+		sreg->desc.ops = &scmi_reg_range_ops;
+	}
+
+	return 0;
+}
+
+static int
+scmi_config_discrete_regulator_mappings(struct scmi_regulator *sreg,
+					const struct scmi_voltage_info *vinfo)
+{
+	/* Discrete non linear levels are mapped to volt_table */
+	sreg->desc.n_voltages = vinfo->num_levels;
+	if (sreg->desc.n_voltages > 1) {
+		sreg->desc.volt_table = (const unsigned int *)vinfo->levels_uv;
+		sreg->desc.ops = &scmi_reg_discrete_ops;
+	} else {
+		sreg->desc.fixed_uV = vinfo->levels_uv[0];
+		sreg->desc.ops = &scmi_reg_fixed_ops;
+	}
+
+	return 0;
+}
+
+static int scmi_regulator_common_init(struct scmi_regulator *sreg)
+{
+	int ret;
+	const struct scmi_handle *handle = sreg->sdev->handle;
+	struct device *dev = &sreg->sdev->dev;
+	const struct scmi_voltage_info *vinfo;
+
+	vinfo = handle->voltage_ops->info_get(handle, sreg->id);
+	if (!vinfo)
+		return -ENODEV;
+
+	if (!vinfo->num_levels)
+		return -EINVAL;
+
+	/*
+	 * Regulator framework does not fully support negative voltages
+	 * so we discard any voltage domain reported as supporting negative
+	 * voltages: as a consequence each levels_uv entry is guaranteed to
+	 * be non-negative from here on.
+	 */
+	if (vinfo->negative_volts_allowed) {
+		dev_warn(dev, "Negative voltages NOT supported...skip %s\n",
+			 sreg->of_node->full_name);
+		return -EOPNOTSUPP;
+	}
+
+	sreg->desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s", vinfo->name);
+	if (!sreg->desc.name)
+		return -ENOMEM;
+
+	sreg->desc.id = sreg->id;
+	sreg->desc.type = REGULATOR_VOLTAGE;
+	sreg->desc.owner = THIS_MODULE;
+	sreg->desc.of_match = sreg->of_node->name;
+	sreg->desc.regulators_node = "regulators";
+	if (vinfo->segmented)
+		ret = scmi_config_linear_regulator_mappings(sreg, vinfo);
+	else
+		ret = scmi_config_discrete_regulator_mappings(sreg, vinfo);
+	if (ret)
+		return ret;
+
+	sreg->conf.dev = dev;
+	sreg->conf.driver_data = sreg;
+
+	return 0;
+}
+
+static int process_scmi_regulator_of_node(struct scmi_device *sdev,
+					  struct device_node *np,
+					  struct scmi_regulator_info *rinfo)
+{
+	u32 dom, ret;
+
+	ret = of_property_read_u32(np, "reg", &dom);
+	if (ret)
+		return ret;
+
+	if (dom >= rinfo->num_doms)
+		return -ENODEV;
+
+	if (rinfo->sregv[dom]) {
+		dev_err(&sdev->dev,
+			"SCMI Voltage Domain %d already in use. Skipping: %s\n",
+			dom, np->full_name);
+		return -EINVAL;
+	}
+
+	rinfo->sregv[dom] = devm_kzalloc(&sdev->dev,
+					 sizeof(struct scmi_regulator),
+					 GFP_KERNEL);
+	if (!rinfo->sregv[dom])
+		return -ENOMEM;
+
+	rinfo->sregv[dom]->id = dom;
+	rinfo->sregv[dom]->sdev = sdev;
+	/* get hold of good nodes */
+	of_node_get(np);
+	rinfo->sregv[dom]->of_node = np;
+	dev_info(&sdev->dev,
+		 "Found valid SCMI Regulator -- OF node [%d] -> %s\n",
+		 dom, np->full_name);
+
+	return ret;
+}
+
+static int scmi_regulator_probe(struct scmi_device *sdev)
+{
+	int d, ret, num_doms;
+	struct device_node *np, *child;
+	const struct scmi_handle *handle = sdev->handle;
+	struct scmi_regulator_info *rinfo;
+
+	if (!handle || !handle->voltage_ops)
+		return -ENODEV;
+
+	num_doms = handle->voltage_ops->num_domains_get(handle);
+	if (num_doms <= 0) {
+		if (!num_doms) {
+			dev_err(&sdev->dev,
+				"number of voltage domains invalid\n");
+			num_doms = -EINVAL;
+		} else {
+			dev_err(&sdev->dev,
+				"failed to get voltage domains - err:%d\n",
+				num_doms);
+		}
+
+		return num_doms;
+	}
+
+	rinfo = devm_kzalloc(&sdev->dev, sizeof(*rinfo), GFP_KERNEL);
+	if (!rinfo)
+		return -ENOMEM;
+
+	/* Allocate pointers' array for all possible domains */
+	rinfo->sregv = devm_kcalloc(&sdev->dev, num_doms,
+				    sizeof(rinfo->sregv), GFP_KERNEL);
+	if (!rinfo->sregv)
+		return -ENOMEM;
+
+	rinfo->num_doms = num_doms;
+	/*
+	 * Start collecting into rinfo->sregv possibly good SCMI Regulators as
+	 * described by a well-formed DT entry and associated with an existing
+	 * plausible SCMI Voltage Domain number, all belonging to this SCMI
+	 * platform instance node (handle->dev->of_node).
+	 */
+	np = of_find_node_by_name(handle->dev->of_node, "regulators");
+	for_each_child_of_node(np, child) {
+		ret = process_scmi_regulator_of_node(sdev, child, rinfo);
+		/* abort on any mem issue */
+		if (ret == -ENOMEM)
+			return ret;
+	}
+
+	/*
+	 * Register a regulator for each valid regulator-DT-entry that we
+	 * can successfully reach via SCMI
+	 */
+	for (d = 0; d < num_doms; d++) {
+		struct scmi_regulator *sreg = rinfo->sregv[d];
+
+		if (!sreg)
+			continue;
+		ret = scmi_regulator_common_init(sreg);
+		if (ret)
+			continue;
+		sreg->rdev = devm_regulator_register(&sdev->dev, &sreg->desc,
+						     &sreg->conf);
+		if (IS_ERR(sreg->rdev)) {
+			sreg->rdev = NULL;
+			continue;
+		}
+
+		dev_info(&sdev->dev,
+			 "Regulator %s registered for domain [%d](%s)\n",
+			 sreg->desc.name, sreg->id, sreg->desc.name);
+	}
+
+	dev_set_drvdata(&sdev->dev, rinfo);
+
+	return 0;
+}
+
+static void scmi_regulator_remove(struct scmi_device *sdev)
+{
+	int d;
+	struct scmi_regulator_info *rinfo;
+
+	rinfo = dev_get_drvdata(&sdev->dev);
+	if (!rinfo)
+		return;
+
+	for (d = 0; d < rinfo->num_doms; d++) {
+		if (!rinfo->sregv[d])
+			continue;
+		of_node_put(rinfo->sregv[d]->of_node);
+	}
+}
+
+static const struct scmi_device_id scmi_regulator_id_table[] = {
+	{ SCMI_PROTOCOL_VOLTAGE,  "regulator" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_regulator_id_table);
+
+static struct scmi_driver scmi_drv = {
+	.name		= "scmi-regulator",
+	.probe		= scmi_regulator_probe,
+	.remove		= scmi_regulator_remove,
+	.id_table	= scmi_regulator_id_table,
+};
+
+module_scmi_driver(scmi_drv);
+
+MODULE_AUTHOR("Cristian Marussi <cristian.marussi@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI regulator driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

