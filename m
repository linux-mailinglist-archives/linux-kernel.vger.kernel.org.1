Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E722F1F28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404149AbhAKTXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391005AbhAKTVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D25DC06138A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:09 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c124so233686wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8eYMdRCMF+3FNGq6eZbp0x04185LsgzRCKOynhg9nzo=;
        b=C+nZExorvyjCiEDV7F+Ck6vDw8Cnx2nsYOugOkYMybb5uNKepwFSqnvU6qbAmnTJPv
         DvJ2FyeF/MEiL5r4Y3eR1ZXdMiH/jeQtGUYi/K3G0BoTe+L0wbl7K0ZATfuarAw8Zavw
         AYzcVIFeqIQ0w1bLMa9dKhp9/ZOkwRQzV/8q6/cKRFlZ3IS7U+JsKu/7OZ+zjsh4Xngd
         jh73bAowkgMX7o+MtPyjCdHxU9m2J1TCRID0AZT7Ork/eYb+snkm5p2rRRlC1sEGAnNV
         4ZzOmxVLnHn0gmpuMWePbl90sT+IT9cD/0aCry95sdCjrH0pRuW/hLwxkVTGmq7U6ui+
         ArUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8eYMdRCMF+3FNGq6eZbp0x04185LsgzRCKOynhg9nzo=;
        b=qiDcndyIaYbf091MIofQfpJziz4cBaaM03XR2EHTGGd5KtiPMRCQ4YThn6b7Teqs/U
         5ujTo0+OliHBXgiJml6CvFkFfhfb41FZb2JX9fMZ80glu2bmcXHNmDZoKACvtnNpzdKU
         gvmFwXGqakGR2+GaQYc0uFpO/FqUBz20aKxnkfHtfI3GRBbX7R3QKAfVVifu9WIBbEkm
         X0QY1k10hPvOea9ZUstijUTVAiGFW8nOryr7iUQc2rWYTwbYjuUzlzYpFp2N4UFZPONH
         tzcr1rJf4OBiQWqpDmrLrWm5Cz92FFbeZwiZMFpL35hk0Rn9Wus3EG4Ye09j7j0YjKUp
         x4Mw==
X-Gm-Message-State: AOAM533qLbs1dOlaF3x6LLHz+Z6oSTvHRcj25eYRx00JxdOV+tXhqw/W
        sNGNylxWlDEi+szS1eLFFs0p8Q==
X-Google-Smtp-Source: ABdhPJytnbA5pIK46E+RAdaHzHZVxw9MulZqU/WesXQS8ouAWQK7AaMf00TSBxyxMCWgALKcaZXXAg==
X-Received: by 2002:a1c:61c3:: with SMTP id v186mr284286wmb.146.1610392808141;
        Mon, 11 Jan 2021 11:20:08 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:07 -0800 (PST)
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
Subject: [PATCH 29/40] drm/amd/display/dc/dce112/dce112_resource: Make local functions and ones called by reference static
Date:   Mon, 11 Jan 2021 19:19:15 +0000
Message-Id: <20210111191926.3688443-30-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:620:22: warning: no previous prototype for ‘dce112_link_encoder_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:674:32: warning: no previous prototype for ‘dce112_opp_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:689:17: warning: no previous prototype for ‘dce112_aux_engine_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:727:20: warning: no previous prototype for ‘dce112_i2c_hw_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:742:22: warning: no previous prototype for ‘dce112_clock_source_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:766:6: warning: no previous prototype for ‘dce112_clock_source_destroy’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:1027:16: warning: no previous prototype for ‘dce112_validate_global’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:1205:29: warning: no previous prototype for ‘dce112_resource_cap’ [-Wmissing-prototypes]

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
 .../drm/amd/display/dc/dce112/dce112_resource.c  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index f99b1c0845908..c68e576a21990 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -617,7 +617,7 @@ static const struct encoder_feature_support link_enc_feature = {
 		.flags.bits.IS_TPS4_CAPABLE = true
 };
 
-struct link_encoder *dce112_link_encoder_create(
+static struct link_encoder *dce112_link_encoder_create(
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dce110_link_encoder *enc110 =
@@ -671,7 +671,7 @@ static struct input_pixel_processor *dce112_ipp_create(
 	return &ipp->base;
 }
 
-struct output_pixel_processor *dce112_opp_create(
+static struct output_pixel_processor *dce112_opp_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -686,7 +686,7 @@ struct output_pixel_processor *dce112_opp_create(
 	return &opp->base;
 }
 
-struct dce_aux *dce112_aux_engine_create(
+static struct dce_aux *dce112_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -724,7 +724,7 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCE110(_MASK)
 };
 
-struct dce_i2c_hw *dce112_i2c_hw_create(
+static struct dce_i2c_hw *dce112_i2c_hw_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -739,7 +739,7 @@ struct dce_i2c_hw *dce112_i2c_hw_create(
 
 	return dce_i2c_hw;
 }
-struct clock_source *dce112_clock_source_create(
+static struct clock_source *dce112_clock_source_create(
 	struct dc_context *ctx,
 	struct dc_bios *bios,
 	enum clock_source_id id,
@@ -763,7 +763,7 @@ struct clock_source *dce112_clock_source_create(
 	return NULL;
 }
 
-void dce112_clock_source_destroy(struct clock_source **clk_src)
+static void dce112_clock_source_destroy(struct clock_source **clk_src)
 {
 	kfree(TO_DCE110_CLK_SRC(*clk_src));
 	*clk_src = NULL;
@@ -1024,7 +1024,7 @@ enum dc_status dce112_add_stream_to_ctx(
 	return result;
 }
 
-enum dc_status dce112_validate_global(
+static enum dc_status dce112_validate_global(
 		struct dc *dc,
 		struct dc_state *context)
 {
@@ -1202,7 +1202,7 @@ static void bw_calcs_data_update_from_pplib(struct dc *dc)
 	dm_pp_notify_wm_clock_changes(dc->ctx, &clk_ranges);
 }
 
-const struct resource_caps *dce112_resource_cap(
+static const struct resource_caps *dce112_resource_cap(
 	struct hw_asic_id *asic_id)
 {
 	if (ASIC_REV_IS_POLARIS11_M(asic_id->hw_internal_rev) ||
-- 
2.25.1

