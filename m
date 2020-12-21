Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10962E0017
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgLUSlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgLUSlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:41:00 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC73C061248;
        Mon, 21 Dec 2020 10:40:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a6so10808078wmc.2;
        Mon, 21 Dec 2020 10:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bQ46+v5WsJ5pb5Dy1AnTrAdXkjlr4FPXsW4mcGL9lB0=;
        b=BpPbEqW28ru80zzxOXwHBL15iBz/OUpN1C+wrSg5V+X/FDfjBPaDnSRZxnH+iJAC32
         y5HYdlDgOMGFhhTzL81fV62wfuMJ/SkPIHYMGq7kNEeLJZQ8ksxwNq/ddC2OFJDMUH29
         b0UEThuf/xXtzY5DEhaEORf0Qd2/VQY78PKPcsWfneZdnRXBIdEF/oCI8orVXf1hRaEp
         XzZilByXwZckPOybv5777YiDCB3HM7m+Ot+kULJ6TrmHOc6NJVq4/f/Wh+4kMEDYBfRp
         jNowZHGiuhuzQYG+BdjvCaIo+sDWOcaqGbsNDXiVLymwvVZIEc3pF20SFtZJpkShUpFK
         yXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bQ46+v5WsJ5pb5Dy1AnTrAdXkjlr4FPXsW4mcGL9lB0=;
        b=RvjMR2S5Q6HbPJs7Mr8tgyrr11hTA8g7gbcdbQQlhbrhQvJNrLGSnMrplCF14k7NdW
         Wk7e3eB7I4lv8F9I9FEgiTgD36Zk9p2NnDeT/6kCDQUJNkUryPAF4k9ZGUez2Z8y00f8
         xt3MdTn/8G4xWjzUG8eFDdsQmDFgkv5rHcsTylEN0iiIngJmdw0SbZe3AS3tcWE1f7yV
         BaPxiv2xdCCYdIXQNb1i5OXv7TfGqIYcgs5OAiQVirjEJYgd4VCSA5m6AdEQIburV8Tv
         +/K8uLNEWRxf7EK5Smdg98H8o1iWWxzGf+qHWRob21XgV/j6EAliCL5G2qd2kagYOdzn
         SDxA==
X-Gm-Message-State: AOAM530D0R+U6OwCweRVrsAqMbdUq4AaTvz92k534ERjKVeo1cfBvkBw
        X4i2NR3m2tcmxw8+pcb4rY7StpXv8jXaLA==
X-Google-Smtp-Source: ABdhPJyHgonaRYVkmJse9T6wTqnCv91oPc5hqg81LY0160RVC9WbGrAg0mv+nrXjB7eY1SxQo4q89Q==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr18285183wmi.36.1608576018257;
        Mon, 21 Dec 2020 10:40:18 -0800 (PST)
Received: from xws.fritz.box (pd9e5aae0.dip0.t-ipconnect.de. [217.229.170.224])
        by smtp.gmail.com with ESMTPSA id j7sm24528310wmb.40.2020.12.21.10.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:40:17 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 3/9] platform/surface: aggregator: Add event item allocation caching
Date:   Mon, 21 Dec 2020 19:39:53 +0100
Message-Id: <20201221183959.1186143-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221183959.1186143-1-luzmaximilian@gmail.com>
References: <20201221183959.1186143-1-luzmaximilian@gmail.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 .../platform/surface/aggregator/controller.c  | 86 +++++++++++++++++--
 .../platform/surface/aggregator/controller.h  |  9 ++
 drivers/platform/surface/aggregator/core.c    | 16 +++-
 3 files changed, 101 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 488318cf2098..775a4509bece 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -513,14 +513,74 @@ static void ssam_nf_destroy(struct ssam_nf *nf)
  */
 #define SSAM_CPLT_WQ_BATCH	10
 
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
@@ -528,9 +588,19 @@ static struct ssam_event_item *ssam_event_item_alloc(size_t len, gfp_t flags)
 {
 	struct ssam_event_item *item;
 
-	item = kzalloc(struct_size(item, event.data, len), flags);
-	if (!item)
-		return NULL;
+	if (len <= SSAM_EVENT_ITEM_CACHE_PAYLOAD_LEN) {
+		item = kmem_cache_alloc(ssam_event_item_cache, flags);
+		if (!item)
+			return NULL;
+
+		item->ops.free = __ssam_event_item_free_cached;
+	} else {
+		item = kzalloc(struct_size(item, event.data, len), flags);
+		if (!item)
+			return NULL;
+
+		item->ops.free = __ssam_event_item_free_generic;
+	}
 
 	item->event.length = len;
 	return item;
@@ -692,7 +762,7 @@ static void ssam_event_queue_work_fn(struct work_struct *work)
 			return;
 
 		ssam_nf_call(nf, dev, item->rqid, &item->event);
-		kfree(item);
+		ssam_event_item_free(item);
 	} while (--iterations);
 
 	if (!ssam_event_queue_is_empty(queue))
@@ -900,7 +970,7 @@ static void ssam_handle_event(struct ssh_rtl *rtl,
 	memcpy(&item->event.data[0], data->ptr, data->len);
 
 	if (WARN_ON(ssam_cplt_submit_event(&ctrl->cplt, item)))
-		kfree(item);
+		ssam_event_item_free(item);
 }
 
 static const struct ssh_rtl_ops ssam_rtl_ops = {
diff --git a/drivers/platform/surface/aggregator/controller.h b/drivers/platform/surface/aggregator/controller.h
index 5ee9e966f1d7..8297d34e7489 100644
--- a/drivers/platform/surface/aggregator/controller.h
+++ b/drivers/platform/surface/aggregator/controller.h
@@ -80,12 +80,18 @@ struct ssam_cplt;
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
 	struct ssam_event event;	/* must be last */
 };
 
@@ -273,4 +279,7 @@ int ssam_ctrl_notif_d0_entry(struct ssam_controller *ctrl);
 int ssam_controller_suspend(struct ssam_controller *ctrl);
 int ssam_controller_resume(struct ssam_controller *ctrl);
 
+int ssam_event_item_cache_init(void);
+void ssam_event_item_cache_destroy(void);
+
 #endif /* _SURFACE_AGGREGATOR_CONTROLLER_H */
diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 60d312f71436..37593234fb31 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -790,12 +790,23 @@ static int __init ssam_core_init(void)
 
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
@@ -803,6 +814,7 @@ module_init(ssam_core_init);
 static void __exit ssam_core_exit(void)
 {
 	serdev_device_driver_unregister(&ssam_serial_hub);
+	ssam_event_item_cache_destroy();
 	ssh_ctrl_packet_cache_destroy();
 }
 module_exit(ssam_core_exit);
-- 
2.29.2

