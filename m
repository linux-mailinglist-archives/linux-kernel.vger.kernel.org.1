Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEC228E2CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbgJNPHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:07:21 -0400
Received: from foss.arm.com ([217.140.110.172]:50902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbgJNPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:07:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6CE11474;
        Wed, 14 Oct 2020 08:07:04 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B89C3F71F;
        Wed, 14 Oct 2020 08:07:02 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 06/11] firmware: arm_scmi: add support for protocol modularization
Date:   Wed, 14 Oct 2020 16:05:40 +0100
Message-Id: <20201014150545.44807-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014150545.44807-1-cristian.marussi@arm.com>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify protocol initialization callback adding a new parameter representing
a reference to the available xfer core operations and introduce a macro to
simply register with the core new protocols as loadable drivers.
Keep standard protocols as builtin.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c    | 56 ++++++++++--------
 drivers/firmware/arm_scmi/bus.c     | 14 ++++-
 drivers/firmware/arm_scmi/clock.c   | 56 +++++++++---------
 drivers/firmware/arm_scmi/common.h  | 42 +++++++++-----
 drivers/firmware/arm_scmi/driver.c  | 50 ++++++++++------
 drivers/firmware/arm_scmi/perf.c    | 88 +++++++++++++++--------------
 drivers/firmware/arm_scmi/power.c   | 46 ++++++++-------
 drivers/firmware/arm_scmi/reset.c   | 46 ++++++++-------
 drivers/firmware/arm_scmi/sensors.c | 52 +++++++++--------
 drivers/firmware/arm_scmi/system.c  | 16 ++++--
 include/linux/scmi_protocol.h       | 18 +++++-
 11 files changed, 288 insertions(+), 196 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index f40821eeb103..8d7214fd2187 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -15,6 +15,8 @@
 #define SCMI_BASE_NUM_SOURCES		1
 #define SCMI_BASE_MAX_CMD_ERR_COUNT	1024
 
+static const struct scmi_xfer_ops *ops;
+
 enum scmi_base_protocol_cmd {
 	BASE_DISCOVER_VENDOR = 0x3,
 	BASE_DISCOVER_SUB_VENDOR = 0x4,
@@ -61,19 +63,19 @@ static int scmi_base_attributes_get(const struct scmi_handle *handle)
 	struct scmi_msg_resp_base_attributes *attr_info;
 	struct scmi_revision_info *rev = handle->version;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
+	ret = ops->xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
 				 SCMI_PROTOCOL_BASE, 0, sizeof(*attr_info), &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret) {
 		attr_info = t->rx.buf;
 		rev->num_protocols = attr_info->num_protocols;
 		rev->num_agents = attr_info->num_agents;
 	}
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 
 	return ret;
 }
@@ -105,15 +107,15 @@ scmi_base_vendor_id_get(const struct scmi_handle *handle, bool sub_vendor)
 		size = ARRAY_SIZE(rev->vendor_id);
 	}
 
-	ret = scmi_xfer_get_init(handle, cmd, SCMI_PROTOCOL_BASE, 0, size, &t);
+	ret = ops->xfer_get_init(handle, cmd, SCMI_PROTOCOL_BASE, 0, size, &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret)
 		memcpy(vendor_id, t->rx.buf, size);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 
 	return ret;
 }
@@ -135,18 +137,18 @@ scmi_base_implementation_version_get(const struct scmi_handle *handle)
 	struct scmi_xfer *t;
 	struct scmi_revision_info *rev = handle->version;
 
-	ret = scmi_xfer_get_init(handle, BASE_DISCOVER_IMPLEMENT_VERSION,
+	ret = ops->xfer_get_init(handle, BASE_DISCOVER_IMPLEMENT_VERSION,
 				 SCMI_PROTOCOL_BASE, 0, sizeof(*impl_ver), &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret) {
 		impl_ver = t->rx.buf;
 		rev->impl_ver = le32_to_cpu(*impl_ver);
 	}
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 
 	return ret;
 }
@@ -170,7 +172,7 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
 	u32 tot_num_ret = 0, loop_num_ret;
 	struct device *dev = handle->dev;
 
-	ret = scmi_xfer_get_init(handle, BASE_DISCOVER_LIST_PROTOCOLS,
+	ret = ops->xfer_get_init(handle, BASE_DISCOVER_LIST_PROTOCOLS,
 				 SCMI_PROTOCOL_BASE, sizeof(*num_skip), 0, &t);
 	if (ret)
 		return ret;
@@ -183,7 +185,7 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
 		/* Set the number of protocols to be skipped/already read */
 		*num_skip = cpu_to_le32(tot_num_ret);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = ops->do_xfer(handle, t);
 		if (ret)
 			break;
 
@@ -198,10 +200,10 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
 
 		tot_num_ret += loop_num_ret;
 
-		scmi_reset_rx_to_maxsz(handle, t);
+		ops->reset_rx_to_maxsz(handle, t);
 	} while (loop_num_ret);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 
 	return ret;
 }
