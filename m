Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A5D2FFC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 06:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbhAVFlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 00:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhAVFlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 00:41:00 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1EAC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:40:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cq1so3061410pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+VVqD6sXlF+5lVgKKmRD65kHUVFDRo2SqtuDbp5A2g=;
        b=IaDISI25WrpzeFw5mp3kQjVIz7W1oxuRgpoH5rOeGBn1yavV3XkZtjBAUBoa3jxWdJ
         1hoTXT9+r+ygCc/DBsrtvd29QHBLEmgI4xeHSIrMb4er5Gwd0a+K0TqHJOsxI4syLnly
         fDOpXqp/0Cqc0zerDk/bYbqdiXzvt4o7gnBrxEFvgG3RPW16mQrrE79WRci4TFCcW7MK
         fGBS22Ay3veF/h2yoDZHu0PNYBNGG0UwGjTinrg9mEuOcsSkzwzwXmC6Rzzl65PXpItW
         JSPodf/PabWwkk2r1xQlfM2cKiO7YuLNtdJqtTsr3GSOxvmeF56H96vT0A3WfemI9mSi
         ZqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+VVqD6sXlF+5lVgKKmRD65kHUVFDRo2SqtuDbp5A2g=;
        b=nGpcS504+FJtxpgebW3jyxMKAnclbo0HC+8N8riOK43wXqwUjzG090qCcRK1chWQL9
         MzQAXVwZ2it/2TjX9+073FhGCpbXNZfHGdDpntWqgrKW72rwlXHCiVgoopB52JzLPBnU
         S5S87++hNO/teQOoxkPHYRUqWemoaIIWA9YG8OVsa8QFIqTln9j1BcvpgO+vVmP2owJn
         yp7laStHghe8FV464kbAvXZVI1YwKJkwXEJN2kFPo9NkfRw3j1ZV0WUMXOWPJ7K57qBA
         +JkvoCZcDH23j1FO4SoffEjm1zOZqn2vFCH88rxhk2s17yWCA/gPhnUujWwYz3VpunG2
         fJ0Q==
X-Gm-Message-State: AOAM532vjOw5Wjp8Eh5n63DKUs9vybapNmtHBPLreVlbrQ8tfk4dsR9W
        tmF8DHdtowWB1RvvxXc/3yiNsg==
X-Google-Smtp-Source: ABdhPJwrUOYouOww1Q9H3FD8MyKJueIXCGnVdG75HCUhilMWt3e1L501NqTTmR87um6lRr1LmhA3zQ==
X-Received: by 2002:a17:902:d50b:b029:de:675f:5b39 with SMTP id b11-20020a170902d50bb02900de675f5b39mr2888645plg.68.1611294019443;
        Thu, 21 Jan 2021 21:40:19 -0800 (PST)
Received: from zzyiwei.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id fy20sm8433683pjb.54.2021.01.21.21.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 21:40:19 -0800 (PST)
From:   Yiwei Zhang <zzyiwei@android.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Yiwei Zhang <zzyiwei@android.com>
Subject: [PATCH v4] drm/virtio: Track total GPU memory for virtio driver
Date:   Fri, 22 Jan 2021 05:40:11 +0000
Message-Id: <20210122054011.1722954-1-zzyiwei@android.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210122053159.1720274-1-zzyiwei@android.com>
References: <20210122053159.1720274-1-zzyiwei@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the success of virtio_gpu_object_create, add size of newly allocated
bo to the tracked total_mem. In drm_gem_object_funcs.free, after the gem
bo loses its last refcount, subtract the bo size from the tracked
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
index 6a232553c99b..c5622f9b591f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -249,6 +249,8 @@ struct virtio_gpu_device {
 	spinlock_t resource_export_lock;
 	/* protects map state and host_visible_mm */
 	spinlock_t host_visible_lock;
+
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

