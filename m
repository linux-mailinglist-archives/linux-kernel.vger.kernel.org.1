Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3392CC7F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgLBUlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:41:12 -0500
Received: from foss.arm.com ([217.140.110.172]:50168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgLBUlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:41:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7837F11FB;
        Wed,  2 Dec 2020 12:40:25 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A726A3F575;
        Wed,  2 Dec 2020 12:40:23 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 01/37] firmware: arm_scmi: review protocol registration interface
Date:   Wed,  2 Dec 2020 20:39:33 +0000
Message-Id: <20201202204009.32073-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend common protocol registration routines and provide some new generic
protocols get/put helpers that can track protocols usage and automatically
perform the proper initialization and de-initialization on demand when
required.

Convert all standard protocols to use this new registration scheme while
keeping them all still using the usual initialization logic bound to SCMI
devices probing.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
- removed new Base protocol initialization, it will be re-introduced
  later with all other protocols
---
 drivers/firmware/arm_scmi/base.c    |   8 ++
 drivers/firmware/arm_scmi/bus.c     |  61 ++++++++---
 drivers/firmware/arm_scmi/clock.c   |  10 +-
 drivers/firmware/arm_scmi/common.h  |  30 +++++-
 drivers/firmware/arm_scmi/driver.c  | 159 +++++++++++++++++++++++++++-
 drivers/firmware/arm_scmi/perf.c    |  10 +-
 drivers/firmware/arm_scmi/power.c   |  10 +-
 drivers/firmware/arm_scmi/reset.c   |  10 +-
 drivers/firmware/arm_scmi/sensors.c |   8 +-
 drivers/firmware/arm_scmi/system.c  |   8 +-
 drivers/firmware/arm_scmi/voltage.c |   8 +-
 include/linux/scmi_protocol.h       |   6 +-
 12 files changed, 296 insertions(+), 32 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 017e5d8bd869..1469bad34bc1 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -365,3 +365,11 @@ int scmi_base_protocol_init(struct scmi_handle *h)
 
 	return 0;
 }
