Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2258E2997B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgJZUKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:10:34 -0400
Received: from foss.arm.com ([217.140.110.172]:51136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730084AbgJZUKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:10:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08DA31FB;
        Mon, 26 Oct 2020 13:10:33 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A64753F68F;
        Mon, 26 Oct 2020 13:10:30 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v2 4/6] firmware: arm_scmi: add SCMIv3.0 Sensors timestamped reads
Date:   Mon, 26 Oct 2020 20:10:05 +0000
Message-Id: <20201026201007.23591-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026201007.23591-1-cristian.marussi@arm.com>
References: <20201026201007.23591-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new .reading_get_timestamped() method to sensor_ops to support SCMIv3.0
timestamped reads.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 134 ++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h       |  22 +++++
 2 files changed, 151 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 5a18f8c84bef..bdb0ed0df683 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -156,6 +156,27 @@ struct scmi_msg_sensor_reading_get {
 #define SENSOR_READ_ASYNC	BIT(0)
 };
 
+struct scmi_resp_sensor_reading_get {
+	__le64 readings;
+};
+
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
@@ -576,6 +597,21 @@ scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
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
@@ -593,18 +629,105 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 
 	sensor = t->tx.buf;
 	sensor->id = cpu_to_le32(sensor_id);
+	if (s->async) {
+		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
+		ret = scmi_do_xfer_with_response(handle, t);
+		if (!ret) {
+			struct scmi_resp_sensor_reading_complete *resp;
+
+			resp = t->rx.buf;
+			if (le32_to_cpu(resp->id) == sensor_id)
+				*value = le64_to_cpu(resp->readings);
+			else
+				ret = -EPROTO;
+		}
+	} else {
+		sensor->flags = cpu_to_le32(0);
+		ret = scmi_do_xfer(handle, t);
+		if (!ret) {
+			struct scmi_resp_sensor_reading_get *resp;
+
+			resp = t->rx.buf;
+			*value = le64_to_cpu(resp->readings);
+		}
+	}
 
+	scmi_xfer_put(handle, t);
+	return ret;
+}
+
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
 	if (s->async) {
 		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
 		ret = scmi_do_xfer_with_response(handle, t);
-		if (!ret)
-			*value = get_unaligned_le64((void *)
-						    ((__le32 *)t->rx.buf + 1));
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
 	} else {
 		sensor->flags = cpu_to_le32(0);
 		ret = scmi_do_xfer(handle, t);
-		if (!ret)
-			*value = get_unaligned_le64(t->rx.buf);
+		if (!ret) {
+			int i;
+			struct scmi_sensor_reading_le *resp_readings;
+
+			resp_readings = t->rx.buf;
+			for (i = 0; i < count; i++)
+				scmi_parse_sensor_readings(&readings[i],
+							   &resp_readings[i]);
+		}
 	}
 
 	scmi_xfer_put(handle, t);
@@ -631,6 +754,7 @@ static const struct scmi_sensor_ops sensor_ops = {
 	.info_get = scmi_sensor_info_get,
 	.trip_point_config = scmi_sensor_trip_point_config,
 	.reading_get = scmi_sensor_reading_get,
+	.reading_get_timestamped = scmi_sensor_reading_get_timestamped,
 };
 
 static int scmi_sensor_set_notify_enabled(const struct scmi_handle *handle,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 1f5c52a460bb..24d5b7ebf508 100644
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
@@ -387,6 +401,11 @@ enum scmi_sensor_class {
  * @info_get: get the information of the specified sensor
  * @trip_point_config: selects and configures a trip-point of interest
  * @reading_get: gets the current value of the sensor
+ * @reading_get_timestamped: gets the current value and timestamp, when
+ *			     available, of the sensor. (as of v2.1 spec)
+ *			     Supports multi-axis sensors for sensors which
+ *			     supports it and if the @reading array size of
+ *			     @count entry equals the sensor num_axis
  */
 struct scmi_sensor_ops {
 	int (*count_get)(const struct scmi_handle *handle);
@@ -396,6 +415,9 @@ struct scmi_sensor_ops {
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

