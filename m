Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744F12997AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgJZUK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:10:27 -0400
Received: from foss.arm.com ([217.140.110.172]:51090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgJZUK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:10:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 973ED13A1;
        Mon, 26 Oct 2020 13:10:26 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E11D13F68F;
        Mon, 26 Oct 2020 13:10:24 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v2 1/6] firmware: arm_scmi: rework scmi_sensors_protocol_init
Date:   Mon, 26 Oct 2020 20:10:02 +0000
Message-Id: <20201026201007.23591-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026201007.23591-1-cristian.marussi@arm.com>
References: <20201026201007.23591-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly handle return values from initialization helpers and avoid
setting sensor_ops before sensor_priv.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index b4232d611033..6aaff478d032 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) Sensor Protocol
  *
- * Copyright (C) 2018 ARM Ltd.
+ * Copyright (C) 2018-2020 ARM Ltd.
  */
 
 #define pr_fmt(fmt) "SCMI Notifications SENSOR - " fmt
@@ -334,6 +334,7 @@ static const struct scmi_event_ops sensor_event_ops = {
 static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 {
 	u32 version;
+	int ret;
 	struct sensors_info *sinfo;
 
 	scmi_version_get(handle, SCMI_PROTOCOL_SENSOR, &version);
@@ -344,15 +345,19 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 	sinfo = devm_kzalloc(handle->dev, sizeof(*sinfo), GFP_KERNEL);
 	if (!sinfo)
 		return -ENOMEM;
+	sinfo->version = version;
 
-	scmi_sensor_attributes_get(handle, sinfo);
-
+	ret = scmi_sensor_attributes_get(handle, sinfo);
+	if (ret)
+		return ret;
 	sinfo->sensors = devm_kcalloc(handle->dev, sinfo->num_sensors,
 				      sizeof(*sinfo->sensors), GFP_KERNEL);
 	if (!sinfo->sensors)
 		return -ENOMEM;
 
-	scmi_sensor_description_get(handle, sinfo);
+	ret = scmi_sensor_description_get(handle, sinfo);
+	if (ret)
+		return ret;
 
 	scmi_register_protocol_events(handle,
 				      SCMI_PROTOCOL_SENSOR, SCMI_PROTO_QUEUE_SZ,
@@ -360,9 +365,8 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 				      ARRAY_SIZE(sensor_events),
 				      sinfo->num_sensors);
 
-	sinfo->version = version;
-	handle->sensor_ops = &sensor_ops;
 	handle->sensor_priv = sinfo;
+	handle->sensor_ops = &sensor_ops;
 
 	return 0;
 }
-- 
2.17.1

