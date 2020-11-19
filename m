Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321A42B9B47
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgKSTL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:11:28 -0500
Received: from foss.arm.com ([217.140.110.172]:37930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgKSTL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:11:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE7EC1595;
        Thu, 19 Nov 2020 11:11:26 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEF493F70D;
        Thu, 19 Nov 2020 11:11:24 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        broonie@kernel.org, robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v6 1/5] firmware: arm_scmi: Add Voltage Domain Support
Date:   Thu, 19 Nov 2020 19:10:47 +0000
Message-Id: <20201119191051.46363-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119191051.46363-1-cristian.marussi@arm.com>
References: <20201119191051.46363-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCMI Voltage Domain protocol support.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v5 --> v6
- removed single field struct
- reviewed args to scmi_init_voltage_levels()
- allocating scmi_voltage_info_array contiguously

v4 --> v5
- removed inline
- moved segmented intervals defines
- fixed some macros complaints by checkpatch

v3 --> v4
- avoid fixed sized typing in voltage_info
- avoid coccinelle falde complaints about pointer-sized allocations

v2 --> v3
- restrict segmented voltage domain descriptors to one triplet
- removed unneeded inline
- free allocated resources for invalid voltage domain
- added __must_check to info_get voltage operations
- added a few comments
- removed fixed size typing from struct voltage_info

v1 --> v2
- fix voltage levels query loop to reload full cmd description
  between iterations as reported by Etienne Carriere
- ensure rx buffer is properly sized calli scmi_reset_rx_to_maxsz
  between transfers
