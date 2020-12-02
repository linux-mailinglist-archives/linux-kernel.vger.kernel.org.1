Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA77F2CC81B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbgLBUmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:42 -0500
Received: from foss.arm.com ([217.140.110.172]:50434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgLBUmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BAAE1650;
        Wed,  2 Dec 2020 12:41:44 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07BDD3F575;
        Wed,  2 Dec 2020 12:41:41 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 37/37] firmware: arm_scmi: add dynamic scmi devices creation
Date:   Wed,  2 Dec 2020 20:40:09 +0000
Message-Id: <20201202204009.32073-38-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having added the support for SCMI protocols as modules in order to let
vendors extend the SCMI core with their own additions it seems odd to
then force SCMI drivers built on top to use a static device table to
declare their devices since this way any new SCMI drivers addition
would need the core SCMI device table to be updated too.

Remove the static core device table and let SCMI drivers to simply declare
which device/protocol pair they need at initialization time: the core will
then take care to generate such devices dynamically during platform
initialization or at module loading time, as long as the requested
underlying protocol is defined in the DT.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c    |  30 +++++
 drivers/firmware/arm_scmi/common.h |   5 +
 drivers/firmware/arm_scmi/driver.c | 208 ++++++++++++++++++++++++-----
 3 files changed, 210 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 88e5057f4e85..88149a46e6d9 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -51,6 +51,31 @@ static int scmi_dev_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
+static int scmi_match_by_id_table(struct device *dev, void *data)
+{
+	struct scmi_device *sdev = to_scmi_dev(dev);
+	struct scmi_device_id *id_table = data;
+
+	return sdev->protocol_id == id_table->protocol_id &&
+		!strcmp(sdev->name, id_table->name);
+}
+
+struct scmi_device *scmi_find_child_dev(struct device *parent,
+					int prot_id, const char *name)
+{
+	struct scmi_device_id id_table;
+	struct device *dev;
+
+	id_table.protocol_id = prot_id;
+	id_table.name = name;
+
+	dev = device_find_child(parent, &id_table, scmi_match_by_id_table);
+	if (!dev)
+		return NULL;
+
+	return to_scmi_dev(dev);
+}
+
 const struct scmi_protocol *scmi_get_protocol(int protocol_id)
 {
 	const struct scmi_protocol *proto;
@@ -114,6 +139,10 @@ int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
 {
 	int retval;
 
+	retval = scmi_request_protocol_device(driver->id_table);
+	if (retval)
+		return retval;
+
 	driver->driver.bus = &scmi_bus_type;
 	driver->driver.name = driver->name;
 	driver->driver.owner = owner;
@@ -130,6 +159,7 @@ EXPORT_SYMBOL_GPL(scmi_driver_register);
 void scmi_driver_unregister(struct scmi_driver *driver)
 {
 	driver_unregister(&driver->driver);
+	scmi_unrequest_protocol_device(driver->id_table);
 }
 EXPORT_SYMBOL_GPL(scmi_driver_unregister);
 
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 1e2046c61d43..9a0519db4865 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -307,6 +307,11 @@ struct scmi_transport_ops {
 	bool (*poll_done)(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer);
 };
 
+int scmi_request_protocol_device(const struct scmi_device_id *id_table);
+void scmi_unrequest_protocol_device(const struct scmi_device_id *id_table);
+struct scmi_device *scmi_find_child_dev(struct device *parent,
+					int prot_id, const char *name);
+
 /**
  * struct scmi_desc - Description of SoC integration
  *
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 4b68952e49db..e26a2afeee6e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -56,6 +56,14 @@ static DEFINE_MUTEX(scmi_list_mutex);
 /* Track the unique id for the transfers for debug & profiling purpose */
 static atomic_t transfer_last_id;
 
+static DEFINE_IDR(scmi_requested_devices);
+static DEFINE_MUTEX(scmi_requested_devices_mutex);
+
+struct scmi_requested_dev {
+	const struct scmi_device_id *id_table;
+	struct scmi_requested_dev *next;
+};
+
 /**
  * struct scmi_xfers_info - Structure to manage transfer information
  *
@@ -113,6 +121,8 @@ struct scmi_protocol_instance {
  * @protocols_mtx: A mutex to protect protocols instances initialization.
  * @protocols_imp: List of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
+ * @active_protocols: IDR storing device_nodes for protocols actually defined
+ *		      in the DT and confirmed as implemented by fw.
  * @notify_priv: Pointer to private data structure specific to notifications.
  * @node: List head
  * @users: Number of users of this instance
@@ -130,6 +140,7 @@ struct scmi_info {
 	/* Ensure mutual exclusive access to protocols instance array */
 	struct mutex protocols_mtx;
 	u8 *protocols_imp;
+	struct idr active_protocols;
 	void *notify_priv;
 	struct list_head node;
 	int users;
@@ -929,6 +940,13 @@ static void scmi_devm_put_protocol_ops(struct scmi_device *sdev, u8 protocol_id)
 	WARN_ON(ret);
 }
 
+static inline
+struct scmi_handle *scmi_handle_get_from_info(struct scmi_info *info)
+{
+	info->users++;
+	return &info->handle;
+}
+
 /**
  * scmi_handle_get() - Get the SCMI handle for a device
  *
@@ -950,8 +968,7 @@ struct scmi_handle *scmi_handle_get(struct device *dev)
 	list_for_each(p, &scmi_list) {
 		info = list_entry(p, struct scmi_info, node);
 		if (dev->parent == info->dev) {
-			handle = &info->handle;
-			info->users++;
+			handle = scmi_handle_get_from_info(info);
 			break;
 		}
 	}
@@ -1094,63 +1111,173 @@ scmi_txrx_setup(struct scmi_info *info, struct device *dev, int prot_id)
 	return ret;
 }
 
-static inline void
-scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
-			    int prot_id, const char *name)
+static inline struct scmi_device *
+scmi_get_protocol_device(struct device_node *np, struct scmi_info *info,
+			 int prot_id, const char *name)
 {
 	struct scmi_device *sdev;
 
+	/* Already created for this parent SCMI instance ? */
+	sdev = scmi_find_child_dev(info->dev, prot_id, name);
+	if (sdev)
+		return sdev;
+
+	pr_debug("Creating SCMI device (%s) for protocol %x\n", name, prot_id);
+
 	sdev = scmi_device_create(np, info->dev, prot_id, name);
 	if (!sdev) {
 		dev_err(info->dev, "failed to create %d protocol device\n",
 			prot_id);
-		return;
+		return NULL;
 	}
 
 	if (scmi_txrx_setup(info, &sdev->dev, prot_id)) {
 		dev_err(&sdev->dev, "failed to setup transport\n");
 		scmi_device_destroy(sdev);
-		return;
+		return NULL;
 	}
 
-	/* setup handle now as the transport is ready */
-	scmi_set_handle(sdev);
+	return sdev;
 }
 
