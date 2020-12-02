Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177AB2CC815
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgLBUm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:27 -0500
Received: from foss.arm.com ([217.140.110.172]:50476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388223AbgLBUmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2BD513D5;
        Wed,  2 Dec 2020 12:41:21 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A38653F575;
        Wed,  2 Dec 2020 12:41:19 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 27/37] firmware: arm_scmi: port SystemPower protocol to new protocols interface
Date:   Wed,  2 Dec 2020 20:39:59 +0000
Message-Id: <20201202204009.32073-28-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert internals of protocol implementation to use protocol handles and
expose a new protocol operations interface for SCMI driver using the new
get/put common operations.

Remove handle->system_priv now unused.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/system.c | 30 ++++++++++++++----------------
 include/linux/scmi_protocol.h      |  1 -
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index 6690610c2c26..a23c1f505b56 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -32,40 +32,40 @@ struct scmi_system_info {
 	u32 version;
 };
 
-static int scmi_system_request_notify(const struct scmi_handle *handle,
+static int scmi_system_request_notify(const struct scmi_protocol_handle *ph,
 				      bool enable)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_system_power_state_notify *notify;
 
-	ret = scmi_xfer_get_init(handle, SYSTEM_POWER_STATE_NOTIFY,
-				 SCMI_PROTOCOL_SYSTEM, sizeof(*notify), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, SYSTEM_POWER_STATE_NOTIFY,
+				      sizeof(*notify), 0, &t);
 	if (ret)
 		return ret;
 
 	notify = t->tx.buf;
 	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_system_set_notify_enabled(const void *handle,
+static int scmi_system_set_notify_enabled(const void *ph,
 					  u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
 
-	ret = scmi_system_request_notify(handle, enable);
+	ret = scmi_system_request_notify(ph, enable);
 	if (ret)
 		pr_debug("FAIL_ENABLE - evt[%X] - ret:%d\n", evt_id, ret);
 
 	return ret;
 }
 
-static void *scmi_system_fill_custom_report(const void *handle,
+static void *scmi_system_fill_custom_report(const void *ph,
 					    u8 evt_id, ktime_t timestamp,
 					    const void *payld, size_t payld_sz,
 					    void *report, u32 *src_id)
@@ -109,29 +109,27 @@ static const struct scmi_protocol_events system_protocol_events = {
 	.num_sources = SCMI_SYSTEM_NUM_SOURCES,
 };
 
-static int scmi_system_protocol_init(struct scmi_handle *handle)
+static int scmi_system_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	u32 version;
 	struct scmi_system_info *pinfo;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_SYSTEM, &version);
+	ph->xops->version_get(ph, &version);
 
-	dev_dbg(handle->dev, "System Power Version %d.%d\n",
+	dev_dbg(ph->dev, "System Power Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
 
-	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
+	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
 		return -ENOMEM;
 
 	pinfo->version = version;
-	handle->system_priv = pinfo;
-
-	return 0;
+	return ph->set_priv(ph, pinfo);
 }
 
 static const struct scmi_protocol scmi_system = {
 	.id = SCMI_PROTOCOL_SYSTEM,
-	.init = &scmi_system_protocol_init,
+	.init_instance = &scmi_system_protocol_init,
 	.ops = NULL,
 	.events = &system_protocol_events,
 };
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0ae47f7ae148..48ff9fef68fc 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -633,7 +633,6 @@ struct scmi_handle {
 	/* for protocol internal use */
 	void *voltage_priv;
 	void *notify_priv;
-	void *system_priv;
 };
 
 enum scmi_std_protocol {
-- 
2.17.1

