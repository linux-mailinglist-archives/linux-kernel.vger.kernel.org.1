Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D3C2F1F19
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403945AbhAKTV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403930AbhAKTVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:24 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17880C061344
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:21 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 91so924523wrj.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A9NZM9JfmH/69BBG6xFGdeZ0kAvlEjIVBJUiVqT8fRA=;
        b=mv3K2/TJiylT6ujFE4500vFgjQr5CLx5qm684HMvkPqQ6kcKChxRdcX/N2vCGNHRKd
         aNxxn2ZC+VZoQkkHH/aNthsbVwqGvGIoV3YSua1ScuKp1iXJ7gOyFmOT4VCCx/RS/HGK
         O+Y5n+A9P91xFrKl/WGaMiIBusn7qONgANPVdQZsvJW/GKL7OTKsIx9k6eDmtJxAQtcY
         qFKykvCmHIF2ceG3s//XPyyJFbagLA2uqaQ7Gcpdfv9a17WZg7pOHC4K5napVvCt+gUR
         lOXz2V9K0irpznW/nCLGh61foRzcsP8cjqhzo15xEIVxCZpu8G7mG63gjg5KRChy+olB
         DMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9NZM9JfmH/69BBG6xFGdeZ0kAvlEjIVBJUiVqT8fRA=;
        b=jMSfgzVpuarVeLe0qBMCXl9ExvbvbJZ4VGpVqXAztt5oUDKm9Yz/gPAdavSkOzTRF1
         EfckWYFXbQutb+ykCf00O51qmfCC9MebPkTETd0jVoYtNEd3y64MRtgK2YDSWycgUp+w
         Vgjh0z4jC7+xKmGvwbPm2AZz9IHpFGGTL/Hry/iZqwEveHHN7MMMAclJV0aBpStw7l+z
         oG1eNH6p68kV8TjsXVSXneASOEq6GLVgHuv2pRj8CH/OXgy2C38dtzJBX6vonln+p7OC
         DkyTXSqZ0eeKA0TXs84C61RKprpZAfcEqJh5jT4dPkkC11sQ31aOGZ6VbNQPdMuKBIDV
         peXQ==
X-Gm-Message-State: AOAM530292V1LaLefEFhuRH5NqtjnGwEMld/aEtf/ngKHKadhFlG7ZCs
        fLWmDJRy3P1BPO6+wAMl2xk40A==
X-Google-Smtp-Source: ABdhPJzvquMex+2hdcKEqOIDvVHXvQEqK+fROfZpUiMMeubWUILkaVY2AfdiA+0jXEqBqV5vLr3RDw==
X-Received: by 2002:adf:f60b:: with SMTP id t11mr570904wrp.401.1610392819806;
        Mon, 11 Jan 2021 11:20:19 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:19 -0800 (PST)
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
Subject: [PATCH 38/40] drm/amd/display/dc/dce80/dce80_resource: Make local functions static
Date:   Mon, 11 Jan 2021 19:19:24 +0000
Message-Id: <20210111191926.3688443-39-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:527:17: warning: no previous prototype for ‘dce80_aux_engine_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:565:20: warning: no previous prototype for ‘dce80_i2c_hw_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:581:20: warning: no previous prototype for ‘dce80_i2c_sw_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:715:22: warning: no previous prototype for ‘dce80_link_encoder_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:754:22: warning: no previous prototype for ‘dce80_clock_source_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:778:6: warning: no previous prototype for ‘dce80_clock_source_destroy’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:868:6: warning: no previous prototype for ‘dce80_validate_bandwidth’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:913:16: warning: no previous prototype for ‘dce80_validate_global’ [-Wmissing-prototypes]

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
 .../drm/amd/display/dc/dce80/dce80_resource.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 26fe25caa2813..fe5d716084363 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -524,7 +524,7 @@ static struct output_pixel_processor *dce80_opp_create(
 	return &opp->base;
 }
 
-struct dce_aux *dce80_aux_engine_create(
+static struct dce_aux *dce80_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -562,7 +562,7 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
 };
 
-struct dce_i2c_hw *dce80_i2c_hw_create(
+static struct dce_i2c_hw *dce80_i2c_hw_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -578,7 +578,7 @@ struct dce_i2c_hw *dce80_i2c_hw_create(
 	return dce_i2c_hw;
 }
 
-struct dce_i2c_sw *dce80_i2c_sw_create(
+static struct dce_i2c_sw *dce80_i2c_sw_create(
 	struct dc_context *ctx)
 {
 	struct dce_i2c_sw *dce_i2c_sw =
@@ -712,7 +712,7 @@ static const struct encoder_feature_support link_enc_feature = {
 		.flags.bits.IS_TPS3_CAPABLE = true
 };
 
-struct link_encoder *dce80_link_encoder_create(
+static struct link_encoder *dce80_link_encoder_create(
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dce110_link_encoder *enc110 =
@@ -751,7 +751,7 @@ static struct panel_cntl *dce80_panel_cntl_create(const struct panel_cntl_init_d
 	return &panel_cntl->base;
 }
 
-struct clock_source *dce80_clock_source_create(
+static struct clock_source *dce80_clock_source_create(
 	struct dc_context *ctx,
 	struct dc_bios *bios,
 	enum clock_source_id id,
@@ -775,7 +775,7 @@ struct clock_source *dce80_clock_source_create(
 	return NULL;
 }
 
-void dce80_clock_source_destroy(struct clock_source **clk_src)
+static void dce80_clock_source_destroy(struct clock_source **clk_src)
 {
 	kfree(TO_DCE110_CLK_SRC(*clk_src));
 	*clk_src = NULL;
@@ -865,7 +865,7 @@ static void dce80_resource_destruct(struct dce110_resource_pool *pool)
 	}
 }
 
-bool dce80_validate_bandwidth(
+static bool dce80_validate_bandwidth(
 	struct dc *dc,
 	struct dc_state *context,
 	bool fast_validate)
@@ -910,7 +910,7 @@ static bool dce80_validate_surface_sets(
 	return true;
 }
 
-enum dc_status dce80_validate_global(
+static enum dc_status dce80_validate_global(
 		struct dc *dc,
 		struct dc_state *context)
 {
-- 
2.25.1

