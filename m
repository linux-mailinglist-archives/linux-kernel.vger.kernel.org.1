Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D421A1B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGIODi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 10:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgGIODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:03:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B07C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:03:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so2502310wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eRj3Oh7sZBJWwDgWc3ORgJ0pvlwZ3+3t0oGyKYtF1AQ=;
        b=TvqytnKA8EMxKSNy7l2um5FuNdy3SYJ1dCG/7d4j6F6McuYKM8i2ZJD6vKXk0zi0sW
         iLOnpHvZFdRKvuQ4F/qk2i4hnaCpqz3S+KTaObiu/vxoojV/loemRU+qqb69JvOiKPDP
         L9xNxHrXw8FYaQ2Qu+2GrfYO2+fFLb7lmV+omk+L5cNjBloyV2TtY/zbzYyBYQnFimYN
         8AyZi1sj7XAKYvMWS2Bioq/QOag3KODrknXJbFSNxV1V8A4z1fTwFOLHwC1SyhPGv+bZ
         Ml24pU2qObO2sXH93W147qiqJXbCXO17gVDejiU3pLSkOldsS0DL7DUgMX1yuOwiNtJL
         7Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eRj3Oh7sZBJWwDgWc3ORgJ0pvlwZ3+3t0oGyKYtF1AQ=;
        b=ejLOzQ7Jw7c+Acxsd6pCA8lwOCgHZea16jjZdHc8Ni2aa6q5n0+hj7d42KtWt48Txy
         6pJpxPuCjvD0ibtHkvPNkIOV1+uNKiGJroDDpbE4a8C+NTJ8hGE3fi7UGuIsOivVR4qg
         aKxC9br2aDi8vsjtKqFaapVaRtXKxtHgq3U5cYo/BvslkiPE4lnljA8dPlBVYJuYm2hD
         YzSTb6eKkug0k66bf7ALcX1xHj3e/gwS1gYyGCTPA3cjGwm80qXaZ8mRXeSuC0z/wu2d
         yBMhgJ9iC7qEgE+gwqjUzm3bPay6SERmKsp+9MzuaiN8396fJC7l0zbMQDyA0BcsqZFU
         JAug==
X-Gm-Message-State: AOAM532UOMw2yZNh4lN7mZY5tWlqY0dnKQiXihXLjQdROMejuixmG1KH
        V9TwidpWOYW1J4cBSNql4EA=
X-Google-Smtp-Source: ABdhPJw84FXJpRMyrNsB+Uk7XKJyvE///uOAMmssgYl7VQxKTPBERcN45fyPtDnuQOC7hHl3ZBZChg==
X-Received: by 2002:a5d:420e:: with SMTP id n14mr67522767wrq.164.1594303413447;
        Thu, 09 Jul 2020 07:03:33 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s8sm5545256wru.38.2020.07.09.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:03:32 -0700 (PDT)
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
Subject: [PATCH v3 06/14] drm/panfrost: properly handle error in probe
Date:   Thu,  9 Jul 2020 16:03:14 +0200
Message-Id: <20200709140322.131320-7-peron.clem@gmail.com>
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

Introduce a boolean to know if opp table has been added.

With this, we can call panfrost_devfreq_fini() in case of error
and release what has been initialised.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 25 ++++++++++++++++-----
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 78753cfb59fb..d9007f44b772 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -101,6 +101,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		return 0;
 	else if (ret)
 		return ret;
+	pfdevfreq->opp_of_table_added = true;
 
 	spin_lock_init(&pfdevfreq->lock);
 
@@ -109,8 +110,10 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	cur_freq = clk_get_rate(pfdev->clock);
 
 	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
-	if (IS_ERR(opp))
-		return PTR_ERR(opp);
+	if (IS_ERR(opp)) {
+		ret = PTR_ERR(opp);
+		goto err_fini;
+	}
 
 	panfrost_devfreq_profile.initial_freq = cur_freq;
 	dev_pm_opp_put(opp);
@@ -119,8 +122,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
 	if (IS_ERR(devfreq)) {
 		DRM_DEV_ERROR(dev, "Couldn't initialize GPU devfreq\n");
-		dev_pm_opp_of_remove_table(dev);
-		return PTR_ERR(devfreq);
+		ret = PTR_ERR(devfreq);
+		goto err_fini;
 	}
 	pfdevfreq->devfreq = devfreq;
 
@@ -131,15 +134,25 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		pfdevfreq->cooling = cooling;
 
 	return 0;
+
+err_fini:
+	panfrost_devfreq_fini(pfdev);
+	return ret;
 }
 
 void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 {
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
-	if (pfdevfreq->cooling)
+	if (pfdevfreq->cooling) {
 		devfreq_cooling_unregister(pfdevfreq->cooling);
-	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+		pfdevfreq->cooling = NULL;
+	}
+
+	if (pfdevfreq->opp_of_table_added) {
+		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+		pfdevfreq->opp_of_table_added = false;
+	}
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index 3392df1020be..210269944687 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -15,6 +15,7 @@ struct panfrost_device;
 struct panfrost_devfreq {
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
+	bool opp_of_table_added;
 
 	ktime_t busy_time;
 	ktime_t idle_time;
-- 
2.25.1

