Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D867F29D41C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgJ1VtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:49:18 -0400
Received: from foss.arm.com ([217.140.110.172]:38346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbgJ1VrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 303B81BB2;
        Wed, 28 Oct 2020 13:29:47 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86D163F66E;
        Wed, 28 Oct 2020 13:29:45 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v2 2/8] firmware: arm_scmi: introduce protocol handles
Date:   Wed, 28 Oct 2020 20:29:08 +0000
Message-Id: <20201028202914.43662-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028202914.43662-1-cristian.marussi@arm.com>
References: <20201028202914.43662-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic protocol handles definitions and helpers support.
All protocols initialization code and SCMI drivers probing is still
performed using the handle based interface.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h | 61 ++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/driver.c | 64 ++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index b08a8ddbc22a..f0678be02a09 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -151,6 +151,67 @@ int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
 		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
 void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
 			    struct scmi_xfer *xfer);
+
+struct scmi_xfer_ops;
+
+/**
+ * struct scmi_protocol_handle  - Reference to an initialized protocol instance
+ *
+ * @dev: A reference to the associated SCMI instance device (handle->dev).
+ * @xops: A reference to a struct holding refs to the core xfer operations that
+ *	  can be used by the protocol implementation to generate SCMI messages.
+ * @set_priv: A method to set protocol private data for this instance.
+ * @get_priv: A method to get protocol private data previously set.
+ *
+ * This structure represents a protocol initialized against specific SCMI
+ * instance and it will be used as follows:
+ * - as a parameter fed from the core to the protocol initialization code so
+ *   that it can access the core xfer operations to build and generate SCMI
+ *   messages exclusively for the specific underlying protocol instance.
+ * - as an opaque handle fed by an SCMI driver user when it tries to access
+ *   this protocol through its own protocol operations.
+ *   In this case this handle will be returned as an opaque object together
+ *   with the related protocol operations when the SCMI driver tries to access
+ *   the protocol.
+ */
+struct scmi_protocol_handle {
+	struct device *dev;
+	const struct scmi_xfer_ops *xops;
+	int (*set_priv)(const struct scmi_protocol_handle *ph, void *priv);
+	void *(*get_priv)(const struct scmi_protocol_handle *ph);
+};
+
+/**
+ * struct scmi_xfer_ops  - References to the core SCMI xfer operations.
+ * @version_get: Get this version protocol.
+ * @xfer_get_init: Initialize one struct xfer if any xfer slot is free.
+ * @reset_rx_to_maxsz: Reset rx size to max transport size.
+ * @do_xfer: Do the SCMI transfer.
+ * @do_xfer_with_response: Do the SCMI transfer waiting for a response.
+ * @xfer_put: Free the xfer slot.
+ *
+ * Note that all this operations expect a protocol handle as first parameter;
+ * they then internally use it to infer the underlying protocol number: this
+ * way is not possible for a protocol implementation to forge messages for
+ * another protocol.
+ */
+struct scmi_xfer_ops {
+	int (*version_get)(const struct scmi_protocol_handle *ph, u32 *version);
+	int (*xfer_get_init)(const struct scmi_protocol_handle *ph, u8 msg_id,
+			     size_t tx_size, size_t rx_size,
+			     struct scmi_xfer **p);
+	void (*reset_rx_to_maxsz)(const struct scmi_protocol_handle *ph,
+				  struct scmi_xfer *xfer);
+	int (*do_xfer)(const struct scmi_protocol_handle *ph,
+		       struct scmi_xfer *xfer);
+	int (*do_xfer_with_response)(const struct scmi_protocol_handle *ph,
+				     struct scmi_xfer *xfer);
+	void (*xfer_put)(const struct scmi_protocol_handle *ph,
+			 struct scmi_xfer *xfer);
+};
+
+struct scmi_revision_info *
+scmi_get_revision_area(const struct scmi_protocol_handle *ph);
 int scmi_handle_put(const struct scmi_handle *handle);
 struct scmi_handle *scmi_handle_get(struct device *dev);
 void scmi_set_handle(struct scmi_device *scmi_dev);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index beae8991422d..8ca04acb6abb 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -72,19 +72,28 @@ struct scmi_xfers_info {
 
 /**
  * struct scmi_protocol_instance  - Describe an initialized protocol instance.
+ * @handle: Reference to the SCMI handle associated to this protocol instance.
  * @proto: A reference to the protocol descriptor.
  * @gid: A reference for per-protocol devres management.
  * @users: A refcount to track effective users of this protocol.
+ * @priv: Reference for optional protocol private data.
+ * @ph: An embedded protocol handle that will be passed down to protocol
+ *	initialization code to identify this instance.
  *
  * Each protocol is initialized independently once for each SCMI platform in
  * which is defined by DT and implemented by the SCMI server fw.
  */
 struct scmi_protocol_instance {
+	const struct scmi_handle	*handle;
 	const struct scmi_protocol	*proto;
 	void				*gid;
 	refcount_t			users;
+	void				*priv;
+	struct scmi_protocol_handle	ph;
 };
 
+#define ph_to_pi(h)	container_of(h, struct scmi_protocol_instance, ph)
+
 /**
  * struct scmi_info - Structure representing a SCMI instance
  *
@@ -543,6 +552,57 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
 	return ret;
 }
 
+/**
+ * scmi_set_protocol_priv  - Set protocol specific data at init time
+ *
+ * @ph: A reference to the protocol handle.
+ * @priv: The private data to set.
+ *
+ * Return: 0 on Success
+ */
+static int scmi_set_protocol_priv(const struct scmi_protocol_handle *ph,
+				  void *priv)
+{
+	struct scmi_protocol_instance *pi = ph_to_pi(ph);
+
+	pi->priv = priv;
+
+	return 0;
+}
+
+/**
+ * scmi_get_protocol_priv  - Set protocol specific data at init time
+ *
+ * @ph: A reference to the protocol handle.
+ *
+ * Return: Protocol private data if any was set.
+ */
+static void *scmi_get_protocol_priv(const struct scmi_protocol_handle *ph)
+{
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+
+	return pi->priv;
+}
+
+/**
+ * scmi_get_revision_area  - Retrieve version memory area.
+ *
+ * @ph: A reference to the protocol handle.
+ *
+ * A helper to grab the version memory area reference during SCMI Base protocol
+ * initialization.
+ *
+ * Return: A reference to the version memory area associated to the SCMI
+ *	   instance underlying this protocol handle.
+ */
+struct scmi_revision_info *
+scmi_get_revision_area(const struct scmi_protocol_handle *ph)
+{
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+
+	return pi->handle->version;
+}
+
 /**
  * scmi_get_protocol_instance  - Protocol initialization helper.
  * @handle: A reference to the SCMI platform instance.
@@ -588,6 +648,10 @@ scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
 
 		pi->gid = gid;
 		pi->proto = proto;
+		pi->handle = handle;
+		pi->ph.dev = handle->dev;
+		pi->ph.set_priv = scmi_set_protocol_priv;
+		pi->ph.get_priv = scmi_get_protocol_priv;
 		refcount_set(&pi->users, 1);
 		/* proto->init is assured NON NULL by scmi_protocol_register */
 		ret = pi->proto->init(handle);
-- 
2.17.1

