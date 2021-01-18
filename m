Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4C82FADD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 00:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbhARXlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 18:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbhARXlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 18:41:42 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7FFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 15:41:01 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t29so5991989pfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 15:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/nlLYINAVyRBHFgQGInQrmkjIpXuU+UuJDo8Ulbu0g=;
        b=CeUbDfkSixcnj7Je9G2EmxupRgBW6vpM+Vjuc4TcLNGrMBZE60j6gj2mcFsRzHbrvr
         dAyMAVGWL74LsxN/Gr0S3TBQ0MY9d+MYNqf8ygYSUQVG6wT6tC7MND3WFyrIsb9ANYGp
         mGqMznnPa2Bq3SqHrpXWh3RM+3w1hPFJwJg7G+wfbTxjRYmdzlM47mPnagqaQkUA26WL
         o7AfpjvZOs7CNJaNalorSoKUnOIMVk7+VBwLRS02n2MsMdDBV1Zqaj0Phd/n9UDZy+jx
         1CoG+8BvWHe3HU7fpUYrhLSj2sQqF6E1NMR8mxsiQNBvdNqBbDKhrNM3XRxYxXn5NcXI
         E/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/nlLYINAVyRBHFgQGInQrmkjIpXuU+UuJDo8Ulbu0g=;
        b=a4hpW2DyNjxA6j5MOkzkq7TsYuvmlb90G74gZ795Y0LS/e9o1YgAskHbmHGKJOS3zm
         s787NkajHCvpPTXh+zAk95eWQwH6nu2ePRRU5zMIKP3hCqGlR1C5rU2QNkBsUXAxfHTv
         LNSSkIJT3i36x2wyEuruG7o3A9tOnMY/hr5PN1nLtbSAGIxhAfVWIiUFyUwZifoL9Y8U
         RQLU4goTOD8eKdmYKvkjmMbAJYkO3kuvhvLij1iytYeiE/TlI1eWb1V1hwKGozaVt6Xl
         NPAkoFw0xnkO+2OSQniIbw4A0HsLFnaOxwEq9V9L9wEdza8hD20E/9a4EWchEuTvDN+H
         VuFw==
X-Gm-Message-State: AOAM531QwgTt5vRbLBmczcfO7Ur7CA0UJg7eED4E0rct5FAV9ZaXZ0d/
        6eltO7s6Fc+YLkkCDWR4VXfmkHl2CUh41hui
X-Google-Smtp-Source: ABdhPJxvqOsZyL74EzO30ITL+q2wdyblNkeX7/6HMu7klkOfxj5G6opd5X57U+/HpseZPrVzjyi+Ow==
X-Received: by 2002:a63:4f01:: with SMTP id d1mr1861356pgb.279.1611013261303;
        Mon, 18 Jan 2021 15:41:01 -0800 (PST)
Received: from zzyiwei.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id x15sm16443040pfa.80.2021.01.18.15.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 15:41:00 -0800 (PST)
From:   Yiwei Zhang <zzyiwei@android.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Yiwei Zhang <zzyiwei@android.com>
Subject: [PATCH v2] drm/virtio: Track total GPU memory for virtio driver
Date:   Mon, 18 Jan 2021 23:40:57 +0000
Message-Id: <20210118234057.270930-1-zzyiwei@android.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <CAKB3++adfpdBHFEyGZ3v2V6zyW+ayg86CLDRKx1ty+OytjYFNw@mail.gmail.com>
References: <CAKB3++adfpdBHFEyGZ3v2V6zyW+ayg86CLDRKx1ty+OytjYFNw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the success of virtio_gpu_object_create, add size of newly allocated
bo to the tracled total_mem. In drm_gem_object_funcs.free, after the gem
bo lost its last refcount, subtract the bo size from the tracked
total_mem if the original underlying memory allocation is successful.

Signed-off-by: Yiwei Zhang <zzyiwei@android.com>
---
 drivers/gpu/drm/virtio/Kconfig          |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  4 ++++
 drivers/gpu/drm/virtio/virtgpu_object.c | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
index b925b8b1da16..e103b7e883b1 100644
--- a/drivers/gpu/drm/virtio/Kconfig
+++ b/drivers/gpu/drm/virtio/Kconfig
@@ -5,6 +5,7 @@ config DRM_VIRTIO_GPU
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
 	select VIRTIO_DMA_SHARED_BUFFER
+	select TRACE_GPU_MEM
 	help
 	   This is the virtual GPU driver for virtio.  It can be used with
 	   QEMU based VMMs (like KVM or Xen).
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 6a232553c99b..7c60e7486bc4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -249,6 +249,10 @@ struct virtio_gpu_device {
 	spinlock_t resource_export_lock;
 	/* protects map state and host_visible_mm */
 	spinlock_t host_visible_lock;
+
+#ifdef CONFIG_TRACE_GPU_MEM
+	atomic64_t total_mem;
+#endif
 };
 
 struct virtio_gpu_fpriv {
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index d69a5b6da553..1e16226cebbe 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -25,12 +25,29 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/moduleparam.h>
+#ifdef CONFIG_TRACE_GPU_MEM
+#include <trace/events/gpu_mem.h>
+#endif
 
 #include "virtgpu_drv.h"
 
 static int virtio_gpu_virglrenderer_workaround = 1;
 module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
 
+#ifdef CONFIG_TRACE_GPU_MEM
+static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *vgdev,
+					      s64 delta)
+{
+	u64 total_mem = atomic64_add_return(delta, &vgdev->total_mem);
+
+	trace_gpu_mem_total(0, 0, total_mem);
+}
+#else
+static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *, s64)
+{
+}
+#endif
+
 int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev, uint32_t *resid)
 {
 	if (virtio_gpu_virglrenderer_workaround) {
@@ -104,6 +121,7 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
 	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
 
 	if (bo->created) {
+		virtio_gpu_trace_total_mem(vgdev, -(obj->size));
 		virtio_gpu_cmd_unref_resource(vgdev, bo);
 		virtio_gpu_notify(vgdev);
 		/* completion handler calls virtio_gpu_cleanup_object() */
@@ -265,6 +283,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 		virtio_gpu_object_attach(vgdev, bo, ents, nents);
 	}
 
+	virtio_gpu_trace_total_mem(vgdev, shmem_obj->base.size);
 	*bo_ptr = bo;
 	return 0;
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

