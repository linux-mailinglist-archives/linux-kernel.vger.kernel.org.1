Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BD92C564C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390916AbgKZNnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390646AbgKZNnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:39 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636D3C061A47
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:38 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id g14so2163191wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2L4ju+uZ20D0/2E1suojqs76azBxprDmuerWKuUkXg=;
        b=FzDylEEID+ChIWfzEFmWZz2uTH3H493rVHv8wAvc/cf9fkvCuUjCYRsUuc0NZXnjf1
         RKC6y9MRt2HtbaXRd/+MWYzK3N9y1OvjOlg09FC4aGlO7LmuK5ZixylQLIKi9ABmiFAo
         hxbj4w7/JM80JHphzbW5XttO40XyJrkWmTUouAZskGFh9ZE8MPiRS2TN49jrHkQZx6hZ
         Aj25a2l0d3gBcvRIXwPGQzYr1D559lBW3CGtJNZHzHYeW9lMFGYoPiaggT+FfcVDLXNu
         mZnqjJF1Rj3ZrfBjjJAt8qSov1+FvRd4MW2OiLuZ0SRwmY5hra7HcnjZIiR9Ez4Gc2pf
         QU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2L4ju+uZ20D0/2E1suojqs76azBxprDmuerWKuUkXg=;
        b=fxUTCsdb9hAjfoynIifj/2kIOBLlS1BYE0G0/ODec9MKhwptkSVR4uCHQVU2gp7BB/
         V0aGLFdjOArT4KRONI9vJuZpeMvr30U70oKP5g8jfTm2kzjZ3BMH4mUp1CXXJFMmjMoI
         uVjt38OwFyu10IKNYHR0JbqtJAtOeghtM7F5LGB44+Z2xuv7mb2gMz0bZ2cI0LCDIFjh
         be788WwiocrU132mKo2TUxWanfjB96T0NH+/zs1fMM0AhY1t4pr6M6nWu1n7QGcTGE92
         YPlC55CMf+QH7q8fJDGZaetv0V0+qv2BGigEC6UHqc9Yus8ZAnNHjvQ379c4LapdNQsD
         OqCg==
X-Gm-Message-State: AOAM531DWJPgp+YlcuniB7KPeaZTIxsCGdlBHrhm6dXSnS8QT6QnMQ0U
        1PJAP+UDvO52mB7RApbi2vtudQ==
X-Google-Smtp-Source: ABdhPJxfGQggZwM6noRk+tdnupoa9wCcjIPp3cRIt3Lxi9cHuFJWCdN0QQSBGG4Qw8BvZOr+tcmuvA==
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr4041256wrn.124.1606398217128;
        Thu, 26 Nov 2020 05:43:37 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 35/40] drm/amd/display/amdgpu_dm/amdgpu_dm_color: Demote a misuse and fix another kernel-doc header
Date:   Thu, 26 Nov 2020 13:42:35 +0000
Message-Id: <20201126134240.3214176-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_color.c:128: warning: Function parameter or member 'lut' not described in '__drm_lut_to_dc_gamma'
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_color.c:128: warning: Function parameter or member 'gamma' not described in '__drm_lut_to_dc_gamma'
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_color.c:128: warning: Function parameter or member 'is_legacy' not described in '__drm_lut_to_dc_gamma'
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_color.c:426: warning: Function parameter or member 'dc_plane_state' not described in 'amdgpu_dm_update_plane_color_mgmt'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 5df05f0d18bc9..157fe4efbb599 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -119,7 +119,7 @@ static bool __is_lut_linear(const struct drm_color_lut *lut, uint32_t size)
 	return true;
 }
 
-/**
+/*
  * Convert the drm_color_lut to dc_gamma. The conversion depends on the size
  * of the lut - whether or not it's legacy.
  */
@@ -413,7 +413,7 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 /**
  * amdgpu_dm_update_plane_color_mgmt: Maps DRM color management to DC plane.
  * @crtc: amdgpu_dm crtc state
- * @ dc_plane_state: target DC surface
+ * @dc_plane_state: target DC surface
  *
  * Update the underlying dc_stream_state's input transfer function (ITF) in
  * preparation for hardware commit. The transfer function used depends on
-- 
2.25.1

