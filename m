Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4684E2B99FC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgKSRtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:49:41 -0500
Received: from foss.arm.com ([217.140.110.172]:36184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbgKSRtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:49:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FD0615EC;
        Thu, 19 Nov 2020 09:49:40 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA6D3F70D;
        Thu, 19 Nov 2020 09:49:38 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 4/6] firmware: arm_scmi: add SCMIv3.0 Sensors timestamped reads
Date:   Thu, 19 Nov 2020 17:49:04 +0000
Message-Id: <20201119174906.43862-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119174906.43862-1-cristian.marussi@arm.com>
References: <20201119174906.43862-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new .reading_get_timestamped() method to sensor_ops to support SCMIv3.0
timestamped reads.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- dropped single field struct

V2 --> v3
- setting rx_size to 0 in sensor_reading_get to allow fw to send
  both v2 and v3 replies...even if sensor_reading_get() only handles
  v2 spec and returns one single value
- using get_unaligned_le64 in lieu of le64_to_cpu
- removed refs to v2.1
---
 drivers/firmware/arm_scmi/sensors.c | 127 ++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h       |  22 +++++
 2 files changed, 143 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index a85827f60a02..2239af5f9e6e 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -155,6 +155,23 @@ struct scmi_msg_sensor_reading_get {
 #define SENSOR_READ_ASYNC	BIT(0)
 };
 
+struct scmi_resp_sensor_reading_complete {
+	__le32 id;
+	__le64 readings;
+};
+
+struct scmi_sensor_reading_le {
+	__le32 sensor_value_low;
+	__le32 sensor_value_high;
+	__le32 timestamp_low;
+	__le32 timestamp_high;
+};
+
+struct scmi_resp_sensor_reading_complete_v3 {
+	__le32 id;
+	struct scmi_sensor_reading_le readings[];
+};
+
 struct scmi_sensor_trip_notify_payld {
 	__le32 agent_id;
 	__le32 sensor_id;
@@ -575,6 +592,21 @@ scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
 	return ret;
 }
 
+/**
+ * scmi_sensor_reading_get  - Read scalar sensor value
+ * @handle: Platform handle
+ * @sensor_id: Sensor ID
+ * @value: The 64bit value sensor reading
+ *
+ * This function returns a single 64 bit reading value representing the sensor
+ * value; if the platform SCMI Protocol implementation and the sensor support
+ * multiple axis and timestamped-reads, this just returns the first axis while
+ * dropping the timestamp value.
+ * Use instead the @scmi_sensor_reading_get_timestamped to retrieve the array of
+ * timestamped multi-axis values.
+ *
+ * Return: 0 on Success
+ */
 static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 				   u32 sensor_id, u64 *value)
 {
@@ -585,20 +617,24 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 	struct scmi_sensor_info *s = si->sensors + sensor_id;
 
 	ret = scmi_xfer_get_init(handle, SENSOR_READING_GET,
-				 SCMI_PROTOCOL_SENSOR, sizeof(*sensor),
-				 sizeof(u64), &t);
+				 SCMI_PROTOCOL_SENSOR, sizeof(*sensor), 0, &t);
 	if (ret)
 		return ret;
 
 	sensor = t->tx.buf;
 	sensor->id = cpu_to_le32(sensor_id);
-
 	if (s->async) {
 		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
 		ret = scmi_do_xfer_with_response(handle, t);
-		if (!ret)
-			*value = get_unaligned_le64((void *)
-						    ((__le32 *)t->rx.buf + 1));
+		if (!ret) {
+			struct scmi_resp_sensor_reading_complete *resp;
+
+			resp = t->rx.buf;
+			if (le32_to_cpu(resp->id) == sensor_id)
+				*value = get_unaligned_le64(&resp->readings);
+			else
+				ret = -EPROTO;
+		}
 	} else {
 		sensor->flags = cpu_to_le32(0);
 		ret = scmi_do_xfer(handle, t);
@@ -610,6 +646,84 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 	return ret;
 }
 
