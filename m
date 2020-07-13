Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDF321B232
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 11:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGJJ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 05:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgGJJZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:25:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81903C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:25:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so5364151wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jfMXVpKl6vspqUzfRtk9RGf4ooITbe25ARObyR1MQUM=;
        b=lSsk67ke2Kl1vIf5ERlY7TmmPYQTQq2qrJGd8Q/k8kzYygx4SOrakuBuBa3mNxGZAZ
         gDrGXb3yttzOHSIMVhjjxjbi4cETm+LNN/kNxIKzpu6u3zT9Fey/LNC7CGDOsn28VAA+
         cdt+g+hnhzN68Gbzy1P1KyMlDBUnNuwVqXy0RygWHGly9GtPZiqzYqfvDmGnEF6TFOb/
         5xfGot3zt+Cm99VQ3Gjf+vJitrySkhV+bG9QVCYzdLcg7vaHr8T7tYJvATgWWva9Viwn
         DVi1YSR05NY/f9eZjRYkOyLA+1yT7LBqTyZ3+aiyCPhBbTe8CYYtxA77LfRp5AE8iOlN
         pw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jfMXVpKl6vspqUzfRtk9RGf4ooITbe25ARObyR1MQUM=;
        b=noOicshbiLYuhGpgc1XF1BlHhEd8gufO2CIlwfxe82fC7ZMTantDmdkt+36/gawHds
         i1y7Hh3H8g/NN0Da0tCoyXlzc460sSOfpRTO/9wDo7RIUj7xe1hu9IoDd4U8orS1Ad0a
         JCsiLb02nnpigwtndcbWtiuA6USR9bO73pTnRYzB7TF1EleAT83/vVFpXPKS6cBFnI4r
         yfgQMnok56jfeAwiKPPywq7vJEYcclPi3vnsau4jfebsNxz8GpuqMsP33BC6ozvZSUzB
         XvXMCYaRqU1IlI8IbfPZDRbzy4L8mZ+OaW9mxJR8oKAPZaoZ7EEupJ0EYBZBd8aJanZx
         cbiA==
X-Gm-Message-State: AOAM532jzyB7wmZtTlmGM241GcgeDXVwmTpvOyQuyk66I7G1Yt5d8WSG
        gJGdc+yWMZFYhGvLDOm5JQc=
X-Google-Smtp-Source: ABdhPJzbyMlo+MM5KpJLW7iQg9q/fMCIJiRmsZRZEDEGMNVkQA+kCO4fOXXhelpPhnPUUcryZUcBjw==
X-Received: by 2002:a1c:2982:: with SMTP id p124mr4500985wmp.26.1594373157054;
        Fri, 10 Jul 2020 02:25:57 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h23sm8179559wmb.3.2020.07.10.02.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:25:56 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 04/14] drm/panfrost: introduce panfrost_devfreq struct
Date:   Fri, 10 Jul 2020 11:25:38 +0200
Message-Id: <20200710092548.316054-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710092548.316054-1-peron.clem@gmail.com>
References: <20200710092548.316054-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a proper panfrost_devfreq to deal with devfreq variables.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 76 ++++++++++++---------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h | 20 +++++-
 drivers/gpu/drm/panfrost/panfrost_device.h  | 11 +--
 drivers/gpu/drm/panfrost/panfrost_job.c     |  4 +-
 4 files changed, 65 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index df7b71da9a84..962550363391 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -10,23 +10,23 @@
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
 
-static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev)
+static void panfrost_devfreq_update_utilization(struct panfrost_devfreq *pfdevfreq)
 {
 	ktime_t now;
 	ktime_t last;
 
-	if (!pfdev->devfreq.devfreq)
+	if (!pfdevfreq->devfreq)
 		return;
 
 	now = ktime_get();
-	last = pfdev->devfreq.time_last_update;
+	last = pfdevfreq->time_last_update;
 
-	if (atomic_read(&pfdev->devfreq.busy_count) > 0)
-		pfdev->devfreq.busy_time += ktime_sub(now, last);
+	if (atomic_read(&pfdevfreq->busy_count) > 0)
+		pfdevfreq->busy_time += ktime_sub(now, last);
 	else
-		pfdev->devfreq.idle_time += ktime_sub(now, last);
+		pfdevfreq->idle_time += ktime_sub(now, last);
 
-	pfdev->devfreq.time_last_update = now;
+	pfdevfreq->time_last_update = now;
 }
 
 static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
