Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF852CC81A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388349AbgLBUmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:39 -0500
Received: from foss.arm.com ([217.140.110.172]:50418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbgLBUmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C150D161B;
        Wed,  2 Dec 2020 12:41:41 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D45DF3F575;
        Wed,  2 Dec 2020 12:41:39 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 36/37] firmware: arm_scmi: add protocol modularization support
Date:   Wed,  2 Dec 2020 20:40:08 +0000
Message-Id: <20201202204009.32073-37-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend SCMI protocols accounting mechanism to address possible module
usage and add the support to possibly define new protocols as loadable
modules.

Keep Standard protocols built into the SCMI core.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c    |  2 ++
 drivers/firmware/arm_scmi/bus.c     | 11 ++++++++++-
 drivers/firmware/arm_scmi/clock.c   |  2 ++
 drivers/firmware/arm_scmi/common.h  |  4 ++++
 drivers/firmware/arm_scmi/driver.c  |  5 ++++-
 drivers/firmware/arm_scmi/perf.c    |  2 ++
 drivers/firmware/arm_scmi/power.c   |  2 ++
 drivers/firmware/arm_scmi/reset.c   |  2 ++
 drivers/firmware/arm_scmi/sensors.c |  2 ++
 drivers/firmware/arm_scmi/system.c  |  2 ++
 include/linux/scmi_protocol.h       | 12 ++++++++++++
 11 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index f2d10c5a55ae..b70d741f8465 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "SCMI Notifications BASE - " fmt
 
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
 #include "common.h"
