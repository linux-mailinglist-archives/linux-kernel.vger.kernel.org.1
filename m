Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2A728E2C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbgJNPG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:06:59 -0400
Received: from foss.arm.com ([217.140.110.172]:50826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbgJNPG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:06:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D2AE1424;
        Wed, 14 Oct 2020 08:06:55 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 931213F71F;
        Wed, 14 Oct 2020 08:06:53 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 01/11] firmware: arm_scmi: review protocol registration interface
Date:   Wed, 14 Oct 2020 16:05:35 +0100
Message-Id: <20201014150545.44807-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014150545.44807-1-cristian.marussi@arm.com>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend common protocol registration routines and provide some new generic
protocols' init/deinit helpers that tracks protocols' users and automatically
perform the proper initialization/de-initialization on demand.

Convert all protocols to use new registration schema while modifying only Base
protocol to use also the new initialization helpers.

All other standard protocols' initialization is still umodified and bound to
SCMI devices probing.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c    |  10 +-
 drivers/firmware/arm_scmi/bus.c     |  61 +++++++---
 drivers/firmware/arm_scmi/clock.c   |  10 +-
 drivers/firmware/arm_scmi/common.h  |  31 ++++-
 drivers/firmware/arm_scmi/driver.c  | 168 +++++++++++++++++++++++++++-
 drivers/firmware/arm_scmi/notify.c  |   3 +-
 drivers/firmware/arm_scmi/perf.c    |  10 +-
 drivers/firmware/arm_scmi/power.c   |  10 +-
 drivers/firmware/arm_scmi/reset.c   |  10 +-
 drivers/firmware/arm_scmi/sensors.c |  10 +-
 drivers/firmware/arm_scmi/system.c  |   8 +-
 include/linux/scmi_protocol.h       |   6 +-
 12 files changed, 298 insertions(+), 39 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 017e5d8bd869..f19e08ed4369 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -318,7 +318,7 @@ static const struct scmi_event_ops base_event_ops = {
 	.fill_custom_report = scmi_base_fill_custom_report,
 };
 
-int scmi_base_protocol_init(struct scmi_handle *h)
+static int scmi_base_protocol_init(struct scmi_handle *h)
 {
 	int id, ret;
 	u8 *prot_imp;
@@ -365,3 +365,11 @@ int scmi_base_protocol_init(struct scmi_handle *h)
 
 	return 0;
 }
