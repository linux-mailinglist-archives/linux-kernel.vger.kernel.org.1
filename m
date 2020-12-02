Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313CE2CC813
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbgLBUmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:22 -0500
Received: from foss.arm.com ([217.140.110.172]:50436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388069AbgLBUmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AB081570;
        Wed,  2 Dec 2020 12:41:08 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 601F63F575;
        Wed,  2 Dec 2020 12:41:06 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 21/37] firmware: arm_scmi: port Reset protocol to new protocols interface
Date:   Wed,  2 Dec 2020 20:39:53 +0000
Message-Id: <20201202204009.32073-22-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert internals of protocol implementation to use protocol handles and
expose a new protocol operations interface for SCMI driver using the new
get/put common operations, while keeping the old handle->reset_ops still
around to ease transition.

Remove handle->reset_priv now unused.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/reset.c | 172 +++++++++++++++++++++---------
 include/linux/scmi_protocol.h     |  14 ++-
 2 files changed, 129 insertions(+), 57 deletions(-)

diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 7047e5baecc2..9c808f5add7e 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -64,46 +64,45 @@ struct scmi_reset_info {
 	struct reset_dom_info *dom_info;
 };
 
-static int scmi_reset_attributes_get(const struct scmi_handle *handle,
+static int scmi_reset_attributes_get(const struct scmi_protocol_handle *ph,
 				     struct scmi_reset_info *pi)
 {
 	int ret;
 	struct scmi_xfer *t;
 	u32 attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
-				 SCMI_PROTOCOL_RESET, 0, sizeof(attr), &t);
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
+				      0, sizeof(attr), &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		attr = get_unaligned_le32(t->rx.buf);
 		pi->num_domains = attr & NUM_RESET_DOMAIN_MASK;
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
 static int
-scmi_reset_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
-				 struct reset_dom_info *dom_info)
+scmi_reset_domain_attributes_get(const struct scmi_protocol_handle *ph,
+				 u32 domain, struct reset_dom_info *dom_info)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_reset_domain_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, RESET_DOMAIN_ATTRIBUTES,
-				 SCMI_PROTOCOL_RESET, sizeof(domain),
-				 sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, RESET_DOMAIN_ATTRIBUTES,
+				      sizeof(domain), sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		u32 attributes = le32_to_cpu(attr->attributes);
 
@@ -115,47 +114,75 @@ scmi_reset_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_reset_num_domains_get(const struct scmi_handle *handle)
+static int scmi_reset_num_domains_get(const struct scmi_protocol_handle *ph)
 {
-	struct scmi_reset_info *pi = handle->reset_priv;
+	struct scmi_reset_info *pi = ph->get_priv(ph);
 
 	return pi->num_domains;
 }
 
-static char *scmi_reset_name_get(const struct scmi_handle *handle, u32 domain)
+static int __scmi_reset_num_domains_get(const struct scmi_handle *handle)
 {
-	struct scmi_reset_info *pi = handle->reset_priv;
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_RESET);
+
+	return scmi_reset_num_domains_get(ph);
+}
+
+static char *scmi_reset_name_get(const struct scmi_protocol_handle *ph,
+				 u32 domain)
+{
+	struct scmi_reset_info *pi = ph->get_priv(ph);
+
 	struct reset_dom_info *dom = pi->dom_info + domain;
 
 	return dom->name;
 }
 
-static int scmi_reset_latency_get(const struct scmi_handle *handle, u32 domain)
+static char *__scmi_reset_name_get(const struct scmi_handle *handle,
+				   u32 domain)
 {
-	struct scmi_reset_info *pi = handle->reset_priv;
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_RESET);
+
+	return scmi_reset_name_get(ph, domain);
+}
+
+static int scmi_reset_latency_get(const struct scmi_protocol_handle *ph,
+				  u32 domain)
+{
+	struct scmi_reset_info *pi = ph->get_priv(ph);
 	struct reset_dom_info *dom = pi->dom_info + domain;
 
 	return dom->latency_us;
 }
 
-static int scmi_domain_reset(const struct scmi_handle *handle, u32 domain,
+static int __scmi_reset_latency_get(const struct scmi_handle *handle,
+				    u32 domain)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_RESET);
+
+	return scmi_reset_latency_get(ph, domain);
+}
+
+static int scmi_domain_reset(const struct scmi_protocol_handle *ph, u32 domain,
 			     u32 flags, u32 state)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_reset_domain_reset *dom;
-	struct scmi_reset_info *pi = handle->reset_priv;
+	struct scmi_reset_info *pi = ph->get_priv(ph);
 	struct reset_dom_info *rdom = pi->dom_info + domain;
 
 	if (rdom->async_reset)
 		flags |= ASYNCHRONOUS_RESET;
 
