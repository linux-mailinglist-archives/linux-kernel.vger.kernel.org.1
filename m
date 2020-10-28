Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F8129D422
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgJ1Vt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:49:29 -0400
Received: from foss.arm.com ([217.140.110.172]:38330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbgJ1VrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0911B1BC0;
        Wed, 28 Oct 2020 13:29:49 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 663C83F66E;
        Wed, 28 Oct 2020 13:29:47 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v2 3/8] firmware: arm_scmi: introduce new protocol operations support
Date:   Wed, 28 Oct 2020 20:29:09 +0000
Message-Id: <20201028202914.43662-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028202914.43662-1-cristian.marussi@arm.com>
References: <20201028202914.43662-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a new generic get/put protocols API based on protocol handles;
provide also a devres managed version also for notifications.
All SCMI drivers still keep using the old handle based interface.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 126 +++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/notify.c | 123 ++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h      |  34 +++++++-
 3 files changed, 282 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8ca04acb6abb..4d86aafbf465 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/bitmap.h>
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/idr.h>
 #include <linux/io.h>
@@ -728,6 +729,38 @@ void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
 	mutex_unlock(&info->protocols_mtx);
 }
 
+/**
+ * scmi_get_protocol_operations  - Get protocol operations
+ * @handle: A reference to the SCMI platform instance.
+ * @protocol_id: The protocol being requested.
+ * @ph: A pointer reference used to pass back the associated protocol handle.
+ *
+ * Get hold of a protocol accounting for its usage, eventually triggering its
+ * initialization, and returning the protocol specific operations and related
+ * protocol handle which will be used as first argument in most of the protocols
+ * operations methods.
+ *
+ * Return: A reference to the requested protocol operations or error.
+ *	   Must be checked for errors by caller.
+ */
+static const void __must_check *
+scmi_get_protocol_operations(struct scmi_handle *handle, u8 protocol_id,
+			     struct scmi_protocol_handle **ph)
+{
+	struct scmi_protocol_instance *pi;
+
+	if (!ph)
+		return ERR_PTR(-EINVAL);
+
+	pi = scmi_get_protocol_instance(handle, protocol_id);
+	if (IS_ERR(pi))
+		return pi;
+
+	*ph = &pi->ph;
+
+	return pi->proto->ops;
+}
+
 void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
 				     u8 *prot_imp)
 {
@@ -751,6 +784,95 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
 	return false;
 }
 
