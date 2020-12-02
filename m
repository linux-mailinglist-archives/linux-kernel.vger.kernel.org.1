Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769EF2CC809
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgLBUl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:41:58 -0500
Received: from foss.arm.com ([217.140.110.172]:50436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731185AbgLBUl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:41:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65B9D143D;
        Wed,  2 Dec 2020 12:40:39 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A85183F575;
        Wed,  2 Dec 2020 12:40:32 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 05/37] firmware: arm_scmi: make notifications aware of protocols users
Date:   Wed,  2 Dec 2020 20:39:37 +0000
Message-Id: <20201202204009.32073-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Account for any active registered notifier against the proper related
protocol; do not consider pending event handlers, only active handlers
will concur to protocol usage accounting.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/notify.c | 51 ++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 66196b293b6c..cdaf0f962d84 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -91,6 +91,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+#include "common.h"
 #include "notify.h"
 
 #define SCMI_MAX_PROTO		256
@@ -368,7 +369,7 @@ static struct scmi_event_handler *
 scmi_get_active_handler(struct scmi_notify_instance *ni, u32 evt_key);
 static void scmi_put_active_handler(struct scmi_notify_instance *ni,
 				    struct scmi_event_handler *hndl);
-static void scmi_put_handler_unlocked(struct scmi_notify_instance *ni,
+static bool scmi_put_handler_unlocked(struct scmi_notify_instance *ni,
 				      struct scmi_event_handler *hndl);
 
 /**
@@ -900,9 +901,21 @@ static inline int scmi_bind_event_handler(struct scmi_notify_instance *ni,
 	if (!r_evt)
 		return -EINVAL;
 
-	/* Remove from pending and insert into registered */
+	/*
+	 * Remove from pending and insert into registered while getting hold
+	 * of protocol instance.
+	 */
 	hash_del(&hndl->hash);
+	/*
+	 * Acquire protocols only for NON pending handlers, so as NOT to trigger
+	 * protocol initialization when a notifier is registered against a still
+	 * not registered protocol, since it would make little sense to force init
+	 * protocols for which still no SCMI driver user exists: they wouldn't
+	 * emit any event anyway till some SCMI driver starts using it.
+	 */
+	scmi_acquire_protocol(ni->handle, KEY_XTRACT_PROTO_ID(hndl->key));
 	hndl->r_evt = r_evt;
+
 	mutex_lock(&r_evt->proto->registered_mtx);
 	hash_add(r_evt->proto->registered_events_handlers,
 		 &hndl->hash, hndl->key);
@@ -1193,41 +1206,65 @@ static int scmi_disable_events(struct scmi_event_handler *hndl)
  * * unregister and free the handler itself
  *
  * Context: Assumes all the proper locking has been managed by the caller.
+ *
+ * Return: True if handler was freed (users dropped to zero)
  */
-static void scmi_put_handler_unlocked(struct scmi_notify_instance *ni,
+static bool scmi_put_handler_unlocked(struct scmi_notify_instance *ni,
 				      struct scmi_event_handler *hndl)
 {
+	bool freed = false;
+
 	if (refcount_dec_and_test(&hndl->users)) {
 		if (!IS_HNDL_PENDING(hndl))
 			scmi_disable_events(hndl);
 		scmi_free_event_handler(hndl);
+		freed = true;
 	}
+
+	return freed;
 }
 
 static void scmi_put_handler(struct scmi_notify_instance *ni,
 			     struct scmi_event_handler *hndl)
 {
+	bool freed;
+	u8 protocol_id;
 	struct scmi_registered_event *r_evt = hndl->r_evt;
 
 	mutex_lock(&ni->pending_mtx);
-	if (r_evt)
+	if (r_evt) {
+		protocol_id = r_evt->proto->id;
 		mutex_lock(&r_evt->proto->registered_mtx);
+	}
 
-	scmi_put_handler_unlocked(ni, hndl);
+	freed = scmi_put_handler_unlocked(ni, hndl);
 
-	if (r_evt)
+	if (r_evt) {
 		mutex_unlock(&r_evt->proto->registered_mtx);
+		/*
+		 * Only registered handler acquired protocol; must be here
+		 * released only AFTER unlocking registered_mtx, since
+		 * releasing a protocol can trigger its de-initialization
+		 * (ie. including r_evt and registered_mtx)
+		 */
+		if (freed)
+			scmi_release_protocol(ni->handle, protocol_id);
+	}
 	mutex_unlock(&ni->pending_mtx);
 }
 
 static void scmi_put_active_handler(struct scmi_notify_instance *ni,
 				    struct scmi_event_handler *hndl)
 {
+	bool freed;
 	struct scmi_registered_event *r_evt = hndl->r_evt;
+	u8 protocol_id = r_evt->proto->id;
 
 	mutex_lock(&r_evt->proto->registered_mtx);
-	scmi_put_handler_unlocked(ni, hndl);
+	freed = scmi_put_handler_unlocked(ni, hndl);
 	mutex_unlock(&r_evt->proto->registered_mtx);
+	if (freed)
+		scmi_release_protocol(ni->handle, protocol_id);
 }
 
 /**
-- 
2.17.1