@@ -224,7 +226,7 @@ static int scmi_base_discover_agent_get(const struct scmi_handle *handle,
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, BASE_DISCOVER_AGENT,
+	ret = ops->xfer_get_init(handle, BASE_DISCOVER_AGENT,
 				 SCMI_PROTOCOL_BASE, sizeof(__le32),
 				 SCMI_MAX_STR_SIZE, &t);
 	if (ret)
@@ -232,11 +234,11 @@ static int scmi_base_discover_agent_get(const struct scmi_handle *handle,
 
 	put_unaligned_le32(id, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret)
 		strlcpy(name, t->rx.buf, SCMI_MAX_STR_SIZE);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 
 	return ret;
 }
@@ -248,7 +250,7 @@ static int scmi_base_error_notify(const struct scmi_handle *handle, bool enable)
 	struct scmi_xfer *t;
 	struct scmi_msg_base_error_notify *cfg;
 
-	ret = scmi_xfer_get_init(handle, BASE_NOTIFY_ERRORS,
+	ret = ops->xfer_get_init(handle, BASE_NOTIFY_ERRORS,
 				 SCMI_PROTOCOL_BASE, sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
@@ -256,9 +258,9 @@ static int scmi_base_error_notify(const struct scmi_handle *handle, bool enable)
 	cfg = t->tx.buf;
 	cfg->event_control = cpu_to_le32(evt_cntl);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -326,7 +328,8 @@ static const struct scmi_protocol_events base_protocol_events = {
 	.num_sources = SCMI_BASE_NUM_SOURCES,
 };
 
-static int scmi_base_protocol_init(const struct scmi_handle *h)
+static int scmi_base_protocol_init(const struct scmi_handle *h,
+				   const struct scmi_xfer_ops *xops)
 {
 	int id, ret;
 	u8 *prot_imp;
@@ -336,7 +339,8 @@ static int scmi_base_protocol_init(const struct scmi_handle *h)
 	struct device *dev = handle->dev;
 	struct scmi_revision_info *rev = handle->version;
 
-	ret = scmi_version_get(handle, SCMI_PROTOCOL_BASE, &version);
+	ops = xops;
+	ret = ops->version_get(handle, SCMI_PROTOCOL_BASE, &version);
 	if (ret)
 		return ret;
 
@@ -375,4 +379,12 @@ static struct scmi_protocol scmi_base = {
 	.events = &base_protocol_events,
 };
 
-DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(base, scmi_base)
+int __init scmi_base_register(void)
+{
+	return scmi_protocol_register(&scmi_base, NULL);
+}
+
+void __exit scmi_base_unregister(void)
+{
+	return scmi_protocol_unregister(&scmi_base);
+}
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 3a2be1193c85..2ce98fae56e3 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -56,7 +56,7 @@ const struct scmi_protocol *scmi_get_protocol(int protocol_id)
 	const struct scmi_protocol *proto;
 
 	proto = idr_find(&scmi_available_protocols, protocol_id);
-	if (!proto) {
+	if (!proto || !try_module_get(proto->owner)) {
 		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
 		return NULL;
 	}
@@ -66,6 +66,15 @@ const struct scmi_protocol *scmi_get_protocol(int protocol_id)
 	return proto;
 }
 
+void scmi_put_protocol(int protocol_id)
+{
+	const struct scmi_protocol *proto;
+
+	proto = idr_find(&scmi_available_protocols, protocol_id);
+	if (proto)
+		module_put(proto->owner);
+}
+
 static int scmi_dev_probe(struct device *dev)
 {
 	struct scmi_driver *scmi_drv = to_scmi_driver(dev->driver);
@@ -186,7 +195,7 @@ void scmi_set_handle(struct scmi_device *scmi_dev)
 	scmi_dev->handle = scmi_handle_get(&scmi_dev->dev);
 }
 
-int scmi_protocol_register(struct scmi_protocol *proto)
+int scmi_protocol_register(struct scmi_protocol *proto, struct module *owner)
 {
 	int ret;
 
@@ -200,6 +209,7 @@ int scmi_protocol_register(struct scmi_protocol *proto)
 		return -EINVAL;
 	}
 
+	proto->owner = owner;
 	spin_lock(&protocol_lock);
 	ret = idr_alloc(&scmi_available_protocols, proto,
 			proto->id, proto->id + 1, GFP_ATOMIC);
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 539c94860b8f..a2f552c87b3e 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -9,6 +9,8 @@
 
 #include "common.h"
 
+static const struct scmi_xfer_ops *ops;
+
 enum scmi_clock_protocol_cmd {
 	CLOCK_ATTRIBUTES = 0x3,
 	CLOCK_DESCRIBE_RATES = 0x4,
@@ -81,20 +83,20 @@ static int scmi_clock_protocol_attributes_get(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_clock_protocol_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
+	ret = ops->xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
 				 SCMI_PROTOCOL_CLOCK, 0, sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret) {
 		ci->num_clocks = le16_to_cpu(attr->num_clocks);
 		ci->max_async_req = attr->max_async_req;
 	}
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -105,7 +107,7 @@ static int scmi_clock_attributes_get(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_clock_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, CLOCK_ATTRIBUTES, SCMI_PROTOCOL_CLOCK,
+	ret = ops->xfer_get_init(handle, CLOCK_ATTRIBUTES, SCMI_PROTOCOL_CLOCK,
 				 sizeof(clk_id), sizeof(*attr), &t);
 	if (ret)
 		return ret;
@@ -113,13 +115,13 @@ static int scmi_clock_attributes_get(const struct scmi_handle *handle,
 	put_unaligned_le32(clk_id, t->tx.buf);
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret)
 		strlcpy(clk->name, attr->name, SCMI_MAX_STR_SIZE);
 	else
 		clk->name[0] = '\0';
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -148,7 +150,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 	struct scmi_msg_clock_describe_rates *clk_desc;
 	struct scmi_msg_resp_clock_describe_rates *rlist;
 
-	ret = scmi_xfer_get_init(handle, CLOCK_DESCRIBE_RATES,
+	ret = ops->xfer_get_init(handle, CLOCK_DESCRIBE_RATES,
 				 SCMI_PROTOCOL_CLOCK, sizeof(*clk_desc), 0, &t);
 	if (ret)
 		return ret;
@@ -161,7 +163,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 		/* Set the number of rates to be skipped/already read */
 		clk_desc->rate_index = cpu_to_le32(tot_rate_cnt);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = ops->do_xfer(handle, t);
 		if (ret)
 			goto err;
 
@@ -193,7 +195,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 
 		tot_rate_cnt += num_returned;
 
-		scmi_reset_rx_to_maxsz(handle, t);
+		ops->reset_rx_to_maxsz(handle, t);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
@@ -208,7 +210,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 	clk->rate_discrete = rate_discrete;
 
 err:
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -218,18 +220,18 @@ scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, CLOCK_RATE_GET, SCMI_PROTOCOL_CLOCK,
+	ret = ops->xfer_get_init(handle, CLOCK_RATE_GET, SCMI_PROTOCOL_CLOCK,
 				 sizeof(__le32), sizeof(u64), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(clk_id, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret)
 		*value = get_unaligned_le64(t->rx.buf);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -241,9 +243,9 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
 	struct scmi_xfer *t;
 	struct scmi_clock_set_rate *cfg;
 	struct clock_info *ci =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_CLOCK);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_CLOCK);
 
-	ret = scmi_xfer_get_init(handle, CLOCK_RATE_SET, SCMI_PROTOCOL_CLOCK,
+	ret = ops->xfer_get_init(handle, CLOCK_RATE_SET, SCMI_PROTOCOL_CLOCK,
 				 sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
@@ -259,14 +261,14 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
 	cfg->value_high = cpu_to_le32(rate >> 32);
 
 	if (flags & CLOCK_SET_ASYNC)
-		ret = scmi_do_xfer_with_response(handle, t);
+		ret = ops->do_xfer_with_response(handle, t);
 	else
-		ret = scmi_do_xfer(handle, t);
+		ret = ops->do_xfer(handle, t);
 
 	if (ci->max_async_req)
 		atomic_dec(&ci->cur_async_req);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -277,7 +279,7 @@ scmi_clock_config_set(const struct scmi_handle *handle, u32 clk_id, u32 config)
 	struct scmi_xfer *t;
 	struct scmi_clock_set_config *cfg;
 
-	ret = scmi_xfer_get_init(handle, CLOCK_CONFIG_SET, SCMI_PROTOCOL_CLOCK,
+	ret = ops->xfer_get_init(handle, CLOCK_CONFIG_SET, SCMI_PROTOCOL_CLOCK,
 				 sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
@@ -286,9 +288,9 @@ scmi_clock_config_set(const struct scmi_handle *handle, u32 clk_id, u32 config)
 	cfg->id = cpu_to_le32(clk_id);
 	cfg->attributes = cpu_to_le32(config);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -305,7 +307,7 @@ static int scmi_clock_disable(const struct scmi_handle *handle, u32 clk_id)
 static int scmi_clock_count_get(const struct scmi_handle *handle)
 {
 	struct clock_info *ci =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_CLOCK);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_CLOCK);
 
 	return ci->num_clocks;
 }
@@ -314,7 +316,7 @@ static const struct scmi_clock_info *
 scmi_clock_info_get(const struct scmi_handle *handle, u32 clk_id)
 {
 	struct clock_info *ci =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_CLOCK);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_CLOCK);
 	struct scmi_clock_info *clk = ci->clk + clk_id;
 
 	if (!clk->name[0])
@@ -332,13 +334,15 @@ static const struct scmi_clk_ops clk_ops = {
 	.disable = scmi_clock_disable,
 };
 
-static int scmi_clock_protocol_init(const struct scmi_handle *handle)
+static int scmi_clock_protocol_init(const struct scmi_handle *handle,
+				    const struct scmi_xfer_ops *xops)
 {
 	u32 version;
 	int clkid, ret;
 	struct clock_info *cinfo;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_CLOCK, &version);
+	ops = xops;
+	ops->version_get(handle, SCMI_PROTOCOL_CLOCK, &version);
 
 	dev_dbg(handle->dev, "Clock Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
@@ -363,7 +367,7 @@ static int scmi_clock_protocol_init(const struct scmi_handle *handle)
 	}
 
 	cinfo->version = version;
-	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_CLOCK, cinfo);
+	return ops->set_proto_priv(handle, SCMI_PROTOCOL_CLOCK, cinfo);
 }
 
 static struct scmi_protocol scmi_clock = {
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 5a91e3324697..ec81edc12ca5 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 #include <linux/types.h>
 
@@ -145,26 +146,39 @@ struct scmi_xfer {
 	struct completion *async_done;
 };
 
-void scmi_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer);
-int scmi_do_xfer(const struct scmi_handle *h, struct scmi_xfer *xfer);
-int scmi_do_xfer_with_response(const struct scmi_handle *h,
-			       struct scmi_xfer *xfer);
-int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
-		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
-void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
-			    struct scmi_xfer *xfer);
+struct scmi_xfer_ops {
+	int (*version_get)(const struct scmi_handle *handle, u8 protocol,
+			   u32 *version);
+	int (*set_proto_priv)(const struct scmi_handle *handle, u8 protocol_id,
+			      void *priv);
+	void *(*get_proto_priv)(const struct scmi_handle *handle,
+				u8 protocol_id);
+	int (*xfer_get_init)(const struct scmi_handle *handle, u8 msg_id,
+			     u8 prot_id, size_t tx_size, size_t rx_size,
+			     struct scmi_xfer **p);
+	void (*reset_rx_to_maxsz)(const struct scmi_handle *handle,
+				  struct scmi_xfer *xfer);
+	int (*do_xfer)(const struct scmi_handle *handle,
+		       struct scmi_xfer *xfer);
+	int (*do_xfer_with_response)(const struct scmi_handle *handle,
+				     struct scmi_xfer *xfer);
+	void (*xfer_put)(const struct scmi_handle *handle,
+			 struct scmi_xfer *xfer);
+};
+
 int scmi_handle_put(const struct scmi_handle *handle);
 struct scmi_handle *scmi_handle_get(struct device *dev);
 void scmi_set_handle(struct scmi_device *scmi_dev);
-int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version);
 void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
 				     u8 *prot_imp);
 
-typedef int (*scmi_prot_init_fn_t)(const struct scmi_handle *);
+typedef int (*scmi_prot_init_fn_t)(const struct scmi_handle *,
+				   const struct scmi_xfer_ops *);
 
 /**
  * struct scmi_protocol  - Protocol descriptor
  * @id: Protocol ID.
+ * @owner: Module reference if any.
  * @init: Mandatory protocol initialization function.
  * @deinit: Optional protocol de-initialization function.
  * @ops: Optional reference to the operations provided by the protocol and
@@ -173,6 +187,7 @@ typedef int (*scmi_prot_init_fn_t)(const struct scmi_handle *);
  */
 struct scmi_protocol {
 	const u8				id;
+	struct module				*owner;
 	const scmi_prot_init_fn_t		init;
 	const scmi_prot_init_fn_t		deinit;
 	const void				*ops;
@@ -196,7 +211,7 @@ DECLARE_SCMI_REGISTER_UNREGISTER(system);
 #define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(name, proto) \
 int __init scmi_##name##_register(void) \
 { \
-	return scmi_protocol_register(&(proto)); \
+	return scmi_protocol_register(&(proto), THIS_MODULE); \
 } \
 \
 void __exit scmi_##name##_unregister(void) \
@@ -205,14 +220,11 @@ void __exit scmi_##name##_unregister(void) \
 }
 
 const struct scmi_protocol *scmi_get_protocol(int protocol_id);
+void scmi_put_protocol(int protocol_id);
 
 int scmi_acquire_protocol(const struct scmi_handle *handle, u8 protocol_id);
 void scmi_release_protocol(const struct scmi_handle *handle, u8 protocol_id);
 
-void *scmi_get_proto_priv(const struct scmi_handle *h, u8 prot);
-int scmi_set_proto_priv(const struct scmi_handle *handle, const u8 proto,
-			void *priv);
-
 /* SCMI Transport */
 /**
  * struct scmi_chan_info - Structure representing a SCMI channel information
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 25a4152537e6..55df134c2338 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -370,7 +370,8 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
  * @handle: Pointer to SCMI entity handle
  * @xfer: message that was reserved by scmi_xfer_get
  */
-void scmi_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
+static void scmi_xfer_put(const struct scmi_handle *handle,
+			  struct scmi_xfer *xfer)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
@@ -398,7 +399,8 @@ static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
  *	return corresponding error, else if all goes well,
  *	return 0.
  */
-int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
+static int scmi_do_xfer(const struct scmi_handle *handle,
+			struct scmi_xfer *xfer)
 {
 	int ret;
 	int timeout;
@@ -451,8 +453,8 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	return ret;
 }
 
-void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
-			    struct scmi_xfer *xfer)
+static void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
+				   struct scmi_xfer *xfer)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
@@ -471,8 +473,8 @@ void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
  * Return: -ETIMEDOUT in case of no delayed response, if transmit error,
  *	return corresponding error, else if all goes well, return 0.
  */
