Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EB92CC810
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbgLBUmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:17 -0500
Received: from foss.arm.com ([217.140.110.172]:50468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgLBUmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF3381478;
        Wed,  2 Dec 2020 12:40:42 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D29A53F575;
        Wed,  2 Dec 2020 12:40:40 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 09/37] firmware: arm_scmi: add new protocol handle core xfer ops
Date:   Wed,  2 Dec 2020 20:39:41 +0000
Message-Id: <20201202204009.32073-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new core SCMI xfer operations based on protocol handles to enable
protocols to builds and send their own protocol specific messages.

Keep old original scmi_xfer_ operations interface as wrappers around the
new interface in order to let coexist old and new interfaces to ease
protocol by protocol migration.

In order to support such migration the above wrappers and some additional
transient code is also introduced in this commit: it will be later removed
as a whole once the full migration of protocols and SCMI drivers will have
been completed.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
An exmaple of transient code:

scmi_map_protocol_handle() / scmi_map_scmi_handle()

and their usage will removed later on together with all the scmi_xfer
wrappers.
---
 drivers/firmware/arm_scmi/common.h |  12 +-
 drivers/firmware/arm_scmi/driver.c | 182 +++++++++++++++++++++++------
 2 files changed, 158 insertions(+), 36 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 218a389f87b5..10ac5a6daf10 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -19,6 +19,8 @@
 
 #include <asm/unaligned.h>
 
+#include "notify.h"
+
 #define PROTOCOL_REV_MINOR_MASK	GENMASK(15, 0)
 #define PROTOCOL_REV_MAJOR_MASK	GENMASK(31, 16)
 #define PROTOCOL_REV_MAJOR(x)	(u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x)))
@@ -179,6 +181,11 @@ struct scmi_protocol_handle {
 	void *(*get_priv)(const struct scmi_protocol_handle *ph);
 };
 
+const struct scmi_protocol_handle *
+scmi_map_protocol_handle(const struct scmi_handle *handle, u8 prot_id);
+
+struct scmi_handle *scmi_map_scmi_handle(const struct scmi_protocol_handle *ph);
+
 /**
  * struct scmi_xfer_ops  - References to the core SCMI xfer operations.
  * @version_get: Get this version protocol.
@@ -217,6 +224,7 @@ void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
 
 int scmi_base_protocol_init(struct scmi_handle *h);
 typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
+typedef int (*scmi_prot_init_ph_fn_t)(const struct scmi_protocol_handle *);
 
 /**
  * struct scmi_protocol  - Protocol descriptor
@@ -231,8 +239,8 @@ typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
 struct scmi_protocol {
 	const u8				id;
 	const scmi_prot_init_fn_t		init;
-	const scmi_prot_init_fn_t		init_instance;
-	const scmi_prot_init_fn_t		deinit_instance;
+	const scmi_prot_init_ph_fn_t		init_instance;
+	const scmi_prot_init_ph_fn_t		deinit_instance;
 	const void				*ops;
 	const struct scmi_protocol_events	*events;
 };
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index da0620318cab..d1357640bf07 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -349,19 +349,54 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	}
 }
 
+/* Transient code wrapper to ease API migration */
+const struct scmi_protocol_handle *
+scmi_map_protocol_handle(const struct scmi_handle *handle, u8 prot_id)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol_instance *pi;
+
+	mutex_lock(&info->protocols_mtx);
+	pi = idr_find(&info->protocols, prot_id);
+	mutex_unlock(&info->protocols_mtx);
+
+	return pi ? &pi->ph : NULL;
+}
+
+/* Transient code wrapper to ease API migration */
+struct scmi_handle *scmi_map_scmi_handle(const struct scmi_protocol_handle *ph)
+{
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+
+	return (struct scmi_handle *)pi->handle;
+}
+
 /**
- * scmi_xfer_put() - Release a transmit message
+ * xfer_put() - Release a transmit message
  *
- * @handle: Pointer to SCMI entity handle
+ * @ph: Pointer to SCMI protocol handle
  * @xfer: message that was reserved by scmi_xfer_get
  */
-void scmi_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
+static void xfer_put(const struct scmi_protocol_handle *ph,
+		     struct scmi_xfer *xfer)
 {
-	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 
 	__scmi_xfer_put(&info->tx_minfo, xfer);
 }
 
+void scmi_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer)
+{
+	const struct scmi_protocol_handle *ph;
+
+	ph = scmi_map_protocol_handle(h, xfer->hdr.protocol_id);
+	if (!ph)
+		return;
+
+	return xfer_put(ph, xfer);
+}
+
 #define SCMI_MAX_POLL_TO_NS	(100 * NSEC_PER_USEC)
 
 static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
