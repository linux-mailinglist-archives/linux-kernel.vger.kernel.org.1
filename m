Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BBD2EC4CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 21:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbhAFUVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:21:09 -0500
Received: from foss.arm.com ([217.140.110.172]:46986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbhAFUSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:18:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09EEA1570;
        Wed,  6 Jan 2021 12:18:10 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A62933F719;
        Wed,  6 Jan 2021 12:18:07 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v4 30/37] firmware: arm_scmi: remove legacy scmi_voltage_ops protocol interface
Date:   Wed,  6 Jan 2021 20:16:03 +0000
Message-Id: <20210106201610.26538-31-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106201610.26538-1-cristian.marussi@arm.com>
References: <20210106201610.26538-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the SCMI driver users have been migrated to the new interface
remove the legacy interface and all the transient code.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/voltage.c | 67 -----------------------------
 include/linux/scmi_protocol.h       | 16 -------
 2 files changed, 83 deletions(-)

diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index 7b390426028e..3a0cd5a531f1 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -262,15 +262,6 @@ static int scmi_voltage_config_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int __scmi_voltage_config_set(const struct scmi_handle *handle,
-				     u32 domain_id, u32 config)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_VOLTAGE);
-
-	return scmi_voltage_config_set(ph, domain_id, config);
-}
-
 static int scmi_voltage_config_get(const struct scmi_protocol_handle *ph,
 				   u32 domain_id, u32 *config)
 {
@@ -278,15 +269,6 @@ static int scmi_voltage_config_get(const struct scmi_protocol_handle *ph,
 				      domain_id, config);
 }
 
-static int __scmi_voltage_config_get(const struct scmi_handle *handle,
-				     u32 domain_id, u32 *config)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_VOLTAGE);
-
-	return scmi_voltage_config_get(ph, domain_id, config);
-}
-
 static int scmi_voltage_level_set(const struct scmi_protocol_handle *ph,
 				  u32 domain_id, u32 flags, s32 volt_uV)
 {
@@ -314,15 +296,6 @@ static int scmi_voltage_level_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int __scmi_voltage_level_set(const struct scmi_handle *handle,
-				    u32 domain_id, u32 flags, s32 volt_uV)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_VOLTAGE);
-
-	return scmi_voltage_level_set(ph, domain_id, flags, volt_uV);
-}
-
 static int scmi_voltage_level_get(const struct scmi_protocol_handle *ph,
 				  u32 domain_id, s32 *volt_uV)
 {
@@ -330,15 +303,6 @@ static int scmi_voltage_level_get(const struct scmi_protocol_handle *ph,
 				      domain_id, (u32 *)volt_uV);
 }
 
-static int __scmi_voltage_level_get(const struct scmi_handle *handle,
-				    u32 domain_id, s32 *volt_uV)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_VOLTAGE);
-
-	return scmi_voltage_level_get(ph, domain_id, volt_uV);
-}
-
 static const struct scmi_voltage_info * __must_check
 scmi_voltage_info_get(const struct scmi_protocol_handle *ph, u32 domain_id)
 {
@@ -351,15 +315,6 @@ scmi_voltage_info_get(const struct scmi_protocol_handle *ph, u32 domain_id)
 	return vinfo->domains + domain_id;
 }
 
-static const struct scmi_voltage_info * __must_check
-__scmi_voltage_info_get(const struct scmi_handle *handle, u32 domain_id)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_VOLTAGE);
-
-	return scmi_voltage_info_get(ph, domain_id);
-}
-
 static int scmi_voltage_domains_num_get(const struct scmi_protocol_handle *ph)
 {
 	struct voltage_info *vinfo = ph->get_priv(ph);
@@ -367,23 +322,6 @@ static int scmi_voltage_domains_num_get(const struct scmi_protocol_handle *ph)
 	return vinfo->num_domains;
 }
 
-static int __scmi_voltage_domains_num_get(const struct scmi_handle *handle)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_VOLTAGE);
-
-	return scmi_voltage_domains_num_get(ph);
-}
-
-static struct scmi_voltage_ops voltage_ops = {
-	.num_domains_get = __scmi_voltage_domains_num_get,
-	.info_get = __scmi_voltage_info_get,
-	.config_set = __scmi_voltage_config_set,
-	.config_get = __scmi_voltage_config_get,
-	.level_set = __scmi_voltage_level_set,
-	.level_get = __scmi_voltage_level_get,
-};
-
 static struct scmi_voltage_proto_ops voltage_proto_ops = {
 	.num_domains_get = scmi_voltage_domains_num_get,
 	.info_get = scmi_voltage_info_get,
@@ -398,7 +336,6 @@ static int scmi_voltage_protocol_init(const struct scmi_protocol_handle *ph)
 	int ret;
 	u32 version;
 	struct voltage_info *vinfo;
-	struct scmi_handle *handle;
 
 	ret = ph->xops->version_get(ph, &version);
 	if (ret)
@@ -429,10 +366,6 @@ static int scmi_voltage_protocol_init(const struct scmi_protocol_handle *ph)
 		dev_warn(ph->dev, "No Voltage domains found.\n");
 	}
 
-	/* Transient code for legacy ops interface */
-	handle = scmi_map_scmi_handle(ph);
-	handle->voltage_ops = &voltage_ops;
-
 	return ph->set_priv(ph, vinfo);
 }
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index a36f3fa33a5f..c16455cff6a9 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -541,20 +541,6 @@ struct scmi_voltage_proto_ops {
 			 s32 *volt_uV);
 };
 
-struct scmi_voltage_ops {
-	int (*num_domains_get)(const struct scmi_handle *handle);
-	const struct scmi_voltage_info __must_check *(*info_get)
-		(const struct scmi_handle *handle, u32 domain_id);
-	int (*config_set)(const struct scmi_handle *handle, u32 domain_id,
-			  u32 config);
-	int (*config_get)(const struct scmi_handle *handle, u32 domain_id,
-			  u32 *config);
-	int (*level_set)(const struct scmi_handle *handle, u32 domain_id,
-			 u32 flags, s32 volt_uV);
-	int (*level_get)(const struct scmi_handle *handle, u32 domain_id,
-			 s32 *volt_uV);
-};
-
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided by
  * SCMI core
@@ -616,7 +602,6 @@ struct scmi_notify_ops {
  *
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
- * @voltage_ops: pointer to set of voltage protocol operations
  * @devm_get_ops: devres managed method to acquire a protocol and get specific
  *		  operations and a dedicated protocol handler
  * @devm_put_ops: devres managed method to release a protocol
@@ -630,7 +615,6 @@ struct scmi_notify_ops {
 struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
-	const struct scmi_voltage_ops *voltage_ops;
 
 	const void __must_check *
 		(*devm_get_ops)(struct scmi_device *sdev, u8 proto,
-- 
2.17.1

