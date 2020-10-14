Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F52B28E2CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbgJNPHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:07:34 -0400
Received: from foss.arm.com ([217.140.110.172]:50954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731654AbgJNPHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:07:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97A7DD6E;
        Wed, 14 Oct 2020 08:07:10 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A77323F71F;
        Wed, 14 Oct 2020 08:07:08 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 09/11] [DEBUG] firmware: arm_scmi: add example SCMI driver for custom protocol
Date:   Wed, 14 Oct 2020 16:05:43 +0100
Message-Id: <20201014150545.44807-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014150545.44807-1-cristian.marussi@arm.com>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an example SCMI driver using custom vendor protocol 0x99 and also
registering for Performance protocol notifications.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/Kconfig                      |   7 +
 drivers/firmware/arm_scmi/Makefile            |   2 +
 drivers/firmware/arm_scmi/scmi_custom_dummy.c | 126 ++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/scmi_custom_dummy.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 75e2668a6490..d209df6fd3ee 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -48,6 +48,13 @@ config ARM_SCMI_POWER_DOMAIN
 	  will be called scmi_pm_domain. Note this may needed early in boot
 	  before rootfs may be available.
 
+config ARM_SCMI_CUSTOM_DUMMY
+	tristate "SCMI Custom Dummy driver"
+	depends on ARM_SCMI_PROTOCOL_CUSTOM || (COMPILE_TEST && OF)
+	default n
+	help
+	  Custom Dummy driver
+
 config ARM_SCPI_PROTOCOL
 	tristate "ARM System Control and Power Interface (SCPI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 0a03b7432497..361ede03cdb5 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -12,3 +12,5 @@ obj-$(CONFIG_ARM_SCMI_PROTOCOL_CUSTOM) += scmi_custom.o
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
+
+obj-$(CONFIG_ARM_SCMI_CUSTOM_DUMMY) += scmi_custom_dummy.o
diff --git a/drivers/firmware/arm_scmi/scmi_custom_dummy.c b/drivers/firmware/arm_scmi/scmi_custom_dummy.c
new file mode 100644
index 000000000000..28fd3595a690
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_custom_dummy.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * Copyright (C) 2018-2020 ARM Ltd.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/pm_domain.h>
+#include <linux/scmi_protocol.h>
+
+static const struct scmi_dummy_ops *dummy_ops;
+
+static int dummy_custom_perf_cb(struct notifier_block *nb,
+				unsigned long event, void *data)
+{
+	struct scmi_perf_level_report *er = data;
+
+	pr_info("%s()::%d - EVENT:[%ld] - TS:%lld  DOMAIN_ID:%d  AGENT_ID:%d  LEVEL:%d\n",
+		__func__, __LINE__, event, er->timestamp, er->domain_id,
+		er->agent_id, er->performance_level);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block dummy_custom_perf_nb = {
+	.notifier_call = dummy_custom_perf_cb,
+	.priority = 10,
+};
+
+static int custom_dummy_scream_cb(struct notifier_block *nb,
+				  unsigned long event, void *data)
+{
+	struct scmi_dummy_scream_report *er = data;
+
+	pr_info("%s()::%d - EVENT:[%ld] - TS:%lld  DOMAIN_ID:%d  AGENT_ID:%d  LEVEL:%d\n",
+		__func__, __LINE__, event, er->timestamp, er->domain_id,
+		er->agent_id, er->scream);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block custom_dummy_nb = {
+	.notifier_call = custom_dummy_scream_cb,
+	.priority = 10,
+};
+
+static int scmi_dummy_probe(struct scmi_device *sdev)
+{
+	int num_domains;
+	struct device *dev = &sdev->dev;
+	const struct scmi_handle *handle = sdev->handle;
+	u32 src_id;
+
+	if (!handle)
+		return -ENODEV;
+
+	dummy_ops = handle->get_ops(handle, SCMI_PROTOCOL_CUSTOM_DUMMY);
+	if (IS_ERR(dummy_ops))
+		return PTR_ERR(dummy_ops);
+
+	num_domains = dummy_ops->num_domains_get(handle);
+	if (num_domains < 0) {
+		dev_err(dev, "number of domains not found\n");
+		return num_domains;
+	}
+
+	pr_info("Registering notify_callback as CUSTOM_DUMMY !!\n");
+
+	src_id = 0x02;
+	handle->notify_ops->register_event_notifier(handle,
+						    SCMI_PROTOCOL_CUSTOM_DUMMY,
+						    SCMI_EVENT_DUMMY_SCREAM,
+						    &src_id, &custom_dummy_nb);
+
+	src_id = 0x01;
+	handle->notify_ops->register_event_notifier(handle,
+						    SCMI_PROTOCOL_PERF,
+					SCMI_EVENT_PERFORMANCE_LEVEL_CHANGED,
+						    &src_id,
+						    &dummy_custom_perf_nb);
+
+	return 0;
+}
+
+static void scmi_dummy_remove(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	u32 src_id;
+
+	src_id = 0x02;
+	handle->notify_ops->unregister_event_notifier(handle,
+						     SCMI_PROTOCOL_CUSTOM_DUMMY,
+						     SCMI_EVENT_DUMMY_SCREAM,
+						     &src_id, &custom_dummy_nb);
+
+	src_id = 0x01;
+	handle->notify_ops->unregister_event_notifier(handle,
+						      SCMI_PROTOCOL_PERF,
+					SCMI_EVENT_PERFORMANCE_LEVEL_CHANGED,
+						      &src_id,
+						      &dummy_custom_perf_nb);
+
+	handle->put_ops(handle, SCMI_PROTOCOL_CUSTOM_DUMMY);
+
+	return;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_CUSTOM_DUMMY, "custom_dummy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_custom_dummy_driver = {
+	.name = "scmi-custom-dummy",
+	.probe = scmi_dummy_probe,
+	.remove = scmi_dummy_remove,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_custom_dummy_driver);
+
+MODULE_AUTHOR("DummyMaster");
+MODULE_DESCRIPTION("ARM SCMI Custom Dummy driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

