Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372E12B3881
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 20:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgKOTWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 14:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgKOTWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 14:22:06 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB25C0613D1;
        Sun, 15 Nov 2020 11:22:06 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so16452027wrw.10;
        Sun, 15 Nov 2020 11:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hmke5hD5ixk6/oJQn6iEQf5E+iJzWp8ycd7dsyeT46o=;
        b=ZhiLO+sPnZ9sX0b2Ib8QXU9k1bP7EGPYbGDJo9XtPpX/IPWT+1oIBPR2tg1fvUXrDJ
         RKKVqeZuLSyPt3KbGUmxzvrhywIdBoRy0Dvo1ArwdWao5b4jG228XwEeaol3VsL4omom
         wftnBXFCoQ3xJ+GzaZ6sH6TdHoh/SJ+8/KmhJlN2FAngSicUpnY5VobKzTIbXgqQI0pJ
         QhgO8H8/dqseWuk1PJGHBjty1zQhQ7uFwgake7RTJxAXL+TWMoNuKDAMWdwf6OzeFPRH
         +YjopWkEoMSb3KPgJC/10GxpPAB7W3RXv1McFlyP9016pUmfB6+ivXk0mQZdg2m3WBxJ
         w9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hmke5hD5ixk6/oJQn6iEQf5E+iJzWp8ycd7dsyeT46o=;
        b=XupGh+GTqa3Y5gmHwhG3HTAMdSm7IRnt25lq06RWHhP88jAcDpdsIhs0lcozXJKz0i
         xvwhsgF6+l8Aj8ZJwg65vonSHIuGWfzEQGioj+xUUuZ++qR2vokczIgJuk17su4OTmqI
         wXR7l7rxMjYGdLXj7Gk4Hvr2B9wUJxOx0UnahhzNnNhGHz+mZ41WJaqAsPEjIaXK0VBQ
         wCZ75oIv560jl2oC6WGQDIp/sAJqjQGrEU6ehX1GTwe+Ce90McmpDmvGsmbbxbr7hsof
         bg1vn0QYJyjefezHp9W6AI6ZiIKaZMUz2MEzO5SI39WVVs75umqCtYmEqzNNVq14dW6t
         J82Q==
X-Gm-Message-State: AOAM532fsnQmJadFHX7S6ydAsEU49D5X8gjEys98P1TC38Ntyg4SFpE3
        jMsLIyJddh0+C161dkKO1CSrBFvlzxg=
X-Google-Smtp-Source: ABdhPJyCY8ANAD0p8S1GqvjGMUQYPEwHwYN2qBaEXBgUJOnD1QkdUs74DImRSnk7pqpPWcx51uhSIg==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr15410212wrv.122.1605468124830;
        Sun, 15 Nov 2020 11:22:04 -0800 (PST)
Received: from xws.fritz.box (p5487b28b.dip0.t-ipconnect.de. [84.135.178.139])
        by smtp.gmail.com with ESMTPSA id u8sm17106600wmg.6.2020.11.15.11.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:22:04 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/9] platform/surface: aggregator: Add event item allocation caching
Date:   Sun, 15 Nov 2020 20:21:37 +0100
Message-Id: <20201115192143.21571-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115192143.21571-1-luzmaximilian@gmail.com>
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Event items are used for completing Surface Aggregator EC events, i.e.
placing event command data and payload on a workqueue for later
processing to avoid doing said processing directly on the receiver
thread. This means that event items are allocated for each incoming
event, regardless of that event being transmitted via sequenced or
unsequenced packets.

On the Surface Book 3 and Surface Laptop 3, touchpad HID input events
(unsequenced), can constitute a larger amount of traffic, and therefore
allocation of event items. This warrants caching event items to reduce
memory fragmentation. The size of the cached objects is specifically
tuned to accommodate keyboard and touchpad input events and their
payloads on those devices. As a result, this effectively also covers
most other event types. In case of a larger event payload, event item
allocation will fall back to kzalloc().

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../platform/surface/aggregator/controller.c  | 84 +++++++++++++++++--
 .../platform/surface/aggregator/controller.h  |  9 ++
 drivers/platform/surface/aggregator/core.c    | 16 +++-
 3 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index fed5b069489c..1c7d2d7b29f7 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -535,14 +535,74 @@ static void ssam_nf_destroy(struct ssam_nf *nf)
 
 #define SSAM_CPLT_WQ_NAME	"ssam_cpltq"
 
