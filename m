Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5286D2C564F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390948AbgKZNn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389954AbgKZNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:42 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B650FC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:40 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so2191609wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wTlQph4T9x2clQDWFRQKUxH5e24azy8BuVSYzp5lBkU=;
        b=Rz+Vn8n1GJmQ/rxsl/asCB4OMfEleQg7MQ7bd6+UCqkmm74BIESn/bQbICzXd8MhjA
         QuNQ4O4dVDJ6LSLLa5dkqVQvWlr9KRQbjeT2N3rOGGVAxe1qZjzmiu/Ix+dTg0/srPE0
         kzde8m10jLEIPnZeUuIQv4H+GX0bSwc3iQGh8KHXvAP6sOp+abDZeHDY+eOa7Fqy1vJd
         WvIxy4ElqE4NzC45RHvb+UftFhN8PtHHYGLc5UKM76FNhLdb7CRbZbUQuq4IoMxMmS5R
         Jda+Kc6IQMS3qx3X0gNu4CDnxZlLrVVplJsduhtZzyo6uI1PfQ6E23pRQdT9Rg4WMhO3
         5xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTlQph4T9x2clQDWFRQKUxH5e24azy8BuVSYzp5lBkU=;
        b=qomrai8Q+78s1YxgRkFtCLmfklqSoYxuw3A8ymEbrAt2GhaQIGJ62/uSg0jplTZRSX
         DyXr1AY38bgwnuomeYGx+lywSbwAzsLFjF69+AhWmNgH17Mg+OJZlropP3+jThchkJBF
         bF3Au8yLhwHOFFhjHocI8HlqC5eESaLcT3UZJezALB9IYL35cb0LEz8eHPYplKCZWL3n
         /UBm0QSgEOcLGjPDSVoV2RGXia3KWtrbkKQOqYRewJaOFI46bS3rFHUZHL/NWm+Ji4kU
         j5rux0885T1lyXeDeD99ADMkpfZ3jsAeaDvDqjwSMN4vq1T+tS56iZHnBTVxfRNCL7w+
         +tyw==
X-Gm-Message-State: AOAM531N3Z5Go9Tg4B0mlql0KxqneudOKHDzmWvcDn9jBpiN4KUucVz7
        0PATRB61b0sguoAyParAHEKQ8g==
X-Google-Smtp-Source: ABdhPJyjFZb/CZGkNbJquN6qeOeEmF3gQUTLtH3m5Nlq0vmYqCf2gV6hQrse5Mhswj35yLTHU2zP6w==
X-Received: by 2002:a5d:6186:: with SMTP id j6mr4005475wru.359.1606398219495;
        Thu, 26 Nov 2020 05:43:39 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:38 -0800 (PST)
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
Subject: [PATCH 37/40] drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu: Remove unused function 'pp_nv_set_pme_wa_enable()'
Date:   Thu, 26 Nov 2020 13:42:37 +0000
Message-Id: <20201126134240.3214176-38-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:664:20: warning: no previous prototype for ‘pp_nv_set_pme_wa_enable’ [-Wmissing-prototypes]

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
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index ac0a0539854ef..607ec09994456 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -661,22 +661,6 @@ static enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 	return PP_SMU_RESULT_OK;
 }
 
-static enum pp_smu_status pp_nv_set_pme_wa_enable(struct pp_smu *pp)
-{
-	const struct dc_context *ctx = pp->dm;
-	struct amdgpu_device *adev = ctx->driver_context;
-	struct smu_context *smu = &adev->smu;
-
-	if (!smu->ppt_funcs)
-		return PP_SMU_RESULT_UNSUPPORTED;
-
-	/* 0: successful or smu.ppt_funcs->set_azalia_d3_pme = NULL;  1: fail */
-	if (smu_set_azalia_d3_pme(smu))
-		return PP_SMU_RESULT_FAIL;
-
-	return PP_SMU_RESULT_OK;
-}
-
 static enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
 {
 	const struct dc_context *ctx = pp->dm;
-- 
2.25.1

