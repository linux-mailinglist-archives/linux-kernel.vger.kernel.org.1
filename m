Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB2A2F1F09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390958AbhAKTVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403800AbhAKTUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C8AC0617B0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t30so972797wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7ShCn/bO13X1iuoCznCgnnKv69aJlFAftAklYMZYMw=;
        b=s3mbs6zayA59XZdRkszpAHmu79CB5wLLYfTBh37vUhFowMfFdZRbf9AR+s2BuYmg1K
         +2cbDIrynPUImeCd6FcIh3J/3wBFhjpwMr9jF20MhUkFaOAs4vjKEO8ko1MXOFQ2BlsT
         wDL5EwTNJMY3c49i2les63t3LnliOCepwfJkykn1imPJEMGjvgynLBBUx0bSoDrzjss3
         z/B+9wvVH2HRjggfU9ScwoMV5sBzmy/2QbOH2LU14TFs4NDXGdT8GMqscpvmhMciS0rr
         DVexi9ZapRebp+lMf8+r4/aQO63EssYqy6KSntSxyxsigj+hFiUCo1MeWgqt+Ir7G5Y1
         NDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7ShCn/bO13X1iuoCznCgnnKv69aJlFAftAklYMZYMw=;
        b=MGtJSLzLtdTJEgw3KEXq1Ci5A9mAcYEJYl7An537WHUeY8CEm8Hk4iJI2a1gtj48ue
         eD1xS7IFH/O2AO8j/djFRynbCjRpoxNdYmwy/ASVeg07/cIyu5mp42c4fvHA5Kcp1Cku
         vauuhvdD2Fb6+qVUWQGVpF9tz2/AVLDXdfepQN6ghE2BcOqGFtqiZVyZNmeq5ai6jmVm
         GP+63Ostr9JrzUk6gAlnHN4Gkcnv3EaNbpBBV2EAiKaO1k9nTEwAJaZQrD4Ihi/Shd4w
         alQgbc54yJYCBrNSirO8VZ40WtIMrValEAcK14eG2kigfmZ2jVSg+kXjqh24iMUwJt6I
         vaFg==
X-Gm-Message-State: AOAM533IgG2sNl7iZc8t/EHU6HCvI3n3rKv7zLr4R95/Lze8PowN9rSZ
        9huoHn47XDjayuJQfWsgWBU1HQ==
X-Google-Smtp-Source: ABdhPJw4LfDgAD1qhuYzVjQVN1mdnAmx88pKsdw88ycahuZPWr5+H/nnLqRTrg1hvJZKkfZ/Kej5MA==
X-Received: by 2002:adf:ec41:: with SMTP id w1mr635549wrn.12.1610392784589;
        Mon, 11 Jan 2021 11:19:44 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Aric Cyr <aric.cyr@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 11/40] drm/amd/display/dc/dce120/dce120_timing_generator:
