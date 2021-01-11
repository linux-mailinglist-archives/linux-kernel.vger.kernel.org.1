Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5D2F1F23
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404075AbhAKTWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403862AbhAKTVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6981AC061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n16so482112wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8i/V9BZU2vNo9/KhBLch8zm2g2BxZT6emjpLJJRwwkU=;
        b=uMxtPomGXSj920dZZy8S8nKUyBuqBt45WI9r3F8cX6RVYDJt72y8Te15dU5FBzrNBL
         O6oP+bb2NRCviyn0nYmYPOZ9Q1j6nQ9a/lig3tAAcC5Gl1wu7N7hq4CxVfG7u1WHxvoy
         O0bp+U/5VKOlDA3o8RuNVCShFZhTKo4P+JyWdZPmg0CDKcaEABdVhp8kzgs7qU0+eWyO
         JCzYsian9gPyuZqd2GNmuEDY8bTHGd0QCcUPofA+EEZrwtUZwmzBrUvNeFdV6/MEpe8d
         797T459NUsuPL9ZWPJdDcbHJoNVws82yay05kKHkDYM5UpMMBXCxadwo4mVG5A3/diN3
         Wc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8i/V9BZU2vNo9/KhBLch8zm2g2BxZT6emjpLJJRwwkU=;
        b=ri+EXQDHa8hjAOXnUZ6ec/7IKndRYMd6rlkvDQX38CdtzkkWuoU8KiIOOAPrqFvA3o
         iuuEc7B2jzjcyBOpSYYoILx2N67krIf826wajWWzxH09i3uefiX7a8GULgnzquDByImc
         YWmsY6Fsw0gEKW8BgoXZ1DOiaTMsdKnW0jyv3pbT4B8nByKMC9dYc2LA6wHBey1KOysb
         zzFq8a3XXrg17ju5rsnZUjlhk2vTEnk84ItydSqpvnRcFjZnnyUNPHZ3yZaTRSuTmdJf
         TGtC1dpPJ6beMTuw/0SHF31pRhCrJkcZDIjKzmNRHvWTbFNsj3ZmmPz/FgZ54y8GP9wh
         lk/g==
X-Gm-Message-State: AOAM533XUXos2DQwf96KY2S8mggAfFooAHDLD75BpjsGIqWbeJOyyQBn
        zPZp5N3w7thwLnznQ8iJRz31lw==
