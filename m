Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C83628E2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgJNPHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:07:00 -0400
Received: from foss.arm.com ([217.140.110.172]:50842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728634AbgJNPG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:06:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 424F513D5;
        Wed, 14 Oct 2020 08:06:57 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 823703F71F;
        Wed, 14 Oct 2020 08:06:55 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 02/11] firmware: arm_scmi: hide protocols' private data
Date:   Wed, 14 Oct 2020 16:05:36 +0100
Message-Id: <20201014150545.44807-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014150545.44807-1-cristian.marussi@arm.com>
References: <20201014150545.44807-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protocols private data were meant to be used exclusively by protocol code
but they are currently exposed through the handle, so available also to
SCMI drivers: move them away from handle into instance specific data and
provide internal helpers to let protocols implementation set/get their own
private data from protocol code.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c   | 12 +++++-----
 drivers/firmware/arm_scmi/common.h  |  4 ++++
 drivers/firmware/arm_scmi/driver.c  | 32 +++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/perf.c    | 34 ++++++++++++++++++-----------
 drivers/firmware/arm_scmi/power.c   | 10 ++++-----
 drivers/firmware/arm_scmi/reset.c   | 16 ++++++++------
 drivers/firmware/arm_scmi/sensors.c | 13 ++++++-----
 drivers/firmware/arm_scmi/system.c  |  4 +---
 include/linux/scmi_protocol.h       | 17 ---------------
 9 files changed, 86 insertions(+), 56 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 94bcad9a7d19..4e8dafc36d7e 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -240,7 +240,8 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
 	u32 flags = 0;
 	struct scmi_xfer *t;
 	struct scmi_clock_set_rate *cfg;
-	struct clock_info *ci = handle->clk_priv;
+	struct clock_info *ci =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_CLOCK);
 
 	ret = scmi_xfer_get_init(handle, CLOCK_RATE_SET, SCMI_PROTOCOL_CLOCK,
 				 sizeof(*cfg), 0, &t);
@@ -303,7 +304,8 @@ static int scmi_clock_disable(const struct scmi_handle *handle, u32 clk_id)
 
 static int scmi_clock_count_get(const struct scmi_handle *handle)
 {
-	struct clock_info *ci = handle->clk_priv;
+	struct clock_info *ci =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_CLOCK);
 
 	return ci->num_clocks;
 }
@@ -311,7 +313,8 @@ static int scmi_clock_count_get(const struct scmi_handle *handle)
 static const struct scmi_clock_info *
 scmi_clock_info_get(const struct scmi_handle *handle, u32 clk_id)
 {
-	struct clock_info *ci = handle->clk_priv;
+	struct clock_info *ci =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_CLOCK);
 	struct scmi_clock_info *clk = ci->clk + clk_id;
 
 	if (!clk->name[0])
@@ -361,9 +364,8 @@ static int scmi_clock_protocol_init(struct scmi_handle *handle)
 
 	cinfo->version = version;
 	handle->clk_ops = &clk_ops;
-	handle->clk_priv = cinfo;
 
-	return 0;
+	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_CLOCK, cinfo);
 }
 
 static struct scmi_protocol scmi_clock = {
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index b08a8ddbc22a..de2f22032a57 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -205,6 +205,10 @@ const struct scmi_protocol *scmi_get_protocol(int protocol_id);
 int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id);
 void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id);
 
+void *scmi_get_proto_priv(const struct scmi_handle *h, u8 prot);
+int scmi_set_proto_priv(const struct scmi_handle *handle, const u8 proto,
+			void *priv);
+
 /* SCMI Transport */
 /**
  * struct scmi_chan_info - Structure representing a SCMI channel information
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 7de994e49884..bad1d0130e96 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -100,6 +100,10 @@ struct scmi_protocol_instance {
  *	       this SCMI instance: populated on protocol's first attempted
  *	       usage.
  * @protocols_mtx: A mutex to protect protocols instances initialization.
+ * @protocols_private_data: An array of per-protocol per-instance private
+ *			    data: populated by protocol's initialization
+ *			    routines when @protocols is still not filled, so
+ *			    they have to sit on their own.
  * @protocols_imp: List of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
  * @node: List head
@@ -117,6 +121,7 @@ struct scmi_info {
 	struct scmi_protocol_instance *protocols[SCMI_MAX_PROTO];
 	/* Ensure mutual exclusive access to protocols instance array */
 	struct mutex protocols_mtx;
+	void *protocols_private_data[SCMI_MAX_PROTO];
 	u8 *protocols_imp;
 	struct list_head node;
 	int users;
@@ -542,6 +547,32 @@ int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
 	return ret;
 }
 