@@ -47,30 +47,31 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 	return 0;
 }
 
-static void panfrost_devfreq_reset(struct panfrost_device *pfdev)
+static void panfrost_devfreq_reset(struct panfrost_devfreq *pfdevfreq)
 {
-	pfdev->devfreq.busy_time = 0;
-	pfdev->devfreq.idle_time = 0;
-	pfdev->devfreq.time_last_update = ktime_get();
+	pfdevfreq->busy_time = 0;
+	pfdevfreq->idle_time = 0;
+	pfdevfreq->time_last_update = ktime_get();
 }
 
 static int panfrost_devfreq_get_dev_status(struct device *dev,
 					   struct devfreq_dev_status *status)
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
+	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
-	panfrost_devfreq_update_utilization(pfdev);
+	panfrost_devfreq_update_utilization(pfdevfreq);
 
 	status->current_frequency = clk_get_rate(pfdev->clock);
-	status->total_time = ktime_to_ns(ktime_add(pfdev->devfreq.busy_time,
-						   pfdev->devfreq.idle_time));
+	status->total_time = ktime_to_ns(ktime_add(pfdevfreq->busy_time,
+						   pfdevfreq->idle_time));
 
-	status->busy_time = ktime_to_ns(pfdev->devfreq.busy_time);
+	status->busy_time = ktime_to_ns(pfdevfreq->busy_time);
 
-	panfrost_devfreq_reset(pfdev);
+	panfrost_devfreq_reset(pfdevfreq);
 
-	dev_dbg(pfdev->dev, "busy %lu total %lu %lu %% freq %lu MHz\n", status->busy_time,
-		status->total_time,
+	dev_dbg(pfdev->dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
+		status->busy_time, status->total_time,
 		status->busy_time / (status->total_time / 100),
 		status->current_frequency / 1000 / 1000);
 
@@ -91,6 +92,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct device *dev = &pfdev->pdev->dev;
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
+	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret == -ENODEV) /* Optional, continue without devfreq */
@@ -98,7 +100,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	else if (ret)
 		return ret;
 
-	panfrost_devfreq_reset(pfdev);
+	panfrost_devfreq_reset(pfdevfreq);
 
 	cur_freq = clk_get_rate(pfdev->clock);
 
@@ -116,53 +118,59 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		dev_pm_opp_of_remove_table(dev);
 		return PTR_ERR(devfreq);
 	}
-	pfdev->devfreq.devfreq = devfreq;
+	pfdevfreq->devfreq = devfreq;
 
 	cooling = of_devfreq_cooling_register(dev->of_node, devfreq);
 	if (IS_ERR(cooling))
 		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
 	else
