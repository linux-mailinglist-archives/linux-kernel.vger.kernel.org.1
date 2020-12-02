Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B62CC823
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389071AbgLBUnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:43:01 -0500
Received: from foss.arm.com ([217.140.110.172]:50656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388543AbgLBUmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E78A15AB;
        Wed,  2 Dec 2020 12:41:31 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 495A83F575;
        Wed,  2 Dec 2020 12:41:29 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 31/37] firmware: arm_scmi: make references to handle const
Date:   Wed,  2 Dec 2020 20:40:03 +0000
Message-Id: <20201202204009.32073-32-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the protocol private variable data have been moved out of
struct scmi_handle, mark all of its references as const.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  4 ++--
 drivers/firmware/arm_scmi/driver.c | 12 ++++++------
 include/linux/scmi_protocol.h      |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index c7b48f1e5fe0..45387a32d79e 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -274,8 +274,8 @@ void __exit scmi_##name##_unregister(void) \
 
 const struct scmi_protocol *scmi_get_protocol(int protocol_id);
 
-int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id);
-void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id);
+int scmi_acquire_protocol(const struct scmi_handle *handle, u8 protocol_id);
+void scmi_release_protocol(const struct scmi_handle *handle, u8 protocol_id);
 
 /* SCMI Transport */
 /**
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b76c06b8bbc3..68a40d83325c 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -729,7 +729,7 @@ scmi_get_revision_area(const struct scmi_protocol_handle *ph)
  * Return: A reference to an initialized protocol instance or error on failure.
  */
 static struct scmi_protocol_instance * __must_check
-scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
+scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 {
 	int ret = -ENOMEM;
 	void *gid;
@@ -808,7 +808,7 @@ scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
  *
  * Return: 0 if protocol was acquired successfully.
  */
-int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id)
+int scmi_acquire_protocol(const struct scmi_handle *handle, u8 protocol_id)
 {
 	return PTR_ERR_OR_ZERO(scmi_get_protocol_instance(handle, protocol_id));
 }
@@ -821,7 +821,7 @@ int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id)
  * Remove one user for the specified protocol and triggers de-initialization
  * and resources de-allocation once the last user has gone.
  */
-void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
+void scmi_release_protocol(const struct scmi_handle *handle, u8 protocol_id)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 	struct scmi_protocol_instance *pi;
@@ -866,7 +866,7 @@ void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
  *	   Must be checked for errors by caller.
  */
 static const void __must_check *
-scmi_get_protocol_operations(struct scmi_handle *handle, u8 protocol_id,
+scmi_get_protocol_operations(const struct scmi_handle *handle, u8 protocol_id,
 			     struct scmi_protocol_handle **ph)
 {
 	struct scmi_protocol_instance *pi;
@@ -908,7 +908,7 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
 }
 
 struct scmi_protocol_devres {
-	struct scmi_handle *handle;
+	const struct scmi_handle *handle;
 	u8 protocol_id;
 };
 
@@ -943,7 +943,7 @@ scmi_devm_get_protocol_ops(struct scmi_device *sdev, u8 protocol_id,
 {
 	struct scmi_protocol_instance *pi;
 	struct scmi_protocol_devres *dres;
-	struct scmi_handle *handle = sdev->handle;
+	const struct scmi_handle *handle = sdev->handle;
 
 	if (!ph)
 		return ERR_PTR(-EINVAL);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 2687778a8a1f..397af71bb07d 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -621,9 +621,9 @@ struct scmi_handle {
 	void (*devm_put_ops)(struct scmi_device *sdev, u8 proto);
 
 	const void __must_check *
-		(*get_ops)(struct scmi_handle *handle, u8 proto,
+		(*get_ops)(const struct scmi_handle *handle, u8 proto,
 			   struct scmi_protocol_handle **ph);
-	void (*put_ops)(struct scmi_handle *handle, u8 proto);
+	void (*put_ops)(const struct scmi_handle *handle, u8 proto);
 
 	const struct scmi_notify_ops *notify_ops;
 	void *notify_priv;
-- 
2.17.1