---
 drivers/firmware/arm_scmi/Makefile  |   2 +-
 drivers/firmware/arm_scmi/common.h  |   1 +
 drivers/firmware/arm_scmi/driver.c  |   2 +
 drivers/firmware/arm_scmi/voltage.c | 380 ++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h       |  64 +++++
 5 files changed, 448 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/voltage.c

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index bc0d54f8e861..6a2ef63306d6 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -4,7 +4,7 @@ scmi-driver-y = driver.o notify.o
 scmi-transport-y = shmem.o
 scmi-transport-$(CONFIG_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
-scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o
+scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
 scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 		    $(scmi-transport-y)
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 65063fa948d4..c0fb45e7c3e8 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -169,6 +169,7 @@ DECLARE_SCMI_REGISTER_UNREGISTER(perf);
 DECLARE_SCMI_REGISTER_UNREGISTER(power);
 DECLARE_SCMI_REGISTER_UNREGISTER(reset);
 DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
+DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
 DECLARE_SCMI_REGISTER_UNREGISTER(system);
 
 #define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(id, name) \
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 3dfd8b6a0ebf..ada35e63feae 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -946,6 +946,7 @@ static int __init scmi_driver_init(void)
 	scmi_power_register();
 	scmi_reset_register();
 	scmi_sensors_register();
+	scmi_voltage_register();
 	scmi_system_register();
 
 	return platform_driver_register(&scmi_driver);
@@ -961,6 +962,7 @@ static void __exit scmi_driver_exit(void)
 	scmi_power_unregister();
 	scmi_reset_unregister();
 	scmi_sensors_unregister();
+	scmi_voltage_unregister();
 	scmi_system_unregister();
 
 	platform_driver_unregister(&scmi_driver);
diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
new file mode 100644
index 000000000000..e794e4349ae6
--- /dev/null
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Voltage Protocol
+ *
+ * Copyright (C) 2020 ARM Ltd.
+ */
+
+#include <linux/scmi_protocol.h>
+
+#include "common.h"
+
+#define VOLTAGE_DOMS_NUM_MASK		GENMASK(15, 0)
+#define REMAINING_LEVELS_MASK		GENMASK(31, 16)
+#define RETURNED_LEVELS_MASK		GENMASK(11, 0)
+
+enum scmi_voltage_protocol_cmd {
+	VOLTAGE_DOMAIN_ATTRIBUTES = 0x3,
+	VOLTAGE_DESCRIBE_LEVELS = 0x4,
+	VOLTAGE_CONFIG_SET = 0x5,
+	VOLTAGE_CONFIG_GET = 0x6,
+	VOLTAGE_LEVEL_SET = 0x7,
+	VOLTAGE_LEVEL_GET = 0x8,
+};
+
+#define NUM_VOLTAGE_DOMAINS(x)	((u16)(FIELD_GET(VOLTAGE_DOMS_NUM_MASK, (x))))
+
+struct scmi_msg_resp_domain_attributes {
+	__le32 attr;
+	u8 name[SCMI_MAX_STR_SIZE];
+};
+
+struct scmi_msg_cmd_describe_levels {
+	__le32 domain_id;
+	__le32 level_index;
+};
+
+struct scmi_msg_resp_describe_levels {
+	__le32 flags;
+#define NUM_REMAINING_LEVELS(f)	((u16)(FIELD_GET(REMAINING_LEVELS_MASK, (f))))
+#define NUM_RETURNED_LEVELS(f)	((u16)(FIELD_GET(RETURNED_LEVELS_MASK, (f))))
+#define SUPPORTS_SEGMENTED_LEVELS(f)	((f) & BIT(12))
+	__le32 voltage[];
+};
+
+struct scmi_msg_cmd_config_set {
+	__le32 domain_id;
+	__le32 config;
+};
+
+struct scmi_msg_cmd_level_set {
+	__le32 domain_id;
+	__le32 flags;
+	__le32 voltage_level;
+};
+
+struct voltage_info {
+	unsigned int version;
+	unsigned int num_domains;
+	struct scmi_voltage_info *domains;
+};
+
+static int scmi_protocol_attributes_get(const struct scmi_handle *handle,
+					struct voltage_info *vinfo)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
+				 SCMI_PROTOCOL_VOLTAGE, 0, sizeof(__le32), &t);
+	if (ret)
+		return ret;
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret)
+		vinfo->num_domains =
+			NUM_VOLTAGE_DOMAINS(get_unaligned_le32(t->rx.buf));
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_init_voltage_levels(struct device *dev,
+				    struct scmi_voltage_info *v,
+				    u32 num_returned, u32 num_remaining,
+				    bool segmented)
+{
+	u32 num_levels;
+
+	num_levels = num_returned + num_remaining;
+	/*
+	 * segmented levels entries are represented by a single triplet
+	 * returned all in one go.
+	 */
+	if (!num_levels ||
+	    (segmented && (num_remaining || num_returned != 3))) {
+		dev_err(dev,
+			"Invalid level descriptor(%d/%d/%d) for voltage dom %d\n",
+			num_levels, num_returned, num_remaining, v->id);
+		return -EINVAL;
+	}
+
+	v->levels_uv = devm_kcalloc(dev, num_levels, sizeof(u32), GFP_KERNEL);
+	if (!v->levels_uv)
+		return -ENOMEM;
+
+	v->num_levels = num_levels;
+	v->segmented = segmented;
+
+	return 0;
+}
+
+static int scmi_voltage_descriptors_get(const struct scmi_handle *handle,
+					struct voltage_info *vinfo)
+{
+	int ret, dom;
+	struct scmi_xfer *td, *tl;
+	struct device *dev = handle->dev;
+	struct scmi_msg_resp_domain_attributes *resp_dom;
+	struct scmi_msg_resp_describe_levels *resp_levels;
+
+	ret = scmi_xfer_get_init(handle, VOLTAGE_DOMAIN_ATTRIBUTES,
+				 SCMI_PROTOCOL_VOLTAGE, sizeof(__le32),
+				 sizeof(*resp_dom), &td);
+	if (ret)
+		return ret;
+	resp_dom = td->rx.buf;
+
+	ret = scmi_xfer_get_init(handle, VOLTAGE_DESCRIBE_LEVELS,
+				 SCMI_PROTOCOL_VOLTAGE, sizeof(__le64), 0, &tl);
+	if (ret)
+		goto outd;
+	resp_levels = tl->rx.buf;
+
+	for (dom = 0; dom < vinfo->num_domains; dom++) {
+		u32 desc_index = 0;
+		u16 num_returned = 0, num_remaining = 0;
+		struct scmi_msg_cmd_describe_levels *cmd;
+		struct scmi_voltage_info *v;
+
+		/* Retrieve domain attributes at first ... */
+		put_unaligned_le32(dom, td->tx.buf);
+		ret = scmi_do_xfer(handle, td);
+		/* Skip domain on comms error */
+		if (ret)
+			continue;
+
+		v = vinfo->domains + dom;
+		v->id = dom;
+		v->attributes = le32_to_cpu(resp_dom->attr);
+		strlcpy(v->name, resp_dom->name, SCMI_MAX_STR_SIZE);
+
+		cmd = tl->tx.buf;
+		/* ...then retrieve domain levels descriptions */
+		do {
+			u32 flags;
+			int cnt;
+
+			cmd->domain_id = cpu_to_le32(v->id);
+			cmd->level_index = desc_index;
+			ret = scmi_do_xfer(handle, tl);
+			if (ret)
+				break;
+
+			flags = le32_to_cpu(resp_levels->flags);
+			num_returned = NUM_RETURNED_LEVELS(flags);
+			num_remaining = NUM_REMAINING_LEVELS(flags);
+
+			/* Allocate space for num_levels if not already done */
+			if (!v->num_levels) {
+				ret = scmi_init_voltage_levels(dev, v,
+							       num_returned,
+							       num_remaining,
+					      SUPPORTS_SEGMENTED_LEVELS(flags));
+				if (ret)
+					break;
+			}
+
+			if (desc_index + num_returned > v->num_levels) {
+				dev_err(handle->dev,
+					"No. of voltage levels can't exceed %d\n",
+					v->num_levels);
+				ret = -EINVAL;
+				break;
+			}
+
+			for (cnt = 0; cnt < num_returned; cnt++) {
+				s32 val;
+
+				val =
+				    (s32)le32_to_cpu(resp_levels->voltage[cnt]);
+				v->levels_uv[desc_index + cnt] = val;
+				if (val < 0)
+					v->negative_volts_allowed = true;
+			}
+
+			desc_index += num_returned;
+
+			scmi_reset_rx_to_maxsz(handle, tl);
+			/* check both to avoid infinite loop due to buggy fw */
+		} while (num_returned && num_remaining);
+
+		if (ret) {
+			v->num_levels = 0;
+			devm_kfree(dev, v->levels_uv);
+		}
+
+		scmi_reset_rx_to_maxsz(handle, td);
+	}
+
+	scmi_xfer_put(handle, tl);
+outd:
+	scmi_xfer_put(handle, td);
+
+	return ret;
+}
+
+static int __scmi_voltage_get_u32(const struct scmi_handle *handle,
+				  u8 cmd_id, u32 domain_id, u32 *value)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct voltage_info *vinfo = handle->voltage_priv;
+
+	if (domain_id >= vinfo->num_domains)
+		return -EINVAL;
+
+	ret = scmi_xfer_get_init(handle, cmd_id,
+				 SCMI_PROTOCOL_VOLTAGE,
+				 sizeof(__le32), 0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(domain_id, t->tx.buf);
+	ret = scmi_do_xfer(handle, t);
+	if (!ret)
+		*value = get_unaligned_le32(t->rx.buf);
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_voltage_config_set(const struct scmi_handle *handle,
+				   u32 domain_id, u32 config)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct voltage_info *vinfo = handle->voltage_priv;
+	struct scmi_msg_cmd_config_set *cmd;
+
+	if (domain_id >= vinfo->num_domains)
+		return -EINVAL;
+
+	ret = scmi_xfer_get_init(handle, VOLTAGE_CONFIG_SET,
+				 SCMI_PROTOCOL_VOLTAGE,
+				 sizeof(*cmd), 0, &t);
+	if (ret)
+		return ret;
+
+	cmd = t->tx.buf;
+	cmd->domain_id = cpu_to_le32(domain_id);
+	cmd->config = cpu_to_le32(config & GENMASK(3, 0));
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_voltage_config_get(const struct scmi_handle *handle,
+				   u32 domain_id, u32 *config)
+{
+	return __scmi_voltage_get_u32(handle, VOLTAGE_CONFIG_GET,
+				      domain_id, config);
+}
+
+static int scmi_voltage_level_set(const struct scmi_handle *handle,
+				  u32 domain_id, u32 flags, s32 volt_uV)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct voltage_info *vinfo = handle->voltage_priv;
+	struct scmi_msg_cmd_level_set *cmd;
+
+	if (domain_id >= vinfo->num_domains)
+		return -EINVAL;
+
+	ret = scmi_xfer_get_init(handle, VOLTAGE_LEVEL_SET,
+				 SCMI_PROTOCOL_VOLTAGE,
+				 sizeof(*cmd), 0, &t);
+	if (ret)
+		return ret;
+
+	cmd = t->tx.buf;
+	cmd->domain_id = cpu_to_le32(domain_id);
+	cmd->flags = cpu_to_le32(flags);
+	cmd->voltage_level = cpu_to_le32(volt_uV);
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_voltage_level_get(const struct scmi_handle *handle,
+				  u32 domain_id, s32 *volt_uV)
+{
+	return __scmi_voltage_get_u32(handle, VOLTAGE_LEVEL_GET,
+				      domain_id, (u32 *)volt_uV);
+}
+
+static const struct scmi_voltage_info * __must_check
+scmi_voltage_info_get(const struct scmi_handle *handle, u32 domain_id)
+{
+	struct voltage_info *vinfo = handle->voltage_priv;
+
+	if (domain_id >= vinfo->num_domains ||
+	    !vinfo->domains[domain_id].num_levels)
+		return NULL;
+
+	return vinfo->domains + domain_id;
+}
+
+static int scmi_voltage_domains_num_get(const struct scmi_handle *handle)
+{
+	struct voltage_info *vinfo = handle->voltage_priv;
+
+	return vinfo->num_domains;
+}
+
+static struct scmi_voltage_ops voltage_ops = {
+	.num_domains_get = scmi_voltage_domains_num_get,
+	.info_get = scmi_voltage_info_get,
+	.config_set = scmi_voltage_config_set,
+	.config_get = scmi_voltage_config_get,
+	.level_set = scmi_voltage_level_set,
+	.level_get = scmi_voltage_level_get,
+};
+
+static int scmi_voltage_protocol_init(struct scmi_handle *handle)
+{
+	int ret;
+	u32 version;
+	struct voltage_info *vinfo;
+
+	ret = scmi_version_get(handle, SCMI_PROTOCOL_VOLTAGE, &version);
+	if (ret)
+		return ret;
+
+	dev_dbg(handle->dev, "Voltage Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	vinfo = devm_kzalloc(handle->dev, sizeof(*vinfo), GFP_KERNEL);
+	if (!vinfo)
+		return -ENOMEM;
+	vinfo->version = version;
+
+	ret = scmi_protocol_attributes_get(handle, vinfo);
+	if (ret)
+		return ret;
+
+	if (vinfo->num_domains) {
+		vinfo->domains = devm_kcalloc(handle->dev, vinfo->num_domains,
+					      sizeof(*vinfo->domains),
+					      GFP_KERNEL);
+		if (!vinfo->domains)
+			return -ENOMEM;
+		ret = scmi_voltage_descriptors_get(handle, vinfo);
+		if (ret)
+			return ret;
+	} else {
+		dev_warn(handle->dev, "No Voltage domains found.\n");
+	}
+
+	handle->voltage_ops = &voltage_ops;
+	handle->voltage_priv = vinfo;
+
+	return 0;
+}
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_VOLTAGE, voltage)
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 9cd312a1ff92..b11ca01e2393 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -209,6 +209,64 @@ struct scmi_reset_ops {
 	int (*deassert)(const struct scmi_handle *handle, u32 domain);
 };
 
+/**
+ * struct scmi_voltage_info - describe one available SCMI Voltage Domain
+ *
+ * @id: the domain ID as advertised by the platform
+ * @segmented: defines the layout of the entries of array @levels_uv.
+ *	       - when True the entries are to be interpreted as triplets,
+ *	         each defining a segment representing a range of equally
+ *	         space voltages: <lowest_volts>, <highest_volt>, <step_uV>
+ *	       - when False the entries simply represent a single discrete
+ *	         supported voltage level
+ * @negative_volts_allowed: True if any of the entries of @levels_uv represent
+ *			    a negative voltage.
+ * @attributes: represents Voltage Domain advertised attributes
+ * @name: name assigned to the Voltage Domain by platform
+ * @num_levels: number of total entries in @levels_uv.
+ * @levels_uv: array of entries describing the available voltage levels for
+ *	       this domain.
+ */
+struct scmi_voltage_info {
+	unsigned int id;
+	bool segmented;
+	bool negative_volts_allowed;
+	unsigned int attributes;
+	char name[SCMI_MAX_STR_SIZE];
+	unsigned int num_levels;
+#define SCMI_VOLTAGE_SEGMENT_LOW	0
+#define SCMI_VOLTAGE_SEGMENT_HIGH	1
+#define SCMI_VOLTAGE_SEGMENT_STEP	2
+	int *levels_uv;
+};
+
+/**
+ * struct scmi_voltage_ops - represents the various operations provided
+ * by SCMI Voltage Protocol
+ *
+ * @num_domains_get: get the count of voltage domains provided by SCMI
+ * @info_get: get the information of the specified domain
+ * @config_set: set the config for the specified domain
+ * @config_get: get the config of the specified domain
+ * @level_set: set the voltage level for the specified domain
+ * @level_get: get the voltage level of the specified domain
+ */
+struct scmi_voltage_ops {
+	int (*num_domains_get)(const struct scmi_handle *handle);
+	const struct scmi_voltage_info __must_check *(*info_get)
+		(const struct scmi_handle *handle, u32 domain_id);
+	int (*config_set)(const struct scmi_handle *handle, u32 domain_id,
+			  u32 config);
+#define	SCMI_VOLTAGE_ARCH_STATE_OFF		0x0
+#define	SCMI_VOLTAGE_ARCH_STATE_ON		0x7
+	int (*config_get)(const struct scmi_handle *handle, u32 domain_id,
+			  u32 *config);
+	int (*level_set)(const struct scmi_handle *handle, u32 domain_id,
+			 u32 flags, s32 volt_uV);
+	int (*level_get)(const struct scmi_handle *handle, u32 domain_id,
+			 s32 *volt_uV);
+};
+
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided by
  * SCMI core
@@ -262,6 +320,7 @@ struct scmi_notify_ops {
  * @clk_ops: pointer to set of clock protocol operations
  * @sensor_ops: pointer to set of sensor protocol operations
  * @reset_ops: pointer to set of reset protocol operations
+ * @voltage_ops: pointer to set of voltage protocol operations
  * @notify_ops: pointer to set of notifications related operations
  * @perf_priv: pointer to private data structure specific to performance
  *	protocol(for internal use only)
@@ -273,6 +332,8 @@ struct scmi_notify_ops {
  *	protocol(for internal use only)
  * @reset_priv: pointer to private data structure specific to reset
  *	protocol(for internal use only)
+ * @voltage_priv: pointer to private data structure specific to voltage
+ *	protocol(for internal use only)
  * @notify_priv: pointer to private data structure specific to notifications
  *	(for internal use only)
  */
@@ -284,6 +345,7 @@ struct scmi_handle {
 	const struct scmi_power_ops *power_ops;
 	const struct scmi_sensor_ops *sensor_ops;
 	const struct scmi_reset_ops *reset_ops;
+	const struct scmi_voltage_ops *voltage_ops;
 	const struct scmi_notify_ops *notify_ops;
 	/* for protocol internal use */
 	void *perf_priv;
@@ -291,6 +353,7 @@ struct scmi_handle {
 	void *power_priv;
 	void *sensor_priv;
 	void *reset_priv;
+	void *voltage_priv;
 	void *notify_priv;
 	void *system_priv;
 };
@@ -303,6 +366,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_CLOCK = 0x14,
 	SCMI_PROTOCOL_SENSOR = 0x15,
 	SCMI_PROTOCOL_RESET = 0x16,
+	SCMI_PROTOCOL_VOLTAGE = 0x17,
 };
 
 enum scmi_system_events {
-- 
2.17.1