+
+static const struct scmi_protocol scmi_base = {
+	.id = SCMI_PROTOCOL_BASE,
+	.init = &scmi_base_protocol_init,
+	.ops = NULL,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(base, scmi_base)
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 1377ec76a45d..044aa9e3ebb0 100644
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
+	proto = scmi_get_protocol(protocol_id);
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
+int scmi_protocol_register(const struct scmi_protocol *proto)
 {
 	int ret;
 
+	if (!proto) {
+		pr_err("invalid protocol\n");
+		return -EINVAL;
+	}
+
+	if (!proto->init && !proto->init_instance) {
+		pr_err("missing .init() for protocol 0x%x\n", proto->id);
+		return -EINVAL;
+	}
+
 	spin_lock(&protocol_lock);
-	ret = idr_alloc(&scmi_protocols, fn, protocol_id, protocol_id + 1,
-			GFP_ATOMIC);
+	ret = idr_alloc(&scmi_available_protocols, (void *)proto,
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
index 4645677d86f1..e8c84cff9922 100644
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
+static const struct scmi_protocol scmi_clock = {
+	.id = SCMI_PROTOCOL_CLOCK,
+	.init = &scmi_clock_protocol_init,
+	.ops = &clk_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(clock, scmi_clock)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index c0fb45e7c3e8..e052507dc918 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -157,6 +157,24 @@ void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
 				     u8 *prot_imp);
 
 int scmi_base_protocol_init(struct scmi_handle *h);
+typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
+
+/**
+ * struct scmi_protocol  - Protocol descriptor
+ * @id: Protocol ID.
+ * @init: Mandatory protocol initialization function.
+ * @init_instance: Optional protocol instance initialization function.
+ * @deinit_instance: Optional protocol de-initialization function.
+ * @ops: Optional reference to the operations provided by the protocol and
+ *	 exposed in scmi_protocol.h.
+ */
+struct scmi_protocol {
+	const u8				id;
+	const scmi_prot_init_fn_t		init;
+	const scmi_prot_init_fn_t		init_instance;
+	const scmi_prot_init_fn_t		deinit_instance;
+	const void				*ops;
+};
 
 int __init scmi_bus_init(void);
 void __exit scmi_bus_exit(void);
@@ -164,6 +182,7 @@ void __exit scmi_bus_exit(void);
 #define DECLARE_SCMI_REGISTER_UNREGISTER(func)		\
 	int __init scmi_##func##_register(void);	\
 	void __exit scmi_##func##_unregister(void)
+DECLARE_SCMI_REGISTER_UNREGISTER(base);
 DECLARE_SCMI_REGISTER_UNREGISTER(clock);
 DECLARE_SCMI_REGISTER_UNREGISTER(perf);
 DECLARE_SCMI_REGISTER_UNREGISTER(power);
@@ -172,17 +191,22 @@ DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
 DECLARE_SCMI_REGISTER_UNREGISTER(voltage);
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
index 5392e1fc6b4e..48059a4406df 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -11,11 +11,12 @@
  * various power domain DVFS including the core/cluster, certain system
  * clocks configuration, thermal sensors and many others.
  *
- * Copyright (C) 2018 ARM Ltd.
+ * Copyright (C) 2018-2020 ARM Ltd.
  */
 
 #include <linux/bitmap.h>
 #include <linux/export.h>
+#include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
@@ -23,6 +24,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/processor.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 
 #include "common.h"
@@ -68,6 +70,21 @@ struct scmi_xfers_info {
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
@@ -80,6 +97,10 @@ struct scmi_xfers_info {
  * @rx_minfo: Universal Receive Message management info
  * @tx_idr: IDR object to map protocol id to Tx channel info pointer
  * @rx_idr: IDR object to map protocol id to Rx channel info pointer
+ * @protocols: IDR for protocols' instance descriptors initialized for
+ *	       this SCMI instance: populated on protocol's first attempted
+ *	       usage.
+ * @protocols_mtx: A mutex to protect protocols instances initialization.
  * @protocols_imp: List of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
  * @node: List head
@@ -94,6 +115,9 @@ struct scmi_info {
 	struct scmi_xfers_info rx_minfo;
 	struct idr tx_idr;
 	struct idr rx_idr;
+	struct idr protocols;
+	/* Ensure mutual exclusive access to protocols instance array */
+	struct mutex protocols_mtx;
 	u8 *protocols_imp;
 	struct list_head node;
 	int users;
@@ -519,6 +543,127 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
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
+	pi = idr_find(&info->protocols, protocol_id);
+
+	if (pi) {
+		refcount_inc(&pi->users);
+	} else {
+		const struct scmi_protocol *proto;
+
+		/* Fail if protocol not registered on bus */
+		proto = scmi_get_protocol(protocol_id);
+		if (!proto) {
+			ret = -ENODEV;
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
+		ret = pi->proto->init_instance(handle);
+		if (ret)
+			goto clean;
+
+		ret = idr_alloc(&info->protocols, pi,
+				protocol_id, protocol_id + 1, GFP_KERNEL);
+		if (ret != protocol_id)
+			goto clean;
+
+		devres_close_group(handle->dev, pi->gid);
+		dev_dbg(handle->dev, "Initialized protocol: 0x%X\n",
+			protocol_id);
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
+	return PTR_ERR_OR_ZERO(scmi_get_protocol_instance(handle, protocol_id));
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
+	pi = idr_find(&info->protocols, protocol_id);
+	if (WARN_ON(!pi))
+		goto out;
+
+	if (refcount_dec_and_test(&pi->users)) {
+		void *gid = pi->gid;
+
+		if (pi->proto->deinit_instance)
+			pi->proto->deinit_instance(handle);
+
+		idr_remove(&info->protocols, protocol_id);
+
+		devres_release_group(handle->dev, gid);
+		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
+			protocol_id);
+	}
+
+out:
+	mutex_unlock(&info->protocols_mtx);
+}
+
 void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
 				     u8 *prot_imp)
 {
@@ -786,6 +931,8 @@ static int scmi_probe(struct platform_device *pdev)
 	info->dev = dev;
 	info->desc = desc;
 	INIT_LIST_HEAD(&info->node);
+	idr_init(&info->protocols);
+	mutex_init(&info->protocols_mtx);
 
 	platform_set_drvdata(pdev, info);
 	idr_init(&info->tx_idr);
@@ -860,6 +1007,10 @@ static int scmi_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	mutex_lock(&info->protocols_mtx);
+	idr_destroy(&info->protocols);
+	mutex_unlock(&info->protocols_mtx);
+
 	/* Safe to free channels since no more users */
 	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
 	idr_destroy(&info->tx_idr);
@@ -942,6 +1093,8 @@ static int __init scmi_driver_init(void)
 {
 	scmi_bus_init();
 
+	scmi_base_register();
+
 	scmi_clock_register();
 	scmi_perf_register();
 	scmi_power_register();
@@ -956,7 +1109,7 @@ subsys_initcall(scmi_driver_init);
 
 static void __exit scmi_driver_exit(void)
 {
-	scmi_bus_exit();
+	scmi_base_unregister();
 
 	scmi_clock_unregister();
 	scmi_perf_unregister();
@@ -966,6 +1119,8 @@ static void __exit scmi_driver_exit(void)
 	scmi_voltage_unregister();
 	scmi_system_unregister();
 
+	scmi_bus_exit();
+
 	platform_driver_unregister(&scmi_driver);
 }
 module_exit(scmi_driver_exit);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 82fb3babff72..bba43f1a2ede 100644
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
+static const struct scmi_protocol scmi_perf = {
+	.id = SCMI_PROTOCOL_PERF,
+	.init = &scmi_perf_protocol_init,
+	.ops = &perf_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(perf, scmi_perf)
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 1f37258e9bee..b620c5fec855 100644
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
+static const struct scmi_protocol scmi_power = {
+	.id = SCMI_PROTOCOL_POWER,
+	.init = &scmi_power_protocol_init,
+	.ops = &power_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(power, scmi_power)
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index a981a22cfe89..3283dde30641 100644
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
+static const struct scmi_protocol scmi_reset = {
+	.id = SCMI_PROTOCOL_RESET,
+	.init = &scmi_reset_protocol_init,
+	.ops = &reset_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(reset, scmi_reset)
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 4541b891b733..c80d492b068a 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -983,4 +983,10 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 	return 0;
 }
 
-DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_SENSOR, sensors)
+static const struct scmi_protocol scmi_sensors = {
+	.id = SCMI_PROTOCOL_SENSOR,
+	.init = &scmi_sensors_protocol_init,
+	.ops = &sensor_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(sensors, scmi_sensors)
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index 283e12d5f24b..94a68bfc79d6 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -128,4 +128,10 @@ static int scmi_system_protocol_init(struct scmi_handle *handle)
 	return 0;
 }
 
-DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_SYSTEM, system)
+static const struct scmi_protocol scmi_system = {
+	.id = SCMI_PROTOCOL_SYSTEM,
+	.init = &scmi_system_protocol_init,
+	.ops = NULL,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(system, scmi_system)
diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index e794e4349ae6..8145ee79bb19 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -377,4 +377,10 @@ static int scmi_voltage_protocol_init(struct scmi_handle *handle)
 	return 0;
 }
 
-DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(SCMI_PROTOCOL_VOLTAGE, voltage)
+static const struct scmi_protocol scmi_voltage = {
+	.id = SCMI_PROTOCOL_VOLTAGE,
+	.init = &scmi_voltage_protocol_init,
+	.ops = &voltage_ops,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(voltage, scmi_voltage)
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index dd9e94849fc1..48393264397f 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -711,9 +711,9 @@ static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
 #define module_scmi_driver(__scmi_driver)	\
 	module_driver(__scmi_driver, scmi_register, scmi_unregister)
 
-typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
-int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn);
-void scmi_protocol_unregister(int protocol_id);
+struct scmi_protocol;
+int scmi_protocol_register(const struct scmi_protocol *proto);
+void scmi_protocol_unregister(const struct scmi_protocol *proto);
 
 /* SCMI Notification API - Custom Event Reports */
 enum scmi_notification_events {
-- 
2.17.1

