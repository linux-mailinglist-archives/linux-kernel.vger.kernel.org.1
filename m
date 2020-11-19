Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C90B2B9A00
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgKSRtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:49:46 -0500
Received: from foss.arm.com ([217.140.110.172]:36212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgKSRto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:49:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6E0A1595;
        Thu, 19 Nov 2020 09:49:43 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 503C93F70D;
        Thu, 19 Nov 2020 09:49:42 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 6/6] firmware: arm_scmi: add SCMIv3.0 Sensor notifications
Date:   Thu, 19 Nov 2020 17:49:06 +0000
Message-Id: <20201119174906.43862-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119174906.43862-1-cristian.marussi@arm.com>
References: <20201119174906.43862-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for new SCMIv3.0 SENSOR_UPDATE notification.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
- removed stale unused msg payload definition
- moved variable declaration inside switch block
---
 drivers/firmware/arm_scmi/sensors.c | 124 +++++++++++++++++++++++-----
 include/linux/scmi_protocol.h       |   9 ++
 2 files changed, 114 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 10c271d430e7..b3d7c08c09a0 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -25,6 +25,7 @@ enum scmi_sensor_protocol_cmd {
 	SENSOR_LIST_UPDATE_INTERVALS = 0x8,
 	SENSOR_CONFIG_GET = 0x9,
 	SENSOR_CONFIG_SET = 0xA,
+	SENSOR_CONTINUOUS_UPDATE_NOTIFY = 0xB,
 };
 
 struct scmi_msg_resp_sensor_attributes {
@@ -132,10 +133,10 @@ struct scmi_msg_resp_sensor_list_update_intervals {
 	__le32 intervals[];
 };
 
-struct scmi_msg_sensor_trip_point_notify {
+struct scmi_msg_sensor_request_notify {
 	__le32 id;
 	__le32 event_control;
-#define SENSOR_TP_NOTIFY_ALL	BIT(0)
+#define SENSOR_NOTIFY_ALL	BIT(0)
 };
 
 struct scmi_msg_set_sensor_trip_point {
@@ -185,6 +186,12 @@ struct scmi_sensor_trip_notify_payld {
 	__le32 trip_point_desc;
 };
 
+struct scmi_sensor_update_notify_payld {
+	__le32 agent_id;
+	__le32 sensor_id;
+	struct scmi_sensor_reading_le readings[];
+};
+
 struct sensors_info {
 	u32 version;
 	int num_sensors;
@@ -550,15 +557,16 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 	return ret;
 }
 
-static int scmi_sensor_trip_point_notify(const struct scmi_handle *handle,
-					 u32 sensor_id, bool enable)
+static inline int
+scmi_sensor_request_notify(const struct scmi_handle *handle, u32 sensor_id,
+			   u8 message_id, bool enable)
 {
 	int ret;
-	u32 evt_cntl = enable ? SENSOR_TP_NOTIFY_ALL : 0;
+	u32 evt_cntl = enable ? SENSOR_NOTIFY_ALL : 0;
 	struct scmi_xfer *t;
-	struct scmi_msg_sensor_trip_point_notify *cfg;
+	struct scmi_msg_sensor_request_notify *cfg;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_TRIP_POINT_NOTIFY,
+	ret = scmi_xfer_get_init(handle, message_id,
 				 SCMI_PROTOCOL_SENSOR, sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
@@ -573,6 +581,23 @@ static int scmi_sensor_trip_point_notify(const struct scmi_handle *handle,
 	return ret;
 }
 
+static int scmi_sensor_trip_point_notify(const struct scmi_handle *handle,
+					 u32 sensor_id, bool enable)
+{
+	return scmi_sensor_request_notify(handle, sensor_id,
+					  SENSOR_TRIP_POINT_NOTIFY,
+					  enable);
+}
+
+static int
+scmi_sensor_continuous_update_notify(const struct scmi_handle *handle,
+				     u32 sensor_id, bool enable)
+{
+	return scmi_sensor_request_notify(handle, sensor_id,
+					  SENSOR_CONTINUOUS_UPDATE_NOTIFY,
+					  enable);
+}
+
 static int
 scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
 			      u8 trip_id, u64 trip_value)
@@ -815,7 +840,19 @@ static int scmi_sensor_set_notify_enabled(const struct scmi_handle *handle,
 {
 	int ret;
 
-	ret = scmi_sensor_trip_point_notify(handle, src_id, enable);
+	switch (evt_id) {
+	case SCMI_EVENT_SENSOR_TRIP_POINT_EVENT:
+		ret = scmi_sensor_trip_point_notify(handle, src_id, enable);
+		break;
+	case SCMI_EVENT_SENSOR_UPDATE:
+		ret = scmi_sensor_continuous_update_notify(handle, src_id,
+							   enable);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
 	if (ret)
 		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
 			 evt_id, src_id, ret);
@@ -828,20 +865,59 @@ static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
 					    const void *payld, size_t payld_sz,
 					    void *report, u32 *src_id)
 {
-	const struct scmi_sensor_trip_notify_payld *p = payld;
-	struct scmi_sensor_trip_point_report *r = report;
+	void *rep = NULL;
 
-	if (evt_id != SCMI_EVENT_SENSOR_TRIP_POINT_EVENT ||
-	    sizeof(*p) != payld_sz)
-		return NULL;
+	switch (evt_id) {
+	case SCMI_EVENT_SENSOR_TRIP_POINT_EVENT:
+	{
+		const struct scmi_sensor_trip_notify_payld *p = payld;
+		struct scmi_sensor_trip_point_report *r = report;
 
-	r->timestamp = timestamp;
-	r->agent_id = le32_to_cpu(p->agent_id);
-	r->sensor_id = le32_to_cpu(p->sensor_id);
-	r->trip_point_desc = le32_to_cpu(p->trip_point_desc);
-	*src_id = r->sensor_id;
+		if (sizeof(*p) != payld_sz)
+			break;
 
-	return r;
+		r->timestamp = timestamp;
+		r->agent_id = le32_to_cpu(p->agent_id);
+		r->sensor_id = le32_to_cpu(p->sensor_id);
+		r->trip_point_desc = le32_to_cpu(p->trip_point_desc);
+		*src_id = r->sensor_id;
+		rep = r;
+		break;
+	}
+	case SCMI_EVENT_SENSOR_UPDATE:
+	{
+		int i;
+		struct scmi_sensor_info *s;
+		const struct scmi_sensor_update_notify_payld *p = payld;
+		struct scmi_sensor_update_report *r = report;
+		struct sensors_info *sinfo = handle->sensor_priv;
+
+		/* payld_sz is variable for this event */
+		r->sensor_id = le32_to_cpu(p->sensor_id);
+		if (r->sensor_id >= sinfo->num_sensors)
+			break;
+		r->timestamp = timestamp;
+		r->agent_id = le32_to_cpu(p->agent_id);
+		s = &sinfo->sensors[r->sensor_id];
+		/*
+		 * The generated report r (@struct scmi_sensor_update_report)
+		 * was pre-allocated to contain up to SCMI_MAX_NUM_SENSOR_AXIS
+		 * readings: here it is filled with the effective @num_axis
+		 * readings defined for this sensor or 1 for scalar sensors.
+		 */
+		r->readings_count = s->num_axis ?: 1;
+		for (i = 0; i < r->readings_count; i++)
+			scmi_parse_sensor_readings(&r->readings[i],
+						   &p->readings[i]);
+		*src_id = r->sensor_id;
+		rep = r;
+		break;
+	}
+	default:
+		break;
+	}
+
+	return rep;
 }
 
 static const struct scmi_event sensor_events[] = {
@@ -850,6 +926,16 @@ static const struct scmi_event sensor_events[] = {
 		.max_payld_sz = sizeof(struct scmi_sensor_trip_notify_payld),
 		.max_report_sz = sizeof(struct scmi_sensor_trip_point_report),
 	},
+	{
+		.id = SCMI_EVENT_SENSOR_UPDATE,
+		.max_payld_sz =
+			sizeof(struct scmi_sensor_update_notify_payld) +
+			 SCMI_MAX_NUM_SENSOR_AXIS *
+			 sizeof(struct scmi_sensor_reading_le),
+		.max_report_sz = sizeof(struct scmi_sensor_update_report) +
+				  SCMI_MAX_NUM_SENSOR_AXIS *
+				  sizeof(struct scmi_sensor_reading),
+	},
 };
 
 static const struct scmi_event_ops sensor_event_ops = {
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 7e9e2cd3d46b..be0be5ff7514 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -657,6 +657,7 @@ enum scmi_notification_events {
 	SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED = 0x0,
 	SCMI_EVENT_PERFORMANCE_LEVEL_CHANGED = 0x1,
 	SCMI_EVENT_SENSOR_TRIP_POINT_EVENT = 0x0,
+	SCMI_EVENT_SENSOR_UPDATE = 0x1,
 	SCMI_EVENT_RESET_ISSUED = 0x0,
 	SCMI_EVENT_BASE_ERROR_EVENT = 0x0,
 	SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER = 0x0,
@@ -698,6 +699,14 @@ struct scmi_sensor_trip_point_report {
 	unsigned int	trip_point_desc;
 };
 
+struct scmi_sensor_update_report {
+	ktime_t				timestamp;
+	unsigned int			agent_id;
+	unsigned int			sensor_id;
+	unsigned int			readings_count;
+	struct scmi_sensor_reading	readings[];
+};
+
 struct scmi_reset_issued_report {
 	ktime_t		timestamp;
 	unsigned int	agent_id;
-- 
2.17.1