+
+static struct scmi_protocol scmi_base = {
+	.id = SCMI_PROTOCOL_BASE,
+	.init = &scmi_base_protocol_init,
+	.ops = NULL,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(base, scmi_base)
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 1377ec76a45d..afa2e4818a2b 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -16,7 +16,7 @@
 #include "common.h"
 
 static DEFINE_IDA(scmi_bus_id);
-static DEFINE_IDR(scmi_protocols);
+static DEFINE_IDR(scmi_available_protocols);
 static DEFINE_SPINLOCK(protocol_lock);
 
 static const struct scmi_device_id *
@@ -51,13 +51,29 @@ static int scmi_dev_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
+const struct scmi_protocol *scmi_get_protocol(int protocol_id)
+{
+	const struct scmi_protocol *proto;
+
+	proto = idr_find(&scmi_available_protocols, protocol_id);
+	if (!proto) {
+		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
+		return NULL;
+	}
+
+	pr_debug("GOT SCMI Protocol 0x%x\n", protocol_id);
+
+	return proto;
+}
+
 static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
 {
-	scmi_prot_init_fn_t fn = idr_find(&scmi_protocols, protocol_id);
+	const struct scmi_protocol *proto;
 
-	if (unlikely(!fn))
+	proto = idr_find(&scmi_available_protocols, protocol_id);
+	if (!proto)
 		return -EINVAL;
-	return fn(handle);
+	return proto->init(handle);
 }
 
 static int scmi_protocol_dummy_init(struct scmi_handle *handle)
@@ -84,7 +100,7 @@ static int scmi_dev_probe(struct device *dev)
 		return ret;
 
 	/* Skip protocol initialisation for additional devices */
-	idr_replace(&scmi_protocols, &scmi_protocol_dummy_init,
+	idr_replace(&scmi_available_protocols, &scmi_protocol_dummy_init,
 		    scmi_dev->protocol_id);
 
 	return scmi_drv->probe(scmi_dev);
@@ -194,26 +210,45 @@ void scmi_set_handle(struct scmi_device *scmi_dev)
 	scmi_dev->handle = scmi_handle_get(&scmi_dev->dev);
 }
 
-int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn)
+int scmi_protocol_register(struct scmi_protocol *proto)
 {
 	int ret;
 
+	if (!proto) {
+		pr_err("invalid protocol\n");
+		return -EINVAL;
+	}
+
+	if (!proto->init) {
+		pr_err("missing .init() for protocol 0x%x\n", proto->id);
+		return -EINVAL;
+	}
+
 	spin_lock(&protocol_lock);
-	ret = idr_alloc(&scmi_protocols, fn, protocol_id, protocol_id + 1,
-			GFP_ATOMIC);
+	ret = idr_alloc(&scmi_available_protocols, proto,
+			proto->id, proto->id + 1, GFP_ATOMIC);
 	spin_unlock(&protocol_lock);
-	if (ret != protocol_id)
-		pr_err("unable to allocate SCMI idr slot, err %d\n", ret);
+	if (ret != proto->id) {
+		pr_err("unable to allocate SCMI idr slot for 0x%x - err %d\n",
+		       proto->id, ret);
+		return ret;
+	}
+
+	pr_debug("Registered SCMI Protocol 0x%x\n", proto->id);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(scmi_protocol_register);
 
-void scmi_protocol_unregister(int protocol_id)
+void scmi_protocol_unregister(const struct scmi_protocol *proto)
 {
 	spin_lock(&protocol_lock);
-	idr_remove(&scmi_protocols, protocol_id);
+	idr_remove(&scmi_available_protocols, proto->id);
 	spin_unlock(&protocol_lock);
+
+	pr_debug("Unregistered SCMI Protocol 0x%x\n", proto->id);
+
+	return;
 }
 EXPORT_SYMBOL_GPL(scmi_protocol_unregister);
 
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 4645677d86f1..94bcad9a7d19 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) Clock Protocol
  *
- * Copyright (C) 2018 ARM Ltd.
+ * Copyright (C) 2018-2020 ARM Ltd.
  */
 
 #include <linux/sort.h>
@@ -366,4 +366,10 @@ static int scmi_clock_protocol_init(struct scmi_handle *handle)
 	return 0;
 }
 
-DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_CLOCK, clock)
+static struct scmi_protocol scmi_clock = {
+	.id = SCMI_PROTOCOL_CLOCK,
+	.init = &scmi_clock_protocol_init,
+	.ops = &clk_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(clock, scmi_clock)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 65063fa948d4..b08a8ddbc22a 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -19,6 +19,8 @@
 
 #include <asm/unaligned.h>
 
+#define SCMI_MAX_PROTO		256
+
 #define PROTOCOL_REV_MINOR_MASK	GENMASK(15, 0)
 #define PROTOCOL_REV_MAJOR_MASK	GENMASK(31, 16)
 #define PROTOCOL_REV_MAJOR(x)	(u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x)))
@@ -156,7 +158,22 @@ int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version);
 void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
 				     u8 *prot_imp);
 
-int scmi_base_protocol_init(struct scmi_handle *h);
+typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
+
+/**
+ * struct scmi_protocol  - Protocol descriptor
+ * @id: Protocol ID.
+ * @init: Mandatory protocol initialization function.
+ * @deinit: Optional protocol de-initialization function.
+ * @ops: Optional reference to the operations provided by the protocol and
+ *	 exposed in scmi_protocol.h.
+ */
+struct scmi_protocol {
+	const u8				id;
+	const scmi_prot_init_fn_t		init;
+	const scmi_prot_init_fn_t		deinit;
+	const void				*ops;
+};
 
 int __init scmi_bus_init(void);
 void __exit scmi_bus_exit(void);
@@ -164,6 +181,7 @@ void __exit scmi_bus_exit(void);
 #define DECLARE_SCMI_REGISTER_UNREGISTER(func)		\
 	int __init scmi_##func##_register(void);	\
 	void __exit scmi_##func##_unregister(void)
