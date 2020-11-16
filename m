Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173D82B4D67
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbgKPRhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733233AbgKPRhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:23 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A620C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:23 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so9668wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BSn+OXUyqlvsEb5g4HG7YJio2FrFxnG4RAzoSpJ37n4=;
        b=V+ElGLhIkl31Mb6P/M3XGUqM6iyTGUDvmxvcJhvSe07Njk+hFpmjbacneoTsjLTfSA
         sFaHyOduil4Gvo0/pfIxP9JJGg9xIs4lJ6PC/K/1BjS5gzfuKAtS4dA3U/06gExWEepW
         z34W2YW39i60AK8MaVWa5tWhHqmxnSpDAcSwTB7TvxuMDO1A6bNFQdF9k66dM1xEHqv7
         +U3CyMQ83XgpjYOueCkvHHKJV8TuCuYa8gCaCPC1qX1Ro21fGH6DH24sQ4vz9p4c35qp
         vypuRQj7FtZdT32r2KCrzyTF4ZPSx0btFEs2MYm25/t3tW94aqCkVKeabvJsqDXn9AJW
         ULeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSn+OXUyqlvsEb5g4HG7YJio2FrFxnG4RAzoSpJ37n4=;
        b=MSrz4WZRhIA8lD5wCIzm7fdnsnkf4PxD28RkVb3iYjQP/NeZFvFCJZMdoiODsRxyMw
         yFCjzdgcG82bmf8vdIAjIKTO1uSIn9sxwg+0O+Rdvlo/9zj3vhh4K0DCw0ODyaMx8R9C
         wKkt5EjTFe1emjS1Jl11PA6gxfHP6W4ZGuRY6VgIPXEvVi1YggLQNspszLo5JF4/l6tn
         5t9RSClnMWnL/++jux1T6byroMOy0MWu0Hykf8q3z3WDLr2T8umRZFXWQyiKy9WgI50H
         +8reSV+E9L9wAMgYSi0k+qWRDOc46pSiPW0ZR3SLXoNbVbthQu2IIm0lvbPgmaV8zZMl
         sL2A==
X-Gm-Message-State: AOAM5323if3DIxcmnKen2e5GHydHBXAtrVbv12xF+cq61u1HlYCq+PTy
        AGc39froUDfw5pgI2jQljBVwqA==
X-Google-Smtp-Source: ABdhPJxXTILeArQ2qdcPdd40XEL/rxA2gV1qsUMQkoZC+iy0q2saiuvG4VqLjI16yVxZ/cTxA9BrFw==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr16513667wmr.179.1605548242110;
        Mon, 16 Nov 2020 09:37:22 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gareth Hughes <gareth@valinux.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 13/43] drm/radeon/radeon_drv: Move 'radeon_mmap()'s prototype to shared header
Date:   Mon, 16 Nov 2020 17:36:30 +0000
Message-Id: <20201116173700.1830487-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/radeon_ttm.c:931:5: warning: no previous prototype for ‘radeon_mmap’ [-Wmissing-prototypes]
 931 | int radeon_mmap(struct file *filp, struct vm_area_struct *vma)
 | ^~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Gareth Hughes <gareth@valinux.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 2 +-
 drivers/gpu/drm/radeon/radeon_ttm.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 536b246b9a6aa..2b9deaead99b2 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -51,6 +51,7 @@
 #include <drm/radeon_drm.h>
 
 #include "radeon_drv.h"
+#include "radeon_ttm.h"
 #include "radeon.h"
 #include "radeon_device.h"
 
@@ -125,7 +126,6 @@ extern int radeon_get_crtc_scanoutpos(struct drm_device *dev, unsigned int crtc,
 				      ktime_t *stime, ktime_t *etime,
 				      const struct drm_display_mode *mode);
 extern bool radeon_is_px(struct drm_device *dev);
-int radeon_mmap(struct file *filp, struct vm_area_struct *vma);
 int radeon_mode_dumb_mmap(struct drm_file *filp,
 			  struct drm_device *dev,
 			  uint32_t handle, uint64_t *offset_p);
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.h b/drivers/gpu/drm/radeon/radeon_ttm.h
index 91ea7141bc812..4d7b90ee27740 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.h
+++ b/drivers/gpu/drm/radeon/radeon_ttm.h
@@ -32,5 +32,6 @@ struct radeon_device;
 
 int radeon_ttm_init(struct radeon_device *rdev);
 void radeon_ttm_fini(struct radeon_device *rdev);
+int radeon_mmap(struct file *filp, struct vm_area_struct *vma);
 
 #endif				/* __RADEON_TTM_H__ */
-- 
2.25.1

