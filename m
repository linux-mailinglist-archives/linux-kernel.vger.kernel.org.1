Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284F12F1F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390989AbhAKTVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390961AbhAKTVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:01 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35DCC061381
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:57 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g8so4848wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNrmFPwKfzO7gGVeJXgh6mlXY4soyZtk9MOKSdUAh0g=;
        b=A7rFEb0NpwwXT9gbSmNZG+K3fWQndZl2/WjJJtCYNRFqJ1Tv5oiN45STNYGV0hRA9g
         sOTSZOBjf5f0sFct4xkHdaJqBcb+L5ebEfU9S3X2cSADcM9dOx+q0ykLSzrDKZJz6PB3
         SXGFuaem8J5K8503YbkueSDTTd7ph6N07iJLZ4gvVUgqM3OPAb3n6xEu9KWELO9NeGdU
         H4QHzJeYh4w1cOJa3XG2ETOO4PD12f+zG0x101YqSHrpfBShxMwd93DVVB9jJIpACTVg
         MbZkNftYMcluX3P0MjIZoy6pKS9txIjbirf01A+kMk9jEVGao6Jp60mnhvm7S8BXPJWh
         GYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNrmFPwKfzO7gGVeJXgh6mlXY4soyZtk9MOKSdUAh0g=;
        b=eyrAd8sPm3Nq2Yr46adr9cJzF5oIGcW5lQ4xZHDr6l6Ai908gz5xfMMlrBz/CmzyOw
         cWV+8hEBsmMhuvVftF2O7xzv5mrNXxXdkNwqPxAkUXoFtQG3ZLYnkK2LRvMyl9/et2BL
         hsD2E+2AqArLz1BmX4DWfc3303mgqUgiMY2G3q60790PM1VjynTNKaGLG09B1LNjvJ7t
         bhJRWdHxGUq0jqkUbl1rVNUWQbBmhxTdxNq854E8vCwzm7q6fjvY1lb8xjWmGobonXgB
         rV6bZTP/50c/nMD3zQPpPqG0KDmtAcm+lCP5nP8X2UOTOXsioeXRn3aGEVWQ3X0N743C
         9h0A==
X-Gm-Message-State: AOAM530mBlr1DP4J6XilVdXSCoHSzBaiyNdSSRZTmRnPdGK+u1KJkYa9
        ESMFgf+A/nJ2kIpgG+/NZSbZ6Q==
X-Google-Smtp-Source: ABdhPJwRmVyOvGf3salMx7JCs/5UCKN5ZGZgaFgk22fzZglVbO7FJ8zMwOMQg13lKdj2nH4jX4wJvA==
X-Received: by 2002:a1c:6205:: with SMTP id w5mr306872wmb.26.1610392796639;
        Mon, 11 Jan 2021 11:19:56 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Aric Cyr <Aric.Cyr@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 20/40] drm/amd/display/dc/dce110/dce110_timing_generator: Remove unused variable 'value_crtc_vtotal'
Date:   Mon, 11 Jan 2021 19:19:06 +0000
Message-Id: <20210111191926.3688443-21-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c: In function ‘dce110_timing_generator_tear_down_global_swap_lock’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.c:1354:12: warning: variable ‘value_crtc_vtotal’ set but not used [-Wunused-but-set-variable]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Aric Cyr <Aric.Cyr@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Tony Cheng <Tony.Cheng@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c  | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index 1ea7db8eeb988..9a6c411bb7fe6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -1351,10 +1351,7 @@ void dce110_timing_generator_tear_down_global_swap_lock(
 
 	/* Restore DCP_GSL_PURPOSE_SURFACE_FLIP */
 	{
-		uint32_t value_crtc_vtotal;
-
-		value_crtc_vtotal = dm_read_reg(tg->ctx,
-				CRTC_REG(mmCRTC_V_TOTAL));
+		dm_read_reg(tg->ctx, CRTC_REG(mmCRTC_V_TOTAL));
 
 		set_reg_field_value(value,
 				0,
-- 
2.25.1