X-Google-Smtp-Source: ABdhPJwCqYXYIrHbGGtSRZCm8m9ogfmKjT33XU5JVCMA0tOwSn+dkd2c+qtXeGKztCvYJNWaecekXA==
X-Received: by 2002:a1c:6205:: with SMTP id w5mr307762wmb.26.1610392813183;
        Mon, 11 Jan 2021 11:20:13 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:12 -0800 (PST)
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
Subject: [PATCH 33/40] drm/amd/display/dc/dce110/dce110_resource: Make local functions invoked by reference static
Date:   Mon, 11 Jan 2021 19:19:19 +0000
Message-Id: <20210111191926.3688443-34-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:262:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:266:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:262:15: note: (near initialization for ‘stream_enc_regs[0].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:266:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:262:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:267:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:262:15: note: (near initialization for ‘stream_enc_regs[1].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:267:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:262:15: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:268:2: note: in expansion of macro ‘stream_enc_regs’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:262:15: note: (near initialization for ‘stream_enc_regs[2].TMDS_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:268:2: note: in expansion of macro ‘stream_enc_regs’
 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:66:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3: note: in expansion of macro ‘SE_COMMON_MASK_SH_LIST_DCE110’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3: note: in expansion of macro ‘SE_COMMON_MASK_SH_LIST_DCE110’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3: note: in expansion of macro ‘SE_COMMON_MASK_SH_LIST_DCE110’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3: note: in expansion of macro ‘SE_COMMON_MASK_SH_LIST_DCE110’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:276:3: note: in expansion of macro ‘SE_COMMON_MASK_SH_LIST_DCE110’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:276:3: note: in expansion of macro ‘SE_COMMON_MASK_SH_LIST_DCE110’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:276:3: note: in expansion of macro ‘SE_COMMON_MASK_SH_LIST_DCE110’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:276:3: note: in expansion of macro ‘SE_COMMON_MASK_SH_LIST_DCE110’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:553:3: note: in expansion of macro ‘HWSEQ_DCE11_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:553:3: note: in expansion of macro ‘HWSEQ_DCE11_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:553:3: note: in expansion of macro ‘HWSEQ_DCE11_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:553:3: note: in expansion of macro ‘HWSEQ_DCE11_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:557:3: note: in expansion of macro ‘HWSEQ_DCE11_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:557:3: note: in expansion of macro ‘HWSEQ_DCE11_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:557:3: note: in expansion of macro ‘HWSEQ_DCE11_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:557:3: note: in expansion of macro ‘HWSEQ_DCE11_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:594:3: note: in expansion of macro ‘MI_DCE11_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:594:3: note: in expansion of macro ‘MI_DCE11_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:599:3: note: in expansion of macro ‘MI_DCE11_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:599:3: note: in expansion of macro ‘MI_DCE11_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:718:17: warning: no previous prototype for ‘dce110_aux_engine_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:756:20: warning: no previous prototype for ‘dce110_i2c_hw_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:771:22: warning: no previous prototype for ‘dce110_clock_source_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:795:6: warning: no previous prototype for ‘dce110_clock_source_destroy’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:1037:16: warning: no previous prototype for ‘dce110_validate_plane’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:1092:16: warning: no previous prototype for ‘dce110_validate_global’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:1336:29: warning: no previous prototype for ‘dce110_resource_cap’ [-Wmissing-prototypes]

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
 .../drm/amd/display/dc/dce110/dce110_resource.c  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index af208f9bd03be..73a924ed2b71e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -715,7 +715,7 @@ static struct output_pixel_processor *dce110_opp_create(
 	return &opp->base;
 }
 
-struct dce_aux *dce110_aux_engine_create(
+static struct dce_aux *dce110_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -753,7 +753,7 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCE110(_MASK)
 };
 
-struct dce_i2c_hw *dce110_i2c_hw_create(
+static struct dce_i2c_hw *dce110_i2c_hw_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -768,7 +768,7 @@ struct dce_i2c_hw *dce110_i2c_hw_create(
 
 	return dce_i2c_hw;
 }
-struct clock_source *dce110_clock_source_create(
+static struct clock_source *dce110_clock_source_create(
 	struct dc_context *ctx,
 	struct dc_bios *bios,
 	enum clock_source_id id,
@@ -792,7 +792,7 @@ struct clock_source *dce110_clock_source_create(
 	return NULL;
 }
 
-void dce110_clock_source_destroy(struct clock_source **clk_src)
+static void dce110_clock_source_destroy(struct clock_source **clk_src)
 {
 	struct dce110_clk_src *dce110_clk_src;
 
@@ -1034,8 +1034,8 @@ static bool dce110_validate_bandwidth(
 	return result;
 }
 
-enum dc_status dce110_validate_plane(const struct dc_plane_state *plane_state,
-				     struct dc_caps *caps)
+static enum dc_status dce110_validate_plane(const struct dc_plane_state *plane_state,
+					    struct dc_caps *caps)
 {
 	if (((plane_state->dst_rect.width * 2) < plane_state->src_rect.width) ||
 	    ((plane_state->dst_rect.height * 2) < plane_state->src_rect.height))
@@ -1089,7 +1089,7 @@ static bool dce110_validate_surface_sets(
 	return true;
 }
 
-enum dc_status dce110_validate_global(
+static enum dc_status dce110_validate_global(
 		struct dc *dc,
 		struct dc_state *context)
 {
@@ -1333,7 +1333,7 @@ static void bw_calcs_data_update_from_pplib(struct dc *dc)
 		1000);
 }
 
-const struct resource_caps *dce110_resource_cap(
+static const struct resource_caps *dce110_resource_cap(
 	struct hw_asic_id *asic_id)
 {
 	if (ASIC_REV_IS_STONEY(asic_id->hw_internal_rev))
-- 
2.25.1

