Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF962F1F16
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403959AbhAKTV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403928AbhAKTVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AF7C061343
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:19 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i9so944741wrc.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9UrmoG5/yGRXhSIKvPcNh16SC/CzS4H2K0X6mSg1W1w=;
        b=Nal3r9JOaqMh0YA8G9TInOQggMygNJ3sCv+Mv5Btn0E+aMP/FMsVKU5X52FZK8X9zw
         xfg5FvqOqx3aFYwpU7Dq6Pyi6N6i21Otxa3Oankvg6nV/A1XfHC0z1/X3o/E2ld7J70c
         tHXr+o2nc9ff+Wrf87mK38Td4aNUpr8s0l0eUCN+i7T/PxDOLAeaqqjKsHNLzngGtT5L
         Xon0gNOaxfwL4XmZlJH0YMm91QdJ8qZNu6PRZQ1R8Z7hzZtrX+JqmRixPO1IWQ+hSwZz
         /vhQFa6AfcvpS6ojwugz7eg6M4hKaw+Qm9+Og9bKqJP60jYpvNlrxkl2Ee2/UlapI94J
         Q8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9UrmoG5/yGRXhSIKvPcNh16SC/CzS4H2K0X6mSg1W1w=;
        b=LOWGZ6nRooHkfIAQRKQIw1XyWohB9FxS5MJoKrTrSpoGyAX1ehbNANDrWTS9NfDZ8X
         eyLAaewu2QQjizkv0CREgcBQWTYE80LoB9YqcwNyjxjIHmlpXdEBAocBaijev7+OLwRT
         YZFxYkcsdNHCQO1NHI838BCgQR4KncsYVydmJls6dfaO6Gjpzw7f6t+bTwjuH4ejIgkg
         QDBNqnYwCXn9qF6gWLBOB0ipi7iI+eFKwec3wGjwFL9rfXCaIdAgHpyJtLE8e3FbiTKr
         7mzdS+O9VOgBUfuitY9Q06DZp54Ea0R+J69fdngKmrQ4PDsk3zHx3qpqzbHg+Yv2/ujo
         LFWw==
X-Gm-Message-State: AOAM530HLqz2Rg06LYok8W6whqyZiIld/GL206qahY2SWOynkImQqYLi
        /yLEhRf5UVQT+6MSjStCBrIIyw==
X-Google-Smtp-Source: ABdhPJze/zXJ6tWB8NZECjT9anqSE+wothNGeknI4s8oLr4bpr8L8IAOth8N55Byo5fIJzUqZzLuEA==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr545360wrc.411.1610392818550;
        Mon, 11 Jan 2021 11:20:18 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:17 -0800 (PST)
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
Subject: [PATCH 37/40] drm/amd/display/dc/dce60/dce60_resource: Make local functions static
Date:   Mon, 11 Jan 2021 19:19:23 +0000
Message-Id: <20210111191926.3688443-38-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:522:17: warning: no previous prototype for ‘dce60_aux_engine_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:560:20: warning: no previous prototype for ‘dce60_i2c_hw_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:576:20: warning: no previous prototype for ‘dce60_i2c_sw_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:710:22: warning: no previous prototype for ‘dce60_link_encoder_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:749:22: warning: no previous prototype for ‘dce60_clock_source_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:773:6: warning: no previous prototype for ‘dce60_clock_source_destroy’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:863:6: warning: no previous prototype for ‘dce60_validate_bandwidth’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:908:16: warning: no previous prototype for ‘dce60_validate_global’ [-Wmissing-prototypes]

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
 .../drm/amd/display/dc/dce60/dce60_resource.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index e9dd78c484d6e..64f4a0da146bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -519,7 +519,7 @@ static struct output_pixel_processor *dce60_opp_create(
 	return &opp->base;
 }
 
-struct dce_aux *dce60_aux_engine_create(
+static struct dce_aux *dce60_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -557,7 +557,7 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
 };
 
-struct dce_i2c_hw *dce60_i2c_hw_create(
+static struct dce_i2c_hw *dce60_i2c_hw_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -573,7 +573,7 @@ struct dce_i2c_hw *dce60_i2c_hw_create(
 	return dce_i2c_hw;
 }
 
-struct dce_i2c_sw *dce60_i2c_sw_create(
+static struct dce_i2c_sw *dce60_i2c_sw_create(
 	struct dc_context *ctx)
 {
 	struct dce_i2c_sw *dce_i2c_sw =
@@ -707,7 +707,7 @@ static const struct encoder_feature_support link_enc_feature = {
 		.flags.bits.IS_TPS3_CAPABLE = true
 };
 
-struct link_encoder *dce60_link_encoder_create(
+static struct link_encoder *dce60_link_encoder_create(
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dce110_link_encoder *enc110 =
@@ -746,7 +746,7 @@ static struct panel_cntl *dce60_panel_cntl_create(const struct panel_cntl_init_d
 	return &panel_cntl->base;
 }
 
-struct clock_source *dce60_clock_source_create(
+static struct clock_source *dce60_clock_source_create(
 	struct dc_context *ctx,
 	struct dc_bios *bios,
 	enum clock_source_id id,
@@ -770,7 +770,7 @@ struct clock_source *dce60_clock_source_create(
 	return NULL;
 }
 
-void dce60_clock_source_destroy(struct clock_source **clk_src)
+static void dce60_clock_source_destroy(struct clock_source **clk_src)
 {
 	kfree(TO_DCE110_CLK_SRC(*clk_src));
 	*clk_src = NULL;
@@ -860,7 +860,7 @@ static void dce60_resource_destruct(struct dce110_resource_pool *pool)
 	}
 }
 
-bool dce60_validate_bandwidth(
+static bool dce60_validate_bandwidth(
 	struct dc *dc,
 	struct dc_state *context,
 	bool fast_validate)
@@ -905,7 +905,7 @@ static bool dce60_validate_surface_sets(
 	return true;
 }
 
-enum dc_status dce60_validate_global(
+static enum dc_status dce60_validate_global(
 		struct dc *dc,
 		struct dc_state *context)
 {
-- 
2.25.1

