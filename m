Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7822F1F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403914AbhAKTVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403885AbhAKTVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:17 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9239DC0617A3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i63so237583wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=csVqrHBFmeDYM+DpUL/qWNe7WS5WghUC/wwda9CIB+s=;
        b=GQYwXGXy14cHXgEvLmIELxaY2UdL8rwyz1AKqSOzd5kf6rFrW4tF5xAq5laBnNMFFu
         dsRh0X330Sv7bLVdhNZV2k0iflojCipy/1hqta78KtHJ1YRNnMO2M5+mxcUqiR0+b/LR
         vzUcxDaDG91YwS8xQGd6e9Ekchq5d/arVgVgkhhiv4WV7wmvNgWia5U/KDxTfwA49UHh
         cGaUK65+qEdZyEe9DV3T9vLvLI48R2e6unLDc4BSiy3pJsJUQpe2kr8F/uSyrEnuLeUC
         iCQIIHwZ1sj0Cir5FXS+9Ky0OCIeyzAV9SSMjzGeVflgBNZ17dGmFonB0LW77MrRRfXs
         ALyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=csVqrHBFmeDYM+DpUL/qWNe7WS5WghUC/wwda9CIB+s=;
        b=i4kv5sI3PGUhzrRo+x3G8GqFY7LZplnu6uxZ5XyGETRAr+pzbYLTyqQfMdN0yp2yW0
         PqvIPPj6j66DiZ/KizfuyhAJOJevc+5uYUry+cDPd0hfU+I1Gb6FKVdnTJ8fEfjGA+dp
         MtJ1uJuog+Bfu5B/EI4kqHHrFGpqF8bNysSRxqFhQYkIENsu9YHkAz5cZ+TTCbpPXyd1
         D4aKYUxoZPyl5KFAvrvdjuEqSj7woGnkdQFCEpkidYb7H0uYPiDrPscixL3gYiZSn7YT
         pABDH/JGBj69lCnfgfs+tVYjkaxsX2uSAVp1AfO4QIQWcn00LlcMQLMeUbLNlxLZ9QEo
         XjsA==
X-Gm-Message-State: AOAM530B37Ry+a3UmNWydKnNIa+++/5Z0PDIwXlpqg0LNeayXKHvIkOw
        /j++l0PocM+g6iVibNA93ecB9w==
X-Google-Smtp-Source: ABdhPJzBFI4D3YDi86XjMvRg8B6yg4BdaS59jHcpr470WNXfSXBq8Lxb38TDe3G444SxY/L5EacEoA==
X-Received: by 2002:a7b:cc0a:: with SMTP id f10mr298684wmh.6.1610392817284;
        Mon, 11 Jan 2021 11:20:17 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:16 -0800 (PST)
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
Subject: [PATCH 36/40] drm/amd/display/dc/dce100/dce100_resource: Make local functions and ones called by reference static
Date:   Mon, 11 Jan 2021 19:19:22 +0000
Message-Id: <20210111191926.3688443-37-lee.jones@linaro.org>
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

 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:54:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:614:22: warning: no previous prototype for ‘dce100_link_encoder_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:653:32: warning: no previous prototype for ‘dce100_opp_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:668:17: warning: no previous prototype for ‘dce100_aux_engine_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:706:20: warning: no previous prototype for ‘dce100_i2c_hw_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:721:22: warning: no previous prototype for ‘dce100_clock_source_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:745:6: warning: no previous prototype for ‘dce100_clock_source_destroy’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:834:6: warning: no previous prototype for ‘dce100_validate_bandwidth’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:879:16: warning: no previous prototype for ‘dce100_validate_global’ [-Wmissing-prototypes]

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
 .../drm/amd/display/dc/dce100/dce100_resource.c  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index f20ed05a5050d..648169086bcf8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -611,7 +611,7 @@ static const struct encoder_feature_support link_enc_feature = {
 		.flags.bits.IS_TPS3_CAPABLE = true
 };
 
-struct link_encoder *dce100_link_encoder_create(
+static struct link_encoder *dce100_link_encoder_create(
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dce110_link_encoder *enc110 =
@@ -650,7 +650,7 @@ static struct panel_cntl *dce100_panel_cntl_create(const struct panel_cntl_init_
 	return &panel_cntl->base;
 }
 
-struct output_pixel_processor *dce100_opp_create(
+static struct output_pixel_processor *dce100_opp_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -665,7 +665,7 @@ struct output_pixel_processor *dce100_opp_create(
 	return &opp->base;
 }
 
-struct dce_aux *dce100_aux_engine_create(
+static struct dce_aux *dce100_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -703,7 +703,7 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
 };
 
-struct dce_i2c_hw *dce100_i2c_hw_create(
+static struct dce_i2c_hw *dce100_i2c_hw_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -718,7 +718,7 @@ struct dce_i2c_hw *dce100_i2c_hw_create(
 
 	return dce_i2c_hw;
 }
-struct clock_source *dce100_clock_source_create(
+static struct clock_source *dce100_clock_source_create(
 	struct dc_context *ctx,
 	struct dc_bios *bios,
 	enum clock_source_id id,
@@ -742,7 +742,7 @@ struct clock_source *dce100_clock_source_create(
 	return NULL;
 }
 
-void dce100_clock_source_destroy(struct clock_source **clk_src)
+static void dce100_clock_source_destroy(struct clock_source **clk_src)
 {
 	kfree(TO_DCE110_CLK_SRC(*clk_src));
 	*clk_src = NULL;
@@ -831,7 +831,7 @@ static enum dc_status build_mapped_resource(
 	return DC_OK;
 }
 
-bool dce100_validate_bandwidth(
+static bool dce100_validate_bandwidth(
 	struct dc  *dc,
 	struct dc_state *context,
 	bool fast_validate)
@@ -876,7 +876,7 @@ static bool dce100_validate_surface_sets(
 	return true;
 }
 
-enum dc_status dce100_validate_global(
+static enum dc_status dce100_validate_global(
 		struct dc  *dc,
 		struct dc_state *context)
 {
-- 
2.25.1

