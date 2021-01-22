Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB432FFC49
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 06:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbhAVFcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 00:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbhAVFco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 00:32:44 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9121C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:32:04 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id h15so93762pli.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BLXgpOXOllZOpAnIxHqD+UYHHzmwKo7AFJN3hA2f4pQ=;
        b=tbFctqzA8MbsuRfWOhF7+/+paIyBF3tGT2Xt2BFWfgMIf/864NJN5Rua+rYjyBMOAI
         iZol7ydj8ULFhwH/EXNswxfwfO4XNCypF5xO9teuC9FW2HOkXna5LhsUJ523EnWqh0B5
         QYzlKFR8seCOHX7neVmJMlFXLCQPolctCREXowxeTVA6GkdLdi3G1vJ+OtssRm/1DgYa
         qbnjJZqjEChBQZGI81Yw+MHuIM1wk6/K70lAKe+4XnoC5o/GweTdKp1qRn+mqLfyqRjf
         X2owyeS6CZD3J2TqEneV/mtHcmt1gd3TDz1pwiUuaVI8ZcoBdZjEJ/GDGcRW+Dmo4tCw
         oHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BLXgpOXOllZOpAnIxHqD+UYHHzmwKo7AFJN3hA2f4pQ=;
        b=MifcDPfWVfco0L69cCZQV+RnF8TvbVB6APcqo4ump9LSyg1tQtu8KL45RED0zNmy6z
         eXFe+4ZB1VXci8trXym5aob5mq+y2zxOhoMyilSlwkBNVvwiHnm+g4nslLqm+wv+mp7J
         SihEdHeDrK4Oxj6HstFyo2szL9ZVxtyFIlGKZ9lwmyuqSajZA2IOgHeJhp6UsRCi407N
         hkDLbBZi3fVE2B1UC7UuL4/1Kc29gOzr0n2yUXsjz1VBElNQVZlhQSHQKaJyWHGy/g+b
         k/bJe+uuwXkanAhVg3ZrAbdl+IdS3ZEBSsF5vvcokugSSVeeBxri7OnSO4wOQtQAg2ZJ
         s8LQ==
X-Gm-Message-State: AOAM532dMXiP2RRU9rnXox+3nfFPiSnbmLZNA3ZZ9h2V0qMEqX+Ep8dg
        TqSRf6FULOrJYivX3Y/KXtQbZg==
X-Google-Smtp-Source: ABdhPJzvNY5BuI42QFjGI0uH6F1mNIZl44NkdqVjmfiVXaOwvVeKlvcj9wg9zceerPKtXqqBJaZ3Tw==
X-Received: by 2002:a17:90b:4b86:: with SMTP id lr6mr3306071pjb.107.1611293524025;
        Thu, 21 Jan 2021 21:32:04 -0800 (PST)
Received: from zzyiwei.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id x186sm6600392pfd.57.2021.01.21.21.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 21:32:03 -0800 (PST)
From:   Yiwei Zhang <zzyiwei@android.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Yiwei Zhang <zzyiwei@google.com>,
        Yiwei Zhang <zzyiwei@android.com>
Subject: [PATCH v3] drm/virtio: trace total gem bo for virtio
Date:   Fri, 22 Jan 2021 05:31:59 +0000
Message-Id: <20210122053159.1720274-1-zzyiwei@android.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210121091013.wlqyukat2w7fow33@sirius.home.kraxel.org>
References: <20210121091013.wlqyukat2w7fow33@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yiwei Zhang <zzyiwei@google.com>

On the success of virtio_gpu_object_create, add size of newly allocated
bo to the tracked total_mem. In drm_gem_object_funcs.free, after the gem
bo lost its last refcount, subtract the bo size from the tracked
total_mem if the original underlying memory allocation is successful.

It's more accurate to do this in device driver layer to best match when
the underlying resource gets allocated and destroyed during tracing.

Signed-off-by: Yiwei Zhang <zzyiwei@android.com>
---
 drivers/gpu/drm/virtio/Kconfig          |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  2 ++
 drivers/gpu/drm/virtio/virtgpu_object.c | 11 +++++++++++
 3 files changed, 14 insertions(+)

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
index 6a232553c99b..7ab63ce9c6a9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -249,6 +249,8 @@ struct virtio_gpu_device {
 	spinlock_t resource_export_lock;
 	/* protects map state and host_visible_mm */
 	spinlock_t host_visible_lock;
+	/* total memory backing gem bos */
+	atomic64_t total_mem;
 };
 
 struct virtio_gpu_fpriv {
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index d69a5b6da553..e2251fc41509 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -25,12 +25,21 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/moduleparam.h>
+#include <trace/events/gpu_mem.h>
 
 #include "virtgpu_drv.h"
 
 static int virtio_gpu_virglrenderer_workaround = 1;
 module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
 
+static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *vgdev,
+					      s64 delta)
+{
+	u64 total_mem = atomic64_add_return(delta, &vgdev->total_mem);
+
+	trace_gpu_mem_total(vgdev->ddev->primary->index, 0, total_mem);
+}
+
 int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev, uint32_t *resid)
 {
 	if (virtio_gpu_virglrenderer_workaround) {
@@ -104,6 +113,7 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
 	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
 
 	if (bo->created) {
+		virtio_gpu_trace_total_mem(vgdev, -(obj->size));
 		virtio_gpu_cmd_unref_resource(vgdev, bo);
 		virtio_gpu_notify(vgdev);
 		/* completion handler calls virtio_gpu_cleanup_object() */
@@ -265,6 +275,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 		virtio_gpu_object_attach(vgdev, bo, ents, nents);
 	}
 
+	virtio_gpu_trace_total_mem(vgdev, shmem_obj->base.size);
 	*bo_ptr = bo;
 	return 0;
 
-- 
2.30.0.280.ga3ce27912f-goog

