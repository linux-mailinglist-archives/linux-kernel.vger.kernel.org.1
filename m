Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6DE29753A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbgJWQvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbgJWQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:50:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFECBC0613CE;
        Fri, 23 Oct 2020 09:50:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o3so1675392pgr.11;
        Fri, 23 Oct 2020 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T65l5OzdCWVlcYo2A+cV1OI3UJqt/gtMxWAEJ0nkpyI=;
        b=LpeSyaXQ5Uq5TNwOlPK9WX4WMRNr+SFQfDimiv4wY/ZkutkYyhIs/pnisIqt5SIL4y
         KZanpAVtzXDdblPb9Lc/fRTJMCsN1QOF/roXuJMbH3DwWHYsERxwjGWjvViaV5pRxa3G
         y6dcBMWgh0zYn2MhxBRmH/IlA4NIkssyGKs8rZcBwR4irJwJ7Wrw+GRyND8p8NQEQxnO
         Z774gM5m1yHUU4/T5/7CSbJDESSF7vOxqHcpBBY1VzEOd/KejiVZsCHRoSTQgjAPCqPY
         4lHvnAQZ2LZcrlhMbq4cpaRiV9lz5/KvBxgGmo4zo1A3ONz36Y2n6rQryupz7mXhcXp5
         OSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T65l5OzdCWVlcYo2A+cV1OI3UJqt/gtMxWAEJ0nkpyI=;
        b=B1f608sm7p39yu2YRHd1Bqy4MhjaBaSry9eAU2UcOMp/3KXXAPbsMntHdVWn5/aMwl
         CJ7cvApFjT21OsjtCBkP/rPtCeOJ6SsmVJocTm53slI7Sf522RMbea9SPOS4oHtC8Dve
         OvN64glPcXnVaPAtTtqTVB74VIsp5u0BMtS9NCbKDpv//3C1yZTl6P5B36baPzXoMYct
         jGrgl4ukAeI2gY0pxeLUxpk1NvQVcd/ekLyQCNB1U/i5LhJqOWl40m1ony0hyo4nGRFV
         T/O73dvp+0NnchcwongyTaIrLaOVpQiCsjHgZ336lxALmTCpHUxDBPnIAa9lmqKDs70p
         pXPw==
X-Gm-Message-State: AOAM533okRh9l7IP8Lf8QOmE/AUIi5kXPpI6psaN/IcJAqF5ahI/5R2D
        0jxkqy3WtJMXD2qlYPVP7IxuvhmwaJhlCQ==
X-Google-Smtp-Source: ABdhPJxdsGn4DcW3sIu1T8u4cxzkDAUGi6q8In/53gQmu61hevJk4ZwWopThRrd5CvYRNlJCcvNw9g==
X-Received: by 2002:a62:ce08:0:b029:156:4427:4b29 with SMTP id y8-20020a62ce080000b029015644274b29mr3112775pfg.70.1603471853312;
        Fri, 23 Oct 2020 09:50:53 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id t6sm2661170pfl.50.2020.10.23.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:50:52 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 17/23] drm/msm: Remove obj->gpu
Date:   Fri, 23 Oct 2020 09:51:18 -0700
Message-Id: <20201023165136.561680-18-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023165136.561680-1-robdclark@gmail.com>
References: <20201023165136.561680-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

It cannot be atomically updated with obj->active_count, and the only
purpose is a useless WARN_ON() (which becomes a buggy WARN_ON() once
retire_submits() is not serialized with incoming submits via
struct_mutex)

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Kristian H. Kristensen <hoegsberg@google.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 2 --
 drivers/gpu/drm/msm/msm_gem.h | 1 -
 drivers/gpu/drm/msm/msm_gpu.c | 5 -----
 3 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 81ed03322a74..b9de19462109 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -775,7 +775,6 @@ void msm_gem_active_get(struct drm_gem_object *obj, struct msm_gpu *gpu)
 
 	if (!atomic_fetch_inc(&msm_obj->active_count)) {
 		mutex_lock(&priv->mm_lock);
-		msm_obj->gpu = gpu;
 		list_del_init(&msm_obj->mm_list);
 		list_add_tail(&msm_obj->mm_list, &gpu->active_list);
 		mutex_unlock(&priv->mm_lock);
@@ -791,7 +790,6 @@ void msm_gem_active_put(struct drm_gem_object *obj)
 
 	if (!atomic_dec_return(&msm_obj->active_count)) {
 		mutex_lock(&priv->mm_lock);
-		msm_obj->gpu = NULL;
 		list_del_init(&msm_obj->mm_list);
 		list_add_tail(&msm_obj->mm_list, &priv->inactive_list);
 		mutex_unlock(&priv->mm_lock);
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 2f289c436ddd..f4e73c6f07bf 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -64,7 +64,6 @@ struct msm_gem_object {
 	 *
 	 */
 	struct list_head mm_list;
-	struct msm_gpu *gpu;     /* non-null if active */
 
 	/* Transiently in the process of submit ioctl, objects associated
 	 * with the submit are on submit->bo_list.. this only lasts for
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index bcd9b4fa98b2..d0f625112a97 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -810,11 +810,6 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 		struct drm_gem_object *drm_obj = &msm_obj->base;
 		uint64_t iova;
 
-		/* can't happen yet.. but when we add 2d support we'll have
-		 * to deal w/ cross-ring synchronization:
-		 */
-		WARN_ON(is_active(msm_obj) && (msm_obj->gpu != gpu));
-
 		/* submit takes a reference to the bo and iova until retired: */
 		drm_gem_object_get(&msm_obj->base);
 		msm_gem_get_and_pin_iova_locked(&msm_obj->base, submit->aspace, &iova);
-- 
2.26.2

