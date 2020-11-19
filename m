Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21912B99FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgKSRtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:49:43 -0500
Received: from foss.arm.com ([217.140.110.172]:36200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbgKSRtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:49:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1940E1396;
        Thu, 19 Nov 2020 09:49:42 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76BB23F70D;
        Thu, 19 Nov 2020 09:49:40 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 5/6] firmware: arm_scmi: add SCMIv3.0 Sensor configuration support
Date:   Thu, 19 Nov 2020 17:49:05 +0000
Message-Id: <20201119174906.43862-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119174906.43862-1-cristian.marussi@arm.com>
References: <20201119174906.43862-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCMIv3.0 Sensor support for CONFIG_GET/CONFIG_SET commands.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- dropped single field structs
---
 drivers/firmware/arm_scmi/sensors.c | 63 +++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h       | 37 +++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 2239af5f9e6e..10c271d430e7 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -23,6 +23,8 @@ enum scmi_sensor_protocol_cmd {
 	SENSOR_READING_GET = 0x6,
 	SENSOR_AXIS_DESCRIPTION_GET = 0x7,
 	SENSOR_LIST_UPDATE_INTERVALS = 0x8,
+	SENSOR_CONFIG_GET = 0x9,
+	SENSOR_CONFIG_SET = 0xA,
 };
 
 struct scmi_msg_resp_sensor_attributes {
@@ -149,6 +151,11 @@ struct scmi_msg_set_sensor_trip_point {
 	__le32 value_high;
 };
 
+struct scmi_msg_sensor_config_set {
+	__le32 id;
+	__le32 sensor_config;
+};
+
 struct scmi_msg_sensor_reading_get {
 	__le32 id;
 	__le32 flags;
@@ -592,6 +599,60 @@ scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
 	return ret;
 }
 
+static int scmi_sensor_config_get(const struct scmi_handle *handle,
+				  u32 sensor_id, u32 *sensor_config)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = scmi_xfer_get_init(handle, SENSOR_CONFIG_GET,
+				 SCMI_PROTOCOL_SENSOR, sizeof(__le32),
+				 sizeof(__le32), &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(cpu_to_le32(sensor_id), t->tx.buf);
+	ret = scmi_do_xfer(handle, t);
+	if (!ret) {
+		struct sensors_info *si = handle->sensor_priv;
+		struct scmi_sensor_info *s = si->sensors + sensor_id;
+
+		*sensor_config = get_unaligned_le64(t->rx.buf);
+		s->sensor_config = *sensor_config;
+	}
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_sensor_config_set(const struct scmi_handle *handle,
+				  u32 sensor_id, u32 sensor_config)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_sensor_config_set *msg;
+
+	ret = scmi_xfer_get_init(handle, SENSOR_CONFIG_SET,
+				 SCMI_PROTOCOL_SENSOR, sizeof(*msg), 0, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->id = cpu_to_le32(sensor_id);
+	msg->sensor_config = cpu_to_le32(sensor_config);
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret) {
+		struct sensors_info *si = handle->sensor_priv;
+		struct scmi_sensor_info *s = si->sensors + sensor_id;
+
+		s->sensor_config = sensor_config;
+	}
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
 /**
  * scmi_sensor_reading_get  - Read scalar sensor value
  * @handle: Platform handle
@@ -745,6 +806,8 @@ static const struct scmi_sensor_ops sensor_ops = {
 	.trip_point_config = scmi_sensor_trip_point_config,
 	.reading_get = scmi_sensor_reading_get,
 	.reading_get_timestamped = scmi_sensor_reading_get_timestamped,
+	.config_get = scmi_sensor_config_get,
+	.config_set = scmi_sensor_config_set,
 };
 
 static int scmi_sensor_set_notify_enabled(const struct scmi_handle *handle,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0c52bf0cbee4..7e9e2cd3d46b 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -286,7 +286,38 @@ struct scmi_sensor_info {
 	unsigned int num_axis;
 	struct scmi_sensor_axis_info *axis;
 	struct scmi_sensor_intervals_info intervals;
+	unsigned int sensor_config;
+#define SCMI_SENS_CFG_UPDATE_SECS_MASK		GENMASK(31, 16)
+#define SCMI_SENS_CFG_GET_UPDATE_SECS(x)				\
+	FIELD_GET(SCMI_SENS_CFG_UPDATE_SECS_MASK, (x))
+
+#define SCMI_SENS_CFG_UPDATE_EXP_MASK		GENMASK(15, 11)
+#define SCMI_SENS_CFG_GET_UPDATE_EXP(x)					\
+	({								\
+		int __signed_exp =					\
+			FIELD_GET(SCMI_SENS_CFG_UPDATE_EXP_MASK, (x));	\
+									\
+		if (__signed_exp & BIT(4))				\
+			__signed_exp |= GENMASK(31, 5);			\
+		__signed_exp;						\
+	})
+
+#define SCMI_SENS_CFG_ROUND_MASK		GENMASK(10, 9)
+#define SCMI_SENS_CFG_ROUND_AUTO		2
+#define SCMI_SENS_CFG_ROUND_UP			1
+#define SCMI_SENS_CFG_ROUND_DOWN		0
+
+#define SCMI_SENS_CFG_TSTAMP_ENABLED_MASK	BIT(1)
+#define SCMI_SENS_CFG_TSTAMP_ENABLE		1
+#define SCMI_SENS_CFG_TSTAMP_DISABLE		0
+#define SCMI_SENS_CFG_IS_TSTAMP_ENABLED(x)				\
+	FIELD_GET(SCMI_SENS_CFG_TSTAMP_ENABLED_MASK, (x))
+
+#define SCMI_SENS_CFG_SENSOR_ENABLED_MASK	BIT(0)
+#define SCMI_SENS_CFG_SENSOR_ENABLE		1
+#define SCMI_SENS_CFG_SENSOR_DISABLE		0
 	char name[SCMI_MAX_STR_SIZE];
+#define SCMI_SENS_CFG_IS_ENABLED(x)		FIELD_GET(BIT(0), (x))
 	bool extended_scalar_attrs;
 	unsigned int sensor_power;
 	unsigned int resolution;
@@ -409,6 +440,8 @@ enum scmi_sensor_class {
  *			     Supports multi-axis sensors for sensors which
  *			     supports it and if the @reading array size of
  *			     @count entry equals the sensor num_axis
+ * @config_get: Get sensor current configuration
+ * @config_set: Set sensor current configuration
  */
 struct scmi_sensor_ops {
 	int (*count_get)(const struct scmi_handle *handle);
@@ -421,6 +454,10 @@ struct scmi_sensor_ops {
 	int (*reading_get_timestamped)(const struct scmi_handle *handle,
 				       u32 sensor_id, u8 count,
 				       struct scmi_sensor_reading *readings);
+	int (*config_get)(const struct scmi_handle *handle,
+			  u32 sensor_id, u32 *sensor_config);
+	int (*config_set)(const struct scmi_handle *handle,
+			  u32 sensor_id, u32 sensor_config);
 };
 
 /**
-- 
2.17.1