+static inline void
+scmi_parse_sensor_readings(struct scmi_sensor_reading *out,
+			   const struct scmi_sensor_reading_le *in)
+{
+	out->value = get_unaligned_le64((void *)&in->sensor_value_low);
+	out->timestamp = get_unaligned_le64((void *)&in->timestamp_low);
+}
+
+/**
+ * scmi_sensor_reading_get_timestamped  - Read multiple-axis timestamped values
+ * @handle: Platform handle
+ * @sensor_id: Sensor ID
+ * @count: The length of the provided @readings array
+ * @readings: An array of elements each representing a timestamped per-axis
+ *	      reading of type @struct scmi_sensor_reading.
+ *	      Returned readings are ordered as the @axis descriptors array
+ *	      included in @struct scmi_sensor_info and the max number of
+ *	      returned elements is min(@count, @num_axis); ideally the provided
+ *	      array should be of length @count equal to @num_axis.
+ *
+ * Return: 0 on Success
+ */
+static int
+scmi_sensor_reading_get_timestamped(const struct scmi_handle *handle,
+				    u32 sensor_id, u8 count,
+				    struct scmi_sensor_reading *readings)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_sensor_reading_get *sensor;
+	struct sensors_info *si = handle->sensor_priv;
+	struct scmi_sensor_info *s = si->sensors + sensor_id;
+
+	if (!count || !readings ||
+	    (!s->num_axis && count > 1) || (s->num_axis && count > s->num_axis))
+		return -EINVAL;
+
+	ret = scmi_xfer_get_init(handle, SENSOR_READING_GET,
+				 SCMI_PROTOCOL_SENSOR, sizeof(*sensor), 0, &t);
+	if (ret)
+		return ret;
+
+	sensor = t->tx.buf;
+	sensor->id = cpu_to_le32(sensor_id);
+	if (s->async) {
+		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
+		ret = scmi_do_xfer_with_response(handle, t);
+		if (!ret) {
+			int i;
+			struct scmi_resp_sensor_reading_complete_v3 *resp;
+
+			resp = t->rx.buf;
+			/* Retrieve only the number of requested axis anyway */
+			if (le32_to_cpu(resp->id) == sensor_id)
+				for (i = 0; i < count; i++)
+					scmi_parse_sensor_readings(&readings[i],
+								   &resp->readings[i]);
+			else
+				ret = -EPROTO;
+		}
+	} else {
+		sensor->flags = cpu_to_le32(0);
+		ret = scmi_do_xfer(handle, t);
+		if (!ret) {
+			int i;
+			struct scmi_sensor_reading_le *resp_readings;
+
+			resp_readings = t->rx.buf;
+			for (i = 0; i < count; i++)
+				scmi_parse_sensor_readings(&readings[i],
+							   &resp_readings[i]);
+		}
+	}
+
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
 static const struct scmi_sensor_info *
 scmi_sensor_info_get(const struct scmi_handle *handle, u32 sensor_id)
 {
@@ -630,6 +744,7 @@ static const struct scmi_sensor_ops sensor_ops = {
 	.info_get = scmi_sensor_info_get,
 	.trip_point_config = scmi_sensor_trip_point_config,
 	.reading_get = scmi_sensor_reading_get,
+	.reading_get_timestamped = scmi_sensor_reading_get_timestamped,
 };
 
 static int scmi_sensor_set_notify_enabled(const struct scmi_handle *handle,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0792b0be25a3..0c52bf0cbee4 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -149,6 +149,20 @@ struct scmi_power_ops {
 			 u32 *state);
 };
 
+/**
+ * scmi_sensor_reading  - represent a timestamped read
+ *
+ * Used by @reading_get_timestamped method.
+ *
+ * @value: The signed value sensor read.
+ * @timestamp: An unsigned timestamp for the sensor read, as provided by
+ *	       SCMI platform. Set to zero when not available.
+ */
+struct scmi_sensor_reading {
+	long long value;
+	unsigned long long timestamp;
+};
+
 /**
  * scmi_range_attrs  - specifies a sensor or axis values' range
  * @min_range: The minimum value which can be represented by the sensor/axis.
@@ -390,6 +404,11 @@ enum scmi_sensor_class {
  * @info_get: get the information of the specified sensor
  * @trip_point_config: selects and configures a trip-point of interest
  * @reading_get: gets the current value of the sensor
+ * @reading_get_timestamped: gets the current value and timestamp, when
+ *			     available, of the sensor. (as of v3.0 spec)
+ *			     Supports multi-axis sensors for sensors which
+ *			     supports it and if the @reading array size of
+ *			     @count entry equals the sensor num_axis
  */
 struct scmi_sensor_ops {
 	int (*count_get)(const struct scmi_handle *handle);
@@ -399,6 +418,9 @@ struct scmi_sensor_ops {
 				 u32 sensor_id, u8 trip_id, u64 trip_value);
 	int (*reading_get)(const struct scmi_handle *handle, u32 sensor_id,
 			   u64 *value);
+	int (*reading_get_timestamped)(const struct scmi_handle *handle,
+				       u32 sensor_id, u8 count,
+				       struct scmi_sensor_reading *readings);
 };
 
 /**
-- 
2.17.1

