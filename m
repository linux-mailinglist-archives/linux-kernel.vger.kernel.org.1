Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC2C1C4026
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgEDQjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 12:39:45 -0400
Received: from foss.arm.com ([217.140.110.172]:48720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729812AbgEDQja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:39:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 521211045;
        Mon,  4 May 2020 09:39:29 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B6983F68F;
        Mon,  4 May 2020 09:39:28 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [PATCH v7 7/9] firmware: arm_scmi: Add Sensor notifications support
Date:   Mon,  4 May 2020 17:38:53 +0100
Message-Id: <20200504163855.54548-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504163855.54548-1-cristian.marussi@arm.com>
References: <20200504163855.54548-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make SCMI Sensor protocol register with the notification core.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
V6 --> V7
- fixed report.timestamp type
- removed trip_point_notify from .sensor_ops
- fixed max_payld_sz initialization
- expose SCMI_EVENT_ in linux/scmi_protocol.h
V5 --> V6
- added handle argument to fill_custom_report()
V4 --> V5
- fixed unsual return construct
V3 --> V4
- scmi_event field renamed
V2 --> V3
- added handle awareness
V1 --> V2
- simplified .set_notify_enabled() implementation moving the ALL_SRCIDs
  logic out of protocol. ALL_SRCIDs logic is now in charge of the
  notification core, together with proper reference counting of enables
- switched to devres protocol-registration
---
 drivers/firmware/arm_scmi/sensors.c | 77 +++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h       | 13 +++--
 2 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index db1b1ab303da..88fdd887f5b5 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -5,7 +5,10 @@
  * Copyright (C) 2018 ARM Ltd.
  */
 
+#include <linux/scmi_protocol.h>
+
 #include "common.h"
+#include "notify.h"
 
 enum scmi_sensor_protocol_cmd {
 	SENSOR_DESCRIPTION_GET = 0x3,
@@ -14,10 +17,6 @@ enum scmi_sensor_protocol_cmd {
 	SENSOR_READING_GET = 0x6,
 };
 
-enum scmi_sensor_protocol_notify {
-	SENSOR_TRIP_POINT_EVENT = 0x0,
-};
-
 struct scmi_msg_resp_sensor_attributes {
 	__le16 num_sensors;
 	u8 max_requests;
@@ -71,6 +70,12 @@ struct scmi_msg_sensor_reading_get {
 #define SENSOR_READ_ASYNC	BIT(0)
 };
 
+struct scmi_sensor_trip_notify_payld {
+	__le32 agent_id;
+	__le32 sensor_id;
+	__le32 trip_point_desc;
+};
+
 struct sensors_info {
 	u32 version;
 	int num_sensors;
@@ -271,11 +276,67 @@ static int scmi_sensor_count_get(const struct scmi_handle *handle)
 static struct scmi_sensor_ops sensor_ops = {
 	.count_get = scmi_sensor_count_get,
 	.info_get = scmi_sensor_info_get,
-	.trip_point_notify = scmi_sensor_trip_point_notify,
 	.trip_point_config = scmi_sensor_trip_point_config,
 	.reading_get = scmi_sensor_reading_get,
 };
 
+static bool scmi_sensor_set_notify_enabled(const struct scmi_handle *handle,
+					   u8 evt_id, u32 src_id, bool enable)
+{
+	int ret;
+
+	ret = scmi_sensor_trip_point_notify(handle, src_id, enable);
+	if (ret)
+		pr_warn("SCMI Notifications - Proto:%X - FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
+			SCMI_PROTOCOL_SENSOR, evt_id, src_id, ret);
+
+	return !ret;
+}
+
+static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
+					    u8 evt_id, u64 timestamp,
+					    const void *payld, size_t payld_sz,
+					    void *report, u32 *src_id)
+{
+	void *rep = NULL;
+
+	switch (evt_id) {
+	case SCMI_EVENT_SENSOR_TRIP_POINT_EVENT:
+	{
+		const struct scmi_sensor_trip_notify_payld *p = payld;
+		struct scmi_sensor_trip_point_report *r = report;
+
+		if (sizeof(*p) != payld_sz)
+			break;
+
+		r->timestamp = timestamp;
+		r->agent_id = le32_to_cpu(p->agent_id);
+		r->sensor_id = le32_to_cpu(p->sensor_id);
+		r->trip_point_desc = le32_to_cpu(p->trip_point_desc);
+		*src_id = r->sensor_id;
+		rep = r;
+		break;
+	}
+	default:
+		break;
+	}
+
+	return rep;
+}
+
+static const struct scmi_event sensor_events[] = {
+	{
+		.id = SCMI_EVENT_SENSOR_TRIP_POINT_EVENT,
+		.max_payld_sz = sizeof(struct scmi_sensor_trip_notify_payld),
+		.max_report_sz = sizeof(struct scmi_sensor_trip_point_report),
+	},
+};
+
+static const struct scmi_protocol_event_ops sensor_event_ops = {
+	.set_notify_enabled = scmi_sensor_set_notify_enabled,
+	.fill_custom_report = scmi_sensor_fill_custom_report,
+};
+
 static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 {
 	u32 version;
@@ -299,6 +360,12 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 
 	scmi_sensor_description_get(handle, sinfo);
 
+	scmi_register_protocol_events(handle,
+				      SCMI_PROTOCOL_SENSOR, PAGE_SIZE,
+				      &sensor_event_ops, sensor_events,
+				      ARRAY_SIZE(sensor_events),
+				      sinfo->num_sensors);
+
 	sinfo->version = version;
 	handle->sensor_ops = &sensor_ops;
 	handle->sensor_priv = sinfo;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 832b03ef37c7..7d1e8d24c880 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -174,18 +174,13 @@ enum scmi_sensor_class {
  *
  * @count_get: get the count of sensors provided by SCMI
  * @info_get: get the information of the specified sensor
- * @trip_point_notify: control notifications on cross-over events for
- *	the trip-points
  * @trip_point_config: selects and configures a trip-point of interest
  * @reading_get: gets the current value of the sensor
  */
 struct scmi_sensor_ops {
 	int (*count_get)(const struct scmi_handle *handle);
-
 	const struct scmi_sensor_info *(*info_get)
 		(const struct scmi_handle *handle, u32 sensor_id);
-	int (*trip_point_notify)(const struct scmi_handle *handle,
-				 u32 sensor_id, bool enable);
 	int (*trip_point_config)(const struct scmi_handle *handle,
 				 u32 sensor_id, u8 trip_id, u64 trip_value);
 	int (*reading_get)(const struct scmi_handle *handle, u32 sensor_id,
@@ -378,6 +373,7 @@ enum scmi_notification_events {
 	SCMI_EVENT_POWER_STATE_CHANGED = 0x0,
 	SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED = 0x0,
 	SCMI_EVENT_PERFORMANCE_LEVEL_CHANGED = 0x1,
+	SCMI_EVENT_SENSOR_TRIP_POINT_EVENT = 0x0,
 };
 
 struct scmi_power_state_changed_report {
@@ -402,4 +398,11 @@ struct scmi_perf_level_report {
 	u32 performance_level;
 };
 
+struct scmi_sensor_trip_point_report {
+	u64 timestamp;
+	u32 agent_id;
+	u32 sensor_id;
+	u32 trip_point_desc;
+};
+
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1