+DECLARE_SCMI_REGISTER_UNREGISTER(base);
 DECLARE_SCMI_REGISTER_UNREGISTER(clock);
 DECLARE_SCMI_REGISTER_UNREGISTER(perf);
 DECLARE_SCMI_REGISTER_UNREGISTER(power);
@@ -171,17 +189,22 @@ DECLARE_SCMI_REGISTER_UNREGISTER(reset);
 DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
 DECLARE_SCMI_REGISTER_UNREGISTER(system);
 
-#define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(id, name) \
+#define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(name, proto) \
 int __init scmi_##name##_register(void) \
 { \
-	return scmi_protocol_register((id), &scmi_##name##_protocol_init); \
+	return scmi_protocol_register(&(proto)); \
 } \
 \
 void __exit scmi_##name##_unregister(void) \
 { \
-	scmi_protocol_unregister((id)); \
+	scmi_protocol_unregister(&(proto)); \
 }
 
+const struct scmi_protocol *scmi_get_protocol(int protocol_id);
+
+int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id);
+void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id);
+
 /* SCMI Transport */
 /**
  * struct scmi_chan_info - Structure representing a SCMI channel information
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 3dfd8b6a0ebf..7de994e49884 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -23,6 +23,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/processor.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 
 #include "common.h"
@@ -68,6 +69,21 @@ struct scmi_xfers_info {
 	spinlock_t xfer_lock;
 };
 
+/**
+ * struct scmi_protocol_instance  - Describe an initialized protocol instance.
+ * @proto: A reference to the protocol descriptor.
+ * @gid: A reference for per-protocol devres management.
+ * @users: A refcount to track effective users of this protocol.
+ *
+ * Each protocol is initialized independently once for each SCMI platform in
+ * which is defined by DT and implemented by the SCMI server fw.
+ */
+struct scmi_protocol_instance {
+	const struct scmi_protocol	*proto;
+	void				*gid;
+	refcount_t			users;
+};
+
 /**
  * struct scmi_info - Structure representing a SCMI instance
  *
@@ -80,6 +96,10 @@ struct scmi_xfers_info {
  * @rx_minfo: Universal Receive Message management info
  * @tx_idr: IDR object to map protocol id to Tx channel info pointer
  * @rx_idr: IDR object to map protocol id to Rx channel info pointer
+ * @protocols: An array of protocols' instance descriptors initialized for
+ *	       this SCMI instance: populated on protocol's first attempted
+ *	       usage.
+ * @protocols_mtx: A mutex to protect protocols instances initialization.
  * @protocols_imp: List of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
  * @node: List head
@@ -94,6 +114,9 @@ struct scmi_info {
 	struct scmi_xfers_info rx_minfo;
 	struct idr tx_idr;
 	struct idr rx_idr;
+	struct scmi_protocol_instance *protocols[SCMI_MAX_PROTO];
+	/* Ensure mutual exclusive access to protocols instance array */
+	struct mutex protocols_mtx;
 	u8 *protocols_imp;
 	struct list_head node;
 	int users;
@@ -519,6 +542,132 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
 	return ret;
 }
 
