Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86D42ADF96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbgKJTcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731871AbgKJTbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:42 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1DDC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:41 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 23so2652973wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BSn+OXUyqlvsEb5g4HG7YJio2FrFxnG4RAzoSpJ37n4=;
        b=IWSDVKQFg3hpW8WwWnraoONM854vSPQmeNeTXUPVHV2/Mrs0NRUEKMoXn9yMH91a+B
         68ndDNvEffubTXaT7qdx8pdnKbe0bn0OWdVSy0Y4ttygX7CeW5rC91Cf7opxRCPpTZ4u
         mJ5Z88gfhGnngt/P+SIBa18MYmx+vzsnUTjS1lupg/L2S15JCAy38Szym/o6fDNcFpS8
         zspEldGMz285nlZIgF2gy0AGAGL7PAs8AxLYCSNIHCbxlVdqoD46QmdMHn4Wn7W6Xc6V
         AK9qL5k45Pr4fW60coQpZkbVQ8AHoZD6WE+mdwv3lRwL36VWbSOS/7hPW10x66D2uFiN
         qbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSn+OXUyqlvsEb5g4HG7YJio2FrFxnG4RAzoSpJ37n4=;
        b=CUCssInr/+SdaTT/AGBKGwN7zop+rb4frmfmFNZyCxbDnBttsstYVSfhawM3t+t0WO
         Qq/IlGiojjyOIj5ycjE1HzgFSiZU/pTNdnScERKoMGZIlQTPtdQMgR4yCkoLhA9shTkg
         GYZ77+dWFg5QovMnJG9XQAMHzD59X9R99aaQv6y0xWkz+nP0E9ffiNVxAC+ca0QAYQi3
         not05qyOZhY5HEsmtVsLpS+ghPYz+249TuHl2r4Nb2LWub2X9EqVeDTTgb3R0S7LX7wH
         AIQ25vkvbLeUAnj2qo874YK0pwJN1pv72Qr2tHlEVFIrsYkdB1xFHiVvynVM42o5+d8M
         cZ0A==
X-Gm-Message-State: AOAM530Yvzcea512T7BVVuvzICCgrIlP5n46DHPv46PsKeyf5ln5lYH5
        X+dQYh1eItuLrvpLc/dYB2ilWg==
X-Google-Smtp-Source: ABdhPJxZcgoA5uKFmKKTZVIW/QgalvI0vViRhWbaPgPhsBdeo0EbXOdxljHdeWjtUnGgsfAjxAHN5w==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr699617wmc.184.1605036700071;
        Tue, 10 Nov 2020 11:31:40 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:39 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gareth Hughes <gareth@valinux.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 19/30] drm/radeon/radeon_drv: Move 'radeon_mmap()'s prototype to shared header
Date:   Tue, 10 Nov 2020 19:31:01 +0000
Message-Id: <20201110193112.988999-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
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

