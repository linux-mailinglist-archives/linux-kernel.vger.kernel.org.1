Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187AF2F1F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391016AbhAKTVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390963AbhAKTVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:08 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC450C061384
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:01 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c124so233430wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70pFYigB5I22JFOM7T44Jwvj3H7OC8wzlxfgrkMC4iE=;
        b=gdrU0FCupi0B2aOKsbEqUZ+MwdrwEROjCjpxoS16WgzjmgcrVB9/jgX5pULUWVCkO7
         cci15OsbH6bNk8r+YdI9U6wPI/Hs8X+pbcG+wcOaOlWiR1UfKUyrPOf4G9Q7qAmaqBZs
         pzV5Sh0k6nX8kCTabeanzrGU9dOngdCq4DKkuhSQG8ygtCwdT7/hDTSZ6D7gHA67LnD3
         UQeL0W4akz8Pq8Uh3Kktc9S2twrucHcD8a3P85qT1Nu8MJiyM1p/SxaA7XVCxgMIYwZV
         DrXTqLQIClGUbQYb426BPBfQxNIL+w5YlQI3oBCWI7eaov1jgDuE77Z7dX9mCFhctttS
         IWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70pFYigB5I22JFOM7T44Jwvj3H7OC8wzlxfgrkMC4iE=;
        b=YisdsnX2krl3dixHCkiJW0zOEY/JoAsdpN+5Nz/vJHSpSUlADEu6tmiLq7vRRZyj5h
         ep9ZKrdBhX7G3Qe34JJ9Ui2uofs3mY+uuUZvyDwr/lYcUyUCu+LQDIPHPr2uQV/bag4K
         IQoqmvOjXrZ7KJZ7HiyzDRp6CPTsAUh6NFbpP6QzhwYU7HFA2U8BSP13xCs1XcC5azaR
         B1HlJ86gDSxupVxCXZkV+SFRU/nsCtrtUIQcdZ8PQFu2W0rOcLdAI91kdgB4GAmJpqRz
         cERm2v5LeO5iD+SUhdrq5Gqqcgajk/4ZE0wrfzQ0MhqB9MWmRlxqkBv8HGUniCU8/ZfY
         yZIw==
X-Gm-Message-State: AOAM5326UKq/8NomEkQKq3hHKImC/8JUjvyNaSX5+/RrFbAdQVCXYgzF
        klJOZ1S1lk/0sfWvqa/gavfG8g==
X-Google-Smtp-Source: ABdhPJz6Xv8Y4U5t2RecR038AzZ1Sd2sP+SP699amwy3vVmFDD2b9XllgPaf4hgtkU4f2bwNfzMJoQ==
X-Received: by 2002:a05:600c:2303:: with SMTP id 3mr189208wmo.129.1610392800518;
        Mon, 11 Jan 2021 11:20:00 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:59 -0800 (PST)
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
Subject: [PATCH 23/40] drm/amd/display/dc/dce110/dce110_mem_input_v: Make local functions static
Date:   Mon, 11 Jan 2021 19:19:09 +0000
Message-Id: <20210111191926.3688443-24-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:471:6: warning: no previous prototype for ‘dce_mem_input_v_is_surface_pending’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:486:6: warning: no previous prototype for ‘dce_mem_input_v_program_surface_flip_and_addr’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:563:6: warning: no previous prototype for ‘dce_mem_input_v_program_pte_vm’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:636:6: warning: no previous prototype for ‘dce_mem_input_v_program_surface_config’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:922:6: warning: no previous prototype for ‘dce_mem_input_v_program_display_marks’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:945:6: warning: no previous prototype for ‘dce_mem_input_program_chroma_display_marks’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:966:6: warning: no previous prototype for ‘dce110_allocate_mem_input_v’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:1008:6: warning: no previous prototype for ‘dce110_free_mem_input_v’ [-Wmissing-prototypes]

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
 .../amd/display/dc/dce110/dce110_mem_input_v.c   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
index d54172d88f5f3..19b1976139b69 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
@@ -468,7 +468,7 @@ static void program_pixel_format(
 	}
 }
 
-bool dce_mem_input_v_is_surface_pending(struct mem_input *mem_input)
+static bool dce_mem_input_v_is_surface_pending(struct mem_input *mem_input)
 {
 	struct dce_mem_input *mem_input110 = TO_DCE_MEM_INPUT(mem_input);
 	uint32_t value;
@@ -483,7 +483,7 @@ bool dce_mem_input_v_is_surface_pending(struct mem_input *mem_input)
 	return false;
 }
 
-bool dce_mem_input_v_program_surface_flip_and_addr(
+static bool dce_mem_input_v_program_surface_flip_and_addr(
 	struct mem_input *mem_input,
 	const struct dc_plane_address *address,
 	bool flip_immediate)
@@ -560,7 +560,7 @@ static const unsigned int *get_dvmm_hw_setting(
 	}
 }
 
-void dce_mem_input_v_program_pte_vm(
+static void dce_mem_input_v_program_pte_vm(
 		struct mem_input *mem_input,
 		enum surface_pixel_format format,
 		union dc_tiling_info *tiling_info,
@@ -633,7 +633,7 @@ void dce_mem_input_v_program_pte_vm(
 	dm_write_reg(mem_input110->base.ctx, mmUNP_DVMM_PTE_ARB_CONTROL_C, value);
 }
 
-void dce_mem_input_v_program_surface_config(
+static void dce_mem_input_v_program_surface_config(
 	struct mem_input *mem_input,
 	enum surface_pixel_format format,
 	union dc_tiling_info *tiling_info,
@@ -919,7 +919,7 @@ static void program_nbp_watermark_c(
 			marks);
 }
 
-void dce_mem_input_v_program_display_marks(
+static void dce_mem_input_v_program_display_marks(
 	struct mem_input *mem_input,
 	struct dce_watermarks nbp,
 	struct dce_watermarks stutter,
@@ -942,7 +942,7 @@ void dce_mem_input_v_program_display_marks(
 
 }
 
-void dce_mem_input_program_chroma_display_marks(
+static void dce_mem_input_program_chroma_display_marks(
 	struct mem_input *mem_input,
 	struct dce_watermarks nbp,
 	struct dce_watermarks stutter,
@@ -963,7 +963,7 @@ void dce_mem_input_program_chroma_display_marks(
 		stutter);
 }
 
-void dce110_allocate_mem_input_v(
+static void dce110_allocate_mem_input_v(
 	struct mem_input *mi,
 	uint32_t h_total,/* for current stream */
 	uint32_t v_total,/* for current stream */
@@ -1005,7 +1005,7 @@ void dce110_allocate_mem_input_v(
 
 }
 
-void dce110_free_mem_input_v(
+static void dce110_free_mem_input_v(
 	struct mem_input *mi,
 	uint32_t total_stream_num)
 {
-- 
2.25.1

