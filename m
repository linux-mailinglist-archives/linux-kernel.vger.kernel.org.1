Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D4C2CC830
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbgLBUnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:43:39 -0500
Received: from foss.arm.com ([217.140.110.172]:50420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387856AbgLBUmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF4A91529;
        Wed,  2 Dec 2020 12:40:55 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 299063F575;
        Wed,  2 Dec 2020 12:40:54 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 15/37] firmware: arm_scmi: port Power protocol to new protocols interface
Date:   Wed,  2 Dec 2020 20:39:47 +0000
Message-Id: <20201202204009.32073-16-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert internals of protocol implementation to use protocol handles and
expose a new protocol operations interface for SCMI driver using the new
get/put common operations, while keeping the old handle->power_ops still
around to ease transition.

Remove handle->power_priv now unused.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/power.c | 141 +++++++++++++++++++-----------
 include/linux/scmi_protocol.h     |  20 +++--
 2 files changed, 105 insertions(+), 56 deletions(-)

diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index e4c084ca92e4..b3d1c032218c 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -68,21 +68,21 @@ struct scmi_power_info {
 	struct power_dom_info *dom_info;
 };
 
-static int scmi_power_attributes_get(const struct scmi_handle *handle,
+static int scmi_power_attributes_get(const struct scmi_protocol_handle *ph,
 				     struct scmi_power_info *pi)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_power_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
-				 SCMI_PROTOCOL_POWER, 0, sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
+				      0, sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		pi->num_domains = le16_to_cpu(attr->num_domains);
 		pi->stats_addr = le32_to_cpu(attr->stats_addr_low) |
@@ -90,28 +90,27 @@ static int scmi_power_attributes_get(const struct scmi_handle *handle,
 		pi->stats_size = le32_to_cpu(attr->stats_size);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
 static int
-scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
-				 struct power_dom_info *dom_info)
+scmi_power_domain_attributes_get(const struct scmi_protocol_handle *ph,
+				 u32 domain, struct power_dom_info *dom_info)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_power_domain_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, POWER_DOMAIN_ATTRIBUTES,
-				 SCMI_PROTOCOL_POWER, sizeof(domain),
-				 sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, POWER_DOMAIN_ATTRIBUTES,
+				      sizeof(domain), sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		u32 flags = le32_to_cpu(attr->flags);
 
@@ -121,19 +120,18 @@ scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int
-scmi_power_state_set(const struct scmi_handle *handle, u32 domain, u32 state)
+static int scmi_power_state_set(const struct scmi_protocol_handle *ph,
+				u32 domain, u32 state)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_power_set_state *st;
 
-	ret = scmi_xfer_get_init(handle, POWER_STATE_SET, SCMI_PROTOCOL_POWER,
-				 sizeof(*st), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, POWER_STATE_SET, sizeof(*st), 0, &t);
 	if (ret)
 		return ret;
 
@@ -142,64 +140,106 @@ scmi_power_state_set(const struct scmi_handle *handle, u32 domain, u32 state)
 	st->domain = cpu_to_le32(domain);
 	st->state = cpu_to_le32(state);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int
-scmi_power_state_get(const struct scmi_handle *handle, u32 domain, u32 *state)
+static int __scmi_power_state_set(const struct scmi_handle *handle,
+				  u32 domain, u32 state)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_POWER);
+
+	return scmi_power_state_set(ph, domain, state);
+}
+
+static int scmi_power_state_get(const struct scmi_protocol_handle *ph,
+				u32 domain, u32 *state)
 {
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, POWER_STATE_GET, SCMI_PROTOCOL_POWER,
-				 sizeof(u32), sizeof(u32), &t);
+	ret = ph->xops->xfer_get_init(ph, POWER_STATE_GET, sizeof(u32), sizeof(u32), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(domain, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		*state = get_unaligned_le32(t->rx.buf);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_power_num_domains_get(const struct scmi_handle *handle)
+static int __scmi_power_state_get(const struct scmi_handle *handle,
+				  u32 domain, u32 *state)
 {
-	struct scmi_power_info *pi = handle->power_priv;
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_POWER);
+
+	return scmi_power_state_get(ph, domain, state);
+}
+
+static int scmi_power_num_domains_get(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_power_info *pi = ph->get_priv(ph);
 
 	return pi->num_domains;
 }
 
-static char *scmi_power_name_get(const struct scmi_handle *handle, u32 domain)
+static int __scmi_power_num_domains_get(const struct scmi_handle *handle)
 {
-	struct scmi_power_info *pi = handle->power_priv;
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_POWER);
+
+	return scmi_power_num_domains_get(ph);
+}
+
+static char *scmi_power_name_get(const struct scmi_protocol_handle *ph,
+				 u32 domain)
+{
+	struct scmi_power_info *pi = ph->get_priv(ph);
 	struct power_dom_info *dom = pi->dom_info + domain;
 
 	return dom->name;
 }
 
