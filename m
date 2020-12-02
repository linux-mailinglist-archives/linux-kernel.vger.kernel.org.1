Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AEA2CC7F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgLBUlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:41:18 -0500
Received: from foss.arm.com ([217.140.110.172]:50202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgLBUlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:41:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 705071424;
        Wed,  2 Dec 2020 12:40:32 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDD633F575;
        Wed,  2 Dec 2020 12:40:30 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 04/37] [RFC] firmware: arm_scmi: introduce bare get/put protocols ops
Date:   Wed,  2 Dec 2020 20:39:36 +0000
Message-Id: <20201202204009.32073-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose to the SCMI drivers a non managed version of a common protocols API
based on generic get/put methods and protocol handles.

All drivers still keep using the old API, no functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
These non devres methods are probably not needed, given the devm_ ones are
already provided and any SCMI driver (user of the API) has surely available
an scmi_device reference to use in the devm_ flavour...so the RFC
---
 drivers/firmware/arm_scmi/driver.c | 34 ++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h      |  8 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index fbc3ba1b69f6..e6e760501587 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -710,6 +710,38 @@ void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
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
@@ -1078,6 +1110,8 @@ static int scmi_probe(struct platform_device *pdev)
 	handle->version = &info->version;
 	handle->devm_get_ops = scmi_devm_get_protocol_ops;
 	handle->devm_put_ops = scmi_devm_put_protocol_ops;
+	handle->get_ops = scmi_get_protocol_operations;
+	handle->put_ops = scmi_release_protocol;
 
 	ret = scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
 	if (ret)
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b9bdb3f1d562..6a25054c3e7d 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -597,6 +597,9 @@ struct scmi_notify_ops {
  * @devm_get_ops: devres managed method to acquire a protocol and get specific
  *		  operations and a dedicated protocol handler
  * @devm_put_ops: devres managed method to release a protocol
+ * @get_ops: method to acquire a protocol and get specific operations and a
+ *	     dedicated protocol handler
+ * @put_ops: method to release a protocol
  * @notify_ops: pointer to set of notifications related operations
  * @perf_priv: pointer to private data structure specific to performance
  *	protocol(for internal use only)
@@ -628,6 +631,11 @@ struct scmi_handle {
 				struct scmi_protocol_handle **ph);
 	void (*devm_put_ops)(struct scmi_device *sdev, u8 proto);
 
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

