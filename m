Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8653521A1BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGIOEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgGIODd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FEDC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a6so6347696wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztEfvDOenwmzhW91KrXpwCBICtYWbElja0rQb72V3Pc=;
        b=CUBY/gohnMihUfeW7hYoZa4qRuiuQR6oligMzAnmkB6qyrwohT837xR+hdTJY71AuN
         vRGEetbFmM/z0UeTMsaZw5vbs1h/T1iTja3IZz3OP/WiG4AL9OuShqkElaI2f1YXBH8N
         6XSr/k0UULPgkxEILbww2PnvUk0cDm4MNUDd3kDy63uMWlj8XQ+NflE4Tr3+csuMTxoH
         l8ylr0QVrmNAiZeWyxQMNGm8S0Nivf79M+AGDQF871Q9Bma1NQwIxANBmPBYsXqHAba1
         fpLidTdFSDfa/od40aFvbL5kEI8A4z0PPCRZwzq892JpUlG9EDMMRE57RkC/ncskpI5O
         GmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztEfvDOenwmzhW91KrXpwCBICtYWbElja0rQb72V3Pc=;
        b=rsNGDDHtGWJ85Pd8M+nXDsA8t4ghYukj52DRPFQvFaB8dvE3IhWLlMJb2qFSVVE/Y5
         Md8lgf8xGCyUPAoB1Ue0JO8o8r1RXXlp0afOJ87su965HUPEbeFRVq5X9gzMkBE7UYzB
         /E5fePOqdtuE4c6z51SI8KngKaU0yU/2YbeCOASR46MUxutzMDFa0jHwVaAFLyDNMoTn
         JdKyOQSDY8hinO/oaUbkwJWLxLq/lfvt9ycYSRjWmt/AO8db/HueKXoGXMTbCDzKyO7k
         RKYZtowj8kXWkPeTcgv6JHgLY3f7nm06brfvp+xDQm9pKSCd2RZmS7Fdnw/EU4WuthxP
         p1bQ==
X-Gm-Message-State: AOAM5304nhEqSq1dqVtfUpFbToX/mcAYh6p3pDEYyERPqy9RqaPv2KpK
        ffj1lGQVPhyKmhUUSI6f4J0=
X-Google-Smtp-Source: ABdhPJx/ayH+Q5ywOwP/RWCOz75bR/TbNDJfRCtUuCjaJiMQMCnozgskzfgigx+WYPDigoa5e69SWg==
X-Received: by 2002:a1c:dfc5:: with SMTP id w188mr170663wmg.182.1594303412263;
        Thu, 09 Jul 2020 07:03:32 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:31 -0700 (PDT)
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
Subject: [PATCH v3 05/14] drm/panfrost: use spinlock instead of atomic
Date:   Thu,  9 Jul 2020 16:03:13 +0200
Message-Id: <20200709140322.131320-6-peron.clem@gmail.com>
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

Convert busy_count to a simple int protected by spinlock.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 43 +++++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  9 ++++-
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 962550363391..78753cfb59fb 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -12,16 +12,12 @@
 
 static void panfrost_devfreq_update_utilization(struct panfrost_devfreq *pfdevfreq)
 {
-	ktime_t now;
-	ktime_t last;
-
-	if (!pfdevfreq->devfreq)
-		return;
+	ktime_t now, last;
 
 	now = ktime_get();
 	last = pfdevfreq->time_last_update;
 
-	if (atomic_read(&pfdevfreq->busy_count) > 0)
+	if (pfdevfreq->busy_count > 0)
 		pfdevfreq->busy_time += ktime_sub(now, last);
 	else
 		pfdevfreq->idle_time += ktime_sub(now, last);
@@ -59,10 +55,14 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
+	unsigned long irqflags;
+
+	status->current_frequency = clk_get_rate(pfdev->clock);
+
+	spin_lock_irqsave(&pfdevfreq->lock, irqflags);
 
 	panfrost_devfreq_update_utilization(pfdevfreq);
 
-	status->current_frequency = clk_get_rate(pfdev->clock);
 	status->total_time = ktime_to_ns(ktime_add(pfdevfreq->busy_time,
 						   pfdevfreq->idle_time));
 
@@ -70,6 +70,8 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
 
 	panfrost_devfreq_reset(pfdevfreq);
 
+	spin_unlock_irqrestore(&pfdevfreq->lock, irqflags);
+
 	dev_dbg(pfdev->dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
 		status->busy_time, status->total_time,
 		status->busy_time / (status->total_time / 100),
@@ -100,6 +102,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	else if (ret)
 		return ret;
 
+	spin_lock_init(&pfdevfreq->lock);
+
 	panfrost_devfreq_reset(pfdevfreq);
 
 	cur_freq = clk_get_rate(pfdev->clock);
@@ -162,15 +166,32 @@ void panfrost_devfreq_suspend(struct panfrost_device *pfdev)
 
 void panfrost_devfreq_record_busy(struct panfrost_devfreq *pfdevfreq)
 {
+	unsigned long irqflags;
+
+	if (!pfdevfreq->devfreq)
+		return;
+
+	spin_lock_irqsave(&pfdevfreq->lock, irqflags);
+
 	panfrost_devfreq_update_utilization(pfdevfreq);
-	atomic_inc(&pfdevfreq->busy_count);
+
+	pfdevfreq->busy_count++;
+
+	spin_unlock_irqrestore(&pfdevfreq->lock, irqflags);
 }
 
 void panfrost_devfreq_record_idle(struct panfrost_devfreq *pfdevfreq)
 {
-	int count;
+	unsigned long irqflags;
+
+	if (!pfdevfreq->devfreq)
+		return;
+
+	spin_lock_irqsave(&pfdevfreq->lock, irqflags);
 
 	panfrost_devfreq_update_utilization(pfdevfreq);
-	count = atomic_dec_if_positive(&pfdevfreq->busy_count);
-	WARN_ON(count < 0);
+
+	WARN_ON(--pfdevfreq->busy_count < 0);
+
+	spin_unlock_irqrestore(&pfdevfreq->lock, irqflags);
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index 0697f8d5aa34..3392df1020be 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -4,6 +4,7 @@
 #ifndef __PANFROST_DEVFREQ_H__
 #define __PANFROST_DEVFREQ_H__
 
+#include <linux/spinlock.h>
 #include <linux/ktime.h>
 
 struct devfreq;
@@ -14,10 +15,16 @@ struct panfrost_device;
 struct panfrost_devfreq {
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
+
 	ktime_t busy_time;
 	ktime_t idle_time;
 	ktime_t time_last_update;
-	atomic_t busy_count;
+	int busy_count;
+	/*
+	 * Protect busy_time, idle_time, time_last_update and busy_count
+	 * because these can be updated concurrently between multiple jobs.
+	 */
+	spinlock_t lock;
 };
 
 int panfrost_devfreq_init(struct panfrost_device *pfdev);
-- 
2.25.1

