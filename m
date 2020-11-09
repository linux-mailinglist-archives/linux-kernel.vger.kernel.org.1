Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA022AC6CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgKIVTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIVTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:05 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F681C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:03 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so905328wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MH4JrPJnV93KjKdduQzhuU+LLZMbEyGUifyLAOa0/tA=;
        b=LZgL07ggHJ7R0ptAiCpzHF9zdgd23QxQBllK5tecy3Tb0t8KoVT1vGpK9+6IeZl6Ef
         QoIJBhYsx0LZBTWLDq0577hYyZJNNfKp+3WPEuTdHhOgXWdJt5fegyQFRifigj05BvOy
         20yqpzld/RJwNMLhDNKYqkxNtMyDyaZoqI2T8b7sL5FRdcvW4K8xR6xjT3DLqtGK+/8y
         25EH/0vFCbVKQyOrgk+EDhDJ726xYSE33dZ+NebIY+hwswqauDuUYiNGxQ4ZFGC9sxrZ
         kIA64UzFlAZUGyLWCj6urbm00THq2CnDEDDejjZXcE6t1KYu0ZbV6AgMTzfHPn3FNzd8
         7G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MH4JrPJnV93KjKdduQzhuU+LLZMbEyGUifyLAOa0/tA=;
        b=tp39UD0V6aO7oVoS0TYt9omiAfjlh8RvjVmNel/uWorEv8+sLGxKbgP0XwGCb2ohMf
         dzXaevy1NIWRpDqhP7zVk/Zn2KmU6oR446h5gIseoyi/yVZzCfAM9xHT8s9Gxg2LXUT3
         4BWNYlJi9XybJHAl7le7Y3/Ig+fMtBt2rfDRhfJ16AK070zXGvmrb4NweilgxECJpdfW
         QrZErx2BPuAYw8V+Xw4GqGl6+QwnxJmOV/03G0Az+k6EQ3+Z7AFBechK7uFfxg/kMFPE
         bfQik3LEMI06qseNtuxujTEflIwEQ2sw1v1uVL/odKfXkh9t2gbXXw3D5lPBFGBpTYPT
         gXEQ==
X-Gm-Message-State: AOAM530pyZSMllRpmgwMJ7sxa85XHIX9k+H0VtdsXe//DjpZEUlj8y6D
        LD1Z7xv78LOoEyYa4u8DhiOBdw==
X-Google-Smtp-Source: ABdhPJxdSPxtoC36afFGHEwvmULh35smowKhbslHUgo2HOWGKa+63fsjzvMsN+Wp2EpaveQFY8ErUQ==
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr1090012wma.75.1604956742114;
        Mon, 09 Nov 2020 13:19:02 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jerome Glisse <glisse@freedesktop.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 01/20] drm/radeon/radeon_ttm: Place declaration of 'rdev' in same clause as its use
Date:   Mon,  9 Nov 2020 21:18:36 +0000
Message-Id: <20201109211855.3340030-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_ttm.c: In function ‘radeon_ttm_tt_create’:
 drivers/gpu/drm/radeon/radeon_ttm.c:611:24: warning: variable ‘rdev’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Glisse <glisse@freedesktop.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 95038ac3382e2..a8c915920070f 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -608,21 +608,21 @@ static void radeon_ttm_backend_destroy(struct ttm_bo_device *bdev, struct ttm_tt
 static struct ttm_tt *radeon_ttm_tt_create(struct ttm_buffer_object *bo,
 					   uint32_t page_flags)
 {
-	struct radeon_device *rdev;
 	struct radeon_ttm_tt *gtt;
 	enum ttm_caching caching;
 	struct radeon_bo *rbo;
-
-	rbo = container_of(bo, struct radeon_bo, tbo);
+#if IS_ENABLED(CONFIG_AGP)
+	struct radeon_device *rdev;
 
 	rdev = radeon_get_rdev(bo->bdev);
-#if IS_ENABLED(CONFIG_AGP)
 	if (rdev->flags & RADEON_IS_AGP) {
 		return ttm_agp_tt_create(bo, rdev->ddev->agp->bridge,
 					 page_flags);
 	}
 #endif
 
+	rbo = container_of(bo, struct radeon_bo, tbo);
+
 	gtt = kzalloc(sizeof(struct radeon_ttm_tt), GFP_KERNEL);
 	if (gtt == NULL) {
 		return NULL;
-- 
2.25.1

