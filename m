Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844692CC81F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbgLBUmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:49 -0500
Received: from foss.arm.com ([217.140.110.172]:50616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388381AbgLBUmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A87D152F;
        Wed,  2 Dec 2020 12:41:02 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36EA93F575;
        Wed,  2 Dec 2020 12:41:00 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 18/37] firmware: arm_scmi: port Clock protocol to new protocols interface
Date:   Wed,  2 Dec 2020 20:39:50 +0000
Message-Id: <20201202204009.32073-19-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert internals of protocol implementation to use protocol handles and
expose a new protocol operations interface for SCMI driver using the new
get/put common operations, while keeping the old handle->clk_ops still
around to ease transition.

Remove handle->clock_priv now unused.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 182 ++++++++++++++++++++----------
 include/linux/scmi_protocol.h     |  20 +++-
 2 files changed, 139 insertions(+), 63 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index e8c84cff9922..bf7dcd537fce 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -74,52 +74,53 @@ struct clock_info {
 	struct scmi_clock_info *clk;
 };
 
-static int scmi_clock_protocol_attributes_get(const struct scmi_handle *handle,
-					      struct clock_info *ci)
+static int
+scmi_clock_protocol_attributes_get(const struct scmi_protocol_handle *ph,
+				   struct clock_info *ci)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_clock_protocol_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
-				 SCMI_PROTOCOL_CLOCK, 0, sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
+				      0, sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		ci->num_clocks = le16_to_cpu(attr->num_clocks);
 		ci->max_async_req = attr->max_async_req;
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_clock_attributes_get(const struct scmi_handle *handle,
+static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 				     u32 clk_id, struct scmi_clock_info *clk)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_clock_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, CLOCK_ATTRIBUTES, SCMI_PROTOCOL_CLOCK,
-				 sizeof(clk_id), sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, CLOCK_ATTRIBUTES,
+				      sizeof(clk_id), sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(clk_id, t->tx.buf);
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		strlcpy(clk->name, attr->name, SCMI_MAX_STR_SIZE);
 	else
 		clk->name[0] = '\0';
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
@@ -136,7 +137,7 @@ static int rate_cmp_func(const void *_r1, const void *_r2)
 }
 
 static int
-scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
+scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
 			      struct scmi_clock_info *clk)
 {
 	u64 *rate = NULL;
@@ -148,8 +149,8 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 	struct scmi_msg_clock_describe_rates *clk_desc;
 	struct scmi_msg_resp_clock_describe_rates *rlist;
 
-	ret = scmi_xfer_get_init(handle, CLOCK_DESCRIBE_RATES,
-				 SCMI_PROTOCOL_CLOCK, sizeof(*clk_desc), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, CLOCK_DESCRIBE_RATES,
+				      sizeof(*clk_desc), 0, &t);
 	if (ret)
 		return ret;
 
@@ -161,7 +162,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 		/* Set the number of rates to be skipped/already read */
 		clk_desc->rate_index = cpu_to_le32(tot_rate_cnt);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 		if (ret)
 			goto err;
 
@@ -171,7 +172,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 		num_returned = NUM_RETURNED(rates_flag);
 
 		if (tot_rate_cnt + num_returned > SCMI_MAX_NUM_RATES) {
-			dev_err(handle->dev, "No. of rates > MAX_NUM_RATES");
+			dev_err(ph->dev, "No. of rates > MAX_NUM_RATES");
 			break;
 		}
 
@@ -179,7 +180,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 			clk->range.min_rate = RATE_TO_U64(rlist->rate[0]);
 			clk->range.max_rate = RATE_TO_U64(rlist->rate[1]);
 			clk->range.step_size = RATE_TO_U64(rlist->rate[2]);
-			dev_dbg(handle->dev, "Min %llu Max %llu Step %llu Hz\n",
+			dev_dbg(ph->dev, "Min %llu Max %llu Step %llu Hz\n",
 				clk->range.min_rate, clk->range.max_rate,
 				clk->range.step_size);
 			break;
@@ -188,12 +189,12 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 		rate = &clk->list.rates[tot_rate_cnt];
 		for (cnt = 0; cnt < num_returned; cnt++, rate++) {
 			*rate = RATE_TO_U64(rlist->rate[cnt]);
-			dev_dbg(handle->dev, "Rate %llu Hz\n", *rate);
+			dev_dbg(ph->dev, "Rate %llu Hz\n", *rate);
 		}
 
 		tot_rate_cnt += num_returned;
 
-		scmi_reset_rx_to_maxsz(handle, t);
+		ph->xops->reset_rx_to_maxsz(ph, t);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
@@ -208,42 +209,52 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 	clk->rate_discrete = rate_discrete;
 
 err:
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
 static int
-scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
+scmi_clock_rate_get(const struct scmi_protocol_handle *ph,
+		    u32 clk_id, u64 *value)
 {
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, CLOCK_RATE_GET, SCMI_PROTOCOL_CLOCK,
-				 sizeof(__le32), sizeof(u64), &t);
+	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_GET,
+				      sizeof(__le32), sizeof(u64), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(clk_id, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		*value = get_unaligned_le64(t->rx.buf);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
-			       u64 rate)
+static int
+__scmi_clock_rate_get(const struct scmi_handle *handle,
+		      u32 clk_id, u64 *value)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_CLOCK);
+
+	return scmi_clock_rate_get(ph, clk_id, value);
+}
+
+static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
+			       u32 clk_id, u64 rate)
 {
 	int ret;
 	u32 flags = 0;
 	struct scmi_xfer *t;
 	struct scmi_clock_set_rate *cfg;
-	struct clock_info *ci = handle->clk_priv;
+	struct clock_info *ci = ph->get_priv(ph);
 
-	ret = scmi_xfer_get_init(handle, CLOCK_RATE_SET, SCMI_PROTOCOL_CLOCK,
-				 sizeof(*cfg), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
 
@@ -258,26 +269,36 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
 	cfg->value_high = cpu_to_le32(rate >> 32);
 
 	if (flags & CLOCK_SET_ASYNC)
-		ret = scmi_do_xfer_with_response(handle, t);
+		ret = ph->xops->do_xfer_with_response(ph, t);
 	else
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 
 	if (ci->max_async_req)
 		atomic_dec(&ci->cur_async_req);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
+static int __scmi_clock_rate_set(const struct scmi_handle *handle,
+				 u32 clk_id, u64 rate)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_CLOCK);
+
+	return scmi_clock_rate_set(ph, clk_id, rate);
+}
+
 static int
