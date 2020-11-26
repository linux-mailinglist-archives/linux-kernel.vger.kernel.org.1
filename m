Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7322C5651
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390966AbgKZNoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390685AbgKZNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:41 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89141C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:39 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so2461130wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OAy1jRBTuNLPEHs/IXnokv+zNFaXcfFnOzJRsPBonE0=;
        b=SPTU9J2onyq2/XfSieB6u7AH3glpdPGvhmzSX3HJXoTSMfOTHMvK+Hckq7OHwcT5c8
         nMz2ecjWqsf3eR95wiufhXwqvFtVokgNJnANAEtpnikhBUVWb4IApNYv5tRct69yKWht
         8vMDT005lM9fiCQVEfDQrkmGK6OTLch+KMRqiXcxJsY8df7z7nFWy/Qxxedis58l58XJ
         wyu90Jjl/9wajPkoyiq4SH6mMhOOJGNlQfgzcAWkC78bxsfK1Wq6YID35dlschDhkHIY
         PZkJx0cinT7BfcUdSJWOzilPUw10Vm+1qJ1wDXind70xKEGJ4n2vDKjvUABmT5VQ+ujl
         iq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OAy1jRBTuNLPEHs/IXnokv+zNFaXcfFnOzJRsPBonE0=;
        b=haEPcVLE6RUVBk1kjgpU8axOdHoPnKvDg6N3aqdBQ5qniVAc6vNPZIR0ZGKaqcjTuC
         PZfHPSFG7wf7YarBHMW3LUENjZ/+CQz6yQBaxGDZLDw4sf41cSHWSyF4cWnbBeDLwYBI
         6cIR/jou17IW7++mTQD1garHWp9/64kmkyUfTN8r7n2mpNS0BfhCDCz/Kcp7QPZ17tK6
         IYJYp2fbXd599xpgY9SE5rZfp8Q057LpvRyLrL0ZB2lKCQ5I+MKxougjcDA87y1bQoPI
         /qLyrUi+MisoLZLVzHW7TytliOoSvdkGVn/6UmYZiaC6jLsGyaYX9yIjntK+7U8ljSnF
         U0KA==
X-Gm-Message-State: AOAM531Zg5NUgyvD9DofjBIMCpb2md2P1FdqO9WqFOodYouDG5IeJJ18
        0ml9a+bqjVxCH8EzQamtdStZEw==
X-Google-Smtp-Source: ABdhPJyrIuGbGAFK6cCNbi887UT+vTL3eGrZMw/5tagoDRi/oTCsGa25Ce80vqYgDTfdzpRIdh4OxA==
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr3487702wma.92.1606398218319;
        Thu, 26 Nov 2020 05:43:38 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:37 -0800 (PST)
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
Subject: [PATCH 36/40] drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu: Mark local functions invoked by reference as static
Date:   Thu, 26 Nov 2020 13:42:36 +0000
Message-Id: <20201126134240.3214176-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:538:6: warning: no previous prototype for ‘pp_rv_set_wm_ranges’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:590:6: warning: no previous prototype for ‘pp_rv_set_pme_wa_enable’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:601:6: warning: no previous prototype for ‘pp_rv_set_active_display_count’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:614:6: warning: no previous prototype for ‘pp_rv_set_min_deep_sleep_dcfclk’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:627:6: warning: no previous prototype for ‘pp_rv_set_hard_min_dcefclk_by_freq’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:640:6: warning: no previous prototype for ‘pp_rv_set_hard_min_fclk_by_freq’ [-Wmissing-prototypes]

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
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 84065c12d4b85..ac0a0539854ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -535,7 +535,7 @@ bool dm_pp_get_static_clocks(
 	return true;
 }
 
-void pp_rv_set_wm_ranges(struct pp_smu *pp,
+static void pp_rv_set_wm_ranges(struct pp_smu *pp,
 		struct pp_smu_wm_range_sets *ranges)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -587,7 +587,7 @@ void pp_rv_set_wm_ranges(struct pp_smu *pp,
 							   &wm_with_clock_ranges);
 }
 
-void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
+static void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -598,7 +598,7 @@ void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
 		pp_funcs->notify_smu_enable_pwe(pp_handle);
 }
 
-void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
+static void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -611,7 +611,7 @@ void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
 	pp_funcs->set_active_display_count(pp_handle, count);
 }
 
-void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
+static void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -624,7 +624,7 @@ void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
 	pp_funcs->set_min_deep_sleep_dcefclk(pp_handle, clock);
 }
 
-void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
+static void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -637,7 +637,7 @@ void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
 	pp_funcs->set_hard_min_dcefclk_by_freq(pp_handle, clock);
 }
 
-void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
+static void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -661,7 +661,7 @@ static enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 	return PP_SMU_RESULT_OK;
 }
 
-enum pp_smu_status pp_nv_set_pme_wa_enable(struct pp_smu *pp)
+static enum pp_smu_status pp_nv_set_pme_wa_enable(struct pp_smu *pp)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
-- 
2.25.1