+struct scmi_protocol_devres {
+	struct scmi_handle *handle;
+	u8 protocol_id;
+};
+
+static void scmi_devm_release_protocol(struct device *dev, void *res)
+{
+	struct scmi_protocol_devres *dres = res;
+
+	scmi_release_protocol(dres->handle, dres->protocol_id);
+}
+
+/**
+ * scmi_devm_get_protocol_ops  - Devres managed get protocol operations
+ * @sdev: A reference to an scmi_device whose embedded struct device is to
+ *	  be used for devres accounting.
+ * @protocol_id: The protocol being requested.
+ * @ph: A pointer reference used to pass back the associated protocol handle.
+ *
+ * Get hold of a protocol accounting for its usage, eventually triggering its
+ * initialization, and returning the protocol specific operations and related
+ * protocol handle which will be used as first argument in most of the
+ * protocols operations methods.
+ * Being a devres based managed method, protocol hold will be automatically
+ * released, and possibly de-initialized on last user, once the SCMI driver
+ * owning the scmi_device is unbound from it.
+ *
+ * Return: A reference to the requested protocol operations or error.
+ *	   Must be checked for errors by caller.
+ */
+static const void __must_check *
+scmi_devm_get_protocol_ops(struct scmi_device *sdev, u8 protocol_id,
+			   struct scmi_protocol_handle **ph)
+{
+	struct scmi_protocol_instance *pi;
+	struct scmi_protocol_devres *dres;
+	struct scmi_handle *handle = sdev->handle;
+
+	if (!ph)
+		return ERR_PTR(-EINVAL);
+
+	dres = devres_alloc(scmi_devm_release_protocol,
+			    sizeof(*dres), GFP_KERNEL);
+	if (!dres)
+		return ERR_PTR(-ENOMEM);
+
+	pi = scmi_get_protocol_instance(handle, protocol_id);
+	if (IS_ERR(pi)) {
+		devres_free(dres);
+		return pi;
+	}
+
+	dres->handle = handle;
+	dres->protocol_id = protocol_id;
+	devres_add(&sdev->dev, dres);
+
+	*ph = &pi->ph;
+
+	return pi->proto->ops;
+}
+
+static int scmi_devm_protocol_match(struct device *dev, void *res, void *data)
+{
+	struct scmi_protocol_devres *dres = res;
+
+	if (WARN_ON(!dres || !data))
+		return 0;
+
+	return dres->protocol_id == *((u8 *)data);
+}
+
+/**
+ * scmi_devm_put_protocol_ops  - Devres managed put protocol operations
+ * @sdev: A reference to an scmi_device whose embedded struct device is to
+ *	  be used for devres accounting.
+ * @protocol_id: The protocol being requested.
+ *
+ * Explicitly release a protocol hold previously obtained calling the above
+ * @scmi_devm_get_protocol_ops.
+ */
+static void scmi_devm_put_protocol_ops(struct scmi_device *sdev, u8 protocol_id)
+{
+	int ret;
+
+	ret = devres_release(&sdev->dev, scmi_devm_release_protocol,
+			     scmi_devm_protocol_match, &protocol_id);
+	WARN_ON(ret);
+}
+
 /**
  * scmi_handle_get() - Get the SCMI handle for a device
  *
@@ -1004,6 +1126,10 @@ static int scmi_probe(struct platform_device *pdev)
 	handle = &info->handle;
 	handle->dev = info->dev;
 	handle->version = &info->version;
+	handle->devm_get_ops = scmi_devm_get_protocol_ops;
+	handle->devm_put_ops = scmi_devm_put_protocol_ops;
+	handle->get_ops = scmi_get_protocol_operations;
+	handle->put_ops = scmi_release_protocol;
 
 	ret = scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
 	if (ret)
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index eae58b2a92cc..64d43e425644 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1370,6 +1370,127 @@ static int scmi_unregister_notifier(const struct scmi_handle *handle,
 	return 0;
 }
 
+struct scmi_notifier_devres {
+	const struct scmi_handle *handle;
+	u8 proto_id;
+	u8 evt_id;
+	u32 __src_id;
+	u32 *src_id;
+	struct notifier_block *nb;
+};
+
+static void scmi_devm_release_notifier(struct device *dev, void *res)
+{
+	struct scmi_notifier_devres *dres = res;
+
+	scmi_unregister_notifier(dres->handle, dres->proto_id, dres->evt_id,
+				 dres->src_id, dres->nb);
+}
+
+/**
+ * scmi_devm_register_notifier()  - Managed registration of a notifier_block
+ * for an event
+ * @sdev: A reference to an scmi_device whose embedded struct device is to
+ *	  be used for devres accounting.
+ * @proto_id: Protocol ID
+ * @evt_id: Event ID
+ * @src_id: Source ID, when NULL register for events coming form ALL possible
+ *	    sources
+ * @nb: A standard notifier block to register for the specified event
+ *
+ * Generic devres managed helper to register a notifier_block against a
+ * protocol event.
+ */
+static int scmi_devm_register_notifier(struct scmi_device *sdev,
+				       u8 proto_id, u8 evt_id, u32 *src_id,
+				       struct notifier_block *nb)
+{
+	int ret;
+	struct scmi_notifier_devres *dres;
+
+	dres = devres_alloc(scmi_devm_release_notifier,
+			    sizeof(*dres), GFP_KERNEL);
+	if (!dres)
+		return -ENOMEM;
+
+	ret = scmi_register_notifier(sdev->handle, proto_id,
+				     evt_id, src_id, nb);
+	if (ret) {
+		devres_free(dres);
+		return ret;
+	}
+
+	dres->handle = sdev->handle;
+	dres->proto_id = proto_id;
+	dres->evt_id = evt_id;
+	dres->nb = nb;
+	if (src_id) {
+		dres->__src_id = *src_id;
+		dres->src_id = &dres->__src_id;
+	} else {
+		dres->src_id = NULL;
+	}
+	devres_add(&sdev->dev, dres);
+
+	return ret;
+}
+
+static int scmi_devm_notifier_match(struct device *dev, void *res, void *data)
+{
+	struct scmi_notifier_devres *dres = res;
+	struct scmi_notifier_devres *xres = data;
+
+	if (WARN_ON(!dres || !xres))
+		return 0;
+
+	return dres->proto_id == xres->proto_id &&
+		dres->evt_id == xres->evt_id &&
+		dres->nb == xres->nb &&
+		((!dres->src_id && !xres->src_id) ||
+		  (dres->src_id && xres->src_id &&
+		   dres->__src_id == xres->__src_id));
+}
+
+/**
+ * scmi_devm_unregister_notifier()  - Managed un-registration of a
+ * notifier_block for an event
+ * @sdev: A reference to an scmi_device whose embedded struct device is to
+ *	  be used for devres accounting.
+ * @proto_id: Protocol ID
+ * @evt_id: Event ID
+ * @src_id: Source ID, when NULL register for events coming form ALL possible
+ *	    sources
+ * @nb: A standard notifier block to register for the specified event
+ *
+ * Generic devres managed helper to explicitly un-register a notifier_block
+ * against a protocol event, which was previously registered using the above
+ * @scmi_devm_register_notifier.
+ */
+static int scmi_devm_unregister_notifier(struct scmi_device *sdev,
+					 u8 proto_id, u8 evt_id, u32 *src_id,
+					 struct notifier_block *nb)
+{
+	int ret;
+	struct scmi_notifier_devres dres;
+
+	dres.handle = sdev->handle;
+	dres.proto_id = proto_id;
+	dres.evt_id = evt_id;
+	if (src_id) {
+		dres.__src_id = *src_id;
+		dres.src_id = &dres.__src_id;
+	} else {
+		dres.src_id = NULL;
+	}
+
+	ret = devres_release(&sdev->dev, scmi_devm_release_notifier,
+			     scmi_devm_notifier_match, &dres);
+
+	WARN_ON(ret);
+
+	return ret;
+}
+
 /**
  * scmi_protocols_late_init()  - Worker for late initialization
  * @work: The work item to use associated to the proper SCMI instance
@@ -1427,6 +1548,8 @@ static void scmi_protocols_late_init(struct work_struct *work)
  * directly from an scmi_driver to register its own notifiers.
  */
 static const struct scmi_notify_ops notify_ops = {
+	.devm_register_event_notifier = scmi_devm_register_notifier,
+	.devm_unregister_event_notifier = scmi_devm_unregister_notifier,
 	.register_event_notifier = scmi_register_notifier,
 	.unregister_event_notifier = scmi_unregister_notifier,
 };
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index d726ddc3dcc0..d95e43c3ea08 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -56,6 +56,8 @@ struct scmi_clock_info {
 };
 
 struct scmi_handle;
