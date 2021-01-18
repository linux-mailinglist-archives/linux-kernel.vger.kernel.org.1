Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F6F2FAD8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 23:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbhARWsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 17:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbhARWrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 17:47:48 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB47CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:47:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id t6so9421529plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/nlLYINAVyRBHFgQGInQrmkjIpXuU+UuJDo8Ulbu0g=;
        b=GPFjx/SnWQ82B/V+bAwLmGmXSSgr6QwsKFAd/bg+BMIaPaBYURo5KVdmUnOFKtRTlM
         UMvpCEv8uqOaEJ3fvG2KOZlu1pfOK4ctOdLk2UFmifYLE/NdunE2K7j3Mxp8V6iyOC9D
         jZHgN6cWgDMIk0QIYnkkO3emElS3N3CMRFxmAj0uRoGLH5o6KhGhDF2UY743SiCsa54v
         HuZYx5oFPaXnXLRRlh5psG4H8/2bSTvwmRCpfiPtPSNgWhXXXccuOdTHzG4WDeDIjue0
         D5zG7YR/2Na6gzapDjILRG4q4MYSz0UDDZaYR3UnuOZqnqZmw8ixFDMT+GMqUENADyCa
         oQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/nlLYINAVyRBHFgQGInQrmkjIpXuU+UuJDo8Ulbu0g=;
        b=DW5oiMsyyxQmg1ktU9jA0f86351wOjeFh4HGGJjb9G0Dy2tXAI6n+QXGXfdGs86YqD
         Aq82kFUE0FDkq6ht1N//LEQEvGc1Cx/xMH5PwrgBOC3GZBfwbUQoQl7hwkCdL/WpF2OB
         HHAJUEFTPpDxyYR00QwwEfGc0yzRPhCF/xWalmpCddc1XjRHvoCi8CK15vEI80l7yhmi
         M6bU+P9wWGBRAK/Xnqply0QzZjTwc9dyiA78X2mRoI+45DvsNw+gKYgap08kJxUQscYB
         Z7IghlsD+f1hD194Ark6J6Oxjv40VR7Cea34dBoRX4e9wkK1Y9Mo3Edvng+FSKTs4G7N
         Aiyw==
X-Gm-Message-State: AOAM531X5Gn2DPMPPUWLSSmX+ocFXLfIYua0YEmILPQK8zI8UZfmbvZ7
        dutnlz0JgUx/jkEshaP3sKuEeg==
X-Google-Smtp-Source: ABdhPJzPNdKwsBB0RLPb1pPxKSIfEoy3HG7qnr37F+0VD63H8quyExVgfKgyQDT4XpFSowzQjkKWew==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr1655405pjb.62.1611010025406;
        Mon, 18 Jan 2021 14:47:05 -0800 (PST)
Received: from zzyiwei.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id c18sm16818415pfj.200.2021.01.18.14.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:47:04 -0800 (PST)
From:   Yiwei Zhang <zzyiwei@android.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, android-kernel-team@google.com,
        Yiwei Zhang <zzyiwei@android.com>
Subject: [PATCH] Track total GPU memory for virtio driver
Date:   Mon, 18 Jan 2021 22:46:59 +0000
Message-Id: <20210118224659.263928-1-zzyiwei@android.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
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

