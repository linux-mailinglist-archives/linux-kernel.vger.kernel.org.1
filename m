Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98A72AC6FF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbgKIVTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731621AbgKIVTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:46 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AABC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:45 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so923600wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKEWaGJB8BfGR6ufuyFa6sc9ZYlzJUyj0WhtwnEg+YM=;
        b=yLNFiHYOOshoi44YOcHvCJLLEepPoEefGQL1ft/wS6fsl9FUBhQHLyJ4M4k86v5zCs
         5J5RdBCbgV+7LI5avSvNm9OU0JAbs9DADt00zEd2Ba9Mz4hOjuJn9JFWKURi/7bvIdt1
         xb7UopKkEa8/tRNspkGKQ2Is28Vu5W9N0IieG7NbyaI9fH8PExpFz/fdSK6TKix+0Iwb
         ygndmQg6/vzQvngoclWGooLS0vCOPnLUQucMoGcBAlNeUndHdyfFCWizDCiYwZPTvMDI
         ljKm8/NevMLVASgfqYYYm+5j3vYRMHMEMecOkwxAWvBCEZ2lR1U8SOBYI06Q/nz3j6NV
         BOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKEWaGJB8BfGR6ufuyFa6sc9ZYlzJUyj0WhtwnEg+YM=;
        b=mbfNostWB0cb5UBcjgQemC2aPvCyHDA9QEMplvet2i8xne4dCxBGZzqvdS7k0nFiVL
         oPPiJB4olTlxGX+nCuKzBnFrtOa7PCALwHUib9xSN9eVjgf0Q0ZWuZ/tir8fbDBre/US
         Bgk2lkY/QKQ5wyIZO6rewLUHDCFb3rf5UVg8JooPn/Liktai2C+QFXSfeof4HBc2rY1U
         fFu739bKaq2M/x2VWkDhgGFcEQR7H9KNrJ+6sBaMTjMrfNmrVTGb5DBelHk0/iyOaoiv
         s85qUHvb9d3eCW9+WrA32cqMe1ENPBLo/yUKD58iJf7YGHknm1U4IQkf2xAotZLwfvSf
         v+KQ==
X-Gm-Message-State: AOAM533mPHXir69zEpYYV752T0YIqwSZhPQdO4Etninw8CMc8UNrRJnD
        K2T20euMizjs4Hx+nLp7Hhjk9w==
X-Google-Smtp-Source: ABdhPJx/sTwJZZUmZSp3w+fqzVck3NElKnITF1z4pScY50oBvZIPhiTvpoumw7kgMJvCdjWybNkkCg==
X-Received: by 2002:a1c:2ece:: with SMTP id u197mr1180731wmu.58.1604956784455;
        Mon, 09 Nov 2020 13:19:44 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        report to <xorg-driver-ati@lists.x.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 18/20] drm/radeon/radeon_display: Fix function doc formatting and missing param issues
Date:   Mon,  9 Nov 2020 21:18:53 +0000
Message-Id: <20201109211855.3340030-19-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/radeon_display.c:264: warning: Function parameter or member '__work' not described in 'radeon_unpin_work_func'
 drivers/gpu/drm/radeon/radeon_display.c:406: warning: Function parameter or member '__work' not described in 'radeon_flip_work_func'
 drivers/gpu/drm/radeon/radeon_display.c:956: warning: Function parameter or member 'freq' not described in 'radeon_compute_pll_avivo'
 drivers/gpu/drm/radeon/radeon_display.c:956: warning: Function parameter or member 'fb_div_p' not described in 'radeon_compute_pll_avivo'
 drivers/gpu/drm/radeon/radeon_display.c:956: warning: Function parameter or member 'frac_fb_div_p' not described in 'radeon_compute_pll_avivo'
 drivers/gpu/drm/radeon/radeon_display.c:956: warning: Function parameter or member 'ref_div_p' not described in 'radeon_compute_pll_avivo'
 drivers/gpu/drm/radeon/radeon_display.c:956: warning: Function parameter or member 'post_div_p' not described in 'radeon_compute_pll_avivo'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: report to <xorg-driver-ati@lists.x.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_display.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 78fceedfd9255..eb0d4cb95f0a6 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -256,7 +256,7 @@ static void radeon_crtc_destroy(struct drm_crtc *crtc)
 /**
  * radeon_unpin_work_func - unpin old buffer object
  *
- * @__work - kernel work item
+ * @__work: kernel work item
  *
  * Unpin the old frame buffer object outside of the interrupt handler
  */
@@ -398,7 +398,7 @@ void radeon_crtc_handle_flip(struct radeon_device *rdev, int crtc_id)
 /**
  * radeon_flip_work_func - page flip framebuffer
  *
- * @work - kernel work item
+ * @__work: kernel work item
  *
  * Wait for the buffer object to become idle and do the actual page flip
  */
@@ -937,11 +937,12 @@ static void avivo_get_fb_ref_div(unsigned nom, unsigned den, unsigned post_div,
  * radeon_compute_pll_avivo - compute PLL paramaters
  *
  * @pll: information about the PLL
+ * @freq: target frequency
  * @dot_clock_p: resulting pixel clock
- * fb_div_p: resulting feedback divider
- * frac_fb_div_p: fractional part of the feedback divider
- * ref_div_p: resulting reference divider
- * post_div_p: resulting reference divider
+ * @fb_div_p: resulting feedback divider
+ * @frac_fb_div_p: fractional part of the feedback divider
+ * @ref_div_p: resulting reference divider
+ * @post_div_p: resulting reference divider
  *
  * Try to calculate the PLL parameters to generate the given frequency:
  * dot_clock = (ref_freq * feedback_div) / (ref_div * post_div)
-- 
2.25.1

