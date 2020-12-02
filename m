Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1472CC807
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbgLBUl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:41:56 -0500
Received: from foss.arm.com ([217.140.110.172]:50420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgLBUlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:41:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45D46142F;
        Wed,  2 Dec 2020 12:40:36 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B3633F85F;
        Wed,  2 Dec 2020 12:40:34 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 06/37] firmware: arm_scmi: introduce new devres notification ops
Date:   Wed,  2 Dec 2020 20:39:38 +0000
Message-Id: <20201202204009.32073-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose to the SCMI drivers a new alternative devres managed notifications
API based on protocol handles.

All drivers still keep using the old API, no functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/notify.c | 123 +++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h      |  15 +++-
 2 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index cdaf0f962d84..70e8eb4e33c6 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1408,6 +1408,127 @@ static int scmi_unregister_notifier(const struct scmi_handle *handle,
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
@@ -1465,6 +1586,8 @@ static void scmi_protocols_late_init(struct work_struct *work)
  * directly from an scmi_driver to register its own notifiers.
  */
 static const struct scmi_notify_ops notify_ops = {
+	.devm_register_event_notifier = scmi_devm_register_notifier,
+	.devm_unregister_event_notifier = scmi_devm_unregister_notifier,
 	.register_event_notifier = scmi_register_notifier,
 	.unregister_event_notifier = scmi_unregister_notifier,
 };
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 6a25054c3e7d..c29f159c8b42 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -543,6 +543,10 @@ struct scmi_voltage_ops {
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
@@ -552,7 +556,9 @@ struct scmi_voltage_ops {
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
@@ -575,6 +581,13 @@ struct scmi_voltage_ops {
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
-- 
2.17.1

