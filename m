Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46802B3882
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 20:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgKOTWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 14:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbgKOTWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 14:22:07 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F1EC0613CF;
        Sun, 15 Nov 2020 11:22:05 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k2so16517561wrx.2;
        Sun, 15 Nov 2020 11:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iu/aWIbrp7kIu5C5ShufKi40TdSl3vZcOeSwZg4KWVw=;
        b=r9zHbG+eudrhZrWs+PtnOTJFLrdJMs5Cy9Dug79M6KGy9J7b+3EwHP7Yd4aBHgRGGd
         wDVil3/JnwkROETF9kpi3RN3AgpKOqnZVsAI+yT6AwiocHdLC2z6TEb04UWOcU3vQrUv
         NI5SXMvURmaC7c8MJVNBumu899ndMPZjEkvN+oFk5M8WedyJvtbXQex8Bnz1y2it8IdL
         YgX+PNG0l63lKBzKAPxoXotmPb9ViCyVturuJWkFZMrJLAdtI4JxXAGp6cmS0EQV0vbN
         s2GkbhNDZqY/8YJUfRvyJYdTaWK4DyVsFfK2FpDem3tHhlsvz1LDD0PRH/XcFaFYJJSG
         xI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iu/aWIbrp7kIu5C5ShufKi40TdSl3vZcOeSwZg4KWVw=;
        b=FXXzA96MsQlzkjmqYY3QfTiBZB9++OBK8Vor9VKw14FSzmj0J1r2wELav69vlkwumS
         PiyWBaqO4ncZcf81/w7dEWWWwvSewjl9Y+K+L9j/AoyHJ/Jgav+QPRliWjIRVH8W9XaW
         TucbhDHWP+DnuYaI1b4yeobdDt7GxI5Z4GiPxFHN7rrRDxGeUbEjO0iMYC5A9rLnYPAg
         RIF0+Op5ZbOGpHUsT7oyBDAA4XF2x/nihKOsf9L7CqedPBIuEI5OLTydjahXE93blF3W
         RcX4zZQ4Iwo6Q00kqwIlqD9hh2xv7fKS2CHSqbjYE+uMuMNN023RDg/4jhxbX4l56ctf
         2qPA==
X-Gm-Message-State: AOAM530GT92YNOvUjAlvkgbiaYpsEDuH0UwoYv8Jey60KOWZd08bmAYp
        rdkP7M/ciLTDVVfACyvIR0rbMQ+bUFI=
X-Google-Smtp-Source: ABdhPJzWxhSyJnbs12WBaZ42ZH5lTl28ZgF+Oh2pT2dNkXtClOoX5GZhQFtwZWRzbSl05MqJq+j2ew==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr15637908wrr.343.1605468123475;
        Sun, 15 Nov 2020 11:22:03 -0800 (PST)
Received: from xws.fritz.box (p5487b28b.dip0.t-ipconnect.de. [84.135.178.139])
        by smtp.gmail.com with ESMTPSA id u8sm17106600wmg.6.2020.11.15.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:22:02 -0800 (PST)
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
Subject: [PATCH 2/9] platform/surface: aggregator: Add control packet allocation caching
Date:   Sun, 15 Nov 2020 20:21:36 +0100
Message-Id: <20201115192143.21571-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115192143.21571-1-luzmaximilian@gmail.com>
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Surface Serial Hub communication is, in its core, packet based. Each
sequenced packet requires to be acknowledged, via an ACK-type control
packet. In case invalid data has been received by the driver, a NAK-type
(not-acknowledge/negative acknowledge) control packet is sent,
triggering retransmission.

Control packets are therefore a core communication primitive and used
frequently enough (with every sequenced packet transmission sent by the
embedded controller, including events and request responses) that it may
warrant caching their allocations to reduce possible memory
fragmentation.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/core.c    | 27 ++++++++++-
 .../surface/aggregator/ssh_packet_layer.c     | 47 +++++++++++++++----
 .../surface/aggregator/ssh_packet_layer.h     |  3 ++
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 58ba000e95d6..5c01d598a479 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -772,7 +772,32 @@ static struct serdev_device_driver ssam_serial_hub = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
-module_serdev_device_driver(ssam_serial_hub);
+
+
+/* -- Module setup. --------------------------------------------------------- */
+
+static int __init ssam_core_init(void)
+{
+	int status;
+
+	status = ssh_ctrl_packet_cache_init();
+	if (status)
+		return status;
+
+	status = serdev_device_driver_register(&ssam_serial_hub);
+	if (status)
+		ssh_ctrl_packet_cache_destroy();
+
+	return status;
+}
+module_init(ssam_core_init);
+
+static void __exit ssam_core_exit(void)
+{
+	serdev_device_driver_unregister(&ssam_serial_hub);
+	ssh_ctrl_packet_cache_destroy();
+}
+module_exit(ssam_core_exit);
 
 MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
 MODULE_DESCRIPTION("Subsystem and Surface Serial Hub driver for Surface System Aggregator Module");
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index eb0b142148db..920e0d75c641 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -291,24 +291,53 @@ void ssh_packet_init(struct ssh_packet *packet, unsigned long type,
 }
 
 
