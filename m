Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC9D2F1F12
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403999AbhAKTVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403986AbhAKTVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:33 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A3AC061387
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y23so302798wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tnSQBmFIPT1i2HDTqQCqcCn82Sl1/E0XXnz7N5xl764=;
        b=jw88wC+Sd6ih61ASSt/FfmCpSpBJiuCR0lsDVbBfBBhzd/LEXaP8ITQmg9WURDN+7u
         EVJd/lyZrp/CMBxS15aTU7QWliDZc8rrHeD7xx72Ij/65jxTCm2HmyFNGjS+7r+ytedF
         VUp5sNpOvupbpm1SEIjGLsMAIFTsUsg0ZB0F2IgPsHFafc3P5SRLMDrTPzuL3x9dtnPn
         qXYaubC4Ni2izQNIhOOcyM8L4lBaE8hyKfIexV60OKF6A4MEXNcuUbZKN8ZotZyddRiH
         58ePmAHyUDCa5aUP5Mx3M+O+VwhEv0sQ7H9sowqxHwwo8jIkcWb+O0o9xuXJdmLNGbh3
         WqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tnSQBmFIPT1i2HDTqQCqcCn82Sl1/E0XXnz7N5xl764=;
        b=V/yZXh+8kfcfS0Kl+Kdfg5wbYRpPjpmJz36AL+ouSYqDQhic6lOQFjZoWC+MwZ0DMK
         vwoKkelbyxU8La4C8G+rdyJIYy7D1G2wIqpRi/GhdyJetUDnWV+hDiUnMnT8a8Hbxa4R
         X+FFEX/eTUTK+HH0Dqu19xVl8FrrS9tFEYv2bhsXqdT+nwmArLbz0P769XgtA/JHXN+v
         5J77G+22yFF0s6zhQp/bGy1bVV4dfsG6qEH9+aPNIvSEPzurSP59F9k4xzkYAn79FiHy
         PjWAg3hMvg38HJ/RsC5xqhgJTYEQTWbOBx6vcEjxYGkFRTjWTNX9HBoflgdtLgZ+0XDS
         76sw==
X-Gm-Message-State: AOAM531/Vi0QcUcQM8Iimc/9gO8QK/V8xp7nIwHqnPS5bGLtBR/YHG25
        gSN90sGV0WCSu+QudCAXzIbFMw==
X-Google-Smtp-Source: ABdhPJxmIhKrCglXXHOwSNfFPETSwkWr1zPaXx82Vr2NyDcw2T0lp9lj1I8RQSuZv0MvB4YDvKQS9A==
X-Received: by 2002:a05:600c:230a:: with SMTP id 10mr273331wmo.172.1610392804235;
        Mon, 11 Jan 2021 11:20:04 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 26/40] drm/amd/display/dc/dce110/dce110_timing_generator: Demote kernel-doc abuses to standard function headers
Date:   Mon, 11 Jan 2021 19:19:12 +0000
Message-Id: <20210111191926.3688443-27-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:79: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:124: warning: Function parameter or member 'tg' not described in 'dce110_timing_generator_enable_crtc'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:179: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:233: warning: Function parameter or member 'tg' not described in 'dce110_timing_generator_disable_crtc'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:258: warning: Function parameter or member 'tg' not described in 'program_horz_count_by_2'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:258: warning: Function parameter or member 'timing' not described in 'program_horz_count_by_2'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:284: warning: Function parameter or member 'tg' not described in 'dce110_timing_generator_program_timing_generator'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:284: warning: Function parameter or member 'dc_crtc_timing' not described in 'dce110_timing_generator_program_timing_generator'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:356: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:525: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:561: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1118: warning: Function parameter or member 'tg' not described in 'dce110_timing_generator_validate_timing'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1118: warning: Function parameter or member 'timing' not described in 'dce110_timing_generator_validate_timing'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1118: warning: Function parameter or member 'signal' not described in 'dce110_timing_generator_validate_timing'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1174: warning: Function parameter or member 'tg' not described in 'dce110_timing_generator_wait_for_vblank'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1198: warning: Function parameter or member 'tg' not described in 'dce110_timing_generator_wait_for_vactive'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1208: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1386: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1768: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1801: warning: Function parameter or member 'tg' not described in 'dce110_timing_generator_disable_vga'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1851: warning: Function parameter or member 'tg' not described in 'dce110_timing_generator_set_overscan_color_black'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1851: warning: Function parameter or member 'color' not described in 'dce110_timing_generator_set_overscan_color_black'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1851: warning: Excess function parameter 'param' description in 'dce110_timing_generator_set_overscan_color_black'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../dc/dce110/dce110_timing_generator.c       | 71 +++++++++----------
 1 file changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index 9a6c411bb7fe6..d88a74559edd7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -75,7 +75,7 @@ static void dce110_timing_generator_apply_front_porch_workaround(
 	}
 }
 
-/**
+/*
  *****************************************************************************
  *  Function: is_in_vertical_blank
  *
@@ -116,7 +116,7 @@ void dce110_timing_generator_set_early_control(
 	dm_write_reg(tg->ctx, address, regval);
 }
 
-/**
+/*
  * Enable CRTC
  * Enable CRTC - call ASIC Control Object to enable Timing generator.
  */
@@ -175,7 +175,7 @@ void dce110_timing_generator_program_blank_color(
 	dm_write_reg(tg->ctx, addr, value);
 }
 
-/**
+/*
  *****************************************************************************
  *  Function: disable_stereo
  *
@@ -226,7 +226,7 @@ static void disable_stereo(struct timing_generator *tg)
 }
 #endif
 
-/**
+/*
  * disable_crtc - call ASIC Control Object to disable Timing generator.
  */
 bool dce110_timing_generator_disable_crtc(struct timing_generator *tg)
