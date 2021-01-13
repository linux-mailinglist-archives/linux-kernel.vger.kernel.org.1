Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D3B2F45EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbhAMIJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbhAMIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:22 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7564FC0617B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g10so714156wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ByKcZ/QO4rFJCc5FU+7eSJHbQTpm5hWIxSF+UVUytQ8=;
        b=NAq8a9+7iN3iO3+wGaICi9lECx6GuUsRdw34OqLPJd3ZnN4FlYdrKOqwub8Fk6eMfh
         5Bilb12AFMTIT63HXIBA5+LWSgS7rO3RyBoAY3n95Hlk3xVW0JgnsHHsVlj2mMd6PZFj
         LWY9sx4YPT9Qp+J9Yw6KW5C4y7Y/amKNrO0DbOBA8TI4JPuT8DOnjpeYTsqac0Kl1uln
         ATiwk9dlj8bfyv6wJayo/nqxgUtP6p5On60pWJQN4v5ZO/xC8g6ekPxEM5cSCyzE1IOe
         fUpAFplHTp2bmIC4n/oV9/ggXw96rpMlD57erX667d2A2c5jRo5GwBM1r1F9xccT2vUn
         BrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ByKcZ/QO4rFJCc5FU+7eSJHbQTpm5hWIxSF+UVUytQ8=;
        b=QIS3UvUCYu8VexNyAZb7eaF2ywHBmS5x2crT20o+N2o3gfT01DthJSQvDBB4ejK73g
         mG2dNorQ4mPvgWAb/OP/ewsjvFEOYpJAUxINiuPkvfAm4eWu+mUoinkImaJttzax2Ic9
         TqdHyHX40L5tM02Sm8+MQkJgx6az8rCgmeB5SW3kG1aLBrd9Irqz6jRO5Y3sxVYDCyXZ
         Bc61YV8JCAhsAhLJVptbLFdFyP2WECgqXNebrJPN0l1XPkpAfx8OgcP/J3xzFodGt76R
         AC/VS7LcpEtzUT8YVfdhnbtAPveW6kyV60dMJZf25RyvTfaykXP1rSdfobU2B8G8/rcp
         DHNQ==
X-Gm-Message-State: AOAM533NC2V1lEUVhOxA4Vjyrcvnucd4E0TkjKq40QUpIENBpZSWEFgr
        CrDucdsqTFNCiIhHYZQK1KsTmw==
X-Google-Smtp-Source: ABdhPJyixOcRMntyyEbwvGMK96ScnWqBXZFNvIivHM7pJ6Fo8CExy2eDANXqae2dONdp61qCKvDjmQ==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr909483wmj.159.1610525291245;
        Wed, 13 Jan 2021 00:08:11 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:10 -0800 (PST)
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
Subject: [PATCH 12/30] drm/amd/display/dc/dce100/dce100_resource: Include our own header containing prototypes
Date:   Wed, 13 Jan 2021 08:07:34 +0000
Message-Id: <20210113080752.1003793-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:54:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:537:3: note: in expansion of macro ‘MI_DCE8_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:537:3: note: in expansion of macro ‘MI_DCE8_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:542:3: note: in expansion of macro ‘MI_DCE8_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:542:3: note: in expansion of macro ‘MI_DCE8_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:547:2: note: in expansion of macro ‘DCE10_AUX_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:547:2: note: in expansion of macro ‘DCE10_AUX_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:551:2: note: in expansion of macro ‘DCE10_AUX_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:551:2: note: in expansion of macro ‘DCE10_AUX_MASK_SH_LIST’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:889:16: warning: no previous prototype for ‘dce100_add_stream_to_ctx’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:916:16: warning: no previous prototype for ‘dce100_validate_plane’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:925:24: warning: no previous prototype for ‘dce100_find_first_free_match_stream_enc_for_link’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:1156:23: warning: no previous prototype for ‘dce100_create_resource_pool’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index 648169086bcf8..635ef0e7c7826 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -58,6 +58,8 @@
 #include "dce/dce_abm.h"
 #include "dce/dce_i2c.h"
 
+#include "dce100_resource.h"
+
 #ifndef mmMC_HUB_RDREQ_DMIF_LIMIT
 #include "gmc/gmc_8_2_d.h"
 #include "gmc/gmc_8_2_sh_mask.h"
-- 
2.25.1

