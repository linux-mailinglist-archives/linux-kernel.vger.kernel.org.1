Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38E021A1BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgGIOEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgGIODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C8CC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so2502157wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRoC5bGLlEhSD60pEeaPChiHjDUdFGDEmZk20OrMuc8=;
        b=VRzIX4UkDZrcfBCSmFx2qL3bw3uwmBfQkN30yMkwsg8YIFFtfqQr8L7lM0glu9Gptp
         NNww1+6BwGEVUlKkKQM5I1UZOx1wi+HU1XsLYM4qp4VEvTTH3l29SyFJ7fRjmxNGtCt5
         NANjekv6+7q47QIKzfQjjE53YHyTx9wCWbAWhHMJ+VvAS0qIjkqLFYMtyENmaI33kDPT
         E+kRWgaK1xUcVrgm/ZG6RwKMmiHVmEQsx8XkazsavTKB65+IQBcGbMglmcSd23hfdQsz
         Pyb1tTDRWhl6IrWwqAmiF7VdkffTeKMwhg6ba3WBMevikYTDDvL9UkwlcAQp1Fv23cbY
         dHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRoC5bGLlEhSD60pEeaPChiHjDUdFGDEmZk20OrMuc8=;
        b=n7X0zZGZB7K/Xu2VqepECokRVpWmbUuMZLEYc5Pe37znqzl+0wQfiSdh1HZvhTxc1Q
         4VaWpDC/sFyqalyjUUIMWW92197Oi/QtaY9O1ZgzTOgxNGia8471HhhuBaAaR+Z+r9Qp
         evaVDwGQl9pi3wg1p6KSA+0w875wWtQDUAyTvweWgUGZYN5W5cwGs6RJiIAuTXeIppf9
         poBmCwZnj8vwBxeRBbV7sJxWUh0SHtOBnE/ibS5C7In0iW7nodwKwftZB6MqTEo6uM2p
         H8qgLHZNvwuLAyInAcmUyTmsY4Mbib5ofv8xvf5am/LvzvGOQyYuCveoClOcanVqqocE
         BeTg==
X-Gm-Message-State: AOAM533i8iqYesYKcZ6q/YXiQfajLAXa1XRWcvj3lOB7Bb0nhF0mopdX
        +PdSTcMwEvVEEOMxxnZZ9Qs=
X-Google-Smtp-Source: ABdhPJzXtEuBoawLX4d1SvLyRTEANvQMgFlipC/UWsLRMfhoJFgeyV8hdw1DOV8Qxc5Mgw3tD8GX4g==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr64829525wru.399.1594303411006;
        Thu, 09 Jul 2020 07:03:31 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:30 -0700 (PDT)
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
Subject: [PATCH v3 04/14] drm/panfrost: introduce panfrost_devfreq struct
Date:   Thu,  9 Jul 2020 16:03:12 +0200
Message-Id: <20200709140322.131320-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709140322.131320-1-peron.clem@gmail.com>
References: <20200709140322.131320-1-peron.clem@gmail.com>
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
 drivers/gpu/drm/panfrost/panfrost_job.c     |  6 +-
 4 files changed, 66 insertions(+), 47 deletions(-)

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
index 63e32a9f2749..a67f3eac6a58 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -155,7 +155,7 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 	}
 
 	cfg = panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
-	panfrost_devfreq_record_busy(pfdev);
+	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
 
 	job_write(pfdev, JS_HEAD_NEXT_LO(js), jc_head & 0xFFFFFFFF);
 	job_write(pfdev, JS_HEAD_NEXT_HI(js), jc_head >> 32);
@@ -415,7 +415,7 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
 	}
 	spin_unlock_irqrestore(&pfdev->js->job_lock, flags);
 
-	panfrost_devfreq_record_idle(pfdev);
+	panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
 	panfrost_device_reset(pfdev);
 
 	for (i = 0; i < NUM_JOB_SLOTS; i++)
@@ -478,7 +478,7 @@ static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
 				pfdev->jobs[j] = NULL;
 
 				panfrost_mmu_as_put(pfdev, &job->file_priv->mmu);
-				panfrost_devfreq_record_idle(pfdev);
+				panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
 
 				dma_fence_signal_locked(job->done_fence);
 				pm_runtime_put_autosuspend(pfdev->dev);
-- 
2.25.1

