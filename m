Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A692FFC58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 06:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbhAVFrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 00:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbhAVFrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 00:47:33 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD91C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:46:51 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i5so2981596pgo.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rqNleKh0i5JJwRxkcTOeVbk2a4dNXv/AWiKewmTsbAM=;
        b=LZuczRiSo/XLTmeOCVGZ31QRgbv0X1Gii2mlW5N8RRTggm5x3crei8OhdtSOop3jlN
         QIpvWhg7TNmd02LKwt31Zh/smC2cCPC4uqKx+4Qw7HAOQSksFIiKeho/Ri/x9tc+9lag
         p0qr8SXsaunQGy7dEmXo5+iLpbcLy+IX+3XNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqNleKh0i5JJwRxkcTOeVbk2a4dNXv/AWiKewmTsbAM=;
        b=NdSEuIhABiMRcDgdC85Iy6MkODmeZWvk59OeKBUgAPkqN7yM2+FInYWq/Afn6xiuaX
         YlJV1cTHXQZErpRwjIzIZ3M61L2KTPSvzMOOCh4ylJn6nw16CivZqe6wi0JDGFxgTLe1
         nb+I/g2VX6T7r42VIAYKrkwaqp3/h5kLM7G4WE98MmVBz8/24DmPgnIRRzta0f2Ggax3
         7s+N/qOhyC3pRqwfD/tBXsdQaEG2ESpTFQAYckneJwIcc47arefsOPHl8UgJkc/NmXxS
         uSXm+Zrzn8QalGupAY7ErfOeOAIqMldKrvk7QSEntkB1k8yOV55+1KQowlyAU1cGYu+/
         5fBA==
X-Gm-Message-State: AOAM532P2yX4nZkKFdo/ze5MDoHXhnGa99ylOvzCjLlRS5/eiPDnR7ks
        8K2+/+OkgwMlvWV52hLQfEiV9A==
X-Google-Smtp-Source: ABdhPJwrj94kx9KahmrATqeWzvw5OopxvrTNzfgFtP6C3s7SUfgIJXM4VESKlR+TrG+w4CoT9WwlOA==
X-Received: by 2002:a62:aa03:0:b029:1b9:7cb5:bbde with SMTP id e3-20020a62aa030000b02901b97cb5bbdemr3448476pff.14.1611294411255;
        Thu, 21 Jan 2021 21:46:51 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id e63sm7487774pfe.216.2021.01.21.21.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 21:46:50 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     rdunlap@infradead.org, groeck@chromium.org,
        enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 1/2] platform: cros_ec: Call interrupt bottom half in ISH or RPMSG mode
Date:   Thu, 21 Jan 2021 21:46:36 -0800
Message-Id: <20210122054637.1422289-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210122054637.1422289-1-gwendal@chromium.org>
References: <20210122054637.1422289-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the same bottom half for all EC protocols (threaded code).

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- Fix merge issues, make changes in cros_ec.h instead of cros_ec_proto.h
- Fix function comments syntax.

 drivers/platform/chrome/cros_ec.c       | 26 +++++++++++++++++++------
 drivers/platform/chrome/cros_ec.h       |  4 +++-
 drivers/platform/chrome/cros_ec_ishtp.c |  6 +-----
 drivers/platform/chrome/cros_ec_rpmsg.c |  6 +-----
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 3104680b7485..bf76a6c49c95 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -32,7 +32,14 @@ static struct cros_ec_platform pd_p = {
 	.cmd_offset = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX),
 };
 
-static irqreturn_t ec_irq_handler(int irq, void *data)
+/**
+ * cros_ec_irq_handler() - top half part of the interrupt handler
+ * @irq: IRQ id
+ * @data: (ec_dev) Device with events to process.
+ *
+ * Return: Wakeup the bottom half
+ */
+static irqreturn_t cros_ec_irq_handler(int irq, void *data)
 {
 	struct cros_ec_device *ec_dev = data;
 
@@ -51,7 +58,7 @@ static irqreturn_t ec_irq_handler(int irq, void *data)
  * Return: true if more events are still pending and this function should be
  * called again.
  */
-bool cros_ec_handle_event(struct cros_ec_device *ec_dev)
+static bool cros_ec_handle_event(struct cros_ec_device *ec_dev)
 {
 	bool wake_event;
 	bool ec_has_more_events;
@@ -73,9 +80,15 @@ bool cros_ec_handle_event(struct cros_ec_device *ec_dev)
 
 	return ec_has_more_events;
 }
-EXPORT_SYMBOL(cros_ec_handle_event);
 
-static irqreturn_t ec_irq_thread(int irq, void *data)
+/**
+ * cros_ec_irq_thread() - bottom half part of the interrupt handler
+ * @irq: IRQ id
+ * @data: (ec_dev) Device with events to process.
+ *
+ * Return: Interrupt handled.
+ */
+irqreturn_t cros_ec_irq_thread(int irq, void *data)
 {
 	struct cros_ec_device *ec_dev = data;
 	bool ec_has_more_events;
@@ -86,6 +99,7 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL(cros_ec_irq_thread);
 
 static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 {
@@ -194,8 +208,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 
 	if (ec_dev->irq > 0) {
 		err = devm_request_threaded_irq(dev, ec_dev->irq,
-						ec_irq_handler,
-						ec_irq_thread,
+						cros_ec_irq_handler,
+						cros_ec_irq_thread,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"chromeos-ec", ec_dev);
 		if (err) {
diff --git a/drivers/platform/chrome/cros_ec.h b/drivers/platform/chrome/cros_ec.h
index e69fc1ff68b4..78363dcfdf23 100644
--- a/drivers/platform/chrome/cros_ec.h
+++ b/drivers/platform/chrome/cros_ec.h
@@ -8,12 +8,14 @@
 #ifndef __CROS_EC_H
 #define __CROS_EC_H
 
+#include <linux/interrupt.h>
+
 int cros_ec_register(struct cros_ec_device *ec_dev);
 int cros_ec_unregister(struct cros_ec_device *ec_dev);
 
 int cros_ec_suspend(struct cros_ec_device *ec_dev);
 int cros_ec_resume(struct cros_ec_device *ec_dev);
 
-bool cros_ec_handle_event(struct cros_ec_device *ec_dev);
+irqreturn_t cros_ec_irq_thread(int irq, void *data);
 
 #endif /* __CROS_EC_H */
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 81364029af36..f00107017318 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -140,12 +140,8 @@ static void ish_evt_handler(struct work_struct *work)
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
index 30d0ba3b8889..d96d15b8ca94 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -149,12 +149,8 @@ cros_ec_rpmsg_host_event_function(struct work_struct *host_event_work)
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
-- 
2.30.0.280.ga3ce27912f-goog

