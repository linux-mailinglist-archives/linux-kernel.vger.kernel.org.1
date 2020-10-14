Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A0B28E2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgJNPHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:07:08 -0400
Received: from foss.arm.com ([217.140.110.172]:50888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731607AbgJNPHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:07:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C81CE143D;
        Wed, 14 Oct 2020 08:07:02 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F5883F71F;
        Wed, 14 Oct 2020 08:07:01 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 05/11] firmware: arm_scmi: make notify_priv really private
Date:   Wed, 14 Oct 2020 16:05:39 +0100
Message-Id: <20201014150545.44807-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014150545.44807-1-cristian.marussi@arm.com>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notification private data is currently accessible via handle->notify_priv;
this data was indeed meant to be private to the notification core support
and not to be accessible to SCMI drivers: make it private hiding it inside
instance descriptor struct scmi_info.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  4 +++
 drivers/firmware/arm_scmi/driver.c | 21 +++++++++++++
 drivers/firmware/arm_scmi/notify.c | 49 +++++++++++-------------------
 include/linux/scmi_protocol.h      |  3 --
 4 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 66574f57e304..5a91e3324697 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -295,4 +295,8 @@ void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
 
+void scmi_set_notification_instance_data(const struct scmi_handle *handle,
+					 void *priv);
+void *scmi_get_notification_instance_data(const struct scmi_handle *handle);
+
 #endif /* _SCMI_COMMON_H */
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 378749040162..25a4152537e6 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -106,6 +106,7 @@ struct scmi_protocol_instance {
  *			    they have to sit on their own.
  * @protocols_imp: List of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
+ * @notify_priv: Pointer to private data structure specific to notifications.
  * @node: List head
  * @users: Number of users of this instance
  */
@@ -123,6 +124,7 @@ struct scmi_info {
 	struct mutex protocols_mtx;
 	void *protocols_private_data[SCMI_MAX_PROTO];
 	u8 *protocols_imp;
+	void *notify_priv;
 	struct list_head node;
 	int users;
 };
@@ -164,6 +166,25 @@ static inline void scmi_dump_header_dbg(struct device *dev,
 		hdr->id, hdr->seq, hdr->protocol_id);
 }
 
+void scmi_set_notification_instance_data(const struct scmi_handle *handle,
+					 void *priv)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	info->notify_priv = priv;
+	/* Ensure updated protocol private date are visible */
+	smp_wmb();
+}
+
+void *scmi_get_notification_instance_data(const struct scmi_handle *handle)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	/* Ensure protocols_private_data has been updated */
+	smp_rmb();
+	return info->notify_priv;
+}
+
 /**
  * scmi_xfer_get() - Allocate one message
  *
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 7ba182d4f2b4..d89d9c08e660 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -578,11 +578,9 @@ int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8 evt_id,
 	struct scmi_event_header eh;
 	struct scmi_notify_instance *ni;
 
-	/* Ensure notify_priv is updated */
-	smp_rmb();
-	if (!handle->notify_priv)
+	ni = scmi_get_notification_instance_data(handle);
+	if (!ni)
 		return 0;
-	ni = handle->notify_priv;
 
 	r_evt = SCMI_GET_REVT(ni, proto_id, evt_id);
 	if (!r_evt)
@@ -756,11 +754,9 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 	    (!ee->num_sources && !ee->ops->get_num_sources))
 		return -EINVAL;
 
-	/* Ensure notify_priv is updated */
-	smp_rmb();
-	if (!handle->notify_priv)
+	ni = scmi_get_notification_instance_data(handle);
+	if (!ni)
 		return -ENOMEM;
