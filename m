Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9872E2F45F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbhAMIKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbhAMIJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:58 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4751CC061382
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g10so714623wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=alsh2XeMyr5vVnQexuCbyQHtivN65vIRA5rbHXO573w=;
        b=bAWrASxCiSIxj1El5h8krkYAGtj0IJjK+lCYw0nH5o2RjfHSgk0ZHTDO0HIz8u/tqc
         Q/APpYWn63o0iJIf3VvsgVszi1UJDVp9kK+p4Bcn9IwiCgpyWVunbd6MWRzkutYwWb2j
         EcU241Y6oQ5yZNLZqU7V6b13PA4HA1e5MutVOp3LXmfPXW1aV4VrKR03ORye61hY7xcl
         usBFwyWj28mKQb8w1sENpWdtj3EFbWU0s2qEl5ny4VZ7Oihw5ARTXm048YH4vYG7NEm1
         DVN6XvyP3lPeEIuw5M2Kcb5OAc0MkJIgsW4iS9ejHvm79tCm9F/vYlBU4Qogue5t2gMB
         JSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alsh2XeMyr5vVnQexuCbyQHtivN65vIRA5rbHXO573w=;
        b=KcVGiSdH0xit4/EfgfTjjN+FayGASJuYTOTOgWC5qxC523nz+5ZkN0KZYN78ZIsa6O
         KK31Ryxv9+A/tM1laPHwIXLyqUpbFQw0RJzcY1Fvfqylco/OnAv9j8PoVQxKwtNOzvr5
         +QFhpsxaBJXgPOfuVfrBseMTUVuRLNFSZvjcWi+eJ/ulT7j8dPFf7YLM0SCXEYNDUDog
         Hwxt2dwMUwP77Q4idAJAwTBcyrIYO4a6jadmrVHbPB1+3SyvAb5tc4mhWokw44Xh8llQ
         36fJ21bo6p7jXmkS0en3aBwVu7DFSFDRDc8N6htRB9QTZAH7/ZPgmbI8400GSw3u7eVf
         onkQ==
X-Gm-Message-State: AOAM533SNRCtWAgriu3/hB9cXpY0msspVG0c9XTUjKUTy/93Gh5twemc
        410g/3BEuHKSxGlr7rEcjgLg8Q==
X-Google-Smtp-Source: ABdhPJxBE6EKX9KnLlKhnuQMKm0+HEyRjhrH/tr0CQY+8sLNaK/sTurIqZUswjLTUQD2N40vYWuxTA==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr941802wml.99.1610525302047;
        Wed, 13 Jan 2021 00:08:22 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:21 -0800 (PST)
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
Subject: [PATCH 21/30] drm/amd/display/dc/core/dc_resource: Demote some kernel-doc abuses
Date:   Wed, 13 Jan 2021 08:07:43 +0000
Message-Id: <20210113080752.1003793-22-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1710: warning: Function parameter or member 'old_stream' not described in 'dc_is_stream_unchanged'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1710: warning: Function parameter or member 'stream' not described in 'dc_is_stream_unchanged'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1726: warning: Function parameter or member 'old_stream' not described in 'dc_is_stream_scaling_unchanged'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1726: warning: Function parameter or member 'stream' not described in 'dc_is_stream_scaling_unchanged'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1843: warning: Function parameter or member 'dc' not described in 'dc_add_stream_to_ctx'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1843: warning: Function parameter or member 'new_ctx' not described in 'dc_add_stream_to_ctx'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1843: warning: Function parameter or member 'stream' not described in 'dc_add_stream_to_ctx'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1870: warning: Function parameter or member 'dc' not described in 'dc_remove_stream_from_ctx'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1870: warning: Function parameter or member 'new_ctx' not described in 'dc_remove_stream_from_ctx'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1870: warning: Function parameter or member 'stream' not described in 'dc_remove_stream_from_ctx'

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
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d423092c45dcd..185412d0c1429 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1697,7 +1697,7 @@ static bool are_stream_backends_same(
 	return true;
 }
 
-/**
+/*
  * dc_is_stream_unchanged() - Compare two stream states for equivalence.
  *
  * Checks if there a difference between the two states
@@ -1718,7 +1718,7 @@ bool dc_is_stream_unchanged(
 	return true;
 }
 
-/**
+/*
  * dc_is_stream_scaling_unchanged() - Compare scaling rectangles of two streams.
  */
 bool dc_is_stream_scaling_unchanged(
@@ -1833,7 +1833,7 @@ static struct audio *find_first_free_audio(
 	return 0;
 }
 
-/**
+/*
  * dc_add_stream_to_ctx() - Add a new dc_stream_state to a dc_state.
  */
 enum dc_status dc_add_stream_to_ctx(
@@ -1860,7 +1860,7 @@ enum dc_status dc_add_stream_to_ctx(
 	return res;
 }
 
-/**
+/*
  * dc_remove_stream_from_ctx() - Remove a stream from a dc_state.
  */
 enum dc_status dc_remove_stream_from_ctx(
-- 
2.25.1

