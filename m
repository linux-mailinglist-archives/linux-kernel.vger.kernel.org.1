Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CA02997B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgJZUKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:10:43 -0400
Received: from foss.arm.com ([217.140.110.172]:51162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbgJZUKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:10:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30B931FB;
        Mon, 26 Oct 2020 13:10:42 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26CDB3F68F;
        Mon, 26 Oct 2020 13:10:35 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v2 6/6] firmware: arm_scmi: add SCMIv3.0 Sensor notifications
Date:   Mon, 26 Oct 2020 20:10:07 +0000
Message-Id: <20201026201007.23591-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026201007.23591-1-cristian.marussi@arm.com>
References: <20201026201007.23591-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for new SCMIv3.0 SENSOR_UPDATE notification.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 124 ++++++++++++++++++++++++----
 include/linux/scmi_protocol.h       |   9 ++
 2 files changed, 116 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 372a3592e99b..51921e279c9f 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -24,6 +24,7 @@ enum scmi_sensor_protocol_cmd {
 	SENSOR_LIST_UPDATE_INTERVALS = 0x8,
 	SENSOR_CONFIG_GET = 0x9,
 	SENSOR_CONFIG_SET = 0xA,
+	SENSOR_CONTINUOUS_UPDATE_NOTIFY = 0xB,
 };
 
 struct scmi_msg_resp_sensor_attributes {
@@ -133,10 +134,10 @@ struct scmi_msg_resp_sensor_list_update_intervals {
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
@@ -198,6 +199,17 @@ struct scmi_sensor_trip_notify_payld {
 	__le32 trip_point_desc;
 };
 
+struct scmi_msg_sensor_continuous_update_notify {
+	__le32 id;
+	__le32 event_control;
+};
+
+struct scmi_sensor_update_notify_payld {
+	__le32 agent_id;
+	__le32 sensor_id;
+	struct scmi_sensor_reading_le readings[];
+};
+
 struct sensors_info {
 	u32 version;
 	int num_sensors;
@@ -563,15 +575,16 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
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
@@ -586,6 +599,23 @@ static int scmi_sensor_trip_point_notify(const struct scmi_handle *handle,
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
@@ -837,7 +867,19 @@ static int scmi_sensor_set_notify_enabled(const struct scmi_handle *handle,
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
@@ -850,20 +892,58 @@ static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
 					    const void *payld, size_t payld_sz,
 					    void *report, u32 *src_id)
 {
+	void *rep = NULL;
 	const struct scmi_sensor_trip_notify_payld *p = payld;
 	struct scmi_sensor_trip_point_report *r = report;
 
-	if (evt_id != SCMI_EVENT_SENSOR_TRIP_POINT_EVENT ||
-	    sizeof(*p) != payld_sz)
-		return NULL;
+	switch (evt_id) {
+	case SCMI_EVENT_SENSOR_TRIP_POINT_EVENT:
+	{
+		if (sizeof(*p) != payld_sz)
+			break;
 
-	r->timestamp = timestamp;
-	r->agent_id = le32_to_cpu(p->agent_id);
-	r->sensor_id = le32_to_cpu(p->sensor_id);
-	r->trip_point_desc = le32_to_cpu(p->trip_point_desc);
-	*src_id = r->sensor_id;
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
 
-	return r;
+	return rep;
 }
 
 static const struct scmi_event sensor_events[] = {
@@ -872,6 +952,16 @@ static const struct scmi_event sensor_events[] = {
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
index 6f39ffa638b7..f6f0199e85e4 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -654,6 +654,7 @@ enum scmi_notification_events {
 	SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED = 0x0,
 	SCMI_EVENT_PERFORMANCE_LEVEL_CHANGED = 0x1,
 	SCMI_EVENT_SENSOR_TRIP_POINT_EVENT = 0x0,
+	SCMI_EVENT_SENSOR_UPDATE = 0x1,
 	SCMI_EVENT_RESET_ISSUED = 0x0,
 	SCMI_EVENT_BASE_ERROR_EVENT = 0x0,
 	SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER = 0x0,
@@ -695,6 +696,14 @@ struct scmi_sensor_trip_point_report {
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

