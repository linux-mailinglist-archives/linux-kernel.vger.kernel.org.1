Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AAB2B9B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgKSTLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:11:39 -0500
Received: from foss.arm.com ([217.140.110.172]:37998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbgKSTLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:11:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 579651595;
        Thu, 19 Nov 2020 11:11:36 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB71C3F70D;
        Thu, 19 Nov 2020 11:11:33 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        broonie@kernel.org, robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v6 5/5] regulator: add SCMI driver
Date:   Thu, 19 Nov 2020 19:10:51 +0000
Message-Id: <20201119191051.46363-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119191051.46363-1-cristian.marussi@arm.com>
References: <20201119191051.46363-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple regulator based on SCMI Voltage Domain Protocol.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
----
v3 --> v4
- using of_match_full_name core regulator flag
- avoid coccinelle falde complaints about pointer-sized allocations

v2 --> v3
- remove multiple linear mappings support
- removed duplicated voltage name printout
- added a few comments
- simplified return path in scmi_reg_set_voltage_sel()

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
 drivers/regulator/scmi-regulator.c | 409 +++++++++++++++++++++++++++++
 3 files changed, 419 insertions(+)
 create mode 100644 drivers/regulator/scmi-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 020a00d6696b..5617c56fbe9b 100644
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
index 6ebae516258e..aeed0b6079b2 100644
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
index 000000000000..536458669b07
--- /dev/null
+++ b/drivers/regulator/scmi-regulator.c
@@ -0,0 +1,409 @@
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
+	s32 volt_uV;
+	struct scmi_regulator *sreg = rdev_get_drvdata(rdev);
+	const struct scmi_handle *handle = sreg->sdev->handle;
+
+	volt_uV = sreg->desc.ops->list_voltage(rdev, selector);
+	if (volt_uV <= 0)
+		return -EINVAL;
+
+	return handle->voltage_ops->level_set(handle, sreg->id, 0x0, volt_uV);
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
+	s32 delta_uV;
+
+	/*
+	 * Note that SCMI voltage domains describable by linear ranges
+	 * (segments) {low, high, step} are guaranteed to come in one single
+	 * triplet by the SCMI Voltage Domain protocol support itself.
+	 */
+
+	delta_uV = (vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_HIGH] -
+			vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_LOW]);
+	/* Rule out buggy negative-intervals answers from fw */
+	if (delta_uV < 0) {
+		dev_err(&sreg->sdev->dev,
+			"Invalid volt-range %d-%duV for domain %d\n",
+			vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_LOW],
+			vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_HIGH],
+			sreg->id);
+		return -EINVAL;
+	}
+
+	if (!delta_uV) {
+		/* Just one fixed voltage exposed by SCMI */
+		sreg->desc.fixed_uV =
+			vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_LOW];
+		sreg->desc.n_voltages = 1;
+		sreg->desc.ops = &scmi_reg_fixed_ops;
+	} else {
+		/* One simple linear mapping. */
+		sreg->desc.min_uV =
+			vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_LOW];
+		sreg->desc.uV_step =
+			vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_STEP];
+		sreg->desc.linear_min_sel = 0;
+		sreg->desc.n_voltages = delta_uV / sreg->desc.uV_step;
+		sreg->desc.ops = &scmi_reg_linear_ops;
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
+	if (!vinfo) {
+		dev_warn(dev, "Skipping invalid voltage domain %d\n",
+			 sreg->id);
+		return -ENODEV;
+	}
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
+	sreg->desc.of_match_full_name = true;
+	sreg->desc.of_match = sreg->of_node->full_name;
+	sreg->desc.regulators_node = "regulators";
+	if (vinfo->segmented)
+		ret = scmi_config_linear_regulator_mappings(sreg, vinfo);
+	else
+		ret = scmi_config_discrete_regulator_mappings(sreg, vinfo);
+	if (ret)
+		return ret;
+
+	/*
+	 * Using the scmi device here to have DT searched from Voltage
+	 * protocol node down.
+	 */
+	sreg->conf.dev = dev;
+	/* Store for later retrieval via rdev_get_drvdata() */
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
+	dev_dbg(&sdev->dev,
+		"Found SCMI Regulator entry -- OF node [%d] -> %s\n",
+		dom, np->full_name);
+
+	return 0;
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
+				    sizeof(void *), GFP_KERNEL);
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
+	 * can successfully reach via SCMI and has a valid associated voltage
+	 * domain.
+	 */
+	for (d = 0; d < num_doms; d++) {
+		struct scmi_regulator *sreg = rinfo->sregv[d];
+
+		/* Skip empty slots */
+		if (!sreg)
+			continue;
+		ret = scmi_regulator_common_init(sreg);
+		/* Skip invalid voltage domains */
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
+			 "Regulator %s registered for domain [%d]\n",
+			 sreg->desc.name, sreg->id);
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

