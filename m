Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADB72CE09D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgLCV1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgLCV1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:27:43 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F14FC061A52;
        Thu,  3 Dec 2020 13:27:03 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id qw4so5611202ejb.12;
        Thu, 03 Dec 2020 13:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=caVWfVVH6dJ8obRbPhyh/U+sXvPqd/kznJTcICC3wMY=;
        b=BXtnbt3ConAnHi1cI918sScurMqDRB/DWoEU1AHCQbTeDUD16cO20Ph4hpWUgU0qCi
         eCJPTbZ9CMm0WdxEuVenx6BBkWfEPpLc/Q5Der2XcGzaz3+FgUSvRuV9ThBXLFAKk+7S
         52y4BJsU2ruBGmi5h68ZEvcHNqBGUmrpxE4erWYBFjKWuUUm/di58EHgQcXan40n4yHl
         MMeV4IpANV0CIv8K0qmVklWBY7Cro2k7NeTn6hT5uw06kwFwAaPsU/lIJDObLstN/XUT
         0c9xzJX6GrO92lh5nQM2FJDdKsXnBKUL+1c4WmaX1rXJSKhin0dC/ufZrzau++gdgo6Q
         jQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=caVWfVVH6dJ8obRbPhyh/U+sXvPqd/kznJTcICC3wMY=;
        b=SmlPSYIHaR/bgNPHTVX27PKgIyZ1mUzyBz/JQ9LD1wHtrWsQHby38VgqixcZzHDFSf
         xXmcAYX+VC8zM8PE5tqZLjVNPwMM81Hev1M4jGi3dXskn7olqOrR931amgXlTTEnDZuH
         GsCA+Q/Lbyxr8WjkSHwOu8JrEjszUVZi6DuE1dDj0vSYn5vArSBu5ArjhBajQuU+vlx1
         PS2uT4JTt4/a077Q0vcWp5olVJZaLRdmKIxguf3rpDoziOvy7zZYxHDVtYmqXXbhc+Ei
         FBu8K+MzXO9xAkEPgGO7rn8M/9IC/emUP3kEe8cWM7kVKgBfaCSNhKW4zTeQQagjIqrL
         ECKw==
X-Gm-Message-State: AOAM532YnxcffNEBKsYxZGs55nIRf+1mfANRo4MDw3l9AQykfmZI0Oz7
        MhwSeITLfk5r1x+4X9crHVDsV4OLhg0=
X-Google-Smtp-Source: ABdhPJxRfFgPm5mgJ6SBB1fhTKi1290wsLk01+F0pURQ3mdjhJWxNpqoRHuy2X6mM1tU5mYg1y5/Sw==
X-Received: by 2002:a17:906:12cf:: with SMTP id l15mr4263386ejb.540.1607030821644;
        Thu, 03 Dec 2020 13:27:01 -0800 (PST)
Received: from xws.fritz.box (pd9e5a6ef.dip0.t-ipconnect.de. [217.229.166.239])
        by smtp.gmail.com with ESMTPSA id e3sm1656169ejq.96.2020.12.03.13.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:27:00 -0800 (PST)
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
Subject: [PATCH v2 2/9] platform/surface: aggregator: Add control packet allocation caching
Date:   Thu,  3 Dec 2020 22:26:33 +0100
Message-Id: <20201203212640.663931-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203212640.663931-1-luzmaximilian@gmail.com>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
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
index ec6c7f40ad36..77bc4c87541b 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -774,7 +774,32 @@ static struct serdev_device_driver ssam_serial_hub = {
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
index 237d28c90e4b..8bc19837cde0 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -302,24 +302,53 @@ void ssh_packet_init(struct ssh_packet *packet, unsigned long type,
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

@@ -330,12 +359,12 @@ static int ssh_ctrl_packet_alloc(struct ssh_packet **packet,
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

