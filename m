Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0973625EA2F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 22:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgIEUEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 16:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgIEUEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 16:04:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E52C061244;
        Sat,  5 Sep 2020 13:04:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t7so1601285pjd.3;
        Sat, 05 Sep 2020 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aVMkWCieLiQqs1s98W4fKMDNGsrQRdazjGIgX0sG0U8=;
        b=XIsst6zTRocNpSbh8ZkMcP8rXc1UlxPp9wvTGhVHdMt2FAqKPKGysbEjoDrzXjy4S/
         PC3N+IWrPHnYBAZCVnuQmwzU4wDWQz4c/hmZoh76Covq4UvhJS+lxh4DX6LCbiDTuCkQ
         ploMnJat8u1KpKtJRVHbTeSZUjl9RLMis+9k9neUHhSW4wftRh2z1gC3XN4junA/Q0VF
         o/H7VkAd4vX69OCQZ36qlwRiJsBGyCQ/e6OPZNlnrvn8vP449AnweWxH5Oc8OlmQGxHP
         9hqM0a+7zopVkWSQNvr/Dsf6H73wmlbpG1MtysUeEed5lQKId7YUv+JL1oDa/ApWEQyt
         21eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aVMkWCieLiQqs1s98W4fKMDNGsrQRdazjGIgX0sG0U8=;
        b=KzBrYripMTnLA+CVdw2J9utEpiBYjBBWzXxckcuSXHnWLYdyzYKZsgA6pK6pVpN9Sa
         VV6tIW9S8bO7+5A6EvnD+yr0ObfEa2S8VbMl8qoKpbhYrM49lqX1owajchJpnW7ivYTK
         Br2jD/WBOqfihALDrIExz3yZBOstsNb3YqhLBZD8pV/HzUN1090fk0j95/E0AHIb9yGU
         tOYQXoqFaA95zzfd+WbdDX9wmNLqiyv/pYwqD+sUrxuAtTKU6H5ys43+kgGrZcxzAVkw
         iuYuWJHfM7JPJvRF53q+mLMU1CpqpzeraeOb3QhyAkJEiEL7F9JdpnjLjn0fE6ZCsCLo
         U4Uw==
X-Gm-Message-State: AOAM533WBRwc+JwhoOPkJ1kbNL+hG7H7lpnGFiHCu0R0Wdax0+EjfEBz
        GRG/ihhYKZgWTzGxwQqx/+A=
X-Google-Smtp-Source: ABdhPJzfSQzj1VT/1ZeuQwfFa6XbcOUoxqCIasybI+jgmGkTQ4Dov2x78m0PB+fX5c5v+yVMYjtrgg==
X-Received: by 2002:a17:90a:c791:: with SMTP id gn17mr13007632pjb.44.1599336276589;
        Sat, 05 Sep 2020 13:04:36 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id l19sm10293189pff.8.2020.09.05.13.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 13:04:35 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v17 11/20] drm/msm: Show process names in gem_describe
Date:   Sat,  5 Sep 2020 13:04:17 -0700
Message-Id: <20200905200454.240929-12-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905200454.240929-1-robdclark@gmail.com>
References: <20200905200454.240929-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

In $debugfs/gem we already show any vma(s) associated with an object.
Also show process names if the vma's address space is a per-process
address space.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/msm_drv.c     |  2 +-
 drivers/gpu/drm/msm/msm_gem.c     | 25 +++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_gem.h     |  5 +++++
 drivers/gpu/drm/msm/msm_gem_vma.c |  1 +
 drivers/gpu/drm/msm/msm_gpu.c     |  8 +++++---
 drivers/gpu/drm/msm/msm_gpu.h     |  2 +-
 6 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 7e963f707852..7143756b7e83 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -597,7 +597,7 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
 	kref_init(&ctx->ref);
 	msm_submitqueue_init(dev, ctx);
 