-		pfdev->devfreq.cooling = cooling;
+		pfdevfreq->cooling = cooling;
 
 	return 0;
 }
 
 void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 {
-	if (pfdev->devfreq.cooling)
-		devfreq_cooling_unregister(pfdev->devfreq.cooling);
+	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
+
+	if (pfdevfreq->cooling)
+		devfreq_cooling_unregister(pfdevfreq->cooling);
 	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
 {
-	if (!pfdev->devfreq.devfreq)
+	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
+
+	if (!pfdevfreq->devfreq)
 		return;
 
-	panfrost_devfreq_reset(pfdev);
+	panfrost_devfreq_reset(pfdevfreq);
 
-	devfreq_resume_device(pfdev->devfreq.devfreq);
+	devfreq_resume_device(pfdevfreq->devfreq);
 }
 
 void panfrost_devfreq_suspend(struct panfrost_device *pfdev)
 {
-	if (!pfdev->devfreq.devfreq)
+	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
+
+	if (!pfdevfreq->devfreq)
 		return;
 
-	devfreq_suspend_device(pfdev->devfreq.devfreq);
+	devfreq_suspend_device(pfdevfreq->devfreq);
 }
 
-void panfrost_devfreq_record_busy(struct panfrost_device *pfdev)
+void panfrost_devfreq_record_busy(struct panfrost_devfreq *pfdevfreq)
 {
-	panfrost_devfreq_update_utilization(pfdev);
-	atomic_inc(&pfdev->devfreq.busy_count);
+	panfrost_devfreq_update_utilization(pfdevfreq);
+	atomic_inc(&pfdevfreq->busy_count);
 }
 
-void panfrost_devfreq_record_idle(struct panfrost_device *pfdev)
+void panfrost_devfreq_record_idle(struct panfrost_devfreq *pfdevfreq)
 {
 	int count;
 
-	panfrost_devfreq_update_utilization(pfdev);
-	count = atomic_dec_if_positive(&pfdev->devfreq.busy_count);
+	panfrost_devfreq_update_utilization(pfdevfreq);
+	count = atomic_dec_if_positive(&pfdevfreq->busy_count);
 	WARN_ON(count < 0);
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index 0611beffc8d0..0697f8d5aa34 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -4,13 +4,29 @@
 #ifndef __PANFROST_DEVFREQ_H__
 #define __PANFROST_DEVFREQ_H__
 
+#include <linux/ktime.h>
+
+struct devfreq;
+struct thermal_cooling_device;
+
+struct panfrost_device;
+
+struct panfrost_devfreq {
+	struct devfreq *devfreq;
+	struct thermal_cooling_device *cooling;
+	ktime_t busy_time;
+	ktime_t idle_time;
+	ktime_t time_last_update;
+	atomic_t busy_count;
+};
+
 int panfrost_devfreq_init(struct panfrost_device *pfdev);
 void panfrost_devfreq_fini(struct panfrost_device *pfdev);
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev);
 void panfrost_devfreq_suspend(struct panfrost_device *pfdev);
 
-void panfrost_devfreq_record_busy(struct panfrost_device *pfdev);
-void panfrost_devfreq_record_idle(struct panfrost_device *pfdev);
+void panfrost_devfreq_record_busy(struct panfrost_devfreq *devfreq);
+void panfrost_devfreq_record_idle(struct panfrost_devfreq *devfreq);
 
 #endif /* __PANFROST_DEVFREQ_H__ */
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index c30c719a8059..2efa59c9d1c5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -13,6 +13,8 @@
 #include <drm/drm_mm.h>
 #include <drm/gpu_scheduler.h>
 
+#include "panfrost_devfreq.h"
+
 struct panfrost_device;
 struct panfrost_mmu;
 struct panfrost_job_slot;
@@ -107,14 +109,7 @@ struct panfrost_device {
 	struct list_head shrinker_list;
 	struct shrinker shrinker;
 
-	struct {
-		struct devfreq *devfreq;
-		struct thermal_cooling_device *cooling;
-		ktime_t busy_time;
-		ktime_t idle_time;
-		ktime_t time_last_update;
-		atomic_t busy_count;
-	} devfreq;
+	struct panfrost_devfreq pfdevfreq;
 };
 
 struct panfrost_mmu {
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 4c13dbae68fb..49b2157d8549 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -145,7 +145,7 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 	u64 jc_head = job->jc;
 	int ret;
 
-	panfrost_devfreq_record_busy(pfdev);
+	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
 
 	ret = pm_runtime_get_sync(pfdev->dev);
 	if (ret < 0)
@@ -478,7 +478,7 @@ static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
 				pfdev->jobs[j] = NULL;
 
 				panfrost_mmu_as_put(pfdev, &job->file_priv->mmu);
-				panfrost_devfreq_record_idle(pfdev);
+				panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
 
 				dma_fence_signal_locked(job->done_fence);
 				pm_runtime_put_autosuspend(pfdev->dev);
-- 
2.25.1