-#define MAX_SCMI_DEV_PER_PROTOCOL	2
-struct scmi_prot_devnames {
-	int protocol_id;
-	char *names[MAX_SCMI_DEV_PER_PROTOCOL];
-};
+static void
+scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
+			    int prot_id, const char *name)
+{
+	struct scmi_device *sdev;
 
-static struct scmi_prot_devnames devnames[] = {
-	{ SCMI_PROTOCOL_POWER,  { "genpd" },},
-	{ SCMI_PROTOCOL_SYSTEM, { "syspower" },},
-	{ SCMI_PROTOCOL_PERF,   { "cpufreq" },},
-	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
-	{ SCMI_PROTOCOL_SENSOR, { "hwmon" },},
-	{ SCMI_PROTOCOL_RESET,  { "reset" },},
-	{ SCMI_PROTOCOL_VOLTAGE,  { "regulator" },},
-};
+	sdev = scmi_get_protocol_device(np, info, prot_id, name);
+	if (!sdev)
+		return;
+
+	/* setup handle now as the transport is ready */
+	scmi_set_handle(sdev);
+}
 
 static inline void
 scmi_create_protocol_devices(struct device_node *np, struct scmi_info *info,
 			     int prot_id)
 {
-	int loop, cnt;
+	struct scmi_requested_dev *rdev;
 
-	for (loop = 0; loop < ARRAY_SIZE(devnames); loop++) {
-		if (devnames[loop].protocol_id != prot_id)
-			continue;
+	rdev = idr_find(&scmi_requested_devices, prot_id);
+	if (!rdev)
+		return;
+
+	for (; rdev; rdev = rdev->next)
+		scmi_create_protocol_device(np, info, prot_id,
+					    rdev->id_table->name);
+}
 
-		for (cnt = 0; cnt < ARRAY_SIZE(devnames[loop].names); cnt++) {
-			const char *name = devnames[loop].names[cnt];
+int scmi_request_protocol_device(const struct scmi_device_id *id_table)
+{
+	int ret = 0;
+	unsigned int id = 0;
+	struct scmi_requested_dev *rdev, *prev = NULL;
+	struct scmi_info *info;
 
-			if (name)
-				scmi_create_protocol_device(np, info, prot_id,
-							    name);
+	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
+		 id_table->name, id_table->protocol_id);
+
+	mutex_lock(&scmi_requested_devices_mutex);
+	/* Search for any equaly named device ... fails if found */
+	idr_for_each_entry(&scmi_requested_devices, rdev, id) {
+		if (rdev->id_table->protocol_id == id_table->protocol_id)
+			prev = rdev;
+		for (; rdev; rdev = rdev->next) {
+			if (!strcmp(rdev->id_table->name, id_table->name)) {
+				pr_err("Ignoring duplicate request [%d] %s\n",
+				       rdev->id_table->protocol_id,
+				       rdev->id_table->name);
+				ret = -EINVAL;
+				goto out;
+			}
 		}
 	}
+
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	rdev->id_table = id_table;
+
+	/* Append the new requested device table to the proper protocol chain */
+	if (!prev) {
+		ret = idr_alloc(&scmi_requested_devices, (void *)rdev,
+				rdev->id_table->protocol_id,
+				rdev->id_table->protocol_id + 1, GFP_KERNEL);
+		if (ret != rdev->id_table->protocol_id) {
+			pr_err("Failed to save SCMI device - ret:%d\n", ret);
+			kfree(rdev);
+			ret = -EINVAL;
+			goto out;
+		}
+		ret = 0;
+	} else {
+		prev->next = rdev;
+	}
+
+	/* Create requested device for each already initialized SCMI instance */
+	mutex_lock(&scmi_list_mutex);
+	list_for_each_entry(info, &scmi_list, node) {
+		struct device_node *child;
+
+		child = idr_find(&info->active_protocols,
+				 id_table->protocol_id);
+		if (child) {
+			struct scmi_device *sdev;
+
+			sdev = scmi_get_protocol_device(child, info,
+							id_table->protocol_id,
+							id_table->name);
+			/* Set handle if not already set (device existed) */
+			if (sdev && !sdev->handle)
+				sdev->handle = scmi_handle_get_from_info(info);
+		} else {
+			dev_err(info->dev,
+				"Failed. SCMI protocol %d not active.\n",
+				id_table->protocol_id);
+		}
+	}
+	mutex_unlock(&scmi_list_mutex);
+
+out:
+	mutex_unlock(&scmi_requested_devices_mutex);
+
+	return ret;
+}
+
+void scmi_unrequest_protocol_device(const struct scmi_device_id *id_table)
+{
+	struct scmi_requested_dev *rdev, *prev, *head;
+
+	pr_debug("Unrequesting SCMI device (%s) for protocol %x\n",
+		 id_table->name, id_table->protocol_id);
+
+	rdev = idr_find(&scmi_requested_devices, id_table->protocol_id);
+	if (!rdev)
+		return;
+
+	head = rdev;
+	for (prev = rdev; rdev; prev = rdev, rdev = rdev->next)
+		if (!strcmp(rdev->id_table->name, id_table->name))
+			break;
+
+	if (rdev) {
+		if (rdev == head) {
+			head = rdev->next;
+			if (head)
+				idr_replace(&scmi_requested_devices, head,
+					    rdev->id_table->protocol_id);
+			else
+				idr_remove(&scmi_requested_devices,
+					   rdev->id_table->protocol_id);
+		} else {
+			prev->next = rdev->next;
+		}
+		kfree(rdev);
+	}
 }
 
 static int scmi_probe(struct platform_device *pdev)
@@ -1175,6 +1302,7 @@ static int scmi_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&info->node);
 	idr_init(&info->protocols);
 	mutex_init(&info->protocols_mtx);