-int scmi_do_xfer_with_response(const struct scmi_handle *handle,
-			       struct scmi_xfer *xfer)
+static int scmi_do_xfer_with_response(const struct scmi_handle *handle,
+				      struct scmi_xfer *xfer)
 {
 	int ret, timeout = msecs_to_jiffies(SCMI_MAX_RESPONSE_TIMEOUT);
 	DECLARE_COMPLETION_ONSTACK(async_response);
@@ -503,8 +505,9 @@ int scmi_do_xfer_with_response(const struct scmi_handle *handle,
  * Return: 0 if all went fine with @p pointing to message, else
  *	corresponding error.
  */
-int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
-		       size_t tx_size, size_t rx_size, struct scmi_xfer **p)
+static int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id,
+			      u8 prot_id, size_t tx_size, size_t rx_size,
+			      struct scmi_xfer **p)
 {
 	int ret;
 	struct scmi_xfer *xfer;
@@ -546,8 +549,8 @@ int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
  *
  * Return: 0 if all went fine, else return appropriate error.
  */
-int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
-		     u32 *version)
+static int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
+			    u32 *version)
 {
 	int ret;
 	__le32 *rev_info;
@@ -568,8 +571,8 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
 	return ret;
 }
 
-int scmi_set_proto_priv(const struct scmi_handle *handle,
-			u8 protocol_id, void *priv)
+static int scmi_set_proto_priv(const struct scmi_handle *handle,
+			       u8 protocol_id, void *priv)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
@@ -585,7 +588,8 @@ int scmi_set_proto_priv(const struct scmi_handle *handle,
 	return 0;
 }
 
