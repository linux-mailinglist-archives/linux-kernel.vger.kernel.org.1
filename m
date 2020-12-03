Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136F62CD97A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgLCOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbgLCOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:43:38 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD94FC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 06:42:57 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id v1so1216195pjr.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 06:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3JIu6lw98cKabBdZ9zOZ/djlPH0Wt6XPKXzLtwvrLs=;
        b=PSkcaAW7awwXjQ0CMrmvkVTWs7N/4OnJHeT9sYTN9e1WvNx+09qSEMPbeuPmL57o7R
         UOvK23e+G/b7phpON10QIgqnbYnz587oMB6/dY8JUr7yrwCv9evVJ/QeXdADL1hpQ5gX
         VUEevggIzgaS5iXtj1we6EwsGJPQLuBtB7xKVLUUcUHEVuuHjRbND0kdv6hNAWYaDbW1
         Hgq/wRr/B2KPuHWdBiEpvIuWYvrH0TX6LK9lk6xrOqnT1E3Kn6sbq1qluCZ2VKQoLBfh
         D/gm79cj9tPqG3doLFwsNBLAdczsEVW+RG/oefqHHqQjl/WH0IDiae1Fk/dmZk7r5gL4
         SFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p3JIu6lw98cKabBdZ9zOZ/djlPH0Wt6XPKXzLtwvrLs=;
        b=cjhX33c4ISnF7SiqPmV9OGjsI7tjOOackqCB/DQW4Kww8hj6EW1x81WEzd8OWKOM00
         14uZSbdsDeOUYQ1NSLBLxIs/yjN3YcMNXBgG0TfDap+PqHUS4P5Csl81KWwoYVtPgu4Y
         1zLz3O1guZXWgvzDvyKgYyV8g7btluGzCo7i/YN9atTGumeXTMR83lf1DetncOCLQ6KS
         cD4s5XMD55ZdmmBn7YNwwAvX1X7Xbnteq7vhpKf8X36VozFcMheNyq+pDP6CfiJHxg0e
         D/bYDVfCChb8stKHtZljfeqXZqzLww3/xPjOQ/GFosP/r/dQCqyUiMm6ujoo1ORTHsRc
         GwDg==
X-Gm-Message-State: AOAM5334vZAqtcYXzfn5zZ0kxjjyc7USdSUqI+4dnrF6K0CBqCLUGiNa
        YCs4KUBscv8BSoxbvCn/OKc=
X-Google-Smtp-Source: ABdhPJyP9BvP14g/wb4ZgOx3ktIQlO3Mldowi4PHo+Ye/qwyje5QG2/rjuo91G1zuj1dkvX6Gp0tYw==
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr3307192pjj.206.1607006577360;
        Thu, 03 Dec 2020 06:42:57 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id k9sm2232081pfp.68.2020.12.03.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 06:42:56 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Peter Rosin <peda@axentia.se>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/fb-helper: Add missed unlocks in setcmap_legacy()
Date:   Thu,  3 Dec 2020 22:42:48 +0800
Message-Id: <20201203144248.418281-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setcmap_legacy() does not call drm_modeset_unlock_all() in some exits,
add the missed unlocks with goto to fix it.

Fixes: 964c60063bff ("drm/fb-helper: separate the fb_setcmap helper into atomic and legacy paths")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 1543d9d10970..8033467db4be 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -923,11 +923,15 @@ static int setcmap_legacy(struct fb_cmap *cmap, struct fb_info *info)
 	drm_modeset_lock_all(fb_helper->dev);
 	drm_client_for_each_modeset(modeset, &fb_helper->client) {
 		crtc = modeset->crtc;
-		if (!crtc->funcs->gamma_set || !crtc->gamma_size)
-			return -EINVAL;
+		if (!crtc->funcs->gamma_set || !crtc->gamma_size) {
+			ret = -EINVAL;
+			goto out;
+		}
 
-		if (cmap->start + cmap->len > crtc->gamma_size)
-			return -EINVAL;
+		if (cmap->start + cmap->len > crtc->gamma_size) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		r = crtc->gamma_store;
 		g = r + crtc->gamma_size;
@@ -940,8 +944,9 @@ static int setcmap_legacy(struct fb_cmap *cmap, struct fb_info *info)
 		ret = crtc->funcs->gamma_set(crtc, r, g, b,
 					     crtc->gamma_size, NULL);
 		if (ret)
-			return ret;
+			goto out;
 	}
+out:
 	drm_modeset_unlock_all(fb_helper->dev);
 
 	return ret;
-- 
2.26.2

