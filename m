Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC728E2CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgJNPHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:07:11 -0400
Received: from foss.arm.com ([217.140.110.172]:50920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731619AbgJNPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:07:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88647D6E;
        Wed, 14 Oct 2020 08:07:06 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE49D3F71F;
        Wed, 14 Oct 2020 08:07:04 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 07/11] [DEBUG] firmware: arm_scmi: add example custom protocol
Date:   Wed, 14 Oct 2020 16:05:41 +0100
Message-Id: <20201014150545.44807-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014150545.44807-1-cristian.marussi@arm.com>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a loadable module implementing a custom vendor protocol
just as an example.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/Kconfig                |  10 +-
 drivers/firmware/arm_scmi/Makefile      |   3 +
 drivers/firmware/arm_scmi/scmi_custom.c | 170 ++++++++++++++++++++++++
 include/linux/scmi_protocol.h           |  21 +++
 4 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/scmi_custom.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index afdbebba628a..75e2668a6490 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -6,7 +6,7 @@
 
 menu "Firmware Drivers"
 
-config ARM_SCMI_PROTOCOL
+menuconfig ARM_SCMI_PROTOCOL
 	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
 	depends on MAILBOX
@@ -27,6 +27,14 @@ config ARM_SCMI_PROTOCOL
 	  This protocol library provides interface for all the client drivers
 	  making use of the features offered by the SCMI.
 
+if ARM_SCMI_PROTOCOL
+	config ARM_SCMI_PROTOCOL_CUSTOM
+		tristate "SCMI Custom Protocol Implementation"
+		default y
+		help
+		  ARM SCMI System Custom Protocol implementation
+endif
+
 config ARM_SCMI_POWER_DOMAIN
 	tristate "SCMI power domain driver"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index bc0d54f8e861..0a03b7432497 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -7,5 +7,8 @@ scmi-transport-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) += smc.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o
 scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
 		    $(scmi-transport-y)