-void *scmi_get_proto_priv(const struct scmi_handle *handle, u8 protocol_id)
+static void *scmi_get_proto_priv(const struct scmi_handle *handle,
+				 u8 protocol_id)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
@@ -594,6 +598,17 @@ void *scmi_get_proto_priv(const struct scmi_handle *handle, u8 protocol_id)
 	return info->protocols_private_data[protocol_id];
 }
 
+static const struct scmi_xfer_ops xfer_ops = {
+	.version_get = scmi_version_get,
+	.set_proto_priv = scmi_set_proto_priv,
+	.get_proto_priv = scmi_get_proto_priv,
+	.xfer_get_init = scmi_xfer_get_init,
+	.reset_rx_to_maxsz = scmi_reset_rx_to_maxsz,
+	.do_xfer = scmi_do_xfer,
+	.do_xfer_with_response = scmi_do_xfer_with_response,
+	.xfer_put = scmi_xfer_put,
+};
+
 /**
  * scmi_get_protocol_instance  - Protocol initialization helper.
  * @handle: A reference to the SCMI platform instance.
@@ -624,7 +639,7 @@ scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 		/* Fail if protocol not registered on bus */
 		proto = scmi_get_protocol(protocol_id);
 		if (!proto) {
-			ret = -EINVAL;
+			ret = -EPROBE_DEFER;
 			goto out;
 		}
 
@@ -641,7 +656,7 @@ scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 		pi->proto = proto;
 		refcount_set(&pi->users, 1);
 		/* proto->init is assured NON NULL by scmi_protocol_register */
-		ret = pi->proto->init(handle);
+		ret = pi->proto->init(handle, &xfer_ops);
 		if (ret)
 			goto clean;
 
@@ -664,6 +679,7 @@ scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 	return pi;
 
 clean:
+	scmi_put_protocol(protocol_id);
 	devres_release_group(handle->dev, gid);
 out:
 	mutex_unlock(&info->protocols_mtx);
@@ -714,13 +730,15 @@ void scmi_release_protocol(const struct scmi_handle *handle, u8 protocol_id)
 			scmi_deregister_protocol_events(handle, protocol_id);
 
 		if (pi->proto->deinit)
-			pi->proto->deinit(handle);
+			pi->proto->deinit(handle, &xfer_ops);
 
 		info->protocols_private_data[protocol_id] = NULL;
 		info->protocols[protocol_id] = NULL;
 		/* Ensure deinitialized protocol is visible */
 		smp_wmb();
 
+		scmi_put_protocol(protocol_id);
+
 		devres_release_group(handle->dev, gid);
 		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
 			protocol_id);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index b3038362f362..60a28ca39455 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -19,6 +19,8 @@
 #include "common.h"
 #include "notify.h"
 
