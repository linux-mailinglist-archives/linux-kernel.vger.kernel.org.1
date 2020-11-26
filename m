Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCE72C564D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390924AbgKZNnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390631AbgKZNno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:43:44 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712EBC061A48
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:44 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id g14so2163535wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SMoItuxgDP7ogQHGcYXarl4I2+ROLy8sCFsG16Aywwg=;
        b=OhdPMGyIXHI+TAj6MaIkGlRL9xzZ4qWRyHui4ZR+pMaQ/MzD27wZVVBTfPeDNog00z
         NN3tcAMPCRSSI/h4caCGAL300/4COFpkwzh6agGGfqN6hncmMlw7j3PtU1UxqxkVKqBE
         Kx3u4BG3SofRKVYlqmEaqTRm47XrknFaSfZkn154BEgBa3g0vXg3i9GxIwnJtSkCCz/0
         pGce+BNmaLjB3fcPjyUNY78xB8MCxdDrxEoi5L65AvoElMM8WTdbh9XaC/bhHhuDsllP
         K3czuao4DwqdPvDwxO4w9U/WhJUFgfC5xxn/gW6UHrM8Dmb5UvG/rLxaxLiMBCsgc1e8
         uVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMoItuxgDP7ogQHGcYXarl4I2+ROLy8sCFsG16Aywwg=;
        b=ZcNszS3qO71qurP+N838ChHbqmcNKIl9cHjXkVQamEwRD5xY1TJvZVIBBX5RdRYYSp
         LTWVNeBMcq8FWwMiDrKk0JEngKDd9cYNs9TpAOJbxpA2xuv4XQlcawgBhVxG53/kNhj5
         ICyayFwNqhj41yo8soWib1OMyti0kfg4k3mKdloUu7ZsDOzXVOjS0tiAzdMvyop86i83
         2GHPcupu21DRdg5wR8K+0KmbxcLe0QAlbVVgCBdLHHTNx5zlwaBJUOpMUNqykh00/KrO
         mZ8OrGnYM81n50lBviGQj9PWMF4G6r3U9oJYCrnzMYkNbOLXi4ORgn0OrGEVg6BoRfKS
         eFDw==
X-Gm-Message-State: AOAM530MZpIPQJKSWtIpJ2ss8UTVRUy9E9Vqr3r2J9Dh7tGMRVGAOwOv
        4OY7sQ/8Nm4xE9dLLIduv88ul/eoZ3RFLm0/
X-Google-Smtp-Source: ABdhPJxxfxoPWMWdyUpDsvOcaHaUFvY3HIue0Wl7PPH2WdJaCaoaw6b0nF5iFH992zGsvfRMtwCqXw==
X-Received: by 2002:adf:fc01:: with SMTP id i1mr4133125wrr.250.1606398223218;
        Thu, 26 Nov 2020 05:43:43 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:43:42 -0800 (PST)
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
Subject: [PATCH 40/40] drm/amd/display/dc/basics/vector: Make local function 'dal_vector_presized_costruct' static
Date:   Thu, 26 Nov 2020 13:42:40 +0000
Message-Id: <20201126134240.3214176-41-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/basics/vector.c:55:6: warning: no previous prototype for ‘dal_vector_presized_costruct’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/amd/display/dc/basics/vector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/vector.c b/drivers/gpu/drm/amd/display/dc/basics/vector.c
index 8f93d25f91ee2..706c803c4d3b0 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/vector.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/vector.c
@@ -52,7 +52,7 @@ bool dal_vector_construct(
 	return true;
 }
 
-bool dal_vector_presized_costruct(
+static bool dal_vector_presized_costruct(
 	struct vector *vector,
 	struct dc_context *ctx,
 	uint32_t count,
-- 
2.25.1