@@ -374,23 +409,32 @@ static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
 }
 
 /**
- * scmi_do_xfer() - Do one transfer
+ * do_xfer() - Do one transfer
  *
- * @handle: Pointer to SCMI entity handle
+ * @ph: Pointer to SCMI protocol handle
  * @xfer: Transfer to initiate and wait for response
  *
  * Return: -ETIMEDOUT in case of no response, if transmit error,
  *	return corresponding error, else if all goes well,
  *	return 0.
  */
-int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
+static int do_xfer(const struct scmi_protocol_handle *ph,
+		   struct scmi_xfer *xfer)
 {
 	int ret;
 	int timeout;
-	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 	struct device *dev = info->dev;
 	struct scmi_chan_info *cinfo;
 
+	/*
+	 * Re-instate protocol id here from protocol handle so that cannot be
+	 * overridden by mistake (or malice) by the protocol code mangling with
+	 * the scmi_xfer structure.
+	 */
+	xfer->hdr.protocol_id = pi->proto->id;
+
 	cinfo = idr_find(&info->tx_idr, xfer->hdr.protocol_id);
 	if (unlikely(!cinfo))
 		return -EINVAL;
@@ -436,35 +480,62 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	return ret;
 }
 
+int scmi_do_xfer(const struct scmi_handle *h, struct scmi_xfer *xfer)
+{
+	const struct scmi_protocol_handle *ph;
+
+	ph = scmi_map_protocol_handle(h, xfer->hdr.protocol_id);
+	if (!ph)
+		return -EINVAL;
+
+	return do_xfer(ph, xfer);
+}
+
+static void reset_rx_to_maxsz(const struct scmi_protocol_handle *ph,
+			      struct scmi_xfer *xfer)
+{
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
+
+	xfer->rx.len = info->desc->max_msg_size;
+}
+
 void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
 			    struct scmi_xfer *xfer)
 {
-	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol_handle *ph;
 
-	xfer->rx.len = info->desc->max_msg_size;
+	ph = scmi_map_protocol_handle(handle, xfer->hdr.protocol_id);
+	if (!ph)
+		return;
+
+	return reset_rx_to_maxsz(ph, xfer);
 }
 
 #define SCMI_MAX_RESPONSE_TIMEOUT	(2 * MSEC_PER_SEC)
 
 /**
- * scmi_do_xfer_with_response() - Do one transfer and wait until the delayed
+ * do_xfer_with_response() - Do one transfer and wait until the delayed
  *	response is received
  *
- * @handle: Pointer to SCMI entity handle
+ * @ph: Pointer to SCMI protocol handle
  * @xfer: Transfer to initiate and wait for response
  *
  * Return: -ETIMEDOUT in case of no delayed response, if transmit error,
  *	return corresponding error, else if all goes well, return 0.
  */
-int scmi_do_xfer_with_response(const struct scmi_handle *handle,
-			       struct scmi_xfer *xfer)
+static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
+				 struct scmi_xfer *xfer)
 {
 	int ret, timeout = msecs_to_jiffies(SCMI_MAX_RESPONSE_TIMEOUT);
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
 	DECLARE_COMPLETION_ONSTACK(async_response);
 
+	xfer->hdr.protocol_id = pi->proto->id;
+
 	xfer->async_done = &async_response;
 
-	ret = scmi_do_xfer(handle, xfer);
+	ret = do_xfer(ph, xfer);
 	if (!ret && !wait_for_completion_timeout(xfer->async_done, timeout))
 		ret = -ETIMEDOUT;
 
@@ -472,12 +543,23 @@ int scmi_do_xfer_with_response(const struct scmi_handle *handle,
 	return ret;
 }
 
+int scmi_do_xfer_with_response(const struct scmi_handle *h,
+			       struct scmi_xfer *xfer)
+{
+	const struct scmi_protocol_handle *ph;
+
+	ph = scmi_map_protocol_handle(h, xfer->hdr.protocol_id);
+	if (!ph)
+		return -EINVAL;
+
+	return do_xfer_with_response(ph, xfer);
+}
+
 /**
- * scmi_xfer_get_init() - Allocate and initialise one message for transmit
+ * xfer_get_init() - Allocate and initialise one message for transmit
  *
- * @handle: Pointer to SCMI entity handle
+ * @ph: Pointer to SCMI protocol handle
  * @msg_id: Message identifier
- * @prot_id: Protocol identifier for the message
  * @tx_size: transmit message size
  * @rx_size: receive message size
  * @p: pointer to the allocated and initialised message
@@ -488,12 +570,14 @@ int scmi_do_xfer_with_response(const struct scmi_handle *handle,
  * Return: 0 if all went fine with @p pointing to message, else
  *	corresponding error.
  */
-int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
-		       size_t tx_size, size_t rx_size, struct scmi_xfer **p)
+static int xfer_get_init(const struct scmi_protocol_handle *ph,
+			 u8 msg_id, size_t tx_size, size_t rx_size,
+			 struct scmi_xfer **p)
 {
 	int ret;
 	struct scmi_xfer *xfer;
-	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 	struct scmi_xfers_info *minfo = &info->tx_minfo;
 	struct device *dev = info->dev;
 
@@ -502,7 +586,7 @@ int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
 	    tx_size > info->desc->max_msg_size)
 		return -ERANGE;
 
