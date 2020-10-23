Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E56297526
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbgJWQur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbgJWQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:50:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A950C0613D4;
        Fri, 23 Oct 2020 09:50:31 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so1706718pgg.1;
        Fri, 23 Oct 2020 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKdXU4mLTFSbqW41cvebBKb564lzQJs1xHm1BiWuh4c=;
        b=pHJb2pooUwKzAgS/n6kq+a28P7o4mxIVO/JiYnFi9iF7qk5OjdwYv01d1Perppcimz
         EO9rgdR7hd/3NnBzQ6oZbJqQgVtCLiEqHwl0lbI0I4IlAxOs9C1l5GULp+ZtpLT0auIq
         2K1i+Eh4KTUwGNxeIcdDV7m4QnJDB+6COztznsri1P0GnM9xagDMN/JCfB8M8uPvBSlw
         NlJJao6uFamN9MZ+mUujR+qdv0z7m4NiGs088D9Cv2r1myPOCa1+3wVG2I6pM4X228zn
         VQlAlwvvcNcaPzHEGqJ6ufs42bQnuS43R4M1Ofu7yU7ZzTHZl7d6Qf3z0C6RypKw6tbP
         aVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKdXU4mLTFSbqW41cvebBKb564lzQJs1xHm1BiWuh4c=;
        b=QFbxNwN3pftgby2bkIrka0XzI37ZmpINSOak8ES7glt8MuqrRYIlLVeDOJPejWeX4x
         eWjA6dJZJuPJKFSr7CZA4BinNWziaNlE+R0pPSI82AgsumYJ1IzvfI4QB9f5vHA2B9lX
         02Kjz5pmeBAAGagVKOXbVZ7SaBNLMzegR3mzllcy+WEJmclq21YpO5xP/TbJ+xAjpFMn
         VgDApTt1Im3YiaXkE2AjGwPyxbArNwAs+eB6QFsjHYsQkwkYSUS7BocjDdaIHdbot9W4
         wJm5kKqXbji1Cb1BhMgb3K6wTP8yidDMLlQc0pWoq/pR5B+Z8VH4J5tbD/PSwQ+C5Dc4
         RYjA==
X-Gm-Message-State: AOAM530E/N/7sZ2IWAWTupH5t6uXREsgHWifZoC2kyH6klLOVC/lxjhZ
        aY1QNQRZZVWcc7G2pL4FLGY=
X-Google-Smtp-Source: ABdhPJxjUrlPkMiFvRkA6XECOEhffOZ0ew10qbhq3vjoc4KLF34I72bh7jDfbuQzcAUawURXBiCDkQ==
X-Received: by 2002:a17:90a:ae16:: with SMTP id t22mr3426910pjq.55.1603471831026;
        Fri, 23 Oct 2020 09:50:31 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id p16sm2854398pfq.63.2020.10.23.09.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:50:30 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 09/23] drm/msm/gem: Switch over to obj->resv for locking
Date:   Fri, 23 Oct 2020 09:51:10 -0700
Message-Id: <20201023165136.561680-10-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023165136.561680-1-robdclark@gmail.com>
References: <20201023165136.561680-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

This also converts the special msm_gem_get_vaddr_active() to expect the
lock to already be held.  There are two call-sites for this, one already
has the lock held, so it is more straightforward to just open-code the
locking for the other caller.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Kristian H. Kristensen <hoegsberg@google.com>
---
 drivers/gpu/drm/msm/msm_gem.c        | 17 +++++++----------
 drivers/gpu/drm/msm/msm_gem.h        | 16 +++++-----------
 drivers/gpu/drm/msm/msm_gem_submit.c |  8 ++++----
 drivers/gpu/drm/msm/msm_gpu.c        | 14 ++++++++++++--
 drivers/gpu/drm/msm/msm_rd.c         |  2 +-
 5 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 1195847714ba..17afa627ea3d 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -644,13 +644,7 @@ void *msm_gem_get_vaddr(struct drm_gem_object *obj)
  */
 void *msm_gem_get_vaddr_active(struct drm_gem_object *obj)
 {
-	void *ret;
-
-	msm_gem_lock(obj);
-	ret = get_vaddr(obj, __MSM_MADV_PURGED);
-	msm_gem_unlock(obj);
-
-	return ret;
+	return get_vaddr(obj, __MSM_MADV_PURGED);
 }
 
 void msm_gem_put_vaddr_locked(struct drm_gem_object *obj)
@@ -970,15 +964,20 @@ static void free_object(struct msm_gem_object *msm_obj)
 		if (msm_obj->pages)
 			kvfree(msm_obj->pages);
 
+		/* dma_buf_detach() grabs resv lock, so we need to unlock
+		 * prior to drm_prime_gem_destroy
+		 */
+		msm_gem_unlock(obj);
+
 		drm_prime_gem_destroy(obj, msm_obj->sgt);
 	} else {
 		msm_gem_vunmap(obj);
 		put_pages(obj);
+		msm_gem_unlock(obj);
 	}
 
 	drm_gem_object_release(obj);
 
-	msm_gem_unlock(obj);
 	kfree(msm_obj);
 }
 
