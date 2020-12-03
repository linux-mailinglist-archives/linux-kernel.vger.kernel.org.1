Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BC32CE09F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388015AbgLCV1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbgLCV1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:27:45 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46E3C061A53;
        Thu,  3 Dec 2020 13:27:04 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a16so5665388ejj.5;
        Thu, 03 Dec 2020 13:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m8g8xn3BH5zB7XtD8su7ih6cQIyY8kQr5+ATa+bYHOE=;
        b=iJAnUfQUMVfKOdZAZYi3TfJU2zLqcvieUGsCCAevadSB9d4zF4DaNQ/0LYPYdzJDSE
         9FfIpAx00tpq2W9/W8a4dewp+1S0Lii5ekGn8YoALlb2pjk8eq0Qz/c0uG9OcNY3Vjiu
         lQCxf2S1iWqwRR3Wr7Q/+Tb85eOYB0xTLQU8yJyYfDY/0l3hgKrhsznPmJv0VC1h6f4p
         +dW1vFf+FTB+Saq1Uoi4RzjvPGh/TE17ExdCVk4qwO4tyoV5cFZ/yQaxgcNFReTwOj+u
         XeFflk8ahEjPQAJsNcvlm6fyOUyIK5WP35+aZDr0dZL897YHDiuUR2KLBqjulawpbsbR
         /UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m8g8xn3BH5zB7XtD8su7ih6cQIyY8kQr5+ATa+bYHOE=;
        b=oeZNZGtbPARxyJ9Q2N4kcuoedanLO5i2VL9ISeA+pMeJutcbMdFhIxzjmOst9BwuOq
         IF41NGpbCUhAP4xnFDiDWHCBPO7P6Wg3/k8au5O9daBenElx46UB3+aYfh3xlvr1uMFH
         S7DgV783vIEQPgbavAaAURIjoUTM7vSgPl3/zsZ8W/8bF+Gb+fGQzVpMScA2do2xeBTd
         bNFDoEzvFE+cNeBRcEZ0v9A+g2Hfmxf76ufgGYNbbbFMAhs10zfrQ9zS3mbwhOWoVSnK
         o0AX8BB3BIABcMTHF38M/LqNjCx+EkRSIQYemPh4S7n0BPjtkj6De45igcGY4K9RfEtb
         okrw==
X-Gm-Message-State: AOAM530SxD5CH6x5pXaAcy5XULgYk6oqOUfCjU5Nw4AqmViqJ0o/RGAC
        yYhTSrb5RBHsOCvS9z85dH0GmQtAjvc=
X-Google-Smtp-Source: ABdhPJxV8wozD4aBtk20sfCwY6n8JYEp2WxDEqPq+sGP3eVisJRfnT+y3gPXym31+xxmz/alHgEi5w==
X-Received: by 2002:a17:906:7a18:: with SMTP id d24mr4344296ejo.324.1607030823102;
        Thu, 03 Dec 2020 13:27:03 -0800 (PST)
Received: from xws.fritz.box (pd9e5a6ef.dip0.t-ipconnect.de. [217.229.166.239])
        by smtp.gmail.com with ESMTPSA id e3sm1656169ejq.96.2020.12.03.13.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:27:02 -0800 (PST)
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
Subject: [PATCH v2 3/9] platform/surface: aggregator: Add event item allocation caching
Date:   Thu,  3 Dec 2020 22:26:34 +0100
Message-Id: <20201203212640.663931-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203212640.663931-1-luzmaximilian@gmail.com>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
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
 .../platform/surface/aggregator/controller.c  | 86 +++++++++++++++++--
 .../platform/surface/aggregator/controller.h  |  9 ++
 drivers/platform/surface/aggregator/core.c    | 16 +++-
 3 files changed, 101 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 8d9811cc2943..89ffd8e45787 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -514,14 +514,74 @@ static void ssam_nf_destroy(struct ssam_nf *nf)
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
@@ -529,9 +589,19 @@ static struct ssam_event_item *ssam_event_item_alloc(size_t len, gfp_t flags)
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
@@ -693,7 +763,7 @@ static void ssam_event_queue_work_fn(struct work_struct *work)
 			return;

 		ssam_nf_call(nf, dev, item->rqid, &item->event);
-		kfree(item);
+		ssam_event_item_free(item);
 	} while (--iterations);

 	if (!ssam_event_queue_is_empty(queue))
@@ -893,7 +963,7 @@ static void ssam_handle_event(struct ssh_rtl *rtl,
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
index 77bc4c87541b..1a53d7ce66a1 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -784,12 +784,23 @@ static int __init ssam_core_init(void)

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
@@ -797,6 +808,7 @@ module_init(ssam_core_init);
 static void __exit ssam_core_exit(void)
 {
 	serdev_device_driver_unregister(&ssam_serial_hub);
+	ssam_event_item_cache_destroy();
 	ssh_ctrl_packet_cache_destroy();
 }
 module_exit(ssam_core_exit);
--
2.29.2

