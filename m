Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2011129DA80
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390224AbgJ1XXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388185AbgJ1XXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:23:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36116C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:23:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id c72so1349826oig.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRIVhEzHo1XPH6PloaXFLB5fbBAOJPEuMdhJUY10d78=;
        b=iYOIaz1lxvCXYXcNu+M4bI10tLNyS4M9A6CZD5JmtScTgP2CA5ampy0XyQktbCzrM4
         ceakwVehkdY/LSqm0tglgrQrFLMxrSzd5TaJyZKvXoxWuCkMqFjxHRfXCvUmBxOEeBC4
         57vXFD6qCgSo0XOh4N70icprcdVJJu/U6FPp6uXalYDeubBNbKCFyhWyXlWYOhTrXmN9
         111vfz9NNBLBF7Gvxfc/9K/YkdW9/DtxWCkRM4yC8iaExAzHBgoBCqSQKPVxk1WH76am
         qq8qlPNy71RraDWoum8l5+HopRZsSa/Bw0h5Sj+YvUecZ8GJsT/tllUFSCBCz7Jp1CjQ
         mmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRIVhEzHo1XPH6PloaXFLB5fbBAOJPEuMdhJUY10d78=;
        b=el+0f9DsVNouy63Jn0rNG8D8HDt+nIwyYPkn4+zJ9pcIxA2rvx26XXJ+azipWZVpVT
         LMc19cOBBa2bnYfvOjk1pUPi54GAg15aRIonyDw5pQnGuiPJljGaD9RV5pImIOaM0JtK
         d1mW9sB5F5m5KfZ5OB0+uShPXfGC6uF1iW7uyvzD/S99a8frPVtHzV1lyvWPg8YV7EaJ
         8hCiaKJgnsQW6spatmGzf3ZKfR5t18/+EiTRkAxyLDVKiueTDWHe2kiHO6XnEazYn80t
         Ig37JjXv1AhXab0KIs94g/GkHhXnHhZkWHOjzZmeOr42Ek54loF3UTDWSWa+p9Ge/yv6
         96cA==
X-Gm-Message-State: AOAM532OoYCcIwZOpDGgiokcHcRCWDoLvcAwi8PfdsTnGcNp12hpTd4f
        p1hMKhXK5V8ItgxVVicsoAFCuGQYwIoS2Q==
X-Google-Smtp-Source: ABdhPJxsjXO4BzH/gTE1g7vUyycm0va7CGlKvoKvhDoyNRMPGXbtCie5OuI0yJ2/DOj01voeRbrUHg==
X-Received: by 2002:a17:90a:f3d4:: with SMTP id ha20mr5577064pjb.28.1603867467388;
        Tue, 27 Oct 2020 23:44:27 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id t10sm3948706pjr.37.2020.10.27.23.44.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 23:44:26 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     robdclark@gmail.com, Qiang Yu <yuq825@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 Resend 1/2] drm/lima: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Wed, 28 Oct 2020 12:14:21 +0530
Message-Id: <c995335d16d8b4b4ff47b1273869c33e14782b32.1603867405.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
find the OPP table with error -ENODEV (i.e. OPP table not present for
the device). And we can call dev_pm_opp_of_remove_table()
unconditionally here.

Reviewed-by: Qiang Yu <yuq825@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
V2: Applied Reviewed by tag.
---
 drivers/gpu/drm/lima/lima_devfreq.c | 6 +-----
 drivers/gpu/drm/lima/lima_devfreq.h | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index bbe02817721b..cd290d866a04 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -105,10 +105,7 @@ void lima_devfreq_fini(struct lima_device *ldev)
 		devfreq->devfreq = NULL;
 	}
 
-	if (devfreq->opp_of_table_added) {
-		dev_pm_opp_of_remove_table(ldev->dev);
-		devfreq->opp_of_table_added = false;
-	}
+	dev_pm_opp_of_remove_table(ldev->dev);
 
 	if (devfreq->regulators_opp_table) {
 		dev_pm_opp_put_regulators(devfreq->regulators_opp_table);
@@ -162,7 +159,6 @@ int lima_devfreq_init(struct lima_device *ldev)
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret)
 		goto err_fini;
-	ldevfreq->opp_of_table_added = true;
 
 	lima_devfreq_reset(ldevfreq);
 
diff --git a/drivers/gpu/drm/lima/lima_devfreq.h b/drivers/gpu/drm/lima/lima_devfreq.h
index 5eed2975a375..2d9b3008ce77 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.h
+++ b/drivers/gpu/drm/lima/lima_devfreq.h
@@ -18,7 +18,6 @@ struct lima_devfreq {
 	struct opp_table *clkname_opp_table;
 	struct opp_table *regulators_opp_table;
 	struct thermal_cooling_device *cooling;
-	bool opp_of_table_added;
 
 	ktime_t busy_time;
 	ktime_t idle_time;
-- 
2.25.0.rc1.19.g042ed3e048af