+struct scmi_device;
+struct scmi_protocol_handle;
 
 /**
  * struct scmi_clk_ops - represents the various operations provided
@@ -212,6 +214,10 @@ struct scmi_reset_ops {
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided by
  * SCMI core
+ * @devm_register_event_notifier: Managed registration of a notifier_block for
+ *				  the requested event
+ * @devm_unregister_event_notifier: Managed unregistration of a notifier_block
+ *				    for the requested event
  * @register_event_notifier: Register a notifier_block for the requested event
  * @unregister_event_notifier: Unregister a notifier_block for the requested
  *			       event
@@ -221,7 +227,9 @@ struct scmi_reset_ops {
  * tuple: (proto_id, evt_id, src_id) using the provided register/unregister
  * interface where:
  *
- * @handle: The handle identifying the platform instance to use
+ * @sdev: The scmi_device to use when calling the devres managed ops devm_
+ * @handle: The handle identifying the platform instance to use, when not
+ *	    calling the managed ops devm_
  * @proto_id: The protocol ID as in SCMI Specification
  * @evt_id: The message ID of the desired event as in SCMI Specification
  * @src_id: A pointer to the desired source ID if different sources are
@@ -244,6 +252,13 @@ struct scmi_reset_ops {
  * @report: A custom struct describing the specific event delivered
  */
 struct scmi_notify_ops {
+	int (*devm_register_event_notifier)(struct scmi_device *sdev,
+					    u8 proto_id, u8 evt_id, u32 *src_id,
+					    struct notifier_block *nb);
+	int (*devm_unregister_event_notifier)(struct scmi_device *sdev,
+					      u8 proto_id, u8 evt_id,
+					      u32 *src_id,
+					      struct notifier_block *nb);
 	int (*register_event_notifier)(const struct scmi_handle *handle,
 				       u8 proto_id, u8 evt_id, u32 *src_id,
 				       struct notifier_block *nb);
@@ -262,6 +277,12 @@ struct scmi_notify_ops {
  * @clk_ops: pointer to set of clock protocol operations
  * @sensor_ops: pointer to set of sensor protocol operations
  * @reset_ops: pointer to set of reset protocol operations
+ * @devm_get_ops: devres managed method to acquire a protocol and get specific
+ *		  operations and a dedicated protocol handler
+ * @devm_put_ops: devres managed method to release a protocol
+ * @get_ops: method to acquire a protocol and get specific operations and a
+ *	     dedicated protocol handler
+ * @put_ops: method to release a protocol
  * @notify_ops: pointer to set of notifications related operations
  * @perf_priv: pointer to private data structure specific to performance
  *	protocol(for internal use only)
@@ -284,6 +305,17 @@ struct scmi_handle {
 	const struct scmi_power_ops *power_ops;
 	const struct scmi_sensor_ops *sensor_ops;
 	const struct scmi_reset_ops *reset_ops;
+
+	const void __must_check *
+		(*devm_get_ops)(struct scmi_device *sdev, u8 proto,
+				struct scmi_protocol_handle **ph);
+	void (*devm_put_ops)(struct scmi_device *sdev, u8 proto);
+
+	const void __must_check *
+		(*get_ops)(struct scmi_handle *handle, u8 proto,
+			   struct scmi_protocol_handle **ph);
+	void (*put_ops)(struct scmi_handle *handle, u8 proto);
+
 	const struct scmi_notify_ops *notify_ops;
 	/* for protocol internal use */
 	void *perf_priv;
-- 
2.17.1