+/**
+ * scmi_get_protocol_instance  - Protocol initialization helper.
+ * @handle: A reference to the SCMI platform instance.
+ * @protocol_id: The protocol being requested.
+ *
+ * In case the required protocol has never been requested before for this
+ * instance, allocate and initialize all the needed structures while handling
+ * resource allocation with a dedicated per-protocol devres subgroup.
+ *
+ * Return: A reference to an initialized protocol instance or error on failure.
+ */
+static struct scmi_protocol_instance * __must_check
+scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
+{
+	int ret = -ENOMEM;
+	void *gid;
+	struct scmi_protocol_instance *pi;
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	mutex_lock(&info->protocols_mtx);
+	/* Ensure protocols has been updated */
+	smp_rmb();
+	pi = info->protocols[protocol_id];
+
+	if (!pi) {
+		const struct scmi_protocol *proto;
+
+		/* Fail if protocol not registered on bus */
+		proto = scmi_get_protocol(protocol_id);
+		if (!proto) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* Protocol specific devres group */
+		gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
+		if (!gid)
+			goto out;
+
+		pi = devm_kzalloc(handle->dev, sizeof(*pi), GFP_KERNEL);
+		if (!pi)
+			goto clean;
+
+		pi->gid = gid;
+		pi->proto = proto;
+		refcount_set(&pi->users, 1);
+		/* proto->init is assured NON NULL by scmi_protocol_register */
+		ret = pi->proto->init(handle);
+		if (ret)
+			goto clean;
+
+		info->protocols[protocol_id] = pi;
+		/* Ensure initialized protocol is visible */
+		smp_wmb();
+
+		devres_close_group(handle->dev, pi->gid);
+		dev_dbg(handle->dev, "Initialized protocol: 0x%X\n",
+			protocol_id);
+	} else {
+		refcount_inc(&pi->users);
+	}
+	mutex_unlock(&info->protocols_mtx);
+
+	return pi;
+
+clean:
+	devres_release_group(handle->dev, gid);
+out:
+	mutex_unlock(&info->protocols_mtx);
+	return ERR_PTR(ret);
+}
+
+/**
+ * scmi_acquire_protocol  - Protocol acquire
+ * @handle: A reference to the SCMI platform instance.
+ * @protocol_id: The protocol being requested.
+ *
+ * Register a new user for the requested protocol on the specified SCMI
+ * platform instance, possibly triggering its initialization on first user.
+ *
+ * Return: 0 if protocol was acquired successfully.
+ */
+int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id)
+{
+	return IS_ERR(scmi_get_protocol_instance(handle, protocol_id));
+}
+
+/**
+ * scmi_release_protocol  - Protocol de-initialization helper.
+ * @handle: A reference to the SCMI platform instance.
+ * @protocol_id: The protocol being requested.
+ *
+ * Remove one user for the specified protocol and triggers de-initialization
+ * and resources de-allocation once the last user has gone.
+ */
+void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+	struct scmi_protocol_instance *pi;
+
+	mutex_lock(&info->protocols_mtx);
+	/* Ensure protocols has been updated */
+	smp_rmb();
+	pi = info->protocols[protocol_id];
+	if (WARN_ON(!pi)) {
+		mutex_unlock(&info->protocols_mtx);
+		return;
+	}
+
+	if (refcount_dec_and_test(&pi->users)) {
+		void *gid = pi->gid;
+
+		if (pi->proto->deinit)
+			pi->proto->deinit(handle);
+
+		info->protocols[protocol_id] = NULL;
+		/* Ensure deinitialized protocol is visible */
+		smp_wmb();
+
+		devres_release_group(handle->dev, gid);
+		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
+			protocol_id);
+	}
+	mutex_unlock(&info->protocols_mtx);
+}
+
 void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
 				     u8 *prot_imp)
 {
@@ -785,6 +934,7 @@ static int scmi_probe(struct platform_device *pdev)
 	info->dev = dev;
 	info->desc = desc;
 	INIT_LIST_HEAD(&info->node);
+	mutex_init(&info->protocols_mtx);
 
 	platform_set_drvdata(pdev, info);
 	idr_init(&info->tx_idr);
@@ -805,10 +955,14 @@ static int scmi_probe(struct platform_device *pdev)
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
 
-	ret = scmi_base_protocol_init(handle);
-	if (ret) {
-		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
-		return ret;
+	/*
+	 * Trigger SCMI Base protocol initialization.
+	 * It's mandatory and won't be ever released/deinit until the
+	 * SCMI stack is shutdown/unloaded as a whole.
+	 */
+	if (scmi_acquire_protocol(handle, SCMI_PROTOCOL_BASE)) {
+		dev_err(dev, "unable to communicate with SCMI\n");
+		return -ENODEV;
 	}
 
 	mutex_lock(&scmi_list_mutex);
@@ -941,6 +1095,8 @@ static int __init scmi_driver_init(void)
 {
 	scmi_bus_init();
 
+	scmi_base_register();
+
 	scmi_clock_register();
 	scmi_perf_register();
 	scmi_power_register();
@@ -954,7 +1110,7 @@ subsys_initcall(scmi_driver_init);
 
 static void __exit scmi_driver_exit(void)
 {
-	scmi_bus_exit();
+	scmi_base_unregister();
 
 	scmi_clock_unregister();
 	scmi_perf_unregister();
@@ -963,6 +1119,8 @@ static void __exit scmi_driver_exit(void)
 	scmi_sensors_unregister();
 	scmi_system_unregister();
 
+	scmi_bus_exit();
+
 	platform_driver_unregister(&scmi_driver);
 }
 module_exit(scmi_driver_exit);
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index c24e427dce0d..eae58b2a92cc 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -91,10 +91,9 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+#include "common.h"
 #include "notify.h"
 
-#define SCMI_MAX_PROTO		256
-
 #define PROTO_ID_MASK		GENMASK(31, 24)
 #define EVT_ID_MASK		GENMASK(23, 16)
 #define SRC_ID_MASK		GENMASK(15, 0)
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 82fb3babff72..854460a051c2 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) Performance Protocol
  *
- * Copyright (C) 2018 ARM Ltd.
+ * Copyright (C) 2018-2020 ARM Ltd.
  */
 
 #define pr_fmt(fmt) "SCMI Notifications PERF - " fmt
@@ -892,4 +892,10 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
 	return 0;
 }
 
-DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_PERF, perf)
+static struct scmi_protocol scmi_perf = {
+	.id = SCMI_PROTOCOL_PERF,
+	.init = &scmi_perf_protocol_init,
+	.ops = &perf_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(perf, scmi_perf)
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 1f37258e9bee..42c9c88da07c 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) Power Protocol
  *