-	ni = handle->notify_priv;
 
 	/* num_sources cannot be <= 0 */
 	if (ee->num_sources) {
@@ -844,12 +840,10 @@ void scmi_deregister_protocol_events(const struct scmi_handle *handle,
 	struct scmi_notify_instance *ni;
 	struct scmi_registered_events_desc *pd;
 
-	/* Ensure notify_priv is updated */
-	smp_rmb();
-	if (!handle->notify_priv)
+	ni = scmi_get_notification_instance_data(handle);
+	if (!ni)
 		return;
 
-	ni = handle->notify_priv;
 	pd = ni->registered_protocols[proto_id];
 	if (!pd)
 		return;
@@ -1352,11 +1346,9 @@ static int scmi_register_notifier(const struct scmi_handle *handle,
 	struct scmi_event_handler *hndl;
 	struct scmi_notify_instance *ni;
 
-	/* Ensure notify_priv is updated */
-	smp_rmb();
-	if (!handle->notify_priv)
+	ni = scmi_get_notification_instance_data(handle);
+	if (!ni)
 		return -ENODEV;
-	ni = handle->notify_priv;
 
 	evt_key = MAKE_HASH_KEY(proto_id, evt_id,
 				src_id ? *src_id : SRC_ID_MASK);
@@ -1400,11 +1392,9 @@ static int scmi_unregister_notifier(const struct scmi_handle *handle,
 	struct scmi_event_handler *hndl;
 	struct scmi_notify_instance *ni;
 
-	/* Ensure notify_priv is updated */
-	smp_rmb();
-	if (!handle->notify_priv)
+	ni = scmi_get_notification_instance_data(handle);
+	if (!ni)
 		return -ENODEV;
-	ni = handle->notify_priv;
 
 	evt_key = MAKE_HASH_KEY(proto_id, evt_id,
 				src_id ? *src_id : SRC_ID_MASK);
@@ -1554,8 +1544,8 @@ int scmi_notification_init(struct scmi_handle *handle)
 
 	INIT_WORK(&ni->init_work, scmi_protocols_late_init);
 
+	scmi_set_notification_instance_data(handle, ni);
 	handle->notify_ops = &notify_ops;
-	handle->notify_priv = ni;
 	/* Ensure handle is up to date */
 	smp_wmb();
 
@@ -1567,7 +1557,7 @@ int scmi_notification_init(struct scmi_handle *handle)
 
 err:
 	dev_warn(handle->dev, "Initialization Failed.\n");
-	devres_release_group(handle->dev, NULL);
+	devres_release_group(handle->dev, gid);
 	return -ENOMEM;
 }
 
@@ -1578,19 +1568,16 @@ int scmi_notification_init(struct scmi_handle *handle)
 void scmi_notification_exit(struct scmi_handle *handle)
 {
 	struct scmi_notify_instance *ni;
+	void *gid;
 
-	/* Ensure notify_priv is updated */
-	smp_rmb();
-	if (!handle->notify_priv)
+	ni = scmi_get_notification_instance_data(handle);
+	if (!ni)
 		return;
-	ni = handle->notify_priv;
-
-	handle->notify_priv = NULL;
-	/* Ensure handle is up to date */
-	smp_wmb();
+	scmi_set_notification_instance_data(handle, NULL);
 
 	/* Destroy while letting pending work complete */
 	destroy_workqueue(ni->notify_wq);
 
-	devres_release_group(ni->handle->dev, ni->gid);
+	gid = ni->gid;
+	devres_release_group(ni->handle->dev, gid);
 }
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index bfe7017cff19..650d0877a5c8 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -258,8 +258,6 @@ struct scmi_notify_ops {
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
  * @notify_ops: pointer to set of notifications related operations
- * @notify_priv: pointer to private data structure specific to notifications
- *	(for internal use only)
  */
 struct scmi_handle {
 	struct device *dev;
@@ -270,7 +268,6 @@ struct scmi_handle {
 	void (*put_ops)(const struct scmi_handle *handle, u8 proto);
 
 	const struct scmi_notify_ops *notify_ops;
-	void *notify_priv;
 };
 
 enum scmi_std_protocol {
-- 
2.17.1