-	ctx->aspace = msm_gpu_create_private_address_space(priv->gpu);
+	ctx->aspace = msm_gpu_create_private_address_space(priv->gpu, current);
 	file->driver_priv = ctx;
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 3cb7aeb93fd3..76a6c5271e57 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -842,11 +842,28 @@ void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m)
 
 		seq_puts(m, "      vmas:");
 
-		list_for_each_entry(vma, &msm_obj->vmas, list)
-			seq_printf(m, " [%s: %08llx,%s,inuse=%d]",
-				vma->aspace != NULL ? vma->aspace->name : NULL,
-				vma->iova, vma->mapped ? "mapped" : "unmapped",
+		list_for_each_entry(vma, &msm_obj->vmas, list) {
+			const char *name, *comm;
+			if (vma->aspace) {
+				struct msm_gem_address_space *aspace = vma->aspace;
+				struct task_struct *task =
+					get_pid_task(aspace->pid, PIDTYPE_PID);
+				if (task) {
+					comm = kstrdup(task->comm, GFP_KERNEL);
+				} else {
+					comm = NULL;
+				}
+				name = aspace->name;
+			} else {
+				name = comm = NULL;
+			}
+			seq_printf(m, " [%s%s%s: aspace=%p, %08llx,%s,inuse=%d]",
+				name, comm ? ":" : "", comm ? comm : "",
+				vma->aspace, vma->iova,
+				vma->mapped ? "mapped" : "unmapped",
 				vma->inuse);
+			kfree(comm);
+		}
 
 		seq_puts(m, "\n");
 	}
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 9c573c4269cb..7b1c7a5f8eef 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -24,6 +24,11 @@ struct msm_gem_address_space {
 	spinlock_t lock; /* Protects drm_mm node allocation/removal */
 	struct msm_mmu *mmu;
 	struct kref kref;
+
+	/* For address spaces associated with a specific process, this
+	 * will be non-NULL:
+	 */
+	struct pid *pid;
 };
 
 struct msm_gem_vma {
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 29cc1305cf37..80a8a266d68f 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -17,6 +17,7 @@ msm_gem_address_space_destroy(struct kref *kref)
 	drm_mm_takedown(&aspace->mm);
 	if (aspace->mmu)
 		aspace->mmu->funcs->destroy(aspace->mmu);
+	put_pid(aspace->pid);
 	kfree(aspace);
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 9f1bd17dfa47..59eed0fb12fc 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -825,10 +825,9 @@ static int get_clocks(struct platform_device *pdev, struct msm_gpu *gpu)
 
 /* Return a new address space for a msm_drm_private instance */
 struct msm_gem_address_space *
-msm_gpu_create_private_address_space(struct msm_gpu *gpu)
+msm_gpu_create_private_address_space(struct msm_gpu *gpu, struct task_struct *task)
 {
 	struct msm_gem_address_space *aspace = NULL;
-
 	if (!gpu)
 		return NULL;
 
@@ -836,8 +835,11 @@ msm_gpu_create_private_address_space(struct msm_gpu *gpu)
 	 * If the target doesn't support private address spaces then return
 	 * the global one
 	 */
-	if (gpu->funcs->create_private_address_space)
+	if (gpu->funcs->create_private_address_space) {
 		aspace = gpu->funcs->create_private_address_space(gpu);
+		if (!IS_ERR(aspace))
+			aspace->pid = get_pid(task_pid(task));
+	}
 
 	if (IS_ERR_OR_NULL(aspace))
 		aspace = msm_gem_address_space_get(gpu->aspace);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 04a2f7539712..5ee358b480e6 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -301,7 +301,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		const char *name, struct msm_gpu_config *config);
 
 struct msm_gem_address_space *
-msm_gpu_create_private_address_space(struct msm_gpu *gpu);
+msm_gpu_create_private_address_space(struct msm_gpu *gpu, struct task_struct *task);
 
 void msm_gpu_cleanup(struct msm_gpu *gpu);
 
-- 
2.26.2