-	ret = scmi_xfer_get_init(handle, RESET, SCMI_PROTOCOL_RESET,
-				 sizeof(*dom), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, RESET, sizeof(*dom), 0, &t);
 	if (ret)
 		return ret;
 
@@ -165,34 +192,71 @@ static int scmi_domain_reset(const struct scmi_handle *handle, u32 domain,
 	dom->reset_state = cpu_to_le32(state);
 
 	if (rdom->async_reset)
-		ret = scmi_do_xfer_with_response(handle, t);
+		ret = ph->xops->do_xfer_with_response(ph, t);
 	else
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_reset_domain_reset(const struct scmi_handle *handle, u32 domain)
+static int scmi_reset_domain_reset(const struct scmi_protocol_handle *ph,
+				   u32 domain)
 {
-	return scmi_domain_reset(handle, domain, AUTONOMOUS_RESET,
+	return scmi_domain_reset(ph, domain, AUTONOMOUS_RESET,
 				 ARCH_COLD_RESET);
 }
 
+static int __scmi_reset_domain_reset(const struct scmi_handle *handle,
+				     u32 domain)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_RESET);
+
+	return scmi_reset_domain_reset(ph, domain);
+}
+
 static int
-scmi_reset_domain_assert(const struct scmi_handle *handle, u32 domain)
+scmi_reset_domain_assert(const struct scmi_protocol_handle *ph, u32 domain)
 {
-	return scmi_domain_reset(handle, domain, EXPLICIT_RESET_ASSERT,
+	return scmi_domain_reset(ph, domain, EXPLICIT_RESET_ASSERT,
 				 ARCH_COLD_RESET);
 }
 
 static int
-scmi_reset_domain_deassert(const struct scmi_handle *handle, u32 domain)
+__scmi_reset_domain_assert(const struct scmi_handle *handle, u32 domain)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_RESET);
+
+	return scmi_reset_domain_assert(ph, domain);
+}
+
+static int
+scmi_reset_domain_deassert(const struct scmi_protocol_handle *ph, u32 domain)
 {
-	return scmi_domain_reset(handle, domain, 0, ARCH_COLD_RESET);
+	return scmi_domain_reset(ph, domain, 0, ARCH_COLD_RESET);
+}
+
+static int
+__scmi_reset_domain_deassert(const struct scmi_handle *handle, u32 domain)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_RESET);
+
+	return scmi_reset_domain_deassert(ph, domain);
 }
 
 static const struct scmi_reset_ops reset_ops = {
+	.num_domains_get = __scmi_reset_num_domains_get,
+	.name_get = __scmi_reset_name_get,
+	.latency_get = __scmi_reset_latency_get,
+	.reset = __scmi_reset_domain_reset,
+	.assert = __scmi_reset_domain_assert,
+	.deassert = __scmi_reset_domain_deassert,
+};
+
+static const struct scmi_reset_proto_ops reset_proto_ops = {
 	.num_domains_get = scmi_reset_num_domains_get,
 	.name_get = scmi_reset_name_get,
 	.latency_get = scmi_reset_latency_get,
@@ -201,16 +265,15 @@ static const struct scmi_reset_ops reset_ops = {
 	.deassert = scmi_reset_domain_deassert,
 };
 
-static int scmi_reset_notify(const struct scmi_handle *handle, u32 domain_id,
-			     bool enable)
+static int scmi_reset_notify(const struct scmi_protocol_handle *ph,
+			     u32 domain_id, bool enable)
 {
 	int ret;
 	u32 evt_cntl = enable ? RESET_TP_NOTIFY_ALL : 0;
 	struct scmi_xfer *t;
 	struct scmi_msg_reset_notify *cfg;
 
-	ret = scmi_xfer_get_init(handle, RESET_NOTIFY,
-				 SCMI_PROTOCOL_RESET, sizeof(*cfg), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, RESET_NOTIFY, sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
 
@@ -218,18 +281,18 @@ static int scmi_reset_notify(const struct scmi_handle *handle, u32 domain_id,
 	cfg->id = cpu_to_le32(domain_id);
 	cfg->event_control = cpu_to_le32(evt_cntl);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_reset_set_notify_enabled(const void *handle,
+static int scmi_reset_set_notify_enabled(const void *ph,
 					 u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
 
-	ret = scmi_reset_notify(handle, src_id, enable);
+	ret = scmi_reset_notify(ph, src_id, enable);
 	if (ret)
 		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
 			 evt_id, src_id, ret);
@@ -237,7 +300,7 @@ static int scmi_reset_set_notify_enabled(const void *handle,
 	return ret;
 }
 
-static void *scmi_reset_fill_custom_report(const void *handle,
+static void *scmi_reset_fill_custom_report(const void *ph,
 					   u8 evt_id, ktime_t timestamp,
 					   const void *payld, size_t payld_sz,
 					   void *report, u32 *src_id)
@@ -257,10 +320,10 @@ static void *scmi_reset_fill_custom_report(const void *handle,
 	return r;
 }
 
-static int scmi_reset_get_num_sources(const void *handle)
+static int scmi_reset_get_num_sources(const void *ph)
 {
 	struct scmi_reset_info *pinfo =
-		((const struct scmi_handle *)(handle))->reset_priv;
+		((const struct scmi_protocol_handle *)ph)->get_priv(ph);
 
 	if (!pinfo)
 		return -EINVAL;
@@ -289,24 +352,25 @@ static const struct scmi_protocol_events reset_protocol_events = {
 	.num_events = ARRAY_SIZE(reset_events),
 };
 
-static int scmi_reset_protocol_init(struct scmi_handle *handle)
+static int scmi_reset_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	int domain;
 	u32 version;
 	struct scmi_reset_info *pinfo;
+	struct scmi_handle *handle;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_RESET, &version);
+	ph->xops->version_get(ph, &version);
 
-	dev_dbg(handle->dev, "Reset Version %d.%d\n",
+	dev_dbg(ph->dev, "Reset Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
 
-	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
+	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
 		return -ENOMEM;
 
-	scmi_reset_attributes_get(handle, pinfo);
+	scmi_reset_attributes_get(ph, pinfo);
 
-	pinfo->dom_info = devm_kcalloc(handle->dev, pinfo->num_domains,
+	pinfo->dom_info = devm_kcalloc(ph->dev, pinfo->num_domains,
 				       sizeof(*pinfo->dom_info), GFP_KERNEL);
 	if (!pinfo->dom_info)
 		return -ENOMEM;
@@ -314,20 +378,22 @@ static int scmi_reset_protocol_init(struct scmi_handle *handle)
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
 		struct reset_dom_info *dom = pinfo->dom_info + domain;
 
-		scmi_reset_domain_attributes_get(handle, domain, dom);
+		scmi_reset_domain_attributes_get(ph, domain, dom);
 	}
 
 	pinfo->version = version;
+
+	/* Transient code for legacy ops interface */
+	handle = scmi_map_scmi_handle(ph);
 	handle->reset_ops = &reset_ops;
-	handle->reset_priv = pinfo;
 
-	return 0;
+	return ph->set_priv(ph, pinfo);
 }
 
 static const struct scmi_protocol scmi_reset = {
 	.id = SCMI_PROTOCOL_RESET,
-	.init = &scmi_reset_protocol_init,
-	.ops = &reset_ops,
+	.init_instance = &scmi_reset_protocol_init,
+	.ops = &reset_proto_ops,
 	.events = &reset_protocol_events,
 };
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index d562a0df3462..bef5a1aee431 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -463,7 +463,7 @@ struct scmi_sensor_ops {
 };
 
 /**
- * struct scmi_reset_ops - represents the various operations provided
+ * struct scmi_reset_proto_ops - represents the various operations provided
  *	by SCMI Reset Protocol
  *
  * @num_domains_get: get the count of reset domains provided by SCMI
@@ -473,6 +473,15 @@ struct scmi_sensor_ops {
  * @assert: explicitly assert reset signal of the specified reset domain
  * @deassert: explicitly deassert reset signal of the specified reset domain
  */
+struct scmi_reset_proto_ops {
+	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
+	char *(*name_get)(const struct scmi_protocol_handle *ph, u32 domain);
+	int (*latency_get)(const struct scmi_protocol_handle *ph, u32 domain);
+	int (*reset)(const struct scmi_protocol_handle *ph, u32 domain);
+	int (*assert)(const struct scmi_protocol_handle *ph, u32 domain);
+	int (*deassert)(const struct scmi_protocol_handle *ph, u32 domain);
+};
+
 struct scmi_reset_ops {
 	int (*num_domains_get)(const struct scmi_handle *handle);
 	char *(*name_get)(const struct scmi_handle *handle, u32 domain);
@@ -613,8 +622,6 @@ struct scmi_notify_ops {
  * @notify_ops: pointer to set of notifications related operations
  * @sensor_priv: pointer to private data structure specific to sensors
  *	protocol(for internal use only)
- * @reset_priv: pointer to private data structure specific to reset
- *	protocol(for internal use only)
  * @voltage_priv: pointer to private data structure specific to voltage
  *	protocol(for internal use only)
  * @notify_priv: pointer to private data structure specific to notifications
@@ -640,7 +647,6 @@ struct scmi_handle {
 	const struct scmi_notify_ops *notify_ops;
 	/* for protocol internal use */
 	void *sensor_priv;
-	void *reset_priv;
 	void *voltage_priv;
 	void *notify_priv;
 	void *system_priv;
-- 
2.17.1