+int scmi_set_proto_priv(const struct scmi_handle *handle,
+			u8 protocol_id, void *priv)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	/* Ensure protocols_private_data has been updated */
+	smp_rmb();
+	if (WARN_ON(info->protocols_private_data[protocol_id]))
+		return -EINVAL;
+
+	info->protocols_private_data[protocol_id] = priv;
+	/* Ensure updated protocol private date are visible */
+	smp_wmb();
+
+	return 0;
+}
+
+void *scmi_get_proto_priv(const struct scmi_handle *handle, u8 protocol_id)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	/* Ensure protocols_private_data has been updated */
+	smp_rmb();
+	return info->protocols_private_data[protocol_id];
+}
+
 /**
  * scmi_get_protocol_instance  - Protocol initialization helper.
  * @handle: A reference to the SCMI platform instance.
@@ -657,6 +688,7 @@ void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
 		if (pi->proto->deinit)
 			pi->proto->deinit(handle);
 
+		info->protocols_private_data[protocol_id] = NULL;
 		info->protocols[protocol_id] = NULL;
 		/* Ensure deinitialized protocol is visible */
 		smp_wmb();
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 854460a051c2..13e215f359fb 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -379,7 +379,8 @@ static int scmi_perf_mb_limits_set(const struct scmi_handle *handle, u32 domain,
 static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
 				u32 max_perf, u32 min_perf)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = scmi_get_proto_priv(handle,
+							SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	if (dom->fc_info && dom->fc_info->limit_set_addr) {
@@ -421,7 +422,8 @@ static int scmi_perf_mb_limits_get(const struct scmi_handle *handle, u32 domain,
 static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
 				u32 *max_perf, u32 *min_perf)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	if (dom->fc_info && dom->fc_info->limit_get_addr) {
@@ -459,7 +461,8 @@ static int scmi_perf_mb_level_set(const struct scmi_handle *handle, u32 domain,
 static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
 			       u32 level, bool poll)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	if (dom->fc_info && dom->fc_info->level_set_addr) {
@@ -496,7 +499,8 @@ static int scmi_perf_mb_level_get(const struct scmi_handle *handle, u32 domain,
 static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
 			       u32 *level, bool poll)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	if (dom->fc_info && dom->fc_info->level_get_addr) {
@@ -647,7 +651,8 @@ static int scmi_dvfs_device_opps_add(const struct scmi_handle *handle,
 	unsigned long freq;
 	struct scmi_opp *opp;
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 
 	domain = scmi_dev_domain_id(dev);
 	if (domain < 0)
@@ -676,7 +681,8 @@ static int scmi_dvfs_transition_latency_get(const struct scmi_handle *handle,
 					    struct device *dev)
 {
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	int domain = scmi_dev_domain_id(dev);
 
 	if (domain < 0)
@@ -690,7 +696,8 @@ static int scmi_dvfs_transition_latency_get(const struct scmi_handle *handle,
 static int scmi_dvfs_freq_set(const struct scmi_handle *handle, u32 domain,
 			      unsigned long freq, bool poll)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	return scmi_perf_level_set(handle, domain, freq / dom->mult_factor,
@@ -702,7 +709,8 @@ static int scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
 {
 	int ret;
 	u32 level;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	ret = scmi_perf_level_get(handle, domain, &level, poll);
@@ -715,7 +723,8 @@ static int scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
 static int scmi_dvfs_est_power_get(const struct scmi_handle *handle, u32 domain,
 				   unsigned long *freq, unsigned long *power)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 	struct perf_dom_info *dom;
 	unsigned long opp_freq;
 	int idx, ret = -EINVAL;
@@ -743,7 +752,8 @@ static bool scmi_fast_switch_possible(const struct scmi_handle *handle,
 				      struct device *dev)
 {
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_PERF);
 
 	dom = pi->dom_info + scmi_dev_domain_id(dev);
 
@@ -887,9 +897,7 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
 
 	pinfo->version = version;
 	handle->perf_ops = &perf_ops;
-	handle->perf_priv = pinfo;
-
-	return 0;
+	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_PERF, pinfo);
 }
 
 static struct scmi_protocol scmi_perf = {
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 42c9c88da07c..e0b29ed4e09a 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -171,14 +171,16 @@ scmi_power_state_get(const struct scmi_handle *handle, u32 domain, u32 *state)
 
 static int scmi_power_num_domains_get(const struct scmi_handle *handle)
 {
-	struct scmi_power_info *pi = handle->power_priv;
+	struct scmi_power_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_POWER);
 
 	return pi->num_domains;
 }
 
 static char *scmi_power_name_get(const struct scmi_handle *handle, u32 domain)
 {
-	struct scmi_power_info *pi = handle->power_priv;
+	struct scmi_power_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_POWER);
 	struct power_dom_info *dom = pi->dom_info + domain;
 
 	return dom->name;
@@ -296,9 +298,7 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
 
 	pinfo->version = version;
 	handle->power_ops = &power_ops;
-	handle->power_priv = pinfo;
-
-	return 0;
+	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_POWER, pinfo);
 }
 
 static struct scmi_protocol scmi_power = {
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 2caf0bdb6fdc..f70e9b5108d5 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -121,14 +121,16 @@ scmi_reset_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 
 static int scmi_reset_num_domains_get(const struct scmi_handle *handle)
 {
-	struct scmi_reset_info *pi = handle->reset_priv;
+	struct scmi_reset_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_RESET);
 
 	return pi->num_domains;
 }
 
 static char *scmi_reset_name_get(const struct scmi_handle *handle, u32 domain)
 {
-	struct scmi_reset_info *pi = handle->reset_priv;
+	struct scmi_reset_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_RESET);
 	struct reset_dom_info *dom = pi->dom_info + domain;
 
 	return dom->name;
@@ -136,7 +138,8 @@ static char *scmi_reset_name_get(const struct scmi_handle *handle, u32 domain)
 
 static int scmi_reset_latency_get(const struct scmi_handle *handle, u32 domain)
 {
-	struct scmi_reset_info *pi = handle->reset_priv;
+	struct scmi_reset_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_RESET);
 	struct reset_dom_info *dom = pi->dom_info + domain;
 
 	return dom->latency_us;
@@ -148,7 +151,8 @@ static int scmi_domain_reset(const struct scmi_handle *handle, u32 domain,
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_reset_domain_reset *dom;
-	struct scmi_reset_info *pi = handle->reset_priv;
+	struct scmi_reset_info *pi =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_RESET);
 	struct reset_dom_info *rdom = pi->dom_info + domain;
 
 	if (rdom->async_reset)
@@ -306,9 +310,7 @@ static int scmi_reset_protocol_init(struct scmi_handle *handle)
 
 	pinfo->version = version;
 	handle->reset_ops = &reset_ops;
-	handle->reset_priv = pinfo;
-
-	return 0;
+	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_RESET, pinfo);
 }
 
 static struct scmi_protocol scmi_reset = {
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index dfe3076d2093..8a0a599558ba 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -233,7 +233,8 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_reading_get *sensor;
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_SENSOR);
 	struct scmi_sensor_info *s = si->sensors + sensor_id;
 
 	ret = scmi_xfer_get_init(handle, SENSOR_READING_GET,
@@ -265,14 +266,16 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 static const struct scmi_sensor_info *
 scmi_sensor_info_get(const struct scmi_handle *handle, u32 sensor_id)
 {
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_SENSOR);
 
 	return si->sensors + sensor_id;
 }
 
 static int scmi_sensor_count_get(const struct scmi_handle *handle)
 {
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si =
+		scmi_get_proto_priv(handle, SCMI_PROTOCOL_SENSOR);
 
 	return si->num_sensors;
 }
@@ -362,9 +365,7 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 
 	sinfo->version = version;
 	handle->sensor_ops = &sensor_ops;
-	handle->sensor_priv = sinfo;
-
-	return 0;
+	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_SENSOR, sinfo);
 }
 
 static struct scmi_protocol scmi_sensors = {
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index bcea18bf54ab..8f53f93c63ca 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -123,9 +123,7 @@ static int scmi_system_protocol_init(struct scmi_handle *handle)
 				      SCMI_SYSTEM_NUM_SOURCES);
 
 	pinfo->version = version;
-	handle->system_priv = pinfo;
-
-	return 0;
+	return scmi_set_proto_priv(handle, SCMI_PROTOCOL_SYSTEM, pinfo);
 }
 
 static struct scmi_protocol scmi_system = {
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index ca23d682941e..bc4f06d46bfb 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -263,16 +263,6 @@ struct scmi_notify_ops {
  * @sensor_ops: pointer to set of sensor protocol operations
  * @reset_ops: pointer to set of reset protocol operations
  * @notify_ops: pointer to set of notifications related operations
- * @perf_priv: pointer to private data structure specific to performance
- *	protocol(for internal use only)
- * @clk_priv: pointer to private data structure specific to clock
- *	protocol(for internal use only)
- * @power_priv: pointer to private data structure specific to power
- *	protocol(for internal use only)
- * @sensor_priv: pointer to private data structure specific to sensors
- *	protocol(for internal use only)
- * @reset_priv: pointer to private data structure specific to reset
- *	protocol(for internal use only)
  * @notify_priv: pointer to private data structure specific to notifications
  *	(for internal use only)
  */
@@ -285,14 +275,7 @@ struct scmi_handle {
 	const struct scmi_sensor_ops *sensor_ops;
 	const struct scmi_reset_ops *reset_ops;
 	const struct scmi_notify_ops *notify_ops;
-	/* for protocol internal use */
-	void *perf_priv;
-	void *clk_priv;
-	void *power_priv;
-	void *sensor_priv;
-	void *reset_priv;
 	void *notify_priv;
-	void *system_priv;
 };
 
 enum scmi_std_protocol {
-- 
2.17.1

