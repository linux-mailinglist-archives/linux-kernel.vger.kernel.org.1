Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6952B2CC821
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbgLBUmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:53 -0500
Received: from foss.arm.com ([217.140.110.172]:50624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388493AbgLBUmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD80F11FB;
        Wed,  2 Dec 2020 12:41:14 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D0D33F575;
        Wed,  2 Dec 2020 12:41:12 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 24/37] firmware: arm_scmi: port Sensor protocol to new protocols interface
Date:   Wed,  2 Dec 2020 20:39:56 +0000
Message-Id: <20201202204009.32073-25-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert internals of protocol implementation to use protocol handles and
expose a new protocol operations interface for SCMI driver using the new
get/put common operations, while keeping the old handle->sensor_ops still
around to ease transition.

Remove handle->sensor_priv now unused.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 275 ++++++++++++++++++----------
 include/linux/scmi_protocol.h       |  22 ++-
 2 files changed, 194 insertions(+), 103 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index e1e428d59d5f..5d2da4f78108 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -201,21 +201,21 @@ struct sensors_info {
 	struct scmi_sensor_info *sensors;
 };
 
-static int scmi_sensor_attributes_get(const struct scmi_handle *handle,
+static int scmi_sensor_attributes_get(const struct scmi_protocol_handle *ph,
 				      struct sensors_info *si)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_sensor_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
-				 SCMI_PROTOCOL_SENSOR, 0, sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
+				      0, sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		si->num_sensors = le16_to_cpu(attr->num_sensors);
 		si->max_requests = attr->max_requests;
@@ -224,7 +224,7 @@ static int scmi_sensor_attributes_get(const struct scmi_handle *handle,
 		si->reg_size = le32_to_cpu(attr->reg_size);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
@@ -235,7 +235,7 @@ static inline void scmi_parse_range_attrs(struct scmi_range_attrs *out,
 	out->max_range = get_unaligned_le64((void *)&in->max_range_low);
 }
 
-static int scmi_sensor_update_intervals(const struct scmi_handle *handle,
+static int scmi_sensor_update_intervals(const struct scmi_protocol_handle *ph,
 					struct scmi_sensor_info *s)
 {
 	int ret, cnt;
@@ -245,8 +245,8 @@ static int scmi_sensor_update_intervals(const struct scmi_handle *handle,
 	struct scmi_msg_resp_sensor_list_update_intervals *buf;
 	struct scmi_msg_sensor_list_update_intervals *msg;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_LIST_UPDATE_INTERVALS,
-				 SCMI_PROTOCOL_SENSOR, sizeof(*msg), 0, &ti);
+	ret = ph->xops->xfer_get_init(ph, SENSOR_LIST_UPDATE_INTERVALS,
+				      sizeof(*msg), 0, &ti);
 	if (ret)
 		return ret;
 
@@ -259,7 +259,7 @@ static int scmi_sensor_update_intervals(const struct scmi_handle *handle,
 		msg->id = cpu_to_le32(s->id);
 		msg->index = cpu_to_le32(desc_index);
 
-		ret = scmi_do_xfer(handle, ti);
+		ret = ph->xops->do_xfer(ph, ti);
 		if (ret)
 			break;
 
@@ -277,7 +277,7 @@ static int scmi_sensor_update_intervals(const struct scmi_handle *handle,
 			/* segmented intervals are reported in one triplet */
 			if (s->intervals.segmented &&
 			    (num_remaining || num_returned != 3)) {
-				dev_err(handle->dev,
+				dev_err(ph->dev,
 					"Sensor ID:%d advertises an invalid segmented interval (%d)\n",
 					s->id, s->intervals.count);
 				s->intervals.segmented = false;
@@ -288,7 +288,7 @@ static int scmi_sensor_update_intervals(const struct scmi_handle *handle,
 			/* Direct allocation when exceeding pre-allocated */
 			if (s->intervals.count >= SCMI_MAX_PREALLOC_POOL) {
 				s->intervals.desc =
-					devm_kcalloc(handle->dev,
+					devm_kcalloc(ph->dev,
 						     s->intervals.count,
 						     sizeof(*s->intervals.desc),
 						     GFP_KERNEL);
@@ -300,7 +300,7 @@ static int scmi_sensor_update_intervals(const struct scmi_handle *handle,
 				}
 			}
 		} else if (desc_index + num_returned > s->intervals.count) {
-			dev_err(handle->dev,
+			dev_err(ph->dev,
 				"No. of update intervals can't exceed %d\n",
 				s->intervals.count);
 			ret = -EINVAL;
@@ -313,18 +313,18 @@ static int scmi_sensor_update_intervals(const struct scmi_handle *handle,
 
 		desc_index += num_returned;
 
-		scmi_reset_rx_to_maxsz(handle, ti);
+		ph->xops->reset_rx_to_maxsz(ph, ti);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
 		 */
 	} while (num_returned && num_remaining);
 
-	scmi_xfer_put(handle, ti);
+	ph->xops->xfer_put(ph, ti);
 	return ret;
 }
 
-static int scmi_sensor_axis_description(const struct scmi_handle *handle,
+static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
 					struct scmi_sensor_info *s)
 {
 	int ret, cnt;
@@ -334,13 +334,13 @@ static int scmi_sensor_axis_description(const struct scmi_handle *handle,
 	struct scmi_msg_resp_sensor_axis_description *buf;
 	struct scmi_msg_sensor_axis_description_get *msg;
 
-	s->axis = devm_kcalloc(handle->dev, s->num_axis,
+	s->axis = devm_kcalloc(ph->dev, s->num_axis,
 			       sizeof(*s->axis), GFP_KERNEL);
 	if (!s->axis)
 		return -ENOMEM;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_AXIS_DESCRIPTION_GET,
-				 SCMI_PROTOCOL_SENSOR, sizeof(*msg), 0, &te);
+	ret = ph->xops->xfer_get_init(ph, SENSOR_AXIS_DESCRIPTION_GET,
+				      sizeof(*msg), 0, &te);
 	if (ret)
 		return ret;
 
@@ -354,7 +354,7 @@ static int scmi_sensor_axis_description(const struct scmi_handle *handle,
 		msg->id = cpu_to_le32(s->id);
 		msg->axis_desc_index = cpu_to_le32(desc_index);
 
-		ret = scmi_do_xfer(handle, te);
+		ret = ph->xops->do_xfer(ph, te);
 		if (ret)
 			break;
 
@@ -363,7 +363,7 @@ static int scmi_sensor_axis_description(const struct scmi_handle *handle,
 		num_remaining = NUM_AXIS_REMAINING(flags);
 
 		if (desc_index + num_returned > s->num_axis) {
-			dev_err(handle->dev, "No. of axis can't exceed %d\n",
+			dev_err(ph->dev, "No. of axis can't exceed %d\n",
 				s->num_axis);
 			break;
 		}
@@ -405,18 +405,18 @@ static int scmi_sensor_axis_description(const struct scmi_handle *handle,
 
 		desc_index += num_returned;
 
-		scmi_reset_rx_to_maxsz(handle, te);
+		ph->xops->reset_rx_to_maxsz(ph, te);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
 		 */
 	} while (num_returned && num_remaining);
 
-	scmi_xfer_put(handle, te);
+	ph->xops->xfer_put(ph, te);
 	return ret;
 }
 
-static int scmi_sensor_description_get(const struct scmi_handle *handle,
+static int scmi_sensor_description_get(const struct scmi_protocol_handle *ph,
 				       struct sensors_info *si)
 {
 	int ret, cnt;
@@ -425,8 +425,8 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_sensor_description *buf;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_DESCRIPTION_GET,
-				 SCMI_PROTOCOL_SENSOR, sizeof(__le32), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, SENSOR_DESCRIPTION_GET,
+				      sizeof(__le32), 0, &t);
 	if (ret)
 		return ret;
 
@@ -437,7 +437,8 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 
 		/* Set the number of sensors to be skipped/already read */
 		put_unaligned_le32(desc_index, t->tx.buf);
-		ret = scmi_do_xfer(handle, t);
+
+		ret = ph->xops->do_xfer(ph, t);
 		if (ret)
 			break;
 
@@ -445,7 +446,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 		num_remaining = le16_to_cpu(buf->num_remaining);
 
 		if (desc_index + num_returned > si->num_sensors) {
-			dev_err(handle->dev, "No. of sensors can't exceed %d",
+			dev_err(ph->dev, "No. of sensors can't exceed %d",
 				si->num_sensors);
 			break;
 		}
@@ -500,8 +501,8 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 				 * Since the command is optional, on error carry
 				 * on without any update interval.
 				 */
-				if (scmi_sensor_update_intervals(handle, s))
-					dev_dbg(handle->dev,
+				if (scmi_sensor_update_intervals(ph, s))
+					dev_dbg(ph->dev,
 						"Update Intervals not available for sensor ID:%d\n",
 						s->id);
 			}
@@ -535,7 +536,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 				}
 			}
 			if (s->num_axis > 0) {
-				ret = scmi_sensor_axis_description(handle, s);
+				ret = scmi_sensor_axis_description(ph, s);
 				if (ret)
 					goto out;
 			}
@@ -545,7 +546,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 
 		desc_index += num_returned;
 
-		scmi_reset_rx_to_maxsz(handle, t);
+		ph->xops->reset_rx_to_maxsz(ph, t);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
@@ -553,12 +554,12 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 	} while (num_returned && num_remaining);
 
 out:
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
 static inline int
-scmi_sensor_request_notify(const struct scmi_handle *handle, u32 sensor_id,
+scmi_sensor_request_notify(const struct scmi_protocol_handle *ph, u32 sensor_id,
 			   u8 message_id, bool enable)
 {
 	int ret;
@@ -566,8 +567,7 @@ scmi_sensor_request_notify(const struct scmi_handle *handle, u32 sensor_id,
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_request_notify *cfg;
 
-	ret = scmi_xfer_get_init(handle, message_id,
-				 SCMI_PROTOCOL_SENSOR, sizeof(*cfg), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, message_id, sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
 
@@ -575,40 +575,40 @@ scmi_sensor_request_notify(const struct scmi_handle *handle, u32 sensor_id,
 	cfg->id = cpu_to_le32(sensor_id);
 	cfg->event_control = cpu_to_le32(evt_cntl);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_sensor_trip_point_notify(const struct scmi_handle *handle,
+static int scmi_sensor_trip_point_notify(const struct scmi_protocol_handle *ph,
 					 u32 sensor_id, bool enable)
 {
-	return scmi_sensor_request_notify(handle, sensor_id,
+	return scmi_sensor_request_notify(ph, sensor_id,
 					  SENSOR_TRIP_POINT_NOTIFY,
 					  enable);
 }
 
 static int
-scmi_sensor_continuous_update_notify(const struct scmi_handle *handle,
+scmi_sensor_continuous_update_notify(const struct scmi_protocol_handle *ph,
 				     u32 sensor_id, bool enable)
 {
-	return scmi_sensor_request_notify(handle, sensor_id,
+	return scmi_sensor_request_notify(ph, sensor_id,
 					  SENSOR_CONTINUOUS_UPDATE_NOTIFY,
 					  enable);
 }
 
 static int
-scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
-			      u8 trip_id, u64 trip_value)
+scmi_sensor_trip_point_config(const struct scmi_protocol_handle *ph,
+			      u32 sensor_id, u8 trip_id, u64 trip_value)
 {
 	int ret;
 	u32 evt_cntl = SENSOR_TP_BOTH;
 	struct scmi_xfer *t;
 	struct scmi_msg_set_sensor_trip_point *trip;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_TRIP_POINT_CONFIG,
-				 SCMI_PROTOCOL_SENSOR, sizeof(*trip), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, SENSOR_TRIP_POINT_CONFIG,
+				      sizeof(*trip), 0, &t);
 	if (ret)
 		return ret;
 
@@ -618,47 +618,66 @@ scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
 	trip->value_low = cpu_to_le32(trip_value & 0xffffffff);
 	trip->value_high = cpu_to_le32(trip_value >> 32);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_sensor_config_get(const struct scmi_handle *handle,
+static int
+__scmi_sensor_trip_point_config(const struct scmi_handle *handle,
+				u32 sensor_id, u8 trip_id, u64 trip_value)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
+
+	return scmi_sensor_trip_point_config(ph, sensor_id, trip_id,
+					     trip_value);
+}
+
+static int scmi_sensor_config_get(const struct scmi_protocol_handle *ph,
 				  u32 sensor_id, u32 *sensor_config)
 {
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_CONFIG_GET,
-				 SCMI_PROTOCOL_SENSOR, sizeof(__le32),
-				 sizeof(__le32), &t);
+	ret = ph->xops->xfer_get_init(ph, SENSOR_CONFIG_GET,
+				      sizeof(__le32), sizeof(__le32), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(cpu_to_le32(sensor_id), t->tx.buf);
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
-		struct sensors_info *si = handle->sensor_priv;
+		struct sensors_info *si = ph->get_priv(ph);
 		struct scmi_sensor_info *s = si->sensors + sensor_id;
 
 		*sensor_config = get_unaligned_le64(t->rx.buf);
 		s->sensor_config = *sensor_config;
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_sensor_config_set(const struct scmi_handle *handle,
+static int __scmi_sensor_config_get(const struct scmi_handle *handle,
+				    u32 sensor_id, u32 *sensor_config)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
+
+	return scmi_sensor_config_get(ph, sensor_id, sensor_config);
+}
+
+static int scmi_sensor_config_set(const struct scmi_protocol_handle *ph,
 				  u32 sensor_id, u32 sensor_config)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_config_set *msg;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_CONFIG_SET,
-				 SCMI_PROTOCOL_SENSOR, sizeof(*msg), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, SENSOR_CONFIG_SET,
+				      sizeof(*msg), 0, &t);
 	if (ret)
 		return ret;
 
@@ -666,21 +685,30 @@ static int scmi_sensor_config_set(const struct scmi_handle *handle,
 	msg->id = cpu_to_le32(sensor_id);
 	msg->sensor_config = cpu_to_le32(sensor_config);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
-		struct sensors_info *si = handle->sensor_priv;
+		struct sensors_info *si = ph->get_priv(ph);
 		struct scmi_sensor_info *s = si->sensors + sensor_id;
 
 		s->sensor_config = sensor_config;
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
+static int __scmi_sensor_config_set(const struct scmi_handle *handle,
+				    u32 sensor_id, u32 sensor_config)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
+
+	return scmi_sensor_config_set(ph, sensor_id, sensor_config);
+}
+
 /**
  * scmi_sensor_reading_get  - Read scalar sensor value
- * @handle: Platform handle
+ * @ph: Protocol handle
  * @sensor_id: Sensor ID
  * @value: The 64bit value sensor reading
  *
@@ -693,17 +721,17 @@ static int scmi_sensor_config_set(const struct scmi_handle *handle,
  *
  * Return: 0 on Success
  */
-static int scmi_sensor_reading_get(const struct scmi_handle *handle,
+static int scmi_sensor_reading_get(const struct scmi_protocol_handle *ph,
 				   u32 sensor_id, u64 *value)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_reading_get *sensor;
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si = ph->get_priv(ph);
 	struct scmi_sensor_info *s = si->sensors + sensor_id;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_READING_GET,
-				 SCMI_PROTOCOL_SENSOR, sizeof(*sensor), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, SENSOR_READING_GET,
+				      sizeof(*sensor), 0, &t);
 	if (ret)
 		return ret;
 
@@ -711,7 +739,7 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 	sensor->id = cpu_to_le32(sensor_id);
 	if (s->async) {
 		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
-		ret = scmi_do_xfer_with_response(handle, t);
+		ret = ph->xops->do_xfer_with_response(ph, t);
 		if (!ret) {
 			struct scmi_resp_sensor_reading_complete *resp;
 
@@ -723,15 +751,24 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 		}
 	} else {
 		sensor->flags = cpu_to_le32(0);
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 		if (!ret)
 			*value = get_unaligned_le64(t->rx.buf);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
+static int __scmi_sensor_reading_get(const struct scmi_handle *handle,
+				     u32 sensor_id, u64 *value)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
+
+	return scmi_sensor_reading_get(ph, sensor_id, value);
+}
+
 static inline void
 scmi_parse_sensor_readings(struct scmi_sensor_reading *out,
 			   const struct scmi_sensor_reading_resp *in)
@@ -742,7 +779,7 @@ scmi_parse_sensor_readings(struct scmi_sensor_reading *out,
 
 /**
  * scmi_sensor_reading_get_timestamped  - Read multiple-axis timestamped values
- * @handle: Platform handle
+ * @ph: Protocol handle
  * @sensor_id: Sensor ID
  * @count: The length of the provided @readings array
  * @readings: An array of elements each representing a timestamped per-axis
@@ -755,22 +792,22 @@ scmi_parse_sensor_readings(struct scmi_sensor_reading *out,
  * Return: 0 on Success
  */
 static int
-scmi_sensor_reading_get_timestamped(const struct scmi_handle *handle,
+scmi_sensor_reading_get_timestamped(const struct scmi_protocol_handle *ph,
 				    u32 sensor_id, u8 count,
 				    struct scmi_sensor_reading *readings)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_reading_get *sensor;
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si = ph->get_priv(ph);
 	struct scmi_sensor_info *s = si->sensors + sensor_id;
 
 	if (!count || !readings ||
 	    (!s->num_axis && count > 1) || (s->num_axis && count > s->num_axis))
 		return -EINVAL;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_READING_GET,
-				 SCMI_PROTOCOL_SENSOR, sizeof(*sensor), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, SENSOR_READING_GET,
+				      sizeof(*sensor), 0, &t);
 	if (ret)
 		return ret;
 
@@ -778,7 +815,7 @@ scmi_sensor_reading_get_timestamped(const struct scmi_handle *handle,
 	sensor->id = cpu_to_le32(sensor_id);
 	if (s->async) {
 		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
-		ret = scmi_do_xfer_with_response(handle, t);
+		ret = ph->xops->do_xfer_with_response(ph, t);
 		if (!ret) {
 			int i;
 			struct scmi_resp_sensor_reading_complete_v3 *resp;
@@ -794,7 +831,7 @@ scmi_sensor_reading_get_timestamped(const struct scmi_handle *handle,
 		}
 	} else {
 		sensor->flags = cpu_to_le32(0);
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 		if (!ret) {
 			int i;
 			struct scmi_sensor_reading_resp *resp_readings;
@@ -806,26 +843,65 @@ scmi_sensor_reading_get_timestamped(const struct scmi_handle *handle,
 		}
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
+static int
+__scmi_sensor_reading_get_timestamped(const struct scmi_handle *handle,
+				      u32 sensor_id, u8 count,
+				      struct scmi_sensor_reading *readings)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
+
+	return scmi_sensor_reading_get_timestamped(ph, sensor_id, count,
+						   readings);
+}
+
 static const struct scmi_sensor_info *
-scmi_sensor_info_get(const struct scmi_handle *handle, u32 sensor_id)
+scmi_sensor_info_get(const struct scmi_protocol_handle *ph, u32 sensor_id)
 {
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si = ph->get_priv(ph);
 
 	return si->sensors + sensor_id;
 }
 
-static int scmi_sensor_count_get(const struct scmi_handle *handle)
+static const struct scmi_sensor_info *
+__scmi_sensor_info_get(const struct scmi_handle *handle, u32 sensor_id)
 {
-	struct sensors_info *si = handle->sensor_priv;
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
+
+	return scmi_sensor_info_get(ph, sensor_id);
+}
+
+static int scmi_sensor_count_get(const struct scmi_protocol_handle *ph)
+{
+	struct sensors_info *si = ph->get_priv(ph);
 
 	return si->num_sensors;
 }
 
+static int __scmi_sensor_count_get(const struct scmi_handle *handle)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_SENSOR);
+
+	return scmi_sensor_count_get(ph);
+}
+
 static const struct scmi_sensor_ops sensor_ops = {
+	.count_get = __scmi_sensor_count_get,
+	.info_get = __scmi_sensor_info_get,
+	.trip_point_config = __scmi_sensor_trip_point_config,
+	.reading_get = __scmi_sensor_reading_get,
+	.reading_get_timestamped = __scmi_sensor_reading_get_timestamped,
+	.config_get = __scmi_sensor_config_get,
+	.config_set = __scmi_sensor_config_set,
+};
+
+static const struct scmi_sensor_proto_ops sensor_proto_ops = {
 	.count_get = scmi_sensor_count_get,
 	.info_get = scmi_sensor_info_get,
 	.trip_point_config = scmi_sensor_trip_point_config,
@@ -835,18 +911,17 @@ static const struct scmi_sensor_ops sensor_ops = {
 	.config_set = scmi_sensor_config_set,
 };
 
-static int scmi_sensor_set_notify_enabled(const void *handle,
+static int scmi_sensor_set_notify_enabled(const void *ph,
 					  u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
 
 	switch (evt_id) {
 	case SCMI_EVENT_SENSOR_TRIP_POINT_EVENT:
-		ret = scmi_sensor_trip_point_notify(handle, src_id, enable);
+		ret = scmi_sensor_trip_point_notify(ph, src_id, enable);
 		break;
 	case SCMI_EVENT_SENSOR_UPDATE:
-		ret = scmi_sensor_continuous_update_notify(handle, src_id,
-							   enable);
+		ret = scmi_sensor_continuous_update_notify(ph, src_id, enable);
 		break;
 	default:
 		ret = -EINVAL;
@@ -860,7 +935,7 @@ static int scmi_sensor_set_notify_enabled(const void *handle,
 	return ret;
 }
 
-static void *scmi_sensor_fill_custom_report(const void *handle,
+static void *scmi_sensor_fill_custom_report(const void *ph,
 					    u8 evt_id, ktime_t timestamp,
 					    const void *payld, size_t payld_sz,
 					    void *report, u32 *src_id)
@@ -891,7 +966,7 @@ static void *scmi_sensor_fill_custom_report(const void *handle,
 		const struct scmi_sensor_update_notify_payld *p = payld;
 		struct scmi_sensor_update_report *r = report;
 		struct sensors_info *sinfo =
-			((const struct scmi_handle *)(handle))->sensor_priv;
+			((const struct scmi_protocol_handle *)ph)->get_priv(ph);
 
 		/* payld_sz is variable for this event */
 		r->sensor_id = le32_to_cpu(p->sensor_id);
@@ -921,10 +996,10 @@ static void *scmi_sensor_fill_custom_report(const void *handle,
 	return rep;
 }
 
-static int scmi_sensor_get_num_sources(const void *handle)
+static int scmi_sensor_get_num_sources(const void *ph)
 {
 	struct sensors_info *si =
-		((const struct scmi_handle *)(handle))->sensor_priv;
+		((const struct scmi_protocol_handle *)ph)->get_priv(ph);
 
 	return si->num_sensors;
 }
@@ -960,44 +1035,46 @@ static const struct scmi_protocol_events sensor_protocol_events = {
 	.num_events = ARRAY_SIZE(sensor_events),
 };
 
-static int scmi_sensors_protocol_init(struct scmi_handle *handle)
+static int scmi_sensors_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	u32 version;
 	int ret;
 	struct sensors_info *sinfo;
+	struct scmi_handle *handle;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_SENSOR, &version);
+	ph->xops->version_get(ph, &version);
 
-	dev_dbg(handle->dev, "Sensor Version %d.%d\n",
+	dev_dbg(ph->dev, "Sensor Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
 
-	sinfo = devm_kzalloc(handle->dev, sizeof(*sinfo), GFP_KERNEL);
+	sinfo = devm_kzalloc(ph->dev, sizeof(*sinfo), GFP_KERNEL);
 	if (!sinfo)
 		return -ENOMEM;
 	sinfo->version = version;
 
-	ret = scmi_sensor_attributes_get(handle, sinfo);
+	ret = scmi_sensor_attributes_get(ph, sinfo);
 	if (ret)
 		return ret;
-	sinfo->sensors = devm_kcalloc(handle->dev, sinfo->num_sensors,
+	sinfo->sensors = devm_kcalloc(ph->dev, sinfo->num_sensors,
 				      sizeof(*sinfo->sensors), GFP_KERNEL);
 	if (!sinfo->sensors)
 		return -ENOMEM;
 
-	ret = scmi_sensor_description_get(handle, sinfo);
+	ret = scmi_sensor_description_get(ph, sinfo);
 	if (ret)
 		return ret;
 
-	handle->sensor_priv = sinfo;
+	/* Transient code for legacy ops interface */
+	handle = scmi_map_scmi_handle(ph);
 	handle->sensor_ops = &sensor_ops;
 
-	return 0;
+	return ph->set_priv(ph, sinfo);
 }
 
 static const struct scmi_protocol scmi_sensors = {
 	.id = SCMI_PROTOCOL_SENSOR,
-	.init = &scmi_sensors_protocol_init,
-	.ops = &sensor_ops,
+	.init_instance = &scmi_sensors_protocol_init,
+	.ops = &sensor_proto_ops,
 	.events = &sensor_protocol_events,
 };
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 940751d2e527..37cf83dae795 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -430,7 +430,7 @@ enum scmi_sensor_class {
 };
 
 /**
- * struct scmi_sensor_ops - represents the various operations provided
+ * struct scmi_sensor_proto_ops - represents the various operations provided
  *	by SCMI Sensor Protocol
  *
  * @count_get: get the count of sensors provided by SCMI
@@ -445,6 +445,23 @@ enum scmi_sensor_class {
  * @config_get: Get sensor current configuration
  * @config_set: Set sensor current configuration
  */
+struct scmi_sensor_proto_ops {
+	int (*count_get)(const struct scmi_protocol_handle *ph);
+	const struct scmi_sensor_info *(*info_get)
+		(const struct scmi_protocol_handle *ph, u32 sensor_id);
+	int (*trip_point_config)(const struct scmi_protocol_handle *ph,
+				 u32 sensor_id, u8 trip_id, u64 trip_value);
+	int (*reading_get)(const struct scmi_protocol_handle *ph, u32 sensor_id,
+			   u64 *value);
+	int (*reading_get_timestamped)(const struct scmi_protocol_handle *ph,
+				       u32 sensor_id, u8 count,
+				       struct scmi_sensor_reading *readings);
+	int (*config_get)(const struct scmi_protocol_handle *ph,
+			  u32 sensor_id, u32 *sensor_config);
+	int (*config_set)(const struct scmi_protocol_handle *ph,
+			  u32 sensor_id, u32 sensor_config);
+};
+
 struct scmi_sensor_ops {
 	int (*count_get)(const struct scmi_handle *handle);
 	const struct scmi_sensor_info *(*info_get)
@@ -610,8 +627,6 @@ struct scmi_notify_ops {
  *	     dedicated protocol handler
  * @put_ops: method to release a protocol
  * @notify_ops: pointer to set of notifications related operations
- * @sensor_priv: pointer to private data structure specific to sensors
- *	protocol(for internal use only)
  * @voltage_priv: pointer to private data structure specific to voltage
  *	protocol(for internal use only)
  * @notify_priv: pointer to private data structure specific to notifications
@@ -635,7 +650,6 @@ struct scmi_handle {
 
 	const struct scmi_notify_ops *notify_ops;
 	/* for protocol internal use */
-	void *sensor_priv;
 	void *voltage_priv;
 	void *notify_priv;
 	void *system_priv;
-- 
2.17.1