-	xfer = scmi_xfer_get(handle, minfo);
+	xfer = scmi_xfer_get(pi->handle, minfo);
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
 		dev_err(dev, "failed to get free message slot(%d)\n", ret);
@@ -512,7 +596,7 @@ int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
 	xfer->tx.len = tx_size;
 	xfer->rx.len = rx_size ? : info->desc->max_msg_size;
 	xfer->hdr.id = msg_id;
-	xfer->hdr.protocol_id = prot_id;
+	xfer->hdr.protocol_id = pi->proto->id;
 	xfer->hdr.poll_completion = false;
 
 	*p = xfer;
@@ -520,39 +604,59 @@ int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
 	return 0;
 }
 
+int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
+		       size_t tx_size, size_t rx_size, struct scmi_xfer **p)
+{
+	const struct scmi_protocol_handle *ph;
+
+	ph = scmi_map_protocol_handle(h, prot_id);
+	if (!ph)
+		return -EINVAL;
+
+	return xfer_get_init(ph, msg_id, tx_size, rx_size, p);
+}
+
 /**
- * scmi_version_get() - command to get the revision of the SCMI entity
+ * version_get() - command to get the revision of the SCMI entity
  *
- * @handle: Pointer to SCMI entity handle
- * @protocol: Protocol identifier for the message
+ * @ph: Pointer to SCMI protocol handle
  * @version: Holds returned version of protocol.
  *
  * Updates the SCMI information in the internal data structure.
  *
  * Return: 0 if all went fine, else return appropriate error.
  */
-int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
-		     u32 *version)
+static int version_get(const struct scmi_protocol_handle *ph, u32 *version)
 {
 	int ret;
 	__le32 *rev_info;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_VERSION, protocol, 0,
-				 sizeof(*version), &t);
+	ret = xfer_get_init(ph, PROTOCOL_VERSION, 0, sizeof(*version), &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = do_xfer(ph, t);
 	if (!ret) {
 		rev_info = t->rx.buf;
 		*version = le32_to_cpu(*rev_info);
 	}
 
-	scmi_xfer_put(handle, t);
+	xfer_put(ph, t);
 	return ret;
 }
 
+int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version)
+{
+	const struct scmi_protocol_handle *ph;
+
+	ph = scmi_map_protocol_handle(h, protocol);
+	if (!ph)
+		return -EINVAL;
+
+	return version_get(ph, version);
+}
+
 /**
  * scmi_set_protocol_priv  - Set protocol specific data at init time
  *
@@ -585,6 +689,15 @@ static void *scmi_get_protocol_priv(const struct scmi_protocol_handle *ph)
 	return pi->priv;
 }
 
+static const struct scmi_xfer_ops xfer_ops = {
+	.version_get = version_get,
+	.xfer_get_init = xfer_get_init,
+	.reset_rx_to_maxsz = reset_rx_to_maxsz,
+	.do_xfer = do_xfer,
+	.do_xfer_with_response = do_xfer_with_response,
+	.xfer_put = xfer_put,
+};
+
 /**
  * scmi_get_protocol_instance  - Protocol initialization helper.
  * @handle: A reference to the SCMI platform instance.
@@ -632,11 +745,12 @@ scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
 		pi->proto = proto;
 		pi->handle = handle;
 		pi->ph.dev = handle->dev;
+		pi->ph.xops = &xfer_ops;
 		pi->ph.set_priv = scmi_set_protocol_priv;
 		pi->ph.get_priv = scmi_get_protocol_priv;
 		refcount_set(&pi->users, 1);
 		/* proto->init is assured NON NULL by scmi_protocol_register */
-		ret = pi->proto->init_instance(handle);
+		ret = pi->proto->init_instance(&pi->ph);
 		if (ret)
 			goto clean;
 
@@ -705,7 +819,7 @@ void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
 			scmi_deregister_protocol_events(handle, protocol_id);
 
 		if (pi->proto->deinit_instance)
-			pi->proto->deinit_instance(handle);
+			pi->proto->deinit_instance(&pi->ph);
 
 		idr_remove(&info->protocols, protocol_id);
 
-- 
2.17.1