+	idr_init(&info->active_protocols);
 
 	platform_set_drvdata(pdev, info);
 	idr_init(&info->tx_idr);
@@ -1229,6 +1357,15 @@ static int scmi_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		ret = idr_alloc(&info->active_protocols, child,
+				prot_id, prot_id + 1, GFP_KERNEL);
+		if (ret != prot_id) {
+			dev_err(dev, "SCMI protocol %d already activated. Skip\n",
+				prot_id);
+			continue;
+		}
+
+		of_node_get(child);
 		scmi_create_protocol_devices(child, info, prot_id);
 	}
 
@@ -1242,9 +1379,10 @@ void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id)
 
 static int scmi_remove(struct platform_device *pdev)
 {
-	int ret = 0;
+	int ret = 0, id;
 	struct scmi_info *info = platform_get_drvdata(pdev);
 	struct idr *idr = &info->tx_idr;
+	struct device_node *child;
 
 	scmi_notification_exit(&info->handle);
 
@@ -1262,6 +1400,10 @@ static int scmi_remove(struct platform_device *pdev)
 	idr_destroy(&info->protocols);
 	mutex_unlock(&info->protocols_mtx);
 
+	idr_for_each_entry(&info->active_protocols, child, id)
+		of_node_put(child);
+	idr_destroy(&info->active_protocols);
+
 	/* Safe to free channels since no more users */
 	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
 	idr_destroy(&info->tx_idr);
-- 
2.17.1