+
+obj-$(CONFIG_ARM_SCMI_PROTOCOL_CUSTOM) += scmi_custom.o
+
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
diff --git a/drivers/firmware/arm_scmi/scmi_custom.c b/drivers/firmware/arm_scmi/scmi_custom.c
new file mode 100644
index 000000000000..5dfdbd175043
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_custom.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Dummy Custom Protocol
+ *
+ * Copyright (C) 2018-2020 ARM Ltd.
+ */
+
+#define pr_fmt(fmt) "SCMI Notifications CUSTOM - " fmt
+
+#include <linux/scmi_protocol.h>
+
+#include "common.h"
+#include "notify.h"
+
+static const struct scmi_xfer_ops *ops;
+
+struct scmi_dummy_scream_notify_payld {
+	__le32 agent_id;
+	__le32 domain_id;
+	__le32 scream;
+};
+
+struct dummy_dom_info {
+	bool state_set_sync;
+	bool state_set_async;
+	bool state_set_notify;
+	char name[SCMI_MAX_STR_SIZE];
+};
+
+struct scmi_dummy_info {
+	u32 version;
+	int num_domains;
+	u64 stats_addr;
+	u32 stats_size;
+	struct dummy_dom_info *dom_info;
+};
+
+static int scmi_dummy_num_domains_get(const struct scmi_handle *handle)
+{
+	struct scmi_dummy_info *di =
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_CUSTOM_DUMMY);
+
+	return di->num_domains;
+}
+
+static const struct scmi_dummy_ops dummy_ops = {
+	.num_domains_get = scmi_dummy_num_domains_get,
+};
+
+static int scmi_dummy_request_notify(const struct scmi_handle *handle,
+				     u32 domain, bool enable)
+{
+	return domain % 2;
+}
+
+static int scmi_dummy_set_notify_enabled(const struct scmi_handle *handle,
+					 u8 evt_id, u32 src_id, bool enable)
+{
+	int ret;
+
+	ret = scmi_dummy_request_notify(handle, src_id, enable);
+	if (ret)
+		pr_debug("FAIL_ENABLE - evt[%X] dom[%d] - ret:%d\n",
+			 evt_id, src_id, ret);
+	else
+		pr_warn("NOTIF %sABLED - evt[%X] dom[%d]\n",
+			enable ? "EN" : "DIS", evt_id, src_id);
+
+	return ret;
+}
+
+static void *scmi_dummy_fill_custom_report(const struct scmi_handle *handle,
+					   u8 evt_id, ktime_t timestamp,
+					   const void *payld, size_t payld_sz,
+					   void *report, u32 *src_id)
+{
+	const struct scmi_dummy_scream_notify_payld *p = payld;
+	struct scmi_dummy_scream_report *r = report;
+
+	if (evt_id != SCMI_EVENT_DUMMY_SCREAM || sizeof(*p) != payld_sz)
+		return NULL;
+
+	r->timestamp = timestamp;
+	r->agent_id = le32_to_cpu(p->agent_id);
+	r->domain_id = le32_to_cpu(p->domain_id);
+	r->scream = le32_to_cpu(p->scream);
+	*src_id = r->domain_id;
+
+	return r;
+}
+
+static int scmi_dummy_get_num_sources(const struct scmi_handle *handle)
+{
+	struct scmi_dummy_info *dinfo =
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_CUSTOM_DUMMY);
+
+	if (!dinfo)
+		return -EINVAL;
+
+	return dinfo->num_domains;
+}
+
+static const struct scmi_event dummy_events[] = {
+	{
+		.id = SCMI_EVENT_DUMMY_SCREAM,
+		.max_payld_sz = sizeof(struct scmi_dummy_scream_notify_payld),
+		.max_report_sz =
+			sizeof(struct scmi_dummy_scream_report),
+	},
+};
+
+static const struct scmi_event_ops dummy_event_ops = {
+	.get_num_sources = scmi_dummy_get_num_sources,
+	.set_notify_enabled = scmi_dummy_set_notify_enabled,
+	.fill_custom_report = scmi_dummy_fill_custom_report,
+};
+
+static const struct scmi_protocol_events dummy_protocol_events = {
+	.queue_sz = SCMI_PROTO_QUEUE_SZ,
+	.ops = &dummy_event_ops,
+	.evts = dummy_events,
+	.num_events = ARRAY_SIZE(dummy_events),
+};
+
+static int scmi_dummy_protocol_init(const struct scmi_handle *handle,
+				    const struct scmi_xfer_ops *xops)
+{
+	u32 version = 0x20000001;
+	struct scmi_dummy_info *dinfo;
+
+	ops = xops;
+	//ops->version_get(handle, SCMI_PROTOCOL_POWER, &version);
+
+	dev_dbg(handle->dev, "Dummy Custom Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	dinfo = devm_kzalloc(handle->dev, sizeof(*dinfo), GFP_KERNEL);
+	if (!dinfo)
+		return -ENOMEM;
+
+	dinfo->num_domains = 5;
+
+	dinfo->dom_info = devm_kcalloc(handle->dev, dinfo->num_domains,
+				       sizeof(*dinfo->dom_info), GFP_KERNEL);
+	if (!dinfo->dom_info)
+		return -ENOMEM;
+
+	dinfo->version = version;
+	return ops->set_proto_priv(handle, SCMI_PROTOCOL_CUSTOM_DUMMY, dinfo);
+}
+
+static int scmi_dummy_protocol_deinit(const struct scmi_handle *handle,
+				      const struct scmi_xfer_ops *xops)
+{
+	return 0;
+}
+
+static struct scmi_protocol scmi_custom = {
+	.id = SCMI_PROTOCOL_CUSTOM_DUMMY,
+	.init = &scmi_dummy_protocol_init,
+	.deinit = &scmi_dummy_protocol_deinit,
+	.ops = &dummy_ops,
+	.events = &dummy_protocol_events,
+};
+
+module_scmi_protocol(scmi_custom);
+
+MODULE_AUTHOR("DummyMaster");
+MODULE_DESCRIPTION("ARM SCMI Custom Dummy Protocol");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index da675d6f90c0..9a89ca68b27d 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -209,6 +209,12 @@ struct scmi_reset_ops {
 	int (*deassert)(const struct scmi_handle *handle, u32 domain);
 };
 
+#if IS_ENABLED(CONFIG_ARM_SCMI_PROTOCOL_CUSTOM)
+struct scmi_dummy_ops {
+	int (*num_domains_get)(const struct scmi_handle *handle);
+};
+#endif
+
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided by
  * SCMI core
@@ -278,6 +284,9 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_CLOCK = 0x14,
 	SCMI_PROTOCOL_SENSOR = 0x15,
 	SCMI_PROTOCOL_RESET = 0x16,
+#if IS_ENABLED(CONFIG_ARM_SCMI_PROTOCOL_CUSTOM)
+	SCMI_PROTOCOL_CUSTOM_DUMMY = 0x99,
+#endif
 };
 
 enum scmi_system_events {
@@ -380,6 +389,9 @@ enum scmi_notification_events {
 	SCMI_EVENT_RESET_ISSUED = 0x0,
 	SCMI_EVENT_BASE_ERROR_EVENT = 0x0,
 	SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER = 0x0,
+#if IS_ENABLED(CONFIG_ARM_SCMI_PROTOCOL_CUSTOM)
+	SCMI_EVENT_DUMMY_SCREAM = 0x0,
+#endif
 };
 
 struct scmi_power_state_changed_report {
@@ -433,4 +445,13 @@ struct scmi_base_error_report {
 	unsigned long long	reports[];
 };
 
+#if IS_ENABLED(CONFIG_ARM_SCMI_PROTOCOL_CUSTOM)
+struct scmi_dummy_scream_report {
+	ktime_t		timestamp;
+	unsigned int	agent_id;
+	unsigned int	domain_id;
+	unsigned int	scream;
+};
+#endif
+
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1