@@ -373,6 +374,7 @@ static int scmi_base_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_base = {
 	.id = SCMI_PROTOCOL_BASE,
+	.owner = NULL,
 	.init_instance = &scmi_base_protocol_init,
 	.ops = NULL,
 	.events = &base_protocol_events,
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 9fbf618b9c4b..88e5057f4e85 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -56,7 +56,7 @@ const struct scmi_protocol *scmi_get_protocol(int protocol_id)
 	const struct scmi_protocol *proto;
 
 	proto = idr_find(&scmi_available_protocols, protocol_id);
-	if (!proto) {
+	if (!proto || !try_module_get(proto->owner)) {
 		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
 		return NULL;
 	}
@@ -66,6 +66,15 @@ const struct scmi_protocol *scmi_get_protocol(int protocol_id)
 	return proto;
 }
 
+void scmi_put_protocol(int protocol_id)
+{
+	const struct scmi_protocol *proto;
+
+	proto = idr_find(&scmi_available_protocols, protocol_id);
+	if (proto)
+		module_put(proto->owner);
+}
+
 static int scmi_dev_probe(struct device *dev)
 {
 	struct scmi_driver *scmi_drv = to_scmi_driver(dev->driver);
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index a0a6593f464f..bd364d3a56d2 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018-2020 ARM Ltd.
  */
 
+#include <linux/module.h>
 #include <linux/sort.h>
 
 #include "common.h"
@@ -367,6 +368,7 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_clock = {
 	.id = SCMI_PROTOCOL_CLOCK,
+	.owner = THIS_MODULE,
 	.init_instance = &scmi_clock_protocol_init,
 	.ops = &clk_proto_ops,
 };
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 5fb64182610a..1e2046c61d43 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 #include <linux/types.h>
 
@@ -214,6 +215,7 @@ typedef int (*scmi_prot_init_ph_fn_t)(const struct scmi_protocol_handle *);
 /**
  * struct scmi_protocol  - Protocol descriptor
  * @id: Protocol ID.
+ * @owner: Module reference if any.
  * @init_instance: Mandatory protocol initialization function.
  * @deinit_instance: Optional protocol de-initialization function.
  * @ops: Optional reference to the operations provided by the protocol and
@@ -222,6 +224,7 @@ typedef int (*scmi_prot_init_ph_fn_t)(const struct scmi_protocol_handle *);
  */
 struct scmi_protocol {
 	const u8				id;
+	struct module				*owner;
 	const scmi_prot_init_ph_fn_t		init_instance;
 	const scmi_prot_init_ph_fn_t		deinit_instance;
 	const void				*ops;
@@ -255,6 +258,7 @@ void __exit scmi_##name##_unregister(void) \
 }
 
 const struct scmi_protocol *scmi_get_protocol(int protocol_id);
+void scmi_put_protocol(int protocol_id);
 
 int scmi_acquire_protocol(const struct scmi_handle *handle, u8 protocol_id);
 void scmi_release_protocol(const struct scmi_handle *handle, u8 protocol_id);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a0a6a3d1d239..4b68952e49db 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -677,7 +677,7 @@ scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 		/* Fail if protocol not registered on bus */
 		proto = scmi_get_protocol(protocol_id);
 		if (!proto) {
-			ret = -ENODEV;
+			ret = -EPROBE_DEFER;
 			goto out;
 		}
 
@@ -722,6 +722,7 @@ scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 	return pi;
 
 clean:
+	scmi_put_protocol(protocol_id);
 	devres_release_group(handle->dev, gid);
 out:
 	mutex_unlock(&info->protocols_mtx);
@@ -772,6 +773,8 @@ void scmi_release_protocol(const struct scmi_handle *handle, u8 protocol_id)
 
 		idr_remove(&info->protocols, protocol_id);
 
+		scmi_put_protocol(protocol_id);
+
 		devres_release_group(handle->dev, gid);
 		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
 			protocol_id);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 49a33fc1c319..f0e717b9830c 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/scmi_protocol.h>
@@ -901,6 +902,7 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_perf = {
 	.id = SCMI_PROTOCOL_PERF,
+	.owner = THIS_MODULE,
 	.init_instance = &scmi_perf_protocol_init,
 	.ops = &perf_proto_ops,
 	.events = &perf_protocol_events,
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 3e453d9bcbc8..70d366ed37e6 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "SCMI Notifications POWER - " fmt
 
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
 #include "common.h"
@@ -312,6 +313,7 @@ static int scmi_power_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_power = {
 	.id = SCMI_PROTOCOL_POWER,
+	.owner = THIS_MODULE,
 	.init_instance = &scmi_power_protocol_init,
 	.ops = &power_proto_ops,
 	.events = &power_protocol_events,
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index bd28d4e9664d..b26686dd8526 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "SCMI Notifications RESET - " fmt
 
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
 #include "common.h"
@@ -324,6 +325,7 @@ static int scmi_reset_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_reset = {
 	.id = SCMI_PROTOCOL_RESET,
+	.owner = THIS_MODULE,
 	.init_instance = &scmi_reset_protocol_init,
 	.ops = &reset_proto_ops,
 	.events = &reset_protocol_events,
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index edc08d9f8daa..903fcdb57d4a 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) "SCMI Notifications SENSOR - " fmt
 
 #include <linux/bitfield.h>
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
 #include "common.h"
@@ -990,6 +991,7 @@ static int scmi_sensors_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_sensors = {
 	.id = SCMI_PROTOCOL_SENSOR,
+	.owner = THIS_MODULE,
 	.init_instance = &scmi_sensors_protocol_init,
 	.ops = &sensor_proto_ops,
 	.events = &sensor_protocol_events,
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index 97ad20a51d72..a68bad27688f 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "SCMI Notifications SYSTEM - " fmt
 
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
 #include "common.h"
@@ -130,6 +131,7 @@ static int scmi_system_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_system = {
 	.id = SCMI_PROTOCOL_SYSTEM,
+	.owner = THIS_MODULE,
 	.init_instance = &scmi_system_protocol_init,
 	.ops = NULL,
 	.events = &system_protocol_events,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 82611f564c66..343131e68697 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -708,6 +708,18 @@ static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
 #define module_scmi_driver(__scmi_driver)	\
 	module_driver(__scmi_driver, scmi_register, scmi_unregister)
 
+/**
+ * module_scmi_protocol() - Helper macro for registering a scmi protocol
+ * @__scmi_protocol: scmi_protocol structure
+ *
+ * Helper macro for scmi drivers to set up proper module init / exit
+ * functions.  Replaces module_init() and module_exit() and keeps people from
+ * printing pointless things to the kernel log when their driver is loaded.
+ */
+#define module_scmi_protocol(__scmi_protocol)	\
+	module_driver(__scmi_protocol,		\
+		      scmi_protocol_register, scmi_protocol_unregister)
+
 struct scmi_protocol;
 int scmi_protocol_register(const struct scmi_protocol *proto);
 void scmi_protocol_unregister(const struct scmi_protocol *proto);
-- 
2.17.1

