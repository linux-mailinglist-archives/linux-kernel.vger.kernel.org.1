Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376BC2EF8D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbhAHURN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbhAHURG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:17:06 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DD3C0612B2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d26so10109865wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/no+Onyy5XrK9PB3hyGhFGC7i5BsGoibiINOqxq12AQ=;
        b=ojEBT5RsN2ItOnq+5hnf27mTpPMgt5HIEpJPbKe+3Zbl9lekg8pVMBTuRv540cHs4Q
         Tb786eVXAWGOwbyelL9uKyuNmGa2SyOXXZFPpId6DC9pDz0zEMopFAyEsoGH9Ko0N6/b
         Ub3sMjADxRs1gr0OfoAQdrQrlnoMCYbktSRB6O+/21I/8I2BC9Veblt10uMGncXyY+No
         Utiitfn6+E8oKxjbI2NCxpWw2s3r7b48u/BQRDA47oZtG8HDS+NQlWzlrgr1yJQi3VA2
         PmwuWx0kJpmQT4Rrwft9zA9na/2WeMHyt4gmXpnyipPfAYTPgrVoNsLJRxgqx71P8V8a
         8isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/no+Onyy5XrK9PB3hyGhFGC7i5BsGoibiINOqxq12AQ=;
        b=RdaGEbFzlkGPhztr5480ETGPDHye3VFfKUhQHvIy7Np6yrJ+8N37iu+ASzBmJyVu8+
         3n3DJ2Z+F7Y1sUbnsUQn2YJjMEyay0HRqDmRrjuTKTDBrhf0iQu3dLmAblPDwqtPsBed
         LGkZlsb/60UxffBbZiEhyaUtyvou5DUno4Iwafi+CmQONoLFeX4+r2lPaOblK2HAWU21
         FUszJgw/US/MXsbuAotjZeqCLTus8/a9FBF/2wRKMDjehk9jiz1c+Yz7dvWsmEnBMlsZ
         iaD/ymMEYGuaQrSV8+4ruR6wbHW0vIdGiMwr+oCndnP9P3Mx91xM9yMdFYbTOY1HqJ3v
         4U0w==
X-Gm-Message-State: AOAM531eXfqncZkMyB+/JswZnltfq4wSFcgPpn5mo1NPjyAbo22msibj
        Z+UU3s6ftTIMoHzb1yuVmZm0Ow==
X-Google-Smtp-Source: ABdhPJxBa92KrsZVIK1LY24dJwGdRNWWQc0vmXVcqMyHxxA2+D+ZCFZLY5GuplgbRG10CXzdo5bl5g==
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr5259451wrr.306.1610136935433;
        Fri, 08 Jan 2021 12:15:35 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:34 -0800 (PST)
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
Subject: [PATCH 21/40] drm/amd/display/dc/calcs/dce_calcs: Remove unused variables 'v_filter_init_mode' and 'sclk_lvl'
Date:   Fri,  8 Jan 2021 20:14:38 +0000
Message-Id: <20210108201457.3078600-22-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In function ‘calculate_bandwidth’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:109:18: warning: variable ‘v_filter_init_mode’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In function ‘bw_calcs’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3031:21: warning: variable ‘sclk_lvl’ set but not used [-Wunused-but-set-variable]

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
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index ef41b287cbe23..158d927c03e55 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -106,7 +106,6 @@ static void calculate_bandwidth(
 	bool lpt_enabled;
 	enum bw_defines sclk_message;
 	enum bw_defines yclk_message;
-	enum bw_defines v_filter_init_mode[maximum_number_of_surfaces];
 	enum bw_defines tiling_mode[maximum_number_of_surfaces];
 	enum bw_defines surface_type[maximum_number_of_surfaces];
 	enum bw_defines voltage;
@@ -792,12 +791,8 @@ static void calculate_bandwidth(
 				data->v_filter_init[i] = bw_add(data->v_filter_init[i], bw_int_to_fixed(1));
 			}
 			if (data->stereo_mode[i] == bw_def_top_bottom) {
-				v_filter_init_mode[i] = bw_def_manual;
 				data->v_filter_init[i] = bw_min2(data->v_filter_init[i], bw_int_to_fixed(4));
 			}
-			else {
-				v_filter_init_mode[i] = bw_def_auto;
-			}
 			if (data->stereo_mode[i] == bw_def_top_bottom) {
 				data->num_lines_at_frame_start = bw_int_to_fixed(1);
 			}
@@ -3028,7 +3023,7 @@ bool bw_calcs(struct dc_context *ctx,
 		calcs_output->all_displays_in_sync = false;
 
 	if (data->number_of_displays != 0) {
-		uint8_t yclk_lvl, sclk_lvl;
+		uint8_t yclk_lvl;
 		struct bw_fixed high_sclk = vbios->high_sclk;
 		struct bw_fixed mid1_sclk = vbios->mid1_sclk;
 		struct bw_fixed mid2_sclk = vbios->mid2_sclk;
@@ -3049,7 +3044,6 @@ bool bw_calcs(struct dc_context *ctx,
 		calculate_bandwidth(dceip, vbios, data);
 
 		yclk_lvl = data->y_clk_level;
-		sclk_lvl = data->sclk_level;
 
 		calcs_output->nbp_state_change_enable =
 			data->nbp_state_change_enable;
-- 
2.25.1

