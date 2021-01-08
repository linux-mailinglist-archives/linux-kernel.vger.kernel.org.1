Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285B72EF8EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbhAHUTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbhAHUQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:45 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C53C061381
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:46 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c133so8745901wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ytR3fqWZwqVYBK3RsUcXcI3WQSuSAKiurJIlwb7LgU=;
        b=wbg5je7FZsTgpIt6O9urrAylcwuurXSWEq/h3em25fF38r83Wa9EOq3Db9eo7QsSk9
         xwCRNYNRj/HLDKQWdrdE8TtwKeaffhNaIpi6nqRIGPVhppSmMflAaIIQH3Fn0I+ceMkh
         4fYv2+yBgTyo1WcrjJkbhFjC/1l+GZEtkMHjeRldDTYSvdfqYUlJ+BZnw5geAXBmz9Kt
         Kw5FQ7yrlP4d6g5ycACgBF+bzlCUiu2T7klLeCQ/8q0Goa4cAXvZFBTeALZvDFP8+dTg
         K7nwLezl8va5JyslPwJjMB2o3u+zpgwll+AaOccnV+dIaNxAY/MUgouPKgWFlhRTYSbe
         GMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ytR3fqWZwqVYBK3RsUcXcI3WQSuSAKiurJIlwb7LgU=;
        b=KGOaRG+7Lgzc3CBTcakBEEU9HqWTxZ081tSWWwZ1hfmdrYTv7SLKNPkV7Yi5EO6tUS
         MQ1uMgJZLEsEl3P4XZjFhGrA8BaQdrTZdC9TZJUD+z/23l4bcodAQlzVGMoT5E+86lMI
         6JP+euntaiF+5v3tiDdfDGmMvOOM7XknNtoqgTAlvHiv4AU5OzXxJzIdiEmS+xIKQAJb
         pxzX4GL9f+aktulxxVJZBZzpt8wW9+K4Gr4N3L/Pd5dhbkUZ/CjuJz0va58yD6oAfGj1
         o8XUFyX5wc6A2+6m4gDgo/RVZkHqnouJB36oWgCrB24vFg+Q0EfyRAc5xSursCa9f+fa
         T63w==
X-Gm-Message-State: AOAM531gSI0VTCjlCP9waE+WkbCv4AhQtO5/9tSYrbyXMXVMSYL1T/EI
        WaXAt4Tm0daebavMH2FW+TS8oHVwLrnq6vFK
X-Google-Smtp-Source: ABdhPJy2bJ02k9gA9sVBBnJKvFxv30bdA0FleqFKFljSQtDb9QUpDx7W0UF3TNjxdaj3Ft2RG6/30Q==
X-Received: by 2002:a1c:234d:: with SMTP id j74mr4503783wmj.18.1610136945272;
        Fri, 08 Jan 2021 12:15:45 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Rossi <issor.oruam@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 28/40] drm/amd/display/dc/dce/dce_transform: Remove 3 unused/legacy variables
Date:   Fri,  8 Jan 2021 20:14:45 +0000
Message-Id: <20210108201457.3078600-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c: In function ‘dce60_transform_set_scaler’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c:496:7: warning: variable ‘filter_updated’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c: In function ‘dce60_transform_set_pixel_storage_depth’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c:1040:19: warning: variable ‘expan_mode’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c:1040:6: warning: variable ‘pixel_depth’ set but not used [-Wunused-but-set-variable]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 130a0a0c83329..6121bb7b009b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -493,7 +493,6 @@ static void dce60_transform_set_scaler(
 {
 	struct dce_transform *xfm_dce = TO_DCE_TRANSFORM(xfm);
 	bool is_scaling_required;
-	bool filter_updated = false;
 	const uint16_t *coeffs_v, *coeffs_h;
 
 	/*Use whole line buffer memory always*/
@@ -558,7 +557,6 @@ static void dce60_transform_set_scaler(
 
 			xfm_dce->filter_v = coeffs_v;
 			xfm_dce->filter_h = coeffs_h;
-			filter_updated = true;
 		}
 	}
 
@@ -1037,34 +1035,23 @@ static void dce60_transform_set_pixel_storage_depth(
 	const struct bit_depth_reduction_params *bit_depth_params)
 {
 	struct dce_transform *xfm_dce = TO_DCE_TRANSFORM(xfm);
-	int pixel_depth, expan_mode;
 	enum dc_color_depth color_depth;
 
 	switch (depth) {
 	case LB_PIXEL_DEPTH_18BPP:
 		color_depth = COLOR_DEPTH_666;
-		pixel_depth = 2;
-		expan_mode  = 1;
 		break;
 	case LB_PIXEL_DEPTH_24BPP:
 		color_depth = COLOR_DEPTH_888;
-		pixel_depth = 1;
-		expan_mode  = 1;
 		break;
 	case LB_PIXEL_DEPTH_30BPP:
 		color_depth = COLOR_DEPTH_101010;
-		pixel_depth = 0;
-		expan_mode  = 1;
 		break;
 	case LB_PIXEL_DEPTH_36BPP:
 		color_depth = COLOR_DEPTH_121212;
-		pixel_depth = 3;
-		expan_mode  = 0;
 		break;
 	default:
 		color_depth = COLOR_DEPTH_101010;
-		pixel_depth = 0;
-		expan_mode  = 1;
 		BREAK_TO_DEBUGGER();
 		break;
 	}
-- 
2.25.1

