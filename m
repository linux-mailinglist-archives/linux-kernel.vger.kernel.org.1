Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED1C2F1F11
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403983AbhAKTVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403930AbhAKTV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:27 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FF4C061382
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:59 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w5so893427wrm.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbOdfw74w6tzF/CbpPUTEI04qCMhfubS6U9e1XZIp68=;
        b=SY9uAV9V59fYWcmoaIsdXl0k7TXOs4fLfBDFwyidnaBs3Z6B+orrrsAEx5TJwydBzJ
         K8nX3NxXBy5TrL6hieK2vO+NXgHYwhgnT+23Y0dN7lnBpdRCqhPOoRySIRjAXZ+rIblf
         Ih2hh/pbvvd8bVpxE+ZPG57im+0H1wWIzoXVmp0cf7XbY4i6DXuotgud1SXh0lVA2wjc
         8evdy55Ymtzme9Ud/0rATBl2ennpYYn6FzdMnZMcZpSqs7qXa1FcDXhidzIO33tvGmW4
         kOvFJ5cYIEZbrVt0CAMRlPatHx1if33AoandcvoJk5eWivKdkS+aswgmoTX0U9jYD+kL
         7XyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbOdfw74w6tzF/CbpPUTEI04qCMhfubS6U9e1XZIp68=;
        b=sOq33i9EHQD/LNDxejUsAWhAMMSPPiKgu4At6pYZ8+ZY5ACsa33FFZn5M9UVvx3/NH
         YAZl67qPKyebBVA+02uagw2RqZT+xS5HPluXr0lczwU+b8m4QJ1FYSjgKz2APpCJ2Eax
         8qvDPBdrQTz69vu8vxwhBC3sga4LIr6Q3hLKYKbj6a4RILwXOSm3tw31UEhtvCTDr0+2
         f1y31EDRzYEsDbIO3mejHg+q3YN9VwH2BSvQ4bwIfC5f58DvK9PAfirasHXAubNn4pII
         uwhxM+1mjo9TQ8l7fC88sWiBeKbs4WJJJ+y/xOSh5nbtEVOWy9BG46Ig+lhtL5Z54ebg
         yL7A==
X-Gm-Message-State: AOAM532SGtnAZsJuN+iIl1/+FKPHH4scOF3n6brUjU3a+tBeHBhA2jFt
        FADciqK+NuK5HCwLqhaJgx7vug==
X-Google-Smtp-Source: ABdhPJzDKek8DXrL8V6g03Aep/A7t7ShJc3+WpVXUzrHYSw7+XQi6FpUmv51oh/GzdsdJ0VJJQOnzA==
X-Received: by 2002:adf:c454:: with SMTP id a20mr595775wrg.314.1610392797924;
        Mon, 11 Jan 2021 11:19:57 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:57 -0800 (PST)
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
Subject: [PATCH 21/40] drm/amd/display/dc/dce110/dce110_compressor: Remove unused function 'dce110_get_required_compressed_surfacesize
Date:   Mon, 11 Jan 2021 19:19:07 +0000
Message-Id: <20210111191926.3688443-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_compressor.c:415:6: warning: no previous prototype for ‘dce110_get_required_compressed_surfacesize’ [-Wmissing-prototypes]

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
 .../amd/display/dc/dce110/dce110_compressor.c | 30 -------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
index 72b580a4eb856..18b0a69b0b1e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
@@ -412,36 +412,6 @@ void dce110_compressor_destroy(struct compressor **compressor)
 	*compressor = NULL;
 }
 
-bool dce110_get_required_compressed_surfacesize(struct fbc_input_info fbc_input_info,
-						struct fbc_requested_compressed_size size)
-{
-	bool result = false;
-
-	unsigned int max_x = FBC_MAX_X, max_y = FBC_MAX_Y;
-
-	get_max_support_fbc_buffersize(&max_x, &max_y);
-
-	if (fbc_input_info.dynamic_fbc_buffer_alloc == 0) {
-		/*
-		 * For DCE11 here use Max HW supported size:  HW Support up to 3840x2400 resolution
-		 * or 18000 chunks.
-		 */
-		size.preferred_size = size.min_size = align_to_chunks_number_per_line(max_x) * max_y * 4;  /* (For FBC when LPT not supported). */
-		size.preferred_size_alignment = size.min_size_alignment = 0x100;       /* For FBC when LPT not supported */
-		size.bits.preferred_must_be_framebuffer_pool = 1;
-		size.bits.min_must_be_framebuffer_pool = 1;
-
-		result = true;
-	}
-	/*
-	 * Maybe to add registry key support with optional size here to override above
-	 * for debugging purposes
-	 */
-
-	return result;
-}
-
-
 void get_max_support_fbc_buffersize(unsigned int *max_x, unsigned int *max_y)
 {
 	*max_x = FBC_MAX_X;
-- 
2.25.1