@@ -247,11 +247,10 @@ bool dce110_timing_generator_disable_crtc(struct timing_generator *tg)
 	return result == BP_RESULT_OK;
 }
 
-/**
-* program_horz_count_by_2
-* Programs DxCRTC_HORZ_COUNT_BY2_EN - 1 for DVI 30bpp mode, 0 otherwise
-*
-*/
+/*
+ * program_horz_count_by_2
+ * Programs DxCRTC_HORZ_COUNT_BY2_EN - 1 for DVI 30bpp mode, 0 otherwise
+ */
 static void program_horz_count_by_2(
 	struct timing_generator *tg,
 	const struct dc_crtc_timing *timing)
@@ -273,7 +272,7 @@ static void program_horz_count_by_2(
 			CRTC_REG(mmCRTC_COUNT_CONTROL), regval);
 }
 
-/**
+/*
  * program_timing_generator
  * Program CRTC Timing Registers - DxCRTC_H_*, DxCRTC_V_*, Pixel repetition.
  * Call ASIC Control Object to program Timings.
@@ -352,7 +351,7 @@ bool dce110_timing_generator_program_timing_generator(
 	return result == BP_RESULT_OK;
 }
 
-/**
+/*
  *****************************************************************************
  *  Function: set_drr
  *
@@ -521,7 +520,7 @@ uint32_t dce110_timing_generator_get_vblank_counter(struct timing_generator *tg)
 	return field;
 }
 
-/**
+/*
  *****************************************************************************
  *  Function: dce110_timing_generator_get_position
  *
@@ -557,7 +556,7 @@ void dce110_timing_generator_get_position(struct timing_generator *tg,
 			CRTC_VERT_COUNT_NOM);
 }
 
-/**
+/*
  *****************************************************************************
  *  Function: get_crtc_scanoutpos
  *
@@ -1106,11 +1105,11 @@ void dce110_timing_generator_set_test_pattern(
 	}
 }
 
-/**
-* dce110_timing_generator_validate_timing
-* The timing generators support a maximum display size of is 8192 x 8192 pixels,
-* including both active display and blanking periods. Check H Total and V Total.
-*/
+/*
+ * dce110_timing_generator_validate_timing
+ * The timing generators support a maximum display size of is 8192 x 8192 pixels,
+ * including both active display and blanking periods. Check H Total and V Total.
+ */
 bool dce110_timing_generator_validate_timing(
 	struct timing_generator *tg,
 	const struct dc_crtc_timing *timing,
@@ -1167,9 +1166,9 @@ bool dce110_timing_generator_validate_timing(
 	return true;
 }
 
-/**
-* Wait till we are at the beginning of VBlank.
-*/
+/*
+ * Wait till we are at the beginning of VBlank.
+ */
 void dce110_timing_generator_wait_for_vblank(struct timing_generator *tg)
 {
 	/* We want to catch beginning of VBlank here, so if the first try are
@@ -1191,9 +1190,9 @@ void dce110_timing_generator_wait_for_vblank(struct timing_generator *tg)
 	}
 }
 
-/**
-* Wait till we are in VActive (anywhere in VActive)
-*/
+/*
+ * Wait till we are in VActive (anywhere in VActive)
+ */
 void dce110_timing_generator_wait_for_vactive(struct timing_generator *tg)
 {
 	while (dce110_timing_generator_is_in_vertical_blank(tg)) {
@@ -1204,7 +1203,7 @@ void dce110_timing_generator_wait_for_vactive(struct timing_generator *tg)
 	}
 }
 
-/**
+/*
  *****************************************************************************
  *  Function: dce110_timing_generator_setup_global_swap_lock
  *
@@ -1215,7 +1214,6 @@ void dce110_timing_generator_wait_for_vactive(struct timing_generator *tg)
  *  @param [in] gsl_params: setup data
  *****************************************************************************
  */
-
 void dce110_timing_generator_setup_global_swap_lock(
 	struct timing_generator *tg,
 	const struct dcp_gsl_params *gsl_params)
@@ -1382,7 +1380,7 @@ void dce110_timing_generator_tear_down_global_swap_lock(
 
 	dm_write_reg(tg->ctx, address, value);
 }
-/**
+/*
  *****************************************************************************
  *  Function: is_counter_moving
  *
@@ -1764,7 +1762,7 @@ void dce110_timing_generator_disable_reset_trigger(
 	dm_write_reg(tg->ctx, CRTC_REG(mmCRTC_TRIGB_CNTL), value);
 }
 
-/**
+/*
  *****************************************************************************
  *  @brief
  *     Checks whether CRTC triggered reset occurred
@@ -1791,7 +1789,7 @@ bool dce110_timing_generator_did_triggered_reset_occur(
 	return (force || vert_sync);
 }
 
-/**
+/*
  * dce110_timing_generator_disable_vga
  * Turn OFF VGA Mode and Timing  - DxVGA_CONTROL
  * VGA Mode and VGA Timing is used by VBIOS on CRT Monitors;
@@ -1837,14 +1835,13 @@ void dce110_timing_generator_disable_vga(
 	dm_write_reg(tg->ctx, addr, value);
 }
 
-/**
-* set_overscan_color_black
-*
-* @param :black_color is one of the color space
-*    :this routine will set overscan black color according to the color space.
-* @return none
-*/
-
+/*
+ * set_overscan_color_black
+ *
+ * @param :black_color is one of the color space
+ *    :this routine will set overscan black color according to the color space.
+ * @return none
+ */
 void dce110_timing_generator_set_overscan_color_black(
 	struct timing_generator *tg,
 	const struct tg_color *color)
-- 
2.25.1

