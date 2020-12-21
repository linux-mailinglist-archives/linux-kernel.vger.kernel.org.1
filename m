Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906CF2E0014
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgLUSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbgLUSk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:40:58 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D96C061282;
        Mon, 21 Dec 2020 10:40:18 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r4so11911701wmh.5;
        Mon, 21 Dec 2020 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cXEyCZhqyAlhe7VN2oOPsspcOcvjXqZgrLMC74f9pH8=;
        b=P/n/WrId737u21PNDRBh5R3UAz0wpvGZGb4xfEkVWhUN1smQbgmGhNwkPhQYXL3LbY
         CjcdFEk9p9+YnEsWNwH9yZsoVt6jpkgacX30emPGNE3Rx0V4eclGhau8iSwg3geD1Tkk
         C3Z4TnjwESBxWCQKUHgbKIkBzEBhKiQmyWjn7ceLJWg5uLITRogf7Qjn2VaKvZlBKWd0
         jO65jEhqhBSYfbuXRGabqZ6c/f8ccWNs8HlfFLL5EwEfuvNDj49o2bCxCLjRYZA94ZAX
         pIEv3+ZRc1gs2M3z5f4Yp6ma96t+1g4zOjXAUfTjtdrGxflmTpTq447YJRgis77RtEU8
         hNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cXEyCZhqyAlhe7VN2oOPsspcOcvjXqZgrLMC74f9pH8=;
        b=uCqixQk3R/kVj0XEYuxqWvMWDYW/GMEesKvFYeGgtHi2Ubfay4tTnvoOH5L5wr0iNZ
         hiiz2JicCENnNeXpo0A7V+G6c+SfVzbY3WdItvf3CidmaG3ZVbRs1QldKP7DInJeXRIK
         QtEXgcUwJmWYqhw2Ys7OSf7c/Cb2al5RuSlrw9uxcg7b9suBAiHHszerRkQUG/10itSz
         GRyuG7s2Lf4WrnSsm+hEiFQNUXfyFFIa8cj6XYq2ehmIOJ8GZKlLrpuPd23REyVF+NEY
         myJb8pl7p0bzZUBTaUY/oNJssWlYnJUdDjgtVTzutoDiHGnlnqd79wzuHC8kgSbpT02M
         E/sQ==
X-Gm-Message-State: AOAM533hjr07vdMNTOmpAXs9JstdTyWqiicCXQeqk73a7PEnyOknPdnF
        sPA89SleVsSgb5LbKq99j5iX24vJfv7q4A==
X-Google-Smtp-Source: ABdhPJw3AqJBTFLWQrkysA1/Sv6O8a+9b+Zs2DoOBoYy1OTrqHVSqgRRGFHAnsAKOJAMWRQR3QhIew==
X-Received: by 2002:a1c:a9c4:: with SMTP id s187mr18185779wme.116.1608576016753;
        Mon, 21 Dec 2020 10:40:16 -0800 (PST)
Received: from xws.fritz.box (pd9e5aae0.dip0.t-ipconnect.de. [217.229.170.224])
        by smtp.gmail.com with ESMTPSA id j7sm24528310wmb.40.2020.12.21.10.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:40:16 -0800 (PST)
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
Subject: [PATCH v3 2/9] platform/surface: aggregator: Add control packet allocation caching
Date:   Mon, 21 Dec 2020 19:39:52 +0100
Message-Id: <20201221183959.1186143-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221183959.1186143-1-luzmaximilian@gmail.com>
References: <20201221183959.1186143-1-luzmaximilian@gmail.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/surface/aggregator/core.c    | 27 ++++++++++-
 .../surface/aggregator/ssh_packet_layer.c     | 47 +++++++++++++++----
 .../surface/aggregator/ssh_packet_layer.h     |  3 ++
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 18e0e9e34e7b..60d312f71436 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -780,7 +780,32 @@ static struct serdev_device_driver ssam_serial_hub = {
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
index 66e38fdc7963..23c2e31e7d0e 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -303,24 +303,53 @@ void ssh_packet_init(struct ssh_packet *packet, unsigned long type,
 	packet->ops = ops;
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
 
@@ -331,12 +360,12 @@ static int ssh_ctrl_packet_alloc(struct ssh_packet **packet,
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
index 058f111292ca..e8757d03f279 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.h
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.h
@@ -184,4 +184,7 @@ static inline void ssh_ptl_tx_wakeup_transfer(struct ssh_ptl *ptl)
 void ssh_packet_init(struct ssh_packet *packet, unsigned long type,
 		     u8 priority, const struct ssh_packet_ops *ops);
 
+int ssh_ctrl_packet_cache_init(void);
+void ssh_ctrl_packet_cache_destroy(void);
+
 #endif /* _SURFACE_AGGREGATOR_SSH_PACKET_LAYER_H */
-- 
2.29.2

