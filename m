Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92452CC812
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbgLBUmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:20 -0500
Received: from foss.arm.com ([217.140.110.172]:50434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388068AbgLBUmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A313113E;
        Wed,  2 Dec 2020 12:41:10 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5284E3F575;
        Wed,  2 Dec 2020 12:41:08 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 22/37] reset: reset-scmi: port driver to the new scmi_reset_proto_ops interface
Date:   Wed,  2 Dec 2020 20:39:54 +0000
Message-Id: <20201202204009.32073-23-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port driver to the new SCMI Reset interface based on protocol handles
and common devm_get_ops().

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/reset/reset-scmi.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
index 8d3a858e3b19..ec77d40e64ad 100644
--- a/drivers/reset/reset-scmi.c
+++ b/drivers/reset/reset-scmi.c
@@ -2,7 +2,7 @@
 /*
  * ARM System Control and Management Interface (ARM SCMI) reset driver
  *
- * Copyright (C) 2019 ARM Ltd.
+ * Copyright (C) 2019-2020 ARM Ltd.
  */
 
 #include <linux/module.h>
@@ -11,18 +11,20 @@
 #include <linux/reset-controller.h>
 #include <linux/scmi_protocol.h>
 
+static const struct scmi_reset_proto_ops *reset_ops;
+
 /**
  * struct scmi_reset_data - reset controller information structure
  * @rcdev: reset controller entity
- * @handle: ARM SCMI handle used for communication with system controller
+ * @ph: ARM SCMI protocol handle used for communication with system controller
  */
 struct scmi_reset_data {
 	struct reset_controller_dev rcdev;
-	const struct scmi_handle *handle;
+	const struct scmi_protocol_handle *ph;
 };
 
 #define to_scmi_reset_data(p)	container_of((p), struct scmi_reset_data, rcdev)
-#define to_scmi_handle(p)	(to_scmi_reset_data(p)->handle)
+#define to_scmi_handle(p)	(to_scmi_reset_data(p)->ph)
 
 /**
  * scmi_reset_assert() - assert device reset
@@ -37,9 +39,9 @@ struct scmi_reset_data {
 static int
 scmi_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 {
-	const struct scmi_handle *handle = to_scmi_handle(rcdev);
+	const struct scmi_protocol_handle *ph = to_scmi_handle(rcdev);
 
-	return handle->reset_ops->assert(handle, id);
+	return reset_ops->assert(ph, id);
 }
 
 /**
@@ -55,9 +57,9 @@ scmi_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 static int
 scmi_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 {
-	const struct scmi_handle *handle = to_scmi_handle(rcdev);
+	const struct scmi_protocol_handle *ph = to_scmi_handle(rcdev);
 
-	return handle->reset_ops->deassert(handle, id);
+	return reset_ops->deassert(ph, id);
 }
 
 /**
@@ -73,9 +75,9 @@ scmi_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 static int
 scmi_reset_reset(struct reset_controller_dev *rcdev, unsigned long id)
 {
-	const struct scmi_handle *handle = to_scmi_handle(rcdev);
+	const struct scmi_protocol_handle *ph = to_scmi_handle(rcdev);
 
-	return handle->reset_ops->reset(handle, id);
+	return reset_ops->reset(ph, id);
 }
 
 static const struct reset_control_ops scmi_reset_ops = {
@@ -90,10 +92,15 @@ static int scmi_reset_probe(struct scmi_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	const struct scmi_handle *handle = sdev->handle;
+	struct scmi_protocol_handle *ph;
 
-	if (!handle || !handle->reset_ops)
+	if (!handle)
 		return -ENODEV;
 
+	reset_ops = handle->devm_get_ops(sdev, SCMI_PROTOCOL_RESET, &ph);
+	if (IS_ERR(reset_ops))
+		return PTR_ERR(reset_ops);
+
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -101,8 +108,8 @@ static int scmi_reset_probe(struct scmi_device *sdev)
 	data->rcdev.ops = &scmi_reset_ops;
 	data->rcdev.owner = THIS_MODULE;
 	data->rcdev.of_node = np;
-	data->rcdev.nr_resets = handle->reset_ops->num_domains_get(handle);
-	data->handle = handle;
+	data->rcdev.nr_resets = reset_ops->num_domains_get(ph);
+	data->ph = ph;
 
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
-- 
2.17.1

