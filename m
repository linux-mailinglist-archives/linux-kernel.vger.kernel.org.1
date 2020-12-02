Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A712CC825
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbgLBUnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:43:05 -0500
Received: from foss.arm.com ([217.140.110.172]:50636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388527AbgLBUmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 773D41424;
        Wed,  2 Dec 2020 12:41:24 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E13F3F575;
        Wed,  2 Dec 2020 12:41:22 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 28/37] firmware: arm_scmi: port Voltage protocol to new protocols interface
Date:   Wed,  2 Dec 2020 20:40:00 +0000
Message-Id: <20201202204009.32073-29-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert internals of protocol implementation to use protocol handles and
expose a new protocol operations interface for SCMI driver using the new
get/put common operations, while keeping the old handle->voltage_ops still
around to ease transition.

Remove handle->voltage_priv now unused.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/voltage.c | 179 ++++++++++++++++++----------
 include/linux/scmi_protocol.h       |  24 ++--
 2 files changed, 136 insertions(+), 67 deletions(-)

diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index 8145ee79bb19..7b390426028e 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -59,23 +59,23 @@ struct voltage_info {
 	struct scmi_voltage_info *domains;
 };
 
-static int scmi_protocol_attributes_get(const struct scmi_handle *handle,
+static int scmi_protocol_attributes_get(const struct scmi_protocol_handle *ph,
 					struct voltage_info *vinfo)
 {
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
-				 SCMI_PROTOCOL_VOLTAGE, 0, sizeof(__le32), &t);
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
+				      sizeof(__le32), &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		vinfo->num_domains =
 			NUM_VOLTAGE_DOMAINS(get_unaligned_le32(t->rx.buf));
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
@@ -109,24 +109,23 @@ static int scmi_init_voltage_levels(struct device *dev,
 	return 0;
 }
 
-static int scmi_voltage_descriptors_get(const struct scmi_handle *handle,
+static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 					struct voltage_info *vinfo)
 {
 	int ret, dom;
 	struct scmi_xfer *td, *tl;
-	struct device *dev = handle->dev;
+	struct device *dev = ph->dev;
 	struct scmi_msg_resp_domain_attributes *resp_dom;
 	struct scmi_msg_resp_describe_levels *resp_levels;
 
-	ret = scmi_xfer_get_init(handle, VOLTAGE_DOMAIN_ATTRIBUTES,
-				 SCMI_PROTOCOL_VOLTAGE, sizeof(__le32),
-				 sizeof(*resp_dom), &td);
+	ret = ph->xops->xfer_get_init(ph, VOLTAGE_DOMAIN_ATTRIBUTES,
+				      sizeof(__le32), sizeof(*resp_dom), &td);
 	if (ret)
 		return ret;
 	resp_dom = td->rx.buf;
 
-	ret = scmi_xfer_get_init(handle, VOLTAGE_DESCRIBE_LEVELS,
-				 SCMI_PROTOCOL_VOLTAGE, sizeof(__le64), 0, &tl);
+	ret = ph->xops->xfer_get_init(ph, VOLTAGE_DESCRIBE_LEVELS,
+				      sizeof(__le64), 0, &tl);
 	if (ret)
 		goto outd;
 	resp_levels = tl->rx.buf;
@@ -139,7 +138,7 @@ static int scmi_voltage_descriptors_get(const struct scmi_handle *handle,
 
 		/* Retrieve domain attributes at first ... */
 		put_unaligned_le32(dom, td->tx.buf);
-		ret = scmi_do_xfer(handle, td);
+		ret = ph->xops->do_xfer(ph, td);
 		/* Skip domain on comms error */
 		if (ret)
 			continue;
@@ -157,7 +156,7 @@ static int scmi_voltage_descriptors_get(const struct scmi_handle *handle,
 
 			cmd->domain_id = cpu_to_le32(v->id);
 			cmd->level_index = desc_index;
-			ret = scmi_do_xfer(handle, tl);
+			ret = ph->xops->do_xfer(ph, tl);
 			if (ret)
 				break;
 
@@ -176,7 +175,7 @@ static int scmi_voltage_descriptors_get(const struct scmi_handle *handle,
 			}
 
 			if (desc_index + num_returned > v->num_levels) {
-				dev_err(handle->dev,
+				dev_err(ph->dev,
 					"No. of voltage levels can't exceed %d\n",
 					v->num_levels);
 				ret = -EINVAL;
@@ -195,7 +194,7 @@ static int scmi_voltage_descriptors_get(const struct scmi_handle *handle,
 
 			desc_index += num_returned;
 
-			scmi_reset_rx_to_maxsz(handle, tl);
+			ph->xops->reset_rx_to_maxsz(ph, tl);
 			/* check both to avoid infinite loop due to buggy fw */
 		} while (num_returned && num_remaining);
 
@@ -204,55 +203,52 @@ static int scmi_voltage_descriptors_get(const struct scmi_handle *handle,
 			devm_kfree(dev, v->levels_uv);
 		}
 
-		scmi_reset_rx_to_maxsz(handle, td);
+		ph->xops->reset_rx_to_maxsz(ph, td);
 	}
 
-	scmi_xfer_put(handle, tl);
+	ph->xops->xfer_put(ph, tl);
 outd:
-	scmi_xfer_put(handle, td);
+	ph->xops->xfer_put(ph, td);
 
 	return ret;
 }
 
-static int __scmi_voltage_get_u32(const struct scmi_handle *handle,
+static int __scmi_voltage_get_u32(const struct scmi_protocol_handle *ph,
 				  u8 cmd_id, u32 domain_id, u32 *value)
 {
 	int ret;
 	struct scmi_xfer *t;
-	struct voltage_info *vinfo = handle->voltage_priv;
+	struct voltage_info *vinfo = ph->get_priv(ph);
 
 	if (domain_id >= vinfo->num_domains)
 		return -EINVAL;
 
-	ret = scmi_xfer_get_init(handle, cmd_id,
-				 SCMI_PROTOCOL_VOLTAGE,
-				 sizeof(__le32), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, cmd_id, sizeof(__le32), 0, &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(domain_id, t->tx.buf);
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		*value = get_unaligned_le32(t->rx.buf);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_voltage_config_set(const struct scmi_handle *handle,
+static int scmi_voltage_config_set(const struct scmi_protocol_handle *ph,
 				   u32 domain_id, u32 config)
 {
 	int ret;
 	struct scmi_xfer *t;
-	struct voltage_info *vinfo = handle->voltage_priv;
+	struct voltage_info *vinfo = ph->get_priv(ph);
 	struct scmi_msg_cmd_config_set *cmd;
 
 	if (domain_id >= vinfo->num_domains)
 		return -EINVAL;
 
-	ret = scmi_xfer_get_init(handle, VOLTAGE_CONFIG_SET,
-				 SCMI_PROTOCOL_VOLTAGE,
-				 sizeof(*cmd), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, VOLTAGE_CONFIG_SET,
+				     sizeof(*cmd), 0, &t);
 	if (ret)
 		return ret;
 
@@ -260,33 +256,50 @@ static int scmi_voltage_config_set(const struct scmi_handle *handle,
 	cmd->domain_id = cpu_to_le32(domain_id);
 	cmd->config = cpu_to_le32(config & GENMASK(3, 0));
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_voltage_config_get(const struct scmi_handle *handle,
+static int __scmi_voltage_config_set(const struct scmi_handle *handle,
+				     u32 domain_id, u32 config)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_VOLTAGE);
+
+	return scmi_voltage_config_set(ph, domain_id, config);
+}
+
+static int scmi_voltage_config_get(const struct scmi_protocol_handle *ph,
 				   u32 domain_id, u32 *config)
 {
-	return __scmi_voltage_get_u32(handle, VOLTAGE_CONFIG_GET,
+	return __scmi_voltage_get_u32(ph, VOLTAGE_CONFIG_GET,
 				      domain_id, config);
 }
 
-static int scmi_voltage_level_set(const struct scmi_handle *handle,
+static int __scmi_voltage_config_get(const struct scmi_handle *handle,
+				     u32 domain_id, u32 *config)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_VOLTAGE);
+
+	return scmi_voltage_config_get(ph, domain_id, config);
+}
+
+static int scmi_voltage_level_set(const struct scmi_protocol_handle *ph,
 				  u32 domain_id, u32 flags, s32 volt_uV)
 {
 	int ret;
 	struct scmi_xfer *t;
-	struct voltage_info *vinfo = handle->voltage_priv;
+	struct voltage_info *vinfo = ph->get_priv(ph);
 	struct scmi_msg_cmd_level_set *cmd;
 
 	if (domain_id >= vinfo->num_domains)
 		return -EINVAL;
 
-	ret = scmi_xfer_get_init(handle, VOLTAGE_LEVEL_SET,
-				 SCMI_PROTOCOL_VOLTAGE,
-				 sizeof(*cmd), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, VOLTAGE_LEVEL_SET,
+				      sizeof(*cmd), 0, &t);
 	if (ret)
 		return ret;
 
@@ -295,23 +308,41 @@ static int scmi_voltage_level_set(const struct scmi_handle *handle,
 	cmd->flags = cpu_to_le32(flags);
 	cmd->voltage_level = cpu_to_le32(volt_uV);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_voltage_level_get(const struct scmi_handle *handle,
+static int __scmi_voltage_level_set(const struct scmi_handle *handle,
+				    u32 domain_id, u32 flags, s32 volt_uV)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_VOLTAGE);
+
+	return scmi_voltage_level_set(ph, domain_id, flags, volt_uV);
+}
+
+static int scmi_voltage_level_get(const struct scmi_protocol_handle *ph,
 				  u32 domain_id, s32 *volt_uV)
 {
-	return __scmi_voltage_get_u32(handle, VOLTAGE_LEVEL_GET,
+	return __scmi_voltage_get_u32(ph, VOLTAGE_LEVEL_GET,
 				      domain_id, (u32 *)volt_uV);
 }
 
+static int __scmi_voltage_level_get(const struct scmi_handle *handle,
+				    u32 domain_id, s32 *volt_uV)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_VOLTAGE);
+
+	return scmi_voltage_level_get(ph, domain_id, volt_uV);
+}
+
 static const struct scmi_voltage_info * __must_check
-scmi_voltage_info_get(const struct scmi_handle *handle, u32 domain_id)
+scmi_voltage_info_get(const struct scmi_protocol_handle *ph, u32 domain_id)
 {
-	struct voltage_info *vinfo = handle->voltage_priv;
+	struct voltage_info *vinfo = ph->get_priv(ph);
 
 	if (domain_id >= vinfo->num_domains ||
 	    !vinfo->domains[domain_id].num_levels)
@@ -320,14 +351,40 @@ scmi_voltage_info_get(const struct scmi_handle *handle, u32 domain_id)
 	return vinfo->domains + domain_id;
 }
 
-static int scmi_voltage_domains_num_get(const struct scmi_handle *handle)
+static const struct scmi_voltage_info * __must_check
+__scmi_voltage_info_get(const struct scmi_handle *handle, u32 domain_id)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_VOLTAGE);
+
+	return scmi_voltage_info_get(ph, domain_id);
+}
+
+static int scmi_voltage_domains_num_get(const struct scmi_protocol_handle *ph)
 {
-	struct voltage_info *vinfo = handle->voltage_priv;
+	struct voltage_info *vinfo = ph->get_priv(ph);
 
 	return vinfo->num_domains;
 }
 
+static int __scmi_voltage_domains_num_get(const struct scmi_handle *handle)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_VOLTAGE);
+
+	return scmi_voltage_domains_num_get(ph);
+}
+
 static struct scmi_voltage_ops voltage_ops = {
+	.num_domains_get = __scmi_voltage_domains_num_get,
+	.info_get = __scmi_voltage_info_get,
+	.config_set = __scmi_voltage_config_set,
+	.config_get = __scmi_voltage_config_get,
+	.level_set = __scmi_voltage_level_set,
+	.level_get = __scmi_voltage_level_get,
+};
+
+static struct scmi_voltage_proto_ops voltage_proto_ops = {
 	.num_domains_get = scmi_voltage_domains_num_get,
 	.info_get = scmi_voltage_info_get,
 	.config_set = scmi_voltage_config_set,
@@ -336,51 +393,53 @@ static struct scmi_voltage_ops voltage_ops = {
 	.level_get = scmi_voltage_level_get,
 };
 
-static int scmi_voltage_protocol_init(struct scmi_handle *handle)
+static int scmi_voltage_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	int ret;
 	u32 version;
 	struct voltage_info *vinfo;
+	struct scmi_handle *handle;
 
-	ret = scmi_version_get(handle, SCMI_PROTOCOL_VOLTAGE, &version);
+	ret = ph->xops->version_get(ph, &version);
 	if (ret)
 		return ret;
 
-	dev_dbg(handle->dev, "Voltage Version %d.%d\n",
+	dev_dbg(ph->dev, "Voltage Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
 
-	vinfo = devm_kzalloc(handle->dev, sizeof(*vinfo), GFP_KERNEL);
+	vinfo = devm_kzalloc(ph->dev, sizeof(*vinfo), GFP_KERNEL);
 	if (!vinfo)
 		return -ENOMEM;
 	vinfo->version = version;
 
-	ret = scmi_protocol_attributes_get(handle, vinfo);
+	ret = scmi_protocol_attributes_get(ph, vinfo);
 	if (ret)
 		return ret;
 
 	if (vinfo->num_domains) {
-		vinfo->domains = devm_kcalloc(handle->dev, vinfo->num_domains,
+		vinfo->domains = devm_kcalloc(ph->dev, vinfo->num_domains,
 					      sizeof(*vinfo->domains),
 					      GFP_KERNEL);
 		if (!vinfo->domains)
 			return -ENOMEM;
-		ret = scmi_voltage_descriptors_get(handle, vinfo);
+		ret = scmi_voltage_descriptors_get(ph, vinfo);
 		if (ret)
 			return ret;
 	} else {
-		dev_warn(handle->dev, "No Voltage domains found.\n");
+		dev_warn(ph->dev, "No Voltage domains found.\n");
 	}
 
+	/* Transient code for legacy ops interface */
+	handle = scmi_map_scmi_handle(ph);
 	handle->voltage_ops = &voltage_ops;
-	handle->voltage_priv = vinfo;
 
-	return 0;
+	return ph->set_priv(ph, vinfo);
 }
 
 static const struct scmi_protocol scmi_voltage = {
 	.id = SCMI_PROTOCOL_VOLTAGE,
-	.init = &scmi_voltage_protocol_init,
-	.ops = &voltage_ops,
+	.init_instance = &scmi_voltage_protocol_init,
+	.ops = &voltage_proto_ops,
 };
 
 DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(voltage, scmi_voltage)
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 48ff9fef68fc..110b2a8f7b72 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -514,7 +514,7 @@ struct scmi_voltage_info {
 };
 
 /**
- * struct scmi_voltage_ops - represents the various operations provided
+ * struct scmi_voltage_proto_ops - represents the various operations provided
  * by SCMI Voltage Protocol
  *
  * @num_domains_get: get the count of voltage domains provided by SCMI
@@ -524,14 +524,28 @@ struct scmi_voltage_info {
  * @level_set: set the voltage level for the specified domain
  * @level_get: get the voltage level of the specified domain
  */
+struct scmi_voltage_proto_ops {
+	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
+	const struct scmi_voltage_info __must_check *(*info_get)
+		(const struct scmi_protocol_handle *ph, u32 domain_id);
+	int (*config_set)(const struct scmi_protocol_handle *ph, u32 domain_id,
+			  u32 config);
+#define	SCMI_VOLTAGE_ARCH_STATE_OFF		0x0
+#define	SCMI_VOLTAGE_ARCH_STATE_ON		0x7
+	int (*config_get)(const struct scmi_protocol_handle *ph, u32 domain_id,
+			  u32 *config);
+	int (*level_set)(const struct scmi_protocol_handle *ph, u32 domain_id,
+			 u32 flags, s32 volt_uV);
+	int (*level_get)(const struct scmi_protocol_handle *ph, u32 domain_id,
+			 s32 *volt_uV);
+};
+
 struct scmi_voltage_ops {
 	int (*num_domains_get)(const struct scmi_handle *handle);
 	const struct scmi_voltage_info __must_check *(*info_get)
 		(const struct scmi_handle *handle, u32 domain_id);
 	int (*config_set)(const struct scmi_handle *handle, u32 domain_id,
 			  u32 config);
-#define	SCMI_VOLTAGE_ARCH_STATE_OFF		0x0
-#define	SCMI_VOLTAGE_ARCH_STATE_ON		0x7
 	int (*config_get)(const struct scmi_handle *handle, u32 domain_id,
 			  u32 *config);
 	int (*level_set)(const struct scmi_handle *handle, u32 domain_id,
@@ -609,8 +623,6 @@ struct scmi_notify_ops {
  *	     dedicated protocol handler
  * @put_ops: method to release a protocol
  * @notify_ops: pointer to set of notifications related operations
- * @voltage_priv: pointer to private data structure specific to voltage
- *	protocol(for internal use only)
  * @notify_priv: pointer to private data structure specific to notifications
  *	(for internal use only)
  */
@@ -630,8 +642,6 @@ struct scmi_handle {
 	void (*put_ops)(struct scmi_handle *handle, u8 proto);
 
 	const struct scmi_notify_ops *notify_ops;
-	/* for protocol internal use */
-	void *voltage_priv;
 	void *notify_priv;
 };
 
-- 
2.17.1