+static char *__scmi_power_name_get(const struct scmi_handle *handle,
+				   u32 domain)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_POWER);
+
+	return scmi_power_name_get(ph, domain);
+}
+
 static const struct scmi_power_ops power_ops = {
+	.num_domains_get = __scmi_power_num_domains_get,
+	.name_get = __scmi_power_name_get,
+	.state_set = __scmi_power_state_set,
+	.state_get = __scmi_power_state_get,
+};
+
+static const struct scmi_power_proto_ops power_proto_ops = {
 	.num_domains_get = scmi_power_num_domains_get,
 	.name_get = scmi_power_name_get,
 	.state_set = scmi_power_state_set,
 	.state_get = scmi_power_state_get,
 };
 
-static int scmi_power_request_notify(const struct scmi_handle *handle,
+static int scmi_power_request_notify(const struct scmi_protocol_handle *ph,
 				     u32 domain, bool enable)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_power_state_notify *notify;
 
-	ret = scmi_xfer_get_init(handle, POWER_STATE_NOTIFY,
-				 SCMI_PROTOCOL_POWER, sizeof(*notify), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, POWER_STATE_NOTIFY,
+				      sizeof(*notify), 0, &t);
 	if (ret)
 		return ret;
 
@@ -207,18 +247,18 @@ static int scmi_power_request_notify(const struct scmi_handle *handle,
 	notify->domain = cpu_to_le32(domain);
 	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_power_set_notify_enabled(const void *handle,
+static int scmi_power_set_notify_enabled(const void *ph,
 					 u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
 
-	ret = scmi_power_request_notify(handle, src_id, enable);
+	ret = scmi_power_request_notify(ph, src_id, enable);
 	if (ret)
 		pr_debug("FAIL_ENABLE - evt[%X] dom[%d] - ret:%d\n",
 			 evt_id, src_id, ret);
@@ -226,7 +266,7 @@ static int scmi_power_set_notify_enabled(const void *handle,
 	return ret;
 }
 
-static void *scmi_power_fill_custom_report(const void *handle,
+static void *scmi_power_fill_custom_report(const void *ph,
 					   u8 evt_id, ktime_t timestamp,
 					   const void *payld, size_t payld_sz,
 					   void *report, u32 *src_id)
@@ -246,10 +286,10 @@ static void *scmi_power_fill_custom_report(const void *handle,
 	return r;
 }
 
-static int scmi_power_get_num_sources(const void *handle)
+static int scmi_power_get_num_sources(const void *ph)
 {
 	struct scmi_power_info *pinfo =
-		((const struct scmi_handle *)(handle))->power_priv;
+		((const struct scmi_protocol_handle *)ph)->get_priv(ph);
 
 	if (!pinfo)
 		return -EINVAL;
@@ -279,24 +319,25 @@ static const struct scmi_protocol_events power_protocol_events = {
 	.num_events = ARRAY_SIZE(power_events),
 };
 
-static int scmi_power_protocol_init(struct scmi_handle *handle)
+static int scmi_power_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	int domain;
 	u32 version;
 	struct scmi_power_info *pinfo;
+	struct scmi_handle *handle;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_POWER, &version);
+	ph->xops->version_get(ph, &version);
 
-	dev_dbg(handle->dev, "Power Version %d.%d\n",
+	dev_dbg(ph->dev, "Power Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
 
-	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
+	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
 		return -ENOMEM;
 
-	scmi_power_attributes_get(handle, pinfo);
+	scmi_power_attributes_get(ph, pinfo);
 
-	pinfo->dom_info = devm_kcalloc(handle->dev, pinfo->num_domains,
+	pinfo->dom_info = devm_kcalloc(ph->dev, pinfo->num_domains,
 				       sizeof(*pinfo->dom_info), GFP_KERNEL);
 	if (!pinfo->dom_info)
 		return -ENOMEM;
@@ -304,20 +345,22 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
 		struct power_dom_info *dom = pinfo->dom_info + domain;
 
-		scmi_power_domain_attributes_get(handle, domain, dom);
+		scmi_power_domain_attributes_get(ph, domain, dom);
 	}
 
 	pinfo->version = version;
+
+	/* Transient code for legacy ops interface */
+	handle = scmi_map_scmi_handle(ph);
 	handle->power_ops = &power_ops;
-	handle->power_priv = pinfo;
 
-	return 0;
+	return ph->set_priv(ph, pinfo);
 }
 
 static const struct scmi_protocol scmi_power = {
 	.id = SCMI_PROTOCOL_POWER,
-	.init = &scmi_power_protocol_init,
-	.ops = &power_ops,
+	.init_instance = &scmi_power_protocol_init,
+	.ops = &power_proto_ops,
 	.events = &power_protocol_events,
 };
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index e4212ce1dfbf..83650b50d64d 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -127,7 +127,7 @@ struct scmi_perf_proto_ops {
 };
 
 /**
- * struct scmi_power_ops - represents the various operations provided
+ * struct scmi_power_proto_ops - represents the various operations provided
  *	by SCMI Power Protocol
  *
  * @num_domains_get: get the count of power domains provided by SCMI
@@ -135,9 +135,9 @@ struct scmi_perf_proto_ops {
  * @state_set: sets the power state of a power domain
  * @state_get: gets the power state of a power domain
  */
-struct scmi_power_ops {
-	int (*num_domains_get)(const struct scmi_handle *handle);
-	char *(*name_get)(const struct scmi_handle *handle, u32 domain);
+struct scmi_power_proto_ops {
+	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
+	char *(*name_get)(const struct scmi_protocol_handle *ph, u32 domain);
 #define SCMI_POWER_STATE_TYPE_SHIFT	30
 #define SCMI_POWER_STATE_ID_MASK	(BIT(28) - 1)
 #define SCMI_POWER_STATE_PARAM(type, id) \
@@ -145,6 +145,15 @@ struct scmi_power_ops {
 		((id) & SCMI_POWER_STATE_ID_MASK))
 #define SCMI_POWER_STATE_GENERIC_ON	SCMI_POWER_STATE_PARAM(0, 0)
 #define SCMI_POWER_STATE_GENERIC_OFF	SCMI_POWER_STATE_PARAM(1, 0)
+	int (*state_set)(const struct scmi_protocol_handle *ph, u32 domain,
+			 u32 state);
+	int (*state_get)(const struct scmi_protocol_handle *ph, u32 domain,
+			 u32 *state);
+};
+
+struct scmi_power_ops {
+	int (*num_domains_get)(const struct scmi_handle *handle);
+	char *(*name_get)(const struct scmi_handle *handle, u32 domain);
 	int (*state_set)(const struct scmi_handle *handle, u32 domain,
 			 u32 state);
 	int (*state_get)(const struct scmi_handle *handle, u32 domain,
@@ -615,8 +624,6 @@ struct scmi_notify_ops {
  * @notify_ops: pointer to set of notifications related operations
  * @clk_priv: pointer to private data structure specific to clock
  *	protocol(for internal use only)
- * @power_priv: pointer to private data structure specific to power
- *	protocol(for internal use only)
  * @sensor_priv: pointer to private data structure specific to sensors
  *	protocol(for internal use only)
  * @reset_priv: pointer to private data structure specific to reset
@@ -648,7 +655,6 @@ struct scmi_handle {
 	const struct scmi_notify_ops *notify_ops;
 	/* for protocol internal use */
 	void *clk_priv;
-	void *power_priv;
 	void *sensor_priv;
 	void *reset_priv;
 	void *voltage_priv;
-- 
2.17.1