@@ -1050,8 +1049,6 @@ static int msm_gem_new_impl(struct drm_device *dev,
 	if (!msm_obj)
 		return -ENOMEM;
 
-	mutex_init(&msm_obj->lock);
-
 	msm_obj->flags = flags;
 	msm_obj->madv = MSM_MADV_WILLNEED;
 
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 1f4e5d871a23..f0608d96ef03 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -85,7 +85,6 @@ struct msm_gem_object {
 	 * an IOMMU.  Also used for stolen/splashscreen buffer.
 	 */
 	struct drm_mm_node *vram_node;
-	struct mutex lock; /* Protects resources associated with bo */
 
 	char name[32]; /* Identifier to print for the debugfs files */
 
@@ -158,36 +157,31 @@ void msm_gem_describe_objects(struct list_head *list, struct seq_file *m);
 static inline void
 msm_gem_lock(struct drm_gem_object *obj)
 {
-	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	mutex_lock(&msm_obj->lock);
+	dma_resv_lock(obj->resv, NULL);
 }
 
 static inline bool __must_check
 msm_gem_trylock(struct drm_gem_object *obj)
 {
-	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	return mutex_trylock(&msm_obj->lock) == 1;
+	return dma_resv_trylock(obj->resv);
 }
 
 static inline int
 msm_gem_lock_interruptible(struct drm_gem_object *obj)
 {
-	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	return mutex_lock_interruptible(&msm_obj->lock);
+	return dma_resv_lock_interruptible(obj->resv, NULL);
 }
 
 static inline void
 msm_gem_unlock(struct drm_gem_object *obj)
 {
-	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	mutex_unlock(&msm_obj->lock);
+	dma_resv_unlock(obj->resv);
 }
 
 static inline bool
 msm_gem_is_locked(struct drm_gem_object *obj)
 {
-	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	return mutex_is_locked(&msm_obj->lock);
+	return dma_resv_is_locked(obj->resv);
 }
 
 static inline bool is_active(struct msm_gem_object *msm_obj)
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index aa3c7af54079..044e9bee70a2 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -221,7 +221,7 @@ static void submit_unlock_unpin_bo(struct msm_gem_submit *submit,
 	struct msm_gem_object *msm_obj = submit->bos[i].obj;
 
 	if (submit->bos[i].flags & BO_PINNED)
-		msm_gem_unpin_iova(&msm_obj->base, submit->aspace);
+		msm_gem_unpin_iova_locked(&msm_obj->base, submit->aspace);
 
 	if (submit->bos[i].flags & BO_LOCKED)
 		dma_resv_unlock(msm_obj->base.resv);
@@ -324,7 +324,7 @@ static int submit_pin_objects(struct msm_gem_submit *submit)
 		uint64_t iova;
 
 		/* if locking succeeded, pin bo: */
-		ret = msm_gem_get_and_pin_iova(&msm_obj->base,
+		ret = msm_gem_get_and_pin_iova_locked(&msm_obj->base,
 				submit->aspace, &iova);
 
 		if (ret)
@@ -383,7 +383,7 @@ static int submit_reloc(struct msm_gem_submit *submit, struct msm_gem_object *ob
 	/* For now, just map the entire thing.  Eventually we probably
 	 * to do it page-by-page, w/ kmap() if not vmap()d..
 	 */
-	ptr = msm_gem_get_vaddr(&obj->base);
+	ptr = msm_gem_get_vaddr_locked(&obj->base);
 
 	if (IS_ERR(ptr)) {
 		ret = PTR_ERR(ptr);
@@ -434,7 +434,7 @@ static int submit_reloc(struct msm_gem_submit *submit, struct msm_gem_object *ob
 	}
 
 out:
-	msm_gem_put_vaddr(&obj->base);
+	msm_gem_put_vaddr_locked(&obj->base);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 55d16489d0f3..015f6b884e2e 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -326,7 +326,9 @@ static void msm_gpu_crashstate_get_bo(struct msm_gpu_state *state,
 		if (!state_bo->data)
 			goto out;
 
+		msm_gem_lock(&obj->base);
 		ptr = msm_gem_get_vaddr_active(&obj->base);
+		msm_gem_unlock(&obj->base);
 		if (IS_ERR(ptr)) {
 			kvfree(state_bo->data);
 			state_bo->data = NULL;
@@ -470,14 +472,22 @@ static void recover_worker(struct work_struct *work)
 			put_task_struct(task);
 		}
 
+		/* msm_rd_dump_submit() needs bo locked to dump: */
+		for (i = 0; i < submit->nr_bos; i++)
+			msm_gem_lock(&submit->bos[i].obj->base);
+
 		if (comm && cmd) {
 			DRM_DEV_ERROR(dev->dev, "%s: offending task: %s (%s)\n",
 				gpu->name, comm, cmd);
 
 			msm_rd_dump_submit(priv->hangrd, submit,
 				"offending task: %s (%s)", comm, cmd);
-		} else
+		} else {
 			msm_rd_dump_submit(priv->hangrd, submit, NULL);
+		}
+
+		for (i = 0; i < submit->nr_bos; i++)
+			msm_gem_unlock(&submit->bos[i].obj->base);
 	}
 
 	/* Record the crash state */
@@ -784,7 +794,7 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 		/* submit takes a reference to the bo and iova until retired: */
 		drm_gem_object_get(&msm_obj->base);
-		msm_gem_get_and_pin_iova(&msm_obj->base, submit->aspace, &iova);
+		msm_gem_get_and_pin_iova_locked(&msm_obj->base, submit->aspace, &iova);
 
 		if (submit->bos[i].flags & MSM_SUBMIT_BO_WRITE)
 			dma_resv_add_excl_fence(drm_obj->resv, submit->fence);
diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index fea30e7aa9e8..659e5cc4b40a 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -333,7 +333,7 @@ static void snapshot_buf(struct msm_rd_state *rd,
 
 	rd_write_section(rd, RD_BUFFER_CONTENTS, buf, size);
 
-	msm_gem_put_vaddr(&obj->base);
+	msm_gem_put_vaddr_locked(&obj->base);
 }
 
 /* called under struct_mutex */
-- 
2.26.2

