Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD02F3A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436934AbhALTXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:23:47 -0500
Received: from foss.arm.com ([217.140.110.172]:52250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436824AbhALTX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:23:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C852315BE;
        Tue, 12 Jan 2021 11:22:03 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB5E13F66E;
        Tue, 12 Jan 2021 11:22:01 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v5 30/36] firmware: arm_scmi: make references to handle const
Date:   Tue, 12 Jan 2021 19:20:12 +0000
Message-Id: <20210112192018.34994-31-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112192018.34994-1-cristian.marussi@arm.com>
References: <20210112192018.34994-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the protocol private variable data have been moved out of
struct scmi_handle, mark all of its references as const.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  4 ++--
 drivers/firmware/arm_scmi/driver.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

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
index 6be7c50b0264..8389b77d867b 100644
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
@@ -876,7 +876,7 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
 }
 
 struct scmi_protocol_devres {
-	struct scmi_handle *handle;
+	const struct scmi_handle *handle;
 	u8 protocol_id;
 };
 
@@ -911,7 +911,7 @@ scmi_devm_get_protocol(struct scmi_device *sdev, u8 protocol_id,
 {
 	struct scmi_protocol_instance *pi;
 	struct scmi_protocol_devres *dres;
-	struct scmi_handle *handle = sdev->handle;
+	const struct scmi_handle *handle = sdev->handle;
 
 	if (!ph)
 		return ERR_PTR(-EINVAL);
-- 
2.17.1