- * Copyright (C) 2018 ARM Ltd.
+ * Copyright (C) 2018-2020 ARM Ltd.
  */
 
 #define pr_fmt(fmt) "SCMI Notifications POWER - " fmt
@@ -301,4 +301,10 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
 	return 0;
 }
 
-DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_POWER, power)
+static struct scmi_protocol scmi_power = {
+	.id = SCMI_PROTOCOL_POWER,
+	.init = &scmi_power_protocol_init,
+	.ops = &power_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(power, scmi_power)
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index a981a22cfe89..2caf0bdb6fdc 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) Reset Protocol
  *
- * Copyright (C) 2019 ARM Ltd.
+ * Copyright (C) 2019-2020 ARM Ltd.
  */
 
 #define pr_fmt(fmt) "SCMI Notifications RESET - " fmt
@@ -311,4 +311,10 @@ static int scmi_reset_protocol_init(struct scmi_handle *handle)
 	return 0;
 }
 
-DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_RESET, reset)
+static struct scmi_protocol scmi_reset = {
+	.id = SCMI_PROTOCOL_RESET,
+	.init = &scmi_reset_protocol_init,
+	.ops = &reset_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(reset, scmi_reset)
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index b4232d611033..dfe3076d2093 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) Sensor Protocol
  *
- * Copyright (C) 2018 ARM Ltd.
+ * Copyright (C) 2018-2020 ARM Ltd.
  */
 
 #define pr_fmt(fmt) "SCMI Notifications SENSOR - " fmt
@@ -367,4 +367,10 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 	return 0;
 }
 
-DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_SENSOR, sensors)
+static struct scmi_protocol scmi_sensors = {
+	.id = SCMI_PROTOCOL_SENSOR,
+	.init = &scmi_sensors_protocol_init,
+	.ops = &sensor_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(sensors, scmi_sensors)
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index 283e12d5f24b..bcea18bf54ab 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -128,4 +128,10 @@ static int scmi_system_protocol_init(struct scmi_handle *handle)
 	return 0;
 }
 
-DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_SYSTEM, system)
+static struct scmi_protocol scmi_system = {
+	.id = SCMI_PROTOCOL_SYSTEM,
+	.init = &scmi_system_protocol_init,
+	.ops = NULL,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(system, scmi_system)
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 9cd312a1ff92..ca23d682941e 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -376,9 +376,9 @@ static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
 #define module_scmi_driver(__scmi_driver)	\
 	module_driver(__scmi_driver, scmi_register, scmi_unregister)
 
-typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
-int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn);
-void scmi_protocol_unregister(int protocol_id);
+struct scmi_protocol;
+int scmi_protocol_register(struct scmi_protocol *proto);
+void scmi_protocol_unregister(const struct scmi_protocol *proto);
 
 /* SCMI Notification API - Custom Event Reports */
 enum scmi_notification_events {
-- 
2.17.1

