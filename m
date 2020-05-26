Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1F1A0041
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 23:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDFVep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 17:34:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47132 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726443AbgDFVel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V8xaBUZcNVWW1ObGlu3v9yKYMY7OCX5Z43TKgR5akQo=;
        b=fUOrCUWLW+UJSmPxI6obmc3ePikXZdxN3k2lJkEuRMaBqQW+slH0mYgzc4knXqBGcvuoT3
        QPkWjBsKVUUeTKSwk+aJbmbbEIFbXgzUlmUOsfQSnfGPTqiVcFIcuvTjBkCOMGsP5xYNwh
        6B49Ma9qGm6Y7wLEYI0E/mEJd2uMYPE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-fftTRTttNkOaSsZ9PUz7cQ-1; Mon, 06 Apr 2020 17:34:38 -0400
X-MC-Unique: fftTRTttNkOaSsZ9PUz7cQ-1
Received: by mail-wm1-f71.google.com with SMTP id o5so15661wmo.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V8xaBUZcNVWW1ObGlu3v9yKYMY7OCX5Z43TKgR5akQo=;
        b=DqSKwPPRJnWLSydtJKL2vq6P3K4nempEw9WjL6gizHmsTPBAau+sw2Jf6PGXAJ1PJG
         y1VWwqAJE1OUefM9xYLQfkweoWeUKnNEsn6s/xLimnXHcSKKVSCG+xzbsSflVJkF6Mm8
         4SX8bvJLYj+b/uDXSVFuC52TY0BrR18DvEyF3nq9wNw/Dx+p6j5raJFlba3YVRZx6oGf
         9K1XzFVfxpnHNiVx89OcqSBVM0T4Kf9cHHBP23oC4o4YwbOlxcgBuskTKWr8+tLs/BFq
         UwimIuP1uEgmYkBSr8Fw593BoxeVtkFwLDX+NaIdkOfwuC1bXFsh8XnTB/LnW4T5FngY
         n+bw==
X-Gm-Message-State: AGi0Pub3GDcAgO+wbSxnsGuoYkLe6t6XwpKykS/ZQ/vu8cOxcZU7Ydpj
        zYd3ns1lQ9WQbVS5beWGKljAcgFXyIRSUZhbApqiYKXha33RcXKRmFTOLWT0HidbcIWHu+0O8G1
        vJvZn4MVPzHVtomlxi/xvPmd/
X-Received: by 2002:adf:ed8b:: with SMTP id c11mr1335296wro.14.1586208877362;
        Mon, 06 Apr 2020 14:34:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ6dpicgfzNq7i2GgfmGv356FjsQ1V9/KoUP0AtiURGxPnf7+CVg/psv+qORkcg1A5Xj6bsmQ==
X-Received: by 2002:adf:ed8b:: with SMTP id c11mr1335281wro.14.1586208877142;
        Mon, 06 Apr 2020 14:34:37 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id b5sm16826979wrs.16.2020.04.06.14.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:36 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 05/12] virtio: stop using legacy struct vring in kernel
Message-ID: <20200406210108.148131-6-mst@redhat.com>
References: <20200406210108.148131-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406210108.148131-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct vring (in the uapi directory) and supporting APIs are kept
around to solely avoid breaking old userspace builds.
It's not actually part of the UAPI - it was kept in the UAPI
header by mistake, and using it in kernel isn't necessary
and prevents us from making changes safely.
In particular, the APIs actually assume the legacy layout.

Add an internal kernel-only struct vring and
switch everyone to use that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h      | 10 ++++++++++
 include/linux/vringh.h           |  1 +
 include/uapi/linux/virtio_ring.h | 26 ++++++++++++++++----------
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 3dc70adfe5f5..11680e74761a 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -60,6 +60,16 @@ static inline void virtio_store_mb(bool weak_barriers,
 struct virtio_device;
 struct virtqueue;
 
+struct vring {
+	unsigned int num;
+
+	struct vring_desc *desc;
+
+	struct vring_avail *avail;
+
+	struct vring_used *used;
+};
+
 /*
  * Creates a virtqueue and allocates the descriptor ring.  If
  * may_reduce_num is set, then this may allocate a smaller ring than
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 9e2763d7c159..d71b3710f58e 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_VRINGH_H
 #define _LINUX_VRINGH_H
 #include <uapi/linux/virtio_ring.h>
+#include <linux/virtio_ring.h>
 #include <linux/virtio_byteorder.h>
 #include <linux/uio.h>
 #include <linux/slab.h>
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 9223c3a5c46a..8961a4adda5c 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -118,16 +118,6 @@ struct vring_used {
 	struct vring_used_elem ring[];
 };
 
-struct vring {
-	unsigned int num;
-
-	struct vring_desc *desc;
-
-	struct vring_avail *avail;
-
-	struct vring_used *used;
-};
-
 /* Alignment requirements for vring elements.
  * When using pre-virtio 1.0 layout, these fall out naturally.
  */
@@ -166,6 +156,21 @@ struct vring {
 #define vring_used_event(vr) ((vr)->avail->ring[(vr)->num])
 #define vring_avail_event(vr) (*(__virtio16 *)&(vr)->used->ring[(vr)->num])
 
+#ifndef __KERNEL__
+/*
+ * The following definitions have been put in the UAPI header by mistake. We
+ * keep them around to avoid breaking old userspace builds.
+ */
+struct vring {
+	unsigned int num;
+
+	struct vring_desc *desc;
+
+	struct vring_avail *avail;
+
+	struct vring_used *used;
+};
+
 static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 			      unsigned long align)
 {
@@ -182,6 +187,7 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
 		 + align - 1) & ~(align - 1))
 		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
 }
+#endif
 
 #endif /* VIRTIO_RING_NO_LEGACY */
 
-- 
MST