+static const struct scmi_xfer_ops *ops;
+
 enum scmi_performance_protocol_cmd {
 	PERF_DOMAIN_ATTRIBUTES = 0x3,
 	PERF_DESCRIBE_LEVELS = 0x4,
@@ -182,14 +184,14 @@ static int scmi_perf_attributes_get(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_perf_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
+	ret = ops->xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
 				 SCMI_PROTOCOL_PERF, 0, sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret) {
 		u16 flags = le16_to_cpu(attr->flags);
 
@@ -200,7 +202,7 @@ static int scmi_perf_attributes_get(const struct scmi_handle *handle,
 		pi->stats_size = le32_to_cpu(attr->stats_size);
 	}
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -212,7 +214,7 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_perf_domain_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PERF_DOMAIN_ATTRIBUTES,
+	ret = ops->xfer_get_init(handle, PERF_DOMAIN_ATTRIBUTES,
 				 SCMI_PROTOCOL_PERF, sizeof(domain),
 				 sizeof(*attr), &t);
 	if (ret)
@@ -221,7 +223,7 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret) {
 		u32 flags = le32_to_cpu(attr->flags);
 
@@ -245,7 +247,7 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -268,7 +270,7 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 	struct scmi_msg_perf_describe_levels *dom_info;
 	struct scmi_msg_resp_perf_describe_levels *level_info;
 
-	ret = scmi_xfer_get_init(handle, PERF_DESCRIBE_LEVELS,
+	ret = ops->xfer_get_init(handle, PERF_DESCRIBE_LEVELS,
 				 SCMI_PROTOCOL_PERF, sizeof(*dom_info), 0, &t);
 	if (ret)
 		return ret;
@@ -281,7 +283,7 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 		/* Set the number of OPPs to be skipped/already read */
 		dom_info->level_index = cpu_to_le32(tot_opp_cnt);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = ops->do_xfer(handle, t);
 		if (ret)
 			break;
 
@@ -305,7 +307,7 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 
 		tot_opp_cnt += num_returned;
 
-		scmi_reset_rx_to_maxsz(handle, t);
+		ops->reset_rx_to_maxsz(handle, t);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
@@ -313,7 +315,7 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 	} while (num_returned && num_remaining);
 
 	perf_dom->opp_count = tot_opp_cnt;
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 
 	sort(perf_dom->opp, tot_opp_cnt, sizeof(*opp), opp_cmp_func, NULL);
 	return ret;
@@ -360,7 +362,7 @@ static int scmi_perf_mb_limits_set(const struct scmi_handle *handle, u32 domain,
 	struct scmi_xfer *t;
 	struct scmi_perf_set_limits *limits;
 
-	ret = scmi_xfer_get_init(handle, PERF_LIMITS_SET, SCMI_PROTOCOL_PERF,
+	ret = ops->xfer_get_init(handle, PERF_LIMITS_SET, SCMI_PROTOCOL_PERF,
 				 sizeof(*limits), 0, &t);
 	if (ret)
 		return ret;
@@ -370,16 +372,16 @@ static int scmi_perf_mb_limits_set(const struct scmi_handle *handle, u32 domain,
 	limits->max_level = cpu_to_le32(max_perf);
 	limits->min_level = cpu_to_le32(min_perf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
 static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
 				u32 max_perf, u32 min_perf)
 {
-	struct scmi_perf_info *pi = scmi_get_proto_priv(handle,
+	struct scmi_perf_info *pi = ops->get_proto_priv(handle,
 							SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
@@ -400,14 +402,14 @@ static int scmi_perf_mb_limits_get(const struct scmi_handle *handle, u32 domain,
 	struct scmi_xfer *t;
 	struct scmi_perf_get_limits *limits;
 
-	ret = scmi_xfer_get_init(handle, PERF_LIMITS_GET, SCMI_PROTOCOL_PERF,
+	ret = ops->xfer_get_init(handle, PERF_LIMITS_GET, SCMI_PROTOCOL_PERF,
 				 sizeof(__le32), 0, &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(domain, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret) {
 		limits = t->rx.buf;
 
@@ -415,7 +417,7 @@ static int scmi_perf_mb_limits_get(const struct scmi_handle *handle, u32 domain,
 		*min_perf = le32_to_cpu(limits->min_level);
 	}
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -423,7 +425,7 @@ static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
 				u32 *max_perf, u32 *min_perf)
 {
 	struct scmi_perf_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	if (dom->fc_info && dom->fc_info->limit_get_addr) {
@@ -442,7 +444,7 @@ static int scmi_perf_mb_level_set(const struct scmi_handle *handle, u32 domain,
 	struct scmi_xfer *t;
 	struct scmi_perf_set_level *lvl;
 
-	ret = scmi_xfer_get_init(handle, PERF_LEVEL_SET, SCMI_PROTOCOL_PERF,
+	ret = ops->xfer_get_init(handle, PERF_LEVEL_SET, SCMI_PROTOCOL_PERF,
 				 sizeof(*lvl), 0, &t);
 	if (ret)
 		return ret;
@@ -452,9 +454,9 @@ static int scmi_perf_mb_level_set(const struct scmi_handle *handle, u32 domain,
 	lvl->domain = cpu_to_le32(domain);
 	lvl->level = cpu_to_le32(level);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -462,7 +464,7 @@ static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
 			       u32 level, bool poll)
 {
 	struct scmi_perf_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	if (dom->fc_info && dom->fc_info->level_set_addr) {
@@ -480,7 +482,7 @@ static int scmi_perf_mb_level_get(const struct scmi_handle *handle, u32 domain,
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, PERF_LEVEL_GET, SCMI_PROTOCOL_PERF,
+	ret = ops->xfer_get_init(handle, PERF_LEVEL_GET, SCMI_PROTOCOL_PERF,
 				 sizeof(u32), sizeof(u32), &t);
 	if (ret)
 		return ret;
@@ -488,11 +490,11 @@ static int scmi_perf_mb_level_get(const struct scmi_handle *handle, u32 domain,
 	t->hdr.poll_completion = poll;
 	put_unaligned_le32(domain, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret)
 		*level = get_unaligned_le32(t->rx.buf);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -500,7 +502,7 @@ static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
 			       u32 *level, bool poll)
 {
 	struct scmi_perf_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	if (dom->fc_info && dom->fc_info->level_get_addr) {
@@ -519,7 +521,7 @@ static int scmi_perf_level_limits_notify(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_perf_notify_level_or_limits *notify;
 
-	ret = scmi_xfer_get_init(handle, message_id, SCMI_PROTOCOL_PERF,
+	ret = ops->xfer_get_init(handle, message_id, SCMI_PROTOCOL_PERF,
 				 sizeof(*notify), 0, &t);
 	if (ret)
 		return ret;
@@ -528,9 +530,9 @@ static int scmi_perf_level_limits_notify(const struct scmi_handle *handle,
 	notify->domain = cpu_to_le32(domain);
 	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -561,7 +563,7 @@ scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
 	if (!p_addr)
 		return;
 
-	ret = scmi_xfer_get_init(handle, PERF_DESCRIBE_FASTCHANNEL,
+	ret = ops->xfer_get_init(handle, PERF_DESCRIBE_FASTCHANNEL,
 				 SCMI_PROTOCOL_PERF,
 				 sizeof(*info), sizeof(*resp), &t);
 	if (ret)
@@ -571,7 +573,7 @@ scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
 	info->domain = cpu_to_le32(domain);
 	info->message_id = cpu_to_le32(message_id);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (ret)
 		goto err_xfer;
 
@@ -609,7 +611,7 @@ scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
 		*p_db = db;
 	}
 err_xfer:
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 }
 
 static void scmi_perf_domain_init_fc(const struct scmi_handle *handle,
@@ -652,7 +654,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_handle *handle,
 	struct scmi_opp *opp;
 	struct perf_dom_info *dom;
 	struct scmi_perf_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 
 	domain = scmi_dev_domain_id(dev);
 	if (domain < 0)
@@ -682,7 +684,7 @@ static int scmi_dvfs_transition_latency_get(const struct scmi_handle *handle,
 {
 	struct perf_dom_info *dom;
 	struct scmi_perf_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	int domain = scmi_dev_domain_id(dev);
 
 	if (domain < 0)
@@ -697,7 +699,7 @@ static int scmi_dvfs_freq_set(const struct scmi_handle *handle, u32 domain,
 			      unsigned long freq, bool poll)
 {
 	struct scmi_perf_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	return scmi_perf_level_set(handle, domain, freq / dom->mult_factor,
@@ -710,7 +712,7 @@ static int scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
 	int ret;
 	u32 level;
 	struct scmi_perf_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	ret = scmi_perf_level_get(handle, domain, &level, poll);
@@ -724,7 +726,7 @@ static int scmi_dvfs_est_power_get(const struct scmi_handle *handle, u32 domain,
 				   unsigned long *freq, unsigned long *power)
 {
 	struct scmi_perf_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom;
 	unsigned long opp_freq;
 	int idx, ret = -EINVAL;
@@ -753,7 +755,7 @@ static bool scmi_fast_switch_possible(const struct scmi_handle *handle,
 {
 	struct perf_dom_info *dom;
 	struct scmi_perf_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 
 	dom = pi->dom_info + scmi_dev_domain_id(dev);
 
@@ -842,7 +844,7 @@ static void *scmi_perf_fill_custom_report(const struct scmi_handle *handle,
 static int scmi_perf_get_num_sources(const struct scmi_handle *handle)
 {
 	struct scmi_perf_info *pinfo =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 
 	if (!pinfo)
 		return -EINVAL;
@@ -876,13 +878,15 @@ static const struct scmi_protocol_events perf_protocol_events = {
 	.num_events = ARRAY_SIZE(perf_events),
 };
 
-static int scmi_perf_protocol_init(const struct scmi_handle *handle)
+static int scmi_perf_protocol_init(const struct scmi_handle *handle,
+				   const struct scmi_xfer_ops *xops)
 {
 	int domain;
 	u32 version;
 	struct scmi_perf_info *pinfo;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_PERF, &version);
+	ops = xops;
+	ops->version_get(handle, SCMI_PROTOCOL_PERF, &version);
 
 	dev_dbg(handle->dev, "Performance Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
@@ -909,7 +913,7 @@ static int scmi_perf_protocol_init(const struct scmi_handle *handle)
 	}
 
 	pinfo->version = version;
-	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_PERF, pinfo);
+	return ops->set_proto_priv(handle, SCMI_PROTOCOL_PERF, pinfo);
 }
 
 static struct scmi_protocol scmi_perf = {
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index cb9b1f6a56dd..766e1782c9ff 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -12,6 +12,8 @@
 #include "common.h"
 #include "notify.h"
 
+static const struct scmi_xfer_ops *ops;
+
 enum scmi_power_protocol_cmd {
 	POWER_DOMAIN_ATTRIBUTES = 0x3,
 	POWER_STATE_SET = 0x4,
@@ -75,14 +77,14 @@ static int scmi_power_attributes_get(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_power_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
+	ret = ops->xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
 				 SCMI_PROTOCOL_POWER, 0, sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret) {
 		pi->num_domains = le16_to_cpu(attr->num_domains);
 		pi->stats_addr = le32_to_cpu(attr->stats_addr_low) |
@@ -90,7 +92,7 @@ static int scmi_power_attributes_get(const struct scmi_handle *handle,
 		pi->stats_size = le32_to_cpu(attr->stats_size);
 	}
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -102,7 +104,7 @@ scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_power_domain_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, POWER_DOMAIN_ATTRIBUTES,
+	ret = ops->xfer_get_init(handle, POWER_DOMAIN_ATTRIBUTES,
 				 SCMI_PROTOCOL_POWER, sizeof(domain),
 				 sizeof(*attr), &t);
 	if (ret)
@@ -111,7 +113,7 @@ scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret) {
 		u32 flags = le32_to_cpu(attr->flags);
 
@@ -121,7 +123,7 @@ scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -132,7 +134,7 @@ scmi_power_state_set(const struct scmi_handle *handle, u32 domain, u32 state)
 	struct scmi_xfer *t;
 	struct scmi_power_set_state *st;
 
-	ret = scmi_xfer_get_init(handle, POWER_STATE_SET, SCMI_PROTOCOL_POWER,
+	ret = ops->xfer_get_init(handle, POWER_STATE_SET, SCMI_PROTOCOL_POWER,
 				 sizeof(*st), 0, &t);
 	if (ret)
 		return ret;
@@ -142,9 +144,9 @@ scmi_power_state_set(const struct scmi_handle *handle, u32 domain, u32 state)
 	st->domain = cpu_to_le32(domain);
 	st->state = cpu_to_le32(state);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -154,25 +156,25 @@ scmi_power_state_get(const struct scmi_handle *handle, u32 domain, u32 *state)
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, POWER_STATE_GET, SCMI_PROTOCOL_POWER,
+	ret = ops->xfer_get_init(handle, POWER_STATE_GET, SCMI_PROTOCOL_POWER,
 				 sizeof(u32), sizeof(u32), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(domain, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret)
 		*state = get_unaligned_le32(t->rx.buf);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
 static int scmi_power_num_domains_get(const struct scmi_handle *handle)
 {
 	struct scmi_power_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_POWER);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_POWER);
 
 	return pi->num_domains;
 }
@@ -180,7 +182,7 @@ static int scmi_power_num_domains_get(const struct scmi_handle *handle)
 static char *scmi_power_name_get(const struct scmi_handle *handle, u32 domain)
 {
 	struct scmi_power_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_POWER);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_POWER);
 	struct power_dom_info *dom = pi->dom_info + domain;
 
 	return dom->name;
@@ -200,7 +202,7 @@ static int scmi_power_request_notify(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_power_state_notify *notify;
 
-	ret = scmi_xfer_get_init(handle, POWER_STATE_NOTIFY,
+	ret = ops->xfer_get_init(handle, POWER_STATE_NOTIFY,
 				 SCMI_PROTOCOL_POWER, sizeof(*notify), 0, &t);
 	if (ret)
 		return ret;
@@ -209,9 +211,9 @@ static int scmi_power_request_notify(const struct scmi_handle *handle,
 	notify->domain = cpu_to_le32(domain);
 	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -251,7 +253,7 @@ static void *scmi_power_fill_custom_report(const struct scmi_handle *handle,
 static int scmi_power_get_num_sources(const struct scmi_handle *handle)
 {
 	struct scmi_power_info *pinfo =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_POWER);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_POWER);
 
 	if (!pinfo)
 		return -EINVAL;
@@ -281,13 +283,15 @@ static const struct scmi_protocol_events power_protocol_events = {
 	.num_events = ARRAY_SIZE(power_events),
 };
 
-static int scmi_power_protocol_init(const struct scmi_handle *handle)
+static int scmi_power_protocol_init(const struct scmi_handle *handle,
+				    const struct scmi_xfer_ops *xops)
 {
 	int domain;
 	u32 version;
 	struct scmi_power_info *pinfo;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_POWER, &version);
+	ops = xops;
+	ops->version_get(handle, SCMI_PROTOCOL_POWER, &version);
 
 	dev_dbg(handle->dev, "Power Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
@@ -310,7 +314,7 @@ static int scmi_power_protocol_init(const struct scmi_handle *handle)
 	}
 
 	pinfo->version = version;
-	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_POWER, pinfo);
+	return ops->set_proto_priv(handle, SCMI_PROTOCOL_POWER, pinfo);
 }
 
 static struct scmi_protocol scmi_power = {
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 83bfd0514d4d..9accad66e07e 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -12,6 +12,8 @@
 #include "common.h"
 #include "notify.h"
 
+static const struct scmi_xfer_ops *ops;
+
 enum scmi_reset_protocol_cmd {
 	RESET_DOMAIN_ATTRIBUTES = 0x3,
 	RESET = 0x4,
@@ -71,18 +73,18 @@ static int scmi_reset_attributes_get(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	u32 attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
+	ret = ops->xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
 				 SCMI_PROTOCOL_RESET, 0, sizeof(attr), &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret) {
 		attr = get_unaligned_le32(t->rx.buf);
 		pi->num_domains = attr & NUM_RESET_DOMAIN_MASK;
 	}
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -94,7 +96,7 @@ scmi_reset_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_reset_domain_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, RESET_DOMAIN_ATTRIBUTES,
+	ret = ops->xfer_get_init(handle, RESET_DOMAIN_ATTRIBUTES,
 				 SCMI_PROTOCOL_RESET, sizeof(domain),
 				 sizeof(*attr), &t);
 	if (ret)
@@ -103,7 +105,7 @@ scmi_reset_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret) {
 		u32 attributes = le32_to_cpu(attr->attributes);
 
@@ -115,14 +117,14 @@ scmi_reset_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
 static int scmi_reset_num_domains_get(const struct scmi_handle *handle)
 {
 	struct scmi_reset_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_RESET);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_RESET);
 
 	return pi->num_domains;
 }
@@ -130,7 +132,7 @@ static int scmi_reset_num_domains_get(const struct scmi_handle *handle)
 static char *scmi_reset_name_get(const struct scmi_handle *handle, u32 domain)
 {
 	struct scmi_reset_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_RESET);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_RESET);
 	struct reset_dom_info *dom = pi->dom_info + domain;
 
 	return dom->name;
@@ -139,7 +141,7 @@ static char *scmi_reset_name_get(const struct scmi_handle *handle, u32 domain)
 static int scmi_reset_latency_get(const struct scmi_handle *handle, u32 domain)
 {
 	struct scmi_reset_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_RESET);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_RESET);
 	struct reset_dom_info *dom = pi->dom_info + domain;
 
 	return dom->latency_us;
@@ -152,13 +154,13 @@ static int scmi_domain_reset(const struct scmi_handle *handle, u32 domain,
 	struct scmi_xfer *t;
 	struct scmi_msg_reset_domain_reset *dom;
 	struct scmi_reset_info *pi =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_RESET);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_RESET);
 	struct reset_dom_info *rdom = pi->dom_info + domain;
 
 	if (rdom->async_reset)
 		flags |= ASYNCHRONOUS_RESET;
 
-	ret = scmi_xfer_get_init(handle, RESET, SCMI_PROTOCOL_RESET,
+	ret = ops->xfer_get_init(handle, RESET, SCMI_PROTOCOL_RESET,
 				 sizeof(*dom), 0, &t);
 	if (ret)
 		return ret;
@@ -169,11 +171,11 @@ static int scmi_domain_reset(const struct scmi_handle *handle, u32 domain,
 	dom->reset_state = cpu_to_le32(state);
 
 	if (rdom->async_reset)
-		ret = scmi_do_xfer_with_response(handle, t);
+		ret = ops->do_xfer_with_response(handle, t);
 	else
-		ret = scmi_do_xfer(handle, t);
+		ret = ops->do_xfer(handle, t);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -213,7 +215,7 @@ static int scmi_reset_notify(const struct scmi_handle *handle, u32 domain_id,
 	struct scmi_xfer *t;
 	struct scmi_msg_reset_notify *cfg;
 
-	ret = scmi_xfer_get_init(handle, RESET_NOTIFY,
+	ret = ops->xfer_get_init(handle, RESET_NOTIFY,
 				 SCMI_PROTOCOL_RESET, sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
@@ -222,9 +224,9 @@ static int scmi_reset_notify(const struct scmi_handle *handle, u32 domain_id,
 	cfg->id = cpu_to_le32(domain_id);
 	cfg->event_control = cpu_to_le32(evt_cntl);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -264,7 +266,7 @@ static void *scmi_reset_fill_custom_report(const struct scmi_handle *handle,
 static int scmi_reset_get_num_sources(const struct scmi_handle *handle)
 {
 	struct scmi_reset_info *pinfo =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_RESET);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_RESET);
 
 	if (!pinfo)
 		return -EINVAL;
@@ -293,13 +295,15 @@ static const struct scmi_protocol_events reset_protocol_events = {
 	.num_events = ARRAY_SIZE(reset_events),
 };
 
-static int scmi_reset_protocol_init(const struct scmi_handle *handle)
+static int scmi_reset_protocol_init(const struct scmi_handle *handle,
+				    const struct scmi_xfer_ops *xops)
 {
 	int domain;
 	u32 version;
 	struct scmi_reset_info *pinfo;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_RESET, &version);
+	ops = xops;
+	ops->version_get(handle, SCMI_PROTOCOL_RESET, &version);
 
 	dev_dbg(handle->dev, "Reset Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
@@ -322,7 +326,7 @@ static int scmi_reset_protocol_init(const struct scmi_handle *handle)
 	}
 
 	pinfo->version = version;
-	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_RESET, pinfo);
+	return ops->set_proto_priv(handle, SCMI_PROTOCOL_RESET, pinfo);
 }
 
 static struct scmi_protocol scmi_reset = {
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 79bdd53ab7ba..3a58dbca2b70 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -12,6 +12,8 @@
 #include "common.h"
 #include "notify.h"
 
+static const struct scmi_xfer_ops *ops;
+
 enum scmi_sensor_protocol_cmd {
 	SENSOR_DESCRIPTION_GET = 0x3,
 	SENSOR_TRIP_POINT_NOTIFY = 0x4,
@@ -94,14 +96,14 @@ static int scmi_sensor_attributes_get(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_sensor_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
+	ret = ops->xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
 				 SCMI_PROTOCOL_SENSOR, 0, sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 	if (!ret) {
 		si->num_sensors = le16_to_cpu(attr->num_sensors);
 		si->max_requests = attr->max_requests;
@@ -110,7 +112,7 @@ static int scmi_sensor_attributes_get(const struct scmi_handle *handle,
 		si->reg_size = le32_to_cpu(attr->reg_size);
 	}
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -123,7 +125,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_sensor_description *buf;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_DESCRIPTION_GET,
+	ret = ops->xfer_get_init(handle, SENSOR_DESCRIPTION_GET,
 				 SCMI_PROTOCOL_SENSOR, sizeof(__le32), 0, &t);
 	if (ret)
 		return ret;
@@ -134,7 +136,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 		/* Set the number of sensors to be skipped/already read */
 		put_unaligned_le32(desc_index, t->tx.buf);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = ops->do_xfer(handle, t);
 		if (ret)
 			break;
 
@@ -167,14 +169,14 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 
 		desc_index += num_returned;
 
-		scmi_reset_rx_to_maxsz(handle, t);
+		ops->reset_rx_to_maxsz(handle, t);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
 		 */
 	} while (num_returned && num_remaining);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -186,7 +188,7 @@ static int scmi_sensor_trip_point_notify(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_trip_point_notify *cfg;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_TRIP_POINT_NOTIFY,
+	ret = ops->xfer_get_init(handle, SENSOR_TRIP_POINT_NOTIFY,
 				 SCMI_PROTOCOL_SENSOR, sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
@@ -195,9 +197,9 @@ static int scmi_sensor_trip_point_notify(const struct scmi_handle *handle,
 	cfg->id = cpu_to_le32(sensor_id);
 	cfg->event_control = cpu_to_le32(evt_cntl);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -210,7 +212,7 @@ scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
 	struct scmi_xfer *t;
 	struct scmi_msg_set_sensor_trip_point *trip;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_TRIP_POINT_CONFIG,
+	ret = ops->xfer_get_init(handle, SENSOR_TRIP_POINT_CONFIG,
 				 SCMI_PROTOCOL_SENSOR, sizeof(*trip), 0, &t);
 	if (ret)
 		return ret;
@@ -221,9 +223,9 @@ scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
 	trip->value_low = cpu_to_le32(trip_value & 0xffffffff);
 	trip->value_high = cpu_to_le32(trip_value >> 32);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -234,10 +236,10 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_reading_get *sensor;
 	struct sensors_info *si =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_SENSOR);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_SENSOR);
 	struct scmi_sensor_info *s = si->sensors + sensor_id;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_READING_GET,
+	ret = ops->xfer_get_init(handle, SENSOR_READING_GET,
 				 SCMI_PROTOCOL_SENSOR, sizeof(*sensor),
 				 sizeof(u64), &t);
 	if (ret)
@@ -248,18 +250,18 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 
 	if (s->async) {
 		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
-		ret = scmi_do_xfer_with_response(handle, t);
+		ret = ops->do_xfer_with_response(handle, t);
 		if (!ret)
 			*value = get_unaligned_le64((void *)
 						    ((__le32 *)t->rx.buf + 1));
 	} else {
 		sensor->flags = cpu_to_le32(0);
-		ret = scmi_do_xfer(handle, t);
+		ret = ops->do_xfer(handle, t);
 		if (!ret)
 			*value = get_unaligned_le64(t->rx.buf);
 	}
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -267,7 +269,7 @@ static const struct scmi_sensor_info *
 scmi_sensor_info_get(const struct scmi_handle *handle, u32 sensor_id)
 {
 	struct sensors_info *si =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_SENSOR);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_SENSOR);
 
 	return si->sensors + sensor_id;
 }
@@ -275,7 +277,7 @@ scmi_sensor_info_get(const struct scmi_handle *handle, u32 sensor_id)
 static int scmi_sensor_count_get(const struct scmi_handle *handle)
 {
 	struct sensors_info *si =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_SENSOR);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_SENSOR);
 
 	return si->num_sensors;
 }
@@ -324,7 +326,7 @@ static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
 static int scmi_sensor_get_num_sources(const struct scmi_handle *handle)
 {
 	struct sensors_info *sinfo =
-		scmi_get_proto_priv(handle, SCMI_PROTOCOL_SENSOR);
+		ops->get_proto_priv(handle, SCMI_PROTOCOL_SENSOR);
 
 	if (!sinfo)
 		return -EINVAL;
@@ -353,12 +355,14 @@ static const struct scmi_protocol_events sensor_protocol_events = {
 	.num_events = ARRAY_SIZE(sensor_events),
 };
 
-static int scmi_sensors_protocol_init(const struct scmi_handle *handle)
+static int scmi_sensors_protocol_init(const struct scmi_handle *handle,
+				      const struct scmi_xfer_ops *xops)
 {
 	u32 version;
 	struct sensors_info *sinfo;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_SENSOR, &version);
+	ops = xops;
+	ops->version_get(handle, SCMI_PROTOCOL_SENSOR, &version);
 
 	dev_dbg(handle->dev, "Sensor Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
@@ -377,7 +381,7 @@ static int scmi_sensors_protocol_init(const struct scmi_handle *handle)
 	scmi_sensor_description_get(handle, sinfo);
 
 	sinfo->version = version;
-	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_SENSOR, sinfo);
+	return ops->set_proto_priv(handle, SCMI_PROTOCOL_SENSOR, sinfo);
 }
 
 static struct scmi_protocol scmi_sensors = {
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index ae884fc669f5..4db3cc9cea3b 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -14,6 +14,8 @@
 
 #define SCMI_SYSTEM_NUM_SOURCES		1
 
+static const struct scmi_xfer_ops *ops;
+
 enum scmi_system_protocol_cmd {
 	SYSTEM_POWER_STATE_NOTIFY = 0x5,
 };
@@ -39,7 +41,7 @@ static int scmi_system_request_notify(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_system_power_state_notify *notify;
 
-	ret = scmi_xfer_get_init(handle, SYSTEM_POWER_STATE_NOTIFY,
+	ret = ops->xfer_get_init(handle, SYSTEM_POWER_STATE_NOTIFY,
 				 SCMI_PROTOCOL_SYSTEM, sizeof(*notify), 0, &t);
 	if (ret)
 		return ret;
@@ -47,9 +49,9 @@ static int scmi_system_request_notify(const struct scmi_handle *handle,
 	notify = t->tx.buf;
 	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ops->do_xfer(handle, t);
 
-	scmi_xfer_put(handle, t);
+	ops->xfer_put(handle, t);
 	return ret;
 }
 
@@ -109,12 +111,14 @@ static const struct scmi_protocol_events system_protocol_events = {
 	.num_sources = SCMI_SYSTEM_NUM_SOURCES,
 };
 
-static int scmi_system_protocol_init(const struct scmi_handle *handle)
+static int scmi_system_protocol_init(const struct scmi_handle *handle,
+				     const struct scmi_xfer_ops *xops)
 {
 	u32 version;
 	struct scmi_system_info *pinfo;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_SYSTEM, &version);
+	ops = xops;
+	ops->version_get(handle, SCMI_PROTOCOL_SYSTEM, &version);
 
 	dev_dbg(handle->dev, "System Power Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
@@ -124,7 +128,7 @@ static int scmi_system_protocol_init(const struct scmi_handle *handle)
 		return -ENOMEM;
 
 	pinfo->version = version;
-	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_SYSTEM, pinfo);
+	return ops->set_proto_priv(handle, SCMI_PROTOCOL_SYSTEM, pinfo);
 }
 
 static struct scmi_protocol scmi_system = {
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 650d0877a5c8..da675d6f90c0 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -351,8 +351,24 @@ static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
 #define module_scmi_driver(__scmi_driver)	\
 	module_driver(__scmi_driver, scmi_register, scmi_unregister)
 
+#define scmi_load(proto) \
+	scmi_protocol_register(proto, THIS_MODULE)
+#define scmi_unload(proto) \
+	scmi_protocol_unregister(proto)
+
+/**
+ * module_scmi_protocol() - Helper macro for registering a scmi protocol
+ * @__scmi_protocol: scmi_protocol structure
+ *
+ * Helper macro for scmi drivers to set up proper module init / exit
+ * functions.  Replaces module_init() and module_exit() and keeps people from
+ * printing pointless things to the kernel log when their driver is loaded.
+ */
+#define module_scmi_protocol(__scmi_protocol)	\
+	module_driver(__scmi_protocol, scmi_load, scmi_unload)
+
 struct scmi_protocol;
-int scmi_protocol_register(struct scmi_protocol *proto);
+int scmi_protocol_register(struct scmi_protocol *proto, struct module *owner);
 void scmi_protocol_unregister(const struct scmi_protocol *proto);
 
 /* SCMI Notification API - Custom Event Reports */
-- 
2.17.1

