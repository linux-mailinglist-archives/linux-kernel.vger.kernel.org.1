Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AE32A3643
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKBWHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 17:07:37 -0500
Received: from aposti.net ([89.234.176.197]:44762 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgKBWHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:07:37 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/5] drm: Add and export function drm_gem_cma_mmap_noncoherent
Date:   Mon,  2 Nov 2020 22:06:49 +0000
Message-Id: <20201102220651.22069-4-paul@crapouillou.net>
In-Reply-To: <20201102220651.22069-1-paul@crapouillou.net>
References: <20201102220651.22069-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function can be used by drivers that need to mmap dumb buffers
created with non-coherent backing memory.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/drm_gem_cma_helper.c | 39 ++++++++++++++++++++++++++++
 include/drm/drm_gem_cma_helper.h     |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 3bdd67795e20..4ed63f4896bd 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -387,6 +387,45 @@ int drm_gem_cma_mmap(struct file *filp, struct vm_area_struct *vma)
 }
 EXPORT_SYMBOL_GPL(drm_gem_cma_mmap);
 
+/**
+ * drm_gem_cma_mmap_noncoherent - memory-map a CMA GEM object with
+ *     non-coherent cache attribute
+ * @filp: file object
+ * @vma: VMA for the area to be mapped
+ *
+ * Just like drm_gem_cma_mmap, but for a GEM object backed by non-coherent
+ * memory.
+ *
+ * Returns:
+ * 0 on success or a negative error code on failure.
+ */
+int drm_gem_cma_mmap_noncoherent(struct file *filp, struct vm_area_struct *vma)
+{
+	struct drm_gem_cma_object *cma_obj;
+	int ret;
+
+	ret = drm_gem_mmap(filp, vma);
+	if (ret)
+		return ret;
+
+	cma_obj = to_drm_gem_cma_obj(vma->vm_private_data);
+
+	/*
+	 * Clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
+	 * vm_pgoff (used as a fake buffer offset by DRM) to 0 as we want to map
+	 * the whole buffer.
+	 */
+	vma->vm_flags &= ~VM_PFNMAP;
+	vma->vm_pgoff = 0;
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+
+	return remap_pfn_range(vma, vma->vm_start,
+			       cma_obj->paddr >> PAGE_SHIFT,
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot);
+}
+EXPORT_SYMBOL_GPL(drm_gem_cma_mmap_noncoherent);
+
 #ifndef CONFIG_MMU
 /**
  * drm_gem_cma_get_unmapped_area - propose address for mapping in noMMU cases
diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
index d0e6a1cd0950..6b01ad5581c3 100644
--- a/include/drm/drm_gem_cma_helper.h
+++ b/include/drm/drm_gem_cma_helper.h
@@ -83,6 +83,8 @@ int drm_gem_cma_dumb_create_noncoherent(struct drm_file *file_priv,
 /* set vm_flags and we can change the VM attribute to other one at here */
 int drm_gem_cma_mmap(struct file *filp, struct vm_area_struct *vma);
 
+int drm_gem_cma_mmap_noncoherent(struct file *filep, struct vm_area_struct *vma);
+
 /* allocate physical memory */
 struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
 					      size_t size);
-- 
2.28.0