-scmi_clock_config_set(const struct scmi_handle *handle, u32 clk_id, u32 config)
+scmi_clock_config_set(const struct scmi_protocol_handle *ph, u32 clk_id,
+		      u32 config)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_clock_set_config *cfg;
 
-	ret = scmi_xfer_get_init(handle, CLOCK_CONFIG_SET, SCMI_PROTOCOL_CLOCK,
-				 sizeof(*cfg), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, CLOCK_CONFIG_SET,
+				      sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
 
@@ -285,33 +306,57 @@ scmi_clock_config_set(const struct scmi_handle *handle, u32 clk_id, u32 config)
 	cfg->id = cpu_to_le32(clk_id);
 	cfg->attributes = cpu_to_le32(config);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_clock_enable(const struct scmi_handle *handle, u32 clk_id)
+static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id)
+{
+	return scmi_clock_config_set(ph, clk_id, CLOCK_ENABLE);
+}
+
+static int __scmi_clock_enable(const struct scmi_handle *handle, u32 clk_id)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_CLOCK);
+
+	return scmi_clock_enable(ph, clk_id);
+}
+
+static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id)
 {
-	return scmi_clock_config_set(handle, clk_id, CLOCK_ENABLE);
+	return scmi_clock_config_set(ph, clk_id, 0);
 }
 
-static int scmi_clock_disable(const struct scmi_handle *handle, u32 clk_id)
+static int __scmi_clock_disable(const struct scmi_handle *handle, u32 clk_id)
 {
-	return scmi_clock_config_set(handle, clk_id, 0);
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_CLOCK);
+
+	return scmi_clock_disable(ph, clk_id);
 }
 
-static int scmi_clock_count_get(const struct scmi_handle *handle)
+static int scmi_clock_count_get(const struct scmi_protocol_handle *ph)
 {
-	struct clock_info *ci = handle->clk_priv;
+	struct clock_info *ci = ph->get_priv(ph);
 
 	return ci->num_clocks;
 }
 
+static int __scmi_clock_count_get(const struct scmi_handle *handle)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_CLOCK);
+
+	return scmi_clock_count_get(ph);
+}
+
 static const struct scmi_clock_info *
-scmi_clock_info_get(const struct scmi_handle *handle, u32 clk_id)
+scmi_clock_info_get(const struct scmi_protocol_handle *ph, u32 clk_id)
 {
-	struct clock_info *ci = handle->clk_priv;
+	struct clock_info *ci = ph->get_priv(ph);
 	struct scmi_clock_info *clk = ci->clk + clk_id;
 
 	if (!clk->name[0])
@@ -320,7 +365,25 @@ scmi_clock_info_get(const struct scmi_handle *handle, u32 clk_id)
 	return clk;
 }
 
+static const struct scmi_clock_info *
+__scmi_clock_info_get(const struct scmi_handle *handle, u32 clk_id)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_CLOCK);
+
+	return scmi_clock_info_get(ph, clk_id);
+}
+
 static const struct scmi_clk_ops clk_ops = {
+	.count_get = __scmi_clock_count_get,
+	.info_get = __scmi_clock_info_get,
+	.rate_get = __scmi_clock_rate_get,
+	.rate_set = __scmi_clock_rate_set,
+	.enable = __scmi_clock_enable,
+	.disable = __scmi_clock_disable,
+};
+
+static const struct scmi_clk_proto_ops clk_proto_ops = {
 	.count_get = scmi_clock_count_get,
 	.info_get = scmi_clock_info_get,
 	.rate_get = scmi_clock_rate_get,
@@ -329,24 +392,25 @@ static const struct scmi_clk_ops clk_ops = {
 	.disable = scmi_clock_disable,
 };
 
-static int scmi_clock_protocol_init(struct scmi_handle *handle)
+static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	u32 version;
 	int clkid, ret;
 	struct clock_info *cinfo;
+	struct scmi_handle *handle;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_CLOCK, &version);
+	ph->xops->version_get(ph, &version);
 
