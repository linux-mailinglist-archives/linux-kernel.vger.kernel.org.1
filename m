Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEB22C1018
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbgKWQUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:20:24 -0500
Received: from foss.arm.com ([217.140.110.172]:56530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729881AbgKWQUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:20:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB09D1396;
        Mon, 23 Nov 2020 08:20:22 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DAB83F718;
        Mon, 23 Nov 2020 08:20:22 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: remove residual _le structs naming
Date:   Mon, 23 Nov 2020 16:20:08 +0000
Message-Id: <20201123162008.35814-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For sake of consistency, remove any residual naming based on _le suffixes
in SCMI Sensors Protocol, since little endianity is already assumed across
all of SCMI implementation and, as such, all currently existent names do
not explicitly state their endianness.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Based on for-next/scmi

commit e3811190acf8 ("firmware: arm_scmi: Add SCMI v3.0 sensor notifications")

Thanks

Cristian
---
 drivers/firmware/arm_scmi/sensors.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index b3d7c08c09a0..4541b891b733 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -168,7 +168,7 @@ struct scmi_resp_sensor_reading_complete {
 	__le64 readings;
 };
 
-struct scmi_sensor_reading_le {
+struct scmi_sensor_reading_resp {
 	__le32 sensor_value_low;
 	__le32 sensor_value_high;
 	__le32 timestamp_low;
@@ -177,7 +177,7 @@ struct scmi_sensor_reading_le {
 
 struct scmi_resp_sensor_reading_complete_v3 {
 	__le32 id;
-	struct scmi_sensor_reading_le readings[];
+	struct scmi_sensor_reading_resp readings[];
 };
 
 struct scmi_sensor_trip_notify_payld {
@@ -189,7 +189,7 @@ struct scmi_sensor_trip_notify_payld {
 struct scmi_sensor_update_notify_payld {
 	__le32 agent_id;
 	__le32 sensor_id;
-	struct scmi_sensor_reading_le readings[];
+	struct scmi_sensor_reading_resp readings[];
 };
 
 struct sensors_info {
@@ -734,7 +734,7 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 
 static inline void
 scmi_parse_sensor_readings(struct scmi_sensor_reading *out,
-			   const struct scmi_sensor_reading_le *in)
+			   const struct scmi_sensor_reading_resp *in)
 {
 	out->value = get_unaligned_le64((void *)&in->sensor_value_low);
 	out->timestamp = get_unaligned_le64((void *)&in->timestamp_low);
@@ -797,7 +797,7 @@ scmi_sensor_reading_get_timestamped(const struct scmi_handle *handle,
 		ret = scmi_do_xfer(handle, t);
 		if (!ret) {
 			int i;
-			struct scmi_sensor_reading_le *resp_readings;
+			struct scmi_sensor_reading_resp *resp_readings;
 
 			resp_readings = t->rx.buf;
 			for (i = 0; i < count; i++)
@@ -931,7 +931,7 @@ static const struct scmi_event sensor_events[] = {
 		.max_payld_sz =
 			sizeof(struct scmi_sensor_update_notify_payld) +
 			 SCMI_MAX_NUM_SENSOR_AXIS *
-			 sizeof(struct scmi_sensor_reading_le),
+			 sizeof(struct scmi_sensor_reading_resp),
 		.max_report_sz = sizeof(struct scmi_sensor_update_report) +
 				  SCMI_MAX_NUM_SENSOR_AXIS *
 				  sizeof(struct scmi_sensor_reading),
-- 
2.17.1

