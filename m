Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC1A2D6B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbgLJW70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 17:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732423AbgLJW7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:59:01 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F02C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 14:58:46 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id p4so5613513pfg.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 14:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GSBxKfBtPntEjiT6G1oMVfgwfggtIyFbL7Z/hYvh9ME=;
        b=Rok09H9+xQHhL68eL5M/k+JkdCVaHwmb711olqZ68/w+q0Lz0X9igDqm+/6yBB1tfz
         b6kHRGusxTyVi8lruY49mFCFhm+YOuLKVpygDYT7uz/7U/yI44HJN3hKEdMZeMLDTjcJ
         QucpVMB85xJiqhoX5Lamt5kK+VQ4C8Z6HMShU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GSBxKfBtPntEjiT6G1oMVfgwfggtIyFbL7Z/hYvh9ME=;
        b=Z4RMURCEuFlvzEQpfLmkS/LPjQAt4gUpai2+fQkDAUDFTecWjnLnY9RLpYh4t9vOrE
         yNaM/SkjC8AYYYrNsMvXcw06KY3pbw+nlw7gPU8cUgdF0Z5XYVm+5CYMXbXqHFJFu1zR
         OPr1aJwzqP2IqWA6oJoOgxzXtVXBdcU/un4HHRCsykx0OyzcVlB/wWNFqaJ76KPr7c5o
         Zi73V6GuG4jNbssTf5Jix7SgyBSRrgr++aIJOx+QcNScdasDGdYjjRYbW4aMQr83clTl
         WCMT4nKyarsn0DeNzTKX3FwLEBcykl+IqHt85W0dtSVOObTUuq6GkHh05pHBq+8pG8yW
         Eblw==
X-Gm-Message-State: AOAM533mPRDRuW/NMLADr4Szv1a0de9tiw+Wj/tixwE1uF0zhSXHMdY0
        +NCLKYKC+OP8zL6j6cKQ0BwxUQ==
X-Google-Smtp-Source: ABdhPJyHBpDtyP44R4Us8YCO5wy+IL4hiRb1PO+7DunMAMRhFBfXsGsD29ulmIdLPVWSPSxeriXKRA==
X-Received: by 2002:a65:689a:: with SMTP id e26mr4191809pgt.413.1607641125703;
        Thu, 10 Dec 2020 14:58:45 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id e8sm4427635pfn.176.2020.12.10.14.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 14:58:45 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/2] platform: cros_ec: Call interrupt bottom half in ISH or RPMSG mode
Date:   Thu, 10 Dec 2020 14:58:38 -0800
Message-Id: <20201210225839.1212462-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210225839.1212462-1-gwendal@chromium.org>
References: <20201210225839.1212462-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the same bottom half for all EC protocols (threaded code).

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec.c           | 26 ++++++++++++++++-----
 drivers/platform/chrome/cros_ec_ishtp.c     |  6 +----
 drivers/platform/chrome/cros_ec_rpmsg.c     |  6 +----
 include/linux/platform_data/cros_ec_proto.h |  3 ++-
 4 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 6d6ce86a1408a..4ac33491d0d18 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -31,7 +31,14 @@ static struct cros_ec_platform pd_p = {
 	.cmd_offset = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX),
 };
 
-static irqreturn_t ec_irq_handler(int irq, void *data)
+/**
+ * cros_ec_irq_handler: top half part of the interrupt handler
+ * @irq: IRQ id
+ * @data: (ec_dev) Device with events to process.
+ *
+ * Return: Wakeup the bottom half
+ */
+static irqreturn_t cros_ec_irq_handler(int irq, void *data)
 {
 	struct cros_ec_device *ec_dev = data;
 
@@ -50,7 +57,7 @@ static irqreturn_t ec_irq_handler(int irq, void *data)
  * Return: true if more events are still pending and this function should be
  * called again.
  */
-bool cros_ec_handle_event(struct cros_ec_device *ec_dev)
+static bool cros_ec_handle_event(struct cros_ec_device *ec_dev)
 {
 	bool wake_event;
 	bool ec_has_more_events;
@@ -72,9 +79,15 @@ bool cros_ec_handle_event(struct cros_ec_device *ec_dev)
 
 	return ec_has_more_events;
 }
-EXPORT_SYMBOL(cros_ec_handle_event);
 
-static irqreturn_t ec_irq_thread(int irq, void *data)
+/**
+ * cros_ec_irq_thread: bottom half part of the interrupt handler
+ * @irq: IRQ id
+ * @data: (ec_dev) Device with events to process.
+ *
+ * Return: Interrupt handled.
+ */
+irqreturn_t cros_ec_irq_thread(int irq, void *data)
 {
 	struct cros_ec_device *ec_dev = data;
 	bool ec_has_more_events;
@@ -85,6 +98,7 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL(cros_ec_irq_thread);
 
 static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 {
@@ -175,8 +189,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 
 	if (ec_dev->irq > 0) {
 		err = devm_request_threaded_irq(dev, ec_dev->irq,
-						ec_irq_handler,
-						ec_irq_thread,
+						cros_ec_irq_handler,
+						cros_ec_irq_thread,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"chromeos-ec", ec_dev);
 		if (err) {
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 316cb4bee80d3..62c03be0183a2 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -138,12 +138,8 @@ static void ish_evt_handler(struct work_struct *work)
 {
 	struct ishtp_cl_data *client_data =
 		container_of(work, struct ishtp_cl_data, work_ec_evt);
-	struct cros_ec_device *ec_dev = client_data->ec_dev;
-	bool ec_has_more_events;
 
-	do {
-		ec_has_more_events = cros_ec_handle_event(ec_dev);
-	} while (ec_has_more_events);
+	cros_ec_irq_thread(0, client_data->ec_dev);
 }
 
 /**
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index 1b38bc8e164c3..12ddc5a4729b7 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -144,12 +144,8 @@ cros_ec_rpmsg_host_event_function(struct work_struct *host_event_work)
 	struct cros_ec_rpmsg *ec_rpmsg = container_of(host_event_work,
 						      struct cros_ec_rpmsg,
 						      host_event_work);
-	struct cros_ec_device *ec_dev = dev_get_drvdata(&ec_rpmsg->rpdev->dev);
-	bool ec_has_more_events;
 
-	do {
-		ec_has_more_events = cros_ec_handle_event(ec_dev);
-	} while (ec_has_more_events);
+	cros_ec_irq_thread(0, dev_get_drvdata(&ec_rpmsg->rpdev->dev));
 }
 
 static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 8776041d5cead..37cfd05d30a0b 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -9,6 +9,7 @@
 #define __LINUX_CROS_EC_PROTO_H
 
 #include <linux/device.h>
+#include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/power_supply.h>
@@ -241,7 +242,7 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
 
 int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
 
-bool cros_ec_handle_event(struct cros_ec_device *ec_dev);
+irqreturn_t cros_ec_irq_thread(int irq, void *data);
 
 /**
  * cros_ec_get_time_ns() - Return time in ns.
-- 
2.29.2.576.ga3fc446d84-goog