-	dev_dbg(handle->dev, "Clock Version %d.%d\n",
+	dev_dbg(ph->dev, "Clock Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
 
-	cinfo = devm_kzalloc(handle->dev, sizeof(*cinfo), GFP_KERNEL);
+	cinfo = devm_kzalloc(ph->dev, sizeof(*cinfo), GFP_KERNEL);
 	if (!cinfo)
 		return -ENOMEM;
 
-	scmi_clock_protocol_attributes_get(handle, cinfo);
+	scmi_clock_protocol_attributes_get(ph, cinfo);
 
-	cinfo->clk = devm_kcalloc(handle->dev, cinfo->num_clocks,
+	cinfo->clk = devm_kcalloc(ph->dev, cinfo->num_clocks,
 				  sizeof(*cinfo->clk), GFP_KERNEL);
 	if (!cinfo->clk)
 		return -ENOMEM;
@@ -354,22 +418,24 @@ static int scmi_clock_protocol_init(struct scmi_handle *handle)
 	for (clkid = 0; clkid < cinfo->num_clocks; clkid++) {
 		struct scmi_clock_info *clk = cinfo->clk + clkid;
 
-		ret = scmi_clock_attributes_get(handle, clkid, clk);
+		ret = scmi_clock_attributes_get(ph, clkid, clk);
 		if (!ret)
-			scmi_clock_describe_rates_get(handle, clkid, clk);
+			scmi_clock_describe_rates_get(ph, clkid, clk);
 	}
 
 	cinfo->version = version;
+
+	/* Transient code for legacy ops interface */
+	handle = scmi_map_scmi_handle(ph);
 	handle->clk_ops = &clk_ops;
-	handle->clk_priv = cinfo;
 
-	return 0;
+	return ph->set_priv(ph, cinfo);
 }
 
 static const struct scmi_protocol scmi_clock = {
 	.id = SCMI_PROTOCOL_CLOCK,
-	.init = &scmi_clock_protocol_init,
-	.ops = &clk_ops,
+	.init_instance = &scmi_clock_protocol_init,
+	.ops = &clk_proto_ops,
 };
 
 DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(clock, scmi_clock)
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 294bab80b74b..d18d5510986e 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -61,7 +61,7 @@ struct scmi_device;
 struct scmi_protocol_handle;
 
 /**
- * struct scmi_clk_ops - represents the various operations provided
+ * struct scmi_clk_proto_ops - represents the various operations provided
  *	by SCMI Clock Protocol
  *
  * @count_get: get the count of clocks provided by SCMI
@@ -71,8 +71,21 @@ struct scmi_protocol_handle;
  * @enable: enables the specified clock
  * @disable: disables the specified clock
  */
+struct scmi_clk_proto_ops {
+	int (*count_get)(const struct scmi_protocol_handle *ph);
+
+	const struct scmi_clock_info *(*info_get)
+		(const struct scmi_protocol_handle *ph, u32 clk_id);
+	int (*rate_get)(const struct scmi_protocol_handle *ph, u32 clk_id,
+			u64 *rate);
+	int (*rate_set)(const struct scmi_protocol_handle *ph, u32 clk_id,
+			u64 rate);
+	int (*enable)(const struct scmi_protocol_handle *ph, u32 clk_id);
+	int (*disable)(const struct scmi_protocol_handle *ph, u32 clk_id);
+};
+
 struct scmi_clk_ops {
-	int (*count_get)(const struct scmi_handle *handle);
+	int (*count_get)(const struct scmi_handle *hamdle);
 
 	const struct scmi_clock_info *(*info_get)
 		(const struct scmi_handle *handle, u32 clk_id);
@@ -612,8 +625,6 @@ struct scmi_notify_ops {
  *	     dedicated protocol handler
  * @put_ops: method to release a protocol
  * @notify_ops: pointer to set of notifications related operations
- * @clk_priv: pointer to private data structure specific to clock
- *	protocol(for internal use only)
  * @sensor_priv: pointer to private data structure specific to sensors
  *	protocol(for internal use only)
  * @reset_priv: pointer to private data structure specific to reset
@@ -643,7 +654,6 @@ struct scmi_handle {
 
 	const struct scmi_notify_ops *notify_ops;
 	/* for protocol internal use */
-	void *clk_priv;
 	void *sensor_priv;
 	void *reset_priv;
 	void *voltage_priv;
-- 
2.17.1