+/*
+ * SSAM_EVENT_ITEM_CACHE_PAYLOAD_LEN - Maximum payload length for a cached
+ * &struct ssam_event_item.
+ *
+ * This length has been chosen to be accommodate standard touchpad and
+ * keyboard input events. Events with larger payloads will be allocated
+ * separately.
+ */
+#define SSAM_EVENT_ITEM_CACHE_PAYLOAD_LEN	32
+
+static struct kmem_cache *ssam_event_item_cache;
+
+/**
+ * ssam_event_item_cache_init() - Initialize the event item cache.
+ */
+int ssam_event_item_cache_init(void)
+{
+	const unsigned int size = sizeof(struct ssam_event_item)
+				  + SSAM_EVENT_ITEM_CACHE_PAYLOAD_LEN;
+	const unsigned int align = __alignof__(struct ssam_event_item);
+	struct kmem_cache *cache;
+
+	cache = kmem_cache_create("ssam_event_item", size, align, 0, NULL);
+	if (!cache)
+		return -ENOMEM;
+
+	ssam_event_item_cache = cache;
+	return 0;
+}
+
+/**
+ * ssam_event_item_cache_destroy() - Deinitialize the event item cache.
+ */
+void ssam_event_item_cache_destroy(void)
+{
+	kmem_cache_destroy(ssam_event_item_cache);
+	ssam_event_item_cache = NULL;
+}
+
+static void __ssam_event_item_free_cached(struct ssam_event_item *item)
+{
+	kmem_cache_free(ssam_event_item_cache, item);
+}
+
+static void __ssam_event_item_free_generic(struct ssam_event_item *item)
+{
+	kfree(item);
+}
+
+/**
+ * ssam_event_item_free() - Free the provided event item.
+ * @item: The event item to free.
+ */
+static void ssam_event_item_free(struct ssam_event_item *item)
+{
+	item->ops.free(item);
+}
+
 /**
  * ssam_event_item_alloc() - Allocate an event item with the given payload size.
  * @len:   The event payload length.
  * @flags: The flags used for allocation.
  *
- * Allocate an event item with the given payload size. Sets the item
- * operations and payload length values. The item free callback (``ops.free``)
- * should not be overwritten after this call.
+ * Allocate an event item with the given payload size, preferring allocation
+ * from the event item cache if the payload is small enough (i.e. smaller than
+ * %SSAM_EVENT_ITEM_CACHE_PAYLOAD_LEN). Sets the item operations and payload
+ * length values. The item free callback (``ops.free``) should not be
+ * overwritten after this call.
  *
  * Return: Returns the newly allocated event item.
  */
@@ -550,9 +610,19 @@ static struct ssam_event_item *ssam_event_item_alloc(size_t len, gfp_t flags)
 {
 	struct ssam_event_item *item;
 
-	item = kzalloc(sizeof(*item) + len, GFP_KERNEL);
-	if (!item)
-		return NULL;
+	if (len <= SSAM_EVENT_ITEM_CACHE_PAYLOAD_LEN) {
+		item = kmem_cache_alloc(ssam_event_item_cache, GFP_KERNEL);
+		if (!item)
+			return NULL;
+
+		item->ops.free = __ssam_event_item_free_cached;
+	} else {
+		item = kzalloc(sizeof(*item) + len, GFP_KERNEL);
+		if (!item)
+			return NULL;
+
+		item->ops.free = __ssam_event_item_free_generic;
+	}
 
 	item->event.length = len;
 	return item;
@@ -714,7 +784,7 @@ static void ssam_event_queue_work_fn(struct work_struct *work)
 			return;
 
 		ssam_nf_call(nf, dev, item->rqid, &item->event);
-		kfree(item);
+		ssam_event_item_free(item);
 	}
 
 	if (!ssam_event_queue_is_empty(queue))
diff --git a/drivers/platform/surface/aggregator/controller.h b/drivers/platform/surface/aggregator/controller.h
index 7688cbc7d0ae..96e2b87a25d9 100644
--- a/drivers/platform/surface/aggregator/controller.h
+++ b/drivers/platform/surface/aggregator/controller.h
@@ -81,12 +81,18 @@ struct ssam_cplt;
  * struct ssam_event_item - Struct for event queuing and completion.
  * @node:     The node in the queue.
  * @rqid:     The request ID of the event.
+ * @ops:      Instance specific functions.
+ * @ops.free: Callback for freeing this event item.
  * @event:    Actual event data.
  */
 struct ssam_event_item {
 	struct list_head node;
 	u16 rqid;
 
+	struct {
+		void (*free)(struct ssam_event_item *event);
+	} ops;
+
 	struct ssam_event event;	// must be last
 };
 
@@ -276,4 +282,7 @@ int ssam_ctrl_notif_d0_entry(struct ssam_controller *ctrl);
 int ssam_controller_suspend(struct ssam_controller *ctrl);
 int ssam_controller_resume(struct ssam_controller *ctrl);
 
+int ssam_event_item_cache_init(void);
+void ssam_event_item_cache_destroy(void);
+
 #endif /* _SURFACE_AGGREGATOR_CONTROLLER_H */
diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 5c01d598a479..733a7d46ee07 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -782,12 +782,23 @@ static int __init ssam_core_init(void)
 
 	status = ssh_ctrl_packet_cache_init();
 	if (status)
-		return status;
+		goto err_cpkg;
+
+	status = ssam_event_item_cache_init();
+	if (status)
+		goto err_evitem;
 
 	status = serdev_device_driver_register(&ssam_serial_hub);
 	if (status)
-		ssh_ctrl_packet_cache_destroy();
+		goto err_register;
 
+	return 0;
+
+err_register:
+	ssam_event_item_cache_destroy();
+err_evitem:
+	ssh_ctrl_packet_cache_destroy();
+err_cpkg:
 	return status;
 }
 module_init(ssam_core_init);
@@ -795,6 +806,7 @@ module_init(ssam_core_init);
 static void __exit ssam_core_exit(void)
 {
 	serdev_device_driver_unregister(&ssam_serial_hub);
+	ssam_event_item_cache_destroy();
 	ssh_ctrl_packet_cache_destroy();
 }
 module_exit(ssam_core_exit);
-- 
2.29.2