+static struct kmem_cache *ssh_ctrl_packet_cache;
+
+/**
+ * ssh_ctrl_packet_cache_init() - Initialize the control packet cache.
+ */
+int ssh_ctrl_packet_cache_init(void)
+{
+	const unsigned int size = sizeof(struct ssh_packet) + SSH_MSG_LEN_CTRL;
+	const unsigned int align = __alignof__(struct ssh_packet);
+	struct kmem_cache *cache;
+
+	cache = kmem_cache_create("ssam_ctrl_packet", size, align, 0, NULL);
+	if (!cache)
+		return -ENOMEM;
+
+	ssh_ctrl_packet_cache = cache;
+	return 0;
+}
+
+/**
+ * ssh_ctrl_packet_cache_destroy() - Deinitialize the control packet cache.
+ */
+void ssh_ctrl_packet_cache_destroy(void)
+{
+	kmem_cache_destroy(ssh_ctrl_packet_cache);
+	ssh_ctrl_packet_cache = NULL;
+}
+
 /**
- * ssh_ctrl_packet_alloc() - Allocate control packet.
+ * ssh_ctrl_packet_alloc() - Allocate packet from control packet cache.
  * @packet: Where the pointer to the newly allocated packet should be stored.
  * @buffer: The buffer corresponding to this packet.
  * @flags:  Flags used for allocation.
  *
- * Allocates a packet and corresponding transport buffer. Sets the packet's
- * buffer reference to the allocated buffer. The packet must be freed via
- * ssh_ctrl_packet_free(), which will also free the corresponding buffer. The
- * corresponding buffer must not be freed separately. Intended to be used with
- * %ssh_ptl_ctrl_packet_ops as packet operations.
+ * Allocates a packet and corresponding transport buffer from the control
+ * packet cache. Sets the packet's buffer reference to the allocated buffer.
+ * The packet must be freed via ssh_ctrl_packet_free(), which will also free
+ * the corresponding buffer. The corresponding buffer must not be freed
+ * separately. Intended to be used with %ssh_ptl_ctrl_packet_ops as packet
+ * operations.
  *
  * Return: Returns zero on success, %-ENOMEM if the allocation failed.
  */
 static int ssh_ctrl_packet_alloc(struct ssh_packet **packet,
 				 struct ssam_span *buffer, gfp_t flags)
 {
-	*packet = kzalloc(sizeof(**packet) + SSH_MSG_LEN_CTRL, flags);
+	*packet = kmem_cache_alloc(ssh_ctrl_packet_cache, flags);
 	if (!*packet)
 		return -ENOMEM;
 
@@ -319,12 +348,12 @@ static int ssh_ctrl_packet_alloc(struct ssh_packet **packet,
 }
 
 /**
- * ssh_ctrl_packet_free() - Free control packet.
+ * ssh_ctrl_packet_free() - Free packet allocated from control packet cache.
  * @p: The packet to free.
  */
 static void ssh_ctrl_packet_free(struct ssh_packet *p)
 {
-	kfree(p);
+	kmem_cache_free(ssh_ctrl_packet_cache, p);
 }
 
 static const struct ssh_packet_ops ssh_ptl_ctrl_packet_ops = {
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.h b/drivers/platform/surface/aggregator/ssh_packet_layer.h
index 01ac27d60c3a..f3d8a85389d5 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.h
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.h
@@ -169,4 +169,7 @@ void ssh_ptl_tx_wakeup(struct ssh_ptl *ptl);
 void ssh_packet_init(struct ssh_packet *packet, unsigned long type,
 		     u8 priority, const struct ssh_packet_ops *ops);
 
+int ssh_ctrl_packet_cache_init(void);
+void ssh_ctrl_packet_cache_destroy(void);
+
 #endif /* _SURFACE_AGGREGATOR_SSH_PACKET_LAYER_H */
-- 
2.29.2