Date:   Mon, 11 Jan 2021 19:18:57 +0000
Message-Id: <20210111191926.3688443-12-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:101:6: warning: no previous prototype for ‘dce120_timing_generator_validate_timing’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:128:6: warning: no previous prototype for ‘dce120_tg_validate_timing’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:136:6: warning: no previous prototype for ‘dce120_timing_generator_enable_crtc’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:156:6: warning: no previous prototype for ‘dce120_timing_generator_set_early_control’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:169:10: warning: no previous prototype for ‘dce120_timing_generator_get_vblank_counter’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:184:6: warning: no previous prototype for ‘dce120_timing_generator_get_crtc_position’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:210:6: warning: no previous prototype for ‘dce120_timing_generator_wait_for_vblank’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:232:6: warning: no previous prototype for ‘dce120_timing_generator_wait_for_vactive’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:245:6: warning: no previous prototype for ‘dce120_timing_generator_setup_global_swap_lock’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:282:6: warning: no previous prototype for ‘dce120_timing_generator_tear_down_global_swap_lock’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:303:6: warning: no previous prototype for ‘dce120_timing_generator_enable_reset_trigger’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:350:6: warning: no previous prototype for ‘dce120_timing_generator_disable_reset_trigger’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:370:6: warning: no previous prototype for ‘dce120_timing_generator_did_triggered_reset_occur’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:387:6: warning: no previous prototype for ‘dce120_timing_generator_disable_vga’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:428:6: warning: no previous prototype for ‘dce120_timing_generator_program_blanking’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:488:6: warning: no previous prototype for ‘dce120_timing_generator_program_blank_color’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:501:6: warning: no previous prototype for ‘dce120_timing_generator_set_overscan_color_black’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:543:6: warning: no previous prototype for ‘dce120_timing_generator_set_drr’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:602:6: warning: no previous prototype for ‘dce120_timing_generator_get_position’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:635:6: warning: no previous prototype for ‘dce120_timing_generator_get_crtc_scanoutpos’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:664:6: warning: no previous prototype for ‘dce120_timing_generator_enable_advanced_request’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:702:6: warning: no previous prototype for ‘dce120_tg_program_blank_color’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:725:6: warning: no previous prototype for ‘dce120_tg_set_overscan_color’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:752:6: warning: no previous prototype for ‘dce120_tg_is_blanked’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:773:6: warning: no previous prototype for ‘dce120_tg_set_blank’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:792:6: warning: no previous prototype for ‘dce120_tg_wait_for_state’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:809:6: warning: no previous prototype for ‘dce120_tg_set_colors’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.c:836:6: warning: no previous prototype for ‘dce120_timing_generator_set_test_pattern’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Aric Cyr <aric.cyr@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../dc/dce120/dce120_timing_generator.c       | 56 +++++++++----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
index 915fbb8e8168c..ebc7d61e8bf36 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
@@ -98,7 +98,7 @@ static bool dce120_timing_generator_is_in_vertical_blank(
 
 
 /* determine if given timing can be supported by TG */
-bool dce120_timing_generator_validate_timing(
+static bool dce120_timing_generator_validate_timing(
 	struct timing_generator *tg,
 	const struct dc_crtc_timing *timing,
 	enum signal_type signal)
@@ -125,7 +125,7 @@ bool dce120_timing_generator_validate_timing(
 	return true;
 }
 
-bool dce120_tg_validate_timing(struct timing_generator *tg,
+static bool dce120_tg_validate_timing(struct timing_generator *tg,
 	const struct dc_crtc_timing *timing)
 {
 	return dce120_timing_generator_validate_timing(tg, timing, SIGNAL_TYPE_NONE);
@@ -133,7 +133,7 @@ bool dce120_tg_validate_timing(struct timing_generator *tg,
 
 /******** HW programming ************/
 /* Disable/Enable Timing Generator */
-bool dce120_timing_generator_enable_crtc(struct timing_generator *tg)
+static bool dce120_timing_generator_enable_crtc(struct timing_generator *tg)
 {
 	enum bp_result result;
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
@@ -153,7 +153,7 @@ bool dce120_timing_generator_enable_crtc(struct timing_generator *tg)
 	return result == BP_RESULT_OK;
 }
 
-void dce120_timing_generator_set_early_control(
+static void dce120_timing_generator_set_early_control(
 		struct timing_generator *tg,
 		uint32_t early_cntl)
 {
@@ -166,7 +166,7 @@ void dce120_timing_generator_set_early_control(
 /**************** TG current status ******************/
 
 /* return the current frame counter. Used by Linux kernel DRM */
-uint32_t dce120_timing_generator_get_vblank_counter(
+static uint32_t dce120_timing_generator_get_vblank_counter(
 		struct timing_generator *tg)
 {
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
@@ -181,7 +181,7 @@ uint32_t dce120_timing_generator_get_vblank_counter(
 }
 
 /* Get current H and V position */
-void dce120_timing_generator_get_crtc_position(
+static void dce120_timing_generator_get_crtc_position(
 	struct timing_generator *tg,
 	struct crtc_position *position)
 {
@@ -207,7 +207,7 @@ void dce120_timing_generator_get_crtc_position(
 }
 
 /* wait until TG is in beginning of vertical blank region */
-void dce120_timing_generator_wait_for_vblank(struct timing_generator *tg)
+static void dce120_timing_generator_wait_for_vblank(struct timing_generator *tg)
 {
 	/* We want to catch beginning of VBlank here, so if the first try are
 	 * in VBlank, we might be very close to Active, in this case wait for
@@ -229,7 +229,7 @@ void dce120_timing_generator_wait_for_vblank(struct timing_generator *tg)
 }
 
 /* wait until TG is in beginning of active region */
-void dce120_timing_generator_wait_for_vactive(struct timing_generator *tg)
+static void dce120_timing_generator_wait_for_vactive(struct timing_generator *tg)
 {
 	while (dce120_timing_generator_is_in_vertical_blank(tg)) {
 		if (!tg->funcs->is_counter_moving(tg)) {
@@ -242,7 +242,7 @@ void dce120_timing_generator_wait_for_vactive(struct timing_generator *tg)
 /*********** Timing Generator Synchronization routines ****/
 
 /* Setups Global Swap Lock group, TimingServer or TimingClient*/
-void dce120_timing_generator_setup_global_swap_lock(
+static void dce120_timing_generator_setup_global_swap_lock(
 	struct timing_generator *tg,
 	const struct dcp_gsl_params *gsl_params)
 {
@@ -279,7 +279,7 @@ void dce120_timing_generator_setup_global_swap_lock(
 }
 
 /* Clear all the register writes done by setup_global_swap_lock */
-void dce120_timing_generator_tear_down_global_swap_lock(
+static void dce120_timing_generator_tear_down_global_swap_lock(
 	struct timing_generator *tg)
 {
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
@@ -300,7 +300,7 @@ void dce120_timing_generator_tear_down_global_swap_lock(
 }
 
 /* Reset slave controllers on master VSync */
-void dce120_timing_generator_enable_reset_trigger(
+static void dce120_timing_generator_enable_reset_trigger(
 	struct timing_generator *tg,
 	int source)
 {
@@ -347,7 +347,7 @@ void dce120_timing_generator_enable_reset_trigger(
 }
 
 /* disabling trigger-reset */
-void dce120_timing_generator_disable_reset_trigger(
+static void dce120_timing_generator_disable_reset_trigger(
 	struct timing_generator *tg)
 {
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
@@ -367,7 +367,7 @@ void dce120_timing_generator_disable_reset_trigger(
 }
 
 /* Checks whether CRTC triggered reset occurred */
-bool dce120_timing_generator_did_triggered_reset_occur(
+static bool dce120_timing_generator_did_triggered_reset_occur(
 	struct timing_generator *tg)
 {
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
@@ -384,7 +384,7 @@ bool dce120_timing_generator_did_triggered_reset_occur(
 
 /******** Stuff to move to other virtual HW objects *****************/
 /* Move to enable accelerated mode */
-void dce120_timing_generator_disable_vga(struct timing_generator *tg)
+static void dce120_timing_generator_disable_vga(struct timing_generator *tg)
 {
 	uint32_t offset = 0;
 	uint32_t value = 0;
@@ -425,7 +425,7 @@ void dce120_timing_generator_disable_vga(struct timing_generator *tg)
 }
 /* TODO: Should we move it to transform */
 /* Fully program CRTC timing in timing generator */
-void dce120_timing_generator_program_blanking(
+static void dce120_timing_generator_program_blanking(
 	struct timing_generator *tg,
 	const struct dc_crtc_timing *timing)
 {
@@ -485,7 +485,7 @@ void dce120_timing_generator_program_blanking(
 
 /* TODO: Should we move it to opp? */
 /* Combine with below and move YUV/RGB color conversion to SW layer */
-void dce120_timing_generator_program_blank_color(
+static void dce120_timing_generator_program_blank_color(
 	struct timing_generator *tg,
 	const struct tg_color *black_color)
 {
@@ -498,7 +498,7 @@ void dce120_timing_generator_program_blank_color(
 		CRTC_BLACK_COLOR_R_CR, black_color->color_r_cr);
 }
 /* Combine with above and move YUV/RGB color conversion to SW layer */
-void dce120_timing_generator_set_overscan_color_black(
+static void dce120_timing_generator_set_overscan_color_black(
 	struct timing_generator *tg,
 	const struct tg_color *color)
 {
@@ -540,7 +540,7 @@ void dce120_timing_generator_set_overscan_color_black(
 	 */
 }
 
-void dce120_timing_generator_set_drr(
+static void dce120_timing_generator_set_drr(
 	struct timing_generator *tg,
 	const struct drr_params *params)
 {
@@ -599,7 +599,7 @@ void dce120_timing_generator_set_drr(
  *  @param [out] position
  *****************************************************************************
  */
-void dce120_timing_generator_get_position(struct timing_generator *tg,
+static void dce120_timing_generator_get_position(struct timing_generator *tg,
 	struct crtc_position *position)
 {
 	uint32_t value;
@@ -632,7 +632,7 @@ void dce120_timing_generator_get_position(struct timing_generator *tg,
 }
 
 
-void dce120_timing_generator_get_crtc_scanoutpos(
+static void dce120_timing_generator_get_crtc_scanoutpos(
 	struct timing_generator *tg,
 	uint32_t *v_blank_start,
 	uint32_t *v_blank_end,
@@ -661,7 +661,7 @@ void dce120_timing_generator_get_crtc_scanoutpos(
 	*v_position = position.vertical_count;
 }
 
-void dce120_timing_generator_enable_advanced_request(
+static void dce120_timing_generator_enable_advanced_request(
 	struct timing_generator *tg,
 	bool enable,
 	const struct dc_crtc_timing *timing)
@@ -699,7 +699,7 @@ void dce120_timing_generator_enable_advanced_request(
 			value);
 }
 
-void dce120_tg_program_blank_color(struct timing_generator *tg,
+static void dce120_tg_program_blank_color(struct timing_generator *tg,
 	const struct tg_color *black_color)
 {
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
@@ -722,7 +722,7 @@ void dce120_tg_program_blank_color(struct timing_generator *tg,
 		value);
 }
 
-void dce120_tg_set_overscan_color(struct timing_generator *tg,
+static void dce120_tg_set_overscan_color(struct timing_generator *tg,
 	const struct tg_color *overscan_color)
 {
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
@@ -749,7 +749,7 @@ static void dce120_tg_program_timing(struct timing_generator *tg,
 		dce120_timing_generator_program_blanking(tg, timing);
 }
 
-bool dce120_tg_is_blanked(struct timing_generator *tg)
+static bool dce120_tg_is_blanked(struct timing_generator *tg)
 {
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
 	uint32_t value = dm_read_reg_soc15(
@@ -770,7 +770,7 @@ bool dce120_tg_is_blanked(struct timing_generator *tg)
 	return false;
 }
 
-void dce120_tg_set_blank(struct timing_generator *tg,
+static void dce120_tg_set_blank(struct timing_generator *tg,
 		bool enable_blanking)
 {
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
@@ -789,7 +789,7 @@ void dce120_tg_set_blank(struct timing_generator *tg,
 bool dce120_tg_validate_timing(struct timing_generator *tg,
 	const struct dc_crtc_timing *timing);
 
-void dce120_tg_wait_for_state(struct timing_generator *tg,
+static void dce120_tg_wait_for_state(struct timing_generator *tg,
 	enum crtc_state state)
 {
 	switch (state) {
@@ -806,7 +806,7 @@ void dce120_tg_wait_for_state(struct timing_generator *tg,
 	}
 }
 
-void dce120_tg_set_colors(struct timing_generator *tg,
+static void dce120_tg_set_colors(struct timing_generator *tg,
 	const struct tg_color *blank_color,
 	const struct tg_color *overscan_color)
 {
@@ -833,7 +833,7 @@ static void dce120_timing_generator_set_static_screen_control(
 			CRTC_STATIC_SCREEN_FRAME_COUNT, num_frames);
 }
 
-void dce120_timing_generator_set_test_pattern(
+static void dce120_timing_generator_set_test_pattern(
 	struct timing_generator *tg,
 	/* TODO: replace 'controller_dp_test_pattern' by 'test_pattern_mode'
 	 * because this is not DP-specific (which is probably somewhere in DP
-- 
2.25.1

